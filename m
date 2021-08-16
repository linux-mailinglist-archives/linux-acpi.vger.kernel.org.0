Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF023EDAFA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhHPQaw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 12:30:52 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:37826 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhHPQav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 12:30:51 -0400
Received: by mail-oo1-f41.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so5121354ooi.4
        for <linux-acpi@vger.kernel.org>; Mon, 16 Aug 2021 09:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRzOLffUL0G8w5kUeO7SDimTni/kC8VLNoLI6Stxcvk=;
        b=b5fA1dmPgOesbtsvlMOPeN05uuge4vslKBN3u+lq+1kxLj1FvDOhWuluKnQWJvrqNF
         6whDADYYnhCryZxNWpGQae7wND2hazhh3/gzmYJ1NHl2M3JR+4Vj79ldTvZBLd3nC4PW
         1Y5af5hZc0rMWQOlQP5GlVbUa1JOgdMCDpWbqXvWB1zX2U7Jse8lyasYunNGgHMZ4oG4
         psgq48sOxp3BVIzGx2yLa/BaCNZHdWYJuWArQK5Qf72kSk8CymA8yeFNO3sW6QxynrXE
         l2QWATXbdi7TJRg1srDYU7LfuYqLwx/CQG+bKSbze1kmbnIR6VyB/f/cS2/ah5Q2xDsH
         d4lA==
X-Gm-Message-State: AOAM533rO0lumcQ8Cf22rWVYpDeyUnIvxhbwk4KbkQlQC7IDf8MAXlkQ
        4254Gor1vEHPgRHWvvhqPn6kvWo5dilSOomvY34=
X-Google-Smtp-Source: ABdhPJwCa1zjs6u26/VWc7HF7a6aqpFxNivoRmKLkiW6dWQfkvhU4scaNwxKi/B61AVHiE7BD9lxeo118kqeMlqsjdw=
X-Received: by 2002:a4a:dcd0:: with SMTP id h16mr5983734oou.44.1629131419681;
 Mon, 16 Aug 2021 09:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210810014004.16399-1-mario.limonciello@amd.com>
In-Reply-To: <20210810014004.16399-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 18:30:08 +0200
Message-ID: <CAJZ5v0iUwBKGGFarPwhSUcjgHmNVA9T1T+wapXABYg70GqkoRg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Invert Microsoft UUID entry and exit
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 10, 2021 at 3:40 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> It was reported by a user with a Dell m15 R5 (5800H) that
> the keyboard backlight was turning on when entering suspend
> and turning off when exiting (the opposite of how it should be).
>
> The user bisected it back to commit 5dbf50997578 ("ACPI: PM:
> s2idle: Add support for new Microsoft UUID").  Previous to that
> commit the LEDs didn't turn off at all.  Confirming in the spec,
> these were reversed when introduced.
>
> Fix them to match the spec.
>
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_1021836
> Fixes: 5dbf50997578 ("ACPI: PM: s2idle: Add support for new Microsoft UUID")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index fbdbef0ab552..3a308461246a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -452,7 +452,7 @@ int acpi_s2idle_prepare_late(void)
>         if (lps0_dsm_func_mask_microsoft > 0) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> @@ -479,7 +479,7 @@ void acpi_s2idle_restore_early(void)
>         if (lps0_dsm_func_mask_microsoft > 0) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> --

Applied as 5.14-rc material, thanks!
