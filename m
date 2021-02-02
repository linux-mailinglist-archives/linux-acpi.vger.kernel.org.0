Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AA30C7C4
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbhBBR3r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 12:29:47 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43098 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhBBONE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:13:04 -0500
Received: by mail-ot1-f45.google.com with SMTP id v1so19912449ott.10;
        Tue, 02 Feb 2021 06:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0479R2u394Ltk2QvfnHnoJX7XQcEO7QEsauy0fsS0KY=;
        b=MtcVvpFbX7qn4xs8UTWvrK4d5SCvFTvXVC4ikoi9sWdkTi26cuo2TK1wN/Azyg65Ry
         nPgmflDX2otwDVkJIJB72LqlxzjuebH+/tuxboZsZfoLAHqQAEOHBCNz18nVEeja+lh9
         jhH/jYj0DlNiRI4pfXW7jHXAMvhiATXgcF2QLEQzoOEeQ3h1+YpYMS6El0bjALVkwRPr
         /PnTm4dQlWEMAFHuP+8/5y2OC2OS+kYvcuzNL/H1Fxq2D4Qnw+l6Wshf7gzEcAVWOeex
         oW+V1fz+alEUlbEylpB+/+sp63NBos2jPwf/CmN8s6tzJqHyQwrvpYMDy8PL5kCr+LcO
         NwJA==
X-Gm-Message-State: AOAM533onbyZUpXT/NeAoxFj0qd+vMcWIykeSlE9aFal+/vDz29m8AoW
        h0bsWfl3cF+LDgXqSUMKDjA71l69CcXOgsScZ20=
X-Google-Smtp-Source: ABdhPJwL06BDRqOucvxZ1+dBx100NysJMJcZ3W8XTNWfFoiQ7YRg8VM3SFhq562hsYjKmftEg6NOcrGtcD/x5pK6Y74=
X-Received: by 2002:a9d:6acf:: with SMTP id m15mr15332415otq.260.1612275141868;
 Tue, 02 Feb 2021 06:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <20210202043345.3778765-2-saravanak@google.com>
In-Reply-To: <20210202043345.3778765-2-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 15:12:10 +0100
Message-ID: <CAJZ5v0j=ib_0tziOrEtafuezhgihNxh-Tv4-jT57z0b34uUHPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: fw_devlink: Detect supplier devices
 that will never be added
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 5:33 AM Saravana Kannan <saravanak@google.com> wrote:
>
> During the initial parsing of firmware by fw_devlink, fw_devlink might
> infer that some supplier firmware nodes would get populated as devices.
> But the inference is not always correct. This patch tries to logically
> detect and fix such mistakes as boot progresses or more devices probe.
>
> fw_devlink makes a fundamental assumption that once a device binds to a
> driver, it will populate (i.e: add as struct devices) all the child
> firmware nodes that could be populated as devices (if they aren't
> populated already).
>
> So, whenever a device probes, we check all its child firmware nodes. If
> a child firmware node has a corresponding device populated, we don't
> modify the child node or its descendants. However, if a child firmware
> node has not been populated as a device, we delete all the fwnode links
> where the child node or its descendants are suppliers. This ensures that
> no other device is blocked on a firmware node that will never be
> populated as a device. We also mark such fwnodes as NOT_DEVICE, so that
> no new fwnode links are created with these nodes as suppliers.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Still ACKed.

> ---
>  drivers/base/core.c    | 31 ++++++++++++++++++++++++++++---
>  include/linux/fwnode.h |  2 ++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 484a942884ba..c95b1daabac7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -148,6 +148,21 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
>         fwnode_links_purge_consumers(fwnode);
>  }
>
> +static void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *child;
> +
> +       /* Don't purge consumer links of an added child */
> +       if (fwnode->dev)
> +               return;
> +
> +       fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
> +       fwnode_links_purge_consumers(fwnode);
> +
> +       fwnode_for_each_available_child_node(fwnode, child)
> +               fw_devlink_purge_absent_suppliers(child);
> +}
> +
>  #ifdef CONFIG_SRCU
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
> @@ -1154,12 +1169,22 @@ void device_links_driver_bound(struct device *dev)
>         LIST_HEAD(sync_list);
>
>         /*
> -        * If a device probes successfully, it's expected to have created all
> +        * If a device binds successfully, it's expected to have created all
>          * the device links it needs to or make new device links as it needs
> -        * them. So, it no longer needs to wait on any suppliers.
> +        * them. So, fw_devlink no longer needs to create device links to any
> +        * of the device's suppliers.
> +        *
> +        * Also, if a child firmware node of this bound device is not added as
> +        * a device by now, assume it is never going to be added and make sure
> +        * other devices don't defer probe indefinitely by waiting for such a
> +        * child device.
>          */
> -       if (dev->fwnode && dev->fwnode->dev == dev)
> +       if (dev->fwnode && dev->fwnode->dev == dev) {
> +               struct fwnode_handle *child;
>                 fwnode_links_purge_suppliers(dev->fwnode);
> +               fwnode_for_each_available_child_node(dev->fwnode, child)
> +                       fw_devlink_purge_absent_suppliers(child);
> +       }
>         device_remove_file(dev, &dev_attr_waiting_for_supplier);
>
>         device_links_write_lock();
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index fde4ad97564c..21082f11473f 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -19,8 +19,10 @@ struct device;
>   * fwnode link flags
>   *
>   * LINKS_ADDED: The fwnode has already be parsed to add fwnode links.
> + * NOT_DEVICE: The fwnode will never be populated as a struct device.
>   */
>  #define FWNODE_FLAG_LINKS_ADDED                BIT(0)
> +#define FWNODE_FLAG_NOT_DEVICE         BIT(1)
>
>  struct fwnode_handle {
>         struct fwnode_handle *secondary;
> --
> 2.30.0.365.g02bc693789-goog
>
