Return-Path: <linux-acpi+bounces-18575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0416C3A35D
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 11:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAB5A50021E
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4D30C628;
	Thu,  6 Nov 2025 10:11:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC412DF131;
	Thu,  6 Nov 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423914; cv=none; b=KsZbvIeZAABN0+FLMCsWsJIZJCsx8LnPlpMcarOBXKR6EKh/N75elkrJV7qCuzf+q618Lvm7nu0TK1CfL0KaLzGH7imjMA10CuOk6pd/c9uWbc4TU5FSmLSEi/vd3ZM0HBurjkQGBnTduKZ9Y5qmtU1Nthftvu6H+Pz3t4QzfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423914; c=relaxed/simple;
	bh=fUWCL+8USFcluuOyJ1yfpV0/AIk5Xei978ERyPPXQCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvAO4vs8G7LDKq7GGZnmNvb8/wDkiXtge78QbsVkD6ZAdJmJdmmDWLMKXsB8IaIDnnICzwwPb5EMCFlsHxmB2T/YcAB0TPkG9pQIMVFSfVbSzuQCNnP5xr+zr9fHeAScwqczp1WywEPbsUyLcSY4FDSoZyOTaRw7s/qiftMGZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1449C1596;
	Thu,  6 Nov 2025 02:11:44 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40ECF3F66E;
	Thu,  6 Nov 2025 02:11:47 -0800 (PST)
Message-ID: <d6b4d9d5-f5bc-4a7d-a221-4451456fbbd3@arm.com>
Date: Thu, 6 Nov 2025 10:11:45 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/29] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: Peter Newman <peternewman@google.com>,
 "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Cc: James Morse <james.morse@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-21-james.morse@arm.com>
 <OSZPR01MB8798162B444DA35707A4E3798BFCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
 <CALPaoChLKRQqjZO+O92WQ=MsWjV+q=hVE8=BXCOdkta6ZEXNMQ@mail.gmail.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <CALPaoChLKRQqjZO+O92WQ=MsWjV+q=hVE8=BXCOdkta6ZEXNMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shaopeng, Peter,

