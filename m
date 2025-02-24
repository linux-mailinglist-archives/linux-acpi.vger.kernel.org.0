Return-Path: <linux-acpi+bounces-11390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DAA41B28
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598C51743F1
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F5158558;
	Mon, 24 Feb 2025 10:31:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E281727;
	Mon, 24 Feb 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393098; cv=none; b=VdA3Ce5JVY+HF3uv6Q3T4J10NnKTaEuGsmMAUZUUY3pEzaxOhvko4gPsg+ShX5b2zj4IXHwlmG2PztaLFsQQpigFYFNWMbJZqsMnYFfysYpqvrggmq+HQgENyT9y2A9EUfeAYtC2W7XAt/3GmlLbX9dy+qnEYDgis/MO+jbSDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393098; c=relaxed/simple;
	bh=dXRdm8n1r2jv7wtwFW8fNm4TeJQUiRjJq79tsZ/qQ+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPQa307s3HYRUzCw0nta5pWV6/RJDzJEHSlQ5NtXAvv/L8v4TwLOYGIl3aUUIfH7pJf5ZUwtWxBF+DHraLDyCjeUEplsWav3VpBlIBYS3VVS3sanlHMT/3i0ImE8P964rEf9UjUys4kB1oqjMHIccXAyo3tp9Wme2XWSYQL4ES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D449A1E7D;
	Mon, 24 Feb 2025 02:31:51 -0800 (PST)
Received: from [10.57.38.222] (unknown [10.57.38.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F5B33F673;
	Mon, 24 Feb 2025 02:31:30 -0800 (PST)
Message-ID: <828ab846-fe03-4830-a722-a86e57ba89c7@arm.com>
Date: Mon, 24 Feb 2025 11:31:29 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Support for autonomous selection in cppc_cpufreq
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 yumpusamongus@gmail.com, srinivas.pandruvada@linux.intel.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 hepeng68@huawei.com, fanghao11@huawei.com
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
 <0097a9a3-fe61-4200-9a54-5a9c81d3219c@huawei.com>
 <CAJZ5v0hP9a8g8UR2oPyivP1C65=csR245PSHay+nOx3vkoKoaA@mail.gmail.com>
 <ddbc0336-9083-4054-8930-c22bd8337488@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <ddbc0336-9083-4054-8930-c22bd8337488@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/22/25 11:07, zhenglifeng (A) wrote:
> On 2025/2/19 3:17, Rafael J. Wysocki wrote:
>> On Thu, Feb 13, 2025 at 2:55 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
>>>
>>> On 2025/2/6 21:14, Lifeng Zheng wrote:
>>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>>> driver.
>>>>
>>>> The patch series is organized in two parts:
>>>>
>>>>   - patch 1-5 refactor out the general CPPC register get and set functions
>>>>     in cppc_acpi.c
>>>>
>>>>   - patches 6-8 expose sysfs files for users to control CPPC autonomous
>>>>     selection when supported
>>>>
>>>> Changelog:
>>>>
>>>> v5:
>>>>
>>>>   - add more explanation to the commit logs and comments
>>>>   - change REG_OPTIONAL from bin to hex
>>>>   - split patch 2 into 3 smaller patches
>>>>   - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
>>>>   - move the modification part in patch 5 into a separate patch
>>>>   - rename the sysfs file from "energy_perf" to
>>>>     energy_performance_preference_val
>>>>
>>>> v4:
>>>>
>>>>   - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register is
>>>>     an optional one
>>>>   - check whether the register is optional before CPC_SUPPORTED check in
>>>>     cppc_get_reg_val() and cppc_set_reg_val()
>>>>   - check the register's type in cppc_set_reg_val()
>>>>   - add macros to generally implement registers getting and setting
>>>>     functions
>>>>   - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
>>>>   - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
>>>>
>>>> v3:
>>>>
>>>>   - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() and
>>>>     cppc_set_reg_val()
>>>>   - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
>>>>   - return the result of cpc_read() in cppc_get_reg_val()
>>>>   - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
>>>>   - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
>>>>   - move some macros from drivers/cpufreq/cppc_cpufreq.c to
>>>>     include/acpi/cppc_acpi.h with a CPPC_XXX prefix
>>>>
>>>> v2:
>>>>
>>>>   - fix some incorrect placeholder
>>>>   - change kstrtoul to kstrtobool in store_auto_select
>>>>
>>>> Lifeng Zheng (8):
>>>>    ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
>>>>      optional
>>>>    ACPI: CPPC: Optimize cppc_get_perf()
>>>>    ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
>>>>    ACPI: CPPC: Add cppc_set_reg_val()
>>>>    ACPI: CPPC: Refactor register value get and set ABIs
>>>>    ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
>>>>    ACPI: CPPC: Add three functions related to autonomous selection
>>>>    cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
>>>>
>>>>   .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
>>>>   drivers/acpi/cppc_acpi.c                      | 303 +++++++++++-------
>>>>   drivers/cpufreq/amd-pstate.c                  |   3 +-
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++
>>>>   include/acpi/cppc_acpi.h                      |  30 +-
>>>>   5 files changed, 372 insertions(+), 127 deletions(-)
>>>>
>>>
>>> Gentle ping.
>>
>> OK, so I'm wondering how this is related to the patch series at
>>
>> https://lore.kernel.org/linux-acpi/20250211103737.447704-1-sumitg@nvidia.com/
> 
> This series refactors some cppc_acpi ABIs and supports cppc autonomous
> selection with sysfs files in cpufreq policy.  Later, [1] proposed another
> design with different user interfaces.We will discuss and reach a consensus
> with regard to this.
> 
> However, as mentioned in [1], patch 1-7 in this series (the cppc_acpi part)
> are not related to user interfaces, so can be reviewed and applied
> separately.  I can also send patch 1-7 as a new thread if preferred.
> 
> [1] https://lore.kernel.org/linux-acpi/20250211103737.447704-1-sumitg@nvidia.com/

I tried the patchset on a platform which doesn't implement CPC and everything worked well.
As Lifeng said,
   PATCH v5 8/8] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
seems to be still in discussion, but for patches 1-7 FWIW:

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Regards,
Pierre

> 
>>
>>> Attach discussions of previous versions:
>>> v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@huawei.com/
>>> v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@huawei.com/
>>> v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@huawei.com/
>>> v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@huawei.com/
>>>
>>
> 
> 

