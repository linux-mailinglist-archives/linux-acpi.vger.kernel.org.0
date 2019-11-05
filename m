Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8AF09E0
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2019 23:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfKEWw7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 17:52:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39513 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfKEWw7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 17:52:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so19171522oif.6
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2019 14:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITot2P1/Oq1djB16oG4kp1TUvRDEYRsyk0+fdSTUYw4=;
        b=iHLJvOrKMmGplCdoVyX0r+Vex/KiHX7/2gzEkqUGtS9y1kL5yKWQyCpQLbuDDjC9Is
         5TTkBC0jgHz5YkvBoVLZNIH7IYS1FN/nj0Ri77yYoHW0RUq6VDBbgb860xuZ2D566gHO
         jRvW49c1h4UyvoTIeITBnbXm1wQ3Mm8r0o2DNuoBShnqCcNpFhej58iGH3HAx+Eog3Ql
         xiFj5N3CuW7VIh48JxSTvl30/ZCtzh10Y5GKZu7VKZvehv1luDEh0MfJe0gMx7PTzcZy
         ZXAoO63WuczkBq1yJB+WPezvFII9eB/rDNWPzS3RklXRdMP30mo+PQRRWpMbyt72LoYA
         NDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITot2P1/Oq1djB16oG4kp1TUvRDEYRsyk0+fdSTUYw4=;
        b=PHOyNIUfVlmbWkjqQUPOen4LBlp96IUmLmF607TawAjwlPIq0hZ+7XLh0PMx3FbQpw
         TrEnhih0WXed/530RFyzkZU/wkXBc1iT0oUV0lOVyvd3/pvu3Q1kFFCzAVAb0BrKjlQd
         gFBiJAM18aPAoxqw/gZVQWz9wBkZVKyzXZvu+r2q6k2iVUCeRbG5WvRu0yikRWMheqaC
         cJgVL7f43mcz/96NO/M9W7KrKlLkg1oJ4t9IX6Bz2aQETM2US7vjJVMNzurUBWClU+xT
         NiHsXXQjXnS0JhbHuAj6l+tW6gNBZH8zWN7gIxc3gHjOxgTCByfpND1tORXseTJeOu/H
         w8VA==
X-Gm-Message-State: APjAAAUk56mr381BjYzzzWGxAIT+ZEBM5SfUuatP/jpe1TYnlE6ilx+F
        DaVv2gtKpK5Da/DPGOb5C2zyuzlmfozVT6ewagYOfw==
X-Google-Smtp-Source: APXvYqzIAUzPDmogTITDbFUcA/ihvKRGXKPJD4mBnp8pOOy8bZMrACShUDrVG+Osz9+7P9TgEvDK1SPeZMDgR0ab2QY=
X-Received: by 2002:aca:d558:: with SMTP id m85mr1203360oig.43.1572994377809;
 Tue, 05 Nov 2019 14:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-4-saravanak@google.com>
 <7640808.4Pc6YCm0Y9@kreacher>
In-Reply-To: <7640808.4Pc6YCm0Y9@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 5 Nov 2019 14:52:21 -0800
Message-ID: <CAGETcx9z86d+w7jO8Nnu+R62RrT829rj3FFHW2GvGdSsnoB3og@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] driver core: Allow fwnode_operations.add_links to
 differentiate errors
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Thanks for the review.

On Tue, Nov 5, 2019 at 2:43 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, October 28, 2019 11:00:24 PM CET Saravana Kannan wrote:
> > When add_links() still has suppliers that it needs to link to in the
> > future, this patch allows it to differentiate between suppliers that are
> > needed for probing vs suppliers that are needed for sync_state()
> > correctness.
>
> I guess you mean that it will return different error codes in the different
> cases.

Yes.

>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c    | 12 ++++++++----
> >  include/linux/fwnode.h | 13 +++++++++----
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 48cd43a91ce6..e6d3e6d485da 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2297,7 +2297,7 @@ int device_add(struct device *dev)
> >       struct device *parent;
> >       struct kobject *kobj;
> >       struct class_interface *class_intf;
> > -     int error = -EINVAL;
> > +     int error = -EINVAL, fw_ret;
> >       struct kobject *glue_dir = NULL;
> >
> >       dev = get_device(dev);
> > @@ -2413,9 +2413,13 @@ int device_add(struct device *dev)
> >        */
> >       device_link_add_missing_supplier_links();
> >
> > -     if (fwnode_has_op(dev->fwnode, add_links)
> > -         && fwnode_call_int_op(dev->fwnode, add_links, dev))
> > -             device_link_wait_for_mandatory_supplier(dev, true);
> > +     if (fwnode_has_op(dev->fwnode, add_links)) {
>
> fw_ret can be defined here and I'd just call it "ret".

I thought that style of variable declaration is frowned up in the
kernel coding style.

>
> > +             fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> > +             if (fw_ret == -ENODEV)
> > +                     device_link_wait_for_mandatory_supplier(dev);
> > +             else if (fw_ret)
> > +                     device_link_wait_for_optional_supplier(dev);
> > +     }
> >
> >       bus_probe_device(dev);
> >       if (parent)
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 25bb81f8ded8..a19134eae5a5 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -96,10 +96,15 @@ struct fwnode_reference_args {
> >   *           available suppliers.
> >   *
> >   *           Return 0 if device links have been successfully created to all
> > - *           the suppliers of this device or if the supplier information is
> > - *           not known. Return an error if and only if the supplier
> > - *           information is known but some of the suppliers are not yet
> > - *           available to create device links to.
> > + *           the suppliers this device needs to create device links to or if
> > + *           the supplier information is not known.
>
> "the known suppliers of this device or if the supplier information is not known."

"suppliers it needs to create device links to" is a subset of known
suppliers. There's no requirement that fw needs to create links to ALL
known suppliers. Just a minor distinction.

> > + *
> > + *           Return -ENODEV if and only if the suppliers needed for probing
> > + *           the device are not yet available to create device links to.
>
> It would be more precise to say something like this:
>
> "Return -ENODEV if an attempt to create a device link to one of the device's
> suppliers needed for probing it fails."

"attempt to create a device link to one of the device's suppliers
needed for probing it fails" to me means device_link_add() fails.
But I'm trying to say that it should return an error if the struct
device isn't even there yet.

> > + *
> > + *           Return -EAGAIN if there are suppliers that need to be linked to
> > + *           that are not yet available but none of those suppliers are
> > + *           necessary for probing this device.
>
> "Return -EAGAIN if attempts to create device links to some of the device's
> suppliers have failed, but those suppliers are not necessary for probing the
> device."

Same comment as before. The distinction I'm making here is that
-EAGAIN is needed when the struct device itself isn't there.

Btw, Greg already pulled these into driver-core-next. Let me know if
you want me to send a delta patch to fix any of these comments.

Thanks,
Saravana
