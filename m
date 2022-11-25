Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062746382EC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 04:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKYD6f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 22:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKYD6d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 22:58:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A026128
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 19:58:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l11so4786577edb.4
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 19:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qG1EXeCBFcyO3EVAf0VFxb1QU3GfLO5BAHKXK8QXU44=;
        b=cZ/iUq/8Ac4sXum6PlSkHb/8lyC1wBkmt7ce4NtB1gel3ZSjx7+/j9VGw3mOb3qQ75
         z6OPVvh42cBseSf3c90EAdRkVfv5lG9N/kDoZLZEIPvPbhbLOrcU+xTYq7do2H3H1j12
         XG72/gjTaeyAUuMMhwn3+Bt4Rity7g86DEFAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qG1EXeCBFcyO3EVAf0VFxb1QU3GfLO5BAHKXK8QXU44=;
        b=c30lVrPo1SWD48yJihZifuhaivz34PvzPDQ+ZdXnmqOn64PXRC0bMTtkZywBG4vJP0
         XPpbyEqB6vKqKDaHFH6BqTaiolA1rovFGrnv6BPNYeCZm8s1eUwkdEB2uajniXu9RRD9
         nn/4KboKNm5IS7/ppcsBgG4elV7ZMLjOzXxb0xTHJlJuHWtgZhVAVCqfl2G2owEsuwx2
         naxK0A/UqXO/ZUKIt/IPVkCCNmggeml3KnrDhl82dtcBKGVhQ5Zlh3fUV46y8ChNXKyF
         tV8B9UM6ccKiu8KFLRs5lSlnrxpTrLhi7xxmuumIr5bJnrOF4Xrjllq/2sP9/+L56qdt
         n0cQ==
X-Gm-Message-State: ANoB5pkx3qeSvXJEA4tLFUAkVjXmGYH0xPsHgBFaskPe53Mvx73qeSxi
        wXGxYnONK9IMzr/hdzowtlU80LNaIoFBuMIT1VZO8g==
X-Google-Smtp-Source: AA0mqf60CqwQOnre/TZIa/ZhVJ8FaIC4IKsOt/yGrHCUPoKZRFRMA3X+qFsKNmLvAyf46Xo33hjWsB1M1Hyr48/9OyU=
X-Received: by 2002:a05:6402:3895:b0:468:15f1:54b5 with SMTP id
 fd21-20020a056402389500b0046815f154b5mr14693061edb.8.1669348708173; Thu, 24
 Nov 2022 19:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20221124102056.393220-1-treapking@chromium.org>
 <20221124102056.393220-7-treapking@chromium.org> <166930150123.3946649.3725588692267123167.robh@kernel.org>
In-Reply-To: <166930150123.3946649.3725588692267123167.robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 25 Nov 2022 11:58:17 +0800
Message-ID: <CAEXTbpfFN=HKCNpQc6wrKozK-X14ky1jrw8GBnkk4rPm1LWoXA@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dt/bindings: drm/bridge: it6505: Add mode-switch support
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Xin Ji <xji@analogixsemi.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Benson Leung <bleung@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry for accidentally using the tab characters. Will fix this in v7.

On Fri, Nov 25, 2022 at 1:39 AM Rob Herring <robh@kernel.org> wrote:
>
>
> On Thu, 24 Nov 2022 18:20:55 +0800, Pin-yen Lin wrote:
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
> > Changes in v6:
> > - Remove switches node and use endpoints and data-lanes property to
> >   describe the connections.
> >
> >  .../bindings/display/bridge/ite,it6505.yaml   | 94 ++++++++++++++++++-
> >  1 file changed, 90 insertions(+), 4 deletions(-)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
>
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dts'
> Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: found character '\t' that cannot start any token
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/bridge/ite,it6505.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml:99:1: found character '\t' that cannot start any token
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml: ignoring, error parsing file
> make: *** [Makefile:1492: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221124102056.393220-7-treapking@chromium.org
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command.
>
