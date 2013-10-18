This is a small Ruby/Sinatra app that displays the train status & track assignment for NJ Transit trains leaving New York. It's meant for mobile devices and is probably not useful to a lot of people.

The app scrapes the NJ Transit "DepartureVision" page for New York Penn Station, looking for a train with the given number. If it finds it, the train's status ("On Time", "Boarding", etc.) and track assignment (if available) are displayed.
