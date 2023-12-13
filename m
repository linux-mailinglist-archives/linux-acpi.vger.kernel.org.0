Return-Path: <linux-acpi+bounces-2232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B397D80A933
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABD9B20B12
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F593986C
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:35:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9173BFB;
	Fri,  8 Dec 2023 07:32:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0F6B106F;
	Fri,  8 Dec 2023 07:32:59 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE3753F6C4;
	Fri,  8 Dec 2023 07:32:12 -0800 (PST)
Message-ID: <b7270822-efe5-da15-49ea-0028031e38ce@arm.com>
Date: Fri, 8 Dec 2023 15:32:07 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 00/10] coresight: Move remaining AMBA ACPI devices into
 platform driver
Content-Language: en-US
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231208053939.42901-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/12/2023 05:39, Anshuman Khandual wrote:
> This moves remaining AMBA ACPI devices into respective platform drivers for
> enabling ACPI based power management support. This series applies on latest
> coresight/next branch. This series has been built, and boot tested on a DT
> based coresight platform. Although this still requires some more testing on
> ACPI based coresight platforms.
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (amba_other_acpi_migration_v3)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> 
> Changes in V3:
> 
> - Split coresight_init_driver/remove_driver() helpers into a separate patch
> - Added 'drvdata->pclk' comments in replicator, funnel, tpiu, tmc, and stm devices
> - Updated funnel, and replicator drivers to use these new helpers
> - Check for drvdata instead of drvdata->pclk in suspend and resume paths in catu,
>   tmc and debug devices
> - Added patch to extract device name from AMBA pid based table lookup for stm
> - Added patch to extract device properties from AMBA pid based table look for tmc
> - Dropped pm_runtime_put() from common __probe() functions
> - Handled pm_runtime_put() in AMBA driver in success path
> - Handled pm_runtime_put() in platform driver in both success and error paths
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20231201062053.1268492-1-anshuman.khandual@arm.com/
> 
> - Dropped redundant devm_ioremap_resource() hunk from tmc_platform_probe()
> - Defined coresight_[init|remove]_driver() for both AMBA/platform drivers
> - Changed catu, tmc, tpiu, stm and debug coresight drivers to use the new
>   helpers avoiding build issues arising from module_amba_driver(), and
>   module_platform_driver() being on the same file
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20231027072943.3418997-1-anshuman.khandual@arm.com/
> 
> - Replaced all IS_ERR() instances with IS_ERR_OR_NULL() as per Suzuki
> 
> Changes in RFC:
> 
> https://lore.kernel.org/all/20230921042040.1334641-1-anshuman.khandual@arm.com/
> 
> Anshuman Khandual (10):
>   coresight: stm: Extract device name from AMBA pid based table lookup
>   coresight: tmc: Extract device properties from AMBA pid based table lookup
>   coresight: Add helpers registering/removing both AMBA and platform drivers
>   coresight: replicator: Move ACPI support from AMBA driver to platform driver
>   coresight: funnel: Move ACPI support from AMBA driver to platform driver
>   coresight: catu: Move ACPI support from AMBA driver to platform driver
>   coresight: tpiu: Move ACPI support from AMBA driver to platform driver
>   coresight: tmc: Move ACPI support from AMBA driver to platform driver
>   coresight: stm: Move ACPI support from AMBA driver to platform driver
>   coresight: debug: Move ACPI support from AMBA driver to platform driver
> 
>  drivers/acpi/arm64/amba.c                     |   8 -
>  drivers/hwtracing/coresight/coresight-catu.c  | 140 +++++++++++++---
>  drivers/hwtracing/coresight/coresight-catu.h  |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |  29 ++++
>  .../hwtracing/coresight/coresight-cpu-debug.c | 141 ++++++++++++++--
>  .../hwtracing/coresight/coresight-funnel.c    |  87 +++++-----
>  drivers/hwtracing/coresight/coresight-priv.h  |  10 ++
>  .../coresight/coresight-replicator.c          |  81 ++++-----
>  drivers/hwtracing/coresight/coresight-stm.c   | 115 +++++++++++--
>  .../hwtracing/coresight/coresight-tmc-core.c  | 156 +++++++++++++++---
>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  99 +++++++++--
>  include/linux/coresight.h                     |   7 +
>  13 files changed, 713 insertions(+), 163 deletions(-)
> 

