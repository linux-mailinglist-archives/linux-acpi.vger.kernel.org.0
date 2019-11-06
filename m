Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D521F0ACF
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 01:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfKFAA5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Nov 2019 19:00:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39009 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfKFAA4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Nov 2019 19:00:56 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so19312138oif.6
        for <linux-acpi@vger.kernel.org>; Tue, 05 Nov 2019 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hiwhUzBCXtjT83VsDEmYQHpboeTfijrcF+AJ7syBgI=;
        b=MbXZiQWcxLr/gVCG+4TdqJiu9bk0wCssGuEy3JC0jY361MdKBbNcQEbabZc2GwKXpg
         cJe54VxnwZZKb1YlthhCkm0wK42efq1vPtHhHFSibIJbMtNoGy6nenFRPVN4rbBfoK57
         Sw/B3zSfBx1U4OFn9zi9MHGwJIqq6PsVdOnJXsbSzecojJk5vfAXaNJAMdxFCwKm/BII
         LOPCWctuW8M2PteNbNjrne7FXwL6ZVAzN9ctKGS4erPZxzyqfjx7oE3+/7SEZVIYj7NW
         a5wspJqTqOcB8e7AGbAznLFYoM2Mb9pHqtF+afn/bSNz+GkvfTZBR16IW96xlpOfT5n9
         mF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hiwhUzBCXtjT83VsDEmYQHpboeTfijrcF+AJ7syBgI=;
        b=UEGusqOBPxhnkA/JflZgxB3BkJK1athDT2JHTE8u1oVw8L0vWxDLVXdJprwz1ueThw
         pAeMh6cXwVf2sAxHolyRYCDsFg5YFisQqdCeMFOAWb4wvrYg/H5JS9SDuCN9f4BJIzz8
         J9caeWXfLHxnEp6jgnddY57qIUg0bvgI2Jwvw0lVwGykKCsuKJ2Pj5gEXZYrPG7YFsbc
         kj8nuep0tpzGls/UvVCilrfovYu/UIby1cRNHAI/r+BOW2OJL8A0p4mHBkiq1Ojx18rU
         rCVYGaH0j7YV7FRYwzzERj8z8uArwHUHIFDdTaScWsx4VxeV1dqcqUGg5dl3Z8XHAHW2
         8vSA==
X-Gm-Message-State: APjAAAUSVhXWo+XDLGT14VUzrvZ5VBp1TDrEMSfx/0aWGeCGq2gxehoc
        93LGRi8DK4i/JciwKU5BriMBoyx+DU05AFM+XT8SGQ==
X-Google-Smtp-Source: APXvYqwzm4wCZExmTT9d9VK+Gdv2LNZ8t/hDnxctzxs8ZILMZJ/1pkogRUEcaomc67Ia7ab9IQrVz0Wbl2XfyNTwQMs=
X-Received: by 2002:aca:b03:: with SMTP id 3mr1450645oil.24.1572998455036;
 Tue, 05 Nov 2019 16:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-4-saravanak@google.com>
 <7640808.4Pc6YCm0Y9@kreacher> <CAGETcx9z86d+w7jO8Nnu+R62RrT829rj3FFHW2GvGdSsnoB3og@mail.gmail.com>
 <CAJZ5v0gfgr=y=NYyNHDeOX_JsUa+41LPucovvC5TnOB3HuonTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gfgr=y=NYyNHDeOX_JsUa+41LPucovvC5TnOB3HuonTg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 5 Nov 2019 16:00:18 -0800
