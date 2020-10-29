Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3429F2B0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgJ2RLM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 13:11:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41442 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RLL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 13:11:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so3758200oih.8;
        Thu, 29 Oct 2020 10:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daqWqpuDAfNvpsbFGrqlJS2OI1IH2cY0LSZL5HwouxY=;
        b=Rrd7qFNrzEp6vGBpB87IFNbHrGZtZB72NGv8IkhCDchUSphyjedGKCTPMeopNS3JUm
         6WypartV0bO5ib2vB6eWSzF1xFaXzPVWT1jXoDQgS8Cg8Sae/geCoR1QgyAYl9XUmfDi
         zMoklLc7P7DHzU5F9A1G90j5K6rEofSbop/x/p2R27KOcbwLG3LMceT3i7IErXkudGVc
         ZMKgMI2HQmV/7lhfuEjsV6d2M/4qpVAeWIwt2dXIr/rnqcwh1j4HwaeYDoSyNVZCymbk
         fB4p4Ia2cc7/9wF9BXH4loTkz/k6B7JUhBMOFprNHu9H5TNL0HqVcj3pGQLIc3/rDw3J
         sx9A==
X-Gm-Message-State: AOAM531qkabFLgo2s/HRyWOiHXVwcBte1qkTehD5PHg1w+bePtxI9g7M
        NWCO2Yimdh3meIxLXjQSbyjKBgIxwN/k4cwnIGk=
X-Google-Smtp-Source: ABdhPJxHVLwwaj1HwM4KZ9eyEvCl8ngRu7uMhbpv0LI+oGCoQ46ibTmoYRFfdTtjLYGqMg4AKXDfDLyLRRFixn1sRxw=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr441009oiw.69.1603991470287;
 Thu, 29 Oct 2020 10:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com> <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 18:10:59 +0100
Message-ID: <CAJZ5v0gc6ihoNuh5eR4MW+uf9CBH=qoRjGeeOHxgvjmUnorPCg@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 11:59 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The software node specific PM operations make it possible to
> handle most PM related quirks separately in their own
> functions instead of conditionally in the device driver's
> generic PM functions (and in some cases all over the
> driver). The software node specific PM operations will also
> reduce the need to pass platform data in some cases, for
> example from a core MFD driver to the child device drivers,
> as from now on the core MFD driver will be able to implement
> the PM quirks directly for the child devices without the
> need to touch the drivers of those child devices.
>
> If a software node includes the PM operations, those PM
> operations are always executed separately on top of the
> other PM operations of the device, so the software node will
> never replace any of the "normal" PM operations of the
> device (including the PM domain's operations, class's or
> bus's PM operations, the device drivers own operations, or
> any other).
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/base/power/common.c |   8 +-
>  drivers/base/swnode.c       | 693 +++++++++++++++++++++++++++++++++++-
>  include/linux/property.h    |  10 +
>  3 files changed, 701 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index bbddb267c2e69..b64cd4690ac63 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -109,8 +109,14 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>         ret = acpi_dev_pm_attach(dev, power_on);
>         if (!ret)
>                 ret = genpd_dev_pm_attach(dev);
> +       if (ret < 0)
> +               return ret;
>
> -       return ret < 0 ? ret : 0;
> +       ret = software_node_dev_pm_attach(dev, power_on);
> +       if (ret)
> +               dev_pm_domain_detach(dev, power_on);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 010828fc785bc..595a9c240fede 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -8,6 +8,8 @@
>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>
> @@ -48,6 +50,19 @@ EXPORT_SYMBOL_GPL(is_software_node);
>                                      struct swnode, fwnode) : NULL;     \
>         })
>
> +static inline struct swnode *dev_to_swnode(struct device *dev)
> +{
> +       struct fwnode_handle *fwnode = dev_fwnode(dev);
> +
> +       if (!fwnode)
> +               return NULL;
> +
> +       if (!is_software_node(fwnode))
> +               fwnode = fwnode->secondary;
> +
> +       return to_swnode(fwnode);
> +}
> +
>  static struct swnode *
>  software_node_to_swnode(const struct software_node *node)
>  {
> @@ -344,6 +359,673 @@ void property_entries_free(const struct property_entry *properties)
>  }
>  EXPORT_SYMBOL_GPL(property_entries_free);
>
> +/* -------------------------------------------------------------------------- */
> +/* Power management operations */
> +
> +/*
> + * The power management operations in software nodes are handled with a power
> + * management domain - a "wrapper" PM domain:
> + *
> + *   When PM operations are supplied as part of the software node, the primary
> + *   PM domain of the device is stored and replaced with a device specific
> + *   software node PM domain. The software node PM domain's PM operations, which
> + *   are implemented below, will then always call the matching PM operation of
> + *   the primary PM domain (which was stored) on top of the software node's own
> + *   operation.
> + *
> + * If the device does not have primary PM domain, the software node PM wrapper
> + * operations below will also call the classes, buses and device type's PM
> + * operations, and of course the device driver's own PM operations if they are
> + * implemented. The priority of those calls follows drivers/base/power/domain.c:
> + *
> + * 1) device type
> + * 2) class
> + * 3) bus
> + * 4) driver
> + *
> + * NOTE. The software node PM operation is always called before the primary
> + * PM domain with resume/on callbacks, and after the primary PM domain with
> + * suspend/off callbacks. This order is used because the software node PM
> + * operations are primarily meant to be used to implement quirks, quirks that
> + * may be needed to power on the device to a point where it is even possible to
> + * execute the primary PM domain's resume/on routines.
> + */

Well, this basically implements a wrapper PM domain that is somewhat
more generic, as a concept, then software nodes PM.

At least it is not specific to software nodes, so I'd prefer it to be
defined generically.

Moreover, IIUC, this breaks if the "primary" PM domain callbacks try
to get to the original PM domain via the dev->pm_domain pointer, which
the genpd callbacks do.

Do we want to wrap the ACPI PM domain only, by any chance?  If so, it
may be more straightforward to invoke swnode callbacks directly from
there, if any.
