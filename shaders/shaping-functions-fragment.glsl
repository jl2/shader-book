#version 410 core

#ifdef GL_ES
precision mediump float;
#endif

layout(location = 0) in vec3 position;
layout(location = 1) in vec2 uv;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

out vec4 Color;

float plot(vec2 st, float pct) {
     return smoothstep(pct - 0.02, pct, st.y) -
          smoothstep(pct, pct+0.02, st.y);
}

void main() {
     vec2 st = gl_FragCoord.xy / u_resolution;
     float y = st.x;
     vec3 color = vec3(y);

     // Plot a line
     float pct = plot(st, y);
     Color = vec4((1.0-pct) * color + pct*vec3(0.0, 1.0, 0.0), 1.0);
}
