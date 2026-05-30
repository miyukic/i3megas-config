# klipper-megas

Klipper configuration for Anycubic i3 Mega S (miyukic's machine).

## Machine

- **Printer**: Anycubic i3 Mega S
- **Board**: Trigorilla 14 (ATmega2560)
- **Host**: Orange Pi Zero3 1.5GB (Armbian 25.5.1 Bookworm, kernel 6.12.23)
- **Host IP**: 192.168.1.3 (DHCP reserved, MAC: 0c:50:84:5b:5f:9e)
- **Fluidd**: http://192.168.1.3
- **SSH**: orangepi@192.168.1.3

## Key config values

| Item | Value | Source |
|------|-------|--------|
| Z endstop (right) | PD3 | stepper_z |
| Z endstop (left) | PL6 | stepper_z1 |
| BLTouch control | PB5 | Marlin SERVO0_PIN |
| BLTouch sensor | PE4 | Marlin Z_MIN_PROBE_PIN |
| BLTouch x_offset | -1 | measured |
| BLTouch y_offset | -23 | measured |
| BLTouch z_offset | 1.802 | PROBE_CALIBRATE 2026-05-30 |
| Filament sensor | PD2 | Marlin FIL_RUNOUT_PIN=19 |
| Extruder steps | 384 steps/mm → rotation_distance 8.333 | upgraded extruder |

## Architecture

- Z homing: dual mechanical endstops (PD3/PL6), Marlin-style hybrid
- BLTouch: bed mesh leveling only (not used for Z homing)
- Dual Z independent endstops: gantry self-levels on every G28

## PID values (calibrated 2026-05-30, PLA)

- Extruder: Kp=21.630 Ki=0.994 Kd=117.612
- Bed: Kp=73.183 Ki=1.474 Kd=908.388

## Cura start Gcode changes from Marlin

- `G29` → works (G29 macro added = BED_MESH_CALIBRATE)
- `M420 S1` / `M420 Z2.0` → remove (not Klipper commands)
- `M900 K0` → remove or `SET_PRESSURE_ADVANCE ADVANCE=0`
- `M300` → remove (no beeper configured)

## Notes

- SAVE_CONFIG block must be at END of printer.cfg. Never append config after it.
- WiFi power saving disabled: /etc/NetworkManager/conf.d/wifi-powersave-off.conf
- Filament sensor was disabled in Marlin (malfunctioning). Replaced and re-enabled in Klipper.
- iPad access to Fluidd fails (port 7125 unreachable from iPadOS). Use Mobileraker app instead.
