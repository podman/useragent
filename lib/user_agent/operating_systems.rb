class UserAgent
  module OperatingSystems
    Windows = {
      "Windows NT 6.2"  => "Windows 8",
      "Windows NT 6.1"  => "Windows 7",
      "Windows NT 6.0"  => "Windows Vista",
      "Windows NT 5.2"  => "Windows XP x64 Edition",
      "Windows NT 5.1"  => "Windows XP",
      "Windows NT 5.01" => "Windows 2000, Service Pack 1 (SP1)",
      "Windows NT 5.0"  => "Windows 2000",
      "Windows NT 4.0"  => "Windows NT 4.0",
      "Windows 98"      => "Windows 98",
      "Windows 95"      => "Windows 95",
      "Windows CE"      => "Windows CE"
    }.freeze

    def self.normalize_os(os)
      Windows[os] || detect_ios(os) || normalize_mac_os_x(os) ||os
    end

    private
      def self.detect_ios(os)
         /CPU (?:iPhone |iPod )?OS ([\d_.]+)/.match(os) do |m|
          return 'iOS %s' % m[1].gsub('_','.')
        end

        if os =~ /like Mac OS X/
          return 'iOS 3.0'
        end

        nil
      end
      
      def self.normalize_mac_os_x(os)
        if os =~ /(?:Intel|PPC) Mac OS X\s*([0-9_\.]+)?/
          if $1.nil?
            "OS X"
          else
            version = $1.gsub('_', '.')
            "OS X #{version}"
          end
        end
      end
  end
end
