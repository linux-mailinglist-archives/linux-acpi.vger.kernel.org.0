Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D6383076
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhEQO1e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:27:34 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:47076 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbhEQOZd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:25:33 -0400
Received: by mail-ot1-f45.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso5648028otb.13;
        Mon, 17 May 2021 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+6ryiKHsnOZrkZjGxnuHvx4Cycm+dsFfU/WqN/dQEA=;
        b=ExG201ldsdxHPBKjiupK/lb24wVlqnpATJaaniyIlgTnsIvbVbX+WAIeNzFRO6utGF
         Douvp1lnVg8QsodNDqQVfCGCJtFGz5W8CvKZU5FA1zWiddwZZ9YJYs1nuBw3Y0mkq0LZ
         uG/XZXaSxlo+Ycp4XHZph5lT0ylFs02cUPHIktD1FKhqQoxYAD0i0QFzpZPCsrVdRc6W
         rdL+SF1poIoRFFN1GMvYUsnZlf3ogvvE8Lwi2EJ5uJxgc0cp+X4CU+cpmJabmsZFIw4q
         gvzgr6EO2+GcZ5Fva22ahXyyVxNeBZxOydPGha7CAPDrYAbJE0ZAERo4kt7LGozFLxSX
         DRpA==
X-Gm-Message-State: AOAM530S95Gxk6czFg0v1S/7WdXrWzTjSnC0mbxaYYD9Voh+NSttwaRk
        mZOsS+qLVxb+C+lF1vzSKpVfuEBVIYS6lyX11qw=
X-Google-Smtp-Source: ABdhPJzxG5TWpGfsd01iDYNp7QK+JpVulbNbYKyCwUqf7AhUIBtBMSdVYtxBNvtsdVuzQ18H4nEY9TmFKY51v58O8lE=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr52530163otc.206.1621261456311;
 Mon, 17 May 2021 07:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210505132032.601097-1-alexander.deucher@amd.com>
In-Reply-To: <20210505132032.601097-1-alexander.deucher@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:24:05 +0200
Message-ID: <CAJZ5v0i5QDQbxYtkrqrQzPpc08Gvr1Jngb4ZC8VOPhphPs5pcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Add missing LPS0 functions for AMD
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Marcin Bachry <hegel666@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 5, 2021 at 3:21 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> These are supposedly not required for AMD platforms,
> but at least some HP laptops seem to require it to
> properly turn off the keyboard backlight.
>
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> ---
>
> Resend with updated subject.
>
>  drivers/acpi/x86/s2idle.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2b69536cdccb..2d7ddb8a8cb6 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> +#define ACPI_LPS0_ENTRY_AMD         2
> +#define ACPI_LPS0_EXIT_AMD          3
>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>
> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>
>         if (acpi_s2idle_vendor_amd()) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>         } else {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>                 return;
>
>         if (acpi_s2idle_vendor_amd()) {
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>         } else {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> --

Applied as 5.14 material, thanks!
