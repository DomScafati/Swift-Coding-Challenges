import UIKit

/* given a date, convert it to mm/dd/yyyy with the hour and minute displayed */
var dateFormatter = DateFormatter()

dateFormatter.dateFormat = "EE, yy-MM-dd 'at' hh:mm"
dateFormatter.timeZone = TimeZone(abbreviation: "EST")

print(dateFormatter.string(from: Date()))

