STORE_PATH=""
STORE_NAME=""
DOMAIN_NAMES=""

while true; do
    read -p "Your Store folder name (i.e.: mystore) :" STORE_NAME
        break;
done

while true; do
     read -p "The path to your store (i.e.: /var/www/) :" STORE_PATH
          break;
done

while true; do
    read -p "Domain names you want this store to respond to:" DOMAIN_NAMES
        break;
done
echo "************************************"
echo " This script now creates your       "
echo " your binstub files as well         "
echo "************************************"
echo ""
echo ""
echo "Updating config files"
NEW_PATH="$(echo "$STORE_PATH$STORE_NAME" | sed -e 's/[/&]/\\&/g')"
find . -name "nginx.conf" -exec sed -i '' "s/\[storepath\]/$NEW_PATH/g" '{}' \;
