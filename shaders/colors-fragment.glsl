#version 410 core

#ifdef GL_ES
precision mediump float;
#endif

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 uv;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149, 0.141, 0.912);
vec3 colorB = vec3(1.0, 0.833, 0.224);
     
out vec4 Color;

vec3 firstExample() {
     return mix(colorA, colorB, abs(sin(u_time)));
}

float plot(vec2 st, float pct) {
     return smoothstep(pct - 0.01, pct, st.y) -
          smoothstep(pct, pct+0.01, st.y);
}

vec3 secondExample() {
     vec2 st = gl_FragCoord.xy/u_resolution.xy;
     vec3 color = vec3(0.0);
     // vec3 pct = vec3(st.x);
     vec3 pct = vec3(abs(sin(u_time * cos(st.x))), abs(sin(u_time * st.x)), abs(cos(st.x * u_time *  st.y)));
     color = mix(colorA, colorB, pct);
     color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
     color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
     color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));
     return color;
          
}
void main() {
     // vec3 rgb = firstExample();
     vec3 rgb = secondExample();
     Color = vec4(rgb, 1.0);
}
