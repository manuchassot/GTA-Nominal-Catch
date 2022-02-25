
print("Initializing connection to the Global Tuna Atlas...")

# con_GTA = dbConnect(drv = PostgreSQL(),
#                dbname   = "tunaatlas", 
#                user     = "tunaatlas_inv",
#                password = "fle087",
#                host     = "db-tunaatlas.d4science.org")

con_GTA = DBI::dbConnect(
  drv = RPostgreSQL::PostgreSQL(),
  host = "35.242.196.99",
  user = "tunaatlasdb",
  password = "!tunaatlasdb!",
  port = "5432",
  dbname = "tunaatlas"
)

print("GTA connection initialized!")