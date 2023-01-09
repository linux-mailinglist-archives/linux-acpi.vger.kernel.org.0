Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD43666201E
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjAIIgS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 03:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjAIIgO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 03:36:14 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFE11444
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 00:36:12 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e129so4229548iof.3
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2023 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHG6QBVWalNbc6K28lbxbgnje/+7/XEu+lQ22LFlbhA=;
        b=RKb0bQ46rB+LGlcgXPPcXSNSsBvnsTEP2Ke81j6fsN0R18E5e0VfOaEeNTYQFYp3x1
         rQFXcYT9aKh2BFfqA/O8uH3QqudY/Yc8uhKMip+5WT6Rn1tw59rzHMo9cNqN3/zAz14j
         91oDYYt33C+AYk5ZdCGXa5TaDVBFg7RndXr/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHG6QBVWalNbc6K28lbxbgnje/+7/XEu+lQ22LFlbhA=;
        b=Ir2OG8DO0TtWFhl/guee83wochMSYrnQoB7W4laTkLQxCRdwbGZB/uwuSDKKwUQcAG
         m3Dvl4D1YAMTpd4W2hEDsla/EEOTVN/b4Pur11L6CYiyTHpNCtwFM4uXZHb+scyTpwCT
         NADiEBYq5UGL+xWXDLbiiTqBacaB8fZMSAFxSJrKzPceqsWj0WLcx9VvH2C8da1X1kh/
         SPKSf7z1FoCN0euzPn4lzUcUB4nyT3s4e99sDo3NrZzLbHNISrm5WpCsBcoy53Jm8J2J
         yn8xNiEN0RQirsEgjucpA9BQllzC5lQeb4CgpN0zFS3Kjm9Rt8DAwUFCjakd+kiuNwKN
         GuCg==
X-Gm-Message-State: AFqh2krU6EnsNeIUAzpKk9Ww3V/SxpseMyhMMbW8FRo90Fbc2/+iNfLA
        ofiJ05hHLAJplgkq8F7Pos0HePMZbc04EOqk3iPRoQ==
X-Google-Smtp-Source: AMrXdXuhMXzijzQbdmdDY+GL4BvF6UUNKOAXtws2POVhvMJvpc7JldHYHGfsgcPDVIsfECU7qR+WcgzqvnWgYoZMK4Y=
X-Received: by 2002:a5e:c00f:0:b0:6e3:38c6:e35f with SMTP id
 u15-20020a5ec00f000000b006e338c6e35fmr5425568iol.153.1673253371768; Mon, 09
 Jan 2023 00:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20230107102231.23682-1-treapking@chromium.org>
 <20230107102231.23682-8-treapking@chromium.org> <7f672ee7-7b78-dad9-ca58-2eb4c2c2dd39@linaro.org>
In-Reply-To: <7f672ee7-7b78-dad9-ca58-2eb4c2c2dd39@linaro.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Mon, 9 Jan 2023 16:36:00 +0800
Message-ID: <CAEXTbpd+yfCeg+SyVy0gbhh4g3MHNhQXZFi7M5svDfkjfDrWpw@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] dt/bindings: display: bridge: it6505: Add
 mode-switch support
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
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

Thanks for your review.

On Sun, Jan 8, 2023 at 10:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/01/2023 11:22, Pin-yen Lin wrote:
> > ITE IT6505 can be used in systems to switch the DP traffic between
> > two downstreams, which can be USB Type-C DisplayPort alternate mode
> > lane or regular DisplayPort output ports.
> >
> > Update the binding to accommodate this usage by introducing a
> > data-lanes and a mode-switch property on endpoints.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > ---
> >
> > Changes in v8:
> > - Updated bindings for data-lanes property
> > - Fixed subject prefix
>
> How? It is still wrong. You have slash there.

Sorry, I didn't even notice that. I'll fix this in v9.
>
> >
>
> (...)
>
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
> > @@ -148,3 +173,49 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c3 {
>
> Just i2c

I missed this when preparing v8. I'll fix this in v9.
>
>
> Best regards,
> Krzysztof
>

Best regards,
Pin-yen
