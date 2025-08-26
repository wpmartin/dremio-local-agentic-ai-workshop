# dremio-local-agentic-ai-workshop

- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP server repository](https://github.com/dremio/dremio-mcp)
- [Claude and Dremio: a Dremio University tutorial](https://university.dremio.com/course/dremio-docker-mcp-server)
- [Using the Dremio MCP Server with any LLM Model](https://www.dremio.com/blog/using-the-dremio-mcp-server-with-any-llm-model/)

This repository is to accompany Dremio's Agentic AI Workshops. It contains SQL scripts that refine sample Dremio datasets to create a basic, three-layer medallion-style data pipeline. 

- You will deploy and run Dremio locally on your laptop, via Docker, using the contents of the `Environment Set-up` directory.
- You will then be creating and saving virtual datasets (Views) in Dremio.
- You will create a Data Catalog called `catalog` and add a folder called `bronze` into which a view will be manually created.
- Then you will use the contents of the `SQL Code` directory to create the rest of our data pipeline in Dremio and add a semantic layer. This directory contains the following scripts:
    - `trips.sql` - will create a `silver` folder in our project structure and a formatted version of the nyc_trips sample dataset, called `trips`.
    - `complete_project.sql` - will create and save the rest of the views and medallion folder structure needed for the workshop.
    - `wiki_trips.txt` - plain text documentation to be used as the Dremio Wiki for the silver-level dataset `trips`.
    - `wiki_weather.txt` - plain text documentation to be used as the Dremio Wiki for the silver-level dataset `nyc_weather`.
    - `wiki_trips_enriched.md` - markdown documentation to be used as the Dremio Wiki for the gold-level dataset `trips_enriched`.
