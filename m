Return-Path: <linux-acpi+bounces-18904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56518C5C7EE
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E41E358BB3
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228530BF7F;
	Fri, 14 Nov 2025 10:07:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9C309F02;
	Fri, 14 Nov 2025 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763114864; cv=none; b=ScS/peVQ4E4FTsUjrglv6uQ0d1Y79fItsk+3i07nzGoKjpIWkPPDoSO4x5X94sIwYSNqcFjOP5nVCOkCSIB9fGqbpHx+nXGWdcXeSzCRoloS8xhpBCPQJwDriDzOsRylvPpx1NlRVmtGQE6WbqVh/hNbCHh7WX1HWHeDE4AoR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763114864; c=relaxed/simple;
	bh=1tr4IxSJGYSIZbhpRK4CZZVBYfJnqU+BBY1lCX217Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD0XiA2pswxaT4OJmqlLn0bUvRV6KkAHXkHs1pAGGguIocAWWIQ67X7ZEhUa1h/Xv5D9n5UbhxzL/UaWPslDTu6rlEMgaAu3laaGwRRaRFv1J3BO3a8/1PBqHmWKiTk5UmysuzI3hCnGVGsKQYgbgVcONVA5KNsBTU+psenRYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D91101063;
	Fri, 14 Nov 2025 02:07:33 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7BD3F5A1;
	Fri, 14 Nov 2025 02:07:36 -0800 (PST)
Message-ID: <38f65035-159d-47d9-b88a-15d79552d8ae@arm.com>
Date: Fri, 14 Nov 2025 10:07:35 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] arm_mpam: Add mpam_msmon_read() to read monitor
 value
To: Gavin Shan <gshan@redhat.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-27-ben.horgan@arm.com>
 <61680de1-6732-48a6-a871-9cc9f17f6759@redhat.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <61680de1-6732-48a6-a871-9cc9f17f6759@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gavin,

On 11/9/25 23:13, Gavin Shan wrote:
> Hi Ben,
> 
> On 11/7/25 10:34 PM, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> Reading a monitor involves configuring what you want to monitor, and
>> reading the value. Components made up of multiple MSC may need values
>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>> not ready, then wait the full timeout value before trying again.
>>
>> CC: Shanker Donthineni <sdonthineni@nvidia.com>
>> Cc: Shaopeng Tan (Fujitsu) <tan.shaopeng@fujitsu.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
>> ---
>> Changes since v3:
>> Add tag - thanks
>> Bring config_mismatch into this commit (Jonathan)
>> whitespace
>> ---
>>   drivers/resctrl/mpam_devices.c  | 237 ++++++++++++++++++++++++++++++++
>>   drivers/resctrl/mpam_internal.h |  19 +++
>>   2 files changed, 256 insertions(+)
>>
> 
> With below minor comments addressed:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks!

> 
>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/
>> mpam_devices.c
>> index f51ffb1400db..86abbac5e1ad 100644
>> --- a/drivers/resctrl/mpam_devices.c
>> +++ b/drivers/resctrl/mpam_devices.c
>> @@ -886,6 +886,243 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>>       return 0;
>>   }
>>   +struct mon_read {
>> +    struct mpam_msc_ris        *ris;
>> +    struct mon_cfg            *ctx;
>> +    enum mpam_device_features    type;
>> +    u64                *val;
>> +    int                err;
>> +};
>> +
>> +static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>> +                   u32 *flt_val)
>> +{
>> +    struct mon_cfg *ctx = m->ctx;
>> +
>> +    /*
>> +     * For CSU counters its implementation-defined what happens when not
>> +     * filtering by partid.
>> +     */
>> +    *ctl_val = MSMON_CFG_x_CTL_MATCH_PARTID;
>> +
>> +    *flt_val = FIELD_PREP(MSMON_CFG_x_FLT_PARTID, ctx->partid);
>> +
>> +    if (m->ctx->match_pmg) {
>> +        *ctl_val |= MSMON_CFG_x_CTL_MATCH_PMG;
>> +        *flt_val |= FIELD_PREP(MSMON_CFG_x_FLT_PMG, ctx->pmg);
>> +    }
>> +
>> +    switch (m->type) {
>> +    case mpam_feat_msmon_csu:
>> +        *ctl_val |= MSMON_CFG_CSU_CTL_TYPE_CSU;
>> +
>> +        if (mpam_has_feature(mpam_feat_msmon_csu_xcl, &m->ris->props))
>> +            *flt_val |= FIELD_PREP(MSMON_CFG_CSU_FLT_XCL,
>> +                           ctx->csu_exclude_clean);
> 
> {} missed here.

Changed to one line.

> 
>> +
>> +        break;
>> +    case mpam_feat_msmon_mbwu:
>> +        *ctl_val |= MSMON_CFG_MBWU_CTL_TYPE_MBWU;
>> +
>> +        if (mpam_has_feature(mpam_feat_msmon_mbwu_rwbw, &m->ris->props))
>> +            *flt_val |= FIELD_PREP(MSMON_CFG_MBWU_FLT_RWBW, ctx->opts);
>> +
>> +        break;
>> +    default:
>> +        return;
> 
> s/return/break
> 
> We may add a error message here:
> 
>         pr_warn("Unsupported feature %d\n", m->type);
> 

Using pr_warn("Unexpected monitor type %d\n", m->type);       
> 
>> +    }
>> +}
>> +
>> +static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>> +                    u32 *flt_val)
>> +{
>> +    struct mpam_msc *msc = m->ris->vmsc->msc;
>> +
>> +    switch (m->type) {
>> +    case mpam_feat_msmon_csu:
>> +        *ctl_val = mpam_read_monsel_reg(msc, CFG_CSU_CTL);
>> +        *flt_val = mpam_read_monsel_reg(msc, CFG_CSU_FLT);
>> +        return;
>> +    case mpam_feat_msmon_mbwu:
>> +        *ctl_val = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>> +        *flt_val = mpam_read_monsel_reg(msc, CFG_MBWU_FLT);
>> +        return;
>> +    default:
>> +        return;
>> +    }
>> +}
> 
> s/return/break for all cases, and maybe a warning message for the
> default case.

