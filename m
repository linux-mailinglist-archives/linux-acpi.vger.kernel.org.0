Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DB94562F6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhKRS5N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 13:57:13 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:42771 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRS5M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 13:57:12 -0500
Received: by mail-oo1-f42.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so2780508ood.9
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 10:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rlxy5otINB7xlUSxP6ufLVDm5w5+ImHBI0jJCQCoei8=;
        b=f88+lQKSYQYcWSUPVMq7Yqtuof+o3lw9QR6amLKkkjIBdE6TU3OXdjFRtGb8XzU4+r
         BxThicWqTRYf962yBrvrBu6HVj8lfkaiKxQ5zDRynjUl0HMb0hN1cRK8k+UBSo32lF62
         MQzdcVIC9GZIiRhwU+sefs8ohwzQXxUvoen5Tfk1/loVy8oLHWNvpzI3YjyYCQn5AfS2
         kZccQhcNngFhpVQO2PGJswrND/s2tWEJVjv6Aif0mMnF5QurTqz3gGdEa7XN/v/bD9Hs
         XiMwLJvrRU0X0wQZdFhhwxJlj/Rw8trTazyDIEtCf37Wn4Onu/zNI7aoyQP3Muddp3lD
         RkZQ==
X-Gm-Message-State: AOAM530gdxLB7hOYKcWue1YCSdY3G4mHxcJfebaDiieMgK/gCELuMlae
        lFPVaPQ5E2hlNLEZV3UoZ5XKIeRRclZ06msQDjY=
X-Google-Smtp-Source: ABdhPJwJVQVbp4q9aADIR/FH44fjolR1L8aKAW04yuQfsXUwG0gyvVAE3EzOs2ZXw++UN+DWiZQdiktSChXMy3FkU/c=
X-Received: by 2002:a4a:1d82:: with SMTP id 124mr14123048oog.91.1637261652023;
 Thu, 18 Nov 2021 10:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20211113135206.5384-1-hdegoede@redhat.com> <YZABGfarFQoxpf1R@jeknote.loshitsa1.net>
 <CAJZ5v0gcJ_Ke6Ppw78Qv9n_Pws20+YBPJX8j0Pa_U=OLHmELfA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcJ_Ke6Ppw78Qv9n_Pws20+YBPJX8j0Pa_U=OLHmELfA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 19:54:01 +0100
Message-ID: <CAJZ5v0iufQMJgybSxfek13+034LuyYpj51ybD-Ke0kj4zRa4MQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / x86: Revert: Make PWM2 device always present at
 Lenovo Yoga Book
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 16, 2021 at 8:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Nov 13, 2021 at 7:17 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> >
> > On Sat, Nov 13, 2021 at 02:52:06PM +0100, Hans de Goede wrote:
> > > It turns out that there is a WMI object which controls the PWM2 device
> > > used for the keyboard backlight and that WMI object also provides some
> > > other useful functionality.
> > >
> > > The upcoming lenovo-yogabook-wmi driver will offer both backlight
> > > control and the other functionality, so there no longer is a need
> > > to have the lpss-pwm driver binding to PWM2 for backlight control;
> > > and this is now actually undesirable because this will cause both
> > > the WMI code and the lpss-pwm driver to poke at the same PWM
> > > controller.
> >
> > Acked-by: Yauhen Kharuzhy <jekhor@gmail.com>
> >
> > >
> > > Revert commit ff6cdfd71495 ("ACPI / x86: Make PWM2 device always present
> > > at Lenovo Yoga Book"), removing the always-present quirk for the PWM2
> > > ACPI-device, so that the lpss-pwm controller will no longer bind to it.
> > >
> > > Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  drivers/acpi/x86/utils.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> > > index cb988f9b23a1..bfcb76888ca7 100644
> > > --- a/drivers/acpi/x86/utils.c
> > > +++ b/drivers/acpi/x86/utils.c
> > > @@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
> > >       ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
> > >       ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
> > >
> > > -     /* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
> > > -     ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> > > -                     DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
> > > -             }),
> > >       /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
> > >       ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> > >               DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> > > --
>
> Applied as 5.16-rc2 material, thanks!

I've decided to make this change in 5.17.

It would be good to put the patch under a different subject too,
because the way it is may confuse someone to regard it as a fix.
