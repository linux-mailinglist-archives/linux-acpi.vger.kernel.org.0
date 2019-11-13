Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D892FA2EA
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 03:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfKMCGx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 21:06:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbfKMCGw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Nov 2019 21:06:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so264128oto.3
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2019 18:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUtTOHWyzSDWIPjsJHW06pPTn0x6obzqOHI2G8rBav8=;
        b=p5WKOfhT7tef8IC18WnzUALrBl9hQZaiVDsRNwsGQjxoNha7Sidx8wSmmdENne847R
         MzNjXemAvHlmfOLbXtCtbTlOurhnh1FQKdKkop4bB2Ayj5SmYnOCoMR1FLDKC7wDpl9K
         d7OLu0FxrFYfiptb1CxjZY5i5nmYPXpHHe9/qBBgUnLvdeLJlHHFaioB2RHqubwaWGBz
         JefH5lLZHXW3Pkfxq5TTJz7vj8fJLtqRdpyYzbD/ZLHRtJTADhsNuwnRwV3nwl1eD4xu
         GR5hcoIjbBIzKpNZdznoNPMgI4CGiEudqOScWPz6auOKdOr7TxBkk8wJ9b1HM8BKPR6V
         KKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUtTOHWyzSDWIPjsJHW06pPTn0x6obzqOHI2G8rBav8=;
        b=PgKILPwi+v/8K5bIFI5qsO5iW+YIS7j3hSSToDuqlu/gdS4uxOLisdGUriMWVADbEl
         u0ADHcrP43q6yMW6sTfolUFGeRlJEF5/ldCGQt5USsprlzo3E9xKseFsDLQbKZ6OHhJ3
         zmYg7RppCzh0TJzUHrPaDu1DbxvvCUvFcfiDmYZGukCvbZ3dL1LO4oPsoYVbEt3r4nBp
         a4tAnntaetC6KV9VPDWZpdAjshTh3FHUuhRsQDopD7/4RRQlTDdDTzG6qtUiUuSCEotL
         0N4/yYDDTvIkhezVDa6L6oSNqD/z5xjUxudEWgWjqOpnjCtNV71MrUdTKOkmNJ/R1ByU
         8rSw==
X-Gm-Message-State: APjAAAU3pSHp+XZMy3pXcxJCXHOdVV+MqRLjpw1c4zWvlFEQFbQ1FrSK
        Ztp8FlE8JYZe544T0ckMTn77ZXPTtvj4KisUQrH3ZWc4
X-Google-Smtp-Source: APXvYqyf/VGQXRwljsfYoE2jmqrxKH5PWyny4Vylqk7rqWMLzNckEKp9OtI2Yp5CXKFhjEJSufddU83l+b68QoiqBpo=
X-Received: by 2002:a05:6830:1d71:: with SMTP id l17mr528996oti.236.1573610810836;
 Tue, 12 Nov 2019 18:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <CAJZ5v0gfgr=y=NYyNHDeOX_JsUa+41LPucovvC5TnOB3HuonTg@mail.gmail.com>
 <CAGETcx-X938BxBeqYD8m8Wrx-hRaXk6EEeR4szh34CS5Sv7EgA@mail.gmail.com> <6671524.6K7l14UQst@kreacher>
