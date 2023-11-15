Return-Path: <linux-acpi+bounces-1404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ACE7E7B72
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635E41C2080C
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEF11B28F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DC13ADA
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 10:16:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560D686AD;
	Fri, 10 Nov 2023 02:16:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795A8106F;
	Fri, 10 Nov 2023 02:17:27 -0800 (PST)
Received: from bogus (unknown [10.57.41.96])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E873F6C4;
	Fri, 10 Nov 2023 02:16:39 -0800 (PST)
Date: Fri, 10 Nov 2023 10:15:07 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, lpieralisi@kernel.org,
	guohanjun@huawei.com, linux-acpi@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, treding@nvidia.com,
	jonathanh@nvidia.com, bbasu@nvidia.com, sanjayc@nvidia.com,
	ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
Subject: Re: [Patch v6 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <20231110101507.GB1505974@bogus>
References: <20231109183322.28039-1-sumitg@nvidia.com>
 <20231109183322.28039-3-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109183322.28039-3-sumitg@nvidia.com>

On Fri, Nov 10, 2023 at 12:03:22AM +0530, Sumit Gupta wrote:
> From: Srikar Srimath Tirumala <srikars@nvidia.com>
> 
> Current implementation of processor_thermal performs software throttling
> in fixed steps of "20%" which can be too coarse for some platforms.
> We observed some performance gain after reducing the throttle percentage.
> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
> to be configurable. Also, update the default values of both for Nvidia
> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
> and accordingly the maximum number of thermal steps are increased as they
> are derived from the reduction percentage.
> 
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/arm64/Makefile          |  1 +
>  drivers/acpi/arm64/thermal_cpufreq.c | 22 +++++++++++++
>  drivers/acpi/internal.h              |  9 +++++
>  drivers/acpi/processor_thermal.c     | 49 +++++++++++++++++++++++-----
>  4 files changed, 72 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
> 
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..726944648c9b 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>  obj-$(CONFIG_ARM_AMBA)		+= amba.o
>  obj-y				+= dma.o init.o
> +obj-y				+= thermal_cpufreq.o
> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
> new file mode 100644
> index 000000000000..40d5806ed528
> --- /dev/null
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +
> +#include "../internal.h"
> +
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +#define SMCCC_SOC_ID_T241      0x036b0241

Sorry for missing this earlier. Not sure if the above define needs to be
conditional. Even if it has to be, CONFIG_ARM_SMCCC_SOC_ID is more
appropriate.

> +
> +int acpi_arch_thermal_cpufreq_pctg(void)
> +{
> +	s32 soc_id = arm_smccc_get_soc_id_version();
> +
> +	/*
> +	 * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
> +	 * reduce the CPUFREQ Thermal reduction percentage to 5%.
> +	 */
> +	if (soc_id == SMCCC_SOC_ID_T241)
> +		return 5;
> +
> +	return 0;
> +}
> +#endif
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed233..ee213a8cddc5 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -85,6 +85,15 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
>  acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
>  void acpi_scan_table_notify(void);
>  
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY

It looks weird to add a such specific ARM config option in generic ACPI
code/header.

Does it make sense to add some new config this new feature you are adding
or just use ARM64 and have CONFIG_HAVE_ARM_SMCCC_DISCOVERY check internally
in the arch specific call.

-- 
Regards,
Sudeep