Message-ID: <CAGETcx-X938BxBeqYD8m8Wrx-hRaXk6EEeR4szh34CS5Sv7EgA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] driver core: Allow fwnode_operations.add_links to
 differentiate errors
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 5, 2019 at 3:07 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 5, 2019 at 11:52 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for the review.
> >
> > On Tue, Nov 5, 2019 at 2:43 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Monday, October 28, 2019 11:00:24 PM CET Saravana Kannan wrote:
> > > > When add_links() still has suppliers that it needs to link to in the
> > > > future, this patch allows it to differentiate between suppliers that are
> > > > needed for probing vs suppliers that are needed for sync_state()
> > > > correctness.
> > >
> > > I guess you mean that it will return different error codes in the different
> > > cases.
> >
> > Yes.
> >
> > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/core.c    | 12 ++++++++----
> > > >  include/linux/fwnode.h | 13 +++++++++----
> > > >  2 files changed, 17 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 48cd43a91ce6..e6d3e6d485da 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -2297,7 +2297,7 @@ int device_add(struct device *dev)
> > > >       struct device *parent;
> > > >       struct kobject *kobj;
> > > >       struct class_interface *class_intf;
> > > > -     int error = -EINVAL;
> > > > +     int error = -EINVAL, fw_ret;
> > > >       struct kobject *glue_dir = NULL;
> > > >
> > > >       dev = get_device(dev);
> > > > @@ -2413,9 +2413,13 @@ int device_add(struct device *dev)
> > > >        */
> > > >       device_link_add_missing_supplier_links();
> > > >
> > > > -     if (fwnode_has_op(dev->fwnode, add_links)
> > > > -         && fwnode_call_int_op(dev->fwnode, add_links, dev))
> > > > -             device_link_wait_for_mandatory_supplier(dev, true);
> > > > +     if (fwnode_has_op(dev->fwnode, add_links)) {
> > >
> > > fw_ret can be defined here and I'd just call it "ret".
> >
> > I thought that style of variable declaration is frowned up in the
> > kernel coding style.
>
> Well, I'm not aware of that. :-)

I've definitely seen such comments before. So I'll leave fw_ret as is.
If you and Greg both want to change it to the way you mentioned, I'm
happy to do it.

> > >
> > > > +             fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> > > > +             if (fw_ret == -ENODEV)
> > > > +                     device_link_wait_for_mandatory_supplier(dev);
> > > > +             else if (fw_ret)
> > > > +                     device_link_wait_for_optional_supplier(dev);
> > > > +     }
> > > >
> > > >       bus_probe_device(dev);
> > > >       if (parent)
> > > > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > > > index 25bb81f8ded8..a19134eae5a5 100644
> > > > --- a/include/linux/fwnode.h
> > > > +++ b/include/linux/fwnode.h
> > > > @@ -96,10 +96,15 @@ struct fwnode_reference_args {
> > > >   *           available suppliers.
> > > >   *
> > > >   *           Return 0 if device links have been successfully created to all
> > > > - *           the suppliers of this device or if the supplier information is
> > > > - *           not known. Return an error if and only if the supplier
> > > > - *           information is known but some of the suppliers are not yet
> > > > - *           available to create device links to.
> > > > + *           the suppliers this device needs to create device links to or if
> > > > + *           the supplier information is not known.
> > >
> > > "the known suppliers of this device or if the supplier information is not known."
> >
> > "suppliers it needs to create device links to" is a subset of known
> > suppliers. There's no requirement that fw needs to create links to ALL
> > known suppliers. Just a minor distinction.
>
> That depends on what exactly you mean by "known suppliers".  The
> suppliers that are not listed by the firmware are not known at this
> point.

Ok, I'll rephrase my comment:
"suppliers it needs to create device links to" is a subset of listed
suppliers. There's no requirement that fw needs to create links to ALL
listed suppliers. For example, I can't think of any reason for
sync_state() to be necessary for an interrupt controller driver. So,
fw doesn't need to create device links from consumer to interrupt
supplier. So I'm being more explicit and saying "the suppliers this
device needs to create device links to" instead of "the listed
suppliers of this device".

Long story short, I wrote the comment this way intentionally and
changing it to what you suggest makes it inaccurate IMHO. But I'm open
to other wording suggestions to improve the clarity of this comment.

>
> > > > + *
> > > > + *           Return -ENODEV if and only if the suppliers needed for probing
> > > > + *           the device are not yet available to create device links to.
> > >
> > > It would be more precise to say something like this:
> > >
> > > "Return -ENODEV if an attempt to create a device link to one of the device's
> > > suppliers needed for probing it fails."
> >
> > "attempt to create a device link to one of the device's suppliers
> > needed for probing it fails" to me means device_link_add() fails.
> > But I'm trying to say that it should return an error if the struct
> > device isn't even there yet.
>
> OK, so it should be something like "if the supplier device has not
> been registered yet".
>
> My point is that "not yet available" is kind of ambiguous.

Agree, the latest suggestion sounds better.

> > > > + *
> > > > + *           Return -EAGAIN if there are suppliers that need to be linked to
> > > > + *           that are not yet available but none of those suppliers are
> > > > + *           necessary for probing this device.
> > >
> > > "Return -EAGAIN if attempts to create device links to some of the device's
> > > suppliers have failed, but those suppliers are not necessary for probing the
> > > device."
> >
> > Same comment as before. The distinction I'm making here is that
> > -EAGAIN is needed when the struct device itself isn't there.
> >
> > Btw, Greg already pulled these into driver-core-next. Let me know if
> > you want me to send a delta patch to fix any of these comments.
>
> Well, it's a Greg's call if he has taken the patches, but it also
> depends on you (if you agree with the comments, it would be prudent to
> send updates).

I don't mind sending updates at all. Just trying to make sure I follow
the maintainers' preference in case they don't want trivial (because
my current ones aren't terrible :)) comment update patches.

Once we agree on all the discussion here, I can send an update patch.

Thanks again for your review.

-Saravana
