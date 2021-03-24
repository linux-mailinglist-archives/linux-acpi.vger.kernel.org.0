Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC9347D2A
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhCXP6y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 11:58:54 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46767 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhCXP6K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 11:58:10 -0400
Received: by mail-ot1-f41.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso23448432ott.13;
        Wed, 24 Mar 2021 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OlQTEcFIX4CEIQrrUQfNWdtuKLtwMJSDttBcSM05XpU=;
        b=QcaxAnY5td0g8x3yegr5vKkFAUDcEaNyHwFCvSK1Va3+iU9lqqbOCKeGY1jUfyj+xv
         5Lxdmvws+w0GYFkKKgWGi9s1a56YtqZCbHg6Ah499+mebJmiVLKmxRGgkkFcYS7Mb95o
         1lk4hVf2soGU6vL5f75VXOpWi7lOsvGmngsrpDSH5jBxmYDc21oHSrLAKv2Lm1NUA7gJ
         8PAxg6qc4Xu9myf2v0t2SWtDVGVcs6T0KAFGlxIh9hrFPpGcEZ6d/D+wU+050l2wBmLg
         U072IvCS7j2n56ithuieUjsbhbY3c9nw0kp4HazvNalAkX45E4Eo561V3jSAesWEr2Bs
         MIag==
X-Gm-Message-State: AOAM530OKxhvow2XcaJTJNS2ieq4X4dSPjFXX7EbE+P09X9gy2vzmJDZ
        tWPYifsdUZafx38ZR8EuNehLghH8VYF2ush4zdg=
X-Google-Smtp-Source: ABdhPJxRkauSgaeZexanMigrLc+47QM8X3xovRTwIMoO05eQKkTFZpMof8Y1BDIRjltAbiN4A7lTd+zU5bgYNMJEx2M=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3837681otr.321.1616601490292;
 Wed, 24 Mar 2021 08:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616504247-48744-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1616504247-48744-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 16:57:59 +0100
Message-ID: <CAJZ5v0jKBXuvuhMiLCRJKhk9Ctbmh6mTcRqSh-_WnwHVZ0PabQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: fix some errors and warnings reported by checkpatch.pl
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 23, 2021 at 2:01 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Fix some errors and warnings reported by checkpatch.pl, including
> following five types:

Well, they are coding style issues rather than errors.

> ERROR: "foo * bar" should be "foo *bar"
> ERROR: code indent should use tabs where possible
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: void function return statements are not generally useful
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/ac.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index b86ee6e..07987854 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -78,17 +78,16 @@ static struct acpi_driver acpi_ac_driver = {
>  struct acpi_ac {
>         struct power_supply *charger;
>         struct power_supply_desc charger_desc;
> -       struct acpi_device * device;
> +       struct acpi_device *device;
>         unsigned long long state;
>         struct notifier_block battery_nb;
>  };
>
>  #define to_acpi_ac(x) power_supply_get_drvdata(x)
>
> -/* --------------------------------------------------------------------------
> -                               AC Adapter Management
> -   -------------------------------------------------------------------------- */
> -
> +/*
> + * AC Adapter Management
> + */

Please use the /* ... */ (one-line) comment format here and below for
comments that aren't longer than one line.

>  static int acpi_ac_get_state(struct acpi_ac *ac)
>  {
>         acpi_status status = AE_OK;
> @@ -109,9 +108,9 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
>         return 0;
>  }
>
> -/* --------------------------------------------------------------------------
> -                            sysfs I/F
> -   -------------------------------------------------------------------------- */
> +/*
> + * sysfs I/F
> + */
>  static int get_ac_property(struct power_supply *psy,
>                            enum power_supply_property psp,
>                            union power_supply_propval *val)
> @@ -138,10 +137,9 @@ static enum power_supply_property ac_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
>  };
>
> -/* --------------------------------------------------------------------------
> -                                   Driver Model
> -   -------------------------------------------------------------------------- */
> -
> +/*
> + * Driver Model
> + */
>  static void acpi_ac_notify(struct acpi_device *device, u32 event)
>  {
>         struct acpi_ac *ac = acpi_driver_data(device);
> @@ -174,8 +172,6 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>                 acpi_notifier_call_chain(device, event, (u32) ac->state);
>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
>         }
> -
> -       return;
>  }
>
>  static int acpi_ac_battery_notify(struct notifier_block *nb,
> @@ -282,9 +278,8 @@ static int acpi_ac_add(struct acpi_device *device)
>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>         register_acpi_notifier(&ac->battery_nb);
>  end:
> -       if (result) {
> +       if (result)
>                 kfree(ac);
> -       }
>
>         return result;
>  }
> @@ -293,7 +288,7 @@ static int acpi_ac_add(struct acpi_device *device)
>  static int acpi_ac_resume(struct device *dev)
>  {
>         struct acpi_ac *ac;
> -       unsigned old_state;
> +       unsigned int old_state;
>
>         if (!dev)
>                 return -EINVAL;
> @@ -352,9 +347,8 @@ static int __init acpi_ac_init(void)
>         }
>
>         result = acpi_bus_register_driver(&acpi_ac_driver);
> -       if (result < 0) {
> +       if (result < 0)
>                 return -ENODEV;
> -       }
>
>         return 0;
>  }
> --
