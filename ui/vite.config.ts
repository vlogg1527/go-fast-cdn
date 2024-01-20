import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      "@": "/src",
    },
  },
  server: {
    proxy: {
      "/api/": {
        target: "http://localhost:8080/",
      },
    },
  },
  plugins: [react()],
  build: {
    outDir: "build",
  },
});
