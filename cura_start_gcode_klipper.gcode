;Profil Homepage: https://github.com/NilsRo/Cura_Anycubic_MegaS_Profile
; Klipper版: NilsRoプロファイルをベースにKlipper向けに調整
; 変更点: M420/M900をコメントアウト、G29をBED_MESH_CALIBRATEマクロとして追加

;Slicer Information - (Support for OctoPrint Slicer Estimator)
;Slicer info:material_guid;{material_guid}
;Slicer info:material_id;{material_id}
;Slicer info:material_brand;{material_brand}
;Slicer info:material_name;{material_name}
;Slicer info:filament_cost;{filament_cost}
;Slicer info:material_bed_temperature;{material_bed_temperature}
;Slicer info:material_bed_temperature_layer_0;{material_bed_temperature_layer_0}
;Slicer info:material_print_temperature;{material_print_temperature}
;Slicer info:material_print_temperature_layer_0;{material_print_temperature_layer_0}
;Slicer info:material_flow;{material_flow}
;Slicer info:layer_height;{layer_height}
;Slicer info:machine_nozzle_size;{machine_nozzle_size}
;Slicer info:wall_thickness;{wall_thickness}
;Slicer info:speed_print;{speed_print}
;Slicer info:speed_topbottom;{speed_topbottom}
;Slicer info:travel_speed;{travel_speed}
;Slicer info:support;{support}
;Slicer info:retraction_speed;{retraction_speed}
;Slicer info:retraction_amount;{retraction_amount}
;Slicer info:layer_height;{layer_height}
;Slicer info:infill_pattern;{infill_pattern}
;Slicer info:infill_sparse_density;{infill_sparse_density}
;Slicer info:cool_fan_enabled;{cool_fan_enabled}
;Slicer info:cool_fan_speed;{cool_fan_speed}
;Slicer info:sliced_at;{day} {date} {time}
G21                                        ; metric values
G90                                        ; absolute positioning
M82                                        ; set extruder to absolute mode
;M900 K0                                    ; disable lin. adv. (Klipper不要)
M107                                       ; start with the fan off
M140 S{material_bed_temperature_layer_0}   ; Start heating the bed
G4 S60                                     ; wait 1 minute
M104 S{material_print_temperature_layer_0} ; start heating the hot end
M190 S{material_bed_temperature_layer_0}   ; wait for bed
M109 S{material_print_temperature_layer_0} ; wait for hotend
;M300 S1000 P500                            ; BEEP heating done
G28 X0 Y10 Z0                              ; move X/Y to min endstops
G29                                        ; Auto Bed Leveling (= BED_MESH_CALIBRATE)
;M420 S1                                    ; Enable leveling (Klipper不要)
;M420 Z2.0                                  ; Set leveling fading height (Klipper不要)
G0 Z0.15                                   ; lift nozzle a bit
G92 E0                                     ; zero the extruded length
G1 Y3 F5000
G1 X50 E20 F500                            ; Extrude 20mm of filament in a 5cm line.
G92 E0                                     ; zero the extruded length again
G1 E-2 F500                                ; Retract a little
G1 X50 F500                                ; wipe away from the filament line
G1 X100 F9000                              ; Quickly wipe away from the filament line
