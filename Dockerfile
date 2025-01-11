# Étape 1 : Utiliser une image Flutter officielle pour la construction
FROM cirrusci/flutter:stable AS builder

WORKDIR /app

# Copier les fichiers source de l'application
COPY . ./app

# Télécharger les dépendances
RUN flutter pub get

# Construire l'application Flutter pour le web
RUN flutter build web

# Étape 2 : Utiliser un serveur web léger pour exécuter l'application
FROM nginx:stable

# Copier les fichiers générés dans le serveur NGINX
COPY --from=builder /app/build/web /usr/share/nginx/html

# Exposer le port 80 pour NGINX
EXPOSE 80

# Démarrer le serveur
CMD ["nginx", "-g", "daemon off;"]
