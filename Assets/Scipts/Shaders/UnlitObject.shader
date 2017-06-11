// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/UnlitObject"
{
	Properties
	{
		_MainTex ("Diffuse (RGB) Spec(A)", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue" = "Transparent" } 
		LOD 100
		Cull off

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

    CGPROGRAM
    #pragma surface surf Lambert
 
    fixed4 _Color;
 
    // Note: pointless texture coordinate. I couldn't get Unity (or Cg)
    //       to accept an empty Input structure or omit the inputs.
    struct Input {
      float2 uv_MainTex;
    };
 
    void surf (Input IN, inout SurfaceOutput o) {
      o.Albedo = _Color.rgb;
      o.Emission = _Color.rgb; // * _Color.a;
      o.Alpha = _Color.a;
    }
    ENDCG
		}


		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

			Stencil {
                Ref 2
                Comp always
                Pass replace
                ZFail replace
            }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma surface surf Labmert
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
	}
}
