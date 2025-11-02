# Exercise 12 – FIR Low-Pass Filter Using MATLAB

## Objective
The goal of this exercise is to design and analyze the **impulse response** and **frequency response** of a low-pass FIR filter using the direct sinc-based formula. The effect of different filter orders (**M = 20** and **M = 64**) is compared to observe how the frequency response sharpness changes.

---

## Implementation Summary
The FIR Low-Pass Filter was implemented using:

\[
h_{LP}(n) = \frac{\sin(w_c (n - M/2))}{\pi (n - M/2)}, \quad h_{LP}(M/2) = \frac{w_c}{\pi}
\]

- Cutoff frequency: **wc = 1 rad/s**
- Orders tested: **M = 20** and **M = 64**
- Frequency response computed using **FFT (1024 points)**
- Figures automatically saved to the `figures/` folder

---

## Observations
- Increasing the filter order **M** increases the number of coefficients in the impulse response, making it **longer and more symmetric**.  
- The **transition band becomes narrower** with higher M, meaning the filter better separates passband and stopband frequencies.  
- The **ripple** in both passband and stopband decreases as M increases, leading to a **smoother and sharper** frequency response.  
- Higher order filters give **better frequency selectivity** but require more computation.

---

## Results (Saved Figures)
- `hLP_M20.png` – Impulse Response (M = 20)  
- `HLP_M20.png` – Frequency Response (M = 20)  
- `hLP_M64.png` – Impulse Response (M = 64)  
- `HLP_M64.png` – Frequency Response (M = 64)  
- `HLP_compare.png` – Comparison of both frequency responses
