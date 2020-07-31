Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7C23472B
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbgGaNsS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:48:18 -0400
Received: from foss.arm.com ([217.140.110.172]:59516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgGaNsS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:48:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57911101E;
        Fri, 31 Jul 2020 06:48:17 -0700 (PDT)
Received: from [192.168.0.57] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC2563F66E;
        Fri, 31 Jul 2020 06:48:15 -0700 (PDT)
Subject: Re: [PATCH] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, linuxarm@huawei.com, shiju.jose@huawei.com,
        jonathan.cameron@huawei.com
References: <1596094348-10230-1-git-send-email-tanxiaofei@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9b340947-4fcf-30f3-f7e4-68a2753864c6@arm.com>
Date:   Fri, 31 Jul 2020 14:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596094348-10230-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tan,

On 30/07/2020 08:32, Xiaofei Tan wrote:
> After the following commit applied, user-mode SEA is preferentially
> processed by APEI. Do memory failure to recover.
> 
> But there are some problems:
> 1) The function apei_claim_sea() has processed an CPER, does not
> mean that memory failure handling has done. Because the firmware-first
> RAS error is reported by both producer and consumer. Mostly SEA uses
> ARM processor error section to report as a consumer. (The producer could
> be DDRC and cache, and use memory error section and other error section
> to report). But memory failure handling for ARM processor error section
> has not been supported. We should add it.

I can't follow what you are saying here.

APEI doesn't parse the Processor Error records. This has always been true, its not a
regression introduced by that commit.


> 2) Some hardware platforms can't record physical address each time. But
> they could always have reported a firmware-first RAS error using ARM
> processor error section. Such platform should update firmware. Don't
> report the RAS error when physical address is not recorded.

Eh? If firmware fails to describe the error, we should carry on and pretend nothing happened?

I think if the APEI code gets CPER records that have the fields linux needs to handle the
error, (for memory: that's the physical address), it should return an error to the caller,
as the work hasn't been done.

In the case of arm64's synchronous external abort, the response should be the
apei_claim_sea() code not claiming the abort, as there is a problem with the records.
Certainly the current behaviour can be improved.


> Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")

I don't see how parsing this extra record fixes a bug in this commit.
Presumably you were depending on the arch code killing the thread regardless of whether
APEI found work to do ... which masked the fact it finds work, but doesn't know what to do
with it.


I'm assuming your platform describes errors it detects in the cache as processor errors
for the cache, instead of memory errors.


> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 81bf71b..07bfa28 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -466,6 +466,44 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
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
> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> +		return false;

> +	sec_sev = ghes_severity(gdata->error_severity);
> +	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
> +		return false;

This is to filter out corrected errors? What if this section is fatal?
The panic on fatal code only looks as the severity in the Generic Error Status Block.

I think the right thing to do is to explicitly test each "Cache error structure"'s bits
for corrected/uncorrected instead.

These top-level severities describe a group of records. You may have a corrected error
event that still has latent faults left in the system.


This thing has multiple variable length entries in it.
Could we sanity test that 'err->err_info_num' doesn't take us outside err->section_length?
(we already do this sort of thing in the probe code)


> +	err_info = (struct cper_arm_err_info *) (err + 1);
> +	for (i = 0; i < err->err_info_num; i++, err_info++) {
> +		unsigned long pfn;

Please check the type of this error, and only invoke memory_failure_queue() for caches.
(does your firmware generate the other types too?)


For a bus error, why are we complaining that this isn't memory?
If this were a TLB error, what does the physical address mean? Is it part of the page
tables or the final output address? (Who knows what the physical address means for a
micro-architectural error!)

I think these other types should print a ratelimited warning that this type isn't
understood. We shouldn't pretend they are memory and hope for the best.


Please check the corrected or uncorrected bit in the type-specific u64 for caches.


> +		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
> +			continue;


> +		pfn = PHYS_PFN(err_info->physical_fault_addr);
> +		if (!pfn_valid(pfn)) {

> +			pr_warn(FW_WARN GHES_PFX

ratelimit!

> +				"Invalid address in generic error data: 0x%#llx\n",
> +				err_info->physical_fault_addr);
> +			continue;
> +		}
> +
> +		memory_failure_queue(pfn, 0);
> +		queued = true;

This bit is almost the same as part of ghes_handle_memory_failure(), please pull that out
to a common helper. I think you'll need to pass the flags for memory_failure_queue() in.



Thanks,

James

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

