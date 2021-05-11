Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAB837A484
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhEKKZV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 06:25:21 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38656 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhEKKZT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 06:25:19 -0400
Received: by mail-oi1-f179.google.com with SMTP id z3so17348856oib.5
        for <linux-acpi@vger.kernel.org>; Tue, 11 May 2021 03:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4U2aBr7O9uDsISwJJm4bhv89p3LxYLpJ+YwHLwCKFY=;
        b=O6s0hkIPxF7Pe3MTWucyNhUXfVQl2wFOpvtFhcjKPF/c3gxTao/qyELfjgsCyMsKi1
         KsVWHkuGB+nW74fBsGrqUJh5JrFg7tJ5kEXiV6KjD3F7N95X1m8L2NjRd+U61dJFNXQ1
         +P5TS7e6fsDOioxN+nFGI+got1mjoTPLvbrnfgMCIdFSYwGq6caNr/tAqzIy5ae04ZKh
         Lh/vCtodB1V8f1EdwCDtJADfMAM56o6AchjbOJm7GlTBEfB3xpL1JMR9+I5A0OdTE1Co
         Pfp3/XEQiRWiTPfsVhFFIKss7l3mYQ5HK+1BFgBDusTZmDPP5+uwhUa5KspgXXbdg8Vs
         //Og==
X-Gm-Message-State: AOAM531Zzj7pf+/+D6iOY8SS1xV6xd9H1FUV3VCUrc7ehqoB/LZxF/QP
        lomwU5bH9WwtQRD4hmwvpF4LerNNpzPqUmYV24V7cqn5
X-Google-Smtp-Source: ABdhPJwJJeojI51Y4vImrJMAnPcdLqtkTYtExnC0WnNuTBBFVAJlC45FDsGKORxC78R2R/uL2jboE1DYqsEyu/yt8bQ=
X-Received: by 2002:aca:1815:: with SMTP id h21mr2439502oih.69.1620728652670;
 Tue, 11 May 2021 03:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210511025024.10083-1-mario.limonciello@amd.com>
In-Reply-To: <20210511025024.10083-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 May 2021 12:24:01 +0200
Message-ID: <CAJZ5v0jSZ-oR2m15emfWV4s2rCic=t7RAEXd0--yaHPbt820-w@mail.gmail.com>
Subject: Re: [PATCH] ACPI / idle: override c-state latency when not in
 conformance with s0ix
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Prike Liang <Prike.Liang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 11, 2021 at 4:50 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Generally the C-state latency is provided by the _CST method or FADT but
> some OEM platforms using AMD Picasso, Renoir, and Cezanne set the C2
> latency greater than C3's which causes the C2 state to be skipped.
> That will block the core entering PC6, which prevents s0ix working
> properly on Linux systems.

Well, if find_deepest_state() looked at the target residency instead
of the exit latency, this would work I suppose?

> In other operating systems the latency values are not validated and this
> does not cause problems by skipping states.
>
> Link: https://gitlab.freedesktop.org/agd5f/linux/-/commit/026d186e4592c1ee9c1cb44295912d0294508725
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 68 +++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 4e2d76b8b697..9d468e0e0cd7 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -30,6 +30,7 @@
>  #ifdef CONFIG_X86
>  #include <asm/apic.h>
>  #include <asm/cpu.h>
> +#include <asm/cpu_device_id.h>
>  #endif
>
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
> @@ -203,8 +204,73 @@ static void tsc_check_state(int state)
>                         mark_tsc_unstable("TSC halts in idle");
>         }
>  }
> +
> +struct cpu_cstate_quirks {
> +       int latency2;
> +       int latency3;
> +};
> +
> +static struct cpu_cstate_quirks amd_cst_bug = {
> +       .latency2 = 18,
> +       .latency3 = 350,
> +};
> +
> +static const struct x86_cpu_id cpu_match[] = {
> +       /* AMD Picasso */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x18, &amd_cst_bug),
> +       /* AMD Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x60, &amd_cst_bug),
> +       /* AMD Van Gogh */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x90, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x91, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x92, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x93, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x94, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x95, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x96, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x17, 0x97, &amd_cst_bug),
> +       /* AMD Cezanne */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x50, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x51, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x52, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x53, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x54, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x55, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x56, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x57, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x58, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x59, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5A, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5B, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5C, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5D, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5E, &amd_cst_bug),
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 0x19, 0x5F, &amd_cst_bug),
> +       {},
> +};
> +
> +static void acpi_processor_check_quirks(struct acpi_processor *pr)
> +{
> +       const struct x86_cpu_id *id = x86_match_cpu(cpu_match);
> +       struct cpu_cstate_quirks *quirks;
> +
> +       if (!id)
> +               return;
> +       quirks = (struct cpu_cstate_quirks *)id->driver_data;
> +       /* correct some OEM BIOS that mistakingly set C2 latency higher
> +        * than C3 making C2 seem like an invalid state
> +        */
> +       if (max_cstate >= 3 &&
> +           pr->power.states[2].latency >= pr->power.states[3].latency &&
> +           quirks->latency2 && quirks->latency3) {
> +               pr->power.states[2].latency = quirks->latency2;
> +               pr->power.states[3].latency = quirks->latency3;
> +               pr_notice("overriding known buggy C2 latency\n");
> +       }
> +}
>  #else
>  static void tsc_check_state(int state) { return; }
> +static void acpi_processor_check_quirks(struct acpi_processor *pr) { return; }
>  #endif
>
>  static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
> @@ -447,6 +513,8 @@ static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>
>         acpi_processor_get_power_info_default(pr);
>
> +       acpi_processor_check_quirks(pr);
> +
>         pr->power.count = acpi_processor_power_verify(pr);
>
>         /*
> --
> 2.25.1
>