On 11/5/25 16:16, Peter Newman wrote:
> On Mon, Oct 27, 2025 at 9:48 AM Shaopeng Tan (Fujitsu)
> <tan.shaopeng@fujitsu.com> wrote:
>>
>> Hello James,
>>
>>> When CPUs come online the MSC's original configuration should be restored.
>>>
>>> Add struct mpam_config to hold the configuration. This has a bitmap of
>>> features that were modified. Once the maximum partid is known, allocate a
>>> configuration array for each component, and reprogram each RIS configuration
>>> from this.
>>>
>>> CC: Dave Martin <Dave.Martin@arm.com>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>>> ---
>>> Changes since v2:
>>>  * Call mpam_init_reset_cfg() on alloated config as 0 is not longer correct.
>>>  * init_garbage() on each config - the array has to be freed in one go, but
>>>    otherwise this looks weird.
>>>  * Use struct initialiser in mpam_init_reset_cfg(),
>>>  * Moved int err definition.
>>>  * Removed srcu lock taking based on squinting at the only caller.
>>>  * Moved config reset to mpam_reset_component_cfg() for re-use in
>>>    mpam_reset_component_locked(), previous memset() was not enough
>>> since zero
>>>    no longer means reset.
>>>
>>> Changes since v1:
>>>  * Switched entry_rcu to srcu versions.
>>>
>>> Changes since RFC:
>>>  * Added a comment about the ordering around max_partid.
>>>  * Allocate configurations after interrupts are registered to reduce churn.
>>>  * Added mpam_assert_partid_sizes_fixed();
>>>  * Make reset use an all-ones instead of zero config.
>>> ---
>>>  drivers/resctrl/mpam_devices.c  | 284
>>> +++++++++++++++++++++++++++++---
>>> drivers/resctrl/mpam_internal.h |  23 +++
>>>  2 files changed, 287 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
>>> index ab37ed1fb5de..e990ef67df5b 100644
>>> --- a/drivers/resctrl/mpam_devices.c
>>> +++ b/drivers/resctrl/mpam_devices.c
>>> @@ -118,6 +118,17 @@ static inline void init_garbage(struct mpam_garbage
>>> *garbage)  {
>>>       init_llist_node(&garbage->llist);
>>>  }
>>> +
>>> +/*
>>> + * Once mpam is enabled, new requestors cannot further reduce the
>>> +available
>>> + * partid. Assert that the size is fixed, and new requestors will be
>>> +turned
>>> + * away.
>>> + */
>>> +static void mpam_assert_partid_sizes_fixed(void)
>>> +{
>>> +     WARN_ON_ONCE(!partid_max_published);
>>> +}
>>> +
>>>  static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)  {
>>>       WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
>>> &msc->accessibility)); @@ -366,12 +377,16 @@ static void
>>> mpam_class_destroy(struct mpam_class *class)
>>>       add_to_garbage(class);
>>>  }
>>>
>>> +static void __destroy_component_cfg(struct mpam_component *comp);
>>> +
>>>  static void mpam_comp_destroy(struct mpam_component *comp)  {
>>>       struct mpam_class *class = comp->class;
>>>
>>>       lockdep_assert_held(&mpam_list_lock);
>>>
>>> +     __destroy_component_cfg(comp);
>>> +
>>>       list_del_rcu(&comp->class_list);
>>>       add_to_garbage(comp);
>>>
>>> @@ -812,48 +827,102 @@ static void mpam_reset_msc_bitmap(struct
>>> mpam_msc *msc, u16 reg, u16 wd)
>>>       __mpam_write_reg(msc, reg, bm);
>>>  }
>>>
>>> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>>> +/* Called via IPI. Call while holding an SRCU reference */ static void
>>> +mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>>> +                                   struct mpam_config *cfg)
>>>  {
>>>       struct mpam_msc *msc = ris->vmsc->msc;
>>>       struct mpam_props *rprops = &ris->props;
>>>
>>> -     WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
>>> -
>>>       mutex_lock(&msc->part_sel_lock);
>>>       __mpam_part_sel(ris->ris_idx, partid, msc);
>>>
>>> -     if (mpam_has_feature(mpam_feat_cpor_part, rprops))
>>> -             mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
>>> rprops->cpbm_wd);
>>> +     if (mpam_has_feature(mpam_feat_cpor_part, rprops) &&
>>> +         mpam_has_feature(mpam_feat_cpor_part, cfg)) {
>>> +             if (cfg->reset_cpbm)
>>> +                     mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
>>> +                                           rprops->cpbm_wd);
>>> +             else
>>> +                     mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
>>> +     }
>>>
>>> -     if (mpam_has_feature(mpam_feat_mbw_part, rprops))
>>> -             mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
>>> rprops->mbw_pbm_bits);
>>> +     if (mpam_has_feature(mpam_feat_mbw_part, rprops) &&
>>> +         mpam_has_feature(mpam_feat_mbw_part, cfg)) {
>>> +             if (cfg->reset_mbw_pbm)
>>> +                     mpam_reset_msc_bitmap(msc,
>>> MPAMCFG_MBW_PBM,
>>> +                                           rprops->mbw_pbm_bits);
>>> +             else
>>> +                     mpam_write_partsel_reg(msc, MBW_PBM,
>>> cfg->mbw_pbm);
>>> +     }
>>>
>>> -     if (mpam_has_feature(mpam_feat_mbw_min, rprops))
>>> +     if (mpam_has_feature(mpam_feat_mbw_min, rprops) &&
>>> +         mpam_has_feature(mpam_feat_mbw_min, cfg))
>>>               mpam_write_partsel_reg(msc, MBW_MIN, 0);
>>>
>>> -     if (mpam_has_feature(mpam_feat_mbw_max, rprops))
>>> -             mpam_write_partsel_reg(msc, MBW_MAX,
>>> MPAMCFG_MBW_MAX_MAX);
>>> +     if (mpam_has_feature(mpam_feat_mbw_max, rprops) &&
>>> +         mpam_has_feature(mpam_feat_mbw_max, cfg))
>>> +             mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
>>>
>>>       mutex_unlock(&msc->part_sel_lock);
>>>  }
>>>
>>> +struct reprogram_ris {
>>> +     struct mpam_msc_ris *ris;
>>> +     struct mpam_config *cfg;
>>> +};
>>> +
>>> +/* Call with MSC lock held */
>>> +static int mpam_reprogram_ris(void *_arg) {
>>> +     u16 partid, partid_max;
>>> +     struct reprogram_ris *arg = _arg;
>>> +     struct mpam_msc_ris *ris = arg->ris;
>>> +     struct mpam_config *cfg = arg->cfg;
>>> +
>>> +     if (ris->in_reset_state)
>>> +             return 0;
>>> +
>>> +     spin_lock(&partid_max_lock);
>>> +     partid_max = mpam_partid_max;
>>> +     spin_unlock(&partid_max_lock);
>>> +     for (partid = 0; partid <= partid_max + 1; partid++)
>>> +             mpam_reprogram_ris_partid(ris, partid, cfg);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void mpam_init_reset_cfg(struct mpam_config *reset_cfg) {
>>> +     *reset_cfg = (struct mpam_config) {
>>> +             .cpbm = ~0,
>>> +             .mbw_pbm = ~0,
>>> +             .mbw_max = MPAMCFG_MBW_MAX_MAX,
>>
>> When rdtgroup_schemata_show() is called, the "cpbm" value is output to the schema file.
>> Since bitmap lengths are chip-dependent, I think we just need to reset the bitmap length portion.
>> Otherwise, 0xffffffff(u32) will be output from the schemata file.
> 
> When I apply additional patches to add the mpam_resctrl.c stuff I
> notice this too:
> 
> # grep L3 schemata
> L3:1=ffffffff
> # cat info/L3/shareable_bits
> ffff
> 
> I noticed that new groups also get a too-long cbm as long as any other
> groups have a too-long cbm. Maybe this out-of-range value is bleeding
> into new groups in __init_one_rdt_domain() when it calls
> resctrl_arch_get_config() on all other groups.
> 
> -Peter

mpam_init_reset_cfg() is used in places, one for ris reset and another
for component reset. In component reset these values persist and with
resctrl support added turn up in the schemata. More significantly, the
reset flags, reset_cpbm etc, are not reset to false and so the control
configuration doesn't take effect. I have an update for the component
case which I'll include when I repost this series for James.

Thanks,

Ben


