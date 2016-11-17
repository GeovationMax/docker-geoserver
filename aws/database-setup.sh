touch app-schema.properties

echo "geoserver.database.host = $RDS_HOSTNAME" >> app-schema.properties
echo "geoserver.database.port = $RDS_PORT" >> app-schema.properties
echo "geoserver.database.name = $RDS_DB_NAME" >> app-schema.properties
echo "geoserver.database.username = $RDS_USERNAME" >> app-schema.properties
echo "geoserver.database.password = $RDS_PASSWORD" >> app-schema.properties

sudo cp app-schema.properties /mnt/geoserver/data
