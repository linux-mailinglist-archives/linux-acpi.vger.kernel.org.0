Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD2358705
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDHOUj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 10:20:39 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33648 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhDHOUi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Apr 2021 10:20:38 -0400
Received: by mail-oi1-f172.google.com with SMTP id w70so2380484oie.0;
        Thu, 08 Apr 2021 07:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsFKUDXqph4UphRjAOoi8Pkkb5/3oXYisYAvqQ430Dc=;
        b=KdY9q2R99IkCk3N8NyFQ/YbYzRYtmAi+2bKbuLZ4LTTjlTJAil4dHFyiIdndEQffpN
         +w9AVbBMCiZ4k8G9xVhA48HRafPxa5rTBihg5pLIWTvHS3cT6PJ4dwGEEheWP36Gq3d1
         PKqcdgEnQcphDnulJQtPGIYOxAH40wmqB6vMFtcCGYYPaMZX3LrW/rHXoKIixPYfmht0
         z0hD03uLEdX0RwiZ9mE1XtCuAhqsH/QWejc0t3N/DrvXcjt4Bdzyrf0Dhl9E8zLWZorx
         vEhE2mY6ArSgqqNe9nvAEGgG6Mtsj6b9yHNTHPdj9heS+EIsbezXNZvTt+RzvEm9JbFy
         +Sxg==
X-Gm-Message-State: AOAM531TRp6zmgH69/AQG5UsVdOqxZTdeMZNhTiiCZDB6eIXRqDGOLnm
        qh/RPDwHLWahfp0yA5dWBkOQKc5rHBIjzcwOBf1SiBgd
X-Google-Smtp-Source: ABdhPJzoPAi6bD2oyaqBuyerEt3z82p57zsddaqu1bPgKwIJKYrzZUAQ8w/Vux5oQc0FH4LD8jf8dI4TOws8WvB4nGE=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr6093138oib.69.1617891626106;
 Thu, 08 Apr 2021 07:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <1616816821-39369-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1616816821-39369-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 16:20:15 +0200
Message-ID: <CAJZ5v0hfHASSY_MM8WQ35hzyn6ohdGPX=F65Q-sB+_RMqTZgGQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: AC: fix some coding style issues
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

On Sat, Mar 27, 2021 at 4:50 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Fix some coding style issues reported by checkpatch.pl, including
> following types:
>
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: code indent should use tabs where possible
> WARNING: Block comments use a trailing */ on a separate line
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: void function return statements are not generally useful
> WARNING: CVS style keyword markers, these will _not_ be updated
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/ac.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index b86ee6e..b0cb662 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *  acpi_ac.c - ACPI AC Adapter Driver ($Revision: 27 $)
> + *  acpi_ac.c - ACPI AC Adapter Driver (Revision: 27)
>   *
>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> @@ -78,17 +78,14 @@ static struct acpi_driver acpi_ac_driver = {
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
> +/* AC Adapter Management */
>  static int acpi_ac_get_state(struct acpi_ac *ac)
>  {
>         acpi_status status = AE_OK;
> @@ -109,9 +106,7 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
>         return 0;
>  }
>
> -/* --------------------------------------------------------------------------
> -                            sysfs I/F
> -   -------------------------------------------------------------------------- */
> +/* sysfs I/F */
>  static int get_ac_property(struct power_supply *psy,
>                            enum power_supply_property psp,
>                            union power_supply_propval *val)
> @@ -138,10 +133,7 @@ static enum power_supply_property ac_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
>  };
>
> -/* --------------------------------------------------------------------------
> -                                   Driver Model
> -   -------------------------------------------------------------------------- */
> -
> +/* Driver Model */
>  static void acpi_ac_notify(struct acpi_device *device, u32 event)
>  {
>         struct acpi_ac *ac = acpi_driver_data(device);
> @@ -174,8 +166,6 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>                 acpi_notifier_call_chain(device, event, (u32) ac->state);
>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
>         }
> -
> -       return;
>  }
>
>  static int acpi_ac_battery_notify(struct notifier_block *nb,
> @@ -282,9 +272,8 @@ static int acpi_ac_add(struct acpi_device *device)
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
> @@ -293,7 +282,7 @@ static int acpi_ac_add(struct acpi_device *device)
>  static int acpi_ac_resume(struct device *dev)
>  {
>         struct acpi_ac *ac;
> -       unsigned old_state;
> +       unsigned int old_state;
>
>         if (!dev)
>                 return -EINVAL;
> @@ -352,9 +341,8 @@ static int __init acpi_ac_init(void)
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

Applied as 5.13 material, thanks!
