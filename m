Return-Path: <linux-acpi+bounces-10175-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9D9F4CC3
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 14:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046F61627A2
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2024 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7CD1F4279;
	Tue, 17 Dec 2024 13:48:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4721EF1D;
	Tue, 17 Dec 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443310; cv=none; b=rYv1iflBaN0Pf8thbo6AECLQBtIFTv5ypk28EqWPv6Wezvw0AiRTSM9qft69MpKdr4gUGTPKgUX+BhE6Dd/5uYWKo20pXfQQZurz8Y2JC/x2kBnZXEF+ZH/3fIJKajDVSoiMy+8GmXQmRvjDywGupcgWBaLv+ezjWI4eAZkZbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443310; c=relaxed/simple;
	bh=Dec/BYNYnRrGFmxGH3FDut30oCKG3o6pxweQtg4CNvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfPHJsF6Ri2avXyCuh8FrN4gRvvI8bKVq8ihxPGHd68+86KdIcIloNlBBQZ88iQNwR3xUgcdqtRQ6wg8I1mqdYAij61fvrH8oObJEaPML4Xa14pTjkhVxJnUU328LW3pAJKuLx0/SSp6f9GujXUAcn2RqtXjlEPho/QIO/YbRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A3A497;
	Tue, 17 Dec 2024 05:48:52 -0800 (PST)
Received: from [10.34.129.42] (e126645.nice.arm.com [10.34.129.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597833F528;
	Tue, 17 Dec 2024 05:48:21 -0800 (PST)
Message-ID: <8e9c1ede-3277-458b-bd44-ca0c7615a4ab@arm.com>
Date: Tue, 17 Dec 2024 14:48:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ACPI: CPPC: Add cppc_get_reg_val and
 cppc_set_reg_val function
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 ionela.voinescu@arm.com, jonathan.cameron@huawei.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
 <20241216091603.1247644-2-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20241216091603.1247644-2-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Lifeng,

On 12/16/24 10:16, Lifeng Zheng wrote:
> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
> cppc registers, with four changes:
> 
> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
> means that this cpu cannot get a valid pcc_ss_id.
> 
> 2. Add a check to verify if the register is a cpc supported one before
> using it.
> 
> 3. Extract the operations if register is in pcc out as
> cppc_get_reg_val_in_pcc().
> 
> 4. Return the result of cpc_read() instead of 0.
> 
> Add cppc_set_reg_val_in_pcc() and cppc_set_reg_val() as generic functions
> for setting cppc registers value. Unlike other set reg ABIs,
> cppc_set_reg_val() checks CPC_SUPPORTED right after getting the register,
> because the rest of the operations are meaningless if this register is not
> a cpc supported one.
> 
> These functions can be used to reduce some existing code duplication.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 111 +++++++++++++++++++++++++++++----------
>   1 file changed, 84 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c1f3568d0c50..bb5333a503a2 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1179,43 +1179,100 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   	return ret_val;
>   }
>   
> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
>   {
> -	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret;
> +
> +	if (pcc_ss_id < 0) {
> +		pr_debug("Invalid pcc_ss_id\n");
> +		return -ENODEV;
> +	}
> +
> +	pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +	down_write(&pcc_ss_data->pcc_lock);
> +
> +	if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
> +		ret = cpc_read(cpu, reg, val);
> +	else
> +		ret = -EIO;
> +
> +	up_write(&pcc_ss_data->pcc_lock);
> +
> +	return ret;
> +}
> +
> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>   	struct cpc_register_resource *reg;
>   
>   	if (!cpc_desc) {
> -		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>   		return -ENODEV;
>   	}
>   
>   	reg = &cpc_desc->cpc_regs[reg_idx];
>   
> -	if (CPC_IN_PCC(reg)) {
> -		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> -		struct cppc_pcc_data *pcc_ss_data = NULL;
> -		int ret = 0;
> -
> -		if (pcc_ss_id < 0)
> -			return -EIO;
> +	if (!CPC_SUPPORTED(reg)) {
> +		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
> +		return -EOPNOTSUPP;
> +	}

I think this is only valid for optional fields. Meaning that:
- if the function is used one day for the mandatory 'Lowest Performance'
field, an integer value of 0 would be valid.
- if the function is used for a mandatory field containing a NULL Buffer,
it seems we would return -EFAULT currently, through cpc_read(). -EOPNOTSUPP
doesn't seem appropriate as the field would be mandatory.

Maybe the function needs an additional 'bool optional' input parameter
to do these check conditionally.

>   
> -		pcc_ss_data = pcc_data[pcc_ss_id];
> +	if (CPC_IN_PCC(reg))
> +		return cppc_get_reg_val_in_pcc(cpu, reg, val);
>   
> -		down_write(&pcc_ss_data->pcc_lock);
> +	return cpc_read(cpu, reg, val);
> +}
>   
> -		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
> -			cpc_read(cpunum, reg, perf);
> -		else
> -			ret = -EIO;
> +static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret;
>   
> -		up_write(&pcc_ss_data->pcc_lock);
> +	if (pcc_ss_id < 0) {
> +		pr_debug("Invalid pcc_ss_id\n");
> +		return -ENODEV;
> +	}
>   
> +	ret = cpc_write(cpu, reg, val);
> +	if (ret)
>   		return ret;
> +
> +	pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +	down_write(&pcc_ss_data->pcc_lock);
> +	/* after writing CPC, transfer the ownership of PCC to platform */
> +	ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +	up_write(&pcc_ss_data->pcc_lock);
> +
> +	return ret;
> +}
> +
> +static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *reg;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
>   	}
>   
> -	cpc_read(cpunum, reg, perf);
> +	reg = &cpc_desc->cpc_regs[reg_idx];
>   
> -	return 0;
> +	if (!CPC_SUPPORTED(reg)) {
> +		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
> +		return -EOPNOTSUPP;
> +	}

Similarly to cppc_get_reg_val(), if a field is:
- mandatory + integer: currently doesn't exist. Not sure we should
try to detect that, but might be safer.
- mandatory + buffer: should not return -EOPNOTSUPP I think
- optional + integer: e.g.: 'Autonomous Selection Enable Register',
we should return -EOPNOTSUPP. It seems that currently, if the integer
value is 1, I get a 'write error: Bad address'
- optional + buffer:
should effectively return -EOPNOTSUPP if the buffer is NULL.

> +
> +	if (CPC_IN_PCC(reg))
> +		return cppc_set_reg_val_in_pcc(cpu, reg, val);
> +
> +	return cpc_write(cpu, reg, val);
>   }
>   
>   /**
> @@ -1223,11 +1280,11 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>    * @cpunum: CPU from which to get desired performance.
>    * @desired_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>    */
>   int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> -	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
> +	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>   
> @@ -1236,11 +1293,11 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>    * @cpunum: CPU from which to get nominal performance.
>    * @nominal_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>    */
>   int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>   {
> -	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
> +	return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
>   }
>   
>   /**
> @@ -1248,11 +1305,11 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>    * @cpunum: CPU from which to get highest performance.
>    * @highest_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>    */
>   int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>   {
> -	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +	return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>   
> @@ -1261,11 +1318,11 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>    * @cpunum: CPU from which to get epp preference value.
>    * @epp_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>    */
>   int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>   {
> -	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
> +	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>   

