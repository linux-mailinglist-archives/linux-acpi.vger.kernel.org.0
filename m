Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C32D1176
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 14:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLGNMJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 08:12:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41492 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGNMJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 08:12:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id x13so4839518oto.8
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 05:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnNFhL8FNcuY+tVjqMjVY63bFBDILKwPjFtG/++ByPs=;
        b=hhHaypAlr3vhBWY2XigSGdh2P4O8yIJvO953yNA7TtpFpSkk/VQWQ33ZNvbTfPWoUc
         WpZVTsxoGM3yJeSlmNgK/JhVS8NvR27FyTqH5t0EWhbK+75+EQ/6nM6wgUscOtbF7/NR
         PyJJDVV2fmPr9P27tsVXNImE3iK2bOTo4HFKPlKo9zu3NYLGoRgXfBLijRZPFmLu6lMC
         Eu7nDZ2OJV4vLWLlt+mrKiBy79qRVrIIusrivybjp0407XsX/ABuLXmWt0W4RU2q+eSP
         uAfs2lSRUiLuxJkD7l0sGE0vnDnaRwfffvFDpFYgnXNpLLC7ggvSuEUotTLiTvnar7ZX
         o3oA==
X-Gm-Message-State: AOAM5332VOsDsMKJkCuZukZojhQbHG+/g7uWhcoIMA+RPADLejmeCUYn
        QroDmy+ZT1feu3mAnzqrY9uat5TKRpTpEnppPLY=
X-Google-Smtp-Source: ABdhPJyJuNXm1GiuBBWn4XhkaQzpcBfSvuln5INFjvpkC3bDts0EfdplJjXRQ85Zg4P2k7moT0Z7iBDGgBlb4/WRXIU=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr13413557otk.206.1607346682211;
 Mon, 07 Dec 2020 05:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204075041.44339-1-hui.wang@canonical.com>
In-Reply-To: <20201204075041.44339-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 14:11:05 +0100
Message-ID: <CAJZ5v0jnVoo_heYUAfbt4t6xFAOqq+dGus1LCZP_-5Q8o8cpQQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / bus: skip the primary physical pnp device in companion_match
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 4, 2020 at 8:51 AM Hui Wang <hui.wang@canonical.com> wrote:
>
> We are working on some latest Thinkpad Yoga and Carbon laptops, the
> touchscreen doesn't work on those machines. And we found the
> touchscreen module is I2C wacom WACF2200 (056A:5276).
>
> The problem is in the acpi_pnp.c, the WACFXXX is in the
> acpi_pnp_device_ids[], so a pnp device will be built and attach to the
> acpi_dev as the 1st physical_node, later when I2C subsystem starts to
> initialize, it will build an I2C_dev and attach to the acpi_dev as the
> 2nd physical_node. When I2C bus needs to match the acpi_id_table, it
> will call acpi_companion_match(), because the 1st physical_node is not
> I2C_dev, it fails to match, then the i2c driver (hid_i2c) will not be
> called.
>
> To fix it, adding a special treatment in the companion_match(): if the
> 1st dev is on pnp bus and the device in question is not on pnp bus,
> skip the 1st physical device, just use the device in question to
> match.
>
> We could refer to the pnpacpi_add_device() in the
> pnp/pnpacpi/core.c, pnp device will not be built if the acpi_dev
> is already attached to a physical device, so a pnp device has
> lower priority than other devices, it is safe to skip it in
> the companion_match().
>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/bus.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 1682f8b454a2..8aa0a861ca29 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -582,6 +582,15 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>         return !!acpi_primary_dev_companion(adev, dev);
>  }
>
> +/* Could move this function to linux/pnp.h in the future */
> +static bool acpi_dev_is_on_pnp_bus(const struct device *dev)
> +{
> +       if (dev->bus)
> +               return !strcmp(dev->bus->name, "pnp");
> +       else

Unnecessary else.

> +               return false;
> +}
> +
>  /*
>   * acpi_companion_match() - Can we match via ACPI companion device
>   * @dev: Device in question
> @@ -597,7 +606,9 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   * companion.  A typical case is an MFD device where all the sub-devices share
>   * the parent's ACPI companion.  In such cases we can only allow the primary
>   * (first) physical device to be matched with the help of the companion's PNP
> - * IDs.
> + * IDs. And another case is a pnp device is attached to ACPI device first, then
> + * other function devices are attached too, in this case, the primary physical
> + * device (pnp) is ignored, just use the device in question to match.
>   *
>   * Additional physical devices sharing the ACPI companion can still use
>   * resources available from it but they will be matched normally using functions
> @@ -605,7 +616,7 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>   */
>  struct acpi_device *acpi_companion_match(const struct device *dev)
>  {
> -       struct acpi_device *adev;
> +       struct acpi_device *adev, *radev;
>
>         adev = ACPI_COMPANION(dev);
>         if (!adev)
> @@ -614,7 +625,15 @@ struct acpi_device *acpi_companion_match(const struct device *dev)
>         if (list_empty(&adev->pnp.ids))
>                 return NULL;
>
> -       return acpi_primary_dev_companion(adev, dev);
> +       radev = acpi_primary_dev_companion(adev, dev);
> +       if (radev == NULL) {
> +               const struct device *first_dev = acpi_get_first_physical_node(adev);
> +
> +               if (acpi_dev_is_on_pnp_bus(first_dev) && !acpi_dev_is_on_pnp_bus(dev))
> +                       radev = adev;
> +       }
> +
> +       return radev;
>  }

This is too convoluted IMV.

Would dropping the device ID in question from acpi_pnp_device_ids[]
make the problem go away?

If so, why don't you do just that?
