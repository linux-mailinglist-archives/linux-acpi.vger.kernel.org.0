Return-Path: <linux-acpi+bounces-11023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742A7A310E6
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510DC164AFE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FAC253B7E;
	Tue, 11 Feb 2025 16:13:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6C1EF088;
	Tue, 11 Feb 2025 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290413; cv=none; b=Kdf2QNYY/jOT7Ob0EXVQLI5iZQo00vlJw0S6rvP2kG+hLUqm5hwogNQv0CEpLFQiY4C9fhAH/32O5U+jZn6RWsFpFiurT0WcUEnQM9RerKL3QlFTA3oszsprLJnOaywsbn2A6IRCOYTx2F6jg4tVcUg0EELZZLVWkEjcduoIW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290413; c=relaxed/simple;
	bh=T15Mx9ZuiwR6vVMrQDZVNExHxsiOFJWhmUatt2oISjQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mABWLAX1zZNBsc9RBUL2/O0a9h8rqTyPevU5xgHayeletvTz/XUv/Lj1Pt6oup6zJF84FnBT+J5n5Xm9J71AUdlXAZWbMaD9nt8Humaw/s332Nlj5wX3GSEysqE48b6co+K0cGvn8IYWfAKRpDUB4CFrX/7r+uEgeLDHv+bQ74I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id AC8D461E64870;
	Tue, 11 Feb 2025 17:12:47 +0100 (CET)
Message-ID: <3ded4075-e2f9-4231-9c3f-49a14fbbde1e@molgen.mpg.de>
Date: Tue, 11 Feb 2025 17:12:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings `Could not retrieve perf counters (-19)` and
 `amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled` (Dell
 PowerEdge R7625, AMD EPYC 9174F)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Gautham Ranjal Shenoy <gautham.shenoy@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Huang
 <Ray.Huang@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <2b811df7-5278-4cfc-b8a0-7d6d72d3358d@molgen.mpg.de>
 <5dff1719-c4e9-4ebf-ae0b-73b9de98df05@amd.com>
 <DS7PR12MB82528A694056F1FBA20CE01E96EF2@DS7PR12MB8252.namprd12.prod.outlook.com>
 <d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de>
 <e26bc00f-1675-4aac-bd02-60774ff5901a@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <e26bc00f-1675-4aac-bd02-60774ff5901a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Am 28.01.25 um 16:08 schrieb Paul Menzel:
> [Cc: +x86 maintainers and ACPI list]

> Am 28.01.25 um 11:49 schrieb Paul Menzel:
> 
>> Thank you for your quick replies. Gautham, messages with HTML are 
>> rejected by Linux kernel lists.
>>
>>
>> Am 28.01.25 um 04:51 schrieb Shenoy, Gautham Ranjal:
>>
>>> As Mario mentioned, you need to enable the CPPC option. Looking for 
>>> some of the Dell PowerEdge documentation, there is an option called 
>>> "Collaborative CPU Performance Control" (https://www.dell.com/ 
>>> support/manuals/en-in/poweredge-r730/r730_ompublication/system- 
>>> profile-settings-details?guid=guid-2e9b46a1-71e3-4072-9d86- 
>>> db648757f0e6&lang=en-us).
>>>
>>> [cid:fe57df8f-3d99-4ea0-8f6e-b0daae49bb0e]
>>> Can you please try enabling it ?
>>
>> You quoted the Dell PowerEdge R730. I couldn’t find it in the *Dell 
>> PowerEdge R7625 Installation and Service Manual* [1], and also it’s 
>> not listed in the iDRAC9 Web site (attached with added `.txt` 
>> extension to trick the Linux list).
> 
> The amd_pstate warning seems to be related to the perf counters warning 
> Linux prints earlier:
> 
>      $ dmesg --level alert,crit,err,warn
>      [    2.666393] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
>      [    8.109446] Could not retrieve perf counters (-19)
>      [    9.386551] scsi 0:0:4:0: set ignore_delay_remove for handle(0x0012)
>      [    9.487804] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>      [   14.726193] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC data block query control method not found
> 
> x86 maintainers, the original report with the Linux logs attached is in 
> the archive [3].
> 
> It looks like, there is something missing in the Dell firmware to enable 
> the feature.
> 
> The perf counters warning is from `amd_set_max_freq_ratio()` in `arch/ 
> x86/kernel/acpi/cppc.c`:
> 
> ```
> static void amd_set_max_freq_ratio(void)
> {
>          struct cppc_perf_caps perf_caps;
>          u64 numerator, nominal_perf;
>          u64 perf_ratio;
>          int rc;
> 
>          rc = cppc_get_perf_caps(0, &perf_caps);
>          if (rc) {
>                  pr_warn("Could not retrieve perf counters (%d)\n", rc);
>                  return;
>          }
>          […]
> }
> ```
> 
> With
> 
>      include/uapi/asm-generic/errno-base.h:#define    ENODEV        19    /* No such device */
> 
> this is returned by in `drivers/acpi/cppc_acpi.c`:
> 
> ```
> /**
>   * cppc_get_perf_caps - Get a CPU's performance capabilities.
>   * @cpunum: CPU from which to get capabilities info.
>   * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
>   *
>   * Return: 0 for success with perf_caps populated else -ERRNO.
>   */
> int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> {
>          struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>          […]
>          if (!cpc_desc) {
>                  pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>                  return -ENODEV;
>          }
>          […]
> }
> ```

@AMD folks, just for clarity. Did Dell something with their firmware? If 
so, are you going to work with Dell on a solution, or do I need to 
report the issue to them?


Kind regards,

Paul


>> PS:
>>
>>> -- 
>>>
>>> Thanks and Regards
>>>
>>> Gautham.
>>
>> Only if you care: Your signature delimiter misses a space at the end [2].
>>
>>
>> [1]: https://www.dell.com/support/manuals/de-de/poweredge-r7625/per7625_ism_pub/system-profile-settings?guid=guid-9f6b6652-4079-45e7-90f5-1c8feee08ec0&lang=en-us
>> [2]: https://en.wikipedia.org/wiki/Signature_block#Standard_delimiter
> [3]: https://lore.kernel.org/linux-pm/d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de/T/#t