In-Reply-To: <6671524.6K7l14UQst@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Nov 2019 18:06:14 -0800
Message-ID: <CAGETcx9G6aH2Eu9ss-RzH4oaBq-mM-EtdjYReKtba86k2KL8+A@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] driver core: Allow fwnode_operations.add_links to
 differentiate errors
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Nov 7, 2019 at 4:35 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, November 6, 2019 1:00:18 AM CET Saravana Kannan wrote:
> > On Tue, Nov 5, 2019 at 3:07 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Nov 5, 2019 at 11:52 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > Hi Rafael,
> > > >
> > > > Thanks for the review.
> > > >
> > > > On Tue, Nov 5, 2019 at 2:43 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > On Monday, October 28, 2019 11:00:24 PM CET Saravana Kannan wrote:
> > > > > > When add_links() still has suppliers that it needs to link to in the
> > > > > > future, this patch allows it to differentiate between suppliers that are
> > > > > > needed for probing vs suppliers that are needed for sync_state()
> > > > > > correctness.
> > > > >
> > > > > I guess you mean that it will return different error codes in the different
> > > > > cases.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > ---
> > > > > >  drivers/base/core.c    | 12 ++++++++----
> > > > > >  include/linux/fwnode.h | 13 +++++++++----
> > > > > >  2 files changed, 17 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > > > index 48cd43a91ce6..e6d3e6d485da 100644
> > > > > > --- a/drivers/base/core.c
> > > > > > +++ b/drivers/base/core.c
> > > > > > @@ -2297,7 +2297,7 @@ int device_add(struct device *dev)
> > > > > >       struct device *parent;
> > > > > >       struct kobject *kobj;
> > > > > >       struct class_interface *class_intf;
> > > > > > -     int error = -EINVAL;
> > > > > > +     int error = -EINVAL, fw_ret;
> > > > > >       struct kobject *glue_dir = NULL;
> > > > > >
> > > > > >       dev = get_device(dev);
> > > > > > @@ -2413,9 +2413,13 @@ int device_add(struct device *dev)
> > > > > >        */
> > > > > >       device_link_add_missing_supplier_links();
> > > > > >
> > > > > > -     if (fwnode_has_op(dev->fwnode, add_links)
> > > > > > -         && fwnode_call_int_op(dev->fwnode, add_links, dev))
> > > > > > -             device_link_wait_for_mandatory_supplier(dev, true);
> > > > > > +     if (fwnode_has_op(dev->fwnode, add_links)) {
> > > > >
> > > > > fw_ret can be defined here and I'd just call it "ret".
> > > >
> > > > I thought that style of variable declaration is frowned up in the
> > > > kernel coding style.
> > >
> > > Well, I'm not aware of that. :-)
> >
> > I've definitely seen such comments before. So I'll leave fw_ret as is.
> > If you and Greg both want to change it to the way you mentioned, I'm
> > happy to do it.
>
> If this has been committed the way it is, there's not so much of a difference,
> but I generally like variables to not be seen out of the scope in which they
> are used, as that allows bugs to be caught at compile time sometimes.

Ok, I don't have a strong preference either way. My understanding is
that Greg doesn't like declaring variables "in the middle". So I'm
going to leave it as is unless I'm corrected.

>
> > > > >
> > > > > > +             fw_ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
> > > > > > +             if (fw_ret == -ENODEV)
> > > > > > +                     device_link_wait_for_mandatory_supplier(dev);
> > > > > > +             else if (fw_ret)
> > > > > > +                     device_link_wait_for_optional_supplier(dev);
> > > > > > +     }
> > > > > >
> > > > > >       bus_probe_device(dev);
> > > > > >       if (parent)
> > > > > > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > > > > > index 25bb81f8ded8..a19134eae5a5 100644
> > > > > > --- a/include/linux/fwnode.h
> > > > > > +++ b/include/linux/fwnode.h
> > > > > > @@ -96,10 +96,15 @@ struct fwnode_reference_args {
> > > > > >   *           available suppliers.
> > > > > >   *
> > > > > >   *           Return 0 if device links have been successfully created to all
> > > > > > - *           the suppliers of this device or if the supplier information is
> > > > > > - *           not known. Return an error if and only if the supplier
> > > > > > - *           information is known but some of the suppliers are not yet
> > > > > > - *           available to create device links to.
> > > > > > + *           the suppliers this device needs to create device links to or if
> > > > > > + *           the supplier information is not known.
> > > > >
> > > > > "the known suppliers of this device or if the supplier information is not known."
> > > >
> > > > "suppliers it needs to create device links to" is a subset of known
> > > > suppliers. There's no requirement that fw needs to create links to ALL
> > > > known suppliers. Just a minor distinction.
> > >
> > > That depends on what exactly you mean by "known suppliers".  The
> > > suppliers that are not listed by the firmware are not known at this
> > > point.
> >
> > Ok, I'll rephrase my comment:
> > "suppliers it needs to create device links to" is a subset of listed
> > suppliers. There's no requirement that fw needs to create links to ALL
> > listed suppliers. For example, I can't think of any reason for
> > sync_state() to be necessary for an interrupt controller driver.
>
> A sync_state() may not be, but it may be a good idea to create device links
> to the controller device from all devices that rely on it, so as to ensure
> the right system suspend/resume ordering if nothing else.

True. Frameworks are starting to add device links when consumers make
calls to "get()" the resource. But if firmware can add it ahead of
time, it doesn't hurt I suppose and it'll also cover for frameworks
without device links support yet.

> > So, fw doesn't need to create device links from consumer to interrupt
> > supplier. So I'm being more explicit and saying "the suppliers this
> > device needs to create device links to" instead of "the listed
> > suppliers of this device".
>
> This gives me the feeling of splitting hairs to be honest. :-)

