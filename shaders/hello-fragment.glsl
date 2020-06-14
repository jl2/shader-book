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

vec4 green() {
     return vec4(0.0, 1.0, 0.0, 1.0);
}

vec4 magenta() {
     return vec4(1.0, 0.0, 1.0, 1.0);
}

void main() {
     Color = vec4(0.0, abs(sin(u_time)), 0.0, 1.0);
}

