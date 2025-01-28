Return-Path: <linux-acpi+bounces-10854-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C55A20CA5
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667151882D43
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907691B0413;
	Tue, 28 Jan 2025 15:09:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C742AA3;
	Tue, 28 Jan 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076979; cv=none; b=WT26PlzshKP4gJg0PlgBx+3y4AFqUHxN4MygaUxJz+ttRON05nKTF45iMoFmKSIIzCT+cE1s2eTLZW2HtVsYrdnotHD2QIK10yFiF6JFCly2WzwB2ek9fb4uS41nvAgeyWVZpykkhCwdTXtvpzlchlhSeUgqUzjPIN36CIXmJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076979; c=relaxed/simple;
	bh=bsjmKyniqMWd6rhrX4DwYWCF9H1Bh7oTRUwDP+gUhfQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nEqIZSdXnEqcmyFLgGL5x0C033DM7yiprk5LRpEx84F9Jju9/HpO5GAKAOZ80YrfzOhjkEmMAbWSmrvIpr0C5YHKl1NZugmFavNxw7fZOjzT4K4G2wtN551WT1ETLTxsR0F99fpqgdBErZGUDjj/luhbB0rY8vuRSNkQApj1eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D5DCE61E647BA;
	Tue, 28 Jan 2025 16:08:43 +0100 (CET)
Message-ID: <e26bc00f-1675-4aac-bd02-60774ff5901a@molgen.mpg.de>
Date: Tue, 28 Jan 2025 16:08:43 +0100
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
Content-Language: en-US
In-Reply-To: <d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +x86 maintainers and ACPI list]

Dear Linux folks,


Am 28.01.25 um 11:49 schrieb Paul Menzel:

> Thank you for your quick replies. Gautham, messages with HTML are 
> rejected by Linux kernel lists.
> 
> 
> Am 28.01.25 um 04:51 schrieb Shenoy, Gautham Ranjal:
> 
>> As Mario mentioned, you need to enable the CPPC option. Looking for 
>> some of the Dell PowerEdge documentation, there is an option called 
>> "Collaborative CPU Performance Control" (https://www.dell.com/support/manuals/en-in/poweredge-r730/r730_ompublication/system-profile-settings-details?guid=guid-2e9b46a1-71e3-4072-9d86-db648757f0e6&lang=en-us).
>>
>> [cid:fe57df8f-3d99-4ea0-8f6e-b0daae49bb0e]
>> Can you please try enabling it ?
> 
> You quoted the Dell PowerEdge R730. I couldn’t find it in the *Dell 
> PowerEdge R7625 Installation and Service Manual* [1], and also it’s not 
> listed in the iDRAC9 Web site (attached with added `.txt` extension to 
> trick the Linux list).

The amd_pstate warning seems to be related to the perf counters warning 
Linux prints earlier:

     $ dmesg --level alert,crit,err,warn
     [    2.666393] Spectre V2 : WARNING: Unprivileged eBPF is enabled 
with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
     [    8.109446] Could not retrieve perf counters (-19)
     [    9.386551] scsi 0:0:4:0: set ignore_delay_remove for handle(0x0012)
     [    9.487804] amd_pstate: the _CPC object is not present in SBIOS 
or ACPI disabled
     [   14.726193] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC 
data block query control method not found

x86 maintainers, the original report with the Linux logs attached is in 
the archive [3].

It looks like, there is something missing in the Dell firmware to enable 
the feature.

The perf counters warning is from `amd_set_max_freq_ratio()` in 
`arch/x86/kernel/acpi/cppc.c`:

```
static void amd_set_max_freq_ratio(void)
{
         struct cppc_perf_caps perf_caps;
         u64 numerator, nominal_perf;
         u64 perf_ratio;
         int rc;

         rc = cppc_get_perf_caps(0, &perf_caps);
         if (rc) {
                 pr_warn("Could not retrieve perf counters (%d)\n", rc);
                 return;
         }
         […]
}
```

With

     include/uapi/asm-generic/errno-base.h:#define	ENODEV		19	/* No such 
device */

this is returned by in `drivers/acpi/cppc_acpi.c`:

```
/**
  * cppc_get_perf_caps - Get a CPU's performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
  * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
  *
  * Return: 0 for success with perf_caps populated else -ERRNO.
  */
int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
{
         struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
         […]
         if (!cpc_desc) {
                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
                 return -ENODEV;
         }
         […]
}
```

Just for your information.


Kind regards,

Paul


> PS:
> 
>> -- 
>>
>> Thanks and Regards
>>
>> Gautham.
> 
> Only if you care: Your signature delimiter misses a space at the end [2].
> 
> 
> [1]: https://www.dell.com/support/manuals/de-de/poweredge-r7625/per7625_ism_pub/system-profile-settings?guid=guid-9f6b6652-4079-45e7-90f5-1c8feee08ec0&lang=en-us
> [2]: https://en.wikipedia.org/wiki/Signature_block#Standard_delimiter
[3]: 
https://lore.kernel.org/linux-pm/d09f52d8-e084-4875-9608-5b3db2554f3d@molgen.mpg.de/T/#t

