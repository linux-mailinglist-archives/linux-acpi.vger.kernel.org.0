Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82768B9F1
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 11:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFKW7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 05:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBFKW6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 05:22:58 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B4BB90
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 02:22:53 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id cz15so2488242vsb.6
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 02:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDFXynxhTW1MwQ5q7ACPsdQYoX0X11isexUWJq5g+yg=;
        b=Tn+42238E/9sl6eoWwma3KtObVRsN/fRvB+q+b9YCSNv+D3eCfQs1FaM3VJac8A3r/
         DRhLjpUmzMZPlOcK4vFkiPX7O2EbwTtrNBHslK4TrfU5m1lwFmhchOwPN20shA+qADeN
         GIgNAy56Yw6c7Uv/a5ovUg0s+6fOBYxNGV9dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDFXynxhTW1MwQ5q7ACPsdQYoX0X11isexUWJq5g+yg=;
        b=ZO9d4OjVoB2FOjvRKQQFfHDnGTf5HlIg2QxPyLf1bH4A4RXiAlZhZadFU0FtNvweBK
         Ne4/gpeheI14WQJQYEW6GeIfBrGEfiVuRhmq18b6X9WrdYSiyd8tePBxlGgZoCCMfGt4
         +q/bu87VxU+GRS/FSeh0vcLftdnkAqQCsIbj4FYmwxGgrio67/7Ax+L8QTDtnsM5yY5Q
         Xd8+/H0pRRhcR4ZpSo4mzc1wHnZ+C6+r7oI5WI8XECBxrZW5x8ECPzmkv8rvmmZDmcNP
         WGAv/BcS+/4BMmq2xPjFq4EzmPW7d2yJyFgM6wSc5zpJt4rC5rJD6N34SOKbM/za1Pmg
         gPDw==
X-Gm-Message-State: AO0yUKU+7bv/Ie3PKn1gFaUwUrYHtXssWiY4tq6BvQLy//2FxVekC6Ng
        Q97dAlcdJTdT7831pJyeNqTTGmjmW0+C6vxJzM5/jQ==
X-Google-Smtp-Source: AK7set9UEObC8Y3n/7lmYrPAsFQnv8OgXuuTtX5cUD3nMzyjS/+VIqLpJpkmCwvPrE9S9lf2zhO2/iIUbDgx4yAMAfo=
X-Received: by 2002:a05:6102:322a:b0:3fe:ae88:d22 with SMTP id
 x10-20020a056102322a00b003feae880d22mr2896334vsf.65.1675678972359; Mon, 06
 Feb 2023 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org> <20230204133040.1236799-8-treapking@chromium.org>
In-Reply-To: <20230204133040.1236799-8-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Feb 2023 18:22:41 +0800
Message-ID: <CAGXv+5FBHKgOA_XAr7HzsZhsB_W5QbdY6R3q+5PCy5yynduprw@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] dt-bindings: display: bridge: it6505: Add
 mode-switch support
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Guenter Roeck <groeck@chromium.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-acpi@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 4, 2023 at 9:31 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> ITE IT6505 can be used in systems to switch the DP traffic between
> two downstreams, which can be USB Type-C DisplayPort alternate mode
> lane or regular DisplayPort output ports.
>
> Update the binding to accommodate this usage by introducing a
> data-lanes and a mode-switch property on endpoints.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
>
> ---
>
> Changes in v11:
> - Updated the description of the endpoints in the bindings
> - Referenced video-interfaces.yaml instead for the endpoints binding
> - Removed duplicated definitions from inherited schema
>
> Changes in v9:
> - Fixed subject prefix again
> - Changed the naming of the example node for it6505
>
> Changes in v8:
> - Updated bindings for data-lanes property
> - Fixed subject prefix
>
> Changes in v7:
> - Fixed issues reported by dt_binding_check.
> - Updated the schema and the example dts for data-lanes.
> - Changed to generic naming for the example dts node.
>
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.
>
>  .../bindings/display/bridge/ite,it6505.yaml   | 101 +++++++++++++++---
>  1 file changed, 88 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index b16a9d9127dd..8ae9c5cba22c 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -75,22 +75,49 @@ properties:
>        port@1:
>          $ref: /schemas/graph.yaml#/$defs/port-base
>          unevaluatedProperties: false
> -        description: Video port for DP output
> +        description:
> +          Video port for DP output. Each endpoint connects to a video output
> +          downstream, and the "data-lanes" property is used to describe the pin
> +          connections. 0, 1, 2, 3 in "data-lanes" maps to TX0, TX1, TX2, TX3,
> +          respectively.
>
> -        properties:
> -          endpoint:
> -            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/media/video-interfaces.yaml#
>              unevaluatedProperties: false
>
>              properties:
> +              reg: true
> +
> +              remote-endpoint: true
> +
>                data-lanes:
> -                minItems: 1
> -                uniqueItems: true
> -                items:
> -                  - enum: [ 0, 1 ]
> -                  - const: 1
> -                  - const: 2
> -                  - const: 3
> +                oneOf:
> +                  - items:
> +                      - enum: [0, 1, 2, 3]

Based on the datasheets we have and the downstream driver, I assume
the hardware implements "lane swap" as simply reversing the order
of the output pins.

In that case the hardware can't output 1 lane DP on any arbitrary lane,
but only lane 0 or 3.

> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +
> +                  - items:
> +                      - const: 2
> +                      - const: 3

And maybe a bit pedantic, but have the order correct as:

    - const: 3
    - const: 2

> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3
> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.

Same as the anx7625 patch, I would reword this as "Serves as Type-C mode
switch if present".


ChenYu


> +
> +            required:
> +              - reg
> +              - remote-endpoint
>
>      required:
>        - port@0
> @@ -102,7 +129,6 @@ required:
>    - pwr18-supply
>    - interrupts
>    - reset-gpios
> -  - extcon
>    - ports
>
>  additionalProperties: false
> @@ -139,8 +165,11 @@ examples:
>                  };
>
>                  port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
>                      reg = <1>;
> -                    it6505_out: endpoint {
> +                    it6505_out: endpoint@0 {
> +                        reg = <0>;
>                          remote-endpoint = <&dp_in>;
>                          data-lanes = <0 1>;
>                      };
> @@ -148,3 +177,49 @@ examples:
>              };
>          };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dp-bridge@5c {
> +            compatible = "ite,it6505";
> +            interrupts = <8 IRQ_TYPE_LEVEL_LOW 8 0>;
> +            reg = <0x5c>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&it6505_pins>;
> +            ovdd-supply = <&mt6366_vsim2_reg>;
> +            pwr18-supply = <&pp1800_dpbrdg_dx>;
> +            reset-gpios = <&pio 177 0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    it6505_dpi_in: endpoint {
> +                        remote-endpoint = <&dpi_out>;
> +                    };
> +                };
> +                port@1 {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    reg = <1>;
> +                    ite_typec0: endpoint@0 {
> +                        reg = <0>;
> +                        mode-switch;
> +                        data-lanes = <0 1>;
> +                        remote-endpoint = <&typec_port0>;
> +                    };
> +                    ite_typec1: endpoint@1 {
> +                        reg = <1>;
> +                        mode-switch;
> +                        data-lanes = <2 3>;
> +                        remote-endpoint = <&typec_port1>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> --
> 2.39.1.519.gcb327c4b5f-goog
>
