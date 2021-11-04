Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21F2445358
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 13:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhKDMza (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 08:55:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:14030 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhKDMz3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Nov 2021 08:55:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231944663"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="231944663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:52:51 -0700
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="600240892"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:52:49 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B793920BFE;
        Thu,  4 Nov 2021 14:52:47 +0200 (EET)
Date:   Thu, 4 Nov 2021 14:52:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YYPXnx6vC7XVZF1B@paasikivi.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-3-sakari.ailus@linux.intel.com>
 <YYLAbVNARsDeJm61@smile.fi.intel.com>
 <CAJZ5v0hBy7TUu7eBkqSfQMEH24XsgSvOBQ-QPR4bk4kHumJW3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hBy7TUu7eBkqSfQMEH24XsgSvOBQ-QPR4bk4kHumJW3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Nov 03, 2021 at 06:48:31PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 3, 2021 at 6:02 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Wed, Nov 03, 2021 at 03:34:05PM +0200, Sakari Ailus wrote:
> > > Printk modifier %pfw is used to print the full path of the device name.
> > > This is obtained device by device until a device no longer has a parent.
> > >
> > > On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> > > which tries to down() a semaphore. But local IRQs are now disabled in
> > > vprintk_store() before the mutex is acquired. This is obviously a problem.
> > >
> > > Luckily struct acpi_device has a parent field already.
> 
> Which I'm going to eliminate, because it is redundant.
> 
> The dev object embedded in struct acpi_device has a parent field
> pointing to the same object and that one is used by the driver core.

Indeed, I'll do that in v2.

> 
> > > Use that field to get the parent instead of relying on acpi_get_parent().
> >
> > I think the best if Rafael can confirm that we may use it like this.
> > If he approved, nothing would stop me to give you
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> In fact, I would prefer the parent field of the dev object embedded in
> struct acpi_device to be used and for completeness it should be tested
> against NULL unless you know that the parent is not going away ATM.
> 
> > > Fixes: 002eb6ad0751 ("printk: track/limit recursion")
> > > Cc: stable@vger.kernel.org # v5.15 and up
> > > Depends-on: ("ACPI: Make acpi_fwnode_handle safer")
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index e312ebaed8db4..7403ee2816eb8 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1089,16 +1089,12 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
> > >       if (is_acpi_data_node(fwnode)) {
> > >               /* All data nodes have parent pointer so just return that */
> > >               return to_acpi_data_node(fwnode)->parent;
> > > -     } else if (is_acpi_device_node(fwnode)) {
> > > -             acpi_handle handle, parent_handle;
> > > +     }
> > >
> > > -             handle = to_acpi_device_node(fwnode)->handle;
> > > -             if (ACPI_SUCCESS(acpi_get_parent(handle, &parent_handle))) {
> > > -                     struct acpi_device *adev;
> > > +     if (is_acpi_device_node(fwnode)) {
> > > +             struct acpi_device *device = to_acpi_device_node(fwnode);
> 
> Call this variable adev please.
> 
> > >
> > > -                     if (!acpi_bus_get_device(parent_handle, &adev))
> > > -                             return acpi_fwnode_handle(adev);
> > > -             }
> > > +             return acpi_fwnode_handle(device->parent);
> 
> And then
> 
>              adev = to_acpi_device(&device->dev.parent);
>              if (adev)
>                           return acpi_fwnode_handle(adev);

Ack.

> 
> > >       }
> > >
> > >       return NULL;

-- 
Kind regards,

Sakari Ailus
