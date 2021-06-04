Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6CC39BAD0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhFDOUw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 10:20:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhFDOUv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 10:20:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D3372B;
        Fri,  4 Jun 2021 07:19:05 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20A173F774;
        Fri,  4 Jun 2021 07:19:02 -0700 (PDT)
Subject: Re: [PATCH v5] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     Xiaofei Tan <tanxiaofei@huawei.com>, rafael@kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        bp@alien8.de, akpm@linux-foundation.org, jroedel@suse.de,
        peterz@infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1607602177-1507-1-git-send-email-tanxiaofei@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d57d786c-f9cb-46ba-78d0-3675666272f2@arm.com>
Date:   Fri, 4 Jun 2021 15:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1607602177-1507-1-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Xiaofei Tan,

Sorry for the delayed response,
this still applies and builds to v5.13-rc4.

On 10/12/2020 12:09, Xiaofei Tan wrote:
> After the commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> synchronise with APEI's irq work") applied, do_sea() return directly
> for user-mode if apei_claim_sea() handled any error record. Therefore,
> each error record reported by the user-mode SEA must be effectively
> processed in APEI GHES driver.

If you describe it the other way round, it would be clearer what the problem here is.
Something like:
| Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise
| with APEI's irq work"), do_sea() would unconditionally signal the affected task
| from the arch code. Since that change, the GHES driver sends the signals,.
| This exposes a problem as errors the GHES driver doesn't understand are silently
| ignored.


> Currently, GHES driver only processes Memory Error Section.(Ignore PCIe
> Error Section, as it has nothing to do with SEA).

(you're starting to confuse me! - I went and checked before I realised you were talking to
me, not describing the code...)

> It is not enough. > Because ARM Processor Error could also be used for SEA in some hardware
> platforms, such as Kunpeng9xx series. We can't ask them to switch to
> use Memory Error Section for two reasons:
> 1)The server was delivered to customers, and it will introduce
> compatibility issue.
> 2)It make sense to use ARM Processor Error Section. Because either
> cache or memory errors could generate SEA when consumed by a processor.

I think you just need to say:
| Existing firmware on Kunpeng9xx systems reports cache errors with the 'ARM Processor
| Error' CPER records.


Could you add something about why the silent-ignore is a problem? Do the errors get taken
again? Does user-space get stuck in this loop?


> Do memory failure handling for ARM Processor Error Section just like
> for Memory Error Section.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fce7ade..0893968 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c

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

err_info has a version and a length, so its expected to be made bigger at some point.
It would be better to use the length instead of 'err_info++', or at least to break out of
the loop if a length > sizeof(*err_info) is seen.

With that:
Reviewed-by: James Morse <james.morse@arm.com>


The following nits would make this easier to read:

> +		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
> +		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);

> +		/*
> +		 * The field (err_info->error_info & BIT(26)) is fixed to set to
> +		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
> +		 * firmware won't mix corrected errors in an uncorrected section,
> +		 * and don't filter out 'corrected' error here.
> +		 */
(Nothing reads err_info->error_info, I guess this is a warning to the next person to touch
this)


> +		if (!is_cache || !has_pa) {
> +			pr_warn_ratelimited(FW_WARN GHES_PFX
> +			"Unhandled processor error type %s\n",
> +			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
> +			cper_proc_error_type_strs[err_info->type] : "unknown error");
> +			continue;

This is hard to read. The convention is to indent the extra lines to the relevant '('.
e.g.:
|			pr_warn_ratelimited(FW_WARN GHES_PFX
|					    "Unhandled processor error type %s\n",

You could make it shorter by working out the error_type string earlier
e.g.:
|		char *error_type = "unknown_error";
|			
|		if  (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs)
|			error_type = cper_proc_error_type_strs[err_info->type];


> +		}

> +		if (ghes_do_memory_failure(err_info->physical_fault_addr, 0))
> +			queued = true;

| if (it_returned_true())
| 	queued = true;

Looks funny, and if you moved this earlier, your pr_warn_ratelimted() would have an extra
level of indentation to play with.
i.e.:
|		if (is_cache && has_pa) {
|			queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
|			continue;
|		}


Thanks,

James
