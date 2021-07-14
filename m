Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243E33C8AA4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhGNSVA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 14:21:00 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:44941 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhGNSVA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 14:21:00 -0400
Received: by mail-oo1-f49.google.com with SMTP id u13-20020a4ad0cd0000b02902638ef0f883so301254oor.11;
        Wed, 14 Jul 2021 11:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gL9wte4jm249mEpLwF1GV8lanhK36T8A64+3sF6q2RE=;
        b=uT7pZ2lStq+h8iNl2CNfGt2B/vqdpUUeqQA2ZTxWlT1CJiduZ6ssQvoaNH4EBkHiJa
         HjwBYMQ8N0GI8TdY30UQZGfarCV55MUiSyFeztjdRPOycD8nWRt1/bA1GbIjVnGiLlrU
         p0w+rFIECPg6LuRinlj32AKIOqzB5OxkmacQ8qGzZSjCeFw4lEwJMUz+K2MMg60L8QUz
         RIOCojGi+K+pTg1u5LVfraZL9+Vm8Q7Jyg+hfEkOu0V8cxj+SRXoM66R6pkUNgbVLJ9q
         MQLeKqQFMxh7J4ucnP0L2fXg9TTn73nQuwwk8Stwtl5hdz+5xwjINO6KNlM6AvmDqhri
         uPFw==
X-Gm-Message-State: AOAM5313ZniotFprNcLjJKomtO66pBMBL2M7BIXPftRtKXnSLKs0ys49
        9nLNn40gqiTfV7OQWtZmXpXwsoiiohChs77IiNI=
X-Google-Smtp-Source: ABdhPJxpt5PSLiPqjE1fknhV/cFqwcTEA4+dRzcAqyhZEJpDSAg0Vz2Abi4MXrqyP/fZ02GYdVSkYtyCHSyqmdSSHiI=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr9050963ooa.1.1626286688369;
 Wed, 14 Jul 2021 11:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <2780027.e9J7NaK4W3@kreacher> <5627033.MhkbZ0Pkbq@kreacher>
 <YOyD/4kdvd77PzLy@kroah.com> <CAJZ5v0gJP1ywCwEgdGdx2A4ZPaSKc3utmXeO_geiGfA85axZOw@mail.gmail.com>
 <YO1E3PjX/uqZEgCF@kuha.fi.intel.com>
In-Reply-To: <YO1E3PjX/uqZEgCF@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 20:17:57 +0200
Message-ID: <CAJZ5v0geFmdPFHvE9Rfd9jyErbgmRb=2SWRTc+uivOuWa02-3Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 13, 2021 at 9:46 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
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
>
> So why not rename those instead: platform_notify() to
> platform_notify_add() and so on? You are in any case modifying
> acpi_device_notify() in this series, and I think there is only one
> place left where .platform_notify is assigned. I believe you also
> wouldn't then need to worry about the function name collision (3/6).
>
> > I thought that adding _add in just one case would be sort of odd, but
> > of course I can do that, so please let me know what you want me to do.
>
> I would prefer the "_add" ending, but in any case, FWIW:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!
