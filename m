Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149BD662204
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 10:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjAIJsL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 04:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjAIJrI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 04:47:08 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459FC120BB
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 01:46:33 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m2so7969510vsv.9
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2023 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JD9id90/GBv0rN+b+fEE7qihWEJZMu0XeMc/gEngtnw=;
        b=JxXWwl+eLuaP6fnFCpJj1Lr9KWkQl8r3Rpi0OvHY1f1GNT609qbw8bRS2JM6xzBJk1
         gzZwM3H2vWaM2CUnjzAfWx28LZ9jbXOnDUqsqoqVZPLJ3YveCvlDuFEP71Nhx0PN68te
         1LAah7NX2O0NdZBWtXSO51iFyBpRk9at/6lN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD9id90/GBv0rN+b+fEE7qihWEJZMu0XeMc/gEngtnw=;
        b=n1KWLjQZ9CSpMfVSBoE9A2XiCAXyq+ZTAe9Hh/p2/En6uvQRbuL1PZQI6FWINTpD1q
         UTCbyeWHrP1bvwSEoOaF3/mev07LWVJGb6lV04WeCiJtkoGJ8662eBQ52SKsABlJZTo1
         Su+UBCpfO58Ghe9pHSuY1WHAF2Sy5R7vNsFfuFVipJ670D55bGLzdjojrQrTzwOdVlZU
         CitPgmX0kQPUd6/2KoUqa1qrIbWKlal0pyLlwYHXfFPbTikN6y3b4KX2QlgYFg/VhKxL
         XJIfPVhwjmJtcQI2BQg6FJBYQNGeIzxCSlFtp4zJ3EuUChFZ7vHbWTWa9CBWI9H159O4
         DLzg==
X-Gm-Message-State: AFqh2krlSMitLtdxv+1UtQGDoCF8nbdSoCfCpiw+jhr+usTW9grxdFRF
        +r1iOfSFy3kNo82glV8CtvvbAALKgVQRYPAJK5L5hWvZR/gvdda0
X-Google-Smtp-Source: AMrXdXuO0fTMqxwkiZVvH9C4e5gp4mmmQNXabaJ9gGA79i+OpIS1ue3zRzP45wYsOoz3U1RqMDqvFfwghOaBt9YruXE=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr7186588vsv.9.1673257592360; Mon, 09 Jan
 2023 01:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org> <20230109084101.265664-2-treapking@chromium.org>
In-Reply-To: <20230109084101.265664-2-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 9 Jan 2023 17:46:21 +0800
Message-ID: <CAGXv+5GG_K8ga_c6mZcyn2y8Ydi3FHs4K6s7e45OeRPdD80g7A@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] device property: Add remote endpoint to devcon matcher
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
> When searching the device graph for device matches, check the
> remote-endpoint itself for a match.
>
> Some drivers register devices for individual endpoints. This allows
> the matcher code to evaluate those for a match too, instead
> of only looking at the remote parent devices. This is required when a
> device supports two mode switches in its endpoints, so we can't simply
> register the mode switch with the parent node.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8192 based Hayato (ASUS Chromebook Flip CM3200).
