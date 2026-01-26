Return-Path: <linux-acpi+bounces-20609-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vOvRA5ghd2lmcgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20609-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 09:11:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EF385597
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 09:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB983003342
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 08:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CE2F6935;
	Mon, 26 Jan 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LKNeZMbq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7A27A47F;
	Mon, 26 Jan 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415061; cv=none; b=goBPBYRCXwZhtpUrMX+38B7IWdGAGJiF32vR5toAqWt7DfapGNN/nMp7SeIBTE0O/4ql+yuxZU9g7Vvgb67EoFUQxjQn0CGKajjSIdFKGO1/TTcp1XFRzrOYqsRmxF545X750xN/CuGUICFHj35esC16eYYbF7iGF36Bm4cw4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415061; c=relaxed/simple;
	bh=GR3zckIVpt6LCL6jaARW/kyCfDLSF1sXbOxzIXTnr6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kh9yCQxDGCchzxWtwl9tgmGpqCib/nH7n1artrh1m2wjLFrzGOdUP6kHA5qLRz458wVmUgA+hJ5efiVxuBYfSi6+u5GARecFURqu5OJfDrkr83KAdB6jGI4BPYx0Q9Wzpsu60luFqrBH7yLumI6c3ov/i2eifVIxynDIrixtA3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LKNeZMbq; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YyYWratAnhyYvIsPU6aAB6x0/xonNgcbkzbNqPshYGQ=;
	b=LKNeZMbqFLdvYz2YeBy0aAN1E+7l3nKA5q817rd/b/G3STx/GRuBXiAD5c861+osb+hPe8NUC
	pvDYwKR//CrXuJwdmkMyKZGn2JYr8OLoJ3RAXiHnM6epBPN8ctp87YALoaZ/2SLjIRhOY7Er/YS
	BmQvUpYiD+1CrPP+7DxOHXg=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f01Mz3VmGznTVZ;
	Mon, 26 Jan 2026 16:06:55 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F6D740363;
	Mon, 26 Jan 2026 16:10:50 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 16:10:49 +0800
Message-ID: <7e86cdbe-f16c-4fe8-92c5-e6fb89f49811@huawei.com>
Date: Mon, 26 Jan 2026 16:10:49 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] ACPI: CPPC: Extend cppc_set_epp_perf() for
 FFH/SystemMemory
To: Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<vsethi@nvidia.com>, <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
	<nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-6-sumitg@nvidia.com>
 <a7a4d351-eed3-4ea6-a84f-e525b7ac13a6@huawei.com>
 <86303677-6124-424f-999d-c420eac0cceb@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <86303677-6124-424f-999d-c420eac0cceb@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-20609-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95EF385597
X-Rspamd-Action: no action

On 2026/1/25 4:08, Sumit Gupta wrote:
> 
> On 22/01/26 14:48, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
>>> registers when they are in FFH or SystemMemory address space.
>>>
>>> This keeps the behavior consistent with PCC case where both registers
>>> are already updated together, but was missing for FFH/SystemMemory.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index de35aeb07833..45c6bd6ec24b 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1562,6 +1562,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>        struct cpc_register_resource *auto_sel_reg;
>>>        struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>        struct cppc_pcc_data *pcc_ss_data = NULL;
>>> +     bool autosel_ffh_sysmem;
>>> +     bool epp_ffh_sysmem;
>>>        int ret;
>>>
>>>        if (!cpc_desc) {
>>> @@ -1572,6 +1574,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>        auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>        epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>
>>> +     epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
>>> +             (CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
>>> +     autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
>>> +             (CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
>>> +
>>>        if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>>>                if (pcc_ss_id < 0) {
>>>                        pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
>>> @@ -1597,11 +1604,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>                ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>>>                up_write(&pcc_ss_data->pcc_lock);
>>>        } else if (osc_cpc_flexible_adr_space_confirmed &&
>>> -                CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
>>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>> +                (epp_ffh_sysmem || autosel_ffh_sysmem)) {
>>> +             if (autosel_ffh_sysmem) {
>>> +                     ret = cpc_write(cpu, auto_sel_reg, enable);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +
>>> +             if (epp_ffh_sysmem) {
>>> +                     ret = cpc_write(cpu, epp_set_reg,
>>> +                                     perf_ctrls->energy_perf);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>> Don't know if such a scenario exists, but if one of them is in PCC and the
>> other is in FFH or system memory, only the one in PCC will be updated
>> based on your modifications.
> The current code handles mixed cases correctly.
> When either register is in PCC, the first if block executes and calls
> cpc_write() for both registers. The cpc_write() internally handles
> each register's type (PCC, FFH, or SystemMemory)

Yes, I was wrong.

According to the first if block, cpc_wite() is OK to be called for a
register not in PCC. So it looks like this 'else if' is unnecessary. Only
CPC_SUPPORTED is needed to be checked before calling cpc_write(), isn't it?

> 
> 
> Thank you,
> Sumit Gupta
> 
> 
> 
>>>        } else {
>>>                ret = -ENOTSUPP;
>>> -             pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
>>> +             pr_debug("_CPC in PCC/FFH/SystemMemory are not supported\n");
>>>        }
>>>
>>>        return ret;


