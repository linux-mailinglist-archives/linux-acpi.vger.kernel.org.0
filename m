Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112D660D3C
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Jan 2023 10:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjAGJUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 7 Jan 2023 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbjAGJUM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2023 04:20:12 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7F88DE0
        for <linux-acpi@vger.kernel.org>; Sat,  7 Jan 2023 01:19:58 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i16so1676429ilq.9
        for <linux-acpi@vger.kernel.org>; Sat, 07 Jan 2023 01:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PbK2+hAlju8ZkGAxc+UQ8RxlZcml7uwUsydLc2gyPEg=;
        b=kfpfmOt+J4n/7SFbmM1pUbeuoX2q1niSB/uKPzsnGL7+M0JwLgagBJO3UnWh65gVeF
         XO11m2J1IDe09i1vfxNVoD6lJRkxkJ4n+RqYZKMvsVrWoM/SCt0NBGzC/SMOz697A2pZ
         YKJvooichUSfD0CDPe7PH0T5W+F3TJ6QkCkz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PbK2+hAlju8ZkGAxc+UQ8RxlZcml7uwUsydLc2gyPEg=;
        b=SbscSMmZ25XuVEqS4+Pu5FmAWZRmZ4YDuhMfNdxFTVcGqUiLzowYfMXzBRjYccbV/L
         UIuEC8q8Yf1Ik60O+DBeSTrB88I1T7Kitg2avd97cMdtyGMsk4xnJung7lm6lVgrjEze
         PSN/dyw0k//6uZMGFkEzRFPGlve+8ItZObffp1dLEj1ZehxGNsxY91bcqwTOwf61r1F6
         03zdHE25HNmxvJew0Yk3vOvOUtoYuS1K2mBsiq0Lqto7ZAFT5G503/61x5Cz+sTp0mEe
         kJSH5u5SCxgZfGc+glq6ej3tJdAURBcFuej0RJDk3nHK/HoLt9u5c1CLZN5wG+12Qjze
         vkyQ==
X-Gm-Message-State: AFqh2kprAOVdvwVaywBmaYq7uZ7L1WcTrsTwYV5jNEPR7/SWtBPdZZfV
        2u3lYVRw4Z2F6hr8lM263RV4bA91nQq+PKFw7qv9ig==
X-Google-Smtp-Source: AMrXdXvICIhe7IxdthfJp4igZhpX85NTS+E2nKcOMieonKi7rm9RWK0+me5+LzCr+2tJ6fmZgXKyCZIwff6ecY8f7CA=
X-Received: by 2002:a92:d0f:0:b0:303:96b3:c8a0 with SMTP id
 15-20020a920d0f000000b0030396b3c8a0mr5352459iln.192.1673083197870; Sat, 07
 Jan 2023 01:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20230105132457.4125372-1-treapking@chromium.org>
 <20230105132457.4125372-8-treapking@chromium.org> <5ad7a6bc-0ffd-9d2d-ed80-62c3530cf2fa@linaro.org>
In-Reply-To: <5ad7a6bc-0ffd-9d2d-ed80-62c3530cf2fa@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Sat, 7 Jan 2023 17:19:46 +0800
Message-ID: <CAEXTbpdxQDvkJTX0XgNkn8s=KMZHuLaPN8nnyfcbkxJ3fgQbdA@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
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

Hi Krzysztof,

Thanks for the review.

On Fri, Jan 6, 2023 at 8:48 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/01/2023 14:24, Pin-yen Lin wrote:
> > ITE IT6505 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).

I'll fix this in this patch and the one for anx7625.
>
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v7:
> > - Fixed issues reported by dt_binding_check.
> > - Updated the schema and the example dts for data-lanes.
> > - Changed to generic naming for the example dts node.
> >
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../bindings/display/bridge/ite,it6505.yaml   | 95 ++++++++++++++++---
> >  1 file changed, 84 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > index b16a9d9127dd..1ee7cd0d2035 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> > @@ -77,20 +77,45 @@ properties:
> >          unevaluatedProperties: false
> >          description: Video port for DP output
> >
> > -        properties:
> > -          endpoint:
> > +        patternProperties:
> > +          "^endpoint@[01]$":
> >              $ref: /schemas/graph.yaml#/$defs/endpoint-base
> >              unevaluatedProperties: false
> >
> >              properties:
> > +              reg:
> > +                maxItems: 1
> > +
> > +              remote-endpoint: true
> > +
> >                data-lanes:
> > -                minItems: 1
> > -                uniqueItems: true
> > -                items:
> > -                  - enum: [ 0, 1 ]
> > -                  - const: 1
> > -                  - const: 2
> > -                  - const: 3
> > +                oneOf:
> > +                  - minItems: 1
>
> Drop minItems.
>
> > +                    maxItems: 1
>
> Actually drop this as well and just use items with one item (enum).

Sure I'll update this in v8.
>
> > +                    items:
> > +                      enum: [0, 1, 2, 3]
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
> >
> >      required:
> >        - port@0
> > @@ -102,7 +127,6 @@ required:
> >    - pwr18-supply
> >    - interrupts
> >    - reset-gpios
> > -  - extcon
> >    - ports
> >
> >  additionalProperties: false
> > @@ -139,8 +163,11 @@ examples:
> >                  };
> >
> >                  port@1 {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> >                      reg = <1>;
> > -                    it6505_out: endpoint {
> > +                    it6505_out: endpoint@0 {
> > +                        reg = <0>;
> >                          remote-endpoint = <&dp_in>;
> >                          data-lanes = <0 1>;
> >                      };
> > @@ -148,3 +175,49 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c3 {
>
> Just i2c

Will fix in v8.
>
> Best regards,
> Krzysztof
>

Best regards,
Pin-yen
