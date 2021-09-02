Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06CE3FF10B
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346246AbhIBQRs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 12:17:48 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43795 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbhIBQRp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 12:17:45 -0400
Received: by mail-ot1-f52.google.com with SMTP id x10-20020a056830408a00b004f26cead745so3173857ott.10
        for <linux-acpi@vger.kernel.org>; Thu, 02 Sep 2021 09:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyZOl70SkSCm7xLHTWRERpMl/pIFluMZB1oK0Mr2pMs=;
        b=TRXxa8DQaUXtjnuZIkYyaVsCW7IVdSsT8Bhh0JyEPSd0ZLDwzN2F3jZJ3NwU5MhMBT
         qjvcx4Ut92m0pV+jcx10npuS8cy4OD7ogAxYOTcb4CNlAfmGpedcBZxlGc3XQ+7ILSvk
         PcyNwNHqqm2teUxc/piCBe+sAD6FSjwJfs/tCH9/H4zDREea35wt2rNRNHUJAwibtbOU
         u6OZ9cgS5pkHlRlbz3fsbD9N/EIrdJgPhoPgq6fn9KhIG9iU1z0eafZXOzmlqBV8+JGL
         YoMsg8EivqJ9WCovuAgP44KXnsr/9jbJHr6w4RuvT4bFW70sr2nEU3aKbECuOQQCyehi
         g2EA==
X-Gm-Message-State: AOAM531rWWK3lvrYz6yFR7CZ9x+wXQEE3BdzYztaqe6D2EuxOQrN2Reu
        NmY+HjXgxvDMMCPF9T92PYxf+Viy+B/OUSgydu0=
X-Google-Smtp-Source: ABdhPJwl2ET43Ex3chFgylCJxeITpVJQJpAU5MNCDco0IrgvZt3UMXJjxdw6gYRvrbuRXasZaDQzbLiXe0iCPY1dvIk=
X-Received: by 2002:a9d:7396:: with SMTP id j22mr3475150otk.206.1630599406415;
 Thu, 02 Sep 2021 09:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210901142111.16891-1-mario.limonciello@amd.com>
In-Reply-To: <20210901142111.16891-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Sep 2021 18:16:35 +0200
Message-ID: <CAJZ5v0g=za-D0bDXT-+CpdUQHOR_JPjCvGxt2Zz1hBiPHig_jw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Run both AMD and Microsoft methods if
 both are supported
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        liaoyuan@gmail.com, Maxwell Beck <max@ryt.one>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 1, 2021 at 4:21 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> It was reported that on "HP ENVY x360" that power LED does not come back,
> certain keys like brightness controls do not work, and the fan never
> spins up, even under load on 5.14 final.
>
> In analysis of the SSDT it's clear that the Microsoft UUID doesn't provide
> functional support, but rather the AMD UUID should be supporting this
> system.
>
> Because this is a gap in the expected logic, we checked back with internal
> team.  The conclusion was that on Windows AMD uPEP *does* run even when
> Microsoft UUID present, but most OEM systems have adopted value of "0x3"
> for supported functions and hence nothing runs.
>
> Henceforth add support for running both Microsoft and AMD methods.  This
> approach will also allow the same logic on Intel systems if desired at a
> future time as well by pulling the evaluation of
> `lps0_dsm_func_mask_microsoft` out of the `if` block for
> `acpi_s2idle_vendor_amd`.
>
> Cc: liaoyuan@gmail.com
> Link: https://gitlab.freedesktop.org/drm/amd/uploads/9fbcd7ec3a385cc6949c9bacf45dc41b/acpi-f.20.bin
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1691
> Reported-by: Maxwell Beck <max@ryt.one>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 67 +++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 3a308461246a..7d1976e5dd8b 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -449,25 +449,30 @@ int acpi_s2idle_prepare_late(void)
>         if (pm_debug_messages_on)
>                 lpi_check_constraints();
>
> -       if (lps0_dsm_func_mask_microsoft > 0) {
> +       /* screen off */
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_SCREEN_OFF_AMD :
> +                                       ACPI_LPS0_SCREEN_OFF,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +       if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +
> +       /* lps0 entry */
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_ENTRY_AMD :
> +                                       ACPI_LPS0_ENTRY,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +       if (lps0_dsm_func_mask_microsoft > 0) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -       } else if (acpi_s2idle_vendor_amd()) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -       } else {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> +               /* modern standby entry */
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>         }
> -
>         return 0;
>  }
>
> @@ -476,24 +481,30 @@ void acpi_s2idle_restore_early(void)
>         if (!lps0_device_handle || sleep_no_lps0)
>                 return;
>
> -       if (lps0_dsm_func_mask_microsoft > 0) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +       /* mdoern standby exit */
> +       if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -       } else if (acpi_s2idle_vendor_amd()) {
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -       } else {
> +
> +       /* lps0 exit */
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_EXIT_AMD :
> +                                       ACPI_LPS0_EXIT,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +       if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +
> +       /* screen on */
> +       if (lps0_dsm_func_mask_microsoft > 0)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> -                               lps0_dsm_func_mask, lps0_dsm_guid);
> -       }
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_SCREEN_ON_AMD :
> +                                       ACPI_LPS0_SCREEN_ON,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
>  }
>
>  static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
> --

Applied as 5.15-rc1 material with some edits in the new comments added
by this patch (including a typo fix).

Thanks!
