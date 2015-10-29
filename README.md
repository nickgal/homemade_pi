# HomemadePi

A simple Phoenix and Ionic app to control [Etekcity 433Mhz RF Outlets](http://www.amazon.com/Etekcity-Programmable-Electrical-Household-Appliances/dp/B00DQELHBS)

## The Setup
- Phoneix 1.0
  - Combo of json api and channels
  - Serving an [Ionic + Angular](http://ionicframework.com/) frontend
  - Ecto via SQLite
- Raspberry Pi
  - Raspbian Jesse
  - Erlang 18.1
  - Elixir 1.1.1
  - [433Mhz RF Transmitter and Receiver](http://www.dxsoul.com/product/433mhz-rf-transmitter-module-receiver-module-link-kit-for-arduino-arm-mcu-wl-green-901220194)
  - [433Utils](https://github.com/nickgal/433Utils)
    - `RFSniffer` for find outlet codes
    - `codesend` for sending over gpio
- iOS
  - [POC RubyMotion app](https://github.com/nickgal/motion_phoenix_poc)

## License
[MIT](LICENSE.md)
