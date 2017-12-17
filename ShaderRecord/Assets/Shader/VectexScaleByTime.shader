Shader "Sikapaper/VectexScaleByTime"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// Step 1
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			// Step 3
			struct v2f
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;

			// Step 2
			v2f vert (appdata v)
			{
				v2f OUT;

				// ------> sin : 1 ~ -1
				float fValue = sin(_Time.y);
				if(fValue < 0)
					fValue = 0;

				v.vertex.xyz *= fValue;

				OUT.position = UnityObjectToClipPos(v.vertex);
				OUT.uv = v.uv;

				return OUT;
			}

			// Step 4
			fixed4 frag (v2f i) : SV_Target
			{
				// Step 5
				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
}
