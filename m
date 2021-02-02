Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9430C254
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 15:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhBBOrd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 09:47:33 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34672 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhBBOfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:35:39 -0500
Received: by mail-oi1-f175.google.com with SMTP id h192so22945711oib.1;
        Tue, 02 Feb 2021 06:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ih/PTL+WWkjkdBUC30zkPX/RQgsZu1ZoljIT08j9q0k=;
        b=LmhM/HmT9UAV7C7Ps141MAIQkTHqLvWkdSLEUkWwjEEpBPAvPbZwCicPbhPd+0lmcV
         kfKlt3RNjIvSzGmXKLxX5rE/cFeVBCLnS9j4kJKjzwG4d6+v+gktEah5af/2YB9TYqPq
         /qPMLwYD1ShL2t4JL0ED4g8sjBeKC/3GIaI2UCebFTr+XeDG7Mu2UBo/6uEzxnZ33JLB
         3YMvBxeqmecvezihiKsZXAYDQeph1o3TlWrhka0ADSuI++ox1sFJr2ok3Kr1Y25IOqtM
         50wSMqup4lyZze/1OvhthTkzZKFL/eHqeDQuChhOdLupOai1GIS+eEABgnSA41Ifz0LU
         XLAQ==
X-Gm-Message-State: AOAM530O4aTspuAByOwFJUwGsHAmtWgNJMF/4fprd0d8Cp0sizahZCew
        /0l5QIjGlNTMVwQWRxkOimDwqOVyc5wcjz9b9arhExWv/z4=
X-Google-Smtp-Source: ABdhPJzJ3fJcnW2pigz7XFFqTe1FN1bzOTWbZKEbJ9nyB4o8w/ANHAYySB0DNK5TaxYdyIDDVI0GGkma3oes1RxoPy4=
X-Received: by 2002:aca:d14:: with SMTP id 20mr2990522oin.157.1612276497544;
 Tue, 02 Feb 2021 06:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <20210202043345.3778765-3-saravanak@google.com>
In-Reply-To: <20210202043345.3778765-3-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Feb 2021 15:34:46 +0100
Message-ID: <CAJZ5v0g6t4kWaMrhj35G01_6t1rrOhOe8Vqa9bAanJDaE5+zCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
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
> After a deferred probe attempt has exhaused all the devices that can be
> bound, any device that remains unbound has one/both of these conditions
> true:
>
> (1) It is waiting on its supplier to bind
> (2) It does not have a matching driver
>
> So, to make fw_devlink=on more forgiving of missing drivers for optional
> suppliers, after we've done a full deferred probe attempt, this patch
> deletes all device links created by fw_devlink where the supplier hasn't
> probed yet and the supplier itself is not waiting on any of its
> suppliers. This allows consumers to probe during another deferred probe
> attempt if they were waiting on optional suppliers.
>
> When modules are enabled, we can't differentiate between a driver
> that'll never be registered vs a driver that'll be registered soon by
> loading a module. So, this patch doesn't do anything for the case where
> modules are enabled.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/base.h |   2 +
>  drivers/base/core.c | 104 ++++++++++++++++++++++++++++++++++++--------
>  drivers/base/dd.c   |   5 +++
>  3 files changed, 94 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index f5600a83124f..34befe9475cb 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -186,6 +186,8 @@ extern void device_links_no_driver(struct device *dev);
>  extern bool device_links_busy(struct device *dev);
>  extern void device_links_unbind_consumers(struct device *dev);
>
> +bool fw_devlink_deferred_probe_retry(void);
> +
>  /* device pm support */
>  void device_pm_move_to_tail(struct device *dev);
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index c95b1daabac7..5e53fc6a21ea 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -50,6 +50,7 @@ static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
>  static DEFINE_MUTEX(fwnode_link_lock);
>  static bool fw_devlink_is_permissive(void);
> +static bool fw_devlink_def_probe_retry;
>
>  /**
>   * fwnode_link_add - Create a link between two fwnode_handles.
> @@ -881,6 +882,13 @@ static void device_link_put_kref(struct device_link *link)
>                 WARN(1, "Unable to drop a managed device link reference\n");
>  }
>
> +static void device_link_drop_managed(struct device_link *link)
> +{
> +       link->flags &= ~DL_FLAG_MANAGED;
> +       WRITE_ONCE(link->status, DL_STATE_NONE);
> +       kref_put(&link->kref, __device_link_del);
> +}
> +
>  /**
>   * device_link_del - Delete a stateless link between two devices.
>   * @link: Device link to delete.
> @@ -943,6 +951,29 @@ static void device_links_missing_supplier(struct device *dev)
>         }
>  }
>
> +/**
> + * device_links_probe_blocked_by - Return first supplier blocking probe
> + * @dev: Consumer device.
> + *
> + * Checks if the probe of @dev is blocked by a supplier without a driver. If
> + * yes, return that supplier dev. Otherwise, return NULL.
> + */
> +static struct device *device_links_probe_blocked_by(struct device *dev)
> +{
> +       struct device_link *link;
> +
> +       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> +               if (!(link->flags & DL_FLAG_MANAGED) ||
> +                   link->flags & DL_FLAG_SYNC_STATE_ONLY)
> +                       continue;
> +
> +               if (link->status != DL_STATE_AVAILABLE)
> +                       return link->supplier;
> +       }
> +
> +       return NULL;

