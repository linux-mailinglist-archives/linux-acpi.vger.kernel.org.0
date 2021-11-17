Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF7454944
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 15:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhKQOze (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 09:55:34 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42893 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhKQOzc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2021 09:55:32 -0500
Received: by mail-oi1-f176.google.com with SMTP id n66so6890688oia.9
        for <linux-acpi@vger.kernel.org>; Wed, 17 Nov 2021 06:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPQz6RGjSZx1pqGnwGyigDzHeQc7ZhXAz0hsX7CsK98=;
        b=BMer11gIFj0JbQ9abphoqVCN3XX9c5XVOl2S821xt7sblu6TD0jfOv3rNw0etVmmrI
         lVy9xWviCke+dLrTLzYWE+HMhrAz5rpzVAXtfG9lvuXwQuq7JcTFmw+9K7at6HzKKP4N
         xlawhaHPBfIY2gp3WyXsiBHlCO8E738uaVZ0jRwTD7rOz313lP5JyvjykPSjQw4Tdt8h
         jeRStQiocYn8rZ+FNTHxIrJPi41aipI+bWWqutCHJOef6/uCuRj1U2bYZJ6LDSqcgC73
         //qAcBxZHS1dn6irYiTYFhsvpUBGdm9mraEKDKyOGEwC5UD3/YoeLmCSZp39ORWDQLkj
         7yrw==
X-Gm-Message-State: AOAM5313g4I8ZsiOmuyWNMr9O7/Pajb4Ak5diozjKtYL4atEs32eHwLw
        WDAmcs5n77BMF0t4q8+l+o/cX382sSQ80q8+zyI=
X-Google-Smtp-Source: ABdhPJzAcGzDGUux2tOOBkjMFiV7iEAdQ073ocOwOsK1b3YFUn1X+4cMs3VrRaNfUfzYW1f0kRNjtGBDU4ryenBXrBc=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr190689oiw.154.1637160752233;
 Wed, 17 Nov 2021 06:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20211109111935.1627406-1-sakari.ailus@linux.intel.com>
 <20211109111935.1627406-2-sakari.ailus@linux.intel.com> <YYpnQaZ7u9Zqr0Qb@smile.fi.intel.com>
 <YYt+IDubi6ib/Iko@paasikivi.fi.intel.com>
In-Reply-To: <YYt+IDubi6ib/Iko@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Nov 2021 15:52:21 +0100
Message-ID: <CAJZ5v0jFy2OCi2H+aHnZ8OQXZuDf+RnjchcJce_VNLVpPkzL3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: Get acpi_device's parent from the parent field
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 9:09 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Andy,
>
> Thanks for the review.
>
> On Tue, Nov 09, 2021 at 02:19:13PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 09, 2021 at 01:19:34PM +0200, Sakari Ailus wrote:
> > > Printk modifier %pfw is used to print the full path of the device name.
> > > This is obtained device by device until a device no longer has a parent.
> > >
> > > On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> > > which tries to down() a semaphore. But local IRQs are now disabled in
> > > vprintk_store() before the mutex is acquired. This is obviously a problem.
> > >
> > > Luckily struct device, embedded in struct acpi_device, has a parent field
> > > already. Use that field to get the parent instead of relying on
> > > acpi_get_parent().
> >
> > Thanks, with the below addressed
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > > Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for printing fwnode names")
> > > Cc: stable@vger.kernel.org # v5.5+
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index e312ebaed8db4..dc97711ba8081 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1089,16 +1089,14 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
> > >     if (is_acpi_data_node(fwnode)) {
> > >             /* All data nodes have parent pointer so just return that */
> > >             return to_acpi_data_node(fwnode)->parent;
> >
> > ...
> >
> > > -   } else if (is_acpi_device_node(fwnode)) {
> > > +   }
> >
> > > +   if (is_acpi_device_node(fwnode)) {
> >
> > Unneeded change. Yes I know that 'else' here can be skipped. But in such cases
> > it's a trade-off between changes, code readability and maintenance. Since here
> > it's a fix, backporting concerns are also play role.
>
> The patch applies cleanly to 5.5, the oldest kernel where it's needed.

Which doesn't matter too much.

The change above is not needed and there is no point making it in
which otherwise is a fix, not just because of the backporting
concerns, but also for the sake of cleanliness in general.

Have you posted the v3 already?  If not, please update the patch as
requested by Andy.
