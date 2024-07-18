# Import the GTK3 module
require 'gtk3'

# Define the CalculatorApp class
class CalculatorApp < Gtk::Application
  # Initialize method
  def initialize
    super('org.gtk.calculator', :flags_none)

    # Connect the activate signal to the window show method
    signal_connect(:activate) { show_window }
  end

  # Method to show the window
  def show_window
    # Create a new window
    window = Gtk::ApplicationWindow.new(self)
    window.set_title('Simple Calculator')
    window.set_default_size(300, 400)

    # Vertical box to hold components
    box = Gtk::Box.new(:vertical, 5)
    window.add(box)

    # Entry field for display
    entry = Gtk::Entry.new
    entry.set_alignment(1.0)
    entry.set_editable(false)
    box.pack_start(entry, expand: false, fill: true, padding: 5)

    # Grid for buttons layout
    grid = Gtk::Grid.new
    box.pack_start(grid, expand: true, fill: true, padding: 5)

    # Calculator buttons
    buttons = [
      '7', '8', '9', '/',
      '4', '5', '6', '*',
      '1', '2', '3', '-',
      '0', '.', '=', '+'
    ]

    row, col = 0, 0

    buttons.each do |label|
      button = Gtk::Button.new(label: label)
      button.signal_connect('clicked') do
        case label
        when '='
          entry.text = eval(entry.text).to_s
        when 'C'
          entry.text = ''
        else
          entry.text += label
        end
      end

      grid.attach(button, col, row, 1, 1)
      col += 1
      if col > 3
        col = 0
        row += 1
      end
    end

    # Show all components of the window
    window.show_all
  end
end

# Create an instance of CalculatorApp and run it
app = CalculatorApp.new
app.run
