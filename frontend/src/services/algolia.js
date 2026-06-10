import algoliasearch from "algoliasearch/lite";
import { createInstantSearch } from "react-instantsearch";

export const searchClient = algoliasearch(
  import.meta.env.VITE_ALGOLIA_APP_ID,
  import.meta.env.VITE_ALGOLIA_SEARCH_KEY
);

export const INDEX_NAME = "media_items";
