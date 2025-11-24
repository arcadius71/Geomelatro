#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 bioluminescent;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

vec4 effect(vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords) * (image_details)) - texture_details.xy * texture_details.ba) / texture_details.ba;
    vec2 adjusted_uv = uv - vec2(0.5, 0.5);
    adjusted_uv.x = adjusted_uv.x * texture_details.b / texture_details.a;
    
    vec2 mouse_offset = (screen_coords - mouse_screen_pos) * screen_scale / 300.0;
    float mouse_influence = exp(-length(mouse_offset) * 0.8) * hovering;
    
    float anim_time = bioluminescent.y;
    float pulse = sin(anim_time * 0.4) * 0.5 + 0.5;
    float slowPulse = sin(anim_time * 0.15) * 0.5 + 0.5;
    
    float dist = length(adjusted_uv);
    
    float centerGlow = exp(-dist * 1.8) * (0.8 + 0.2 * pulse);
    float edgeGlow = (1.0 - exp(-dist * 1.8)) * (0.3 + 0.15 * pulse);
    
    float mouseWave = sin((uv.x + uv.y) * 6.0 + mouse_offset.x * 2.0 + mouse_offset.y * 2.0 + anim_time * 2.0);
    
    vec3 deepBlue = vec3(0.2, 0.5, 0.85);
    vec3 royalBlue = vec3(0.15, 0.25, 0.95);
    
    vec3 centerColor = deepBlue * (0.7 + 0.3 * pulse + 0.3 * mouse_influence);
    vec3 edgeColor = royalBlue * (0.4 + 0.2 * pulse + 0.2 * mouse_influence);
    
    float shimmer = sin(mouse_offset.x * 8.0 + mouse_offset.y * 8.0 + anim_time * 3.0) * 0.5 + 0.5;
    centerColor += deepBlue * shimmer * mouse_influence * 0.4;
    edgeColor += royalBlue * shimmer * mouse_influence * 0.3;
    
    vec3 finalGlow = centerColor * centerGlow + edgeColor * edgeGlow;
    
    if (tex.a > 0.01 && !shadow) {
        tex.rgb = tex.rgb + finalGlow * 0.8;
        tex.rgb = clamp(tex.rgb, 0.0, 1.0);
    }
    
    return dissolve_mask(tex * colour, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.0) : tex.xyz, shadow ? tex.a * 0.3 : tex.a);
    }

    float adjusted_dissolve = (dissolve * dissolve * (3.0 - 2.0 * dissolve)) * 1.02 - 0.01;
    float t = time * 10.0 + 2003.0;
    vec2 uv_scaled_centered = (uv - 0.5) * 2.3;
    
    vec2 field_part1 = uv_scaled_centered + 50.0 * vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.0 * vec2(cos(t / 53.1532), cos(t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.0 * vec2(sin(-t / 87.53218), sin(-t / 49.0000));
    
    float field = (1.0 + (
        cos(length(field_part1) / 19.483) + 
        sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) + 
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92)
    )) / 2.0;
    
    vec2 borders = vec2(0.2, 0.8);
    float res = (0.5 + 0.5 * cos((adjusted_dissolve) / 82.612 + (field - 0.5) * 3.14159))
        - (uv.x > borders.y ? (uv.x - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (uv.y > borders.y ? (uv.y - borders.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (uv.x < borders.x ? (borders.x - uv.x) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve
        - (uv.y < borders.x ? (borders.x - uv.y) * (5.0 + 5.0 * dissolve) : 0.0) * dissolve;
    
    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8 * (0.5 - abs(adjusted_dissolve - 0.5)) && res > adjusted_dissolve) {
        if (res < adjusted_dissolve + 0.5 * (0.5 - abs(adjusted_dissolve - 0.5))) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }
    
    return vec4(shadow ? vec3(0.0) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a * 0.3 : tex.a) : 0.0);
}

#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    if (hovering <= 0.0) {
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5 * love_ScreenSize.xy) / length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy) / screen_scale;
    float scale = 0.2 * (-0.03 - 0.3 * max(0.0, 0.3 - mid_dist)) * hovering * (length(mouse_offset) * length(mouse_offset)) / (2.0 - mid_dist);
    return transform_projection * vertex_position + vec4(0.0, 0.0, 0.0, scale);
}
#endif