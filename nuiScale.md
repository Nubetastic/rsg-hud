# NUI Auto-Scaling Guide

Use this guide to implement resolution-independent scaling for RedM/FiveM NUI resources.

## 1. CSS Implementation

Add a scaling variable and set the root font size based on viewport height (`vh`). This ensures the UI maintains its relative size regardless of the player's resolution.

```css
:root {
  /* Central variable to adjust overall scale */
  --nui-scale: 1.0; 
}

html {
  /* 1vh is 1% of the screen height. Multiplying by the scale allows easy adjustment. */
  font-size: calc(1vh * var(--nui-scale));
}
```

## 2. Converting Units

Instead of using fixed units like `px` or `pt`, use `rem`.
- **1rem** will be equal to the font-size of the `html` element (which we set to `1vh`).
- Calculation formula: `desired_size_in_pixels / (reference_height / 100)`
- *Tip: For a standard 1080p reference, 10.8px = 1rem.*

### Example Conversion:
| Unit | Original (Fixed) | Responsive (rem) |
| :--- | :--- | :--- |
| Width | `36px` | `3.33rem` |
| Font Size | `11pt` (approx 14.6px) | `1.36rem` |
| Margin | `4px` | `0.37rem` |

## 3. Centering Logic

Always use relative positioning combined with `transform` to ensure elements stay centered during scaling.

```css
.centered-element {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}
```

## 4. Why this works
By basing everything on `vh` and `rem`, if a player switches from 1080p to 4K, the `1vh` value effectively quadruples in pixel count, but the UI remains the same physical size relative to the screen. The `--nui-scale` variable then allows the user to make the UI larger or smaller globally without editing every single element.
