Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81D339C6EC
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFEJBW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Jun 2021 05:01:22 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4366 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEJBV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jun 2021 05:01:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fxtl364jHz68Zc;
        Sat,  5 Jun 2021 16:55:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 16:59:31 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 16:59:31 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v5] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     James Morse <james.morse@arm.com>, <rafael@kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <akpm@linux-foundation.org>, <jroedel@suse.de>,
        <peterz@infradead.org>
References: <1607602177-1507-1-git-send-email-tanxiaofei@huawei.com>
 <d57d786c-f9cb-46ba-78d0-3675666272f2@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Message-ID: <5b444714-aa45-517f-9595-fd5889d3c342@huawei.com>
Date:   Sat, 5 Jun 2021 16:59:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <d57d786c-f9cb-46ba-78d0-3675666272f2@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi James,

On 2021/6/4 22:19, James Morse wrote:
> Hi Xiaofei Tan,
>
> Sorry for the delayed response,

It's okay.

> this still applies and builds to v5.13-rc4.

Yes, that's why i hadn't resend it.

>
> On 10/12/2020 12:09, Xiaofei Tan wrote:
>> After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
>> synchronise with APEI's irq work") applied, do_sea() return directly
>> for user-mode if apei_claim_sea() handled any error record. Therefore,
>> each error record reported by the user-mode SEA must be effectively
>> processed in APEI GHES driver.
>
> If you describe it the other way round, it would be clearer what the problem here is.
> Something like:
> | Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise
> | with APEI's irq work"), do_sea() would unconditionally signal the affected task
> | from the arch code. Since that change, the GHES driver sends the signals,.
> | This exposes a problem as errors the GHES driver doesn't understand are silently
> | ignored.
>

Yes, it's clearer. Only one little change to the last sentence.
Change to:
This exposes a problem as errors the GHES driver doesn't understand
or doesn't handle effectively are silently ignored.

>
>> Currently, GHES driver only processes Memory Error Section.(Ignore PCIe
>> Error Section, as it has nothing to do with SEA).
>
> (you're starting to confuse me! - I went and checked before I realised you were talking to
> me, not describing the code...)
>
>> It is not enough. > Because ARM Processor Error could also be used for SEA in some hardware
>> platforms, such as Kunpeng9xx series. We can't ask them to switch to
>> use Memory Error Section for two reasons:
>> 1)The server was delivered to customers, and it will introduce
>> compatibility issue.
>> 2)It make sense to use ARM Processor Error Section. Because either
>> cache or memory errors could generate SEA when consumed by a processor.
>
> I think you just need to say:
> | Existing firmware on Kunpeng9xx systems reports cache errors with the 'ARM Processor
> | Error' CPER records.
>

OK

>
> Could you add something about why the silent-ignore is a problem?

OK

> Do the errors get taken again?Does user-space get stuck in this loop?

Yes, the process will repeat endlessly.

>
>
>> Do memory failure handling for ARM Processor Error Section just like
>> for Memory Error Section.
>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index fce7ade..0893968 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
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
> err_info has a version and a length, so its expected to be made bigger at some point.


Yes, but the table "ARM Processor Error Section" fixed the length of
processor error information structure to fixed 32 bytes. Then the
description of the UEFI spec need to update.

> It would be better to use the length instead of 'err_info++', or at least to break out of
> the loop if a length > sizeof(*err_info) is seen.
>

OK. Maybe check length != sizeof(*err_info) is better. I will add this.

	if (err_info->length != sizeof(struct cper_arm_err_info)) {
		pr_warn_ratelimited(FW_WARN GHES_PFX
				    "Error info length %d is invalid\n",
				    err_info->length);
		break;
	}

> With that:
> Reviewed-by: James Morse <james.morse@arm.com>
>
>
> The following nits would make this easier to read:
>
>> +		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
>> +		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
>
>> +		/*
>> +		 * The field (err_info->error_info & BIT(26)) is fixed to set to
>> +		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
>> +		 * firmware won't mix corrected errors in an uncorrected section,
>> +		 * and don't filter out 'corrected' error here.
>> +		 */
> (Nothing reads err_info->error_info, I guess this is a warning to the next person to touch
> this)
>

Yes

>
>> +		if (!is_cache || !has_pa) {
>> +			pr_warn_ratelimited(FW_WARN GHES_PFX
>> +			"Unhandled processor error type %s\n",
>> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
>> +			cper_proc_error_type_strs[err_info->type] : "unknown error");
>> +			continue;
>
> This is hard to read. The convention is to indent the extra lines to the relevant '('.
> e.g.:
> |			pr_warn_ratelimited(FW_WARN GHES_PFX
> |					    "Unhandled processor error type %s\n",
>
> You could make it shorter by working out the error_type string earlier
> e.g.:
> |		char *error_type = "unknown_error";
> |			
> |		if  (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs)
> |			error_type = cper_proc_error_type_strs[err_info->type];
>

OK, I will do this change.


>
>> +		}
>
>> +		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
>> +			queued = true;
>
> | if (it_returned_true())
> | 	queued = true;
>
> Looks funny, and if you moved this earlier, your pr_warn_ratelimted() would have an extra
> level of indentation to play with.
> i.e.:
> |		if (is_cache && has_pa) {
> |			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
> |			continue;
> |		}
>

Right.

>
> Thanks,
>
> James
>
> .
>

