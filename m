Return-Path: <linux-acpi+bounces-2113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB58032D8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 13:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75D1F20FB2
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5824208
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D67D9B9;
	Mon,  4 Dec 2023 02:54:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2D6139F;
	Mon,  4 Dec 2023 02:55:03 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A3F53F6C4;
	Mon,  4 Dec 2023 02:54:14 -0800 (PST)
Message-ID: <fe5c82d1-8b7d-6701-4e19-9019f23d9c7b@arm.com>
Date: Mon, 4 Dec 2023 10:54:15 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 5/7] coresight: tmc: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-6-anshuman.khandual@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231201062053.1268492-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/12/2023 06:20, Anshuman Khandual wrote:
> Add support for the tmc devices in the platform driver, which can then be
> used on ACPI based platforms. This change would now allow runtime power
> management for ACPI based systems. The driver would try to enable the APB
> clock if available.
> 
[...]
> -module_amba_driver(tmc_driver);
> +static int tmc_platform_probe(struct platform_device *pdev)
> +{
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct tmc_drvdata *drvdata;
> +	int ret = 0;
> +
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
> +	dev_set_drvdata(&pdev->dev, drvdata);
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = __tmc_probe(&pdev->dev, res, NULL);
> +	if (ret) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
> +	}

I'm not sure if these pm_runtime()s are right because there is already a
put inside of __tmc_probe() if it fails. If you unload and then reload
all the coresight modules with these patches you get these errors which
are new:

  coresight-tpiu-platform ARMHC979:00: Unbalanced pm_runtime_enable!
  CSCFG registered etm0
  coresight etm0: CPU0: etm v4.2 initialized
  CSCFG registered etm1
  coresight etm1: CPU1: etm v4.2 initialized
  CSCFG registered etm2
  coresight etm2: CPU2: etm v4.2 initialized
  CSCFG registered etm3
  coresight etm3: CPU3: etm v4.2 initialized
  coresight-tmc-platform ARMHC97C:00: Unbalanced pm_runtime_enable!
  coresight-tmc-platform ARMHC97C:01: Unbalanced pm_runtime_enable!
  coresight-tmc-platform ARMHC97C:02: Unbalanced pm_runtime_enable!
  coresight-tmc-platform ARMHC97C:03: Unbalanced pm_runtime_enable!

It might be worth testing all of these pm_runtime()s, including the
error case ones, because loading and unloading the modules doesn't even
include the error scenarios, so there are probably more bad ones in
there too.

