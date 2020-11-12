Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014862B0D53
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 20:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKLTCR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 14:02:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38012 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKLTBt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2020 14:01:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id o25so7588580oie.5;
        Thu, 12 Nov 2020 11:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+w+4eC2maSF/r7trirVas9YwBWw6JH5ZamWKvGgFzg=;
        b=g6GKcLONQO2OfVUAlTxSgl4l02t0ryPPNNp+Mk8ON2xEKz3UArzF0Wv5Srd4GlhubC
         TWo7m+VmxPCK7UiChKw3y995zBtxEZwuqc2UbNIQXBPixVyeDnY+prpVLvAclVPdY7aD
         Ou83vgppwropv8CuFmRtcahtoXFW8i2G+4R72KWkc8hTr53sNtT7aThG1K/q/t2hy7l4
         H6JpijXeQrjjQ9kf9Fjcf8Q4NGd+GiyfWPt+9158mP2Ru5J/ouXK8VsNVqcM7FOE09Gi
         Ff6NCB6GJspSogZcj6VqzR3nZ3CJ0jR3eSdYb0UKM5/CbM+ddsh9NDEi2CN6bxXk4X9d
         z4SA==
X-Gm-Message-State: AOAM531h+IOvg/P54X5xckrkQlEhQFPPzebjZsoy9tmrOai9dr2GycJv
        wRpVgpCC+zJpoUHTXDFOCKqd63YYv3bnB0KX3PA=
X-Google-Smtp-Source: ABdhPJzONrekm/QNxYeQPdMHxElZzXpS4vrLG0dN1cRv7WQGc6GvT1dwJq1+ZhgttQy4yP7zimAmxkaUSTEtpzL+lCc=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr794110oif.69.1605207708303;
 Thu, 12 Nov 2020 11:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 20:01:37 +0100
Message-ID: <CAJZ5v0hNBguxETML2rjweXEp6=iyxRyMNBcTYaLpwjO+ZposRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] rtc: ds1307: Remove non-valid ACPI IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 4:58 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added non-valid

s/non-valid/invalid/ ?

> ACPI IDs (all of them abusing ACPI specification). Moreover there is
> no even a single evidence that vendor registered any of such device.

"not even" and "devices".

> Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
> with device tree defined bindings.

"with device properties adhering to a DT binding". ?

> The following patches will add support of that to the driver.
>
> Link: https://uefi.org/PNP_ACPI_Registry
> Cc: Tin Huynh <tnhuynh@apm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
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
