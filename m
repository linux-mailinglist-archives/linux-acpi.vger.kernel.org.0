Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69403C6306
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhGLTAl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 15:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhGLTAl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 15:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C676120A;
        Mon, 12 Jul 2021 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626116271;
        bh=P4x4u3W+TsFok4fGyNrfpkXYKrxbAAG8fhhPCl/58dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8dVLW3ZHOzMIO61CZfvi7WbSL4XKXcBuWThED5UfMeXbyoojpQP12fb0YP75amnF
         44OJpkAx8uqaV2fe5ErzBym9guajnYBiuavAaMyksuRLumYLQWDcE8ZPHcr7HAG65B
         VCqUWFaOiFyhHFwQCjXuWp2t8bU5asDqGGQ5b9gI=
Date:   Mon, 12 Jul 2021 20:57:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
Message-ID: <YOyQrK3b2dhb2wTF@kroah.com>
References: <2780027.e9J7NaK4W3@kreacher>
 <5627033.MhkbZ0Pkbq@kreacher>
 <YOyD/4kdvd77PzLy@kroah.com>
 <CAJZ5v0gJP1ywCwEgdGdx2A4ZPaSKc3utmXeO_geiGfA85axZOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gJP1ywCwEgdGdx2A4ZPaSKc3utmXeO_geiGfA85axZOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 08:30:06PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 12, 2021 at 8:03 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 12, 2021 at 07:27:12PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Split software_node_notify_remove) out of software_node_notify()
> > > and make device_platform_notify() call the latter on device addition
> > > and the former on device removal.
> > >
> > > While at it, put the headers of the above functions into base.h,
> > > because they don't need to be present in a global header file.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/base.h      |    3 ++
> > >  drivers/base/core.c      |    9 +++---
> > >  drivers/base/swnode.c    |   61 ++++++++++++++++++++++++-----------------------
> > >  include/linux/property.h |    2 -
> > >  4 files changed, 39 insertions(+), 36 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/swnode.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/swnode.c
> > > +++ linux-pm/drivers/base/swnode.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/property.h>
> > >  #include <linux/slab.h>
> > >
> > > +#include "base.h"
> > > +
> > >  struct swnode {
> > >       struct kobject kobj;
> > >       struct fwnode_handle fwnode;
> > > @@ -1053,7 +1055,7 @@ int device_add_software_node(struct devi
> > >        * balance.
> > >        */
> > >       if (device_is_registered(dev))
> > > -             software_node_notify(dev, KOBJ_ADD);
> > > +             software_node_notify(dev);
> >
> > Should this now be called "software_node_notify_add()" to match up with:
> >
> > >       if (device_is_registered(dev))
> > > -             software_node_notify(dev, KOBJ_REMOVE);
> > > +             software_node_notify_remove(dev);
> >
> > The other being called "_remove"?
> >
> > Makes it more obvious to me :)
> 
> The naming convention used here follows platform_notify() and
> platform_notify_remove(), and the analogous function names in ACPI for
> that matter.
> 
> I thought that adding _add in just one case would be sort of odd, but
> of course I can do that, so please let me know what you want me to do.

Ah, ok, that makes more sense, let's just leave it as-is then:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
