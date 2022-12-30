Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6A65971B
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Dec 2022 11:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiL3KEk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Dec 2022 05:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3KEj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2022 05:04:39 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F567193EB
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 02:04:38 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id g65so6475941vkh.8
        for <linux-acpi@vger.kernel.org>; Fri, 30 Dec 2022 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ExYPh7ZCQLAcVoV2/SqeVJ+2V2M6l9fcSXq3tB4QxWY=;
        b=oEYPzAA+zkVxpKYc173YYeMY/bnwwE6uQr5YAZo6wkXXeoKXrRVo9ECSbBJMGIodQW
         1O6DKlbOtBU5Wao+gvmkDjnAiSMurzBgSMPK+3BxWoq20LgoRTLWLsDGojFukSjc+kkJ
         6qV7cHBzbTe5vnBE0r+68GkTFBybeLL9PyRf17h15eJtni37WNzNzfRSJ+PbBpeVZMsu
         xsPqO3HqoMLhNVtqaml4WnVIo+U/5Tq3uTo45N+R3gQvXUTUgZuRHqATrUasLLcaTGQF
         v1jmNG81SIs2OgyLXk2veo+CsIGQbhe24bTql+LNvBgvh92SOO+EWMdgSFSzq9Vrp4su
         WHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExYPh7ZCQLAcVoV2/SqeVJ+2V2M6l9fcSXq3tB4QxWY=;
        b=JDefT0s4czjLuwGVRVpy9uj8yIA2xdfhtlRMozkW56lG2gdwNrtAWR2rVvMxphChtG
         9keqx5ivEyoujipXh3nhzu9pemgp1L2i2XM4vtJ8sCsTsU9Q2vZxj3GZEBXpT++V7vS/
         oeAxA64CXZlUP7PRiCb3dh/5GyeBy5ej9JWPT7fBakgzhsQDeQZ7/lNukCZmtpMp29+8
         d8SAYAvH2K6vwSWGWga46FSobAMHlxWlRqTXXHNE8Btc8Yxhj4i/7SBEEc7oDLyGVK+m
         A4jX8zlgD+6qoAJeLDxAtiuNmoN68SL3V7TSgC5udPOlr8QTcTpw12RrjemwsGIqADyc
         jHdg==
X-Gm-Message-State: AFqh2kqtHpalO3rZ84clCk17Fm+5pbH/FEVkzcaGgi8j3lIhbm6QBPiJ
        aX1pYC0sCx0qm7BpPv09NNGUrzQRlLRPQMtv1b+YxQ==
X-Google-Smtp-Source: AMrXdXt7wuPRN1BtM7zjBgL/feVCI7O7KUPBfnqtP4FXAjQdG6O7OsnSKbdt+QnfbTIcRLLsLMiNIt47C0DxHFImiUA=
X-Received: by 2002:a1f:2508:0:b0:3b7:bd26:9251 with SMTP id
 l8-20020a1f2508000000b003b7bd269251mr3407821vkl.25.1672394677740; Fri, 30 Dec
 2022 02:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20221229164501.76044-1-hdegoede@redhat.com>
In-Reply-To: <20221229164501.76044-1-hdegoede@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Dec 2022 11:04:26 +0100
Message-ID: <CAMRc=MeZ407hS2D2-PGgeyhOMfVopYTxCS-Y0CAnaKJeJHSZsA@mail.gmail.com>
Subject: Re: [PATCH 6.2 regression fix] gpiolib: Fix using uninitialized
 lookup-flags on ACPI platforms
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        "regressions @ lists . linux . dev" <regressions@lists.linux.dev>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 29, 2022 at 5:45 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups") refactors
> fwnode_get_named_gpiod() and gpiod_get_index() into a unified
> gpiod_find_and_request() helper.
>
> The old functions both initialized their local lookupflags variable to
> GPIO_LOOKUP_FLAGS_DEFAULT, but the new code leaves it uninitialized.
>
> This is a problem for at least ACPI platforms, where acpi_find_gpio()
> only does a bunch of *lookupflags |= GPIO_* statements and thus relies
> on the variable being initialized.
>
> The variable not being initialized leads to:
>
> 1. Potentially the wrong flags getting used
> 2. The check for conflicting lookup flags in gpiod_configure_flags():
>    "multiple pull-up, pull-down or pull-disable enabled, invalid config"
>    sometimes triggering, making the GPIO unavailable
>
> Restore the initialization of lookupflags to GPIO_LOOKUP_FLAGS_DEFAULT
> to fix this.
>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note I'm not working and not reading work email until Monday January 9th.
> I hit this while doing some hobby stuff and I decided to send this out
> right away to avoid others potentially wasting time debugging this, but
> I will not see any replies until Monday January 9th.
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5a66d9616d7c..939c776b9488 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3905,8 +3905,8 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>                                                 const char *label,
>                                                 bool platform_lookup_allowed)
>  {
> +       unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
>         struct gpio_desc *desc = ERR_PTR(-ENOENT);
> -       unsigned long lookupflags;
>         int ret;
>
>         if (!IS_ERR_OR_NULL(fwnode))
> --
> 2.38.1
>

Queued for fixes, thanks!

Bart