Maybe, but it's coming from a point of goodwill :) I just want to
capture the intent as narrowly and accurately as possible.

> In fact, the FW indicates to the OS that there are some dependencies (either
> hard or soft) between devices and adding device links is a way to act on that
> information.
>
> The "device link" notion is not actually defined at the FW level.  What it
> knows about is a "probe dependency" or an "ordering constraint" which then
> is represented by a device link at the OS level.

And you've convinced me why it doesn't have to be as narrow as I intended.

> > Long story short, I wrote the comment this way intentionally and
> > changing it to what you suggest makes it inaccurate IMHO. But I'm open
> > to other wording suggestions to improve the clarity of this comment.
>
> My point basically is that the way you phrased it may lead to some confusion
> (regardless of whether or not it is intentional).

Ok, I think we are on the same page now. I'll send an update soon.

>
> > >
> > > > > > + *
> > > > > > + *           Return -ENODEV if and only if the suppliers needed for probing
> > > > > > + *           the device are not yet available to create device links to.
> > > > >
> > > > > It would be more precise to say something like this:
> > > > >
> > > > > "Return -ENODEV if an attempt to create a device link to one of the device's
> > > > > suppliers needed for probing it fails."
> > > >
> > > > "attempt to create a device link to one of the device's suppliers
> > > > needed for probing it fails" to me means device_link_add() fails.
> > > > But I'm trying to say that it should return an error if the struct
> > > > device isn't even there yet.
> > >
> > > OK, so it should be something like "if the supplier device has not
> > > been registered yet".
> > >
> > > My point is that "not yet available" is kind of ambiguous.
> >
> > Agree, the latest suggestion sounds better.
> >
> > > > > > + *
> > > > > > + *           Return -EAGAIN if there are suppliers that need to be linked to
> > > > > > + *           that are not yet available but none of those suppliers are
> > > > > > + *           necessary for probing this device.
> > > > >
> > > > > "Return -EAGAIN if attempts to create device links to some of the device's
> > > > > suppliers have failed, but those suppliers are not necessary for probing the
> > > > > device."
> > > >
> > > > Same comment as before. The distinction I'm making here is that
> > > > -EAGAIN is needed when the struct device itself isn't there.
> > > >
> > > > Btw, Greg already pulled these into driver-core-next. Let me know if
> > > > you want me to send a delta patch to fix any of these comments.
> > >
> > > Well, it's a Greg's call if he has taken the patches, but it also
> > > depends on you (if you agree with the comments, it would be prudent to
> > > send updates).
> >
> > I don't mind sending updates at all. Just trying to make sure I follow
> > the maintainers' preference in case they don't want trivial (because
> > my current ones aren't terrible :)) comment update patches.
>
> If it can be improved, then improve it.  Worst case you can hear from the
> maintainers that they don't agree with the proposed changes.

Eh, I've been yelled at a couple of times for sending patches too soon
or too many. So just playing it safe.

-Saravana
