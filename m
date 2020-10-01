Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89828005D
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Oct 2020 15:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgJANo0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Oct 2020 09:44:26 -0400
Received: from foss.arm.com ([217.140.110.172]:34624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732018AbgJANoY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Oct 2020 09:44:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE5A30E;
        Thu,  1 Oct 2020 06:44:23 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADAF13F6CF;
        Thu,  1 Oct 2020 06:44:21 -0700 (PDT)
Subject: Re: [PATCH v3] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     rafael@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, bp@alien8.de, akpm@linux-foundation.org,
        jroedel@suse.de, peterz@infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1601258560-6658-1-git-send-email-tanxiaofei@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <06ebead0-ffa5-5003-f0a7-0b38fcb0e702@arm.com>
Date:   Thu, 1 Oct 2020 14:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601258560-6658-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tanxiaofei,

(sorry for the late reply)

On 28/09/2020 03:02, Xiaofei Tan wrote:
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


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 99df00f..ca0aa97 100644
> --- a/drivers/acpi/apei/ghes.
> +++ b/drivers/acpi/apei/ghes.c
> @@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)

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

err_info has its own length, could we use that in case someone comes up with a new table
version? (like this, old versions of the kernel will read mis-aligned structures)


> +		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
> +			continue;
> +
> +		if (err_info->type != CPER_ARM_CACHE_ERROR) {
> +			pr_warn_ratelimited(FW_WARN GHES_PFX
> +			"Physical address should be invalid for %s\n",

Should? A bus-error could have a valid physical address. I can't see anything in the spec
that forbids this. In general we shouldn't try to validate what firmware is doing.


> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +			cper_proc_error_type_strs[err_info->type] : "unknown error type");
> +			continue;
> +		}

I think we should warn for the cases this handler doesn't cover, but we should try to
catch all of them. e.g:

|	bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
|	bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
|
|	if (!is_cache || !has_pa) {
|		pr_warn_ratelimited(..."Unhandled processor error type %s\n", ...);
|		continue;
|	}


For cache errors, (err_info->error_info & BIT(26)) has its own corrected/uncorrected flag.
You filter out 'overall corrected' section types earlier, could you check this error
record before invoking memory_failure()?

(sections may contain a set of errors. I'm not convinced a 'corrected section' can't
contain latent uncorrected errors, it just means the machine didn't need that data yet)



> +		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
> +			queued = true;

May as well:
|		return ghes_do_memory_failure(...);


> +	}
> +
> +	return queued;

(and make this:
|	return false
)

> +}



Thanks,

James
