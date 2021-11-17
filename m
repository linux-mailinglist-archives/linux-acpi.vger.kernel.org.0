Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C0F454BB6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhKQROy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 12:14:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:30669 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239311AbhKQROw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 12:14:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234233636"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="234233636"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:46:46 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="672449260"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:46:44 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id F310420282;
        Wed, 17 Nov 2021 18:46:41 +0200 (EET)
Date:   Wed, 17 Nov 2021 18:46:41 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
Message-ID: <YZUx8ZEWTuKCTX8q@paasikivi.fi.intel.com>
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-2-sakari.ailus@linux.intel.com>
 <YYpnQaZ7u9Zqr0Qb@smile.fi.intel.com>
 <YYt+IDubi6ib/Iko@paasikivi.fi.intel.com>
 <CAJZ5v0jFy2OCi2H+aHnZ8OQXZuDf+RnjchcJce_VNLVpPkzL3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFy2OCi2H+aHnZ8OQXZuDf+RnjchcJce_VNLVpPkzL3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2021 at 03:52:21PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 10, 2021 at 9:09 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Andy,
> >
> > Thanks for the review.
> >
> > On Tue, Nov 09, 2021 at 02:19:13PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 09, 2021 at 01:19:34PM +0200, Sakari Ailus wrote:
> > > > Printk modifier %pfw is used to print the full path of the device name.
> > > > This is obtained device by device until a device no longer has a parent.
> > > >
> > > > On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> > > > which tries to down() a semaphore. But local IRQs are now disabled in
> > > > vprintk_store() before the mutex is acquired. This is obviously a problem.
> > > >
> > > > Luckily struct device, embedded in struct acpi_device, has a parent field
> > > > already. Use that field to get the parent instead of relying on
> > > > acpi_get_parent().
> > >
> > > Thanks, with the below addressed
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > > Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for printing fwnode names")
> > > > Cc: stable@vger.kernel.org # v5.5+
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/acpi/property.c | 14 ++++++--------
> > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > index e312ebaed8db4..dc97711ba8081 100644
> > > > --- a/drivers/acpi/property.c
> > > > +++ b/drivers/acpi/property.c
> > > > @@ -1089,16 +1089,14 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
> > > >     if (is_acpi_data_node(fwnode)) {
> > > >             /* All data nodes have parent pointer so just return that */
> > > >             return to_acpi_data_node(fwnode)->parent;
> > >
> > > ...
> > >
> > > > -   } else if (is_acpi_device_node(fwnode)) {
> > > > +   }
> > >
> > > > +   if (is_acpi_device_node(fwnode)) {
> > >
> > > Unneeded change. Yes I know that 'else' here can be skipped. But in such cases
> > > it's a trade-off between changes, code readability and maintenance. Since here
> > > it's a fix, backporting concerns are also play role.
> >
> > The patch applies cleanly to 5.5, the oldest kernel where it's needed.
> 
> Which doesn't matter too much.
> 
> The change above is not needed and there is no point making it in
> which otherwise is a fix, not just because of the backporting
> concerns, but also for the sake of cleanliness in general.
> 
> Have you posted the v3 already?  If not, please update the patch as
> requested by Andy.

I'll post v3 soon.

-- 
Sakari Ailus
