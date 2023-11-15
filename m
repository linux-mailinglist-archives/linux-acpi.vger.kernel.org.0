Return-Path: <linux-acpi+bounces-1504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC97EC56A
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 15:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C88280E56
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9002D042
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812241EB42
	for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 13:54:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B231EAF;
	Wed, 15 Nov 2023 05:54:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12847DA7;
	Wed, 15 Nov 2023 05:54:48 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC473F641;
	Wed, 15 Nov 2023 05:54:00 -0800 (PST)
Message-ID: <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
Date: Wed, 15 Nov 2023 13:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
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
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231027072943.3418997-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/10/2023 08:29, Anshuman Khandual wrote:
> Add support for the tpiu device in the platform driver, which can then be
> used on ACPI based platforms. This change would now allow runtime power
> management for ACPI based systems. The driver would try to enable the APB
> clock if available.
> 
[...]
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id tpiu_acpi_ids[] = {
> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
> +#endif
> +
> +static struct platform_driver tpiu_platform_driver = {
> +	.probe	= tpiu_platform_probe,
> +	.remove	= tpiu_platform_remove,
> +	.driver = {
> +		.name			= "coresight-tpiu-platform",
> +		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
> +		.suppress_bind_attrs	= true,
> +		.pm			= &tpiu_dev_pm_ops,
> +	},
> +};
> +module_platform_driver(tpiu_platform_driver);
> +

Is there a special build config where this works? I get an error here
because module_platform_driver() redefines things that are in
module_amba_driver() which is defined above:

  module_amba_driver(tpiu_driver);

This isn't a W=1 build or anything, just a normal one. And it applies to
most of the patches in this set.


