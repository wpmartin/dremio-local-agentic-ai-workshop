# dremio-local-agentic-ai-workshop

## Useful links
- [Dremio docs](https://docs.dremio.com)
- [Dremio MCP server repo](https://github.com/dremio/dremio-mcp)
- [A blog post tutorial for using the Dremio MCP Server with any LLM Model](https://www.dremio.com/blog/using-the-dremio-mcp-server-with-any-llm-model/)

This repository is to accompany Dremio's In-Person Agentic AI Workshops. The intent is to refine sample Dremio datasets to create a basic, three-layer medallion-style data pipeline, which will then be interrogated using an Agentic AI. The Agent will be connected to Dremio using the Dremio MCP server, and will use Claude Desktop as the frontend.

- You will deploy and run Dremio locally on your laptop, via Docker.
- You will then be creating virtual datasets (Views) in the Dremio UI and saving them in the Iceberg format in a data catalog.
- This directory contains the following files:
    - `docker-compose.yml` - will create containers to run Dremio, object storage, and a data catalog.
    - `create_all_views.sql` - will create and save all views in the medallion folder structure needed for the workshop.
    - `get_pat.py` - will access your Dremio instance and generate a Personal Access Token (PAT) via REST API for use with the MCP Server.

- There is also a `Semantic Layer` directory containing .txt and .md files to use as Dremio wiki entries for the generated views.
    - `wiki_trips.txt` - plain text documentation to be used as the Dremio Wiki for the silver-level dataset `trips`.
    - `wiki_weather.txt` - plain text documentation to be used as the Dremio Wiki for the silver-level dataset `nyc_weather`.
    - `wiki_trips_enriched.md` - markdown documentation to be used as the Dremio Wiki for the gold-level dataset `trips_enriched`.

# Setting up your environment

For this tutorial, we will be creating a data lakehouse on your laptop. We will be spinning up MinIO as a local data lake, using Nessie as our data catalog, and connecting these as data sources to Dremio. This may sound complicated but is easily achieved using Docker. 

As such, make sure you have Docker installed, and if using Docker Desktop you may have to make sure you have at least 6GB of memory allocated to Docker. 

## Setting up a Minio Data Lake and Nessie Catalog

First, let's spin up our services using the provided `docker-compose.yml` and with the command:

```
docker compose up
```
After a minute or two, Dremio should be up and running and we can visit it in the browser at `localhost:9047` where we will have to create our initial user account. You will need to provide:
  - First Name
  - Last Name
  - Username
  - Email
  - Password

<p align="center">
  <img src=./images/image-0.1.webp>
</p>

Your Username and Password will be used later to connect Dremio to dbt, so please remember them.

## Connecting Our Data Sources to Dremio
Once you are inside Dremio, we can begin adding our data sources by clicking the "Add Source" button in the bottom left corner.

### Add Our Data Catalog Source
  - Select Nessie from "Add Source"
  - On the General Tab
    - name: `catalog`
    - URL: `http://nessie:19120/api/v2`
    - Nessie authentication type: `None`
  - On the Storage tab:
    - root path: `warehouse`
    - access key: `admin`
    - secret key: `password`
    - connection properties:
      - `fs.s3a.path.style.access` : `true`
      - `fs.s3a.endpoint` : `minio:9000`
      - `dremio.s3.compat` : `true`
    - Encrypt Connection: `false`

    <img src=./images/image-0.2.webp>
    <img src=./images/image-0.3.webp>

## Add Sample Data
To run this project you will be using sample datasets that are provided as part of Dremio. To use these you will first have to add this sample data as a source to your deployment.

Click on the "Add Source" button to bring up the "Add Data Source" pop-up window. In this list, under "Object Storage" select the option "Sample Source" which has Gnarly, the Dremio mascot, as its icon.

<p align="left">
  <img src=./images/image-1.1.webp width="250">
</p>

- Click through to `Samples."samples.dremio.com"` and click on the file `NYC-taxi-trips.csv` to [format the data to a table](https://docs.dremio.com/current/sonar/data-sources/entity-promotion/).

<p align="left">
  <img src=./images/image-1.2.webp width="250">
</p>

- In the Table Settings window that pops up, tick the box to `Extract Column Names` and click Save.

<p align="center">
  <img src=./images/image-1.3.webp>
</p>

- Back in the sample data list, the icon for this file will now have changed from a grey file to a purple table.

<p align="left">
  <img src=./images/image-1.4.webp width="250">
</p>

Now repeat this same process for two more datasets, `NYC-weather.csv` and `SF weather 2018-2019.csv`.

## Creating the data pipeline

With all the datasets formated as tables you can now generate Iceberg views in the data catalog. Go to the SQL editor and run the SQL code found in the file `create_all_views.sql`. This will establish a medallion style data structure within your data catalog, saving the outputs as views:
- **bronze**: raw, 1-to-1 views of the Sample tables
- **silver**: cleaned and formatted views of the two NYC datasets.
- **gold**: an enriched view of the NYC taxi trips dataset created by joining the NYC weather dataset.

# Installing the Dremio MCP Server
To grant our Agentic AI access to Dremio we will be using the offical Dremio Model Context Protocol (MCP) server. The MCP server will run locally on your machine that also runs the LLM frontend. For this workshop you will be using Claude Desktop as the LLM frontend and LLM model.

Please refer to the [installation instructions](https://github.com/dremio/dremio-mcp?tab=readme-ov-file#installation) on the Dremio MCP Server repo to install and configure the MCP server. The steps you will be doing are:
1) Clone or download the dremio-mcp repo.
2) Install the `uv` package manager.
3) Install the `dremio-simple-query` library and run the script `get_pat.py` to generate your PAT token.
4) Generate your Dremio config file, using this PAT token and the uri `http://localhost:9047`.
5) Download and install Claude Desktop.
6) Generate your Claude config file.
7) Launch Claude Desktop.