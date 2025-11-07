Return-Path: <linux-acpi+bounces-18622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0FC3F4BE
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3CE188BD1C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253D2C326A;
	Fri,  7 Nov 2025 10:01:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D90156661;
	Fri,  7 Nov 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509696; cv=none; b=U5Cfh42UeK23H+AywrVydX78SS5mgFCKocbG9l9PsiZYHXo09GmueknRwonILg/syk/cv/ZjYG6r6dkm/BddnMWbPhbn6RSlpMsukCVro03rTaORfm6dz0yIVQE5p+5fMHmF/FZOS+xg34m43D1GLSbqerYYUOpq7ZTVLxxPfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509696; c=relaxed/simple;
	bh=I3SvcWbt5UCgbtrbH4LHKbVopaxMAOlYurhZkaJBqkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRvN+iqmViyfEyOl/ZHqUTN4InRczjwMGsZCANu+9W7VoG3yOaC7VROQzKvEZPBNMAixILhb9vKuAX4xc4izDIqu0p9GQ4SlJjfwGbV24BUrrG1IG1fTOcHHL7H5L4Le9JCWIsZlNQmOb+pLJ2WIJOU+P6WQsrmKjEKPsDJxkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C5614BF;
	Fri,  7 Nov 2025 02:01:25 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1013F66E;
	Fri,  7 Nov 2025 02:01:28 -0800 (PST)
Message-ID: <44ce4a5b-b210-4fd0-9676-51173d5f5b8c@arm.com>
Date: Fri, 7 Nov 2025 10:01:27 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/29] arm_mpam: Add mpam_msmon_read() to read monitor
 value
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 'James Morse' <james.morse@arm.com>,
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
 <20251017185645.26604-24-james.morse@arm.com>
 <OSZPR01MB8798C425E5A820C2E0AAA7BC8BC5A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
 <597d479f-4f1d-4cae-b15f-21ecc73a35bf@arm.com>
 <OSZPR01MB8798EEEF42B16AD8F35DE8EE8BC3A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <OSZPR01MB8798EEEF42B16AD8F35DE8EE8BC3A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 11/7/25 05:01, Shaopeng Tan (Fujitsu) wrote:
> Hi Ben,
> 
>> Hi Shaopeng,
>>
>> On 11/5/25 08:32, Shaopeng Tan (Fujitsu) wrote:
>>> Hello James,
>>>
>>>> Reading a monitor involves configuring what you want to monitor, and
>>>> reading the value. Components made up of multiple MSC may need values
>>>> from each MSC. MSCs may take time to configure, returning 'not ready'.
>>>> The maximum 'not ready' time should have been provided by firmware.
>>>>
>>>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
>>>> not ready, then wait the full timeout value before trying again.
>>>>
>>>> CC: Shanker Donthineni <sdonthineni@nvidia.com>
>>>> Signed-off-by: James Morse <james.morse@arm.com>
>> [...]
>>>> +/* Call with MSC lock held */
>>>> +static void __ris_msmon_read(void *arg) {
>>>> +	u64 now;
>>>> +	bool nrdy = false;
>>>> +	struct mon_read *m = arg;
>>>> +	struct mon_cfg *ctx = m->ctx;
>>>> +	struct mpam_msc_ris *ris = m->ris;
>>>> +	struct mpam_props *rprops = &ris->props;
>>>> +	struct mpam_msc *msc = m->ris->vmsc->msc;
>>>> +	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
>>>> +
>>>> +	if (!mpam_mon_sel_lock(msc)) {
>>>> +		m->err = -EIO;
>>>> +		return;
>>>> +	}
>>>> +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL,
>>>> ctx->mon) |
>>>> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>>>> +	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>>>> +
>>>> +	/*
>>>> +	 * Read the existing configuration to avoid re-writing the same values.
>>>> +	 * This saves waiting for 'nrdy' on subsequent reads.
>>>> +	 */
>>>> +	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>>>> +	clean_msmon_ctl_val(&cur_ctl);
>>>> +	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>>>> +	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
>>>> +		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
>>>
>>> When reading the CSU counter of a different control group, the counter is
>> cleared to 0 by the write_msmon_ctl_flt_vals().
>>>
>>>> +	switch (m->type) {
>>>> +	case mpam_feat_msmon_csu:
>>>> +		now = mpam_read_monsel_reg(msc, CSU);
>>>> +		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy,
>>>> rprops))
>>>> +			nrdy = now & MSMON___NRDY;
>>>> +		break;
>>>
>>> The first time read the counter(MSMON_CSU), all bits except nrdy are 0.
>>
>>
>> I'm trying to understand your problem. Isn't what you are describing the
>> intended behaviour of the nrdy bit? It takes some time to get a count of the
>> cache utilization so if it's not ready this is set and the driver retries.
> 
> I apologize for not explain it correctly.
> The key point is that for some SOC chip, if `mpam_feat_msmon_csu_hw_nrdy` is false,
> the NRDY bit value of counter(MSMON_CSU) cannot be set to 'nrdy'.
> 'nrdy' will keep its initial value(false).

Ok, so if I understand correctly, your hardware takes some time to
generate the csu monitor value but doesn't have a hardware control of
the nrdy bit to mark the value as unreliable. When this bit is under
software control then the behaviour is implementation defined. Some what
wierdly the spec says "If a monitor does not support automatic behavior
of NRDY, software can use this bit for any purpose.". I would expect a
quirk for your platform could be added to delay after CSU configuration
but this is out of scope for this series.


> 
>>> This means when check the cache monitoring value the first time, cat
>>> mon_data/mon_L3_0*/llc_occupancy the result will be 0.
>>> From the second time, the result will return to normal.
>>
>> This is not expected. On creating a new ctrl_mon group, generating some
>> memory traffic and checking the llc_occumpancy I see a non-zero value on my
>> setup. Not sure why you wouldn't.
> 
> Best regards,
> Shaopeng TAN
> 

Thanks,

Ben


