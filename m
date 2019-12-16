Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0712022D
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLPKTC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 05:19:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46905 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfLPKTC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 05:19:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so3047859oii.13
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2019 02:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5XriA0S15RgeNG0SeUZd/2CwO1Ji3k/QUi+TsSSui0=;
        b=QLV2XuBehhOdjrT1uwcAbuFB4dbJFUX0AFN5YsE6k8Gy2Cb+zs3h7b0IvKpqJQjKwr
         eNUximOK2g2e3o6oW5DgQp93GLqrntEyYFOLKuqWxLFLGK6B+dp5hdf+tWP1yVEIw87d
         uWS5hvRAdpeT9AgSS5YDDsnjKWrdr6alcCK2QA8MVg0BTINofyYCXmoTocgoXmvg5NZo
         76JsuCUgUMPoLA7t7TnSitClVO7EIz2cNZakcLEw9YRfTg4b3QgJU1ovuFnd9+aCPmdl
         lsfAE7sAc2yQ+pv6GKTpt5nM6N8+YAC72SHDz6SfNDlkjIJjflGVeg8XxogfYPWWvb9i
         Vk9g==
X-Gm-Message-State: APjAAAVfj3cQzlvbrnTeclHZIdeLQgg5gTb8G+F7d2wB9X+7HTA8Qqs3
        XEnXj90b5gFawviDj4bu7oxR6h1U/hLgRexZKsYfIw==
X-Google-Smtp-Source: APXvYqw5VnVsko33vpFfcMtfVJCL51ia4KNdPujPUMA9hkfqf8os6h1JStNLyxE3vkJ7uTWnmej6CVovXqTeqkgnonw=
X-Received: by 2002:aca:cd92:: with SMTP id d140mr8957325oig.68.1576491541325;
 Mon, 16 Dec 2019 02:19:01 -0800 (PST)
MIME-Version: 1.0
References: <20191210095752.4211-1-hdegoede@redhat.com>
In-Reply-To: <20191210095752.4211-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Dec 2019 11:18:50 +0100
Message-ID: <CAJZ5v0iEbmejvVq-C=J8CdpARUs04UmF6OONmbmHyTUN3KF6mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI / battery: Deal with design or full capacity
 being reported as -1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 10, 2019 at 10:57 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on
> devices without full_charge_capacity") added support for some (broken)
> devices which always report 0 for both design- and full_charge-capacity.
>
> This assumes that if the capacity is not being reported it is 0. The
> ThunderSoft TS178 tablet's _BIX implementation falsifies this assumption.
> It reports ACPI_BATTERY_VALUE_UNKNOWN (-1) as full_charge_capacity, which
> we treat as a valid value which causes several problems.
>
> This commit fixes this by adding a new ACPI_BATTERY_CAPACITY_VALID() helper
> which checks that the value is not 0 and not -1; and using this whenever we
> need to test if either design_capacity or full_charge_capacity is valid.
>
> Fixes: b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on devices without full_charge_capacity")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applying along with the [2-3/3] as 5.6 material, thanks!

> ---
>  drivers/acpi/battery.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 558fedf8a7a1..9c0d7c577cb9 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -38,6 +38,8 @@
>  #define PREFIX "ACPI: "
>
>  #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
> +#define ACPI_BATTERY_CAPACITY_VALID(capacity) \
> +       ((capacity) != 0 && (capacity) != ACPI_BATTERY_VALUE_UNKNOWN)
>
>  #define ACPI_BATTERY_DEVICE_NAME       "Battery"
>
> @@ -192,7 +194,8 @@ static int acpi_battery_is_charged(struct acpi_battery *battery)
>
>  static bool acpi_battery_is_degraded(struct acpi_battery *battery)
>  {
> -       return battery->full_charge_capacity && battery->design_capacity &&
> +       return ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
> +               ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity) &&
>                 battery->full_charge_capacity < battery->design_capacity;
>  }
>
> @@ -263,14 +266,14 @@ static int acpi_battery_get_property(struct power_supply *psy,
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>         case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> -               if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
> +               if (!ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
>                         ret = -ENODEV;
>                 else
>                         val->intval = battery->design_capacity * 1000;
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_FULL:
>         case POWER_SUPPLY_PROP_ENERGY_FULL:
> -               if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
> +               if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
>                         ret = -ENODEV;
>                 else
>                         val->intval = battery->full_charge_capacity * 1000;
> @@ -283,11 +286,12 @@ static int acpi_battery_get_property(struct power_supply *psy,
>                         val->intval = battery->capacity_now * 1000;
>                 break;
>         case POWER_SUPPLY_PROP_CAPACITY:
> -               if (battery->capacity_now && battery->full_charge_capacity)
> +               if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN ||
> +                   !ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
> +                       ret = -ENODEV;
> +               else
>                         val->intval = battery->capacity_now * 100/
>                                         battery->full_charge_capacity;
> -               else
> -                       val->intval = 0;
>                 break;
>         case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>                 if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
> @@ -799,7 +803,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
>                 battery->bat_desc.properties = charge_battery_props;
>                 battery->bat_desc.num_properties =
>                         ARRAY_SIZE(charge_battery_props);
> -       } else if (battery->full_charge_capacity == 0) {
> +       } else if (!ACPI_BATTERY_CAPACITY_VALID(
> +                                       battery->full_charge_capacity)) {
>                 battery->bat_desc.properties =
>                         energy_battery_full_cap_broken_props;
>                 battery->bat_desc.num_properties =
> --
> 2.23.0
>
