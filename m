Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6157C976
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jul 2022 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGULBP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jul 2022 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGULBP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jul 2022 07:01:15 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767EC3054A
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jul 2022 04:01:14 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31e64ca5161so13223127b3.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jul 2022 04:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yacwu+7aLAL4vzZga75Ep0yNgXwnefoiMBI1MBaUr2U=;
        b=1R5qYRL2vHCRlQx/DtJxuFcxHNu9NP8CrsQqABYmMjspDH9GvSOxnTeIKSCC/GwIQK
         tc51ApwCtvkqjUhwWxkDwKGd5H5E2P2xFZwqo7dSfKopzLyUv4+A17y2Xd9bjBAUL0/l
         qaLvlicsPOKyf7/KQS1PZAgGPSyxG0mF7gfNr70KxIUYIiU7d4J1GA71rI3Evwd520dE
         RVlhNY4ClmCeOQTbnOYI2Glg8V1p7uOrSF516wjaacHP+0tfJS8J/Bw2YmMOiaLgeAxT
         a1fFkIYbpKyZXYYOu9QekrluvN+1Lnhs/dZ1sDGZlFRFpO3RGkq8RxdzSNGvGqzK49PQ
         FsLQ==
X-Gm-Message-State: AJIora9H0g8TD5yJDggp3BnM9vwCQQKwNu8GgRaDcGm3XodsTNnB7XYz
        4T206d2F1W/4Knh3L7KQatcpkhFUhwDcTDMb26YPGCCq
X-Google-Smtp-Source: AGRyM1tjVNWILpTWPXNtVhD9VOvGEpaahi8vvgPUVmvBt99XWtuObRIKvDIQHgCIWL4Zw/f3uKGF1QasOg7ofg6U6FU=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr1375805ywc.301.1658401273684; Thu, 21
 Jul 2022 04:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <7d5bd8b6-15ba-a99c-349e-cfbd94942239@umanwizard.com>
In-Reply-To: <7d5bd8b6-15ba-a99c-349e-cfbd94942239@umanwizard.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 13:01:02 +0200
Message-ID: <CAJZ5v0h9BJxR6aNBFwn4O=PEJ=VfBYa0CL8c6HyWkxrrVLypZA@mail.gmail.com>
Subject: Re: [PATCH] Expose ACPI battery "measurement accuracy" property to sysfs.
To:     Brennan Vincent <brennan@umanwizard.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 15, 2022 at 9:08 PM Brennan Vincent <brennan@umanwizard.com> wrote:
>
> This property, expressed in thousands of a percent,
> reports how accurate the device claims its
> capacity metrics to be. It may be useful for battery
> monitoring tools.

For changes like this, it is usually required to at least provide a
pointer to a user space utility that will use the given ABI.

Are you aware of any plans to use this new attribute in any existing utilities?

> ---
>  drivers/acpi/battery.c                    | 7 +++++++
>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  include/linux/power_supply.h              | 1 +
>  3 files changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 306513fec1e1..933f3de4dd67 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -300,6 +300,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_SERIAL_NUMBER:
>                 val->strval = battery->serial_number;
>                 break;
> +       case POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY:
> +               val->intval = battery->measurement_accuracy;
> +               break;
>         default:
>                 ret = -EINVAL;
>         }
> @@ -322,6 +325,7 @@ static enum power_supply_property charge_battery_props[] = {
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>  };
>
>  static enum power_supply_property charge_battery_full_cap_broken_props[] = {
> @@ -336,6 +340,7 @@ static enum power_supply_property charge_battery_full_cap_broken_props[] = {
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>  };
>
>  static enum power_supply_property energy_battery_props[] = {
> @@ -354,6 +359,7 @@ static enum power_supply_property energy_battery_props[] = {
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>  };
>
>  static enum power_supply_property energy_battery_full_cap_broken_props[] = {
> @@ -368,6 +374,7 @@ static enum power_supply_property energy_battery_full_cap_broken_props[] = {
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>  };
>
>  /* Battery Management */
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 4239591e1522..844dbd61295f 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>         POWER_SUPPLY_ATTR(MODEL_NAME),
>         POWER_SUPPLY_ATTR(MANUFACTURER),
>         POWER_SUPPLY_ATTR(SERIAL_NUMBER),
> +       POWER_SUPPLY_ATTR(MEASUREMENT_ACCURACY),
>  };
>
>  static struct attribute *
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index cb380c1d9459..4c48ee26f1b5 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -174,6 +174,7 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>  };
>
>  enum power_supply_type {
> --
> 2.34.1
