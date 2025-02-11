print("Initializing connection to the Global Tuna Atlas...")

# con_GTA = dbConnect(drv = PostgreSQL(),
#                dbname   = "tunaatlas", 
#                user     = "tunaatlas_inv",
#                password = "fle087",
#                host     = "db-tunaatlas.d4science.org")

# DB_DRV=PostgreSQL
# DB_PORT=5432
# DB_HOST=db-tunaatlas.d4science.org
# DB_NAME=tunaatlas
# DB_USER_READONLY=tunaatlas_u
# DB_USER=tunaatlas_u
# DB_PASSWORD=21c0551e7ed2911

con_GTA = DBI::dbConnect(
  drv = RPostgreSQL::PostgreSQL(),
  host = "db-tunaatlas.d4science.org",
  user = "tunaatlas_u",
  password = "21c0551e7ed2911",
  port = "5432",
  dbname = "tunaatlas_sandbox"
)

# con_GTA = DBI::dbConnect(
#   drv = RPostgreSQL::PostgreSQL(),
#   host = "35.242.196.99",
#   user = "tunaatlasdb",
#   password = "!tunaatlasdb!",
#   port = "5432",
#   dbname = "tunaatlas"
# )


print("GTA connection initialized!")