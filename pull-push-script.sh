#!/bin/bash

# This script pulls Docker images from a public repository and pushes them to a private Artifact Registry.
# In order to make the script executable you have to run: chmod +x pull-push-script.sh
# Afterwards you can execute the script with: ./pull-push-script.sh

# TODO Set the target private repository
target_repository="europe-west1-docker.pkg.dev/cw-academy-sandbox-alex/test-repo"

# Function to pull and push Docker images
pull_and_push_image() {
    source_image=$1
    target_image="$target_repository/$source_image"

    docker pull $source_image

    docker tag $source_image $target_image

    docker push $target_image

    docker rmi $source_image
    docker rmi $target_image
}

# List of public image repositories to target image names
images=(
    # TODO Add more images in the format "public/image:tag target-image:tag"
    "bitnami/cert-manager:latest"
    "nginx:latest"
    "chainguard/external-secrets:latest"
)

# Loop through each image pair and pull and push the images
for image_pair in "${images[@]}"
do
    image_pair_array=($image_pair)
    pull_and_push_image ${image_pair_array[0]} ${image_pair_array[1]}
done