Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D13C6323
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhGLTHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 15:07:38 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45799 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhGLTHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2021 15:07:38 -0400
Received: by mail-ot1-f44.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso19913797oty.12;
        Mon, 12 Jul 2021 12:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reEJf1bmElX4/0DK2loR9L7DpxWf5DpKVb/0nheNJZA=;
        b=n/eVYPEsUOJEIcaGvLhXqSokYCdbaB4lNf4loc4/KQBpJKk3+XBjoMr3eQrVFPZVvi
         4cEqIy1GtssldzZxDPsbmxK5dJMw8ifqV0Wa6cafgQfhysuCRitaILzbQK+EOorqogyM
         4a0L35h6f1GpJsdBnhv0TZQ0tEmvLOr9/54WkwDj3O9zNyAtYbgbACUIZIFtg5DOdaw3
         NeqshNDWT7aVSLWs88LEim+xXOv96aSrqfLQfb3G3RRJBy6R9CIIlwAnJ296AdnQAzKU
         wfO8ubj2KRUezsd5i5+ctTqrWLEvCGmrwAwjE6IYnlPoCumKE89XLw1+hEHEyGFcvvIQ
         Hwug==
X-Gm-Message-State: AOAM533nurr5XRtOKE1tukWSaDHcahCq97D0tWG6a9xaj/y4H1CJF5Vn
        qLVnu21aXTzO85iGFn4jAsZS340pEeYs/lHfXDwHKxPg
X-Google-Smtp-Source: ABdhPJyQ8aCvZedt0gS7+ZoS4te5VHnzm3uHQ0+dHpBCKXjAZWwuKG16pDhnFV547DTrombI9BFXMSdkV2oJpJDlEAQ=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr404882otj.260.1626116689419;
 Mon, 12 Jul 2021 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <5627033.MhkbZ0Pkbq@kreacher>
 <YOyD/4kdvd77PzLy@kroah.com> <CAJZ5v0gJP1ywCwEgdGdx2A4ZPaSKc3utmXeO_geiGfA85axZOw@mail.gmail.com>
 <YOyQrK3b2dhb2wTF@kroah.com>
In-Reply-To: <YOyQrK3b2dhb2wTF@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 21:04:38 +0200
Message-ID: <CAJZ5v0j8RUviZRTgsYNis5vc+6g0ACLGiOm84Y+ocPpHBXgLoA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 8:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 12, 2021 at 08:30:06PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 12, 2021 at 8:03 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 12, 2021 at 07:27:12PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Split software_node_notify_remove) out of software_node_notify()
> > > > and make device_platform_notify() call the latter on device addition
> > > > and the former on device removal.
> > > >
> > > > While at it, put the headers of the above functions into base.h,
> > > > because they don't need to be present in a global header file.
> > > >
> > > > No intentional functional impact.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/base.h      |    3 ++
> > > >  drivers/base/core.c      |    9 +++---
> > > >  drivers/base/swnode.c    |   61 ++++++++++++++++++++++++-----------------------
> > > >  include/linux/property.h |    2 -
> > > >  4 files changed, 39 insertions(+), 36 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/swnode.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/base/swnode.c
> > > > +++ linux-pm/drivers/base/swnode.c
> > > > @@ -11,6 +11,8 @@
> > > >  #include <linux/property.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > +#include "base.h"
> > > > +
> > > >  struct swnode {
> > > >       struct kobject kobj;
> > > >       struct fwnode_handle fwnode;
> > > > @@ -1053,7 +1055,7 @@ int device_add_software_node(struct devi
> > > >        * balance.
> > > >        */
> > > >       if (device_is_registered(dev))
> > > > -             software_node_notify(dev, KOBJ_ADD);
> > > > +             software_node_notify(dev);
> > >
> > > Should this now be called "software_node_notify_add()" to match up with:
> > >
> > > >       if (device_is_registered(dev))
> > > > -             software_node_notify(dev, KOBJ_REMOVE);
> > > > +             software_node_notify_remove(dev);
> > >
> > > The other being called "_remove"?
> > >
> > > Makes it more obvious to me :)
> >
> > The naming convention used here follows platform_notify() and
> > platform_notify_remove(), and the analogous function names in ACPI for
> > that matter.
> >
> > I thought that adding _add in just one case would be sort of odd, but
> > of course I can do that, so please let me know what you want me to do.
>
> Ah, ok, that makes more sense, let's just leave it as-is then:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!
