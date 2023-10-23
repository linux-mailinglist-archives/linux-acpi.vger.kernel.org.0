Return-Path: <linux-acpi+bounces-840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F547D301C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DEF1C208D6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FB14A97
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60523C5
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 08:53:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DFBCA9;
	Mon, 23 Oct 2023 01:53:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6349C2F4;
	Mon, 23 Oct 2023 01:54:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9893F64C;
	Mon, 23 Oct 2023 01:53:22 -0700 (PDT)
Date: Mon, 23 Oct 2023 09:53:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
	<ksitaraman@nvidia.com>, <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
Message-ID: <ZTY0gMOAKbugxDIJ@bogus>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014105426.26389-3-sumitg@nvidia.com>

On Sat, Oct 14, 2023 at 04:24:26PM +0530, Sumit Gupta wrote:
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
>  drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>  drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>  include/linux/acpi.h                 |  9 +++++++
>  4 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..3f181d8156cc 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
>  obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
>  obj-$(CONFIG_ARM_AMBA)		+= amba.o
>  obj-y				+= dma.o init.o
> +obj-$(CONFIG_ACPI)		+= thermal_cpufreq.o

Do we really need CONFIG_ACPI here ? We won't be building this if it
is not enabled.

If this is for some module building, then does it make sense to have
more specific config ? May be CONFIG_ACPI_THERMAL ?

> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
> new file mode 100644
> index 000000000000..de834fb013e7
> --- /dev/null
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +#define SMCCC_SOC_ID_T241      0x036b0241
> +
> +int acpi_thermal_cpufreq_pctg(void)
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

Since this looks like arch specific hook/callback, not sure if it is good
idea to have "arch_" in the function name. But if Rafael is OK with the name
I am fine with this as well.

--
Regards,
Sudeep

