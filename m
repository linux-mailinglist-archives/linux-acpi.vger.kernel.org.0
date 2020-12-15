Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB92DB37B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Dec 2020 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgLOSOJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Dec 2020 13:14:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34049 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbgLOSNp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Dec 2020 13:13:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id a109so20288642otc.1;
        Tue, 15 Dec 2020 10:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+neHbL09Xun/NNti/k5yNFLU2L8mIit4SQGtYnlEOEc=;
        b=paxitfby3z/OlDAndF5YTPEhEY6ST5WdpzvETifcJX3LF+iQQI8LWlDTHAqzgt2scD
         bYUC+pUTccCx3NMfAHRtPJEzVlhdc87Yd3xBdHqTl8affvNVdatld/DH4OL46PwG5ZGt
         rPf8jmL3LgrqUPGrW1GHFiEux1XmGHWENXTVKAGPSfA6R8kjgqgha5bFtfBB9SzIJeoa
         LbDa9WBmS+ZN9MRMR+ffrW3nKZ3sRWP4LVYkGzbkYF5TuOFm7Mu1u4QtkyYvfGY9IL4F
         v6dWf/fW57ymkQnvqs1Cvy3cLeENdBBRgOfk1UJXeIex7GTkzAcTPxLMOTcw2I6P9CKV
         dObw==
X-Gm-Message-State: AOAM530gGzAjLoE/MLdzGn9lqSQAJAUJRniGxQuVpJ+uTZt6T/ToBaoh
        EDQU5GS7FqblrKUu7DxLB2LUFnfPXYKTqDhRqFM=
X-Google-Smtp-Source: ABdhPJwAkvLUYOyUqkQrNmkKDu5aQ3C3svYexbkyjDzgdXTvkqLtmr/PmM8M1Anz9ly/XCEqsOsBnVDujJWIAG0Q5nA=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr22168853ota.260.1608055984455;
 Tue, 15 Dec 2020 10:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20201214120740.10948-1-ionela.voinescu@arm.com>
In-Reply-To: <20201214120740.10948-1-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Dec 2020 19:12:53 +0100
Message-ID: <CAJZ5v0jKf3f5AAGWJJJR72SOw-m0yuaEK56mQYJ=Ho=oOHdaCw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: processor: fix NONE coordination for domain
 mapping failure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 14, 2020 at 1:48 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> For errors parsing the _PSD domains, a separate domain is returned for
> each CPU in the failed _PSD domain with no coordination (as per previous
> comment). But contrary to the intention, the code was setting
> CPUFREQ_SHARED_TYPE_ALL as coordination type.
>
> Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
> the domain information. The function still returns the error and the caller
> is free to bail out the domain initialisation altogether in that case.
>
> Given that both functions return domains with a single CPU, this change
> does not affect the functionality, but clarifies the intention.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> [ rjw: Subject edit ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Hi guys,
>
> I'm sending v2 of some of the patches at [1] in light of the discussions
> at [2].
>
> This patch is a trivial rebase on linux next 20201211, submitted separately
> due to its lack of dependency on the other patches.
>
> [1] https://lore.kernel.org/linux-pm/20201105125524.4409-1-ionela.voinescu@arm.com/#t
> [2] https://lore.kernel.org/linux-pm/20201210142139.20490-1-yousaf.kaukab@suse.com/

Applied as 5.11-rc material, thanks!

>  drivers/acpi/cppc_acpi.c         | 2 +-
>  drivers/acpi/processor_perflib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a852dc4927f7..62f55db443c1 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -512,7 +512,7 @@ int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
>                 /* Assume no coordination on any error parsing domain info */
>                 cpumask_clear(pr->shared_cpu_map);
>                 cpumask_set_cpu(i, pr->shared_cpu_map);
> -               pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +               pr->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>         }
>  out:
>         free_cpumask_var(covered_cpus);
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 0dcedd652807..32f0f554ccae 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -708,7 +708,7 @@ int acpi_processor_preregister_performance(
>                 if (retval) {
>                         cpumask_clear(pr->performance->shared_cpu_map);
>                         cpumask_set_cpu(i, pr->performance->shared_cpu_map);
> -                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +                       pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>                 }
>                 pr->performance = NULL; /* Will be set for real in register */
>         }
> --
> 2.29.2.dirty
>
