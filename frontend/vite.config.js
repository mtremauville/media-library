import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  build: {
    outDir:    "../app/assets/builds",
    emptyOutDir: true,
    manifest:  true,
    rollupOptions: {
      input: "src/main.jsx"
    }
  },
  server: {
    proxy: {
      "/api": "http://localhost:3000",
      "/users": "http://localhost:3000"
    }
  }
});
