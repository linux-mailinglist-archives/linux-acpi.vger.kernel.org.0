Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3FE3161A2
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 09:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBJI6p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 03:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBJI4L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 03:56:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849CC061756
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 00:55:31 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e132so1243713ybh.8
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2021 00:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIYUBkGMy3qE6aqOle/QpEgFxQFoJfY+aVajMelV3xs=;
        b=qqKG0XSv+akp+PhEDy+mWsosrzGxxmJtkSfE/RiAHtParBQ1+/HeO672kBHv8o8i3G
         eesnT9wcGJbvHbEc1b+g2cn0zA0r/mdAvB5O6SsxerFnvgsLpiD28pUxjoC2ILa9euYV
         xYnXmOzzgBvMfFgJOHoRR+nS/1qfbPS4DJMg3ElQZbbZMS9S72aPCJBFR1jKl5o7SEK9
         gRY86ph1NI9lK898i7M4Bbmis02HInlo2BaYGfBFxcGzfZwvNSrCXXoPaZIT3IgxwxES
         KbI+yTrvPRW7RVetJNStLFzDlDblpefA1Q7CbbkLfvL9z8TfDasFOAyUL0v8uoBv3qq/
         JRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIYUBkGMy3qE6aqOle/QpEgFxQFoJfY+aVajMelV3xs=;
        b=NZAGweP8tcZwn1gv+EfK8ZgR4krtwUbrJr8SIZfZZXXq9IjiZmWV/lwRIEy4YOU8hv
         c15vqTFy19/8sDHDlfCHJKQxJG7lebcCn9emNQ3fQi8NytTyBiax7IOMKgQjXhlB1WuN
         iKqFuddVSEpDJtI3YfN52eoWjYxBRbca93l8GWYqpxogmpeUzqwQohecEzK1nLEmvRVb
         IM0G1sGQua7FK5sSewlqnto4EzyX9vib9xiMM+NBvwHd92JCgjJx1RK+vJ2CPEmbE8lG
         aahdT8KJtnUhFKsAYQlutua9xAZH4SeWccL4hyTXudvl23C2HzEAaKD7wQhb6ZGooo8T
         R3hA==
X-Gm-Message-State: AOAM531g3TSJgy3eob+CJKtm0pIfTuVIf+h2tYXI6S1d8MtfG+OCs/yO
        sm4jxNQMwULpoHQtqd2dDGVlvyAONTdGa1aJ9soPBw==
X-Google-Smtp-Source: ABdhPJwwgYm9gSe18/JyjErLTRz5FCOkyXxd4stR4ZaLz//fROhqjDQGN2y2rtdVkMLB3bpoDtl1Y3uYT/scb2Xt5zw=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr2865453ybt.96.1612947330653;
 Wed, 10 Feb 2021 00:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <47ca46aa-99f3-5203-8aa7-65c6443bd965@microchip.com>
In-Reply-To: <47ca46aa-99f3-5203-8aa7-65c6443bd965@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 10 Feb 2021 00:54:54 -0800
Message-ID: <CAGETcx862JPn8759tk-69WySBvokxMXJaaOVY7L6V8FLwfpV8g@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 10, 2021 at 12:19 AM <Tudor.Ambarus@microchip.com> wrote:
>
> Hi, Saravana,
>
> On 2/6/21 12:26 AM, Saravana Kannan wrote:
> > There are a lot of devices/drivers where they never have a struct device
> > created for them or the driver initializes the hardware without ever
> > binding to the struct device.
> >
> > This series is intended to avoid any boot regressions due to such
> > devices/drivers when fw_devlink=on and also address the handling of
> > optional suppliers.
> >
> > Patch 1 and 2 addresses the issue of firmware nodes that look like
> > they'll have struct devices created for them, but will never actually
> > have struct devices added for them. For example, DT nodes with a
> > compatible property that don't have devices added for them.
> >
> > Patch 3 and 4 allow for handling optional DT bindings.
> >
> > Patch 5 sets up a generic API to handle drivers that never bind with
> > their devices.
> >
> > Patch 6 through 8 update different frameworks to use the new API.
> >
> > Thanks,
> > Saravana
> >
> > Saravana Kannan (8):
> >   driver core: fw_devlink: Detect supplier devices that will never be
> >     added
> >   of: property: Don't add links to absent suppliers
> >   driver core: Add fw_devlink.strict kernel param
> >   of: property: Add fw_devlink support for optional properties
> >   driver core: fw_devlink: Handle suppliers that don't use driver core
> >   irqdomain: Mark fwnodes when their irqdomain is added/removed
> >   PM: domains: Mark fwnodes when their powerdomain is added/removed
> >   clk: Mark fwnodes when their clock provider is added/removed
> >
> >  .../admin-guide/kernel-parameters.txt         |  5 ++
> >  drivers/base/core.c                           | 58 ++++++++++++++++++-
> >  drivers/base/power/domain.c                   |  2 +
> >  drivers/clk/clk.c                             |  3 +
> >  drivers/of/property.c                         | 16 +++--
> >  include/linux/fwnode.h                        | 20 ++++++-
> >  kernel/irq/irqdomain.c                        |  2 +
> >  7 files changed, 98 insertions(+), 8 deletions(-)
> >
>
> Even with this patch set applied, sama5d2_xplained can not boot.
> Patch at [1] makes sama5d2_xplained boot again. Stephen applied it
> to clk-next.

I'm glad you won't actually have any boot issues in 5.12, but the fact
you need [1] with this series doesn't make a lot of sense to me
because:

1. The FWNODE_FLAG_INITIALIZED flag will be set for the clock fwnode
in question way before any consumer devices are added.
2. Any consumer device added after (1) will stop trying to link to the
clock device.

Are you somehow adding a consumer to the clock fwnode before (1)?

Can you try this patch without your clk fix? I was trying to avoid
looping through a list, but looks like your case might somehow need
it?

-Saravana

+++ b/drivers/base/core.c
@@ -943,6 +943,31 @@ static void device_links_missing_supplier(struct
device *dev)
        }
 }

+static int fw_devlink_check_suppliers(struct device *dev)
+{
+       struct fwnode_link *link;
+       int ret = 0;
+
+       if (!dev->fwnode ||fw_devlink_is_permissive())
+               return 0;
+
+       /*
+        * Device waiting for supplier to become available is not allowed to
+        * probe.
+        */
+       mutex_lock(&fwnode_link_lock);
+       list_for_each_entry(link, &dev->fwnode->suppliers, c_hook) {
+               if (link->supplier->flags & FWNODE_FLAG_INITIALIZED)
+                       continue;
+
+               ret = -EPROBE_DEFER;
+               break;
+       }
+       mutex_unlock(&fwnode_link_lock);
+
+       return ret;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -964,21 +989,13 @@ int device_links_check_suppliers(struct device *dev)
        struct device_link *link;
        int ret = 0;

-       /*
-        * Device waiting for supplier to become available is not allowed to
-        * probe.
-        */
-       mutex_lock(&fwnode_link_lock);
-       if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
-           !fw_devlink_is_permissive()) {
+       if (fw_devlink_check_suppliers(dev)) {
                dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
                        list_first_entry(&dev->fwnode->suppliers,
                        struct fwnode_link,
                        c_hook)->supplier);
-               mutex_unlock(&fwnode_link_lock);
                return -EPROBE_DEFER;
        }
-       mutex_unlock(&fwnode_link_lock);

        device_links_write_lock();



>
> Cheers,
> ta
>
> [1] https://lore.kernel.org/lkml/20210203154332.470587-1-tudor.ambarus@microchip.com/
