import { useState } from "react";
import MediaCard from "./MediaCard";
import CoverFlow from "../coverflow/CoverFlow";
import SearchBar from "../search/SearchBar";
import MediaPlayer from "./MediaPlayer";
import { useQuery } from "@tanstack/react-query";
import { mediaApi } from "../../services/api";

export default function MediaGrid() {
  const [filter, setFilter] = useState("all");
  const [selectedItem, setSelectedItem] = useState(null);

  const { data, isLoading } = useQuery({
    queryKey: ["mediaItems", filter],
    queryFn: () => mediaApi.getAll(filter === "all" ? null : filter)
  });

  const items = data?.data || [];

  const filters = [
    { key: "all",    label: "Tout",    emoji: "🎬" },
    { key: "movie",  label: "Films",   emoji: "🎥" },
    { key: "series", label: "Séries",  emoji: "📺" },
    { key: "album",  label: "Musique", emoji: "🎵" }
  ];

  return (
    <div className="media-library">
      {/* Header filtres */}
      <div className="filter-bar">
        {filters.map(f => (
          <button
            key={f.key}
            className={`filter-btn ${filter === f.key ? "active" : ""}`}
            onClick={() => setFilter(f.key)}
          >
            {f.emoji} {f.label}
          </button>
        ))}
      </div>

      {/* Grille */}
      {isLoading ? (
        <div className="loading-grid">
          {Array.from({ length: 12 }).map((_, i) => (
            <div key={i} className="skeleton-card" />
          ))}
        </div>
      ) : (
        <div className="media-grid">
          {items.map(item => (
            <MediaCard
              key={item.id}
              item={item}
              onSelect={setSelectedItem}
            />
          ))}
        </div>
      )}

      {/* CoverFlow */}
      {items.length > 0 && (
        <CoverFlow items={items} onSelect={setSelectedItem} />
      )}

      {/* Barre de recherche */}
      <SearchBar />

      {/* Player */}
      {selectedItem && (
        <MediaPlayer item={selectedItem} onClose={() => setSelectedItem(null)} />
      )}
    </div>
  );
}
