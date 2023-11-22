Return-Path: <linux-acpi+bounces-1733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA47F4029
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317672810EB
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5432E41A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2D97110;
	Tue, 21 Nov 2023 23:02:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34E521595;
	Tue, 21 Nov 2023 23:03:27 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6C223F73F;
	Tue, 21 Nov 2023 23:02:36 -0800 (PST)
Message-ID: <268e1605-fe3f-4aa0-92e3-36ddfc8aacb3@arm.com>
Date: Wed, 22 Nov 2023 12:32:33 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] coresight: tpiu: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To: James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-5-anshuman.khandual@arm.com>
 <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <92d6a66d-3270-3378-2ab9-9214c004d5c7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/23 19:23, James Clark wrote:
> 
> 
> On 27/10/2023 08:29, Anshuman Khandual wrote:
>> Add support for the tpiu device in the platform driver, which can then be
>> used on ACPI based platforms. This change would now allow runtime power
>> management for ACPI based systems. The driver would try to enable the APB
>> clock if available.
>>
> [...]
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id tpiu_acpi_ids[] = {
>> +	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
>> +#endif
>> +
>> +static struct platform_driver tpiu_platform_driver = {
>> +	.probe	= tpiu_platform_probe,
>> +	.remove	= tpiu_platform_remove,
>> +	.driver = {
>> +		.name			= "coresight-tpiu-platform",
>> +		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
>> +		.suppress_bind_attrs	= true,
>> +		.pm			= &tpiu_dev_pm_ops,
>> +	},
>> +};
>> +module_platform_driver(tpiu_platform_driver);
>> +
> 
> Is there a special build config where this works? I get an error here

I have been testing this with a config known to work on RB5 board.

> because module_platform_driver() redefines things that are in
> module_amba_driver() which is defined above:
> 
>   module_amba_driver(tpiu_driver);
> 
> This isn't a W=1 build or anything, just a normal one. And it applies to
> most of the patches in this set.

You are right, I am able to recreate this problem with defconfig on
6.7-rc2 as well. The problem here seems to be caused by having both
module_amba_driver() and module_platform_driver() in the same file.

#define module_amba_driver(__amba_drv) \
        module_driver(__amba_drv, amba_driver_register, amba_driver_unregister)

#define module_platform_driver(__platform_driver) \
        module_driver(__platform_driver, platform_driver_register, \
                        platform_driver_unregister)

Although, AFAICT, have not seen these before - even on the defconfig.
Just to work around this problem, there can be a common module_init()
/module_exit() to register/unregister both AMBA and platform drivers,
similar to etm4x_init()/etm4x_exit() setup in coresight-etm4x-core.c.

