Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D462639D0E
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Nov 2022 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiK0U61 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Nov 2022 15:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiK0U61 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Nov 2022 15:58:27 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592972AFE
        for <linux-acpi@vger.kernel.org>; Sun, 27 Nov 2022 12:58:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e15so3282236ljl.7
        for <linux-acpi@vger.kernel.org>; Sun, 27 Nov 2022 12:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0DuQsNLT0RY6V02XnWfmVJTL0d/Zc+EKxzoplKAPRg=;
        b=cWTmZztQXVYg/pGFJwKQrIUs9ASsk1f86dyJ6BV6j9A9XNSYJkoTUJihtLQAxxRPh4
         S0GnfVSi8NkiSNJKZoFWgLu0ALu2gO7K4dd0I6ouEmc14PPrJdewmFvK7qfJHsUHM3MF
         bmtvIW0ZPTKrmhMsdlxxteltgm/s3KXePOhwpBwELndHDOSCpcW14A3rCj/VZB5/X8xP
         ogJHRszafv+YN0tpqehqE+NiIUkLCTgys8RE0HG+7o/4RHg6ekANvcjPzCvVFZktrRFX
         ZQGZ3hOShGb/LGWR6YZ5jhU76nSjWic8CmyK3rBtUU1sFJwS6rScaTVhJScrI1pfY6xx
         98ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0DuQsNLT0RY6V02XnWfmVJTL0d/Zc+EKxzoplKAPRg=;
        b=oUlTCxw2gTjSBKWznIYbiBu/rgg3wFvzx7JLVIb6fb33W2B/xo9waML07uLNN2aPAC
         qTVvuqSkkEzSksQpoqbpy/u/Hglp2NKSdLf7mSOvzSbmxYrFZoJFQYI7VLMHzNI6YIWT
         AkpD8LWMbS5uLSgLMY6/pqSJhSuEECfdMJWBf4S6HRfoyeePx5lT5SPKSDTuDHcQj9wE
         nokw6c7v53FHO/WMzWX2IpgRk1FFg36/l+m+OgQs92HzPICGLvbKiAtV+07Q0K4fFhWw
         GcJdSmQU38sks2eINLZQe4YnairwVw6Rx97SkvN5/Zu4/NjWw8uf5QugyCts/FOqcpgF
         VB3A==
X-Gm-Message-State: ANoB5pkQd+JMJNZ1Ns7H7HzqPc9w+pvbYoW/zdUHsygKCN03ompsurZW
        bTr+5A833fKMfBtQyCEI46o9QQ==
X-Google-Smtp-Source: AA0mqf7DSbp7zd1DjzQpiy8x4qXr0QOwLtJh8XqXRY3opc8q48qUhIu5CXz2s3UXoaXUh3DG0POO9Q==
X-Received: by 2002:a2e:bcc5:0:b0:279:3851:1420 with SMTP id z5-20020a2ebcc5000000b0027938511420mr12784992ljp.265.1669582703489;
        Sun, 27 Nov 2022 12:58:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020ac25d4a000000b004a8f824466bsm1410359lfd.188.2022.11.27.12.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:58:23 -0800 (PST)
Message-ID: <00cc31a2-39b1-9bb3-5b79-3c6d51cd5d51@linaro.org>
Date:   Sun, 27 Nov 2022 21:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 3/7] dt-bindings: drm/bridge: anx7625: Add mode-switch
 support
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-acpi@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-4-treapking@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124102056.393220-4-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24/11/2022 11:20, Pin-yen Lin wrote:
> Analogix 7625 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
> 
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
> 
> Also include the link to the product brief in the bindings.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> ---
> 
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.

Except missing testing few things...

> 
>  .../display/bridge/analogix,anx7625.yaml      | 73 ++++++++++++++++++-
>  1 file changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 4590186c4a0b..5fdbf1f3bab8 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -12,7 +12,8 @@ maintainers:
>  
>  description: |
>    The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> -  designed for portable devices.
> +  designed for portable devices. Product brief is available at
> +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
>  
>  properties:
>    compatible:
> @@ -112,10 +113,36 @@ properties:
>                data-lanes: true
>  
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/properties/port-base

I don't understand why you are changing this line.

>          description:
>            Video port for panel or connector.
>  
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            type: object
> +            unevaluatedProperties: false
> +
> +            properties:
> +              reg:
> +                maxItems: 1
> +
> +              remote-endpoint: true
> +
> +              data-lanes:
> +                minItems: 1
> +                uniqueItems: true

These are confusing... you allow only one item, so why minItems and
uniqueItems?

> +                items:
> +                  - enum: [ 0, 1, 2, 3]
> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.
> +
> +            required:
> +              - reg
> +              - remote-endpoint
> +
>      required:
>        - port@0
>        - port@1
> @@ -186,3 +213,45 @@ examples:
>              };
>          };
>      };
> +  - |
> +    &i2c3 {
> +	anx_bridge_dp: anx7625-dp@58 {

Messed up indentation.

> +	    compatible = "analogix,anx7625

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

";
> +	    reg = <0x58>;

Best regards,
Krzysztof

