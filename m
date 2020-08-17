Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C6F245AC5
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Aug 2020 04:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHQCtq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 16 Aug 2020 22:49:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgHQCto (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 16 Aug 2020 22:49:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2D5E051C329AE0683AE9;
        Mon, 17 Aug 2020 10:49:40 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 10:49:30 +0800
Subject: Re: [PATCH v2] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
References: <1596618731-37623-1-git-send-email-tanxiaofei@huawei.com>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F39F039.4060201@huawei.com>
Date:   Mon, 17 Aug 2020 10:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1596618731-37623-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

@James, Could you help to check if i have fixed your review comments? thanks.

On 2020/8/5 17:12, Xiaofei Tan wrote:
> After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> synchronise with APEI's irq work") applied, user-mode SEA is
> preferentially processed by APEI. Do memory failure to recover.
> 
> But there are some problems:
> 1) The function apei_claim_sea() has processed an CPER, does not
> mean that memory failure handling has done. Because the firmware-first
> RAS error is reported by both producer and consumer. Mostly SEA uses
> ARM processor error section to report as a consumer. (The producer could
> be DDRC and cache, and use memory error section and other error section
> to report). But memory failure handling for ARM processor error section
> has not been supported. This patch will add it.
> 
> 2) Some hardware platforms can't record physical address each time. But
> they could always have reported a firmware-first RAS error using ARM
> processor error section. Such platform should update firmware. Don't
> report the RAS error in SEA processing flow when physical address is
> not recorded.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 70 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 81bf71b..aee7787 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -429,28 +429,35 @@ static void ghes_kick_task_work(struct callback_head *head)
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
> @@ -458,14 +465,45 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
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
> +		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
> +			continue;
> +
> +		if (err_info->type != CPER_ARM_CACHE_ERROR) {
> +			pr_warn_ratelimited(FW_WARN GHES_PFX
> +			"Physical address should be invalid for %s\n",
> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +			cper_proc_error_type_strs[err_info->type] : "unknown error type");
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
> @@ -543,9 +581,7 @@ static bool ghes_do_proc(struct ghes *ghes,
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

