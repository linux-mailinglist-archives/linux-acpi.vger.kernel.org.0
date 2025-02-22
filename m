Return-Path: <linux-acpi+bounces-11384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A05A40747
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 11:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245773BB3AF
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC98207A33;
	Sat, 22 Feb 2025 10:07:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8D205AD2;
	Sat, 22 Feb 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740218877; cv=none; b=fK1NlqNtLkIAS/XBYA6aUJwKxTeFLnHeDHkX4ua2ATHnIOQU0fM1EhzAIDM20tAmA5eIesQiIhNByL7QbRA0AlDS9gIAIwY5KQyllC7N46eO25P3nCE1lWz/0fGLzY570zMOqkKBbI2uq8nVJebqkOCngAIgUSELD0zHbvxwaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740218877; c=relaxed/simple;
	bh=h4o39zGp6HLTNh3hEvswpajKgUxVor2Rc9U8zJVy15U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f5n/8Fs9jGE9TeTJC5/2dD4CA7DVTeM2iJvy80ESQ/hGt/eDByMZQymxkwbtQd5NXhlKr25RD7LBTAlOH5Zq6BI7K31B7hqQVxWEhd/zvyNSagn/GokNjPF5ANWMQmRjSM1XXPNjN6Jm5twK7y3U1UoPCfdlnYFPqOOJTZ0pIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z0My16cJ1zdb8t;
	Sat, 22 Feb 2025 18:03:05 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 18FD91802D2;
	Sat, 22 Feb 2025 18:07:46 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 18:07:45 +0800
Message-ID: <ddbc0336-9083-4054-8930-c22bd8337488@huawei.com>
Date: Sat, 22 Feb 2025 18:07:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Support for autonomous selection in cppc_cpufreq
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
 <0097a9a3-fe61-4200-9a54-5a9c81d3219c@huawei.com>
 <CAJZ5v0hP9a8g8UR2oPyivP1C65=csR245PSHay+nOx3vkoKoaA@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0hP9a8g8UR2oPyivP1C65=csR245PSHay+nOx3vkoKoaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/2/19 3:17, Rafael J. Wysocki wrote:
> On Thu, Feb 13, 2025 at 2:55 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
>>
>> On 2025/2/6 21:14, Lifeng Zheng wrote:
>>> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
>>> driver.
>>>
>>> The patch series is organized in two parts:
>>>
>>>  - patch 1-5 refactor out the general CPPC register get and set functions
>>>    in cppc_acpi.c
>>>
>>>  - patches 6-8 expose sysfs files for users to control CPPC autonomous
>>>    selection when supported
>>>
>>> Changelog:
>>>
>>> v5:
>>>
>>>  - add more explanation to the commit logs and comments
>>>  - change REG_OPTIONAL from bin to hex
>>>  - split patch 2 into 3 smaller patches
>>>  - remove CPPC_REG_VAL_READ() and CPPC_REG_VAL_WRITE() macros
>>>  - move the modification part in patch 5 into a separate patch
>>>  - rename the sysfs file from "energy_perf" to
>>>    energy_performance_preference_val
>>>
>>> v4:
>>>
>>>  - add REG_OPTIONAL and IS_OPTIONAL_CPC_REG to judge if a cpc register is
>>>    an optional one
>>>  - check whether the register is optional before CPC_SUPPORTED check in
>>>    cppc_get_reg_val() and cppc_set_reg_val()
>>>  - check the register's type in cppc_set_reg_val()
>>>  - add macros to generally implement registers getting and setting
>>>    functions
>>>  - move some logic codes from cppc_cpufreq.c to cppc_acpi.c
>>>  - replace cppc_get_auto_sel_caps() by cppc_get_auto_sel()
>>>
>>> v3:
>>>
>>>  - change cppc_get_reg() and cppc_set_reg() name to cppc_get_reg_val() and
>>>    cppc_set_reg_val()
>>>  - extract cppc_get_reg_val_in_pcc() and cppc_set_reg_val_in_pcc()
>>>  - return the result of cpc_read() in cppc_get_reg_val()
>>>  - add pr_debug() in cppc_get_reg_val_in_pcc() when pcc_ss_id < 0
>>>  - rename 'cpunum' to 'cpu' in cppc_get_reg_val()
>>>  - move some macros from drivers/cpufreq/cppc_cpufreq.c to
>>>    include/acpi/cppc_acpi.h with a CPPC_XXX prefix
>>>
>>> v2:
>>>
>>>  - fix some incorrect placeholder
>>>  - change kstrtoul to kstrtobool in store_auto_select
>>>
>>> Lifeng Zheng (8):
>>>   ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is
>>>     optional
>>>   ACPI: CPPC: Optimize cppc_get_perf()
>>>   ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
>>>   ACPI: CPPC: Add cppc_set_reg_val()
>>>   ACPI: CPPC: Refactor register value get and set ABIs
>>>   ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
>>>   ACPI: CPPC: Add three functions related to autonomous selection
>>>   cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
>>>
>>>  .../ABI/testing/sysfs-devices-system-cpu      |  54 ++++
>>>  drivers/acpi/cppc_acpi.c                      | 303 +++++++++++-------
>>>  drivers/cpufreq/amd-pstate.c                  |   3 +-
>>>  drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++
>>>  include/acpi/cppc_acpi.h                      |  30 +-
>>>  5 files changed, 372 insertions(+), 127 deletions(-)
>>>
>>
>> Gentle ping.
> 
> OK, so I'm wondering how this is related to the patch series at
> 
> https://lore.kernel.org/linux-acpi/20250211103737.447704-1-sumitg@nvidia.com/

This series refactors some cppc_acpi ABIs and supports cppc autonomous
selection with sysfs files in cpufreq policy.  Later, [1] proposed another
design with different user interfaces.We will discuss and reach a consensus
with regard to this.

However, as mentioned in [1], patch 1-7 in this series (the cppc_acpi part)
are not related to user interfaces, so can be reviewed and applied
separately.  I can also send patch 1-7 as a new thread if preferred.

[1] https://lore.kernel.org/linux-acpi/20250211103737.447704-1-sumitg@nvidia.com/

> 
>> Attach discussions of previous versions:
>> v1: https://lore.kernel.org/all/20241114084816.1128647-1-zhenglifeng1@huawei.com/
>> v2: https://lore.kernel.org/all/20241122062051.3658577-1-zhenglifeng1@huawei.com/
>> v3: https://lore.kernel.org/all/20241216091603.1247644-1-zhenglifeng1@huawei.com/
>> v4: https://lore.kernel.org/all/20250113122104.3870673-1-zhenglifeng1@huawei.com/
>>
> 


