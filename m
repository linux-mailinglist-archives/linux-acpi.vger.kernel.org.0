Return-Path: <linux-acpi+bounces-10010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5D9E6FFD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 15:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07E916CAF2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 14:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16444207DFD;
	Fri,  6 Dec 2024 14:23:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462962040BD;
	Fri,  6 Dec 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733495019; cv=none; b=p6DS66aL1NKh7GojOPBcZSUnbaG4lco9egw5+RxIZm1bbdwFPymccY/iekdeNGtzrdUDJEyGczmMIWbl1ouJaw8/00hqPYenhnvt+dl8taV3Gm96t3It66j7FZCJ+qRWnO7b8ZRaa9bouB2EtfZAwFwT9Ii/OaxuuOklgDfMW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733495019; c=relaxed/simple;
	bh=CZf69GeuxRSB4nHlFT99feBX5u7AwBAV/jb+fIEfn0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbMVsmd1wRtdg8YgbACxvdXWmrw1+2M7lhAfy5gnKbFHmQ6v1D4N/WljcoQ3T8KC9ypgxsoxYPE2PMMJUIZolTD0+siSrdYVaSI28y9Qn0n7MyCuMepB2BaXnl+MLH+G/J6HAOdZGBwXzuWSeTOUGM+tTD8/fw5r8xK2254VzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6216FEC;
	Fri,  6 Dec 2024 06:24:04 -0800 (PST)
Received: from [10.57.68.20] (unknown [10.57.68.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A8DD3F71E;
	Fri,  6 Dec 2024 06:23:33 -0800 (PST)
Message-ID: <0f113d9d-faac-420a-9c75-9b620bf5c3f6@arm.com>
Date: Fri, 6 Dec 2024 15:23:32 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ACPI: CPPC: Refactor register get and set ABIs
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, fanghao11@huawei.com
References: <20241114084816.1128647-1-zhenglifeng1@huawei.com>
 <20241114084816.1128647-2-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241114084816.1128647-2-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Lifeng,

On 11/14/24 09:48, Lifeng Zheng wrote:
> Refactor register get and set ABIs using cppc_get_reg() and cppc_set_reg().
> 
> Rename cppc_get_perf() to cppc_get_reg() as a generic function to read cppc
> registers, with two changes:
> 
> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
> means that this cpu cannot get a valid pcc_ss_id.
> 
> 2. Add a check to verify if the register is a cpc supported one before
> using it.
> 
> Add cppc_set_reg() as a generic function for setting cppc registers. Unlike
> other set reg ABIs, this function checks CPC_SUPPORTED right after getting
> the register, because the rest of the operations are meaningless if this
> register is not a cpc supported one.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 191 +++++++++++++++------------------------
>   1 file changed, 72 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c1f3568d0c50..306ced9c3376 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1179,10 +1179,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   	return ret_val;
>   }
>   
> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> +static int cppc_get_reg(int cpunum, enum cppc_regs reg_idx, u64 *val)
>   {
>   	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
>   	struct cpc_register_resource *reg;
> +	int pcc_ss_id;
> +	int ret = 0;

NIT: Might not be necessary if we save the value returned by cpc_read(),
cf. other comment below.

>   
>   	if (!cpc_desc) {
>   		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1191,20 +1194,23 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   
>   	reg = &cpc_desc->cpc_regs[reg_idx];
>   
> +	if (!CPC_SUPPORTED(reg)) {
> +		pr_debug("CPC register (reg_idx=%u) is not supported\n", reg_idx);
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (CPC_IN_PCC(reg)) {
> -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> -		struct cppc_pcc_data *pcc_ss_data = NULL;
> -		int ret = 0;
> +		pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>   
>   		if (pcc_ss_id < 0)
> -			return -EIO;
> +			return -ENODEV;

NIT: Could add here:
   pr_debug("Invalid pcc_ss_id\n");
just as you did in cppc_set_reg()

>   
>   		pcc_ss_data = pcc_data[pcc_ss_id];
>   
>   		down_write(&pcc_ss_data->pcc_lock);
>   
>   		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
> -			cpc_read(cpunum, reg, perf);
> +			cpc_read(cpunum, reg, val);

This was not introduced by your patch, but cpc_read() return a value.
Shouldn't we return it instead of 0 ?

>   		else
>   			ret = -EIO;
>   
> @@ -1213,21 +1219,65 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   		return ret;
>   	}
>   
> -	cpc_read(cpunum, reg, perf);
> +	cpc_read(cpunum, reg, val);

Same comment as above

>   
>   	return 0;
>   }
>   
> +static int cppc_set_reg(int cpu, enum cppc_regs reg_idx, u64 val)

Just to have similar functions, maybe 'cpu' should be renamed to 'cpunum' ?
Or the other way around.

> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	struct cpc_register_resource *reg;
> +	int pcc_ss_id;
> +	int ret;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	reg = &cpc_desc->cpc_regs[reg_idx];
> +
> +	if (!CPC_SUPPORTED(reg)) {
> +		pr_debug("CPC register (reg_idx=%u) is not supported\n", reg_idx);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (CPC_IN_PCC(reg)) {
> +		pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id\n");
> +			return -ENODEV;
> +		}
> +
> +		ret = cpc_write(cpu, reg, val);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +		return ret;
> +	}
> +
> +	return cpc_write(cpu, reg, val);
> +}
> +

[snip]

