Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35A453A20
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbhKPT2L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Nov 2021 14:28:11 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:33664 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbhKPT2J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2021 14:28:09 -0500
Received: by mail-oi1-f175.google.com with SMTP id q25so934483oiw.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 Nov 2021 11:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSTF8drKRLuVi1fH+KHbioAcQ8gnSxNUCxDi3CwCmjA=;
        b=nIRM+R9aLLEN3X1Sl0h+GSNe3JK3txA+jhxIohRT2MRKcxoJ0aXi0kDFc2MG/LDzKK
         IHHe0WphT3eIqnbjz5ptV0y9Xaiv5L1Y/imHEEeZuIKgRdql5Jbl2OjdarraEpTj8fdO
         AkDUcc0/lPIbuYffMZc5ldkQDDnUME/HnPM/TNdEvF/3DW2P+2efg6MzVEESPKrz746Y
         M4FAMD4GIbu0xjafEXOBCixbajr6+H5+FTiu2qPerMbO9qxolbznZmnreH6dj2hMZukK
         Ul/a1znFqBfZqKW6QLQ+TwypF7iCb8on22WYWQ14YN+lRWvHk3ipB9CRvURiknLOtInw
         QZ9A==
X-Gm-Message-State: AOAM530JD/4ewrUIqZInXHu5u16ABy7bWfatSvC47DrZ2177X7JCww95
        mlctyxhoLsh1pdr1eZIE0q5Tt00UuqKNR8YLC2k=
X-Google-Smtp-Source: ABdhPJzRoYHjWVtM0mJ0Ntlv8kucDmazyQCPUX//6xNOqI/gTPjdaG3rI8MNWOIF2TFgqLGcFNYnSTN4ihRNZ9PE6pk=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr36361078oiw.51.1637090711818;
 Tue, 16 Nov 2021 11:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20211113135206.5384-1-hdegoede@redhat.com> <YZABGfarFQoxpf1R@jeknote.loshitsa1.net>
In-Reply-To: <YZABGfarFQoxpf1R@jeknote.loshitsa1.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Nov 2021 20:25:01 +0100
Message-ID: <CAJZ5v0gcJ_Ke6Ppw78Qv9n_Pws20+YBPJX8j0Pa_U=OLHmELfA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / x86: Revert: Make PWM2 device always present at
 Lenovo Yoga Book
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 13, 2021 at 7:17 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> On Sat, Nov 13, 2021 at 02:52:06PM +0100, Hans de Goede wrote:
> > It turns out that there is a WMI object which controls the PWM2 device
> > used for the keyboard backlight and that WMI object also provides some
> > other useful functionality.
> >
> > The upcoming lenovo-yogabook-wmi driver will offer both backlight
> > control and the other functionality, so there no longer is a need
> > to have the lpss-pwm driver binding to PWM2 for backlight control;
> > and this is now actually undesirable because this will cause both
> > the WMI code and the lpss-pwm driver to poke at the same PWM
> > controller.
>
> Acked-by: Yauhen Kharuzhy <jekhor@gmail.com>
>
> >
> > Revert commit ff6cdfd71495 ("ACPI / x86: Make PWM2 device always present
> > at Lenovo Yoga Book"), removing the always-present quirk for the PWM2
> > ACPI-device, so that the lpss-pwm controller will no longer bind to it.
> >
> > Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/x86/utils.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> > index cb988f9b23a1..bfcb76888ca7 100644
> > --- a/drivers/acpi/x86/utils.c
> > +++ b/drivers/acpi/x86/utils.c
> > @@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
> >       ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
> >       ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
> >
> > -     /* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
> > -     ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> > -                     DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
> > -             }),
> >       /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
> >       ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> >               DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> > --

Applied as 5.16-rc2 material, thanks!
