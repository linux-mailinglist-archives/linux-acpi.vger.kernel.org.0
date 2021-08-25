Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1C3F7BAD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhHYRtZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 13:49:25 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33465 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHYRtZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 13:49:25 -0400
Received: by mail-oi1-f178.google.com with SMTP id n27so846754oij.0;
        Wed, 25 Aug 2021 10:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oN8MaQRWB2ARwAjkxsd31oxcs1o1bX4XvGF14YSFh0w=;
        b=QALozDpfqadJoEvRNQ3C/tMYLUC+5q5/nJaUc/9XtfGEVh94FVhiUS8fT1hCXCXp8f
         ZzARNY6ko/OKdLERcXdw3RBO0PfZbBlzGEKq/FoUr/khJxNFEt1E0FP+kZFt3AVYJvDk
         AxH2LKPEhE5IlyBjZrRYIUjCkXBWRnpx6eMQVxOPSZzQyNu1Qrsrc9H5/Is+M+ZrON9V
         BsS6zMNnLzaqhAQ8h5hrl8kxLphkB5dNZb1smV03Kjf0GmKXXBrT3SMyF39RA3qUnwxH
         4A482cFOj6upnC9hPiSbxes1RLy7jS+R4dx1yPWlbFG8zx0DWEdXoGUs7PvXV6P25pkR
         l1Pw==
X-Gm-Message-State: AOAM533pUBTsA98wSwSjc/YPqlowJ405deKQTqHP0cIRnolWhjeB2YHR
        16gwwxabty1yD06SeLoWf5GvKQqk344YysDe+1c=
X-Google-Smtp-Source: ABdhPJyeQCRjEBRF2fh37jTBDPKOtYuXLBQHOCwekpq26Y3kiTqbuJsjGGHCM88j7jiPJ6lfBYY8gxKUW0+fmSrM1J0=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr7802452oie.71.1629913718705;
 Wed, 25 Aug 2021 10:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210824105651.28660-1-ionela.voinescu@arm.com> <20210824105651.28660-2-ionela.voinescu@arm.com>
In-Reply-To: <20210824105651.28660-2-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 19:48:28 +0200
Message-ID: <CAJZ5v0jaRaP-+Zxx9NS8OcREEbmcJo1Zs-p3gT9BLNKBtNtqyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86, ACPI: rename init_freq_invariance_cppc to arch_init_invariance_cppc
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 24, 2021 at 12:57 PM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
> after CPU performance information and controls were populated from the
> per-cpu _CPC objects.
>
> But these _CPC objects provide information that helps with both CPU
> (u-arch) and frequency invariance. Therefore, change the function name
> to a more generic one, while adding the arch_ prefix, as this function
> is expected to be defined differently by different architectures.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/include/asm/topology.h | 2 +-
>  drivers/acpi/cppc_acpi.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 9239399e5491..61d73013cab8 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -220,7 +220,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  void init_freq_invariance_cppc(void);
> -#define init_freq_invariance_cppc init_freq_invariance_cppc
> +#define arch_init_invariance_cppc init_freq_invariance_cppc
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a4d4eebba1da..c211d77310e8 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -660,8 +660,8 @@ static bool is_cppc_supported(int revision, int num_ent)
>   *     }
>   */
>
> -#ifndef init_freq_invariance_cppc
> -static inline void init_freq_invariance_cppc(void) { }
> +#ifndef arch_init_invariance_cppc
> +static inline void arch_init_invariance_cppc(void) { }
>  #endif
>
>  /**
> @@ -826,7 +826,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                 goto out_free;
>         }
>
> -       init_freq_invariance_cppc();
> +       arch_init_invariance_cppc();
>
>         kfree(output.pointer);
>         return 0;
> --
> 2.29.2.dirty
>
