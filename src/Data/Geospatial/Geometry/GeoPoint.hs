{-# LANGUAGE TemplateHaskell #-}
-------------------------------------------------------------------
-- |
-- Module       : Data.Geospatial.Geometry.GeoPoint
-- Copyright    : (C) 2014 Dom De Re
-- License      : BSD-style (see the file etc/LICENSE.md)
-- Maintainer   : Dom De Re
--
-------------------------------------------------------------------
module Data.Geospatial.Geometry.GeoPoint (
    -- * Type
        GeoPoint(..)
    -- * Lenses
    ,   unGeoPoint
    ) where

import Data.Geospatial.BasicTypes
import Data.Geospatial.Geometry.Aeson
import Data.Geospatial.Geometry.JSON

import Control.Lens ( makeLenses )
import Control.Monad ( mzero )
import Data.Aeson ( FromJSON(..), ToJSON(..), Value(..), Object )
import Text.JSON ( JSON(..) )

newtype GeoPoint = GeoPoint { _unGeoPoint :: GeoPositionWithoutCRS } deriving (Show, Eq)

makeLenses ''GeoPoint

-- instances

instance JSON GeoPoint where
    readJSON = readGeometryGeoJSON "Point" GeoPoint

    showJSON (GeoPoint point) = makeGeometryGeoJSON "Point" point

instance ToJSON GeoPoint where
--  toJSON :: a -> Value
    toJSON = makeGeometryGeoAeson "Point" . _unGeoPoint

instance FromJSON GeoPoint where
--  parseJSON :: Value -> Parser a
    parseJSON (Object o)    = readGeometryGeoAeson "Point" GeoPoint o
    parseJSON _             = mzero
