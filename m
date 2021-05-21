Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA138CB2C
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhEUQk7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 12:40:59 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33512 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbhEUQk6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 12:40:58 -0400
Received: by mail-oi1-f178.google.com with SMTP id b25so20253899oic.0
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 09:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L/RoK6wup09rAoEsvKy77fTqf/Hy3G7bB4uSc9Jrfo=;
        b=FQk3sqJ6gUTFNM4KAVlW3GYUUM5a+yTrxFXyonJYpMtCOoh8w84GQLR17sv3VeYm2q
         EyiZFtw2Xw8ZudSv/Ff0kXMh4ZscK8g8XAjPMgtfVEY2kO4HE/fpmH3HpMNDadS09pCr
         tBgW0sUpr3GPm0S8qIyke9hpW/iEEwzAaotYaihn9GsIF1MunndhcA2DSkatTruWcUK+
         yuStyfF+BtUFrXkMQcMzu+Rk7M8XGBF2QYtqomIB0TNQ0zNt9v8kZpf3PykusMUuWHwB
         KyZ8fdYUnYgyAiY9q4GMVgJj//MCbEhIJqJ7zzfOJi1xhVRoU8UWkuf/PKDrMMj/fwAD
         01MA==
X-Gm-Message-State: AOAM5329Kb1zyJ05/bHqEwxaX4KVIBpSmINxcqJ0lkDExAgpBxzZ7ZgU
        Vow9Ut1fakgn6flQV3JIWEto+oIMLAqQWNxmL34=
X-Google-Smtp-Source: ABdhPJybUpZcko8bDzbsYB0EWlv5wAQPE40mmkviuVqrnlJf1vsIP3osFfCJr1yxVSlO/8tJbLKE8TlBsZTeC8zPyhw=
X-Received: by 2002:aca:4758:: with SMTP id u85mr2840877oia.71.1621615175113;
 Fri, 21 May 2021 09:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210423113836.3974972-1-jean-philippe@linaro.org> <20210423113836.3974972-4-jean-philippe@linaro.org>
In-Reply-To: <20210423113836.3974972-4-jean-philippe@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 18:39:24 +0200
Message-ID: <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: Add driver for the VIOT table
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The ACPI Virtual I/O Translation Table describes topology of
> para-virtual platforms, similarly to vendor tables DMAR, IVRS and IORT.
> For now it describes the relation between virtio-iommu and the endpoints
> it manages.
>
> Three steps are needed to configure DMA of endpoints:
>
> (1) acpi_viot_init(): parse the VIOT table, find or create the fwnode
>     associated to each vIOMMU device.
>
> (2) When probing the vIOMMU device, the driver registers its IOMMU ops
>     within the IOMMU subsystem. This step doesn't require any
>     intervention from the VIOT driver.
>
> (3) viot_iommu_configure(): before binding the endpoint to a driver,
>     find the associated IOMMU ops. Register them, along with the
>     endpoint ID, into the device's iommu_fwspec.
>
> If step (3) happens before step (2), it is deferred until the IOMMU is
> initialized, then retried.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/Kconfig      |   3 +
>  drivers/iommu/Kconfig     |   1 +
>  drivers/acpi/Makefile     |   2 +
>  include/linux/acpi_viot.h |  19 +++
>  drivers/acpi/bus.c        |   2 +
>  drivers/acpi/scan.c       |   3 +
>  drivers/acpi/viot.c       | 350 ++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS               |   8 +
>  8 files changed, 388 insertions(+)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/viot.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index eedec61e3476..3758c6940ed7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -526,6 +526,9 @@ endif
>
>  source "drivers/acpi/pmic/Kconfig"
>
> +config ACPI_VIOT
> +       bool
> +
>  endif  # ACPI
>
>  config X86_PM_TIMER
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1f111b399bca..aff8a4830dd1 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -403,6 +403,7 @@ config VIRTIO_IOMMU
>         depends on ARM64
>         select IOMMU_API
>         select INTERVAL_TREE
> +       select ACPI_VIOT if ACPI
>         help
>           Para-virtualised IOMMU driver with virtio.
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 700b41adf2db..a6e644c48987 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -118,3 +118,5 @@ video-objs                  += acpi_video.o video_detect.o
>  obj-y                          += dptf/
>
>  obj-$(CONFIG_ARM64)            += arm64/
> +
> +obj-$(CONFIG_ACPI_VIOT)                += viot.o
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> new file mode 100644
> index 000000000000..1eb8ee5b0e5f
> --- /dev/null
> +++ b/include/linux/acpi_viot.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ACPI_VIOT_H__
> +#define __ACPI_VIOT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_VIOT
> +void __init acpi_viot_init(void);
> +int viot_iommu_configure(struct device *dev);
> +#else
> +static inline void acpi_viot_init(void) {}
> +static inline int viot_iommu_configure(struct device *dev)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif /* __ACPI_VIOT_H__ */
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..b835ca702ff0 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -27,6 +27,7 @@
>  #include <linux/dmi.h>
>  #endif
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
> @@ -1339,6 +1340,7 @@ static int __init acpi_init(void)
>         pci_mmcfg_late_init();
>         acpi_iort_init();
>         acpi_scan_init();
> +       acpi_viot_init();
>         acpi_ec_init();
>         acpi_debugfs_init();
>         acpi_sleep_proc_init();
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5924421075f6..4db43c822ee7 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -9,6 +9,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
>  #include <linux/signal.h>
>  #include <linux/kthread.h>
> @@ -1554,6 +1555,8 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>                 return ops;
>
>         err = iort_iommu_configure_id(dev, id_in);
> +       if (err && err != -EPROBE_DEFER)
> +               err = viot_iommu_configure(dev);
>
>         /*
>          * If we have reason to believe the IOMMU driver missed the initial
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> new file mode 100644
> index 000000000000..710e5a5eac70
> --- /dev/null
> +++ b/drivers/acpi/viot.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Virtual I/O topology

In the first place, more information on what this is all about, please.

What it does and how it is used.
