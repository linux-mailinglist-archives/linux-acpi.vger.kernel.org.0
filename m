Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10226364172
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Apr 2021 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhDSMSE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 08:18:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58051 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhDSMSE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 08:18:04 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYSqJ-0007SK-Sr
        for linux-acpi@vger.kernel.org; Mon, 19 Apr 2021 12:17:32 +0000
Received: by mail-lf1-f69.google.com with SMTP id x5-20020a0565121305b029019cde1790dfso6119861lfu.15
        for <linux-acpi@vger.kernel.org>; Mon, 19 Apr 2021 05:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9RbFGgUfh9R1pGM9X22W/pCvHlFibz2pAB/20DyBvc=;
        b=e66lajcx2QQLyNfs1U+p3tFo/I0QMS+MTk3lnRO6aXhA0pLiEVrgYTK93K6Kboi4H5
         euAD9a1x9X5HPP5RPHoNQVYcDEjCW/krh80b8JyOtqNqFgnGNxHppqTmOb77VfDoHy85
         SS3h3jrn9SfL5udYEgFQqDTbhZn2I2SJzir23YSxks7IjPseBK78uFgachoB1z5KPLk7
         43pav0hvwItgwsp+5feZ8UUl6cEiwh0eN0weCdye7l66RsPbtzCkaNE+eipnMs1O2wHc
         M4U9+wHgd+12kjHBI7++a2A+Pyf2yy0DCAqLvSE7Q4NSGPw1uTeWFaiEunjnlZuJbeUz
         15/w==
X-Gm-Message-State: AOAM530iRE8H6x8Z/I6eBFI6Y8ovpQbdZU1bVn+g1Dunp2hYKYzOej6c
        +SJbO6QTZ2CoOj+Tdy2o7Y4iLwwHZf3cKalUA0+qtq6Zi5dwcRiBkfOT4fC2tZZFr21zFXk5blq
        uRW4/4JVjv68tWOSo6cxuW+M1MlVl7nXsuoP5Wgw+4pKs2+i3M0sFIoU=
X-Received: by 2002:ac2:559c:: with SMTP id v28mr12392220lfg.290.1618834651351;
        Mon, 19 Apr 2021 05:17:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZVAJt8pj4926EE+AA+D7ohFpNGRoRawnmzYkLavLiDvAptySqRSEF4uEolMuh029IJJSJPBB8U5CMzZJKe2E=
X-Received: by 2002:ac2:559c:: with SMTP id v28mr12392207lfg.290.1618834651099;
 Mon, 19 Apr 2021 05:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210419090750.1272562-1-kai.heng.feng@canonical.com> <CAJZ5v0imLOF-9VCSJdb-A2HR29SFX-HgU5Kh7Uf7COfuHpZMDg@mail.gmail.com>
In-Reply-To: <CAJZ5v0imLOF-9VCSJdb-A2HR29SFX-HgU5Kh7Uf7COfuHpZMDg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 19 Apr 2021 20:17:20 +0800
Message-ID: <CAAd53p7F8oPytk8GTZRULw4m2y7jJ8vPx-drnSbW4e-3vvVz9Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Invoke _PTS for s2idle
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2021 at 7:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 11:08 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > HP EliteBook 840 G8 reboots on s2idle resume, and HP EliteBook 845 G8
> > wakes up immediately on s2idle. Both are caused by the XMM7360 WWAN PCI
> > card.
> >
> > There's a WWAN specific method to really turn off the WWAN via EC:
> >     Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
> >     {
> >     ...
> >         If (CondRefOf (\_SB.PCI0.GP12.PTS))
> >         {
> >             \_SB.PCI0.GP12.PTS (Arg0)
> >         }
> >     ...
> >     }
> >
> >     Scope (_SB.PCI0.GP12)
> >     {
> >     ...
> >         Method (PTS, 1, Serialized)
> >         {
> >             If (^^LPCB.EC0.ECRG)
> >             {
> >                 If ((PDID == 0xFFFF))
> >                 {
> >                     Return (Zero)
> >                 }
> >
> >                 POFF ()
> >                 SGIO (WWBR, One)
> >                 Sleep (0x1E)
> >                 Acquire (^^LPCB.EC0.ECMX, 0xFFFF)
> >                 ^^LPCB.EC0.WWP = One
> >                 Release (^^LPCB.EC0.ECMX)
> >                 Sleep (0x01F4)
> >             }
> >
> >             Return (Zero)
> >         }
> >     ...
> >     }
> >
> > So let's also invok _PTS for s2idle.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/acpi/sleep.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 09fd13757b65..7e84b4b09919 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -698,6 +698,7 @@ int acpi_s2idle_prepare(void)
> >         }
> >
> >         acpi_enable_wakeup_devices(ACPI_STATE_S0);
> > +       acpi_enter_sleep_state_prep(ACPI_STATE_S0);
>
> The system is in S0 already at this point, so not really.

Ok, indeed ACPI spec only states _PTS can be used for S1 to S5.

> Please use a quirk to address this.

Let me discuss with HP folks. Right now it looks like we need to apply
this to all HP systems...

Kai-Heng

>
> >
> >         /* Change the configuration of GPEs to avoid spurious wakeup. */
> >         acpi_enable_all_wakeup_gpes();
> > --
