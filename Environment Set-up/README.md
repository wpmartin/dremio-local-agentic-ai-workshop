# Setting up your environment

For this tutorial, we will be creating a data lakehouse on your laptop. We will be spinning up Minio as a local data lake, using Nessie as our data catalog, and connecting these as data sources to Dremio. This may sound complicated but is easily achieved using Docker. 

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
