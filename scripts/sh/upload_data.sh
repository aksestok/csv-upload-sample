#!/usr/bin/env bash

set -euf

# Make sure we are in the correct directory (root of the project)
SCRIPTPATH="$(dirname "$0")"
cd $SCRIPTPATH/../..

# Set variables from environment file
source ./.env

# Upload entities
python -m exabel_data_sdk.scripts.load_entities_from_csv  \
    --api-key="$EXABEL_API_KEY" --namespace="$EXABEL_NAMESPACE" \
    --filename="./resources/data/entities/brands.csv" --sep=";" \
    --name_column="brand" --description_column="description"

# Upload relationships
python -m exabel_data_sdk.scripts.load_relationships_from_csv  \
    --api-key="$EXABEL_API_KEY" --namespace="$EXABEL_NAMESPACE" \
    --filename="./resources/data/relationships/HAS_BRAND.csv" --sep=";" \
    --entity_from_column="factset_identifier" --entity_to_column="brand" \
    --relationship_type="HAS_BRAND" --description_column="description"

# Upload time series
python -m exabel_data_sdk.scripts.load_time_series_from_csv  \
    --api-key="$EXABEL_API_KEY" --namespace="$EXABEL_NAMESPACE" \
    --filename="./resources/data/time_series/brand_time_series.csv" --sep=";" \
    --create_missing_signals