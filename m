Return-Path: <linux-acpi+bounces-2085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4E8018F6
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 01:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAFE1F210F9
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE917D1
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 00:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bf6BJnov"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77CAA1BF7;
	Fri,  1 Dec 2023 15:52:04 -0800 (PST)
Received: from [10.192.9.210] (unknown [167.220.81.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id C94D120B74C0;
	Fri,  1 Dec 2023 15:52:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C94D120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701474723;
	bh=gZ3VA+8/Gj+Yz4nrqJ+cY+xf1+TC5VM+Uo2ZYHxFToU=;
	h=Date:Subject:Cc:References:From:To:In-Reply-To:From;
	b=Bf6BJnovE2cEt/xyyF84WCafWsc5wLsEpRE2KlrPZAWwDKt9dXfthjerRmCsa8EBn
	 jGxAC6aGYbtIfaQa9VkqVEX2az40VMRG+Zkgwg+GxloNbUoXCzF7f6iCO8psNrGgfY
	 DaD/i/X1mfTc1E/hFGKJAq4WK5umZh5snSNphOK4=
Message-ID: <db97466d-059f-489a-ac21-24edf39f43cd@linux.microsoft.com>
Date: Fri, 1 Dec 2023 15:52:02 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi: Use access_width over register_width for system
 memory accesses
Content-Language: en-US
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <42a5c36d-8b65-418f-9826-2808ab49d67a@linux.microsoft.com>
 <20231026211513.474-1-jarredwhite@linux.microsoft.com>
From: Jarred White <jarredwhite@linux.microsoft.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20231026211513.474-1-jarredwhite@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 10/26/2023 2:15 PM, Jarred White wrote:
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we cannot
> depend on it being always on a clean 8b boundary. Instead, use access_width
> to determine the size and use the offset and width to shift and mask the
> bits we want to read/write out. Make sure to add a check for system memory
> since pcc redefines the access_width to subspace id.
> 
> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> ---
> changelog:
> v1-->v2:
> 	1. Fixed coding style errors
>          2. Backwards compatibility with ioremapping of address still an
>             open question. Suggestions are welcomed.
> 
>   drivers/acpi/cppc_acpi.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..fb37e1727bf8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
>   show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>   
> +/* Use access_width to determine the total number of bits */
> +#define ACCESS_WIDTH_TO_BITS(reg) 8 << ((reg)->access_width - 1)
> +
> +/* Shift and apply the mask for CPC reads/writes */
> +#define MASK_VAL(val) (((val) >> reg->bit_offset) & 			\
> +					GENMASK((reg->bit_width), 0))
> +
>   static ssize_t show_feedback_ctrs(struct kobject *kobj,
>   		struct kobj_attribute *attr, char *buf)
>   {
> @@ -777,6 +784,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>   				if (gas_t->address) {
>   					void __iomem *addr;
> +					size_t access_width;
>   
>   					if (!osc_cpc_flexible_adr_space_confirmed) {
>   						pr_debug("Flexible address space capability not supported\n");
> @@ -784,7 +792,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   							goto out_free;
>   					}
>   
> -					addr = ioremap(gas_t->address, gas_t->bit_width/8);
> +					access_width = ACCESS_WIDTH_TO_BITS(gas_t) / 8;
> +					addr = ioremap(gas_t->address, access_width);
>   					if (!addr)
>   						goto out_free;
>   					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
> @@ -980,6 +989,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>   static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   {
>   	void __iomem *vaddr = NULL;
> +	int size;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>   
> @@ -991,7 +1001,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   	*val = 0;
>   
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = 8 << (reg->access_width - 1);
> +		u32 width = ACCESS_WIDTH_TO_BITS(reg);
>   		u32 val_u32;
>   		acpi_status status;
>   
> @@ -1015,7 +1025,12 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   		return acpi_os_read_memory((acpi_physical_address)reg->address,
>   				val, reg->bit_width);
>   
> -	switch (reg->bit_width) {
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		size = ACCESS_WIDTH_TO_BITS(reg);
> +	else
> +		size = reg->bit_width;
> +
> +	switch (size) {
>   	case 8:
>   		*val = readb_relaxed(vaddr);
>   		break;
> @@ -1034,18 +1049,22 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>   		return -EFAULT;
>   	}
>   
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +		*val = MASK_VAL(*val);
> +
>   	return 0;
>   }
>   
>   static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   {
>   	int ret_val = 0;
> +	int size;
>   	void __iomem *vaddr = NULL;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>   	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>   
>   	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> -		u32 width = 8 << (reg->access_width - 1);
> +		u32 width = ACCESS_WIDTH_TO_BITS(reg);
>   		acpi_status status;
>   
>   		status = acpi_os_write_port((acpi_io_address)reg->address,
> @@ -1067,7 +1086,14 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>   		return acpi_os_write_memory((acpi_physical_address)reg->address,
>   				val, reg->bit_width);
>   
> -	switch (reg->bit_width) {
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +		size = ACCESS_WIDTH_TO_BITS(reg);
> +		val = MASK_VAL(val);
> +	} else {
> +		size = reg->bit_width;
> +	}
> +
> +	switch (size) {
>   	case 8:
>   		writeb_relaxed(val, vaddr);
>   		break;

I just wanted to follow-up on the V2 patch and discuss the open we have 
regarding the backwards compatibility with ioremapping of the address.


Thanks,
Jarred


