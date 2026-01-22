Return-Path: <linux-acpi+bounces-20508-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD7eABfocWkONAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20508-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:04:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0E1642D7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 900DF6A4B33
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBC3ACEED;
	Thu, 22 Jan 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Cs7omK5N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CE3A7F49;
	Thu, 22 Jan 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072176; cv=none; b=NVKLExTKLicNBsibkweEJu+VYVqQ+QNXwI0NXx9tBs7kn76KKp626SCn+D5jzurlo/gz+kt1fuiHmCrQ7Zb12I5RicEidGh2adaTF1T9SA1aCpUxFmn/BEaWP7znHgQQrHCiYC7XaHomWaCF3L95vEaE3jbXqpMgdLXHsbbyk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072176; c=relaxed/simple;
	bh=zo/k6MNrNvcqETtnkBU7N9py2eZd8C0HTvTrCTYeNRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ia4eqo4lHFKd05/sJgg7ya/lBHGTS1L6HOKRmQEGhQPJzScJDzWvjyXSItKkvxlROltHbx/x87cLSHRuT3PwUC4deAR2CzlS4Pdgre6lqPjnMCX026VmQAohzUIX/8CPjAWP+ke18Gj53m07XxwPRAMTIyWSvoLy6byjw6c5LL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Cs7omK5N; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=egbATltjKtI2lDt3jOk7R1/+E4l/hmITyhwUo2UnyFk=;
	b=Cs7omK5NyR4uJO7VAmxcu1sE2rcdo73iU+6c/iYg9a+wUflB0gPeW/Rk07TPI5WNIJOSHNSNl
	Zg8OCiQx3J89s8VGX5GfxfqqiSnikoO+TZaZsSzJKTFMOgzyK5ePYvO5NneAo3/F9Nvw5d3Xi14
	0hRS58CCvFcNw+Tuq7J/A6g=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dxZZd0tRlz1cyTK;
	Thu, 22 Jan 2026 16:52:41 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 012E940538;
	Thu, 22 Jan 2026 16:56:05 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 16:56:03 +0800
Message-ID: <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
Date: Thu, 22 Jan 2026 16:56:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
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
 <20260120145623.2959636-5-sumitg@nvidia.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20260120145623.2959636-5-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20508-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,huawei.com:mid,huawei.com:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: DD0E1642D7
X-Rspamd-Action: no action

On 2026/1/20 22:56, Sumit Gupta wrote:
> Add cppc_get_perf() function to read values of performance control
> registers including desired_perf, min_perf, max_perf, energy_perf,
> and auto_sel.
> 
> This provides a read interface to complement the existing
> cppc_set_perf() write interface for performance control registers.
> 
> Note that auto_sel is read by cppc_get_perf() but not written by
> cppc_set_perf() to avoid unintended mode changes during performance
> updates. It can be updated with existing dedicated cppc_set_auto_sel()
> API.
> 
> Use cppc_get_perf() in cppc_cpufreq_get_cpu_data() to initialize
> perf_ctrls with current hardware register values during cpufreq
> policy initialization.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 80 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c |  6 +++
>  include/acpi/cppc_acpi.h       |  5 +++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a09bdabaa804..de35aeb07833 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1739,6 +1739,86 @@ int cppc_set_enable(int cpu, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_enable);
>  
> +/**
> + * cppc_get_perf - Get a CPU's performance controls.
> + * @cpu: CPU for which to get performance controls.
> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
> + *
> + * Return: 0 for success with perf_ctrls, -ERRNO otherwise.
> + */
> +int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *desired_perf_reg,
> +				     *min_perf_reg, *max_perf_reg,
> +				     *energy_perf_reg, *auto_sel_reg;
> +	u64 desired_perf = 0, min = 0, max = 0, energy_perf = 0, auto_sel = 0;
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = 0, regs_in_pcc = 0;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	if (!perf_ctrls) {
> +		pr_debug("Invalid perf_ctrls pointer\n");
> +		return -EINVAL;
> +	}
> +
> +	desired_perf_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	/* Are any of the regs PCC ?*/
> +	if (CPC_IN_PCC(desired_perf_reg) || CPC_IN_PCC(min_perf_reg) ||
> +	    CPC_IN_PCC(max_perf_reg) || CPC_IN_PCC(energy_perf_reg) ||
> +	    CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id for CPU:%d\n", cpu);
> +			return -ENODEV;
> +		}
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +		regs_in_pcc = 1;
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* Ring doorbell once to update PCC subspace */
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) < 0) {
> +			ret = -EIO;
> +			goto out_err;
> +		}
> +	}
> +
> +	/* Read optional elements if present */
> +	if (CPC_SUPPORTED(max_perf_reg))
> +		cpc_read(cpu, max_perf_reg, &max);
> +	perf_ctrls->max_perf = max;
> +
> +	if (CPC_SUPPORTED(min_perf_reg))
> +		cpc_read(cpu, min_perf_reg, &min);
> +	perf_ctrls->min_perf = min;
> +
> +	if (CPC_SUPPORTED(desired_perf_reg))
> +		cpc_read(cpu, desired_perf_reg, &desired_perf);
> +	perf_ctrls->desired_perf = desired_perf;

desired_perf_reg is not an optional one, so it has to be supported.

> +
> +	if (CPC_SUPPORTED(energy_perf_reg))
> +		cpc_read(cpu, energy_perf_reg, &energy_perf);
> +	perf_ctrls->energy_perf = energy_perf;
> +
> +	if (CPC_SUPPORTED(auto_sel_reg))
> +		cpc_read(cpu, auto_sel_reg, &auto_sel);
> +	perf_ctrls->auto_sel = (bool)auto_sel;
> +
> +out_err:
> +	if (regs_in_pcc)
> +		up_write(&pcc_ss_data->pcc_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf);
> +
>  /**
>   * cppc_set_perf - Set a CPU's performance controls.
>   * @cpu: CPU for which to set performance controls.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index c95dcd7719c3..229880c4eedb 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -594,6 +594,12 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
>  		goto free_mask;
>  	}
>  
> +	ret = cppc_get_perf(cpu, &cpu_data->perf_ctrls);
> +	if (ret) {
> +		pr_debug("Err reading CPU%d perf ctrls: ret:%d\n", cpu, ret);
> +		goto free_mask;
> +	}
> +
>  	return cpu_data;
>  
>  free_mask:
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 4d644f03098e..3fc796c0d902 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -151,6 +151,7 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>  extern int cppc_get_highest_perf(int cpunum, u64 *highest_perf);
>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
> +extern int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> @@ -193,6 +194,10 @@ static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>  	return -EOPNOTSUPP;