Done

> 
>> +
>> +/* Remove values set by the hardware to prevent apparent mismatches. */
>> +static void clean_msmon_ctl_val(u32 *cur_ctl)
>> +{
>> +    *cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
>> +}
>> +
> 
> May be worthy be to a inline function.

Done

> 
>> +static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>> +                     u32 flt_val)
>> +{
>> +    struct mpam_msc *msc = m->ris->vmsc->msc;
>> +
>> +    /*
>> +     * Write the ctl_val with the enable bit cleared, reset the counter,
>> +     * then enable counter.
>> +     */
>> +    switch (m->type) {
>> +    case mpam_feat_msmon_csu:
>> +        mpam_write_monsel_reg(msc, CFG_CSU_FLT, flt_val);
>> +        mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val);
>> +        mpam_write_monsel_reg(msc, CSU, 0);
>> +        mpam_write_monsel_reg(msc, CFG_CSU_CTL, ctl_val |
>> MSMON_CFG_x_CTL_EN);
>> +        break;
>> +    case mpam_feat_msmon_mbwu:
>> +        mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>> +        mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
>> +        mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val |
>> MSMON_CFG_x_CTL_EN);
>> +        /* Counting monitors require NRDY to be reset by software */
>> +        mpam_write_monsel_reg(msc, MBWU, 0);
>> +        break;
>> +    default:
>> +        return;
> 
> s/return/break, and maybe a warning message for the default case.

Done. Using the same warning as above.

> 
>> +    }
>> +}
>> +
>> +static void __ris_msmon_read(void *arg)
>> +{
>> +    u64 now;
>> +    bool nrdy = false;
>> +    bool config_mismatch;
>> +    struct mon_read *m = arg;
>> +    struct mon_cfg *ctx = m->ctx;
>> +    struct mpam_msc_ris *ris = m->ris;
>> +    struct mpam_props *rprops = &ris->props;
>> +    struct mpam_msc *msc = m->ris->vmsc->msc;
>> +    u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
>> +
>> +    if (!mpam_mon_sel_lock(msc)) {
>> +        m->err = -EIO;
>> +        return;
>> +    }
>> +    mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
>> +          FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>> +    mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +
>> +    /*
>> +     * Read the existing configuration to avoid re-writing the same
>> values.
>> +     * This saves waiting for 'nrdy' on subsequent reads.
>> +     */
>> +    read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +    clean_msmon_ctl_val(&cur_ctl);
>> +    gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>> +    config_mismatch = cur_flt != flt_val ||
>> +              cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN);
>> +
>> +    if (config_mismatch)
>> +        write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>> +
>> +    switch (m->type) {
>> +    case mpam_feat_msmon_csu:
>> +        now = mpam_read_monsel_reg(msc, CSU);
>> +        if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, rprops))
>> +            nrdy = now & MSMON___NRDY;
>> +        break;
>> +    case mpam_feat_msmon_mbwu:
>> +        now = mpam_read_monsel_reg(msc, MBWU);
>> +        if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
>> +            nrdy = now & MSMON___NRDY;
>> +        break;
>> +    default:
>> +        m->err = -EINVAL;
>> +        break;
> 
> This 'break' can be droped.

Done

