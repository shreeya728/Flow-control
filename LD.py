
#D = 0.012  # Diameter of the cylinder in meters (12 mm)
#L = 0.1  # Length of the cylinder in meters (100 mm)
D = 0.04
L = 0.4
V = 10  # Freestream velocity in m/s
rho = 1.184  # Air density in kg/m^3
mu = 0.0000186  # Dynamic viscosity in kg/(m·s)

# Calculating Reynolds number
Re = (rho * V * D) / mu

# Drag coefficient for a smooth cylinder at subcritical Reynolds number
CD = 1.2  # Assuming subcritical regime

# Frontal area of the cylinder
A = D * L

# Drag force 
FD = 0.5 * rho * V**2 * A * CD

load = FD/9.81  # in kg

print(Re)
print(FD)   # in N
print(load*1000)  # in grams

# approx 75 g - due to drag force
# can my load cell measure this?


# Constants
load_cell_capacity = 10  # in kg
sensitivity = 2  # in mV/V
excitation_voltage = 10  # in V (typical excitation voltage)
ADC_resolution_bits = 16  # bits of ADC resolution (e.g., 16-bit)
ADC_voltage_range = excitation_voltage  # ADC measures up to the excitation voltage

def calculate_min_load():
    # Step 1: Calculate the full-scale output of the load cell
    full_scale_output = (sensitivity * excitation_voltage) / 1000  # in V (convert mV to V)

    # Step 2: Calculate the resolution of the ADC
    adc_resolution = ADC_voltage_range / (2 ** ADC_resolution_bits)  # in V per bit

    # Step 3: Minimum detectable signal by the ADC (corresponding to one bit)
    min_detectable_signal = adc_resolution  # in V

    # Step 4: Calculate the minimum measurable load
    min_measurable_load = (min_detectable_signal / full_scale_output) * load_cell_capacity   # in kg

    return min_measurable_load

# minimum measurable load
min_load = calculate_min_load()
min_load = min_load*1000
print(f"The minimum load the load cell can measure accurately is approximately {min_load:.6f} g.")
