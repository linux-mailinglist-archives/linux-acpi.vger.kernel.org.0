Return-Path: <linux-acpi+bounces-19842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B0CDD441
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 04:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B09C30019E2
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Dec 2025 03:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CBB26E708;
	Thu, 25 Dec 2025 03:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FITWrUDr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5EA26CE1E;
	Thu, 25 Dec 2025 03:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766634977; cv=none; b=dy4t2CgBGO9X5mgGRsiT7dwU3NkJexgqzYbLVNMmh+b/ut1p9RJFJXm8zjGkvB7y7IgGlwpUCTotqsW2wMIsFQpKsMUxR+lhCXL/iyOLJIrda31fbKJYaf9ZCVA5YktMQ9rBW1/RrXKamYkljspMOGyVD5hZwIA0kRldzV+Ls84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766634977; c=relaxed/simple;
	bh=fMmt53/JJWWP4pjndh+z3lihgDw1Gcx+TyH5M8i6tiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tXbE4xMxZhnchfF9YdFxNS+9O+PhupbM5hbEtiaDgLowWAH7Ei6/X9xmFUHhnEi2oC9UC3gvR8NC4aPT8SIPYU1kkvQrUOKkipSvt7klwbOqwLYS7yeKPTf2ZW184MGj8LHco820kJyoYpGgUG36j4cFgiOkDeCJnRN3mIkdF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FITWrUDr; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SeTeoeWMD6hV4CIob9uwUSK89zuLIoZE1oDuloPtKCQ=;
	b=FITWrUDr6rrlRAI8nb6S2WONTWuA3Su2v7og1znc0LTGo6Zaxq8Y8vsfFPMKtD0GSgfY3mkCM
	MVoZgMobic1/WVso94DUNyXvGWJuE5ZK7sJ34Fj1NRsA0bQaY0iyDW5s0Z0tw+XfUc7zPv89n5+
	jxpy7gzXVIo4opQYqhdwdu8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dcFFh0j55z1prKB;
	Thu, 25 Dec 2025 11:52:56 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 8265640538;
	Thu, 25 Dec 2025 11:56:05 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 11:56:04 +0800
Message-ID: <81f6409e-7909-44f7-9618-5f263b297ce9@huawei.com>
Date: Thu, 25 Dec 2025 11:56:04 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/11] ACPI: CPPC: Extend cppc_set_epp_perf() to
 support auto_sel and epp
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<corbet@lwn.net>, <pierre.gondois@arm.com>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-5-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251223121307.711773-5-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 2025/12/23 20:13, Sumit Gupta wrote:
> Extend cppc_set_epp_perf() to write both auto_sel and energy_perf
> registers when they are in FFH or SystemMemory address space.
> 
> This keeps the behavior consistent with PCC case where both registers
> are already updated together, but was missing for FFH/SystemMemory.
> 
> Also update EPP constants for better clarity:
> - Add CPPC_EPP_PERFORMANCE_PREF (0x00) for performance preference
> - Add CPPC_EPP_ENERGY_EFFICIENCY_PREF (0xFF) for energy efficiency
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c | 35 +++++++++++++++++++++++++++++------
>  include/acpi/cppc_acpi.h |  3 ++-
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4e89fe6aab5..403ee988a8c6 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1556,6 +1556,8 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  	struct cpc_register_resource *auto_sel_reg;
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	bool autosel_ffh_sysmem;
> +	bool epp_ffh_sysmem;
>  	int ret;
>  
>  	if (!cpc_desc) {
> @@ -1566,6 +1568,11 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
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
> @@ -1590,14 +1597,30 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  		/* after writing CPC, transfer the ownership of PCC to platform */
>  		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  		up_write(&pcc_ss_data->pcc_lock);
> -	} else if (osc_cpc_flexible_adr_space_confirmed &&
> -		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
> -		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +	} else if (osc_cpc_flexible_adr_space_confirmed) {
> +		if (!epp_ffh_sysmem && !autosel_ffh_sysmem) {
> +			ret = -EOPNOTSUPP;
> +		} else {

I think this can do the same thing:

	} else if (osc_cpc_flexible_adr_space_confirmed &&
		   (epp_ffh_sysmem || autosel_ffh_sysmem)) {

and reduce the levels of indentation.

> +			if (autosel_ffh_sysmem) {
> +				ret = cpc_write(cpu, auto_sel_reg, enable);
> +				if (ret)
> +					return ret;
> +			}
> +
> +			if (epp_ffh_sysmem) {
> +				ret = cpc_write(cpu, epp_set_reg,
> +						perf_ctrls->energy_perf);
> +				if (ret)
> +					return ret;
> +			}
> +		}
>  	} else {
> -		ret = -ENOTSUPP;
> -		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
> +		ret = -EOPNOTSUPP;
>  	}
>  
> +	if (ret == -EOPNOTSUPP)
> +		pr_debug("CPU%d: _CPC not in PCC/FFH/SystemMemory\n", cpu);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_epp_perf);

The code below is unrelated to the code above and should ideally be
separated into a separate patch I think.

> @@ -1609,7 +1632,7 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   */
>  int cppc_set_epp(int cpu, u64 epp_val)
>  {
> -	if (epp_val > CPPC_ENERGY_PERF_MAX)
> +	if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>  		return -EINVAL;
>  
>  	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 12a1dc31bf2a..2860a0252313 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -39,7 +39,8 @@
>  /* CPPC_AUTO_ACT_WINDOW_MAX_SIG is 127, so 128 and 129 will decay to 127 when writing */
>  #define CPPC_AUTO_ACT_WINDOW_SIG_CARRY_THRESH 129
>  
> -#define CPPC_ENERGY_PERF_MAX	(0xFF)
> +#define CPPC_EPP_PERFORMANCE_PREF		0x00
> +#define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
>  
>  /* Each register has the folowing format. */
>  struct cpc_reg {


