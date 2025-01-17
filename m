Return-Path: <linux-acpi+bounces-10730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A9A14869
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478A8164CCD
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42B1E2007;
	Fri, 17 Jan 2025 03:11:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71F7FBA2;
	Fri, 17 Jan 2025 03:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083469; cv=none; b=f7jy7I0EyD7NiLa5SPIUTsQyqyGs3G8sDl0tZPHAwa8WG42suKbYlXewuEL51nZaOgfW8BOiuWfe1ZLNRPHT1ts/wBCrHgI/YotVvhZaQiDplZhwHwr/UR2bFgjlGnc7awRotjhsR2vNkIX6wDS0OZ7QVomz7tQOD49SwdeK9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083469; c=relaxed/simple;
	bh=CGhLza4dHpSDMk5Ykf26NfZ78oeA7zsoqgRdps8RMug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nKleXTWLUCUnnjh1izzHtuhYIlYZGVaC7RPQNi4GEzOrspbrbfQITE17aU0FQMCCsCW8v3PcM0+XpdPU/cukMHGoBU37oSutRYihlKdQQmj1FDDVFLc03KDUu2yXfkKUwI+kbJkPIzQzisdKNLTsoFvSOXemCeOacj61gXFNV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YZ4RV30Qqz1kycb;
	Fri, 17 Jan 2025 11:07:50 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A6B681400D5;
	Fri, 17 Jan 2025 11:11:02 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Jan
 2025 11:11:01 +0800
Message-ID: <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
Date: Fri, 17 Jan 2025 11:11:01 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Russell Haley <yumpusamongus@gmail.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/16 19:39, Russell Haley wrote:

> Hello,
> 
> I noticed something here just as a user casually browsing the mailing list.
> 
> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>> driver.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>  drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>>  2 files changed, 163 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 206079d3bd5b..3d87c3bb3fe2 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>>  		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>>  		drivers are in use.
>>  
> 
> [...snip...]
> 
>> +What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>> +Date:		October 2024
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:	Energy performance preference
>> +
>> +		Read/write an 8-bit integer from/to this file. This file
>> +		represents a range of values from 0 (performance preference) to
>> +		0xFF (energy efficiency preference) that influences the rate of
>> +		performance increase/decrease and the result of the hardware's
>> +		energy efficiency and performance optimization policies.
>> +
>> +		Writing to this file only has meaning when Autonomous Selection is
>> +		enabled.
>> +
>> +		This file only presents if the cppc-cpufreq driver is in use.
> 
> In intel_pstate driver, there is file with near-identical semantics:
> 
> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
> 
> It also accepts a few string arguments and converts them to integers.
> 
> Perhaps the same name should be used, and the semantics made exactly
> identical, and then it could be documented as present for either
> cppc_cpufreq OR intel_pstate?
> 
> I think would be more elegant if userspace tooling could Just Work with
> either driver.
> 
> One might object that the frequency selection behavior that results from
> any particular value of the register itself might be different, but they
> are *already* different between Intel's P and E-cores in the same CPU
> package. (Ugh.)

Yes, I should use the same name. Thanks.

As for accepting string arguments and converting them to integers, I don't
think it is necessary. It'll be a litte confused if someone writes a raw
value and reads a string I think. I prefer to let users freely set this
value.

In addition, there are many differences between the implementations of
energy_performance_preference in intel_pstate and cppc_cpufreq (and
amd-pstate...). It is really difficult to explain all this differences in
this document. So I'll leave it to be documented as present for
cppc_cpufreq only.

> 
> --
> Thanks,
> Russell
> 
> 
> 


