Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4C3A6AD1
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhFNPsU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 11:48:20 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34337 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhFNPsS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2021 11:48:18 -0400
Received: by mail-ot1-f50.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so8909346ott.1;
        Mon, 14 Jun 2021 08:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toPUT2S1k5OdAiBpsMpdY9PJGsGmpvlDZZQEqj7J4K8=;
        b=UN44xwqWVaSLArQynXoiLhaKpdZWAejrpxOhMrunmOoESvGtUN72UGT/ukBmJdjwvb
         CtrLTRlMwHp7Ewgwua1t+DpQquZIsf8Jkl+UMlj85tNXE/NqPbZK8EfyJc+vaYeaLlxQ
         xxhUTK+OhWAWVSYSTrM9TMFC0ByctyoVLu7537KL8cHt/5qtfvtZbE2y2n/AGEdgZRnZ
         98W1+YxYj2ZHONAX8b0WSDBFx7+yVGqI10MdHXBzeTuTQMV8J0zejJQsGpOMqp7slp2q
         rO2uQq5rF0c40li5fl7/mqZo7ADUCoJcCW8nZnGJZB47FPqtFIUfYGlt+R4Q6URtPp+7
         /S1Q==
X-Gm-Message-State: AOAM531Tx6LCKmD/KHghDQyaRhCZrXvaH1vXXUwgbklXMU93/1o6JdlP
        4Ad8USwuEfZcIdMLZBthNZhufAMVRnJAOniG8Cw=
X-Google-Smtp-Source: ABdhPJxI6CokphsCMyrl2sgFpJssavunGyo5E2JfiSLIKArok1Yi/ETvJBzr7x5Lx4uNkiOWqjX+RKHKMXrPM/cry28=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr14381825otb.206.1623685575508;
 Mon, 14 Jun 2021 08:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <1623415027-36130-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1623415027-36130-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Jun 2021 17:46:04 +0200
Message-ID: <CAJZ5v0gvzZ-64AJuEsOg2M=veZYz+9ciG5wFEQT7ghki2SNpPA@mail.gmail.com>
Subject: Re: [PATCH v7] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     Xiaofei Tan <tanxiaofei@huawei.com>,
        James Morse <james.morse@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 11, 2021 at 2:40 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> synchronise with APEI's irq work"), do_sea() would unconditionally
> signal the affected task from the arch code. Since that change,
> the GHES driver sends the signals.
>
> This exposes a problem as errors the GHES driver doesn't understand
> or doesn't handle effectively are silently ignored. It will cause
> the errors get taken again, and circulate endlessly. User-space task
> get stuck in this loop.
>
> Existing firmware on Kunpeng9xx systems reports cache errors with the
> 'ARM Processor Error' CPER records.
>
> Do memory failure handling for ARM Processor Error Section just like
> for Memory Error Section.

Still, I'm not convinced that this is the right way to address the problem.

In particular, is it guaranteed that "ARM Processor Error" will always
mean "memory failure" on all platforms?

If not, doing a platform-specific quirk might be better.

James, I need you to hear from you here I suppose.

> Fixes: 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work")
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: James Morse <james.morse@arm.com>
>
> ---
> Changes since v5:
> - Do some changes following James's suggestions: 1) optimize commit log
> 2) use err_info->length instead of err_info++' 3) some coding style
> advice.
>
> Changes since v4:
> - 1. Change the patch name from " ACPI / APEI: do memory failure on the
> physical address reported by ARM processor error section" to this
> more proper one.
> - 2. Add a comment in the code to tell why not filter out corrected
> error in an uncorrected section.
>
> Changes since v3:
> - Print unhandled error following James Morse's advice.
>
> Changes since v2:
> - Updated commit log
> ---
>  drivers/acpi/apei/ghes.c | 81 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index fce7ade..0c8330e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -441,28 +441,35 @@ static void ghes_kick_task_work(struct callback_head *head)
>         gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>  }
>
> -static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
> -                                      int sev)
> +static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>         unsigned long pfn;
> -       int flags = -1;
> -       int sec_sev = ghes_severity(gdata->error_severity);
> -       struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>
>         if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>                 return false;
>
> -       if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> -               return false;
> -
> -       pfn = mem_err->physical_addr >> PAGE_SHIFT;
> +       pfn = PHYS_PFN(physical_addr);
>         if (!pfn_valid(pfn)) {
>                 pr_warn_ratelimited(FW_WARN GHES_PFX
>                 "Invalid address in generic error data: %#llx\n",
> -               mem_err->physical_addr);
> +               physical_addr);
>                 return false;
>         }
>
> +       memory_failure_queue(pfn, flags);
> +       return true;
> +}
> +
> +static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
> +                                      int sev)
> +{
> +       int flags = -1;
> +       int sec_sev = ghes_severity(gdata->error_severity);
> +       struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
> +
> +       if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +               return false;
> +
>         /* iff following two events can be handled properly by now */
>         if (sec_sev == GHES_SEV_CORRECTED &&
>             (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> @@ -470,14 +477,56 @@ static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
>         if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
>                 flags = 0;
>
> -       if (flags != -1) {
> -               memory_failure_queue(pfn, flags);
> -               return true;
> -       }
> +       if (flags != -1)
> +               return ghes_do_memory_failure(mem_err->physical_addr, flags);
>
>         return false;
>  }
>
> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
> +{
> +       struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> +       bool queued = false;
> +       int sec_sev, i;
> +       char *p;
> +
> +       log_arm_hw_error(err);
> +
> +       sec_sev = ghes_severity(gdata->error_severity);
> +       if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
> +               return false;
> +
> +       p = (char *)(err + 1);
> +       for (i = 0; i < err->err_info_num; i++) {
> +               struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
> +               bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
> +               bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
> +               const char *error_type = "unknown error";
> +
> +               /*
> +                * The field (err_info->error_info & BIT(26)) is fixed to set to
> +                * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
> +                * firmware won't mix corrected errors in an uncorrected section,
> +                * and don't filter out 'corrected' error here.
> +                */
> +               if (is_cache && has_pa) {
> +                       queued = ghes_do_memory_failure(err_info->physical_fault_addr, 0);
> +                       p += err_info->length;
> +                       continue;
> +               }
> +
> +               if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
> +                       error_type = cper_proc_error_type_strs[err_info->type];
> +
> +               pr_warn_ratelimited(FW_WARN GHES_PFX
> +                                   "Unhandled processor error type: %s\n",
> +                                   error_type);
> +               p += err_info->length;
> +       }
> +
> +       return queued;
> +}
> +
>  /*
>   * PCIe AER errors need to be sent to the AER driver for reporting and
>   * recovery. The GHES severities map to the following AER severities and
> @@ -605,9 +654,7 @@ static bool ghes_do_proc(struct ghes *ghes,
>                         ghes_handle_aer(gdata);
>                 }
>                 else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -                       struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> -
> -                       log_arm_hw_error(err);
> +                       queued = ghes_handle_arm_hw_error(gdata, sev);
>                 } else {
>                         void *err = acpi_hest_get_payload(gdata);
>
> --
> 2.8.1
>
