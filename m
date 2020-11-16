Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A343C2B4F14
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgKPSTx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 13:19:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47004 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbgKPSTw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 13:19:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id g19so16888641otp.13;
        Mon, 16 Nov 2020 10:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohGFL3Q7pKV3keI5xbAuvjquZQzxNqdIFUMSBmoE3o8=;
        b=TQDfVJ6764zTVuXDJN0mHvDHedcP5A9HOIbeE/ejCVlwmbhpNld5gVBF/vVgp/q98u
         3PifuEgd9fKx3D6J4M6rJBS6E2IO7X6pQYsMNAxJIgKsjG2XA8yx9DCTOQ7NwIcdB/fD
         fBFbKQT58JKNBKUTeOzkBzlUIRlhyWB93bQshHFvNKaOBcbvjWijTxBy+tCGm0CjEzb8
         dixKb1sauobpMk2yIkdsnwm4YM2xmbWeNzYSUk4QYbGiI3O8Gt4EMRsDzDBz4Ta53CmP
         pKD/DZa2IW8LoVIkUeoGMvf4YT3YpTHd9LTEcYOWveYcULqbPLG28E/oIu+Nc4/DerPv
         QqcQ==
X-Gm-Message-State: AOAM532oSOKFnxn/DwHxJRdi1nRqTb4vZzygQTZSHM8tamLvTFeGiCD4
        W0/INc4Mqq/cz0DP4PtznDlhkFwcMQqMnsio6z4=
X-Google-Smtp-Source: ABdhPJxIpheWJYE+OS5cb2zI0swiLwjIzJydT8/ML2/e00xId9fKAVgCGtWybZiqqDeFxHsUrZB+4HRGT7bkzlPYMhQ=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr387479ota.321.1605550790627;
 Mon, 16 Nov 2020 10:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Nov 2020 19:19:39 +0100
Message-ID: <CAJZ5v0iK9VbeG1V+PFejc0F9sUiwm6a+UeU+ZaduSbW7JO38QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rtc: ds1307: Remove non-valid ACPI IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tin Huynh <tnhuynh@apm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 16, 2020 at 3:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added invalid
> ACPI IDs (all of them are abusing ACPI specification). Moreover there is
> not even a single evidence that vendor registered any of such devices.
>
> Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> with device properties adhering to a DT binding. The following patches
> will add support of that to the driver.
>
> Link: https://uefi.org/PNP_ACPI_Registry
> Cc: Tin Huynh <tnhuynh@apm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW, the series looks good to me.

Please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patches.

> ---
> v2: reworded commit message to clarify source of properties (Rafael)
>  drivers/rtc/rtc-ds1307.c | 36 +-----------------------------------
>  1 file changed, 1 insertion(+), 35 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 9f5f54ca039d..fcb8e281abd5 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -8,7 +8,6 @@
>   *  Copyright (C) 2012 Bertrand Achard (nvram access fixes)
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/bcd.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -1169,31 +1168,6 @@ static const struct of_device_id ds1307_of_match[] = {
>  MODULE_DEVICE_TABLE(of, ds1307_of_match);
>  #endif
>
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id ds1307_acpi_ids[] = {
> -       { .id = "DS1307", .driver_data = ds_1307 },
> -       { .id = "DS1308", .driver_data = ds_1308 },
> -       { .id = "DS1337", .driver_data = ds_1337 },
> -       { .id = "DS1338", .driver_data = ds_1338 },
> -       { .id = "DS1339", .driver_data = ds_1339 },
> -       { .id = "DS1388", .driver_data = ds_1388 },
> -       { .id = "DS1340", .driver_data = ds_1340 },
> -       { .id = "DS1341", .driver_data = ds_1341 },
> -       { .id = "DS3231", .driver_data = ds_3231 },
> -       { .id = "M41T0", .driver_data = m41t0 },
> -       { .id = "M41T00", .driver_data = m41t00 },
> -       { .id = "M41T11", .driver_data = m41t11 },
> -       { .id = "MCP7940X", .driver_data = mcp794xx },
> -       { .id = "MCP7941X", .driver_data = mcp794xx },
> -       { .id = "PT7C4338", .driver_data = ds_1307 },
> -       { .id = "RX8025", .driver_data = rx_8025 },
> -       { .id = "ISL12057", .driver_data = ds_1337 },
> -       { .id = "RX8130", .driver_data = rx_8130 },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
> -#endif
> -
>  /*
>   * The ds1337 and ds1339 both have two alarms, but we only use the first
>   * one (with a "seconds" field).  For ds1337 we expect nINTA is our alarm
> @@ -1794,14 +1768,7 @@ static int ds1307_probe(struct i2c_client *client,
>                 chip = &chips[id->driver_data];
>                 ds1307->type = id->driver_data;
>         } else {
> -               const struct acpi_device_id *acpi_id;
> -
> -               acpi_id = acpi_match_device(ACPI_PTR(ds1307_acpi_ids),
> -                                           ds1307->dev);
> -               if (!acpi_id)
> -                       return -ENODEV;
> -               chip = &chips[acpi_id->driver_data];
> -               ds1307->type = acpi_id->driver_data;
> +               return -ENODEV;
>         }
>
>         want_irq = client->irq > 0 && chip->alarm;
> @@ -2065,7 +2032,6 @@ static struct i2c_driver ds1307_driver = {
>         .driver = {
>                 .name   = "rtc-ds1307",
>                 .of_match_table = of_match_ptr(ds1307_of_match),
> -               .acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
>         },
>         .probe          = ds1307_probe,
>         .id_table       = ds1307_id,
> --
> 2.28.0
>
