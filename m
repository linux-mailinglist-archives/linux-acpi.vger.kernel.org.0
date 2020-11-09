Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B22AC3DB
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Nov 2020 19:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKISbE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Nov 2020 13:31:04 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:39272 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKISbD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2020 13:31:03 -0500
Received: by mail-oo1-f68.google.com with SMTP id l10so979655oom.6
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2020 10:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0cH/VP5xsWweX4GNb81DjXTT/sb7QMwfbxN0d8fKH+o=;
        b=cYAG13mM1EOj+rx+BpYshDyZOQgjR+AoQBwduJzyLHnqMogHiu7Jf2ilSk2kKKP1pd
         50hdyZGOVaeEW27ZiX2Vjw1mE5y8FAAb5auEUfQxv4s8xP6SpWYSBPncVN5WqdME7fgO
         z9zN+qKDQfLcMgKBOHNuOxdP9lUXburnz3845+NHHqHgtooWYz5z6TWW9u0tCuhai0AS
         6qe/uuH475RBH22aYvErQcC263ebDJCb33VHWjoVXluZG8o8e9mOsYfcVNJqc9Fa87sV
         dSIt2MDzJurlR6LpDAWB/OGSH39SSpK1I9WES1E3dEqIN4zrb+YwWC7QO0xzPFKbgtFv
         75XQ==
X-Gm-Message-State: AOAM531yNHGI76qFdCLCM7frlMBBvhqy1Wd6zfF7Ved6EcbWYaP51Xae
        HE1CqlZHauNRSkj6h/IbUAwSCE9OQZwcakTI2H4=
X-Google-Smtp-Source: ABdhPJwn/aeIknOWDRv9RwPKgomBpXUZHdHuPcLovRNKAhnpDvhVYZApFriFUVZL2FYnJnBY4VgoS3X4nOj2FXb7aFY=
X-Received: by 2002:a4a:c018:: with SMTP id v24mr10758664oop.2.1604946662924;
 Mon, 09 Nov 2020 10:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20201107133254.101882-1-hdegoede@redhat.com>
In-Reply-To: <20201107133254.101882-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Nov 2020 19:30:51 +0100
Message-ID: <CAJZ5v0ha4v=y=oVhAf0sXn+hsTubEU6J0CDg1Ktxi=8g-fDqDg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Add DMI quirk for Medion Akoya E2228T
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 7, 2020 at 2:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Medion Akoya E2228T's ACPI _LID implementation is quite broken,
> it has the same issues as the one from the Medion Akoya E2215T:
>
> 1. For notifications it uses an ActiveLow Edge GpioInt, rather then
>    an ActiveBoth one, meaning that the device is only notified when the
>    lid is closed, not when it is opened.
>
> 2. Matching with this its _LID method simply always returns 0 (closed)
>
> In order for the Linux LID code to work properly with this implementation,
> the lid_init_state selection needs to be set to ACPI_BUTTON_LID_INIT_OPEN,
> add a DMI quirk for this.
>
> While working on this I also found out that the MD60### part of the model
> number differs per country/batch while all of the E2215T and E2228T models
> have this issue, so also remove the " MD60198" part from the E2215T quirk.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.10-rc material, thanks!

> ---
>  drivers/acpi/button.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 0761529cac05..0d93a5ef4d07 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -89,7 +89,18 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>                  */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "E2215T"),
> +               },
> +               .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
> +       },
> +       {
> +               /*
> +                * Medion Akoya E2228T, notification of the LID device only
> +                * happens on close, not on open and _LID always returns closed.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "E2228T"),
>                 },
>                 .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>         },
> --
> 2.28.0
>
