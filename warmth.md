# Clothing Warmth

## Current Settings

Clothing warmth is enabled while `Config.TempFeature` is `true`. The HUD checks whether each supported clothing category is equipped once per second and adds the configured value to the world temperature.

| Clothing category | Component hash | Current warmth |
| --- | --- | ---: |
| Hat | `0x9925C067` | 0 |
| Shirt | `0x2026C46D` | 0 |
| Pants | `0x1D4C528A` | 0 |
| Boots | `0x777EC6EF` | 0 |
| Coat | `0xE06D30CE` | 15 |
| Open coat | `0x0662AC34` | 15 |
| Gloves | `0xEABE0032` | 0 |
| Vest | `0x485EE834` | 0 |
| Poncho | `0xAF14310B` | 0 |
| Skirt | `0xA0E3AB7F` | 0 |
| Chaps | `0x3107499B` | 0 |

Only coats and open coats currently provide warmth. The existing system assigns warmth by clothing category, so every item within a category receives the same benefit. Equipped category values are added together.

## Current Temperature Rules

- Temperature format: Fahrenheit
- Minimum safe temperature: `30`
- Maximum safe temperature: `104`
- Below `Config.MinTemp`: the HUD ring is blue and cold damage can apply.
- Above `Config.MaxTemp`: the HUD ring is red and heat damage can apply.
- Between both limits: the HUD ring is white.
- Clothing warmth is added directly to the displayed temperature and the temperature used for damage checks.
- Job types `leo` and `medic` currently have all clothing warmth removed when `Config.EnableNoWarmthJobs` is enabled.

The warmth number is currently added without conversion. A value of `15` therefore means `+15°F` in Fahrenheit mode or `+15°C` in Celsius mode.

## Planned Per-Item Warmth Flow

`rsg-clothingstore` will determine warmth from the specific clothing items currently equipped. This lets different items in the same category provide different benefits.

1. `rsg-clothingstore` loops through the player's equipped clothing and totals the configured per-item warmth.
2. The calculation runs after clothing changes, including changes made by another resource such as `rsg-wardrobe`.
3. `rsg-clothingstore` calls a client export in `rsg-hud` and sends the completed warmth total.
4. `rsg-hud` stores that total and uses it when calculating the player's effective temperature.
5. `rsg-hud` does not repeatedly request clothing data from `rsg-clothingstore`.

The export should receive one numeric total, not the complete clothing list. Per-item warmth configuration and clothing lookup remain owned by `rsg-clothingstore`; temperature display, limits, and damage remain owned by `rsg-hud`.

The existing category-based warmth calculation should be removed or bypassed when the injected total is active so warmth is not counted twice.
