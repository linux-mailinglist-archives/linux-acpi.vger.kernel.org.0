Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E406166723E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jan 2023 13:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjALMdL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Jan 2023 07:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjALMdL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jan 2023 07:33:11 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F707632D
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2023 04:33:10 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i185so18873479vsc.6
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jan 2023 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmMMKRN2mYFSKBWdfS4KEk8FcK8S7SAJEuBn9XGJN0Y=;
        b=gFe2+58oQUeTne9Zkfg/uZ9QWaIynLRPo7PQDJ5C/B/JiBw/x/ytir+8cc2ShEVEpM
         h1jAtFbbp7ClBkAXMOF0BppMfBNqixsIgnHhR3ykhKHeUymrnYCtxiYLGCoe2TjT9Bmt
         XMEDeAyOFogPrwD8JuhSHAK3nr+cnt+udZNp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmMMKRN2mYFSKBWdfS4KEk8FcK8S7SAJEuBn9XGJN0Y=;
        b=cn2mm79PyEs8tmVFaWM6heqUTaO2xN3FX6uajAiSNIRjIfZANWo83UzTzaQYs01nY+
         eqQmeUdt1w0LTnE4ZsPQWpjBjJhBufh21CA97ZrBX8Ukqm315/MhlWi0CgraQMpkUeX9
         27JJrwApWkk4Ox/hIQMumGkMJsCjliS0e/3XuOfOd718Yr72CXoonULE+T90BHCqIkeX
         XoNiQkdilU7sBS+D9osALk8vrHBSqUjMCDwYD0npAzENUfoI40kP/TViPVJ69wGqrrPC
         czoDmT4Nf7yJKtZkm6eGTjFnYMprYfKOz9w7cjCkqI0J/MLRUGo9u0sf7d5uqoLWTAhD
         VdYw==
X-Gm-Message-State: AFqh2krjf8f4fpHML7ILURfPAyrkAnKBYjDFHfNwT82RW85tPi0NhneH
        lMuXWM/iE35IHxpXmG9f1oadJsnOFBGJHC/Rfao0Rg==
X-Google-Smtp-Source: AMrXdXtCB2FwlHoY21KCpYVwLL1xj0HeaIsLRbFONUmvlRokBMQ/nNZG1R0mfhDYTDrxpXmDZBtfE8Cd1Wy2420mG2Q=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr9078574vsv.9.1673526789365; Thu, 12 Jan
 2023 04:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org> <20230112042104.4107253-10-treapking@chromium.org>
In-Reply-To: <20230112042104.4107253-10-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 12 Jan 2023 20:32:58 +0800
Message-ID: <CAGXv+5ErwJFmu3tFX5RjB9jj-2YWH6mabnHFxnRWv+oAZud=1Q@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] drm/bridge: it6505: Register Type C mode switches
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
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
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

On Thu, Jan 12, 2023 at 12:22 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Register USB Type-C mode switches when the "mode-switch" property and
> relevant port are available in Device Tree. Configure the "lane_swap"
> state based on the entered alternate mode for a specific Type-C
> connector, which ends up updating the lane swap registers of the it6505
> chip.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
