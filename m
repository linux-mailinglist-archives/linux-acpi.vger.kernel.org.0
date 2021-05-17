Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59F3834C3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbhEQPL6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 11:11:58 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:39666 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbhEQPKE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 11:10:04 -0400
Received: by mail-oo1-f50.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so1536358oot.6
        for <linux-acpi@vger.kernel.org>; Mon, 17 May 2021 08:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba1/1n5WRQwH83ACx88o0jxWLkFUcTvYCQ6wd+GAzr4=;
        b=eWglhySW1Ay+qDrmwRMlae4186gkTfak2cKL1YcJmBblc01PR+WKBH4aXNGwThcoRj
         FxlKj5C2gLH02XuttT0pGASSuMuoS2Ni1dEWY6Lffj7ef8KGPYC5k2p8JdQEf41s65rC
         upJPJgsKXZtAcOd/11U96yEvwyMAFqSyOdS4akjIFt4opszM6ONOwFzAHD7/ExwwSNJ4
         nVxNVAtydO5oMpaYvCr7DjhEQGzp54wG2DNNlMKs6GXuf8N4xO9U14vkUAsRekN1oi1b
         DDbcUuOD32Ya7ZjanaMd0iN5xfJMvpe68hEzrwKrWpzLVoNujpR5Jn6WaEvYH5eXISV+
         CxkA==
X-Gm-Message-State: AOAM5310vcvNZgDZ2p0IV0gMI8UKVCTtOMkuO2gpfqu3zaPeoC/fTK9s
        NykbXzXVp/BuR55dCURJHCtaEOqDI+J58h7Tqqat4Ovduo4=
X-Google-Smtp-Source: ABdhPJxmanjevSBcNPG8Lw5EAEHi2qQLTyoF1U4U2q4N4k/RhD2wSr6/VPvphz+Sx2YoAIUhqYVXUmKULHLHCIh5fbs=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr317668oou.44.1621264126024;
 Mon, 17 May 2021 08:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210512221514.32038-1-mario.limonciello@amd.com>
In-Reply-To: <20210512221514.32038-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 17:08:35 +0200
Message-ID: <CAJZ5v0hbmTO4vo_yKKUArpSSLUbJddR2TTCai+FQjHAV5YBsMg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI / idle: override c-state latency when not in
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

On Thu, May 13, 2021 at 1:12 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Generally the C-state latency is provided by the _CST method or FADT but
> some OEM platforms using AMD Picasso, Renoir, Van Gogh, and Cezanne set
> the C2 latency greater than C3's which causes the C2 state to be skipped.
> That will block the core entering PC6, which prevents s0ix working
> properly on Linux systems.
>
> In other operating systems the latency values are not validated and this
> does not cause problems by skipping states.
>
> To avoid this issue happening on Linux, detect when latencies are not an
> arithmetic progression and sort them.
>
> Link: https://gitlab.freedesktop.org/agd5f/linux/-/commit/026d186e4592c1ee9c1cb44295912d0294508725
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 5.14 material under a different subject ("ACPI: processor
idle: Fix up C-state latency if not ordered") and with some edits in
the changelog.

Thanks!

> ---
>  drivers/acpi/processor_idle.c | 40 +++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 4e2d76b8b697..6790df5a2462 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/sched.h>       /* need_resched() */
> +#include <linux/sort.h>
>  #include <linux/tick.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
> @@ -388,10 +389,37 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>         return;
>  }
>
> +static int acpi_cst_latency_cmp(const void *a, const void *b)
> +{
> +       const struct acpi_processor_cx *x = a, *y = b;
> +
> +       if (!(x->valid && y->valid))
> +               return 0;
> +       if (x->latency > y->latency)
> +               return 1;
> +       if (x->latency < y->latency)
> +               return -1;
> +       return 0;
> +}
> +static void acpi_cst_latency_swap(void *a, void *b, int n)
> +{
> +       struct acpi_processor_cx *x = a, *y = b;
> +       u32 tmp;
> +
> +       if (!(x->valid && y->valid))
> +               return;
> +       tmp = x->latency;
> +       x->latency = y->latency;
> +       y->latency = tmp;
> +}
> +
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
>  {
>         unsigned int i;
>         unsigned int working = 0;
> +       unsigned int last_latency = 0;
> +       unsigned int last_type = 0;
> +       bool buggy_latency = false;
>
>         pr->power.timer_broadcast_on_state = INT_MAX;
>
> @@ -415,12 +443,24 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>                 }
>                 if (!cx->valid)
>                         continue;
> +               if (cx->type >= last_type && cx->latency < last_latency)
> +                       buggy_latency = true;
> +               last_latency = cx->latency;
> +               last_type = cx->type;
>
>                 lapic_timer_check_state(i, pr, cx);
>                 tsc_check_state(cx->type);
>                 working++;
>         }
>
> +       if (buggy_latency) {
> +               pr_notice("FW issue: working around C-state latencies out of order\n");
> +               sort(&pr->power.states[1], max_cstate,
> +                    sizeof(struct acpi_processor_cx),
> +                    acpi_cst_latency_cmp,
> +                    acpi_cst_latency_swap);
> +       }
> +
>         lapic_timer_propagate_broadcast(pr);
>
>         return (working);
> --
> 2.25.1
>
