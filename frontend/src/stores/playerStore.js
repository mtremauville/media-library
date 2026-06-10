// frontend/src/stores/playerStore.js
import { create } from "zustand";

export const usePlayerStore = create((set, get) => ({
  currentItem:   null,
  currentTrack:  null,
  isPlaying:     false,
  volume:        0.8,
  progress:      0,
  queue:         [],

  play:  (item, track = null) => set({ currentItem: item, currentTrack: track, isPlaying: true }),
  pause: ()                   => set({ isPlaying: false }),
  resume:()                   => set({ isPlaying: true }),
  stop:  ()                   => set({ currentItem: null, isPlaying: false }),
  setVolume:   (v)            => set({ volume: v }),
  setProgress: (p)            => set({ progress: p }),

  next: () => {
    const { queue, currentTrack } = get();
    const idx = queue.findIndex(t => t.id === currentTrack?.id);
    if (idx < queue.length - 1) set({ currentTrack: queue[idx + 1] });
  },

  previous: () => {
    const { queue, currentTrack } = get();
    const idx = queue.findIndex(t => t.id === currentTrack?.id);
    if (idx > 0) set({ currentTrack: queue[idx - 1] });
  },

  setQueue: (items) => set({ queue: items })
}));
