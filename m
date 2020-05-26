Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6511E20B3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 May 2020 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbgEZLMq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 May 2020 07:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388683AbgEZLMp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 May 2020 07:12:45 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CA0208A7;
        Tue, 26 May 2020 11:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590491565;
        bh=w3m3BiqegA/c+AK0c9B3Lz04RjxLTZODaFVIMVf+TVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hU0oETOXSYMagC2q8kNXSo8qLzsqGsFQQdGVNPQhS6mftnrvRezldE1Xh+J67hDgK
         RYvOpeSd+apIGzRu6s39QRRzuZ55JKA3YZIpuVUDhJwUfamZsDoKINrI7UjEqcCqnK
         uSs1GA4XDfFvFA/hOyvbn1GW8b5AbbCBbZKPIErk=
Received: by mail-io1-f45.google.com with SMTP id j8so21415828iog.13;
        Tue, 26 May 2020 04:12:44 -0700 (PDT)
X-Gm-Message-State: AOAM531LrCI9ny7+un59wukeJYOLrBWHrur6+TQfJzEAmWzpu46VZwgO
        bQquJ1NlKz5KmtNjjzXCDWby54qQ3JdG8SkOkCw=
X-Google-Smtp-Source: ABdhPJy4K/V9tFR2GK96RiXGHjIJJ56IY7i7ivtw4AS3QQiZ4is+DnyTxH8db+0ZS9QH8rim5quPD2MhJStgltaiIgM=
X-Received: by 2002:a5d:9b8a:: with SMTP id r10mr16755157iom.171.1590491564286;
 Tue, 26 May 2020 04:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200515093613.18691-1-ardb@kernel.org> <CAJZ5v0guHdbZTsU5e7KDAHDy9Gnh67JwtSSCeDaK8mUwAk1d3g@mail.gmail.com>
In-Reply-To: <CAJZ5v0guHdbZTsU5e7KDAHDy9Gnh67JwtSSCeDaK8mUwAk1d3g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 May 2020 13:12:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFVYOoX=pe9uVY-j_o8YhhE_Fef6q6jc8S9nzBLYSBb=g@mail.gmail.com>
Message-ID: <CAMj1kXFVYOoX=pe9uVY-j_o8YhhE_Fef6q6jc8S9nzBLYSBb=g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: GED: add support for _Exx / _Lxx handler methods
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael,

I spotted an issue with this patch. Please see below.


On Fri, 15 May 2020 at 18:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 11:37 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Per the ACPI spec, interrupts in the range [0, 255] may be handled
> > in AML using individual methods whose naming is based on the format
> > _Exx or _Lxx, where xx is the hex representation of the interrupt
> > index.
> >
> > Add support for this missing feature to our ACPI GED driver.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Cc: <stable@vger.kernel.org> # v4.9+
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/acpi/evged.c | 22 +++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> > index aba0d0027586..6d7a522952bf 100644
> > --- a/drivers/acpi/evged.c
> > +++ b/drivers/acpi/evged.c
> > @@ -79,6 +79,8 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
> >         struct resource r;
> >         struct acpi_resource_irq *p = &ares->data.irq;
> >         struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
> > +       char ev_name[5];
> > +       u8 trigger;
> >
> >         if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
> >                 return AE_OK;
> > @@ -87,14 +89,28 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
> >                 dev_err(dev, "unable to parse IRQ resource\n");
> >                 return AE_ERROR;
> >         }
> > -       if (ares->type == ACPI_RESOURCE_TYPE_IRQ)
> > +       if (ares->type == ACPI_RESOURCE_TYPE_IRQ) {
> >                 gsi = p->interrupts[0];
> > -       else
> > +               trigger = p->triggering;
> > +       } else {
> >                 gsi = pext->interrupts[0];
> > +               trigger = p->triggering;

This should be 'pext->triggering' instead.

In practice, it doesn't matter, since p and pext point to the same
union, and the 'triggering' field happens to be at the same offset.
But it should still be fixed, of course.

Would you prefer a followup patch? Or can you fix it locally?


> > +       }
> >
> >         irq = r.start;
> >
> > -       if (ACPI_FAILURE(acpi_get_handle(handle, "_EVT", &evt_handle))) {
> > +       switch (gsi) {
> > +       case 0 ... 255:
> > +               sprintf(ev_name, "_%c%02hhX",
> > +                       trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
> > +
> > +               if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
> > +                       break;
> > +               /* fall through */
> > +       default:
> > +               if (ACPI_SUCCESS(acpi_get_handle(handle, "_EVT", &evt_handle)))
> > +                       break;
> > +
> >                 dev_err(dev, "cannot locate _EVT method\n");
> >                 return AE_ERROR;
> >         }
> > --
>
> Applied as 5.8 material, thanks!
