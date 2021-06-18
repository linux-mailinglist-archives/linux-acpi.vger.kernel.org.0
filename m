Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2043AD06A
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhFRQcf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:32:35 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44676 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhFRQcc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 12:32:32 -0400
Received: by mail-ot1-f51.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so3621846ote.11
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 09:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evz/5ICuJOU6mgEio4sKRA25gC0B4sX9s7jX/BzCpXI=;
        b=VmtGXO5uzIwNWYLQt92oIHffV8XvYdNfV0MA/qVgw8VbJnKENGaCJpXGYTfiuIGVRw
         Spj7CKr1F492GGutSvrrb8hobEprsyxMVr4+hUmV/O3VRaF1gSgAzhpqhSKhxyXRVqXl
         aXp35u76X6hGErYpHFockxVamod2qYpHTzWtPtpguz0H7bAZmgqWB77dTqZ/5D8JJxPd
         7P+0+Rxt+FQKY0DHqMxHbS6mR3WbdaE7PS2y5pv7LhBgQvdFTxQykWc71vexo0mYU6wa
         oK4Gv689a1w7f/4LcDRUVjT/a/E0jG30ihRnd2Rh8L8pHBUADD2OP1RMjB4Et48HrDA/
         Lo0A==
X-Gm-Message-State: AOAM533t6MoM4CikB01jfTEkTZZ7o5NT0PNRrnYRgM3VYUWGh/KTJiqO
        nFsPHS/CjYreqEyOiwdaI5RyQeWD4pOYrmnuyLk=
X-Google-Smtp-Source: ABdhPJzIrE6UZCgP9U7QzqjlcZfS+KHNQ7ctGkyErVcVF+3DDiWVGTN1x+oTypiaUzaZrsqttbK2TpuWu1aJF3sZRBg=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr10573615otb.206.1624033821411;
 Fri, 18 Jun 2021 09:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210617164212.584-1-mario.limonciello@amd.com> <20210617164212.584-3-mario.limonciello@amd.com>
In-Reply-To: <20210617164212.584-3-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jun 2021 18:30:10 +0200
Message-ID: <CAJZ5v0gryewS7GFY_vBd4QAc_5hSG3PH2pZ4xyjStt7TxeCO0Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] ACPI: PM: s2idle: Add support for multiple func mask
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 17, 2021 at 6:42 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
>
> Required for follow-up patch adding new UUID
> needing new function mask.
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Your s-o-b is missing.

> ---
>  drivers/acpi/x86/s2idle.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index c0cba025072f..0d19669ac7ad 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -309,14 +309,15 @@ static void lpi_check_constraints(void)
>         }
>  }
>
> -static void acpi_sleep_run_lps0_dsm(unsigned int func)
> +static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, guid_t dsm_guid)
>  {
>         union acpi_object *out_obj;
>
> -       if (!(lps0_dsm_func_mask & (1 << func)))
> +       if (!(func_mask & (1 << func)))
>                 return;
>
> -       out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
> +       out_obj = acpi_evaluate_dsm(lps0_device_handle, &dsm_guid,
> +                                       rev_id, func, NULL);
>         ACPI_FREE(out_obj);
>
>         acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> @@ -412,11 +413,15 @@ int acpi_s2idle_prepare_late(void)
>                 lpi_check_constraints();
>
>         if (acpi_s2idle_vendor_amd()) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>         } else {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>         }
>
>         return 0;
> @@ -428,11 +433,15 @@ void acpi_s2idle_restore_early(void)
>                 return;
>
>         if (acpi_s2idle_vendor_amd()) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>         } else {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +                               lps0_dsm_func_mask, lps0_dsm_guid);
>         }
>  }
>
> --
> 2.25.1
>
