Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEE3765553
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jul 2023 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjG0Nug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 27 Jul 2023 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjG0Nuf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jul 2023 09:50:35 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352FBFD
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 06:50:34 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56475c1b930so113307eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 06:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690465833; x=1691070633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL4iF1UXD5+MRF4jDdUcOvP3ePOAfKT+8xAjNzK3VjA=;
        b=a2HiimHCG/7f19FVXX0toUAvzYjkUlbPq9z9AqQe635XMxZ72cBxsyiK3/JbWlTPvC
         wz2ywHPnKGYsgA++LmundMpmNCCN1ITjZecp4NwGObe19B92IBhf2lUW1ipiMeNgayJO
         d/iLgJs2/qsf/SStxorshZPta0lEjR+qwIPJkyRShclk7ceQDTu4RBcca3YNrIFEjupF
         QOSH9vm6MbCOT7lsQE+GQ++gL6TO6M/pvEAU566bsyBYdcrJpyavxHTqWGuQFsniuRDv
         1hxuv4yXnqBIV6oqzYvlo2VCE6/yM2RsVqdJJ/HEM8zux7NKaDi6WUNXSP95NzzWYnYg
         mKCQ==
X-Gm-Message-State: ABy/qLa0ABzHEbC5E8ugig02djXhPBxMVa9/vI6lLUnonw+QJore259d
        wzNAOtM0kko/GzzJvgIme9B/UaQ2ZpsAeYgUUd4=
X-Google-Smtp-Source: APBJJlGwT8TF2jCRW3Jq6U0XyiX7mv9q9bgI97TsPOyJLRdW7tP4IxfHhwxgnrXl+bMqydMhqTeKEIk3xwRrFTxArcc=
X-Received: by 2002:a05:6820:1014:b0:560:b01a:653d with SMTP id
 v20-20020a056820101400b00560b01a653dmr3620385oor.0.1690465833341; Thu, 27 Jul
 2023 06:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230727133347.648102-1-sudeep.holla@arm.com>
In-Reply-To: <20230727133347.648102-1-sudeep.holla@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jul 2023 15:50:20 +0200
Message-ID: <CAJZ5v0heD9EG1Wi3ty17gsFJd1K7U1=BOCcPpicbN4L9BEzc5g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Move AMBA bus scan handling into arm64 specific directory
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 27, 2023 at 3:33 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
> initialisation into acpi_arm_init()") moved all of the ARM-specific
> initialization into acpi_arm_init(). However, acpi_amba.c being outside
> of drivers/acpi/arm64 got ignored and hence acpi_amba_init() was not
> moved into acpi_arm_init().
>
> Move the AMBA platform bus support into arm64 specific folder and make
> acpi_amba_init() part of acpi_arm_init().
>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to take care of this.

> ---
>  drivers/acpi/Makefile                      | 1 -
>  drivers/acpi/arm64/Makefile                | 1 +
>  drivers/acpi/{acpi_amba.c => arm64/amba.c} | 2 +-
>  drivers/acpi/arm64/init.c                  | 2 ++
>  drivers/acpi/arm64/init.h                  | 1 +
>  drivers/acpi/internal.h                    | 5 -----
>  drivers/acpi/scan.c                        | 1 -
>  7 files changed, 5 insertions(+), 8 deletions(-)
>  rename drivers/acpi/{acpi_amba.c => arm64/amba.c} (99%)
>
> Hi Rafael and others,
>
> While I was trying to just add drivers/acpi/acpi_amba.c under ACPI for
> ARM64 entry in the MAINTAINERS, I realised it could be moved as part of
> acpi_arm_init() which got completely missed last time. So I took that path
> instead of add the file in the entry explicitly.
>
> This may have to wait until the coresight changes land or if those changes
> can be applied as git understands the file movement this can be applied.
>
> Regards,
> Sudeep
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3fc5a0d54f6e..eaa09bf52f17 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -50,7 +50,6 @@ acpi-$(CONFIG_PCI)            += acpi_lpss.o
>  acpi-y                         += acpi_apd.o
>  acpi-y                         += acpi_platform.o
>  acpi-y                         += acpi_pnp.o
> -acpi-$(CONFIG_ARM_AMBA)        += acpi_amba.o
>  acpi-y                         += power.o
>  acpi-y                         += event.o
>  acpi-y                         += evged.o
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index f81fe24894b2..143debc1ba4a 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_ACPI_AGDI)         += agdi.o
>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
>  obj-$(CONFIG_ACPI_APMT)        += apmt.o
> +obj-$(CONFIG_ARM_AMBA)         += amba.o
>  obj-y                          += dma.o init.o
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/arm64/amba.c
> similarity index 99%
> rename from drivers/acpi/acpi_amba.c
> rename to drivers/acpi/arm64/amba.c
> index f5b443ab01c2..b2a7631d7ac7 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -17,7 +17,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>
> -#include "internal.h"
> +#include "init.h"
>
>  static const struct acpi_device_id amba_id_list[] = {
>         {"ARMH0061", 0}, /* PL061 GPIO Device */
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> index d3ce53dda122..d0c8aed90fd1 100644
> --- a/drivers/acpi/arm64/init.c
> +++ b/drivers/acpi/arm64/init.c
> @@ -10,4 +10,6 @@ void __init acpi_arm_init(void)
>                 acpi_apmt_init();
>         if (IS_ENABLED(CONFIG_ACPI_IORT))
>                 acpi_iort_init();
> +       if (IS_ENABLED(CONFIG_ARM_AMBA))
> +               acpi_amba_init();
>  }
> diff --git a/drivers/acpi/arm64/init.h b/drivers/acpi/arm64/init.h
> index a1715a2a34e9..dcc277977194 100644
> --- a/drivers/acpi/arm64/init.h
> +++ b/drivers/acpi/arm64/init.h
> @@ -4,3 +4,4 @@
>  void __init acpi_agdi_init(void);
>  void __init acpi_apmt_init(void);
>  void __init acpi_iort_init(void);
> +void __init acpi_amba_init(void);
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f4148dc50b9c..21ec31b78216 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -28,11 +28,6 @@ void acpi_processor_init(void);
>  void acpi_platform_init(void);
>  void acpi_pnp_init(void);
>  void acpi_int340x_thermal_init(void);
> -#ifdef CONFIG_ARM_AMBA
> -void acpi_amba_init(void);
> -#else
> -static inline void acpi_amba_init(void) {}
> -#endif
>  int acpi_sysfs_init(void);
>  void acpi_gpe_apply_masked_gpes(void);
>  void acpi_container_init(void);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5b145f1aaa1b..902763430d56 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2615,7 +2615,6 @@ void __init acpi_scan_init(void)
>         acpi_watchdog_init();
>         acpi_pnp_init();
>         acpi_int340x_thermal_init();
> -       acpi_amba_init();
>         acpi_init_lpit();
>
>         acpi_scan_add_handler(&generic_device_handler);
> --
> 2.41.0
>
