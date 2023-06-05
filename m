Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC3722AEC
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jun 2023 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjFEPYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jun 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjFEPYO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Jun 2023 11:24:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0696DD2
        for <linux-acpi@vger.kernel.org>; Mon,  5 Jun 2023 08:24:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51A44D75;
        Mon,  5 Jun 2023 08:24:58 -0700 (PDT)
Received: from [10.57.85.135] (unknown [10.57.85.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF903F663;
        Mon,  5 Jun 2023 08:24:11 -0700 (PDT)
Message-ID: <cddea4a2-79ec-ab3e-2e67-be3a2e10824c@arm.com>
Date:   Mon, 5 Jun 2023 16:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ACPI: bus: Consolidate all arm specific initialisation
 into acpi_arm_init()
Content-Language: en-GB
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20230605103550.2427459-1-sudeep.holla@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230605103550.2427459-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-06-05 11:35, Sudeep Holla wrote:
> Move all of the ARM-specific initialization into one function namely
> acpi_arm_init(), so it is not necessary to modify/update bus.c every
> time a new piece of it is added.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/acpi/arm64/Makefile |  2 +-
>   drivers/acpi/arm64/agdi.c   |  2 +-
>   drivers/acpi/arm64/apmt.c   |  2 +-
>   drivers/acpi/arm64/init.c   | 10 ++++++++++
>   drivers/acpi/arm64/init.h   | 20 ++++++++++++++++++++
>   drivers/acpi/arm64/iort.c   |  1 +
>   drivers/acpi/bus.c          |  7 +------
>   include/linux/acpi.h        |  6 ++++++
>   include/linux/acpi_agdi.h   | 13 -------------
>   include/linux/acpi_apmt.h   | 19 -------------------
>   include/linux/acpi_iort.h   |  2 --
>   11 files changed, 41 insertions(+), 43 deletions(-)
>   create mode 100644 drivers/acpi/arm64/init.c
>   create mode 100644 drivers/acpi/arm64/init.h
>   delete mode 100644 include/linux/acpi_agdi.h
>   delete mode 100644 include/linux/acpi_apmt.h
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index e21a9e84e394..f81fe24894b2 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
>   obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>   obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>   obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
> -obj-y				+= dma.o
> +obj-y				+= dma.o init.o
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index f605302395c3..8b3c7d42b41b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -9,11 +9,11 @@
>   #define pr_fmt(fmt) "ACPI: AGDI: " fmt
>   
>   #include <linux/acpi.h>
> -#include <linux/acpi_agdi.h>
>   #include <linux/arm_sdei.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/platform_device.h>
> +#include "init.h"
>   
>   struct agdi_data {
>   	int sdei_event;
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..e5c3bc99fc79 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -10,10 +10,10 @@
>   #define pr_fmt(fmt)	"ACPI: APMT: " fmt
>   
>   #include <linux/acpi.h>
> -#include <linux/acpi_apmt.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/platform_device.h>
> +#include "init.h"
>   
>   #define DEV_NAME "arm-cs-arch-pmu"
>   
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> new file mode 100644
> index 000000000000..b4f6ba1c8ef1
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include "init.h"
> +
> +void __init acpi_arm_init(void)
> +{
> +	acpi_agdi_init();
> +	acpi_apmt_init();
> +	acpi_iort_init();
> +}
> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> new file mode 100644
> index 000000000000..85b0541ce3cc
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include <linux/init.h>
> +
> +#ifdef CONFIG_ACPI_AGDI
> +void acpi_agdi_init(void);
> +#else
> +static inline void acpi_agdi_init(void) { }
> +#endif /* CONFIG_ACPI_AGDI */

Hmm, I wonder if it might be any nicer to make the declarations 
unconditional and guard the calls in "if (IS_ENABLED(...))" instead. No 
particular preference, just musing - either way this looks like a 
sensible refactor, so FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +
> +#ifdef CONFIG_ACPI_APMT
> +void acpi_apmt_init(void);
> +#else
> +static inline void acpi_apmt_init(void) { }
> +#endif /* CONFIG_ACPI_APMT */
> +
> +#ifdef CONFIG_ACPI_IORT
> +void acpi_iort_init(void);
> +#else
> +static inline void acpi_iort_init(void) { }
> +#endif /* CONFIG_ACPI_IORT */
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 38fb84974f35..3631230a61c8 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -19,6 +19,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/dma-map-ops.h>
> +#include "init.h"
>   
>   #define IORT_TYPE_MASK(type)	(1 << (type))
>   #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index d161ff707de4..7a1eaf8c7bde 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -26,9 +26,6 @@
>   #include <asm/mpspec.h>
>   #include <linux/dmi.h>
>   #endif
> -#include <linux/acpi_agdi.h>
> -#include <linux/acpi_apmt.h>
> -#include <linux/acpi_iort.h>
>   #include <linux/acpi_viot.h>
>   #include <linux/pci.h>
>   #include <acpi/apei.h>
> @@ -1408,7 +1405,7 @@ static int __init acpi_init(void)
>   	acpi_init_ffh();
>   
>   	pci_mmcfg_late_init();
> -	acpi_iort_init();
> +	acpi_arm_init();
>   	acpi_viot_early_init();
>   	acpi_hest_init();
>   	acpi_ghes_init();
> @@ -1420,8 +1417,6 @@ static int __init acpi_init(void)
>   	acpi_debugger_init();
>   	acpi_setup_sb_notify_handler();
>   	acpi_viot_init();
> -	acpi_agdi_init();
> -	acpi_apmt_init();
>   	return 0;
>   }
>   
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7b71dd74baeb..5ef126a0a50f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1507,6 +1507,12 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>   }
>   #endif
>   
> +#ifdef CONFIG_ARM64
> +void acpi_arm_init(void);
> +#else
> +static inline void acpi_arm_init(void) { }
> +#endif
> +
>   #ifdef CONFIG_ACPI_PCC
>   void acpi_init_pcc(void);
>   #else
> diff --git a/include/linux/acpi_agdi.h b/include/linux/acpi_agdi.h
> deleted file mode 100644
> index f477f0b452fa..000000000000
> --- a/include/linux/acpi_agdi.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -
> -#ifndef __ACPI_AGDI_H__
> -#define __ACPI_AGDI_H__
> -
> -#include <linux/acpi.h>
> -
> -#ifdef CONFIG_ACPI_AGDI
> -void __init acpi_agdi_init(void);
> -#else
> -static inline void acpi_agdi_init(void) {}
> -#endif
> -#endif /* __ACPI_AGDI_H__ */
> diff --git a/include/linux/acpi_apmt.h b/include/linux/acpi_apmt.h
> deleted file mode 100644
> index 40bd634d082f..000000000000
> --- a/include/linux/acpi_apmt.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0
> - *
> - * ARM CoreSight PMU driver.
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> - *
> - */
> -
> -#ifndef __ACPI_APMT_H__
> -#define __ACPI_APMT_H__
> -
> -#include <linux/acpi.h>
> -
> -#ifdef CONFIG_ACPI_APMT
> -void acpi_apmt_init(void);
> -#else
> -static inline void acpi_apmt_init(void) { }
> -#endif /* CONFIG_ACPI_APMT */
> -
> -#endif /* __ACPI_APMT_H__ */
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index b43be0987b19..e4e7bb6fa720 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -27,7 +27,6 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
>   void iort_deregister_domain_token(int trans_id);
>   struct fwnode_handle *iort_find_domain_token(int trans_id);
>   #ifdef CONFIG_ACPI_IORT
> -void acpi_iort_init(void);
>   u32 iort_msi_map_id(struct device *dev, u32 id);
>   struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>   					  enum irq_domain_bus_token bus_token);
> @@ -43,7 +42,6 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>   void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>   #else
> -static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
>   { return id; }
>   static inline struct irq_domain *iort_get_device_domain(
