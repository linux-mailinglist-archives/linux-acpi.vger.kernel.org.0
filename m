Return-Path: <linux-acpi+bounces-11092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E0A323F2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087A83A84FB
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307BD209F49;
	Wed, 12 Feb 2025 10:52:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D5209F2A;
	Wed, 12 Feb 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357530; cv=none; b=ZGhOQQ0HHjZ5cd1Gn5WjIyqkNs2hgkCKW/XhHFjCuYOkydhXECcOWJtjGPZLZVHEzyfB7+xey+Fcx+ZPHimA9D6Lg6d0jTErb9VhvjKvCZOWGDHiSX8qCWMmkT9K4SQqU2SIcG5rlzkZrT7PSvf/a7oDUSJPCD7133R4tv92mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357530; c=relaxed/simple;
	bh=AI5QOFLLH0oxBfsduevknRWSBfbZxBE//7tA0kLY9ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UfRn3maRjQuLxV5WdIJTky/4I4FWNA08krbUTD7bpOdQVA/4VxQ6wC3sDIuI6efciJEtteaxYBID1JfrLOUSh6TosYQwYNHwYmHZ0t5TwQ4TDZA+ccevAietISN2zBFa308OAXzm0XBphrl7DjgLzqgrJmdcqocIP+z4Fv2INbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YtFQ03R0Lz11Q1B;
	Wed, 12 Feb 2025 18:47:36 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BAF91140258;
	Wed, 12 Feb 2025 18:52:03 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 12 Feb
 2025 18:52:02 +0800
Message-ID: <8d5e0035-d8fe-49ef-bda5-f5881ff96657@huawei.com>
Date: Wed, 12 Feb 2025 18:52:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
To: Sumit Gupta <sumitg@nvidia.com>, Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <sashal@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<bbasu@nvidia.com>
References: <20250211103737.447704-1-sumitg@nvidia.com>
 <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
 <b45d0d81-e4f7-474e-a146-0075a6145cc2@huawei.com>
 <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <868d4c2a-583a-4cbb-a572-d884090a7134@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/2/11 22:08, Sumit Gupta wrote:
> 
> 
>>
>> On 2025/2/11 18:44, Viresh Kumar wrote:
>>> On 11-02-25, 16:07, Sumit Gupta wrote:
>>>> This patchset supports the Autonomous Performance Level Selection mode
>>>> in the cppc_cpufreq driver. The feature is part of the existing CPPC
>>>> specification and already present in Intel and AMD specific pstate
>>>> cpufreq drivers. The patchset adds the support in generic acpi cppc
>>>> cpufreq driver.
>>>
>>> Is there an overlap with:
>>>
>>> https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
>>>
>>> ?
>>
>> Ha, it looks like we're doing something very similar.
>>
> 
> Hi Viresh,
> 
> Thank you for pointing to [1].
> 
> There seems to be some common points about updating the 'energy_perf'
> and 'auto_sel' registers for autonomous mode but the current patchset
> has more comprehensive changes to support Autonomous mode with the
> cppc_cpufreq driver.
> 
> The patches in [1]:
> 1) Make the cpc register read/write API’s generic and improves error
>    handling for 'CPC_IN_PCC'.
> 2) Expose sysfs under 'cppc_cpufreq_attr' to update 'auto_select',
>    'auto_act_window' and 'epp' registers.
> 
> The current patch series:
> 1) Exposes sysfs under 'cppc_attrs' to keep CPC registers together.
> 2) Updates existing API’s to use new registers and creates new API
>    with similar semantics to get all perf_ctrls.
> 3) Renames some existing API’s for clarity.
> 4) Use these existing API’s from acpi_cppc sysfs to update the CPC
>    registers used in Autonomous mode:
>    'auto_select', 'epp', 'min_perf', 'max_perf' registers.
> 5) Add separate 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq'
>    driver to apply different limit and policy for Autonomous mode.
>    Having it separate will avoid confusion between SW and HW mode.
>    Also, it will be easy to scale and add new features in future
>    without interference. Similar approach is used in Intel and AMD
>    pstate drivers.
> 
> Please share inputs about the preferred approach.
> 
> Best Regards,
> Sumit Gupta
> 
> [1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/
> 
> 

Hi Sumit,

Thanks for upstreaming this.

I think the changes to cppc_acpi in this patchset is inappropriate.

1) cppc_attrs are common sysfs for any system that supports CPPC. That
means, these interfaces would appear even if the cpufreq driver has already
managing it, e.g. amd-pstate and cppc_cpufreq. This would create multiple
interfaces to modify the same CPPC regs, which may probably introduce
concurrency and data consistency issues. Instead, exposing the interfaces
under cppc_cpufreq_attr decouples the write access to CPPC regs.

2) It's inappropriate to call cpufreq_cpu_get() in cppc_acpi. This file
currently provides interfaces for cpufreq drivers to use. It has no ABI
dependency on cpufreq at the moment.

Apart from the changes to cppc_acpi, I think the whole patchset in [1] can
be independent to this patchset. In other words, adding the
cppc_cpufreq_epp_driver could be standalone to discuss. I think combining
the use of ->setpolicy() and setting EPP could be a use case? Could you
explain more on the motivation of adding a new cppc_cpufreq_epp_driver?

[1] https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/

Regards,
Lifeng

>>>
>>>> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
>>>> for supporting the Autonomous Performance Level Selection and Energy
>>>> Performance Preference (EPP).
>>>> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
>>>> boot argument is passed or the 'Autonomous Selection Enable' register
>>>> is already set before kernel boot. When enabled, the hardware is
>>>> allowed to autonomously select the CPU frequency within the min and
>>>> max perf boundaries using the Engergy Performance Preference hints.
>>>> The EPP values range from '0x0'(performance preference) to '0xFF'
>>>> (energy efficiency preference).
>>>>
>>>> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
>>>> and {min|max_perf} registers for changing the hints to hardware for
>>>> Autonomous selection.
>>>>
>>>> In a followup patch, plan to add support to dynamically switch the
>>>> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
>>>> vice-versa without reboot.
>>>>
>>>> The patches are divided into below groups:
>>>> - Patch [1-2]: Improvements. Can be applied independently.
>>>> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
>>>> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
>>>>
>>>> Sumit Gupta (5):
>>>>    ACPI: CPPC: add read perf ctrls api and rename few existing
>>>>    ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>>>>    ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>>>>      sysfs
>>>>    Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>>>>    cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
>>>>
>>>>   Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>>>>   .../admin-guide/kernel-parameters.txt         |  11 +
>>>>   drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>>>>   include/acpi/cppc_acpi.h                      |  19 +-
>>>>   5 files changed, 572 insertions(+), 57 deletions(-)
>>>
>>


