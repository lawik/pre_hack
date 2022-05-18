# Configuration for the sweet OLED bonnet

```elixir
@gpio_config [
    # Joystick press
    %{
      pin: 4,
      pull_mode: :pullup,
      low: {:key, {" ", :press, 0}},
      high: {:key, {" ", :release, 0}}
    },
    # Joystick up
    %{
      pin: 17,
      pull_mode: :pullup,
      low: {:key, {"up", :press, 0}},
      high: {:key, {"up", :release, 0}}
    },
    # Joystick right
    %{
      pin: 23,
      pull_mode: :pullup,
      low: {:key, {"right", :press, 0}},
      high: {:key, {"right", :release, 0}}
    },
    # Joystick down
    %{
      pin: 22,
      pull_mode: :pullup,
      low: {:key, {"down", :press, 0}},
      high: {:key, {"down", :release, 0}}
    },
    # Joystick left
    %{
      pin: 27,
      pull_mode: :pullup,
      low: {:key, {"left", :press, 0}},
      high: {:key, {"left", :release, 0}}
    },
    # #5
    %{
      pin: 5,
      pull_mode: :pullup,
      low: {:key, {"A", :press, 0}},
      high: {:key, {"A", :release, 0}}
    },
    # #6
    %{
      pin: 6,
      pull_mode: :pullup,
      low: {:key, {"S", :press, 0}},
      high: {:key, {"S", :release, 0}}
    }
```
