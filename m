Return-Path: <linux-acpi+bounces-18486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CADC3080E
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71C2421F11
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D9314D13;
	Tue,  4 Nov 2025 10:25:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746E6314B60;
	Tue,  4 Nov 2025 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251900; cv=none; b=fRP9zjMs93dm/2mhv8l2umpYwhyUCGS+HUOBU9+ugyXuWd0aIJAea0E5QqWcHyOQQJUSU4IqZxYGBgtpTiKAhitRpJRppDhNYkScsUisUFiLlgcWI6MreCbhY7zNheZEglIlD32Uu3tSFwF9QCMLrj9a2HTdngl3GpiiiLDKkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251900; c=relaxed/simple;
	bh=KVZNGQPhkhNgH+vsX0tilQCrzEjfAQnpiEgZNc0e2Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBtSphlruYNsIEkDNmUL9oS/0kFbTX6xNLwm+U4Gc2Xg29bTV4FIbOP9vSo7QX7UIoqtNMXEySvDR942wq9nmwPc+LZ63HNX0L7PqmX6th1mO61Z+AMTQPLVdFamBMkhIMejLfuBGxwgYCMo3dORI5B0QarbpEsQW4qGSI3r6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B701CE0;
	Tue,  4 Nov 2025 02:24:49 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4622F3F694;
	Tue,  4 Nov 2025 02:24:52 -0800 (PST)
Message-ID: <293395d7-5766-45df-a2e0-1542fecda5a7@arm.com>
Date: Tue, 4 Nov 2025 10:24:50 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mpam: Clean MBWU monitor overflow bit
To: Zeng Heng <zengheng4@huawei.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, carl@os.amperecomputing.com,
 catalin.marinas@arm.com, dakr@kernel.org, dave.martin@arm.com,
 david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20251017185645.26604-25-james.morse@arm.com>
 <20251029075655.3284280-1-zengheng4@huawei.com>
 <b0ea1879-9e77-4eb3-8312-ce27d73cc1f4@arm.com>
 <f4518f80-8e17-e622-fbe6-e20a7d1c85fc@huawei.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <f4518f80-8e17-e622-fbe6-e20a7d1c85fc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zeng,

On 11/3/25 03:47, Zeng Heng wrote:
> Hi Ben,
> 
> On 2025/10/30 17:52, Ben Horgan wrote:
>> Hi Zeng,
>>
>> On 10/29/25 07:56, Zeng Heng wrote:
>>> The MSMON_MBWU register accumulates counts monotonically forward and
>>> would not automatically cleared to zero on overflow. The overflow
>>> portion
>>> is exactly what mpam_msmon_overflow_val() computes, there is no need to
>>> additionally subtract mbwu_state->prev_val.
>>>
>>> Before invoking write_msmon_ctl_flt_vals(), the overflow bit of the
>>> MSMON_MBWU register must first be read to prevent it from being
>>> inadvertently cleared by the write operation.
>>>
>>> Finally, use the overflow bit instead of relying on counter wrap-around
>>> to determine whether an overflow has occurred, that avoids the case
>>> where
>>> a wrap-around (now > prev_val) is overlooked. So with this, prev_val no
>>> longer has any use and remove it.
>>>
>>> CC: Ben Horgan <ben.horgan@arm.com>
>>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>>> ---
>>>   drivers/resctrl/mpam_devices.c  | 22 +++++++++++++++++-----
>>>   drivers/resctrl/mpam_internal.h |  3 ---
>>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> This all looks fine for overflow, but what we've been forgetting about
>> is the power management. As James mentioned in his commit message, the
>> prev_val is after now check is doing double duty. If an msc is powered
>> down and reset then we lose the count. Hence, to keep an accurate count,
>> we should be considering this case too.
>>
> 
> 
> Regarding CPU power management and CPU on-/off-line scenarios, this
> should and already has been handled by mpam_save_mbwu_state():
> 
> 1. Freezes the current MSMON_MBWU counter into the
> mbwu_state->correction;
> 2. Clears the MSMON_MBWU counter;
> 
> After the CPU is powered back on, the total bandwidth traffic is
> MSMON_MBWU(the `now` variable) + correction.
> 
> So the above solution also covers CPU power-down scenarios, and no
> additional code is needed to adapt to this case.
> 
> If I've missed anything, thanks in advance to point it out.
> 

No, I don't think you missed anything. You just didn't mention in your commit message
that this is also fixing the power management case.

I'm going to post the next version of this series for James as he is otherwise engaged.
I've taken your patch and adapted it to fit in with the order of patches. 
Does this look ok to you? The support for the long counters will be added later.

+static u64 mpam_msmon_overflow_val(enum mpam_device_features type)
+{
+       /* TODO: scaling, and long counters */
+       return BIT_ULL(hweight_long(MSMON___VALUE));
+}
+
 static void __ris_msmon_read(void *arg)
 {
        u64 now;
        bool nrdy = false;
        bool config_mismatch;
+       bool overflow;
        struct mon_read *m = arg;
        struct mon_cfg *ctx = m->ctx;
        struct mpam_msc_ris *ris = m->ris;
@@ -1008,6 +1015,8 @@ static void __ris_msmon_read(void *arg)
         * This saves waiting for 'nrdy' on subsequent reads.
         */
        read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
+       overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
+
        clean_msmon_ctl_val(&cur_ctl);
        gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
        config_mismatch = cur_flt != flt_val ||
@@ -1016,6 +1025,9 @@ static void __ris_msmon_read(void *arg)
        if (config_mismatch) {
                write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
                overflow = false;
+       } else if (overflow) {
+               mpam_write_monsel_reg(msc, CFG_MBWU_CTL,
+                                     cur_ctl & ~MSMON_CFG_x_CTL_OFLOW_STATUS);
        }
 
        switch (m->type) {
@@ -1039,7 +1051,10 @@ static void __ris_msmon_read(void *arg)
                if (overflow)
                        mbwu_state->correction += mpam_msmon_overflow_val(m->type);
 
-               /* Include bandwidth consumed before the last hardware reset */
+               /*
+                * Include bandwidth consumed before the last hardware reset and
+                * a counter size increment for each overflow.
+                */
                now += mbwu_state->correction;
                break;
        default:
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index d10edf4c0f0b..7e9390211df7 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -209,7 +209,8 @@ struct msmon_mbwu_state {
        struct mon_cfg  cfg;
 
        /*
-        * The value to add to the new reading to account for power management.
+        * The value to add to the new reading to account for power management,
+        * and overflow.
         */
        u64             correction;

 
Thanks,

Ben


