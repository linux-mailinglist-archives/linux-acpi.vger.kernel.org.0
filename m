Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1D288518
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgJIIUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 04:20:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732547AbgJIIUe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Oct 2020 04:20:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1AED2D3E59D5D3204E6D;
        Fri,  9 Oct 2020 16:20:31 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 16:20:25 +0800
Subject: Re: [PATCH v3] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     James Morse <james.morse@arm.com>
References: <1601258560-6658-1-git-send-email-tanxiaofei@huawei.com>
 <06ebead0-ffa5-5003-f0a7-0b38fcb0e702@arm.com>
CC:     <rafael@kernel.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <bp@alien8.de>, <akpm@linux-foundation.org>,
        <jroedel@suse.de>, <peterz@infradead.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F801D49.302@huawei.com>
Date:   Fri, 9 Oct 2020 16:20:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <06ebead0-ffa5-5003-f0a7-0b38fcb0e702@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James, Thanks for reviewing the patch.

On 2020/10/1 21:44, James Morse wrote:
> Hi Tanxiaofei,
> 
> (sorry for the late reply)
> 
> On 28/09/2020 03:02, Xiaofei Tan wrote:
>> After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
>> synchronise with APEI's irq work") applied, do_sea() return directly
>> for user-mode if apei_claim_sea() handled any error record. Therefore,
>> each error record reported by the user-mode SEA must be effectively
>> processed in APEI GHES driver.
>>
>> Currently, GHES driver only processes Memory Error Section.(Ignore PCIe
>> Error Section, as it has nothing to do with SEA). It is not enough.
>> Because ARM Processor Error could also be used for SEA in some hardware
>> platforms, such as Kunpeng9xx series. We can't ask them to switch to
>> use Memory Error Section for two reasons:
>> 1)The server was delivered to customers, and it will introduce
>> compatibility issue.
> 
>> 2)It make sense to use ARM Processor Error Section. Because either
>> cache or memory errors could generate SEA when consumed by a processor.
>>
>> Do memory failure handling for ARM Processor Error Section just like
>> for Memory Error Section.
> 
> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 99df00f..ca0aa97 100644
>> --- a/drivers/acpi/apei/ghes.
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)
> 
>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>> +{
>> +	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>> +	struct cper_arm_err_info *err_info;
>> +	bool queued = false;
>> +	int sec_sev, i;
>> +
>> +	log_arm_hw_error(err);
>> +
>> +	sec_sev = ghes_severity(gdata->error_severity);
>> +	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>> +		return false;
>> +
>> +	err_info = (struct cper_arm_err_info *) (err + 1);
>> +	for (i = 0; i < err->err_info_num; i++, err_info++) {
> 
> err_info has its own length, could we use that in case someone comes up with a new table
> version? (like this, old versions of the kernel will read mis-aligned structures)
> 

The length of err_info is hard written in "ARM Processor Error Section", always 32 bytes.
If someone comes up with a new table version, must also be this length. It seems no much
differences to change to use the fixed 32 bytes here.

> 
>> +		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
>> +			continue;
>> +
>> +		if (err_info->type != CPER_ARM_CACHE_ERROR) {
>> +			pr_warn_ratelimited(FW_WARN GHES_PFX
>> +			"Physical address should be invalid for %s\n",
> 
> Should? A bus-error could have a valid physical address. I can't see anything in the spec
> that forbids this.

Really? Our platform can't physical address for bus-error.
I remember you asked this in earlier version patch, which is why i skipped non-cache error.


 In general we shouldn't try to validate what firmware is doing.
> 
> 
>> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
>> +			cper_proc_error_type_strs[err_info->type] : "unknown error type");
>> +			continue;
>> +		}
> 
> I think we should warn for the cases this handler doesn't cover, but we should try to
> catch all of them. e.g:
> 
> |	bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
> |	bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR)
> |
> |	if (!is_cache || !has_pa) {
> |		pr_warn_ratelimited(..."Unhandled processor error type %s\n", ...);
> |		continue;
> |	}
> 

OK

> 
> For cache errors, (err_info->error_info & BIT(26)) has its own corrected/uncorrected flag.
> You filter out 'overall corrected' section types earlier, could you check this error
> record before invoking memory_failure()?
> 

Do you mean skip corrected error in a recoverable or fatal error section ?
We only use the  severity type of section header, and this corrected/uncorrected flag
may not be filled correctly in firmware.

> (sections may contain a set of errors. I'm not convinced a 'corrected section' can't
> contain latent uncorrected errors, it just means the machine didn't need that data yet)
> 

If contain uncorrected errors, then the error section should be defined as recoverable.

> 
> 
>> +		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
>> +			queued = true;
> 
> May as well:
> |		return ghes_do_memory_failure(...);
> 

We can't return directly from here, as other error info may not have been handled.

> 
>> +	}
>> +
>> +	return queued;
> 
> (and make this:
> |	return false
> )
> 
>> +}
> 
> 
> 
> Thanks,
> 
> James
> 
> .
> 

-- 
 thanks
tanxiaofei

