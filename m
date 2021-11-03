Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF82444837
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCSXv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:23:51 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36783 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKCSXu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:23:50 -0400
Received: by mail-ot1-f41.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso4721311otv.3;
        Wed, 03 Nov 2021 11:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvIpNYV2Tx6bolS6CIHdaJSwGnfCSaBkUG5dm1ZVR98=;
        b=6kl5u+eIuGfHO7Hro1uhACgNXFnhIdtnwfwJLxEIZK9R2auB/4UdKoiN+Dw889cs3m
         IppuPg6xCyS7rG5+05+3NZGFRIM7JLVlMAb5jLb45j7dpWVPWgTW0dPk5bSer3BWxQPY
         GiSERN8DjvDlcsHYPDzQrBz3XWuVbICElK44qfmyfXMZIxYMCPzJIcTueodtkoZ7h/nZ
         m7wMSywrvePQRQpBW5ukCVLWEmNP14sEH6qRWbyzZYJOUzs3Zs53cVvUbX97kHyxg2mN
         71u88FIwmFGnbWnJfOhwURf0pySvL+v4JtWzK5AyZqRq7uxE4KLwMeTbq9eaP48neSvM
         JXMA==
X-Gm-Message-State: AOAM530Fw8uXKaF95iIaX3INr4eOtjzRNL0eANTngEt/TXHHOdSGMMfO
        uVQbrd+fzcto4BlBXHVWUDB/Itt9QyimpiF2/A4=
X-Google-Smtp-Source: ABdhPJz6oq6BMpLa6xzEMg2bbk/wKb3OdSX/FB2sb6qFm6Gaed9h7yaHFioG+FDztVtbc9Yk02bLWu2ZX0mfGQoHwSY=
X-Received: by 2002:a05:6830:3484:: with SMTP id c4mr17342342otu.254.1635963673329;
 Wed, 03 Nov 2021 11:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211102223959.3873-1-hdegoede@redhat.com> <20211102223959.3873-2-hdegoede@redhat.com>
In-Reply-To: <20211102223959.3873-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 19:21:02 +0100
Message-ID: <CAJZ5v0gRna0DBK6CbaOTp82EVmmF67UxgaZoW3cu=YbVG21o4A@mail.gmail.com>
Subject: Re: [RFC v2 1/2] ACPI / x86: Add PWM2 on the Xiaomi Mi Pad 2 to the
 always_present list
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 2, 2021 at 11:40 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Xiaomi Mi Pad 2 has backlit LEDs behind the capacitive menu, home
> and back buttons below the screen which are controlled by the PWM2
> controller of the CHT SoC. This PWM2 controller gets hidden by the
> firmware, add it to the always_present_ids table so that we can use
> the PWM controller to control the backlighting of the buttons.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/x86/utils.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index f22f23933063..cb988f9b23a1 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -58,6 +58,11 @@ static const struct always_present_id always_present_ids[] = {
>         ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
>                 }),
> +       /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
> +       ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
> +             }),
>         /*
>          * The INT0002 device is necessary to clear wakeup interrupt sources
>          * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
> --
> 2.31.1
>
