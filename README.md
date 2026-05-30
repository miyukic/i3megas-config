# klipper-megas

Anycubic i3 Mega S の Klipper 設定ファイル置き場。

Marlin 時代の Cura Gcode もリファレンスとして保管してある。

---

## 機体構成

| 項目 | 内容 |
|------|------|
| プリンター | Anycubic i3 Mega S |
| メインボード | Trigorilla 14（ATmega2560互換） |
| ホスト | Orange Pi Zero3 1.5GB（192.168.1.3） |
| OS | Armbian 25.5.1 Bookworm（kernel 6.12.23） |
| UI | Fluidd（http://192.168.1.3） |
| SSH | orangepi@192.168.1.3 |

---

## 主要ピン（Trigorilla 14）

| 用途 | ピン | 備考 |
|------|------|------|
| Z エンドストップ（右） | PD3 | stepper_z |
| Z エンドストップ（左） | PL6 | stepper_z1 |
| BLTouch control | PB5 | Marlin SERVO0_PIN (Arduino D11) |
| BLTouch sensor | PE4 | Marlin Z_MIN_PROBE_PIN (Arduino D2) |
| フィラメントセンサー | PD2 | Marlin FIL_RUNOUT_PIN=19 |

---

## BLTouch オフセット値

```
x_offset: -1
y_offset: -23
z_offset: 1.802  （PROBE_CALIBRATE で実測、2026-05-30）
```

**x/y オフセットはカスタムマウントの実測値。マウントの形状によって全員異なる。**

---

## キャリブレーション済み PID 値（PLA、2026-05-30）

| ヒーター | Kp | Ki | Kd |
|---------|----|----|-----|
| ホットエンド（200°C） | 21.630 | 0.994 | 117.612 |
| ベッド（60°C） | 73.183 | 1.474 | 908.388 |

---

## 設計方針

- **Z ホーム**: デュアルメカエンドストップ（Marlin と同じハイブリッド方式）
- **BLTouch**: ベッドメッシュレベリング専用（Z ホームには使わない）
- 毎回 `BED_MESH_CALIBRATE`（G29）を実行することでエンドストップの誤差も吸収される

---

## ファイル一覧

| ファイル | 内容 |
|---------|------|
| `printer.cfg` | Klipper 設定（SAVE_CONFIG 込み） |
| `cura_start_gcode_marlin.gcode` | Marlin 時代の Cura スタートGcode（リファレンス） |
| `cura_end_gcode_marlin.gcode` | Marlin 時代の Cura エンドGcode（リファレンス） |

Marlin 時代のスタートGcodeは [NilsRo/Cura_Anycubic_MegaS_Profile](https://github.com/NilsRo/Cura_Anycubic_MegaS_Profile) をベースに一部カスタムしたもの。

---

## 注意事項

- `printer.cfg` の SAVE_CONFIG ブロック以降に設定を追記しない（Klipper がエラーになる）
- WiFi 省電力は `/etc/NetworkManager/conf.d/wifi-powersave-off.conf` で無効化済み
- 印刷中に WiFi が切れても印刷は継続する（Klipper はローカル動作）

---

## 関連記事

- [Anycubic i3 Mega S を Klipper に移行した話（Zenn）](https://zenn.dev/yumeno/articles/klipper-anycubic-i3-megas)
