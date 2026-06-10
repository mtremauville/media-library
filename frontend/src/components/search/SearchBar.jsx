import { InstantSearch, SearchBox, Hits, Configure } from "react-instantsearch";
import { searchClient, INDEX_NAME } from "../../services/algolia";

function HitCard({ hit }) {
  return (
    <div className="hit-card">
      <img src={hit.poster_url} alt={hit.title} />
      <div>
        <p className="hit-title">{hit.title}</p>
        <span className={`badge badge-${hit.media_type}`}>{hit.media_type}</span>
      </div>
    </div>
  );
}

export default function SearchBar() {
  return (
    <div className="search-wrapper">
      <InstantSearch searchClient={searchClient} indexName={INDEX_NAME}>
        <Configure hitsPerPage={8} />
        <SearchBox
          placeholder="🔍  Rechercher un film, série, album..."
          classNames={{
            root:   "search-root",
            form:   "search-form",
            input:  "search-input",
            submit: "search-submit",
            reset:  "search-reset"
          }}
        />
        <Hits hitComponent={HitCard} className="hits-list" />
      </InstantSearch>
    </div>
  );
}
