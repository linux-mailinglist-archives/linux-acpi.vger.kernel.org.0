Return-Path: <linux-acpi+bounces-10176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9459F4CC6
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C8B162810
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745741F4E38;
	Tue, 17 Dec 2024 13:48:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D31EF1D;
	Tue, 17 Dec 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443316; cv=none; b=Mc4MaoMENSKVxWFghHRotIjQf7ih52dDlcMcA90OFjiHPyN0gkG4xGnHpMScX9TurVIXHdOoGLoWbmTNRytRM/ltWFif8uI5it0YtnYgDJ16grKpSmii9mg/CUHXjfSxTekxLyhhhQyoTyq+4lwcAddv1+3/hYm4WkjrjdK0Woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443316; c=relaxed/simple;
	bh=rE9+tJdETdIr7B9CewRm5Y0xjSrk+mv2qtnTS01O4mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYzHNjU392L3y0YMRFuh6nTCVlhC+OB4sRSnwE0Pv4pZyOZd6pMMXM3SVjJufDIIPbQ1CPqQxvIFKrrKEyrGwM0Aqu3maCIeyjYIcrypGcmUl0i14hcT8CznPyDF/XlOOaLOZhcKETm/UwtVR7gIx3VuD3bHwN3BmQkRUyVsKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382C2113E;
	Tue, 17 Dec 2024 05:49:02 -0800 (PST)
Received: from [10.34.129.42] (e126645.nice.arm.com [10.34.129.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EABA3F528;
	Tue, 17 Dec 2024 05:48:29 -0800 (PST)
Message-ID: <e581fa05-9b4e-46e6-9172-83704bfa8ab2@arm.com>
Date: Tue, 17 Dec 2024 14:48:29 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] ACPI: CPPC: Add autonomous selection ABIs
To: Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: acpica-devel@lists.linux.dev, lenb@kernel.org, viresh.kumar@linaro.org,
 robert.moore@intel.com, rafael@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 ionela.voinescu@arm.com, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-4-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241216091603.1247644-4-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Lifeng, Huang, Gautham, Mario,

On 12/16/24 10:16, Lifeng Zheng wrote:
> cppc_set_epp - write energy performance preference register
> 
> cppc_get_auto_act_window - read autonomous activity window register
> 
> cppc_set_auto_act_window - write autonomous activity window register
> 
> cppc_get_auto_sel - read autonomous selection enable register
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++++++
>   include/acpi/cppc_acpi.h | 20 ++++++++++++++++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 83c7fcad74ad..645f2366c888 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1595,6 +1595,50 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   
> +/**
> + * cppc_set_epp() - Write the EPP register.
> + * @cpu: CPU on which to write register.
> + * @epp_val: Value to write to the EPP register.
> + */
> +int cppc_set_epp(int cpu, u64 epp_val)
> +{
> +	return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp);
> +
> +/**
> + * cppc_get_auto_act_window() - Read autonomous activity window register.
> + * @cpu: CPU from which to read register.
> + * @auto_act_window: Return address.
> + */
> +int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)

As there is only one way to interpret the value of the
'Autonomous Activity Window Register', maybe the logic to convert
from/to the register value to a value in us should be placed here
rather than in the cppc_cpufreq driver.
Meaning, maybe the prototype should be:

int cppc_get_auto_act_window(int cpu, unsigned int *auto_act_window);

Similar remark for cppc_set_epp() and other functions.

> +{
> +	return cppc_get_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_act_window);
> +
> +/**
> + * cppc_set_auto_act_window() - Write autonomous activity window register.
> + * @cpu: CPU on which to write register.
> + * @auto_act_window: Value to write to the autonomous activity window register.
> + */
> +int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +	return cppc_set_reg_val(cpu, AUTO_ACT_WINDOW, auto_act_window);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_act_window);
> +
> +/**
> + * cppc_get_auto_sel() - Read autonomous selection register.
> + * @cpu: CPU from which to read register.
> + * @auto_sel: Return address.
> + */
> +int cppc_get_auto_sel(int cpu, u64 *auto_sel)

Similarly, maybe it would be better to use:
int cppc_get_auto_sel(int cpu, bool *auto_sel);

> +{
> +	return cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, auto_sel);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
> +
>   /**
>    * cppc_get_auto_sel_caps - Read autonomous selection register.
>    * @cpunum : CPU from which to read register.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 62d368bcd9ec..134931b081a0 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -159,6 +159,10 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> +extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
> +extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
> +extern int cppc_get_auto_sel(int cpu, u64 *auto_sel);
>   extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);

This is a bit annoying, but maybe only one function between:
- cppc_get_auto_sel_caps()
- cppc_get_auto_sel()
is necessary.

I added the owners of the amd-pstate driver to ask if this would
be ok to replace cppc_get_auto_sel_caps() by cppc_get_auto_sel().

>   extern int cppc_set_auto_sel(int cpu, bool enable);
>   extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
> @@ -225,6 +229,22 @@ static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls,
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_epp(int cpu, u64 epp_val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_set_auto_act_window(int cpu, u64 auto_act_window)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_auto_sel(int cpu, u64 *auto_sel)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>   {
>   	return -EOPNOTSUPP;

