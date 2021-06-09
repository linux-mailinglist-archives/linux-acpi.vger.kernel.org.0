Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839583A156F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhFINZG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:25:06 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38450 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhFINZF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:25:05 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10277276otk.5;
        Wed, 09 Jun 2021 06:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wNfcwQ4q6mSgQUiBQC9ZHhM+heDyjoYvZ01H+MstbQ=;
        b=m8ISMGgx9vCD/lCKVoBBZ7V+ZfeJt5iWddrSKjpWdLRr0Ltj6Qo84gLl4yjHN80k4f
         epLi7DhtVa8n1j8LfC9sxKDghA85NhQS6eXCyRyFnhRssucKAZAEwwDWDm/8oylOdvLZ
         RB2dXxw+6L8cCSeSGeZ215i5r6yIDANvhelSTWFCuuOcpcoSSZyaAmwUil2PlIgi8aJA
         c7i5cItODRsnGh7F55rMyi76HLap73NB3gkqGMUB6SFfilpVsOSKCJGiZotsOd0dqgov
         i7aDaPan30dvngJd4Mmzb95Od5xy1nnAObd2Ie/eAA10rB7yfDvQkaf6hqhAkuKgrNU1
         KY1Q==
X-Gm-Message-State: AOAM531IeuI5SJkaMj0RWy/c1qjoKsK/bhaTqcxQpGbROm19w+tdE/lv
        /HbhJxCLI62iTTONsWUAORatSpCUfsoFxZ/sQsw=
X-Google-Smtp-Source: ABdhPJzYN6rt1ee7irlDPVN2uDJ0SsgiqxV4jKjoFBec8CtT94LjptYJtY5F0f0xN5tubPu1JK1jDYpxx1jaa5u5dgU=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr4143410otb.206.1623244974564;
 Wed, 09 Jun 2021 06:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <1623218580-41912-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1623218580-41912-1-git-send-email-tanxiaofei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:22:43 +0200
Message-ID: <CAJZ5v0ifxfuwdHd9HrWby6qdXwCq1YHbk6UapQL3g39TGynLHg@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jun 9, 2021 at 8:06 AM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>
> Before commit 8fcc4ae6faf8 ("arm64: acpi: Make apei_claim_sea()
> synchronise with APEI's irq work"), do_sea() would unconditionally
> signal the affected task from the arch code. Since that change,
> the GHES driver sends the signals.

Since this fixes a regression apparently introduced by the above
commit, please add a Fixes tag pointing to that commit to it.

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

So why is this the right thing to do?

I guess it doesn't address the problem entirely, but only in this
particular case, so what if the firmware on some other platform
reports errors with a new type unknown to the GHES driver?  Will the
problem show up again?

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
