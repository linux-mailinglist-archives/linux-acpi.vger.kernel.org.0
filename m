Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9C68B79C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBFIny (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 03:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBFInr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 03:43:47 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6E21A4
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 00:43:45 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id q76so5741429vkb.4
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p8oD7R/FrBAkelIyxEM30uYD5gBcZlDZhHvr+FZng8E=;
        b=Nu81GZyEPAhLyKvqA8hK3yjuBadLPq/OVMOmYEObPhNf2/DKkCmXdZqOLJWZqHMyXo
         NZIYjTV+s6RChRPAaCo7wrHHpfathmnstTrzEvaFR0b+kCEoIS6XyE/BdDW+cmQfE5cL
         8lSkomPhvvSestXsJzriH0Mncz82ICUOTfcQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8oD7R/FrBAkelIyxEM30uYD5gBcZlDZhHvr+FZng8E=;
        b=yNtubRLIf16vXYrzWdNOQxQbBO3afysL1C9q2K9axRyymmlZuM+cK41H82YAgoearx
         sUfhhDIuWXCJF7f9ze3bWV66riDHlsU/3nV0JHLYp/nvbeot2G61+sgmjCIxt8aWOafe
         YuJnrDqmvjyMW5QlstobtcRF+P0cUmv00WSnzXBoMJq4Baba+XEaz+JLrEhV66VEVYnd
         V5Tyk45GElcMpMKZivCp2wImHBjDlIO7378KsTRJrddJUFeQMHG3NXwWlWegqK1gpN3+
         4PISiiZCfA+DmiqXTC/K63zi/g/021DEzga8JxmSlrt3uvAcu2JMg9Pi926vIHfKirWX
         9xBA==
X-Gm-Message-State: AO0yUKX+JjEiANQepaTyblA2iSVrUe8DLYcfKW72WE4L/8G7kiURG+mg
        flAvvbeh80Pd4LvEB7nzbY5htBGvPIgYYRZ4/h3DOQ==
X-Google-Smtp-Source: AK7set8rfNXDkSD7s7g/Z9Yi+fgiFxMAJA536L7Dzqiaomn/KaU5rwWRdIO8WqqAsbdrjqdw1OE5rCloQrh5y08A5OA=
X-Received: by 2002:ac5:cac7:0:b0:3ea:7394:e9ef with SMTP id
 m7-20020ac5cac7000000b003ea7394e9efmr2630363vkl.11.1675673024627; Mon, 06 Feb
 2023 00:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20230204133040.1236799-1-treapking@chromium.org> <20230204133040.1236799-5-treapking@chromium.org>
In-Reply-To: <20230204133040.1236799-5-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 6 Feb 2023 16:43:33 +0800
Message-ID: <CAGXv+5Gf5r4Unz+JCHUJS33uvuxPRDnwi=vTfxyM4rPTQZ0xbw@mail.gmail.com>
Subject: Re: [PATCH v11 4/9] dt-bindings: display: bridge: anx7625: Add
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
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 4, 2023 at 9:31 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
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
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> ---
>
> Changes in v11:
> - Updated the description of the endpoints
> - Referenced video-interfaces.yaml instead for the endpoints
>
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
>
> Changes in v9:
> - Collected Reviewed-by tag
>
> Changes in v8:
> - Updated anx7625 bindings for data-lane property
> - Fixed the subject prefix
>
> Changes in v7:
> - Fixed issues reported by dt_binding_check
> - Updated the schema and the example dts for data-lanes.
> - Changed to generic naming for the example dts node.
>
> Changes in v6:
> - Remove switches node and use endpoints and data-lanes property to
>   describe the connections.
>
>  .../display/bridge/analogix,anx7625.yaml      | 94 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 4590186c4a0b..f287e8e0602f 100644
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
> @@ -112,9 +113,46 @@ properties:
>                data-lanes: true
>
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>          description:
> -          Video port for panel or connector.
> +          Video port for panel or connector. Each endpoint connects to a video
> +          output downstream, and the "data-lanes" property is used to describe
> +          the pin connections. 0, 1, 2, 3 in "data-lanes" maps to SSRX1, SSTX1,
> +          SSRX2, SSTX2, respectively.
> +
> +        patternProperties:
> +          "^endpoint@[01]$":
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            properties:
> +              reg: true
> +
> +              remote-endpoint: true
> +
> +              data-lanes:
> +                oneOf:
> +                  - items:
> +                      - enum: [0, 1, 2, 3]
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +
> +                  - items:
> +                      - const: 2
> +                      - const: 3
> +
> +                  - items:
> +                      - const: 0
> +                      - const: 1
> +                      - const: 2
> +                      - const: 3

Given that this bridge only supports up to two lanes, including all four
lanes doesn't make sense.

> +
> +              mode-switch:
> +                type: boolean
> +                description: Register this node as a Type-C mode switch or not.

I would reword this as "Serves as Type-C mode switch if present"

ChenYu
