﻿Shader "cube map for cubes" 
{
	Properties
	{
		_Cube("cube map", Cube) = "" {}
	}
	SubShader
	{
	Tags { "Queue" = "Transparent" }
		Pass
		{
			Cull Front
			Blend One One
			CGPROGRAM
			
			
#pragma vertex vert  
#pragma fragment frag
			
			uniform samplerCUBE _Cube;

			struct vertexInput 
			{
				float4 vertex : POSITION;
			};
			struct vertexOutput 
			{
				float4 pos : SV_POSITION;
				float3 texDir : TEXCOORD0;
			};

			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;

				output.texDir = input.vertex;
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				return output;
			}

			float4 frag(vertexOutput input) : COLOR
			{
				return texCUBE(_Cube, input.texDir);
			}

			ENDCG
		}
	}
}