This is slightly confusing, because you don't actually use the
returned device pointer, but simply check it against NULL.

AFAICS this function can return bool and I'd call it
device_links_probe_blocked().

> +}
> +
>  /**
>   * device_links_check_suppliers - Check presence of supplier drivers.
>   * @dev: Consumer device.
> @@ -961,7 +992,7 @@ static void device_links_missing_supplier(struct device *dev)
>   */
>  int device_links_check_suppliers(struct device *dev)
>  {
> -       struct device_link *link;
> +       struct device_link *link, *tmp;
>         int ret = 0;
>
>         /*
> @@ -982,19 +1013,47 @@ int device_links_check_suppliers(struct device *dev)
>
>         device_links_write_lock();
>
> -       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> +       list_for_each_entry_safe(link, tmp, &dev->links.suppliers, c_node) {
>                 if (!(link->flags & DL_FLAG_MANAGED))
>                         continue;
>
> -               if (link->status != DL_STATE_AVAILABLE &&
> -                   !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
> -                       device_links_missing_supplier(dev);
> -                       dev_dbg(dev, "probe deferral - supplier %s not ready\n",
> -                               dev_name(link->supplier));
> -                       ret = -EPROBE_DEFER;
> -                       break;
> +
> +               if (link->status == DL_STATE_AVAILABLE ||
> +                   link->flags & DL_FLAG_SYNC_STATE_ONLY) {
> +                       WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
> +                       continue;
> +               }
> +
> +               /*
> +                * After a deferred probe attempt has exhaused all the devices
> +                * that can be bound, any device that remains unbound has
> +                * one/both of these conditions true:
> +                *
> +                * (1) It is waiting on its supplier to bind
> +                * (2) It does not have a matching driver
> +                *
> +                * If this device is waiting on a supplier to bind to a driver,
> +                * we make sure condition (1) above is not true for the
> +                * supplier. In which case, condition (2) has to be true for
> +                * the supplier. That is, the supplier doesn't have a matching
> +                * driver.
> +                *
> +                * When we find such a supplier, we delete the device link if
> +                * it was created by fw_devlink. This it to allow the consumer
> +                * to probe in case the supplier is an optional.
> +                */
> +               if (fw_devlink_def_probe_retry &&

I would put a IS_ENABLED(CONFIG_MODULES) check here to let the
compiler optimize out the code depending on it and make it clear that
this is a NOP if there are modules.

> +                   link->flags & DL_FLAG_INFERRED &&
> +                   !device_links_probe_blocked_by(link->supplier)) {
> +                       device_link_drop_managed(link);
> +                       continue;
>                 }
> -               WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
> +
> +               device_links_missing_supplier(dev);
> +               dev_dbg(dev, "probe deferral - supplier %s not ready\n",
> +                       dev_name(link->supplier));
> +               ret = -EPROBE_DEFER;
> +               break;
>         }
>         dev->links.status = DL_DEV_PROBING;
>
> @@ -1132,13 +1191,6 @@ static void __device_links_supplier_defer_sync(struct device *sup)
>                 list_add_tail(&sup->links.defer_sync, &deferred_sync);
>  }
>
> -static void device_link_drop_managed(struct device_link *link)
> -{
> -       link->flags &= ~DL_FLAG_MANAGED;
> -       WRITE_ONCE(link->status, DL_STATE_NONE);
> -       kref_put(&link->kref, __device_link_del);
> -}
> -
>  static ssize_t waiting_for_supplier_show(struct device *dev,
>                                          struct device_attribute *attr,
>                                          char *buf)
> @@ -1597,6 +1649,24 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
>         return ret;
>  }
>
> +/** fw_devlink_deferred_probe_retry - Set up fw_devlink for probe retries

Kerneldoc format mistake.

> + *
> + * This function requests fw_devlink to set itself up for a deferred probe
> + * retry. This allows fw_devlink to ignore device links it created to
> + * suppliers that'll never probe. This is necessary in case some of the
> + * suppliers are optional and their consumers can probe without them.
> + *
> + * Returns true if deferred probe retry is likely to make any difference.
> + */
> +bool fw_devlink_deferred_probe_retry(void)
> +{
> +       if (IS_ENABLED(CONFIG_MODULES))
> +               return false;

To make the above more visible, I'd fold this function into the caller.

> +
> +       fw_devlink_def_probe_retry = true;
> +       return fw_devlink_get_flags() && !fw_devlink_is_permissive();
> +}
> +
>  /**
>   * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
>   * @con - Consumer device for the device link
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..11325df2327f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -317,6 +317,11 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
>         flush_work(&deferred_probe_work);
> +
> +       if (fw_devlink_deferred_probe_retry()) {
> +               driver_deferred_probe_trigger();
> +               flush_work(&deferred_probe_work);
> +       }
>         initcalls_done = true;
>
>         /*
> --

Overall, the "let's do nothing if modules are not enabled" approach is
a bit disappointing, because what if somebody builds all of the
drivers needed for boot in and enables modules anyway, for example to
allow USB drivers to be probed dynamically?

They surely can be forgiven for expecting to get the right ordering
then, like in the "no modules" case ...
