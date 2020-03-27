Shader "Yord/GradientShader"
{
    Properties
    {
        _Color1 ("First Color", Color) = (1,1,1,1)
        _Color2 ("Second Color", Color) = (1,1,1,1)
        _ScaleFirst("Scale First", Float) = 1
        _Rotation("Rotation", Float) = 1
    }
    SubShader
    {
        Tags {
            "IgnoreProjector" = "True"
        }
        LOD 100
        
        ZWrite Off

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 _Color1;
            fixed4 _Color2;
            float _Rotation;
            float _ScaleFirst;

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
            };

            v2f vert (appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float2 origin = float2(0.5, 0.5);
				v.texcoord.xy -= origin;
				float sinX = sin(_Rotation);
				float cosX = cos(_Rotation);
				float sinY = sin(_Rotation);
				float2x2 rotationMatrix = float2x2(cosX, -sinX, sinY, cosX);
				v.texcoord.xy = mul(v.texcoord.xy, rotationMatrix);
				o.color = lerp(_Color1, _Color2, v.texcoord.x * _ScaleFirst);



				
				return o;
			}
			

			fixed4 frag (v2f IN) : SV_Target
			{
				
				float4 color;
			    color.rgb = IN.color.rgb;
                color.a = IN.color.a;
			    return color;
			}
            ENDCG
        }
        
    }
    FallBack "Diffuse"
}
