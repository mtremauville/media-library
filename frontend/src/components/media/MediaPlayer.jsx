import ReactPlayer from "react-player";
import { usePlayerStore } from "../../stores/playerStore";

export default function MediaPlayer({ item, onClose }) {
  const { isPlaying, volume, progress, play, pause, setVolume, setProgress,
          next, previous, currentTrack, queue } = usePlayerStore();

  const getSource = () => {
    if (item.media_type === "album" && currentTrack) {
      // MusicBrainz ne stream pas directement — placeholder ou lien
      return null;
    }
    return item.metadata?.trailer || item.metadata?.stream_url;
  };

  return (
    <div className="player-overlay">
      <div className="player-modal">
        <button className="close-btn" onClick={onClose}>✕</button>

        <div className="player-header">
          <img src={item.poster_url} alt={item.title} className="player-poster" />
          <div className="player-info">
            <h2>{item.title}</h2>
            {currentTrack && <p className="track-name">🎵 {currentTrack.title}</p>}
          </div>
        </div>

        {getSource() && (
          <ReactPlayer
            url={getSource()}
            playing={isPlaying}
            volume={volume}
            onProgress={({ played }) => setProgress(played)}
            width="100%"
            height="360px"
            controls
          />
        )}

        <div className="player-controls">
          <button onClick={previous}>⏮</button>
          <button onClick={isPlaying ? pause : () => play(item)}>
            {isPlaying ? "⏸" : "▶"}
          </button>
          <button onClick={next}>⏭</button>
          <input
            type="range" min={0} max={1} step={0.05}
            value={volume}
            onChange={e => setVolume(parseFloat(e.target.value))}
            className="volume-slider"
          />
        </div>

        {/* Tracklist pour albums */}
        {item.media_type === "album" && item.tracks && (
          <div className="tracklist">
            {item.tracks.map((track, i) => (
              <div
                key={i}
                className={`track-item ${currentTrack?.id === track.id ? "active" : ""}`}
                onClick={() => play(item, track)}
              >
                <span className="track-num">{track.track_number}</span>
                <span className="track-title">{track.title}</span>
                <span className="track-duration">
                  {track.duration ? `${Math.floor(track.duration/60000)}:${String(Math.floor((track.duration%60000)/1000)).padStart(2,'0')}` : "--"}
                </span>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
