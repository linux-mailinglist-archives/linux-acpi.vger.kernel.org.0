Return-Path: <linux-acpi+bounces-2108-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B8803093
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34331C209CE
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3935222EE7
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 10:39:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66809B6;
	Mon,  4 Dec 2023 01:57:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FF87FEC;
	Mon,  4 Dec 2023 01:58:20 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEA293F6C4;
	Mon,  4 Dec 2023 01:57:31 -0800 (PST)
Message-ID: <2aec13e9-4ae3-676f-1ba8-c9e9a9241063@arm.com>
Date: Mon, 4 Dec 2023 09:57:31 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/7] coresight: replicator: Move ACPI support from AMBA
 driver to platform driver
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Mike Leach
 <mike.leach@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-2-anshuman.khandual@arm.com>
 <20231201123515.gntwvhsxd5nzojn7@bogus>
 <58882cab-89ce-4554-aee4-24e70d82fc09@arm.com>
 <b9f407c7-62af-47e1-bea9-c494cdfed1e9@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <b9f407c7-62af-47e1-bea9-c494cdfed1e9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/12/2023 04:48, Anshuman Khandual wrote:
> 
> 
> On 12/4/23 09:56, Anshuman Khandual wrote:
>>
>>
>> On 12/1/23 18:05, Sudeep Holla wrote:
>>> On Fri, Dec 01, 2023 at 11:50:47AM +0530, Anshuman Khandual wrote:
>>>> Add support for the dynamic replicator device in the platform driver, which
>>>> can then be used on ACPI based platforms. This change would now allow
>>>> runtime power management for repliacator devices on ACPI based systems.
>>>>
>>>> The driver would try to enable the APB clock if available. Also, rename the
>>>> code to reflect the fact that it now handles both static and dynamic
>>>> replicators.
>>>>
>>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> Except the minor nit below which may apply also for few other patches
>>> in the series
>>>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
>>> Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
>>>
>>> [...]
>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
>>>> index b6be73034996..64de0bee02ec 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>>>> @@ -38,6 +38,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>>>>  struct replicator_drvdata {
>>>>  	void __iomem		*base;
>>>>  	struct clk		*atclk;
>>>> +	struct clk		*pclk;
>>>
>>> [minor nit] Perhaps can be documented as well ?
>>
>> Sure, will add the following comment above the structure.
>>
>> @pclk:    optional clock for the core parts of the replicator.
> 
> My bad, this will be the following instead.
> 
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 64de0bee02ec..44b9a77ec8aa 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -31,6 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
>   * @base:      memory mapped base address for this component. Also indicates
>   *             whether this one is programmable or not.
>   * @atclk:     optional clock for the core parts of the replicator.
> + * @pclk:      APB clock if present, otherwise NULL
>   * @csdev:     component vitals needed by the framework
>   * @spinlock:  serialize enable/disable operations.
>   * @check_idfilter_val: check if the context is lost upon clock removal.
> 
> I will update replicator, tpiu, tmc, and stm devices.
> 

funnel is missing it as well. If you build with W=1 it shows up.

> struct catu_drvdata and debug_drvdata do not have the comment section itself.
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

