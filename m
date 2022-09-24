Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A617A5E8E97
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Sep 2022 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIXQsC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Sat, 24 Sep 2022 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiIXQsB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Sep 2022 12:48:01 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CE5FAEE
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:48:00 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id g4so1904053qvo.3
        for <linux-acpi@vger.kernel.org>; Sat, 24 Sep 2022 09:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o2abk++w5sJRoX/sXFl4c//8ejpPhUCbt+jZmomYYMc=;
        b=HwfnktqVSXJPogRz+k62r5ZW5hvpU9kO9BagGAN4A6Mw0RUivPaz7aI9Qqt9/yBfKk
         dppw4voNfc/JrL8s2BWoC1e2sWfrI72uLlGH2bKKvk+KkANXNf/P9cUqRl7TnoktzgPx
         VL/IfdpJli7oXpRwGelmgjnUijYh0AXJRp3D1qcZ5Jnm/gLpXTFq1tb4/PG/KZwGHDNN
         6G2jLd91yg9ihwiSWRQUTrCJ/mIcXWp0EXroBagI2Btas06wywiwbv2aN9ylHZisoggP
         Qruig9cpTSgHQdC7HQtbNioDtgp4lIsN1FZGp/Tvb5iUmRd67iWI5aa+RKzXF1/a9bkV
         tbDQ==
X-Gm-Message-State: ACrzQf3cRO+YZwiCZGLUQHHgX8m6wmUvHpFRXk+lohfiIrdv/0Ik/b3j
        D7gG1AE37Kd0/YTxSTy/1cRQAcM+qqZny3fa8rg=
X-Google-Smtp-Source: AMsMyM5Wf9xZscwLF3cGQZp7LmVKfNGRUUp+s386GVr851dQOEqnzFKqlwHmRQxqWq6kiwifTQ9+jbgptld2oPnVRJA=
X-Received: by 2002:a05:6214:f24:b0:4ac:a9fd:8b42 with SMTP id
 iw4-20020a0562140f2400b004aca9fd8b42mr11447204qvb.22.1664038079665; Sat, 24
 Sep 2022 09:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220917215622.342912-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220917215622.342912-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:47:48 +0200
Message-ID: <CAJZ5v0jYxwTxDexLd0qz9jqB2H3ivNkMRN6ji_g-sw5DGEZETQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Reorder symbols to get rid of a few forward declarations
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 17, 2022 at 11:57 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Having the driver struct at the end of the file isn't only more usual, it
> also allows to drop a few forward declarations which are just useless
> repetition.
>
> While at it also move the MODULE_... macros to the end of the file.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/acpi/fan_core.c | 58 +++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index b9a9a59ddcc1..52a0b303b70a 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -19,43 +19,12 @@
>
>  #include "fan.h"
>
> -MODULE_AUTHOR("Paul Diefenbaugh");
> -MODULE_DESCRIPTION("ACPI Fan Driver");
> -MODULE_LICENSE("GPL");
> -
> -static int acpi_fan_probe(struct platform_device *pdev);
> -static int acpi_fan_remove(struct platform_device *pdev);
> -
>  static const struct acpi_device_id fan_device_ids[] = {
>         ACPI_FAN_DEVICE_IDS,
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, fan_device_ids);
>
> -#ifdef CONFIG_PM_SLEEP
> -static int acpi_fan_suspend(struct device *dev);
> -static int acpi_fan_resume(struct device *dev);
> -static const struct dev_pm_ops acpi_fan_pm = {
> -       .resume = acpi_fan_resume,
> -       .freeze = acpi_fan_suspend,
> -       .thaw = acpi_fan_resume,
> -       .restore = acpi_fan_resume,
> -};
> -#define FAN_PM_OPS_PTR (&acpi_fan_pm)
> -#else
> -#define FAN_PM_OPS_PTR NULL
> -#endif
> -
> -static struct platform_driver acpi_fan_driver = {
> -       .probe = acpi_fan_probe,
> -       .remove = acpi_fan_remove,
> -       .driver = {
> -               .name = "acpi-fan",
> -               .acpi_match_table = fan_device_ids,
> -               .pm = FAN_PM_OPS_PTR,
> -       },
> -};
> -
>  /* thermal cooling device callbacks */
>  static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
>                              *state)
> @@ -459,6 +428,33 @@ static int acpi_fan_resume(struct device *dev)
>
>         return result;
>  }
> +
> +static const struct dev_pm_ops acpi_fan_pm = {
> +       .resume = acpi_fan_resume,
> +       .freeze = acpi_fan_suspend,
> +       .thaw = acpi_fan_resume,
> +       .restore = acpi_fan_resume,
> +};
> +#define FAN_PM_OPS_PTR (&acpi_fan_pm)
> +
> +#else
> +
> +#define FAN_PM_OPS_PTR NULL
> +
>  #endif
>
> +static struct platform_driver acpi_fan_driver = {
> +       .probe = acpi_fan_probe,
> +       .remove = acpi_fan_remove,
> +       .driver = {
> +               .name = "acpi-fan",
> +               .acpi_match_table = fan_device_ids,
> +               .pm = FAN_PM_OPS_PTR,
> +       },
> +};
> +
>  module_platform_driver(acpi_fan_driver);
> +
> +MODULE_AUTHOR("Paul Diefenbaugh");
> +MODULE_DESCRIPTION("ACPI Fan Driver");
> +MODULE_LICENSE("GPL");
> --

Applied as 6.1 material, thanks!
