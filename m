Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48C7245DC
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jun 2023 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjFFO0g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 6 Jun 2023 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjFFO0f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 10:26:35 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04A172B
        for <linux-acpi@vger.kernel.org>; Tue,  6 Jun 2023 07:26:20 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-977d3292be0so79787666b.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Jun 2023 07:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061579; x=1688653579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t4yIEoFlfQl890o87hoE4P1c/Yo42+LiMBwFAuCP/Y=;
        b=eXPGzYC/WHjwArYULijJ9Fw1W6pbmKkJN/EkNLdS3r+RqnWLNHgYMm4rvCmuqqW0Mk
         /Ir4eZM1xXgRjVTPqwydvj7T2EjPSX4Wbrql14E2lLDJdl1TwIeAmJsIeB+/xfjy37e+
         2D+ed8nZss2w6WNrWcXURoQcQBpYdCa3VScqL1bNDLi5KvN4/GNO8jwTj8ysNGGexRin
         nNjbDn0rch5M00q6HULZnUttiufW4YZU4sD7Az4FuV+jBSS78uClB1kpoMZbnYBRdmsU
         993paOt8vu5SaXUhJ6My1qnLBwM/v6gO0FfMW4HSl/1IpBp+rvq+rHytOYPg2RvlUeGk
         qiSQ==
X-Gm-Message-State: AC+VfDyuv5Ai7sWPyGA5LVxVxyNhE/3LwAVw1BEKL42+4+v3zepnwWAQ
        IDOnJUTEKyV9cAJCTbQ7mUz/vjmq9PFsRv2hhs0=
X-Google-Smtp-Source: ACHHUZ6q3KUj31Wllv9eCkP+lAmxB36autuSIoYTfnOQ+keCPaVChuxnMEOw1/YeGhvhcOQ6RXeQphAvy9H6KofKHdk=
X-Received: by 2002:a17:906:1c7:b0:94e:9efa:a9ed with SMTP id
 7-20020a17090601c700b0094e9efaa9edmr2940539ejj.7.1686061579161; Tue, 06 Jun
 2023 07:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
In-Reply-To: <20230606093531.2746732-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Jun 2023 16:26:06 +0200
Message-ID: <CAJZ5v0g2JJVgTrtBH0CbcVXWav5Z5kfVSktEa6iVHWuqgiuunw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific initialisation
 into acpi_arm_init()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 6, 2023 at 11:35 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Move all of the ARM-specific initialization into one function namely
> acpi_arm_init(), so it is not necessary to modify/update bus.c every
> time a new piece of it is added.
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

or please let me know if you want me to pick this up.

