// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Stencil Mask" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse (RGB) Spec(A)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
	        Tags { "RenderType"="Transparent" "Queue"="Geometry"}
	        Blend SrcAlpha OneMinusSrcAlpha
	        Pass {
	            Stencil {
	                Ref 2
	                Comp always
	                Pass keep 
	                Fail decrWrap 
	                ZFail keep
	            }

	        CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			//#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				//UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				//o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				//UNITY_TRANSFER_FOG(o,o.vertex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
				// apply fog
				//UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
	        }
	        Pass {
	            Stencil {
	                Ref 2
	                Comp equal
	            }

	            CGPROGRAM
	            #pragma vertex vert
	            #pragma fragment frag
	            struct appdata {
	                float4 vertex : POSITION;
	            };
	            struct v2f {
	                float4 pos : SV_POSITION;
	            };
	            v2f vert(appdata v) {
	                v2f o;
	                o.pos = UnityObjectToClipPos(v.vertex);
	                return o;
	            }
	            half4 frag(v2f i) : SV_Target {
	                return half4(1,0,1,1);
	            }
	            ENDCG
	        }

	    } 

	FallBack "Diffuse"
}
