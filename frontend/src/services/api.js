import axios from "axios";

const api = axios.create({
  baseURL: "/api/v1",
  headers: {
    "Content-Type": "application/json",
    "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content
  }
});

api.interceptors.response.use(
  res => res.data,
  err => {
    if (err.response?.status === 401) window.location.href = "/users/sign_in";
    return Promise.reject(err);
  }
);

export const mediaApi = {
  getAll:    (type)     => api.get("/media_items", { params: { type } }),
  getOne:    (id)       => api.get(`/media_items/${id}`),
  create:    (data)     => api.post("/media_items", { media_item: data }),
  destroy:   (id)       => api.delete(`/media_items/${id}`),
  getMovie:  (id)       => api.get(`/movies/${id}`),
  getSeries: (id)       => api.get(`/series/${id}`),
  getAlbum:  (id)       => api.get(`/albums/${id}`),
  search:    (q, type)  => api.get("/search", { params: { q, type } })
};
