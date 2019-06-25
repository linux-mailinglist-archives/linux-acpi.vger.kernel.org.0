Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01655391
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfFYPia (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 11:38:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728823AbfFYPi3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jun 2019 11:38:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E4D1B2AF2A9A3DBB39C5;
        Tue, 25 Jun 2019 23:38:13 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 23:38:08 +0800
Date:   Tue, 25 Jun 2019 16:37:56 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <x86@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "kbuild test robot" <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <peterz@infradead.org>, <ard.biesheuvel@linaro.org>,
        <tglx@linutronix.de>, <linux-acpi@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/10] device-dax: Add a driver for "hmem" devices
Message-ID: <20190625163756.00001a85@huawei.com>
In-Reply-To: <156140041177.2951909.8582567579750505172.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156140041177.2951909.8582567579750505172.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 24 Jun 2019 11:20:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Platform firmware like EFI/ACPI may publish "hmem" platform devices.
> Such a device is a performance differentiated memory range likely
> reserved for an application specific use case. The driver gives access
> to 100% of the capacity via a device-dax mmap instance by default.
> 
> However, if over-subscription and other kernel memory management is
> desired the resulting dax device can be assigned to the core-mm via the
> kmem driver.
> 
> This consumes "hmem" devices the producer of "hmem" devices is saved for
> a follow-on patch so that it can reference the new CONFIG_DEV_DAX_HMEM
> symbol to gate performing the enumeration work.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
No need to have a remove function at all.  Otherwise this looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/dax/Kconfig    |   27 +++++++++++++++++++----
>  drivers/dax/Makefile   |    2 ++
>  drivers/dax/hmem.c     |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioport.h |    4 +++
>  4 files changed, 85 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/dax/hmem.c
> 
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index f33c73e4af41..1a59ef86f148 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -32,19 +32,36 @@ config DEV_DAX_PMEM
>  
>  	  Say M if unsure
>  
> +config DEV_DAX_HMEM
> +	tristate "HMEM DAX: direct access to 'specific purpose' memory"
> +	depends on EFI_APPLICATION_RESERVED
> +	default DEV_DAX
> +	help
> +	  EFI 2.8 platforms, and others, may advertise 'specific purpose'
> +	  memory.  For example, a high bandwidth memory pool. The
> +	  indication from platform firmware is meant to reserve the
> +	  memory from typical usage by default.  This driver creates
> +	  device-dax instances for these memory ranges, and that also
> +	  enables the possibility to assign them to the DEV_DAX_KMEM
> +	  driver to override the reservation and add them to kernel
> +	  "System RAM" pool.
> +
> +	  Say M if unsure.
> +
>  config DEV_DAX_KMEM
>  	tristate "KMEM DAX: volatile-use of persistent memory"
>  	default DEV_DAX
>  	depends on DEV_DAX
>  	depends on MEMORY_HOTPLUG # for add_memory() and friends
>  	help
> -	  Support access to persistent memory as if it were RAM.  This
> -	  allows easier use of persistent memory by unmodified
> -	  applications.
> +	  Support access to persistent, or other performance
> +	  differentiated memory as if it were System RAM. This allows
> +	  easier use of persistent memory by unmodified applications, or
> +	  adds core kernel memory services to heterogeneous memory types
> +	  (HMEM) marked "reserved" by platform firmware.
>  
>  	  To use this feature, a DAX device must be unbound from the
> -	  device_dax driver (PMEM DAX) and bound to this kmem driver
> -	  on each boot.
> +	  device_dax driver and bound to this kmem driver on each boot.
>  
>  	  Say N if unsure.
>  
> diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
> index 81f7d54dadfb..80065b38b3c4 100644
> --- a/drivers/dax/Makefile
> +++ b/drivers/dax/Makefile
> @@ -2,9 +2,11 @@
>  obj-$(CONFIG_DAX) += dax.o
>  obj-$(CONFIG_DEV_DAX) += device_dax.o
>  obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
> +obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
>  
>  dax-y := super.o
>  dax-y += bus.o
>  device_dax-y := device.o
> +dax_hmem-y := hmem.o
>  
>  obj-y += pmem/
> diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem.c
> new file mode 100644
> index 000000000000..62f9e3c80e21
> --- /dev/null
> +++ b/drivers/dax/hmem.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/platform_device.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/pfn_t.h>
> +#include "bus.h"
> +
> +static int dax_hmem_probe(struct platform_device *pdev)
> +{
> +	struct dev_pagemap pgmap = { NULL };
> +	struct device *dev = &pdev->dev;
> +	struct dax_region *dax_region;
> +	struct memregion_info *mri;
> +	struct dev_dax *dev_dax;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	mri = dev->platform_data;
> +	pgmap.dev = dev;
> +	memcpy(&pgmap.res, res, sizeof(*res));
> +
> +	dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
> +			PMD_SIZE, PFN_DEV|PFN_MAP);
> +	if (!dax_region)
> +		return -ENOMEM;
> +
> +	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
> +	if (IS_ERR(dev_dax))
> +		return PTR_ERR(dev_dax);
> +
> +	/* child dev_dax instances now own the lifetime of the dax_region */
> +	dax_region_put(dax_region);
> +	return 0;
> +}
> +
> +static int dax_hmem_remove(struct platform_device *pdev)
> +{
> +	/* devm handles teardown */
> +	return 0;

Why have a remove at all?  driver/base/platform.c has
the appropriate protections to allow you to not provide one.
If you want the comment, just put it after .probe =
below.

> +}
> +
> +static struct platform_driver dax_hmem_driver = {
> +	.probe = dax_hmem_probe,
> +	.remove = dax_hmem_remove,
> +	.driver = {
> +		.name = "hmem",
> +	},
> +};
> +
> +module_platform_driver(dax_hmem_driver);
> +
> +MODULE_ALIAS("platform:hmem*");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 72ea690b35a4..0c529c8f8027 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -294,6 +294,10 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>  }
>  
>  #ifdef CONFIG_MEMREGION
> +struct memregion_info {
> +	int target_node;
> +};
> +
>  extern struct ida memregion_ids;
>  static inline int memregion_alloc(gfp_t gfp)
>  {
> 


