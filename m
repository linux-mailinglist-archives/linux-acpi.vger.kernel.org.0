Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936BFEE7D8
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfKDTCV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 14:02:21 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46115 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbfKDTCV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Nov 2019 14:02:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id b19so5852385oib.13
        for <linux-acpi@vger.kernel.org>; Mon, 04 Nov 2019 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHvMybYCPvLOcRHqCBZyxUzdSqz4vFyRg5UuR2Ahyew=;
        b=Yp07K186DuxwZHZLbvAqheApB9VC785SKUV264EeioFCjyGfcjLdY6R/3zrMgomkf6
         iAZvA//p0ACWZZZ3ru+YoQPAaSdy/Xlgq54DG1DBJstqJwrKEytiSDPVksn0ov45SfdD
         BCFimiCInTI1x7cgvt5ZjyaN1j8gS0PElAUlt0ZdXktta6B1w1k9aWa0G//JRs4OPz/w
         uFfV+z0dtmAsPluS3BtHOHYUih5RlVD/Iye9TuroC7Idm1Sf9+t+oXEiqGh9H42x39OC
         Yn/yxRPTZP0PZnBKSsF3rABozZBCYGOdtbSQvyphlHyFlPtmDv33p5yAYOiS4SBY7HAV
         1vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHvMybYCPvLOcRHqCBZyxUzdSqz4vFyRg5UuR2Ahyew=;
        b=Q/3o4Zlt6xFgKGIrqzH58Y0JUdduqJFHQmh0nc8PBauWKQwxXlFYik/3Gho4hC2BXw
         gNqAv/O8e/6IITxN7Y51EoGf352/INbgljlY1w48pWS1NIeChQPkygLHQUgcgXi7jpd5
         C5ZDn/GPb9wltkPuHACgCncTCwKDdYTAzP5sLFRAXblUqRE3bRyVuJpbNUxBAGofN9Nl
         881cuBkRoUY58R24tFlzafjEPtXoinD54bHyNKOPIbeZYLWkU0+nPawCbg0cAx0TAgy2
         YEp7aV00ZZRP131UFuBcqSj3DFRjTO700pv83Dh3SJh9Nd83jfHyUD+4Cu5VCG/Pnfb/
         fIsA==
X-Gm-Message-State: APjAAAXneldilPjizen8Ou3LocXT6feVNuJeVMZo15I1NeMuSYUHdiMh
        w/KcxEp/f124C1QzsrcI53OHr7vDZefOxnzONDSYziR5
X-Google-Smtp-Source: APXvYqxvMsCRsWBIDZ0SqDKRbA2a2jcPrtgP2JA+jl0La2OLtVPkdITmiBc0BO/x8fRSa547Hk9FSYYdLVC57gQLkRs=
X-Received: by 2002:aca:f408:: with SMTP id s8mr482330oih.69.1572894140243;
 Mon, 04 Nov 2019 11:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-6-saravanak@google.com>
 <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
In-Reply-To: <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 4 Nov 2019 11:01:44 -0800
Message-ID: <CAGETcx_CL9P3svctyDuGpavG4Ykd+o2G-rxDAE5OUvxL+sj6xA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Skip adding device links to
 suppliers that aren't devices
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 4, 2019 at 7:18 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Oct 28, 2019 at 5:00 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Some devices need to be initialized really early and can't wait for
> > driver core or drivers to be functional.  These devices are typically
> > initialized without creating a struct device for their device nodes.
> >
> > If a supplier ends up being one of these devices, skip trying to add
> > device links to them.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index f16f85597ccc..21c9d251318a 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> >         struct device *sup_dev;
> >         int ret = 0;
> >         struct device_node *tmp_np = sup_np;
> > +       int is_populated;
> >
> >         of_node_get(sup_np);
> >         /*
> > @@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> >                 return -EINVAL;
> >         }
> >         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> > +       is_populated = of_node_check_flag(sup_np, OF_POPULATED);
> >         of_node_put(sup_np);
> >         if (!sup_dev)
> > -               return -EAGAIN;
> > +               return is_populated ? 0 : -EAGAIN;
>
> You're only using the flag in one spot and a comment would be good
> here, so I'd just do:
>
> if (of_node_check_flag(sup_np, OF_POPULATED))
>         return 0; /* Early device without a struct device */

Hi Rob,

Thanks for the review.

I'm using the flag to keep the error handling code simple/cleaner. I
can't do the check like that after I do a put on the sup_np.

Yeah, I was actually planning to add a dev_dbg() message when this
happens and returning a -EINVAL (that'll be ignored by the caller)
instead of -EAGAIN (that's NOT ignored by the caller).

Looks like these changes go pulled into driver-core-next. So I'll send
a delta patch to add the dbg message and also address you nit on the
other patch.

Thanks,
Saravana
