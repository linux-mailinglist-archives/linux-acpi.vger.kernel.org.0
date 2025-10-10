Return-Path: <linux-acpi+bounces-17718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E755BCDFDD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A90494FA03F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Oct 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389442FBE12;
	Fri, 10 Oct 2025 16:53:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7922EFDA6;
	Fri, 10 Oct 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115215; cv=none; b=opMZbFw/N+a7W56sHV5bnVf2Vif8RGRAvc/NwGyNGjsvAZb2rycBpnbXFShnhb1vhH4KfHmcTZQC1JkBRwJANzawGNWjC8viWlb3i9mRWmh94MgVWnrfxi8oToqdtbKLlir0zP8T68/S4VVOxq+gERXjb1dbLFlQbKxYcXrARDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115215; c=relaxed/simple;
	bh=Y4U5Qb3P7aLjRMKHQsQcq5XWGo1uLKlM/ipm+bvx0HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el+uyAxzOhRpiaRp7GCmwJY8vZ7ckZXWZAdkSPWnsbYfmz84yo1Q4qvE+QogjiNJSKMdhG0wHWdjTf0Z1sT7CScvoH/vPIDXAqFYK/5JVndROH+cf1ZgJ4lWjvyA+2F7U1IZevlU6UeejF75jxI5lc3HFgfxLjxuutkoEvnizFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAB01713;
	Fri, 10 Oct 2025 09:53:24 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFF23F66E;
	Fri, 10 Oct 2025 09:53:27 -0700 (PDT)
Message-ID: <960a8bf9-63ad-4748-a669-622b2570700a@arm.com>
Date: Fri, 10 Oct 2025 17:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/29] arm_mpam: Add helper to reset saved mbwu state
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-28-james.morse@arm.com>
 <OSZPR01MB87982A954238E8122FF3ABD58B16A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB87982A954238E8122FF3ABD58B16A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 18/09/2025 03:35, Shaopeng Tan (Fujitsu) wrote:
>> resctrl expects to reset the bandwidth counters when the filesystem is
>> mounted.
>>
>> To allow this, add a helper that clears the saved mbwu state. Instead of cross
>> calling to each CPU that can access the component MSC to write to the counter,
>> set a flag that causes it to be zero'd on the the next read. This is easily done by
>> forcing a configuration update.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 3080a81f0845..8254d6190ca2 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -1112,7 +1122,10 @@ static void __ris_msmon_read(void *arg)
>>  	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>>  	clean_msmon_ctl_val(&cur_ctl);
>>  	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>> -	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
>> +	config_mismatch = cur_flt != flt_val ||
>> +			  cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>> +
>> +	if (config_mismatch || reset_on_next_read)
>>  		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);

I don't have a platform that implements any of the bandwidth counters, so may need a hand
to debug this ...


> mbm_handle_overflow() calls __ris_msmon_read() every second. 
> If there are multiple monitor groups, the config_mismatch will "true" every second. 

It shouldn't be - I think you've forced it into a pathalogical case that the resctrl glue
code tries very hard to avoid.

The pattern of allocating a montior, detecing a mismatch and reconfiguring it is needed
for CSU. That stuff is re-usable for MBWU, but you never want it to happen outside
control/monitor group creation because it means you're losing data.

For those reading along at home:
resctrl expects there to be as many hardware monitors as PARTID*PMG - because every
control and monitor group has 'mbm_total_bytes' or equivalent files. User-space can read
these at any time, and the deal is they start at 0 from boot, and reset when the control
or monitor group is created.

This means the MPAM driver needs to have enough, and it needs to pre-configure them on
startup.

The resctrl glue code calls this 'free running'. It means when you call
resctrl_arch_mon_ctx_alloc() for a bandwidth monitor - it doesn't allocate a context, but
returns a magic out of range value 'USE_RMID_IDX' so that subsequent calls use the
pre-allocated monitor.


If you don't have PARTID*PMG's worth of monitors - you can't have resctrl's
mbm_total_bytes interface. People regularly complain about this - but the alternative is
counters that randomly reset, meaning you could never trust the value.
I have no intention of supporting that mode, (its already available in /dev/urandom!)


If you're seeing this mismatch happen from the overflow thread - I think you've forced
the mbwu counters on when you don't have enough monitors.
Even if the resctrl overflow 'thread' used the same mon_ctx - USE_RMID_IDX means it will
access a different hardware monitor each time.
Another option is clean_msmon_ctl_val() is missing a bit that is set by hardware, causing
the values to mismatch when they shouldn't.


Could you check mon_ctx is USE_RMID_IDX, and check which bits are mismatching?


> Then "mbwu_state->prev_val = 0;" in function write_msmon_ctl_flt_vals() will be always run.
> This means that for multiple monitoring groups, the MemoryBandwidth monitoring value is cleared every second.

Yes - this should never happen because the overflow thread should never cause a mismatch,
and the montiros should only be reconfigured when control/monitor groups are allocated.



Thanks,

James

