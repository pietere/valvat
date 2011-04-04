class Valvat
  module Utils
    
    EU_COUNTRIES = %w(AT BE BG CY CZ DE DK EE ES FI FR GB GR HU IE IT LT LU LV MT NL PL PT RO SE SI SK)
    COUNTRY_PATTERN = /\A([A-Z]{2})(.+)\Z/
    NORMALIZE_PATTERN = /[-\.:_\s,;]+/
    
    def self.split(vat)
      COUNTRY_PATTERN =~ vat 
      result = [$1, $2]
      iso_country = vat_country_to_iso_country(result[0])
      EU_COUNTRIES.include?(iso_country) ? result : [nil, nil]
    end
    
    def self.normalize(vat)
      vat.upcase.gsub(NORMALIZE_PATTERN, "")
    end
    
    def self.vat_country_to_iso_country(vat_country)
      vat_country == "EL" ? "GR" : vat_country
    end
    
    def self.should_pay_vat(vat1,vat2)
      self.split(vat1)[0] == self.split(vat2)[0]
    end    
  end
end