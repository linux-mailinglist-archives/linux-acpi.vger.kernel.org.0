Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD62C0ABD
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 14:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgKWM0o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 07:26:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8569 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgKWM0n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2020 07:26:43 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CfmbQ5z2NzLsR5;
        Mon, 23 Nov 2020 20:26:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Nov 2020
 20:26:25 +0800
Subject: Re: [PATCH v4] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     <james.morse@arm.com>, <rafael@kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <akpm@linux-foundation.org>, <jroedel@suse.de>,
        <peterz@infradead.org>
References: <1603877835-30970-1-git-send-email-tanxiaofei@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5FBBAA71.3090101@huawei.com>
Date:   Mon, 23 Nov 2020 20:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1603877835-30970-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James，
Please help to review this new version, thank you very much.

On 2020/10/28 17:37, Xiaofei Tan wrote:
> After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> synchronise with APEI's irq work") applied, do_sea() return directly
> for user-mode if apei_claim_sea() handled any error record. Therefore,
> each error record reported by the user-mode SEA must be effectively
> processed in APEI GHES driver.
> 
> Currently, GHES driver only processes Memory Error Section.(Ignore PCIe
> Error Section, as it has nothing to do with SEA). It is not enough.
> Because ARM Processor Error could also be used for SEA in some hardware
> platforms, such as Kunpeng9xx series. We can't ask them to switch to
> use Memory Error Section for two reasons:
> 1)The server was delivered to customers, and it will introduce
> compatibility issue.
> 2)It make sense to use ARM Processor Error Section. Because either
> cache or memory errors could generate SEA when consumed by a processor.
> 
> Do memory failure handling for ARM Processor Error Section just like
> for Memory Error Section.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
> Changes since v3:
> - Print unhandled error following James Morse's advice.
> 
> Changes since v2:
> - Updated commit log
> ---
>  drivers/acpi/apei/ghes.c | 70 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 99df00f..b9cbd33 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)
>  	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>  }
>  
> -static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
> -				       int sev)
> +static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>  	unsigned long pfn;
> -	int flags = -1;
> -	int sec_sev = ghes_severity(gdata->error_severity);
> -	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>  
>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>  		return false;
>  
> -	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> -		return false;
> -
> -	pfn = mem_err->physical_addr >> PAGE_SHIFT;
> +	pfn = PHYS_PFN(physical_addr);
>  	if (!pfn_valid(pfn)) {
>  		pr_warn_ratelimited(FW_WARN GHES_PFX
>  		"Invalid address in generic error data: %#llx\n",
> -		mem_err->physical_addr);
> +		physical_addr);
>  		return false;
>  	}
>  
> +	memory_failure_queue(pfn, flags);
> +	return true;
> +}
> +
> +static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
> +				       int sev)
> +{
> +	int flags = -1;
> +	int sec_sev = ghes_severity(gdata->error_severity);
> +	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
> +
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +		return false;
> +
>  	/* iff following two events can be handled properly by now */
>  	if (sec_sev == GHES_SEV_CORRECTED &&
>  	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> @@ -470,14 +477,45 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>  	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>  		flags = 0;
>  
> -	if (flags != -1) {
> -		memory_failure_queue(pfn, flags);
> -		return true;
> -	}
> +	if (flags != -1)
> +		return ghes_do_memory_failure(mem_err->physical_addr, flags);
>  
>  	return false;
>  }
>  
> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
> +{
> +	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> +	struct cper_arm_err_info *err_info;
> +	bool queued = false;
> +	int sec_sev, i;
> +
> +	log_arm_hw_error(err);
> +
> +	sec_sev = ghes_severity(gdata->error_severity);
> +	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
> +		return false;
> +
> +	err_info = (struct cper_arm_err_info *) (err + 1);
> +	for (i = 0; i < err->err_info_num; i++, err_info++) {
> +		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
> +		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> +
> +		if (!is_cache || !has_pa) {
> +			pr_warn_ratelimited(FW_WARN GHES_PFX
> +			"Unhandled processor error type %s\n",
> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +			cper_proc_error_type_strs[err_info->type] : "unknown error");
> +			continue;
> +		}
> +
> +		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
> +			queued = true;
> +	}
> +
> +	return queued;
> +}
> +
>  /*
>   * PCIe AER errors need to be sent to the AER driver for reporting and
>   * recovery. The GHES severities map to the following AER severities and
> @@ -605,9 +643,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			ghes_handle_aer(gdata);
>  		}
>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> -
> -			log_arm_hw_error(err);
> +			queued = ghes_handle_arm_hw_error(gdata, sev);
>  		} else {
>  			void *err = acpi_hest_get_payload(gdata);
>  
> 

-- 
 thanks
tanxiaofei

