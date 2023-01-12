Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709FE666ACF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jan 2023 06:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbjALF0R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Jan 2023 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbjALF0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jan 2023 00:26:15 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9F63CD
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 21:26:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q190so8595651iod.10
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QY1E4/I6RghVeieKHKvp0MOZpx6IxtkejP5Fijsma7E=;
        b=jbR5QkZ9oTOTD86R7m2LvwAPxczUOeacx5dN+653AdySSX+Bpcf9XBGnH5lRRbfmJR
         sodSwRDpEyXjrQYEpdkNwDmY15Zav2XcpqVRXZ75WdQZUPSp+HD1LkCWASmj4amyOICs
         w6vxJaQ3oShEPZfh2OZMYmsk6/4BLAxTKyfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QY1E4/I6RghVeieKHKvp0MOZpx6IxtkejP5Fijsma7E=;
        b=c7Jw6FbVCWIB/QODgh6zGU1z5FNw8ZnHsWnur+vY/CTzRQ2Yn92Ffpu9XdOZ8fpMx5
         SMR2AiVE2nnJqrjTVJgoVDOx71k32CpeEFSQlXt+hoDuxykNNZG64BF+ddlAvY91C//q
         qt9ixplsADHHTP8c12d8Obb3INjEhZX0IQTuMrdGj+0fsWRY4WSl8iQ7nkc63Xb2Yg9G
         aYBbJRnemftmKq9r6v9hgeoBq/FjUL/wJrKNBa/XhfXnUMz/oHdrlTOCvXzTVWXMK9bj
         UmQhsLY0jICBf4TSnefMmR9wJuG08V2skB8uOwHrPqn76I4T6VamutcvnefSLsUwWBM4
         0nUA==
X-Gm-Message-State: AFqh2kojY2EMtOzQWVN1N4CHbVQsKTdi9aPHtdBTJztcdzE2E7m8gyJ2
        4dInii5H0iri+YGQodlB3w81kbn/c4NqV9btyqZYjw==
X-Google-Smtp-Source: AMrXdXugCp7x+cUdqaG8tZQfFSqRksTZdbCE7QDMdiXrvqvOB3sTUbzLnrw6wV699TgRxXpVeA0/zh1LOZOk5XKNk3c=
X-Received: by 2002:a05:6638:58:b0:38a:9192:2ba6 with SMTP id
 a24-20020a056638005800b0038a91922ba6mr7600948jap.76.1673501173912; Wed, 11
 Jan 2023 21:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-5-treapking@chromium.org> <fce16123-e157-bcd6-553d-6c1926fe1d46@linaro.org>
In-Reply-To: <fce16123-e157-bcd6-553d-6c1926fe1d46@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 12 Jan 2023 13:26:03 +0800
Message-ID: <CAEXTbpfrwRxT7hov1G_URGdVY+n-RWRZrGA8C2zjcnX=6QaOvg@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] dt-bindings: display: bridge: anx7625: Add
 mode-switch support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Xin Ji <xji@analogixsemi.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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

Hi Dmitry,

Thanks for the review.

On Thu, Jan 12, 2023 at 12:43 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/01/2023 06:20, Pin-yen Lin wrote:
> > Analogix 7625 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Also include the link to the product brief in the bindings.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > ---
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> >
> > Changes in v9:
> > - Collected Reviewed-by tag
> >
> > Changes in v8:
> > - Updated anx7625 bindings for data-lane property
> > - Fixed the subject prefix
> >
> > Changes in v7:
> > - Fixed issues reported by dt_binding_check
> > - Updated the schema and the example dts for data-lanes.
> > - Changed to generic naming for the example dts node.
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >    describe the connections.
> >
> >   .../display/bridge/analogix,anx7625.yaml      | 99 ++++++++++++++++++-
> >   1 file changed, 96 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > index 4590186c4a0b..b49a350c40e3 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > @@ -12,7 +12,8 @@ maintainers:
> >
> >   description: |
> >     The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
> > -  designed for portable devices.
> > +  designed for portable devices. Product brief is available at
> > +  https://www.analogix.com/en/system/files/AA-002291-PB-6-ANX7625_ProductBrief.pdf
> >
> >   properties:
> >     compatible:
> > @@ -112,10 +113,48 @@ properties:
> >                 data-lanes: true
> >
> >         port@1:
> > -        $ref: /schemas/graph.yaml#/properties/port
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> >           description:
> >             Video port for panel or connector.
> >
> > +        patternProperties:
> > +          "^endpoint@[01]$":
> > +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +            unevaluatedProperties: false
> > +
> > +            properties:
> > +              reg:
> > +                maxItems: 1
>
> Please remove duplicates to the graph.yaml. You have several of them here.

I'll fix this in v11.
>
> > +
> > +              remote-endpoint: true
> > +
> > +              data-lanes:
> > +                oneOf:
> > +                  - items:
> > +                      - enum: [0, 1, 2, 3]
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +
> > +                  - items:
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +                  - items:
> > +                      - const: 0
> > +                      - const: 1
> > +                      - const: 2
> > +                      - const: 3
> > +
> > +              mode-switch:
> > +                type: boolean
> > +                description: Register this node as a Type-C mode switch or not.
> > +
> > +            required:
> > +              - reg
> > +              - remote-endpoint
> > +
> >       required:
> >         - port@0
> >         - port@1
> > @@ -164,8 +203,12 @@ examples:
> >                   };
> >
> >                   mipi2dp_bridge_out: port@1 {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> >                       reg = <1>;
> > -                    anx7625_out: endpoint {
> > +                    anx7625_out: endpoint@0 {
>
> But why? It's perfectly fine from the graph perspective to omit the
> index if there is jus a single endpoint.

This is because "reg" property is added as a required property. Do you
suggest making "reg" property optional and only add it when there are
multiple ports?
>
> > +                        reg = <0>;
> >                           remote-endpoint = <&panel_in>;
> >                       };
> >                   };
> > @@ -186,3 +229,53 @@ examples:
> >               };
> >           };
> >       };
> > +  - |
> > +    i2c3 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        encoder@58 {
> > +            compatible = "analogix,anx7625";
> > +            reg = <0x58>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&anx7625_dp_pins>;
> > +            enable-gpios = <&pio 176 GPIO_ACTIVE_HIGH>;
> > +            reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
> > +            vdd10-supply = <&pp1100_dpbrdg>;
> > +            vdd18-supply = <&pp1800_dpbrdg_dx>;
> > +            vdd33-supply = <&pp3300_dpbrdg_dx>;
> > +            analogix,audio-enable;
> > +
> > +            ports {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                port@0 {
> > +                    reg = <0>;
> > +                    anx7625_dp_in: endpoint {
> > +                        bus-type = <7>;
> > +                        remote-endpoint = <&dpi_out>;
> > +                    };
> > +                };
> > +
> > +                port@1 {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> > +                    reg = <1>;
> > +                    anx_typec0: endpoint@0 {
> > +                        reg = <0>;
> > +                        mode-switch;
> > +                        data-lanes = <0 1>;
> > +                        remote-endpoint = <&typec_port0>;
> > +                    };
> > +                    anx_typec1: endpoint@1 {
> > +                        reg = <1>;
> > +                        mode-switch;
> > +                        data-lanes = <2 3>;
> > +                        remote-endpoint = <&typec_port1>;
> > +                    };
> > +                };
> > +            };
> > +        };
> > +    };
>
> --
> With best wishes
> Dmitry
>

Best regards,
Pin-yen
