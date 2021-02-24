#pragma once
#include "pch.h"
#include "GUIDs.h"
#include "Anime4KUpscaleDenoiseConvReduceTransform.h"
#include "Anime4KUpscaleCombineTransform.h"
#include "SimpleDrawTransform.h"
#include "EffectBase.h"

// Anime4K-Denoise，放大图像的同时去噪，经测试效果良好
// 移植自 https://github.com/bloc97/Anime4K/blob/master/glsl/Upscale%2BDenoise/Anime4K_Upscale_CNN_M_x2_Denoise.glsl
class Anime4KUpscaleDenoiseEffect : public EffectBase {
public:
    IFACEMETHODIMP Initialize(
        _In_ ID2D1EffectContext* pEffectContext,
        _In_ ID2D1TransformGraph* pTransformGraph
    ) {
        //
        // +--+   +-+   +-+   +-+   +-+   +-+   +-+
        // |in+--->0+--->1+--->2+--->3+--->4+--->5|
        // +-++   +-+   +++   +++   +++   +++   +++
        //   |           |     |     |     |     |
        //   |           v-----v-----v---+-v-----v
        //   |                           |
        //   |                       +---v--+
        //   +--------------->+<-----+reduce|
        //                    |      +------+
        //                +---v---+
        //                |combine|
        //                +---+---+
        //                    |
        //                  +-v-+
        //                  |out|
        //                  +---+
        //
        HRESULT hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x1Transform,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x1_SHADER,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x1_SHADER);
        if (FAILED(hr)) {
            return hr;
        }
        hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x8Transform1,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER1,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER_1);
        if (FAILED(hr)) {
            return hr;
        }
        hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x8Transform2,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER2,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER_2
        );
        if (FAILED(hr)) {
            return hr;
        }
        hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x8Transform3,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER3,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER_3
        );
        if (FAILED(hr)) {
            return hr;
        }
        hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x8Transform4,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER4,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER_4
        );
        if (FAILED(hr)) {
            return hr;
        }
        hr = SimpleDrawTransform::Create(
            pEffectContext,
            &_conv4x3x3x8Transform5,
            MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER5,
            GUID_MAGPIE_ANIME4K_UPSCALE_DENOISE_CONV_4x3x3x8_SHADER_5
        );
        if (FAILED(hr)) {
            return hr;
        }
        hr = Anime4KUpscaleDenoiseConvReduceTransform::Create(pEffectContext, &_convReduceTransform);
        if (FAILED(hr)) {
            return hr;
        }
        hr = Anime4KUpscaleCombineTransform::Create(pEffectContext, &_combineTransform);
        if (FAILED(hr)) {
            return hr;
        }

        hr = pTransformGraph->AddNode(_conv4x3x3x1Transform.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_conv4x3x3x8Transform1.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_conv4x3x3x8Transform2.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_conv4x3x3x8Transform3.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_conv4x3x3x8Transform4.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_conv4x3x3x8Transform5.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_convReduceTransform.Get());
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->AddNode(_combineTransform.Get());
        if (FAILED(hr)) {
            return hr;
        }

        hr = pTransformGraph->ConnectToEffectInput(0, _conv4x3x3x1Transform.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x1Transform.Get(), _conv4x3x3x8Transform1.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform1.Get(), _conv4x3x3x8Transform2.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform2.Get(), _conv4x3x3x8Transform3.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform3.Get(), _conv4x3x3x8Transform4.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform4.Get(), _conv4x3x3x8Transform5.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }

        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform1.Get(), _convReduceTransform.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform2.Get(), _convReduceTransform.Get(), 1);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform3.Get(), _convReduceTransform.Get(), 2);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform4.Get(), _convReduceTransform.Get(), 3);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_conv4x3x3x8Transform5.Get(), _convReduceTransform.Get(), 4);
        if (FAILED(hr)) {
            return hr;
        }

        hr = pTransformGraph->ConnectToEffectInput(0, _combineTransform.Get(), 0);
        if (FAILED(hr)) {
            return hr;
        }
        hr = pTransformGraph->ConnectNode(_convReduceTransform.Get(), _combineTransform.Get(), 1);
        if (FAILED(hr)) {
            return hr;
        }

        hr = pTransformGraph->SetOutputNode(_combineTransform.Get());
        if (FAILED(hr)) {
            return hr;
        }


        return S_OK;
    }

    static HRESULT Register(_In_ ID2D1Factory1* pFactory) {
        HRESULT hr = pFactory->RegisterEffectFromString(CLSID_MAGIPE_ANIME4K_UPSCALE_DENOISE_EFFECT, XML(
            <?xml version='1.0'?>
            <Effect>
                <!--System Properties-->
                <Property name='DisplayName' type='string' value='Ripple' />
                <Property name='Author' type='string' value='Microsoft Corporation' />
                <Property name='Category' type='string' value='Stylize' />
                <Property name='Description' type='string' value='Adds a ripple effect that can be animated' />
                <Inputs>
                    <Input name='Source' />
                </Inputs>
            </Effect>
        ), nullptr, 0, CreateEffect);

        return hr;
    }

    static HRESULT CALLBACK CreateEffect(_Outptr_ IUnknown** ppEffectImpl) {
        // This code assumes that the effect class initializes its reference count to 1.
        *ppEffectImpl = static_cast<ID2D1EffectImpl*>(new Anime4KUpscaleDenoiseEffect());

        if (*ppEffectImpl == nullptr) {
            return E_OUTOFMEMORY;
        }

        return S_OK;
    }

private:
    // Constructor should be private since it should never be called externally.
    Anime4KUpscaleDenoiseEffect() {}

    ComPtr<SimpleDrawTransform> _conv4x3x3x1Transform = nullptr;
    ComPtr<SimpleDrawTransform> _conv4x3x3x8Transform1 = nullptr;
    ComPtr<SimpleDrawTransform> _conv4x3x3x8Transform2 = nullptr;
    ComPtr<SimpleDrawTransform> _conv4x3x3x8Transform3 = nullptr;
    ComPtr<SimpleDrawTransform> _conv4x3x3x8Transform4 = nullptr;
    ComPtr<SimpleDrawTransform> _conv4x3x3x8Transform5 = nullptr;
    ComPtr<Anime4KUpscaleDenoiseConvReduceTransform> _convReduceTransform = nullptr;
    ComPtr<Anime4KUpscaleCombineTransform> _combineTransform = nullptr;
};
