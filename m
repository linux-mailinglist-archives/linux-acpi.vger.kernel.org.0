Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7040723A1A6
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgHCJOt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 05:14:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbgHCJOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Aug 2020 05:14:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 01B976B9CC15A1BF2CD4;
        Mon,  3 Aug 2020 17:14:44 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 17:14:35 +0800
Subject: Re: [PATCH] ACPI / APEI: do memory failure on the physical address
 reported by ARM processor error section
To:     James Morse <james.morse@arm.com>
References: <1596094348-10230-1-git-send-email-tanxiaofei@huawei.com>
 <9b340947-4fcf-30f3-f7e4-68a2753864c6@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F27D57B.6000608@huawei.com>
Date:   Mon, 3 Aug 2020 17:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <9b340947-4fcf-30f3-f7e4-68a2753864c6@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James，

On 2020/7/31 21:48, James Morse wrote:
> Hi Tan,
> 
> On 30/07/2020 08:32, Xiaofei Tan wrote:
>> After the following commit applied, user-mode SEA is preferentially
>> processed by APEI. Do memory failure to recover.
>>
>> But there are some problems:
>> 1) The function apei_claim_sea() has processed an CPER, does not
>> mean that memory failure handling has done. Because the firmware-first
>> RAS error is reported by both producer and consumer. Mostly SEA uses
>> ARM processor error section to report as a consumer. (The producer could
>> be DDRC and cache, and use memory error section and other error section
>> to report). But memory failure handling for ARM processor error section
>> has not been supported. We should add it.
> 
> I can't follow what you are saying here.
> 
> APEI doesn't parse the Processor Error records. This has always been true, its not a
> regression introduced by that commit.
> 

The APEI parsing error didn't affect the SEA processing flow before. After that commit, it is changed.

> 
>> 2) Some hardware platforms can't record physical address each time. But
>> they could always have reported a firmware-first RAS error using ARM
>> processor error section. Such platform should update firmware. Don't
>> report the RAS error when physical address is not recorded.
> 
> Eh? If firmware fails to describe the error, we should carry on and pretend nothing happened?
> 

I mean firmware don't report RAS error in SEA process if physical address is not recorded.
The producer RAS node can still report the error.


> I think if the APEI code gets CPER records that have the fields linux needs to handle the
> error, (for memory: that's the physical address), it should return an error to the caller,
> as the work hasn't been done.
> 
> In the case of arm64's synchronous external abort, the response should be the
> apei_claim_sea() code not claiming the abort, as there is a problem with the records.
> Certainly the current behaviour can be improved.
> 

Agree.


> 
>> Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")
> 
> I don't see how parsing this extra record fixes a bug in this commit.
> Presumably you were depending on the arch code killing the thread regardless of whether
> APEI found work to do ... which masked the fact it finds work, but doesn't know what to do
> with it.
> 

Hmm,it's a little far-fetched. But i don't know how to describe the relationship with that commit.
Any idea?

> 
> I'm assuming your platform describes errors it detects in the cache as processor errors
> for the cache, instead of memory errors.
> 

Yes.

> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 81bf71b..07bfa28 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -466,6 +466,44 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>  	return false;
>>  }
>>  
>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>> +{
>> +	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>> +	struct cper_arm_err_info *err_info;
>> +	bool queued = false;
>> +	int sec_sev, i;
>> +
>> +	log_arm_hw_error(err);
>> +
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> +		return false;
> 
>> +	sec_sev = ghes_severity(gdata->error_severity);
>> +	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>> +		return false;
> 
> This is to filter out corrected errors? 

Yes.

What if this section is fatal?

Fatal errors won't come here.

> The panic on fatal code only looks as the severity in the Generic Error Status Block.
> 

Yes.

> I think the right thing to do is to explicitly test each "Cache error structure"'s bits
> for corrected/uncorrected instead.
> 

Do you mean skip TLB/Bus/Micro-architectural Error？

> These top-level severities describe a group of records. You may have a corrected error
> event that still has latent faults left in the system.
> 

Yes

> 
> This thing has multiple variable length entries in it.
> Could we sanity test that 'err->err_info_num' doesn't take us outside err->section_length?
> (we already do this sort of thing in the probe code)
> 

I think firmware should ensure the data is valid.

> 
>> +	err_info = (struct cper_arm_err_info *) (err + 1);
>> +	for (i = 0; i < err->err_info_num; i++, err_info++) {
>> +		unsigned long pfn;
> 
> Please check the type of this error, and only invoke memory_failure_queue() for caches.
> (does your firmware generate the other types too?)
> 

Our firmware only generate two types: cache error and TLB error.
The type of TLB error is only for MMU, and it can't record physical address, but only VA.

> 
> For a bus error, why are we complaining that this isn't memory?

There are two types of errors from the memory: bus error and poison error.
CPU core RAS nodes can't record bus errors.
It can record poison errors in some scenarios, but will be taken as cache errors with a flag "PN".

> If this were a TLB error, what does the physical address mean? Is it part of the page
> tables or the final output address? (Who knows what the physical address means for a
> micro-architectural error!)

You are right, we can't record a physical address for error types other than cache error.

> 
> I think these other types should print a ratelimited warning that this type isn't
> understood. We shouldn't pretend they are memory and hope for the best.
> 

OK. I will add a ratelimited warning for other types here.

> 
> Please check the corrected or uncorrected bit in the type-specific u64 for caches.
> 

OK

> 
>> +		if (!(err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR))
>> +			continue;
> 
> 
>> +		pfn = PHYS_PFN(err_info->physical_fault_addr);
>> +		if (!pfn_valid(pfn)) {
> 
>> +			pr_warn(FW_WARN GHES_PFX
> 
> ratelimit!
> 

OK

>> +				"Invalid address in generic error data: 0x%#llx\n",
>> +				err_info->physical_fault_addr);
>> +			continue;
>> +		}
>> +
>> +		memory_failure_queue(pfn, 0);
>> +		queued = true;
> 
> This bit is almost the same as part of ghes_handle_memory_failure(), please pull that out
> to a common helper. I think you'll need to pass the flags for memory_failure_queue() in.
> 
> 

OK.

> 
> Thanks,
> 
> James
> 
>> +	}
>> +
>> +	return queued;
>> +}
>> +
>>  /*
>>   * PCIe AER errors need to be sent to the AER driver for reporting and
>>   * recovery. The GHES severities map to the following AER severities and
>> @@ -543,9 +581,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  			ghes_handle_aer(gdata);
>>  		}
>>  		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>> -			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>> -
>> -			log_arm_hw_error(err);
>> +			queued = ghes_handle_arm_hw_error(gdata, sev);
>>  		} else {
>>  			void *err = acpi_hest_get_payload(gdata);
>>  
>>
> 
> 
> .
> 

-- 
 thanks
tanxiaofei

