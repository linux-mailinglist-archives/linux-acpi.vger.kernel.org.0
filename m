Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608D3A755D
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jun 2021 05:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhFODtP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 23:49:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6501 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFODtP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 23:49:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3vM22nwQzZh5D;
        Tue, 15 Jun 2021 11:44:14 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:47:08 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 11:47:08 +0800
Subject: Re: [PATCH v7] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        James Morse <james.morse@arm.com>
References: <1623415027-36130-1-git-send-email-tanxiaofei@huawei.com>
 <CAJZ5v0gvzZ-64AJuEsOg2M=veZYz+9ciG5wFEQT7ghki2SNpPA@mail.gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <d38b018d-2adf-9549-ba55-44289c816fed@huawei.com>
Date:   Tue, 15 Jun 2021 11:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gvzZ-64AJuEsOg2M=veZYz+9ciG5wFEQT7ghki2SNpPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2021/6/14 23:46, Rafael J. Wysocki wrote:
> On Fri, Jun 11, 2021 at 2:40 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>
>> Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
>> synchronise with APEI's irq work"), do_sea() would unconditionally
>> signal the affected task from the arch code. Since that change,
>> the GHES driver sends the signals.
>>
>> This exposes a problem as errors the GHES driver doesn't understand
>> or doesn't handle effectively are silently ignored. It will cause
>> the errors get taken again, and circulate endlessly. User-space task
>> get stuck in this loop.
>>
>> Existing firmware on Kunpeng9xx systems reports cache errors with the
>> 'ARM Processor Error' CPER records.
>>
>> Do memory failure handling for ARM Processor Error Section just like
>> for Memory Error Section.
>
> Still, I'm not convinced that this is the right way to address the problem.
>
> In particular, is it guaranteed that "ARM Processor Error" will always
> mean "memory failure" on all platforms?
>

There are two sources for ARM Processor cache errors(no second case for the platform that doesn't support poison mechanism).
1.occur in the cache. If it is transient, we have a chance to recover by doing memory failure.
If it is persistent, we have to handle in other place, such as do cache way isolation in firmware,
or trigger cpu core isolation in user space. I think most platform can't support such feature,
so the most simple and effective way is report as fatal error and do isolation during firmware start-up phase.

2.error transferred from other RAS node. If it is from DDR, i think there is no doubt, and this is
the most cases we met before.If it is from other place of SoC, such as internal SRAM(the probability is very little compare to DDR),
the error is still in the hardware. But the RAS node that detected the SRAM error will also report the error.

To sum up the above, it is effective for most situation, and no harm for the others.

> If not, doing a platform-specific quirk might be better.
>
> James, I need you to hear from you here I suppose.
>
>> Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>>
>> ---
>> Changes since v5:
>> - Do some changes following James's suggestions: 1) optimize commit log
>> 2) use err_info->length instead of err_info++' 3) some coding style
>> advice.
>>
>> Changes since v4:
>> - 1. Change the patch name from " ACPI / APEI: do memory failure on the
>> physical address reported by ARM processor error section" to this
>> more proper one.
>> - 2. Add a comment in the code to tell why not filter out corrected
>> error in an uncorrected section.
>>
>> Changes since v3:
>> - Print unhandled error following James Morse's advice.
>>
>> Changes since v2:
>> - Updated commit log
>> ---
>>  drivers/acpi/apei/ghes.c | 81 ++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 64 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index fce7ade..0c8330e 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)
>>         gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>>  }
>>
>> -static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>> -                                      int sev)
>> +static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  {
>>         unsigned long pfn;
>> -       int flags = -1;
>> -       int sec_sev = ghes_severity(gdata->error_severity);
>> -       struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>>
>>         if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>>                 return false;
>>
>> -       if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>> -               return false;
>> -
>> -       pfn = mem_err->physical_addr >> PAGE_SHIFT;
>> +       pfn = PHYS_PFN(physical_addr);
>>         if (!pfn_valid(pfn)) {
>>                 pr_warn_ratelimited(FW_WARN GHES_PFX
>>                 "Invalid address in generic error data: %#llx\n",
>> -               mem_err->physical_addr);
>> +               physical_addr);
>>                 return false;
>>         }
>>
>> +       memory_failure_queue(pfn, flags);
>> +       return true;
>> +}
>> +
>> +static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>> +                                      int sev)
>> +{
>> +       int flags = -1;
>> +       int sec_sev = ghes_severity(gdata->error_severity);
>> +       struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>> +
>> +       if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>> +               return false;
>> +
>>         /* iff following two events can be handled properly by now */
>>         if (sec_sev == GHES_SEV_CORRECTED &&
>>             (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
>> @@ -470,14 +477,56 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>>         if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>>                 flags = 0;
>>
>> -       if (flags != -1) {
>> -               memory_failure_queue(pfn, flags);
>> -               return true;
>> -       }
>> +       if (flags != -1)
>> +               return ghes_do_memory_failure(mem_err->physical_addr, flags);
>>
>>         return false;
>>  }
>>
>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>> +{
>> +       struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>> +       bool queued = false;
>> +       int sec_sev, i;
>> +       char *p;
>> +
>> +       log_arm_hw_error(err);
>> +
>> +       sec_sev = ghes_severity(gdata->error_severity);
>> +       if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>> +               return false;
>> +
>> +       p = (char *)(err + 1);
>> +       for (i = 0; i < err->err_info_num; i++) {
>> +               struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
>> +               bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
>> +               bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
>> +               const char *error_type = "unknown error";
>> +
>> +               /*
>> +                * The field (err_info->error_info & BIT(26)) is fixed to set to
>> +                * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
>> +                * firmware won't mix corrected errors in an uncorrected section,
>> +                * and don't filter out 'corrected' error here.
>> +                */
>> +               if (is_cache && has_pa) {
>> +                       queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
>> +                       p += err_info->length;
>> +                       continue;
>> +               }
>> +
>> +               if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
>> +                       error_type = cper_proc_error_type_strs[err_info->type];
>> +
>> +               pr_warn_ratelimited(FW_WARN GHES_PFX
>> +                                   "Unhandled processor error type: %s\n",
>> +                                   error_type);
>> +               p += err_info->length;
>> +       }
>> +
>> +       return queued;
>> +}
>> +
>>  /*
>>   * PCIe AER errors need to be sent to the AER driver for reporting and
>>   * recovery. The GHES severities map to the following AER severities and
>> @@ -605,9 +654,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>>                         ghes_handle_aer(gdata);
>>                 }
>>                 else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>> -                       struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>> -
>> -                       log_arm_hw_error(err);
>> +                       queued = ghes_handle_arm_hw_error(gdata, sev);
>>                 } else {
>>                         void *err = acpi_hest_get_payload(gdata);
>>
>> --
>> 2.8.1
>>
>
> .
>