> 
>> +    }
>> +    mpam_mon_sel_unlock(msc);
>> +
>> +    if (nrdy) {
>> +        m->err = -EBUSY;
>> +        return;
>> +    }
>> +
>> +    now = FIELD_GET(MSMON___VALUE, now);
>> +    *m->val += now;
>> +}
>> +
>> +static int _msmon_read(struct mpam_component *comp, struct mon_read
>> *arg)
>> +{
>> +    int err, any_err = 0;
>> +    struct mpam_vmsc *vmsc;
>> +
>> +    guard(srcu)(&mpam_srcu);
>> +    list_for_each_entry_srcu(vmsc, &comp->vmsc, comp_list,
>> +                 srcu_read_lock_held(&mpam_srcu)) {
>> +        struct mpam_msc *msc = vmsc->msc;
>> +        struct mpam_msc_ris *ris;
>> +
>> +        list_for_each_entry_srcu(ris, &vmsc->ris, vmsc_list,
>> +                     srcu_read_lock_held(&mpam_srcu)) {
>> +            arg->ris = ris;
>> +
>> +            err = smp_call_function_any(&msc->accessibility,
>> +                            __ris_msmon_read, arg,
>> +                            true);
>> +            if (!err && arg->err)
>> +                err = arg->err;
>> +
>> +            /*
>> +             * Save one error to be returned to the caller, but
>> +             * keep reading counters so that get reprogrammed. On
>> +             * platforms with NRDY this lets us wait once.
>> +             */
>> +            if (err)
>> +                any_err = err;
>> +        }
>> +    }
>> +
>> +    return any_err;
>> +}
>> +
>> +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>> +            enum mpam_device_features type, u64 *val)
>> +{
>> +    int err;
>> +    struct mon_read arg;
>> +    u64 wait_jiffies = 0;
>> +    struct mpam_props *cprops = &comp->class->props;
>> +
>> +    might_sleep();
>> +
>> +    if (!mpam_is_enabled())
>> +        return -EIO;
>> +
>> +    if (!mpam_has_feature(type, cprops))
>> +        return -EOPNOTSUPP;
>> +
>> +    arg = (struct mon_read) {
>> +        .ctx = ctx,
>> +        .type = type,
>> +        .val = val,
>> +    };
>> +    *val = 0;
>> +
>> +    err = _msmon_read(comp, &arg);
>> +    if (err == -EBUSY && comp->class->nrdy_usec)
>> +        wait_jiffies = usecs_to_jiffies(comp->class->nrdy_usec);
>> +
>> +    while (wait_jiffies)
>> +        wait_jiffies = schedule_timeout_uninterruptible(wait_jiffies);
>> +
>> +    if (err == -EBUSY) {
>> +        arg = (struct mon_read) {
>> +            .ctx = ctx,
>> +            .type = type,
>> +            .val = val,
>> +        };
>> +        *val = 0;
>> +
>> +        err = _msmon_read(comp, &arg);
>> +    }
>> +
>> +    return err;
>> +}
>> +
>>   static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16
>> wd)
>>   {
>>       u32 num_words, msb;
>> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/
>> mpam_internal.h
>> index e59c0f4d9ada..d8f8e29987e0 100644
>> --- a/drivers/resctrl/mpam_internal.h
>> +++ b/drivers/resctrl/mpam_internal.h
>> @@ -184,6 +184,22 @@ struct mpam_props {
>>   #define mpam_set_feature(_feat, x)    set_bit(_feat, (x)->features)
>>   #define mpam_clear_feature(_feat, x)    clear_bit(_feat, (x)->features)
>>   +/* The values for MSMON_CFG_MBWU_FLT.RWBW */
>> +enum mon_filter_options {
>> +    COUNT_BOTH    = 0,
>> +    COUNT_WRITE    = 1,
>> +    COUNT_READ    = 2,
>> +};
>> +
>> +struct mon_cfg {
>> +    u16            mon;
>> +    u8            pmg;
>> +    bool            match_pmg;
>> +    bool            csu_exclude_clean;
>> +    u32            partid;
>> +    enum mon_filter_options opts;
>> +};
>> +
>>   struct mpam_class {
>>       /* mpam_components in this class */
>>       struct list_head    components;
>> @@ -327,6 +343,9 @@ void mpam_disable(struct work_struct *work);
>>   int mpam_apply_config(struct mpam_component *comp, u16 partid,
>>                 struct mpam_config *cfg);
>>   +int mpam_msmon_read(struct mpam_component *comp, struct mon_cfg *ctx,
>> +            enum mpam_device_features, u64 *val);
>> +
>>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32
>> cache_level,
>>                      cpumask_t *affinity);
>>   
> Thanks,
> Gavin
> 

Thanks,

Ben


