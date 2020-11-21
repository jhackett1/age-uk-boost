module ApplicationHelper

    def svg(path)
        File.open("app/assets/images/#{path}", "rb") do |file|
            raw file.read
        end
    end

    def rough_distance(distance)
        if distance < 1
          "Less than a mile away"
        elsif (1 < distance) && (distance < 2)
          "1 mile away"
        else
          "#{distance.round} miles away"
        end
      end

end
