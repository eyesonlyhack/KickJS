#ifdef GL_ES
precision highp float;
#endif
varying vec2 vUv;
varying vec3 vNormal;

uniform vec3 mainColor;
uniform float specularExponent;
uniform vec3 specularColor;
uniform sampler2D mainTexture;

#pragma include "light.glsl"
#pragma include "shadowmap.glsl"

void main(void)
{
    vec3 diffuse;
    float specular;
    getDirectionalLight(vNormal, _dLight, specularExponent, diffuse, specular);
    float visibility = computeLightVisibility();
    vec3 color = max(diffuse*visibility,_ambient.xyz)*mainColor;

    gl_FragColor = texture2D(mainTexture,vUv)*vec4(color, 1.0)+vec4(specular*specularColor,0.0);
}
 