Return-Path: <linux-acpi+bounces-16505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21814B497BB
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F707B59AA
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921D3148B0;
	Mon,  8 Sep 2025 17:58:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C823CB;
	Mon,  8 Sep 2025 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354325; cv=none; b=nMRYjLxjqaXAUbIicMrrgP/N32Kxvg4TDmBEEMGnxUeOsRF3FdIV6Zerm+iljqi+xw2h3RarvAS7oNosmeGbdSB+R5G1dkmGof1ddeJAnuFxkiSL19r6AaSyycL1E7T9kNLTAjT0nDrGKYTHrjh6r+G06nrnApPsfKvY9RkLdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354325; c=relaxed/simple;
	bh=e9IUfmE03jXeUwHUQ/DiuTlKUAu9POx7DXBahXNAKzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbq9xuwLo9T7Ru8Kvv5p5MEwnP5l67zBQCB6rii36axTupN3CO+Z/wlgMA4ZKNtdFmLObx4Kzi0SJ3R2vPWQYr3ygJ5aJI/067fmA9QeQMEfkeTvbZwNxIW7YwPII2b8X47pGcpej6JheBv1y2x+2EEbc+0ABC5ADjVFNg4dRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8C621692;
	Mon,  8 Sep 2025 10:58:34 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E47D3F694;
	Mon,  8 Sep 2025 10:58:36 -0700 (PDT)
Message-ID: <4ef6d9d0-cebc-4b51-a200-8b1c395030e4@arm.com>
Date: Mon, 8 Sep 2025 18:58:34 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] arm_mpam: Add cpuhp callbacks to probe MSC hardware
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Lecopzer Chen <lecopzerc@nvidia.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-15-james.morse@arm.com>
 <CAL_JsqK5HZdyq_6rQibtmDE_H=gy+3aeCSCioA5MHR5+Gh_drQ@mail.gmail.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <CAL_JsqK5HZdyq_6rQibtmDE_H=gy+3aeCSCioA5MHR5+Gh_drQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rob,

On 27/08/2025 17:08, Rob Herring wrote:
> On Fri, Aug 22, 2025 at 10:32 AM James Morse <james.morse@arm.com> wrote:
>>
>> Because an MSC can only by accessed from the CPUs in its cpu-affinity
>> set we need to be running on one of those CPUs to probe the MSC
>> hardware.
>>
>> Do this work in the cpuhp callback. Probing the hardware will only
>> happen before MPAM is enabled, walk all the MSCs and probe those we can
>> reach that haven't already been probed.
>>
>> Later once MPAM is enabled, this cpuhp callback will be replaced by
>> one that avoids the global list.
>>
>> Enabling a static key will also take the cpuhp lock, so can't be done
>> from the cpuhp callback. Whenever a new MSC has been probed schedule
>> work to test if all the MSCs have now been probed.

>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>> index 5baf2a8786fb..9d6516f98acf 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -78,6 +90,22 @@ LIST_HEAD(mpam_classes);
>>  /* List of all objects that can be free()d after synchronise_srcu() */
>>  static LLIST_HEAD(mpam_garbage);
>>
>> +static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>> +{
>> +       WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
>> +       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> 
> These either make __mpam_read_reg uninlined or add 2 checks to every
> register read. Neither seems very good.

The mapping-bounds one is from before the ACPI table had the size of the mapping. I can
remove that one now.

The accessibility one really needs checking as getting this wrong will only occasionally
cause a deadlock if you get unlucky with power-management. I don't think we'd ever manage
to debug that, hence the check. The server platforms we'll see first aren't going to
bother with PSCI CPU_SUSPEND - but mobile devices will.

If the compiler choses not to inline this, I'm fine with that. Accesses to the device
mapped configuration are rare, and always via a resctrl filesystem access. I don't think
the performance matters.


>> +
>> +       return readl_relaxed(msc->mapped_hwpage + reg);
>> +}
>> +
>> +static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>> +{
>> +       lockdep_assert_held_once(&msc->part_sel_lock);
> 
> Similar thing here.

If don't build with lockdep this costs you nothing.


>> +       return __mpam_read_reg(msc, reg);
>> +}
>> +
>> +#define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
>> +
>>  #define init_garbage(x)        init_llist_node(&(x)->garbage.llist)
>>
>>  static struct mpam_vmsc *
>> @@ -511,9 +539,84 @@ int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>>         return err;
>>  }
>>
>> -static void mpam_discovery_complete(void)
> 
> It is annoying to review things which disappear in later patches...

It's a printk - its purpose was to show something happens once all the MSC have been
probed. That was supposed to make it easier to review as it has always has this shape from
the beginning. This patch adds the hardware accesses that do the probing, which happen
from cpuhp calls - which in turn moves this 'complete' work to be scheduled.
As this seems to be causing confusion I'll inline it so it doesn't look strange.


>> +static int mpam_msc_hw_probe(struct mpam_msc *msc)
>> +{
>> +       u64 idr;
>> +       int err;
>> +
>> +       lockdep_assert_held(&msc->probe_lock);
>> +
>> +       mutex_lock(&msc->part_sel_lock);
>> +       idr = mpam_read_partsel_reg(msc, AIDR);
> 
> I don't think AIDR access depends on PART_SEL.

It doesn't, but as most registers do, it was just simpler to pretend it does.

I'll shove the __version in here instead, which will save taking the lock.


>> +       if ((idr & MPAMF_AIDR_ARCH_MAJOR_REV) != MPAM_ARCHITECTURE_V1) {
>> +               pr_err_once("%s does not match MPAM architecture v1.x\n",
>> +                           dev_name(&msc->pdev->dev));
>> +               err = -EIO;
>> +       } else {
>> +               msc->probed = true;
>> +               err = 0;
>> +       }
>> +       mutex_unlock(&msc->part_sel_lock);
>> +
>> +       return err;
>> +}

>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
>> index 6e0982a1a9ac..a98cca08a2ef 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -59,14 +60,14 @@ struct mpam_msc {
>>          * part_sel_lock protects access to the MSC hardware registers that are
>>          * affected by MPAMCFG_PART_SEL. (including the ID registers that vary
>>          * by RIS).
>> -        * If needed, take msc->lock first.
>> +        * If needed, take msc->probe_lock first.
> 
> Humm. I think this belongs in patch 10.

Yup, fixed.


Thanks,

James

