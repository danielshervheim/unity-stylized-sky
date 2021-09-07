#ifndef DSS_SKY_COMMON_HLSL_
#define DSS_SKY_COMMON_HLSL_

// ---------- //
// PROPERTIES //
// ---------- //

half3 _SunDiscColor;
half _SunDiscExponent;
half _SunDiscMultiplier;

half3 _SunHaloColor;
half _SunHaloExponent;
half _SunHaloContribution;

half3 _HorizonLineColor;
half _HorizonLineExponent;
half _HorizonLineContribution;

half3 _SkyGradientTop;
half3 _SkyGradientBottom;
half _SkyGradientExponent;

uint _DebugMode;

// --------- //
// FUNCTIONS //
// --------- //

// @brief Computes the masks used to color different parts of the sky.
void ComputeSkyMasks(half3 view, half3 sun, out half sunDisc, out half sunHalo, out half horizon, out half gradient)
{
    // Initialize.
    sunDisc = 0;
    sunHalo = 0;
    horizon = 0;
    gradient = 0;

    // Compute dot product "base" masks.
    half dotViewUp = dot(view, half3(0,1,0));
    half dotViewSun = saturate(dot(view, sun));

    // Compute sun disc mask.
    sunDisc = pow(dotViewSun, _SunDiscExponent);
    sunDisc *= _SunDiscMultiplier;
    sunDisc = saturate(sunDisc);

    // Compute sun halo mask.
    float bellCurve = pow(saturate(dotViewSun), _SunHaloExponent * saturate(abs(dotViewUp)));
    float horizonSoften = 1 - pow(1 - saturate(dotViewUp), 50);
    sunHalo = saturate(bellCurve * horizonSoften);

    // Compute horizon mask.
    horizon = saturate(1.0 - abs(dotViewUp));
    horizon = pow(horizon, _HorizonLineExponent);
    horizon = saturate(horizon);

    // Compute gradient mask.
    gradient = 1.0 - saturate(dotViewUp);
    gradient = pow(gradient, _SkyGradientExponent);
    gradient = saturate(gradient);
}

// @brief Computes the sky color for the given view and sun direction.
half3 ComputeSkyColor(half3 viewDirWS, half3 sunDirWS)
{
    // Compute the masks.
    half maskSunDisc, maskSunHalo, maskHorizon, maskGradient;
    ComputeSkyMasks(viewDirWS, sunDirWS, maskSunDisc, maskSunHalo, maskHorizon, maskGradient);

    // Compute base sky color.
    half3 finalColor = lerp(_SkyGradientTop, _SkyGradientBottom, maskGradient);

    // Incorperate horizon line.
    finalColor = lerp(finalColor, _HorizonLineColor, _HorizonLineContribution * maskHorizon);

    // Incorperate sun halo.
    finalColor += _SunHaloColor * _SunHaloContribution * maskSunHalo;

    // Incorperate sun disc.
    finalColor = lerp(finalColor, _SunDiscColor, maskSunDisc);

    switch (_DebugMode)
    {
        case 1:
            return maskGradient;
        case 2:
            return maskHorizon;
        case 3:
            return maskSunHalo;
        case 4:
            return maskSunDisc;
        default:
            return finalColor;
    }
}

#endif  // DSS_SKY_COMMON_HLSL_