> ---
>  drivers/acpi/arm64/Makefile |  2 +-
>  drivers/acpi/arm64/agdi.c   |  2 +-
>  drivers/acpi/arm64/apmt.c   |  2 +-
>  drivers/acpi/arm64/init.c   | 13 +++++++++++++
>  drivers/acpi/arm64/init.h   |  6 ++++++
>  drivers/acpi/arm64/iort.c   |  1 +
>  drivers/acpi/bus.c          |  7 +------
>  include/linux/acpi.h        |  6 ++++++
>  include/linux/acpi_agdi.h   | 13 -------------
>  include/linux/acpi_apmt.h   | 19 -------------------
>  include/linux/acpi_iort.h   |  2 --
>  11 files changed, 30 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/acpi/arm64/init.c
>  create mode 100644 drivers/acpi/arm64/init.h
>  delete mode 100644 include/linux/acpi_agdi.h
>  delete mode 100644 include/linux/acpi_apmt.h
>
> v1[1]->v2:
>         - Used IS_ENABLED and made the init functions' declarations
>           unconditional
>         - Added review tags
>
> [1] https://lore.kernel.org/all/20230605103550.2427459-1-sudeep.holla@arm.com
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index e21a9e84e394..f81fe24894b2 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_ACPI_AGDI)         += agdi.o
>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
>  obj-$(CONFIG_ACPI_APMT)        += apmt.o
> -obj-y                          += dma.o
> +obj-y                          += dma.o init.o
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index f605302395c3..8b3c7d42b41b 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -9,11 +9,11 @@
>  #define pr_fmt(fmt) "ACPI: AGDI: " fmt
>
>  #include <linux/acpi.h>
> -#include <linux/acpi_agdi.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include "init.h"
>
>  struct agdi_data {
>         int sdei_event;
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> index 8cab69fa5d59..e5c3bc99fc79 100644
> --- a/drivers/acpi/arm64/apmt.c
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -10,10 +10,10 @@
>  #define pr_fmt(fmt)    "ACPI: APMT: " fmt
>
>  #include <linux/acpi.h>
> -#include <linux/acpi_apmt.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
> +#include "init.h"
>
>  #define DEV_NAME "arm-cs-arch-pmu"
>
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> new file mode 100644
> index 000000000000..d3ce53dda122
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +#include "init.h"
> +
> +void __init acpi_arm_init(void)
> +{
> +       if (IS_ENABLED(CONFIG_ACPI_AGDI))
> +               acpi_agdi_init();
> +       if (IS_ENABLED(CONFIG_ACPI_APMT))
> +               acpi_apmt_init();
> +       if (IS_ENABLED(CONFIG_ACPI_IORT))
> +               acpi_iort_init();
> +}
> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> new file mode 100644
> index 000000000000..a1715a2a34e9
> --- /dev/null
> +++ b/drivers/acpi/arm64/init.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include <linux/init.h>
> +
> +void __init acpi_agdi_init(void);
> +void __init acpi_apmt_init(void);
> +void __init acpi_iort_init(void);
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 38fb84974f35..3631230a61c8 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include "init.h"
>
>  #define IORT_TYPE_MASK(type)   (1 << (type))
>  #define IORT_MSI_TYPE          (1 << ACPI_IORT_NODE_ITS_GROUP)
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index d161ff707de4..7a1eaf8c7bde 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -26,9 +26,6 @@
>  #include <asm/mpspec.h>
>  #include <linux/dmi.h>
>  #endif
> -#include <linux/acpi_agdi.h>
> -#include <linux/acpi_apmt.h>
> -#include <linux/acpi_iort.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
> @@ -1408,7 +1405,7 @@ static int __init acpi_init(void)
>         acpi_init_ffh();
>
>         pci_mmcfg_late_init();
> -       acpi_iort_init();
> +       acpi_arm_init();
>         acpi_viot_early_init();
>         acpi_hest_init();
>         acpi_ghes_init();
> @@ -1420,8 +1417,6 @@ static int __init acpi_init(void)
>         acpi_debugger_init();
>         acpi_setup_sb_notify_handler();
>         acpi_viot_init();
> -       acpi_agdi_init();
> -       acpi_apmt_init();
>         return 0;
>  }
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 7b71dd74baeb..5ef126a0a50f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1507,6 +1507,12 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  }
>  #endif
>
> +#ifdef CONFIG_ARM64
> +void acpi_arm_init(void);
> +#else
> +static inline void acpi_arm_init(void) { }
> +#endif
> +
>  #ifdef CONFIG_ACPI_PCC
>  void acpi_init_pcc(void);
>  #else
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
>  void iort_deregister_domain_token(int trans_id);
>  struct fwnode_handle *iort_find_domain_token(int trans_id);
>  #ifdef CONFIG_ACPI_IORT
> -void acpi_iort_init(void);
>  u32 iort_msi_map_id(struct device *dev, u32 id);
>  struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>                                           enum irq_domain_bus_token bus_token);
> @@ -43,7 +42,6 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
> -static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
>  { return id; }
>  static inline struct irq_domain *iort_get_device_domain(
> --
> 2.40.1
>
