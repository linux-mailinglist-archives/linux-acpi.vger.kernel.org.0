Return-Path: <linux-acpi+bounces-2261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A6B80C264
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 08:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A2E280D1B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4A208D4;
	Mon, 11 Dec 2023 07:51:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E50DAFC;
	Sun, 10 Dec 2023 23:51:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170881007;
	Sun, 10 Dec 2023 23:52:33 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E31B3F7C5;
	Sun, 10 Dec 2023 23:51:42 -0800 (PST)
Message-ID: <862afccb-e9c5-4fcb-abdf-45a5eb9aa6d8@arm.com>
Date: Mon, 11 Dec 2023 13:21:40 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/10] coresight: replicator: Move ACPI support from
 AMBA driver to platform driver
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
 <20231208053939.42901-5-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231208053939.42901-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/8/23 11:09, Anshuman Khandual wrote:
> Add support for the dynamic replicator device in the platform driver, which
> can then be used on ACPI based platforms. This change would now allow
> runtime power management for repliacator devices on ACPI based systems.
> 
> The driver would try to enable the APB clock if available. Also, rename the
> code to reflect the fact that it now handles both static and dynamic
> replicators.
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
> - Dropped pm_runtime_put() from replicator_probe()
> - Added pm_runtime_put() on success path in dynamic_replicator_probe()
> - Added pm_runtime_put() on success/error paths in
>   replicator_platform_probe()
> 
>  drivers/acpi/arm64/amba.c                     |  1 -
>  .../coresight/coresight-replicator.c          | 81 ++++++++++---------
>  2 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 171b5c2c7edd..270f4e3819a2 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
>  	{"ARMHC503", 0}, /* ARM CoreSight Debug */
>  	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>  	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
> -	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
>  	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
>  	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
>  	{"", 0},
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b6be73034996..125b256cb8db 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -31,6 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>   * @base:	memory mapped base address for this component. Also indicates
>   *		whether this one is programmable or not.
>   * @atclk:	optional clock for the core parts of the replicator.
> + * @pclk:	APB clock if present, otherwise NULL
>   * @csdev:	component vitals needed by the framework
>   * @spinlock:	serialize enable/disable operations.
>   * @check_idfilter_val: check if the context is lost upon clock removal.
> @@ -38,6 +39,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>  struct replicator_drvdata {
>  	void __iomem		*base;
>  	struct clk		*atclk;
> +	struct clk		*pclk;
>  	struct coresight_device	*csdev;
>  	spinlock_t		spinlock;
>  	bool			check_idfilter_val;
> @@ -243,6 +245,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  			return ret;
>  	}
>  
> +	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
>  	/*
>  	 * Map the device base for dynamic-replicator, which has been
>  	 * validated by AMBA core
> @@ -285,7 +291,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
>  	}
>  
>  	replicator_reset(drvdata);
> -	pm_runtime_put(dev);
>  
>  out_disable_clk:
>  	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
> @@ -301,29 +306,31 @@ static int replicator_remove(struct device *dev)
>  	return 0;
>  }
>  
> -static int static_replicator_probe(struct platform_device *pdev)
> +static int replicator_platform_probe(struct platform_device *pdev)
>  {
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	int ret;
>  
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
>  
> -	/* Static replicators do not have programming base */
> -	ret = replicator_probe(&pdev->dev, NULL);
> -
> -	if (ret) {
> -		pm_runtime_put_noidle(&pdev->dev);
> -		pm_runtime_disable(&pdev->dev);
> -	}
> +	ret = replicator_probe(&pdev->dev, res);
> +	pm_runtime_put(&pdev->dev);

I believe pm_runtime_disable() would still be needed on the error path. Otherwise
pm_runtime_enable() will remain unbalanced on this error path when the replicator
module could not be loaded.

--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -317,6 +317,8 @@ static int replicator_platform_probe(struct platform_device *pdev)
 
        ret = replicator_probe(&pdev->dev, res);
        pm_runtime_put(&pdev->dev);
+       if (ret)
+               pm_runtime_disable(&pdev->dev);
 
        return ret;
 }

Similar constructs in this error path are also required in all other drivers (except
cpu debug) as well.

