module Customers
  module DistanceCalculator
    extend self
    
    
    # Mumbai office coordinates
    MUMBAI_LAT = 19.0590317
    MUMBAI_LON = 72.7553452
    EARTH_RADIUS_KM = 6371.0
    
    
    # Uses the spherical law of cosines formula:
    # d = R * arccos( sin φ1 sin φ2 + cos φ1 cos φ2 cos(Δλ) )
    # where φ = latitude in radians, λ = longitude in radians
    def distance_km(lat_deg, lon_deg)
        lat1 = deg_to_rad(MUMBAI_LAT)
        lon1 = deg_to_rad(MUMBAI_LON)
        lat2 = deg_to_rad(lat_deg)
        lon2 = deg_to_rad(lon_deg)
    
    
        delta_lon = lon2 - lon1
    
    
        cos_angle = Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(delta_lon)
        cos_angle = [[cos_angle, -1.0].max, 1.0].min
        central = Math.acos(cos_angle)
        EARTH_RADIUS_KM * central
    end
    
    
    def within_radius_km?(lat_deg, lon_deg, radius_km: 100)
        distance_km(lat_deg, lon_deg) <= radius_km
    end
    
    
    private
    
    
    def deg_to_rad(deg)
        deg * Math::PI / 180.0
    end
  end
end