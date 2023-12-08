Return-Path: <linux-acpi+bounces-2231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C580A92E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4861F1F210DD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE838DF7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:35:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 493E41732;
	Fri,  8 Dec 2023 07:31:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CE9D106F;
	Fri,  8 Dec 2023 07:32:21 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 527983F6C4;
	Fri,  8 Dec 2023 07:31:34 -0800 (PST)
Message-ID: <22cfb197-b8bd-46c5-f3cb-ea04b95c0792@arm.com>
Date: Fri, 8 Dec 2023 15:31:32 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 08/10] coresight: tmc: Move ACPI support from AMBA
 driver to platform driver
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
 <20231208053939.42901-9-anshuman.khandual@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231208053939.42901-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/12/2023 05:39, Anshuman Khandual wrote:
> Add support for the tmc devices in the platform driver, which can then be
> used on ACPI based platforms. This change would now allow runtime power
> management for ACPI based systems. The driver would try to enable the APB
> clock if available.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
> 
> - Added commnets for 'drvdata->pclk'
> - Used coresight_init_driver()/coresight_remove_driver() helpers instead
> - Dropped pm_runtime_put() from __tmc_probe()
> - Added pm_runtime_put() on success path in tmc_probe()
> - Added pm_runtime_put() on success/error paths in tmc_platform_probe()
> - Check for drvdata instead of drvdata->pclk in suspend and resume paths
> 
>  drivers/acpi/arm64/amba.c                     |   2 -
>  .../hwtracing/coresight/coresight-tmc-core.c  | 137 ++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>  3 files changed, 124 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 6d24a8f7914b..d3c1defa7bc8 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -22,10 +22,8 @@
>  static const struct acpi_device_id amba_id_list[] = {
>  	{"ARMH0061", 0}, /* PL061 GPIO Device */
>  	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
> -	{"ARMHC501", 0}, /* ARM CoreSight ETR */
>  	{"ARMHC502", 0}, /* ARM CoreSight STM */
>  	{"ARMHC503", 0}, /* ARM CoreSight Debug */
> -	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
>  	{"", 0},
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index ad61d02f5f75..8482830d73ef 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -23,6 +23,8 @@
>  #include <linux/of.h>
>  #include <linux/coresight.h>
>  #include <linux/amba/bus.h>
> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
>  
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
> @@ -437,24 +439,17 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
>  	return burst_size;
>  }
>  
> -static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
> +static int __tmc_probe(struct device *dev, struct resource *res, void *dev_caps)

I don't think the dev_caps argument is used anymore since the v3 changes.


