Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FF3C6BAE
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jul 2021 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhGMHta (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Jul 2021 03:49:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:61484 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234342AbhGMHta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Jul 2021 03:49:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197391554"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="197391554"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 00:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="570205582"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Jul 2021 00:46:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 13 Jul 2021 10:46:36 +0300
Date:   Tue, 13 Jul 2021 10:46:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/6] software nodes: Split software_node_notify()
Message-ID: <YO1E3PjX/uqZEgCF@kuha.fi.intel.com>
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

So why not rename those instead: platform_notify() to
platform_notify_add() and so on? You are in any case modifying
acpi_device_notify() in this series, and I think there is only one
place left where .platform_notify is assigned. I believe you also
wouldn't then need to worry about the function name collision (3/6).

> I thought that adding _add in just one case would be sort of odd, but
> of course I can do that, so please let me know what you want me to do.

I would prefer the "_add" ending, but in any case, FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


-- 
heikki
