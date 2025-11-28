function [GHI, I_bn, I_dh] = ashrae2001_clear_sky(doy, zenith_deg)
    % ASHRAE 2001 Clear-Sky model
    A_vals = [1202,1187,1164,1130,1106,1092,1093,1107,1136,1166,1190,1204];
    B_vals = [0.141,0.142,0.149,0.164,0.177,0.185,0.186,0.182,0.165,0.152,0.144,0.141];
    C_vals = [0.103,0.104,0.109,0.120,0.130,0.137,0.138,0.134,0.121,0.111,0.106,0.103];
    month = month_from_doy(doy);
    A = A_vals(month); B = B_vals(month); C = C_vals(month);
    cosZ = cosd(zenith_deg);
    if cosZ <= 0
        GHI = 0; I_bn = 0; I_dh = 0; return;
    end
    Io = 1367 * (1 + 0.033*cosd(360*(doy-3)/365));
    I_bn = A * exp(-B / cosZ);
    I_bh = I_bn * cosZ;
    I_dh = C * I_bn * cosZ;
    GHI = I_bh + I_dh;
end

function [GHI, I_bn, I_dh] = hottel_clear_sky(doy, zenith_deg)
    % Hottel 1976 Clear-Sky model
    site_alt = 0.455;  % km
    a0s = 0.4237 - 0.00821*(6 - site_alt)^2;
    a1s = 0.5055 + 0.00595*(6.5 - site_alt)^2;
    ks  = 0.2711 + 0.01858*(2.5 - site_alt)^2;
    if ismember(month_from_doy(doy), [12,1,2])
        r0=1.03; r1=1.01; rk=1.00;  % midlatitude winter
    else
        r0=0.97; r1=0.99; rk=1.02;  % midlatitude summer
    end
    a0 = a0s*r0; a1 = a1s*r1; k = ks*rk;
    cosZ = cosd(zenith_deg);
    if cosZ <= 0
        GHI=0; I_bn=0; I_dh=0; return;
    end
    Io = 1367 * (1 + 0.033*cosd(360*(doy-3)/365));
    tau_b = a0 + a1 * exp(-k / cosZ);
    I_bn = Io * tau_b;
    I_bh = I_bn * cosZ;
    I_dh = (0.271 - 0.294*tau_b) * Io * cosZ;
    GHI = I_bh + I_dh;
end

function [GHI, I_bn, I_dh] = ashrae2009_clear_sky(doy, zenith_deg)
    % ASHRAE 2009 Clear-Sky Tau model
    cosZ = cosd(zenith_deg);
    if cosZ <= 0
        GHI=0; I_bn=0; I_dh=0; return;
    end
    Io = 1367 * (1 + 0.033*cosd(360*(doy-3)/365));
    % (Assume fixed tau for simplicity; ideally use monthly values)
    if ismember(month_from_doy(doy), [12,1,2])
        tau_b=0.20; tau_d=0.50;
    else
        tau_b=0.14; tau_d=0.45;
    end
    a_b = 1.219 - 0.043*tau_b - 0.151*tau_d - 0.204*tau_b*tau_d;
    a_d = 0.202 + 0.852*tau_b - 0.007*tau_d - 0.357*tau_b*tau_d;
    I_bn = Io * exp(-tau_b * (1/cosZ)^a_b);
    I_bh = I_bn * cosZ;
    I_dh = Io * exp(-tau_d * (1/cosZ)^a_d);
    GHI = I_bh + I_dh;
end

% NASA POWER data fetch (using webread for example)
function data = fetch_nasa_power_data(lat, lon, start_date, end_date)
    baseURL = "https://power.larc.nasa.gov/api/temporal/hourly/point";
    params = "&parameters=DNI,DHI,ALLSKY_SFC_SW_DWN&community=SB&format=CSV";
    url = sprintf("%s?latitude=%.4f&longitude=%.4f&start=%s&end=%s%s", ...
                   baseURL, lat, lon, start_date, end_date, params);
    dataText = webread(url);
    data = parse_power_csv(dataText);  % parse CSV text to MATLAB arrays (user-defined)
end
