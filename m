Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0E66220D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 10:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjAIJt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 04:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjAIJsL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 04:48:11 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991110EA
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 01:47:38 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id t8so1854512uaj.5
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2023 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yJBLzPMDm5Q01iXB5Sz5L7WTxl86lVDIt70z6KlR+Fw=;
        b=HF4vGRVX4KrX+Buk98OORMVOApzR1ZVhIZG6Z/HtmES/yCtZYx7hnX6SYer6Z4YTAz
         cjSrcCBXFKxA//IC8yY8sz3kKi0LgCvBY3Q7kDlpNsWn7JMgogCtok+avfIe4kkZaoVB
         e8nnGFC6Tz/w2uu/cS3fe6XpYKhq/DIl0p8q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJBLzPMDm5Q01iXB5Sz5L7WTxl86lVDIt70z6KlR+Fw=;
        b=oZByQzMPVNgDOaTLB8llRgevaz0+uWzSlGaS9TgKBVexZfLLgWimBbZvVUsccSV/uD
         eoSFtWCyVuE7jq/gMQWIEtRrEtVaefDHUXK8r6z1A1QBV6CnOXESOi6rBDr91fXsjKVx
         oSciM6UqzshD0/QZpiA20lig3EfvngZ+Nuy4zo58fuhFVPOdR4XdEKgcuqVd/Q3k0tPE
         gmD4VzO7cMWSXV76NenXAtE9f0yc8h7u2Hv0b515onbYtrtj5dngKWUfuWTZH+n5T4fO
         MAcTyN5dauOx0FMeDC3RkgzJOmb5P4K2thgek37OYgKASszByKyYiy2cC+Jda5tNwl13
         e1ug==
X-Gm-Message-State: AFqh2kpw+p3ijQv2x7GFkpOauBvAZpHut5pOGNkrGo+dWszd3sDiUGYH
        8LYmvIj3CmI6OHj2VgLVSoe2FJaTeBn0IjiCU+4cFg==
X-Google-Smtp-Source: AMrXdXtrQtHYDxHPRjbH8w7qNhx5RWtnRaWn9ssgWPVavMNEUU5tSZg8SwoLKK8t83WFP7pMb0p2UP5jikrNxqjZXkY=
X-Received: by 2002:a9f:3189:0:b0:4c7:b2c7:d054 with SMTP id
 v9-20020a9f3189000000b004c7b2c7d054mr5823348uad.97.1673257657210; Mon, 09 Jan
 2023 01:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org> <20230109084101.265664-3-treapking@chromium.org>
In-Reply-To: <20230109084101.265664-3-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 9 Jan 2023 17:47:26 +0800
Message-ID: <CAGXv+5FVfSUo6aTfS6tGPZLT3gqBRj5i0h0gKk5EdifPj-4L8w@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] platform/chrome: cros_ec_typec: Purge blocking
 switch devlinks
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
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        chrome-platform@lists.linux.dev, Xin Ji <xji@analogixsemi.com>,
        linux-kernel@vger.kernel.org,
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

On Mon, Jan 9, 2023 at 4:41 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> From: Prashant Malani <pmalani@chromium.org>
>
> When using OF graph, the fw_devlink code will create links between the
> individual port driver (cros-ec-typec here) and the parent device for
> a Type-C switch (like mode-switch). Since the mode-switch will in turn
> have the usb-c-connector (i.e the child of the port driver) as a
> supplier, fw_devlink will not be able to resolve the cyclic dependency
> correctly.
>
> As a result, the mode-switch driver probe() never runs, so mode-switches
> are never registered. Because of that, the port driver probe constantly
> fails with -EPROBE_DEFER, because the Type-C connector class requires all
> switch devices to be registered prior to port registration.
>
> To break this deadlock and allow the mode-switch registration to occur,
> purge all the usb-c-connector nodes' absent suppliers. This eliminates
> the connector as a supplier for a switch and allows it to be probed.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>


Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8192 based Hayato (ASUS Chromebook Flip CM3200).
