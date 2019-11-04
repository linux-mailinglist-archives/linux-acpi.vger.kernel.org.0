Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA8EE806
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 20:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfKDTOr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 14:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfKDTOr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Nov 2019 14:14:47 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA6820869;
        Mon,  4 Nov 2019 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572894885;
        bh=xsHYsB2zXyMTH2IKEVWf2hBE7o2ppclJRWbNmU8ydpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U3LKG6Z8BwDtzgs/xqc5kRZSSzXrXQJmbRdShYkUcXr/7ApyP8BRc6im67plsC1UD
         I4EvP4bgUndg5SxM+vQZLbKyU7hJLSWOYngXl4go9i1uQtqdc+Jyd38Iaz0j7R1EyG
         g565xCQR68R0FrSrBsXrNLdkAW7GLmbTmX2dtnwY=
Received: by mail-qt1-f181.google.com with SMTP id x21so25552645qto.12;
        Mon, 04 Nov 2019 11:14:45 -0800 (PST)
X-Gm-Message-State: APjAAAUV06GpFc6nSxAQlfhdEb5CzZu8ZrxoHhRhtpsRise+YRxUeG2p
        +p+HUjuF0gpWFAslDIk2pfzds/8yToFml+G/3g==
X-Google-Smtp-Source: APXvYqwDm4nm4amh56WMcaZv0m6i+1qGGjr7WZUR++nmINh861qFieVIg3CDST02eujwAAYxYo0uuF3bzl8SqvtkCl8=
X-Received: by 2002:ac8:48c5:: with SMTP id l5mr14006694qtr.110.1572894884938;
 Mon, 04 Nov 2019 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-6-saravanak@google.com>
 <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com> <CAGETcx_CL9P3svctyDuGpavG4Ykd+o2G-rxDAE5OUvxL+sj6xA@mail.gmail.com>
In-Reply-To: <CAGETcx_CL9P3svctyDuGpavG4Ykd+o2G-rxDAE5OUvxL+sj6xA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 13:14:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJA8awLeEmcxXFRqrd+ftP99+Sjjie9bFYLEpwXWEwzoA@mail.gmail.com>
Message-ID: <CAL_JsqJA8awLeEmcxXFRqrd+ftP99+Sjjie9bFYLEpwXWEwzoA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Skip adding device links to
 suppliers that aren't devices
To:     Saravana Kannan <saravanak@google.com>
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

On Mon, Nov 4, 2019 at 1:02 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Nov 4, 2019 at 7:18 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Oct 28, 2019 at 5:00 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Some devices need to be initialized really early and can't wait for
> > > driver core or drivers to be functional.  These devices are typically
> > > initialized without creating a struct device for their device nodes.
> > >
> > > If a supplier ends up being one of these devices, skip trying to add
> > > device links to them.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/property.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index f16f85597ccc..21c9d251318a 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > >         struct device *sup_dev;
> > >         int ret = 0;
> > >         struct device_node *tmp_np = sup_np;
> > > +       int is_populated;
> > >
> > >         of_node_get(sup_np);
> > >         /*
> > > @@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> > >                 return -EINVAL;
> > >         }
> > >         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> > > +       is_populated = of_node_check_flag(sup_np, OF_POPULATED);
> > >         of_node_put(sup_np);
> > >         if (!sup_dev)
> > > -               return -EAGAIN;
> > > +               return is_populated ? 0 : -EAGAIN;
> >
> > You're only using the flag in one spot and a comment would be good
> > here, so I'd just do:
> >
> > if (of_node_check_flag(sup_np, OF_POPULATED))
> >         return 0; /* Early device without a struct device */
>
> Hi Rob,
>
> Thanks for the review.
>
> I'm using the flag to keep the error handling code simple/cleaner. I
> can't do the check like that after I do a put on the sup_np.

Ah, right. Nevermind.

> Yeah, I was actually planning to add a dev_dbg() message when this
> happens and returning a -EINVAL (that'll be ignored by the caller)
> instead of -EAGAIN (that's NOT ignored by the caller).
>
> Looks like these changes go pulled into driver-core-next. So I'll send
> a delta patch to add the dbg message and also address you nit on the
> other patch.

I didn't notice Greg applied already. Don't worry about the nit then.

Rob
