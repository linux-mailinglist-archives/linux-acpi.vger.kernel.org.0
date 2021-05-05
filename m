Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1282373C0D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhEENMw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhEENMw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 09:12:52 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CF0C061574
        for <linux-acpi@vger.kernel.org>; Wed,  5 May 2021 06:11:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id i26so2131199oii.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 May 2021 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWL3R/wvp79X5sMQgGYKT2VaRT3usJagJyJ8LLwCBRc=;
        b=YEKNUVNGjcNZcPeTxKUu3L9ieWS5OYMjeFVM/Iv4aZH+waVxukEYe9obPkcrt+hNKc
         4CbnLMBhTNyKjtzDfocKAdW3Qk5EIsae4ZsdPtpgnkEiG3PhtVKyJAkbRDpRTaKKNbeE
         2GXz/9RSTXrZk2xlEc1dk4nVGK6QGEBj2Avy4ZpTVpcR0ovtQFoTwMjSDRKyo0KGQ1Vy
         6mGiz2/wyIaqGmiaMIYQ736kd2vs+CAwROqzO1t1Y4zCHl6An6thJxp0x0QxGUs8teb6
         LJmHbMH0RmdssEhJV7jOuh0Q7AuI+ijpFAOy+2QxRCOsIuReJcNGj0zASGKBh6SRz3GP
         1aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWL3R/wvp79X5sMQgGYKT2VaRT3usJagJyJ8LLwCBRc=;
        b=m5ZQmTSaBU6ZE+VF1hgKyKMCmM/7TVaVvB6UKjRyr92KgckVGGlLZTFAsqjO/XAUF3
         0fPtgtJaT6wCDIt4IS1xr/HfdsjNxUsio797CVpD2eb+uyxIDYhm4l1T4l+D/PykXHGE
         nQD5T0CzZ756H49FPge9zyFk1O8hO9ZABCKDSBWlwzjM5Ytu2Nrc0RffUmUMEDypzLBh
         4NnvKyyMmkaZtB5wHo32kM0s7fNjczGTpxLvq1nJiAOeSHcwTtkh5nSknP9uLqdgnJKh
         iXfnZXE7jS0Vc/OS6LwuA37PvWmvcxqJh4Cq61zuixNANBf7wcILNdUwMb24P0rRv+hg
         lmOw==
X-Gm-Message-State: AOAM532EDvbUlEmMLBRPKhulvPyii8F+rLejCM4k265voSgNh79ywe1y
        hK0Nv6tPcTbzNIrI6TxztCtCX/bYEh1IrivINmw=
X-Google-Smtp-Source: ABdhPJztzUDmHalSN8/7tcMO2/PyPxSYfsnh3OwAMTzs8F6HtjLhgkdAVxMxilL+vymgNpAZ4siQxjJSV8DOxu+hD1c=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr21052843oig.120.1620220314538;
 Wed, 05 May 2021 06:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210504221140.593002-1-alexander.deucher@amd.com>
 <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
 <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
In-Reply-To: <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 5 May 2021 09:11:43 -0400
Message-ID: <CADnq5_POX7j1_BDh24uQ=gFfJU43TQW49Q32LUoisqg3hW8t+A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add missing LPS0 functions for AMD
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Liang, Prike" <Prike.Liang@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 5, 2021 at 9:10 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5/5/21 12:33 AM, Limonciello, Mario wrote:
> > [AMD Public Use]
> >
> >> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
> >
> > Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
> > I think technically this subsystem prefix to match other stuff committed to this file
> > should be:
> >
> > "ACPI: PM: s2idle:"
>
> Ack, please get the subject next right time. I was about the put this in a folder
> with patches to apply to the pdx86 kernel tree once 5.13-rc1 is out, but this
> should not go upstream through the pdx86 tree at all.

Do you want me to resend with the corrected subject?  What tree does
this need to go through?

Alex

>
> Regards,
>
> Hans
>
>
>
> >
> >>
> >> These are supposedly not required for AMD platforms,
> >> but at least some HP laptops seem to require it to
> >> properly turn off the keyboard backlight.
> >>
> >> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> >>
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Marcin Bachry <hegel666@gmail.com>
> >> Cc: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>
> >> Dropping patch 2/2 for now.  This patch fixes several
> >> systems and doesn't appear to cause any issues.
> >>
> >>  drivers/acpi/x86/s2idle.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> >> index 2b69536cdccb..2d7ddb8a8cb6 100644
> >> --- a/drivers/acpi/x86/s2idle.c
> >> +++ b/drivers/acpi/x86/s2idle.c
> >> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
> >>
> >>  /* AMD */
> >>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
> >> 932122d37721"
> >> +#define ACPI_LPS0_ENTRY_AMD         2
> >> +#define ACPI_LPS0_EXIT_AMD          3
> >>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
> >>  #define ACPI_LPS0_SCREEN_ON_AMD     5
> >>
> >> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
> >>
> >>      if (acpi_s2idle_vendor_amd()) {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> >> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
> >>      } else {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> >> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
> >>              return;
> >>
> >>      if (acpi_s2idle_vendor_amd()) {
> >> +            acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
> >>      } else {
> >>              acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> >> --
> >> 2.30.2
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
