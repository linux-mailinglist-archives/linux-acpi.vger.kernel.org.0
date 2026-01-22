Return-Path: <linux-acpi+bounces-20509-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KPzMiftcWk/ZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20509-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:25:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FAF647F2
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F251A7E7403
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E934BA21;
	Thu, 22 Jan 2026 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pfZWIrRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957132C939;
	Thu, 22 Jan 2026 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073535; cv=none; b=mJxdEDf0kgTDso7jCSGAJhFIPlJtFRB7bzbux4rxM3eK5AxPZB3LMUliQUehdr/akcb0G2+K4FHA5Ure7KiYGU4AAb22UH2EmKQAyyPCJ0GKHErQ+VAjwRJRBVXo8gXTSvyfKTgJ20SKDeoDMeNpa7bvAOyJ8QLFI+d01fR6wTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073535; c=relaxed/simple;
	bh=k1vLCZxBh2pEce2WLUIty3WrFFC+IYh3CoHUZFCCAnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iu28kwRN2ty90IaPyegBUH/dTQ5M1lmQCQgvqjEUHS3C4T3xpgMXCmb3qat3UOwyhgDiyyXEeZuYVkMfkI6rGxKF+hu3vp3sQAnGhiXFLK+VKV37mSU5Y85TOT0cAa2DEuPYblKtrRACp9kv1QJuSM16SgAt+NaPLB4FffGO9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pfZWIrRg; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hj5qo0VXuLVg7QUuygYodXkqi79esrBXG4hcCec4FkM=;
	b=pfZWIrRgu0AWyxmJKowFYr1F8stIjaWf/j/sNCNQE5rf3Hrg7aEdLiSkGJlcUe9S5fc7gBUHF
	3riCN1sKX9eUwmfl2raal9FImMtY/1FDR4hzCXzVwCGGG1Aa0qIuISwJYjlvRuMvljB6PpctSzB
	lPUq7nKUTmLmoFACp3WpsuQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dxb4l1jd5zmV69;
	Thu, 22 Jan 2026 17:15:19 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D42C40563;
	Thu, 22 Jan 2026 17:18:44 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 17:18:43 +0800
Message-ID: <a7a4d351-eed3-4ea6-a84f-e525b7ac13a6@huawei.com>
Date: Thu, 22 Jan 2026 17:18:42 +0800
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-6-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20509-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 55FAF647F2
X-Rspamd-Action: no action

On 2026/1/20 22:56, Sumit Gupta wrote:
> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
> registers when they are in FFH or SystemMemory address space.
> 
> This keeps the behavior consistent with PCC case where both registers
> are already updated together, but was missing for FFH/SystemMemory.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index de35aeb07833..45c6bd6ec24b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1562,6 +1562,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  	struct cpc_register_resource *auto_sel_reg;
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool autosel_ffh_sysmem;
> +	bool epp_ffh_sysmem;
>  	int ret;
>  
>  	if (!cpc_desc) {
> @@ -1572,6 +1574,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>  	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>  
> +	epp_ffh_sysmem = CPC_SUPPORTED(epp_set_reg) &&
> +		(CPC_IN_FFH(epp_set_reg) || CPC_IN_SYSTEM_MEMORY(epp_set_reg));
> +	autosel_ffh_sysmem = CPC_SUPPORTED(auto_sel_reg) &&
> +		(CPC_IN_FFH(auto_sel_reg) || CPC_IN_SYSTEM_MEMORY(auto_sel_reg));
> +
>  	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
>  		if (pcc_ss_id < 0) {
>  			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> @@ -1597,11 +1604,22 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  		up_write(&pcc_ss_data->pcc_lock);
>  	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> -		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {
> +		if (autosel_ffh_sysmem) {
> +			ret = cpc_write(cpu, auto_sel_reg, enable);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (epp_ffh_sysmem) {
> +			ret = cpc_write(cpu, epp_set_reg,
> +					perf_ctrls->energy_perf);
> +			if (ret)
> +				return ret;
> +		}

Don't know if such a scenario exists, but if one of them is in PCC and the
other is in FFH or system memory, only the one in PCC will be updated
based on your modifications.

>  	} else {
>  		ret = -ENOTSUPP;
> -		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +		pr_debug("_CPC in PCC/FFH/SystemMemory are not supported\n");
>  	}
>  
>  	return ret;


