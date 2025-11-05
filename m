Return-Path: <linux-acpi+bounces-18543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3DC3590B
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 13:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E55613A7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 12:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85383126CE;
	Wed,  5 Nov 2025 12:11:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40E8BEC;
	Wed,  5 Nov 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344703; cv=none; b=b9X4bDB+BNPjtpjlJVONcbzxeG9TcpsiBZa6jn086MWak4zPDv6ACmUwGFp0wor8xAyrwCROk3FwXP+Fv84U5H4qWcuZuzUsYOYGk6mF5h50k0r8n8kDKm1xRh+6kMw928nIyxfUzAFX4Kf8fxaFCJgjb3xIBOL3i36wC2S2c5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344703; c=relaxed/simple;
	bh=EvS91HJJGx3poXL0hNmUGqtF1maSmGpFIYmrvs+4mMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da60Iu9+bPkNnXMGGiKczczmnhx/ur8EeKuxbijAnQGu9ZNAgyWDdEUHw0xa9cwIpK5DG6DnyikFvzbhu6NjOqPdoanVjPya50rbwSt4PxlrQ7KwIR4QgerpnjrOMyyE5KxCZkdRHizzvH6tJpT2GaUinrwxRZkzgkte9/DSH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7170E169C;
	Wed,  5 Nov 2025 04:11:33 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 973C53F66E;
	Wed,  5 Nov 2025 04:11:36 -0800 (PST)
Message-ID: <597d479f-4f1d-4cae-b15f-21ecc73a35bf@arm.com>
Date: Wed, 5 Nov 2025 12:11:35 +0000
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
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <OSZPR01MB8798C425E5A820C2E0AAA7BC8BC5A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 11/5/25 08:32, Shaopeng Tan (Fujitsu) wrote:
> Hello James,
> 
>> Reading a monitor involves configuring what you want to monitor, and reading
>> the value. Components made up of multiple MSC may need values from each
>> MSC. MSCs may take time to configure, returning 'not ready'.
>> The maximum 'not ready' time should have been provided by firmware.
>>
>> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns not ready,
>> then wait the full timeout value before trying again.
>>
>> CC: Shanker Donthineni <sdonthineni@nvidia.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
[...]
>> +/* Call with MSC lock held */
>> +static void __ris_msmon_read(void *arg) {
>> +	u64 now;
>> +	bool nrdy = false;
>> +	struct mon_read *m = arg;
>> +	struct mon_cfg *ctx = m->ctx;
>> +	struct mpam_msc_ris *ris = m->ris;
>> +	struct mpam_props *rprops = &ris->props;
>> +	struct mpam_msc *msc = m->ris->vmsc->msc;
>> +	u32 mon_sel, ctl_val, flt_val, cur_ctl, cur_flt;
>> +
>> +	if (!mpam_mon_sel_lock(msc)) {
>> +		m->err = -EIO;
>> +		return;
>> +	}
>> +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL,
>> ctx->mon) |
>> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
>> +	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
>> +
>> +	/*
>> +	 * Read the existing configuration to avoid re-writing the same values.
>> +	 * This saves waiting for 'nrdy' on subsequent reads.
>> +	 */
>> +	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
>> +	clean_msmon_ctl_val(&cur_ctl);
>> +	gen_msmon_ctl_flt_vals(m, &ctl_val, &flt_val);
>> +	if (cur_flt != flt_val || cur_ctl != (ctl_val | MSMON_CFG_x_CTL_EN))
>> +		write_msmon_ctl_flt_vals(m, ctl_val, flt_val);
> 
> When reading the CSU counter of a different control group, the counter is cleared to 0 by the write_msmon_ctl_flt_vals().
> 
>> +	switch (m->type) {
>> +	case mpam_feat_msmon_csu:
>> +		now = mpam_read_monsel_reg(msc, CSU);
>> +		if (mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy,
>> rprops))
>> +			nrdy = now & MSMON___NRDY;
>> +		break;
> 
> The first time read the counter(MSMON_CSU), all bits except nrdy are 0.


I'm trying to understand your problem. Isn't what you are describing the
intended behaviour of the nrdy bit? It takes some time to get a count of
the cache utilization so if it's not ready this is set and the driver
retries.

> 
> This means when check the cache monitoring value the first time,
> cat mon_data/mon_L3_0*/llc_occupancy
> the result will be 0.
> From the second time, the result will return to normal.

This is not expected. On creating a new ctrl_mon group, generating some
memory traffic and checking the llc_occumpancy I see a non-zero value on
my setup. Not sure why you wouldn't.

> 
> Best regards,
> Shaopeng TAN
> 

Thanks,

Ben


