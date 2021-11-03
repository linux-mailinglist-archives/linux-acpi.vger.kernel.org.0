Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE64447AE
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhKCRvT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:51:19 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41951 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhKCRvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 13:51:19 -0400
Received: by mail-ot1-f47.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so4588422ote.8
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 10:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8ESxFzJi1fI0WBhGGo+HAaCi/FB7RFMfIM5SPOKo3Y=;
        b=KfZ5vQ4DdEQmtAZDpEL6aVMx/CBySHbftXxrLyQb2KPoC7PnM4xezWxjuH84lFXZDN
         KDykbIMkJP6lQEDa821/uIv/SqR9rXDSWe/XKuu41IHd/fCaZSSaVC/boUoeQnJtM5u9
         mQp10Vk+rjaUgnHaMmS41OkDRhB2q/6Wh7A4AhbdxzNCj0wo0URe8t1ngukdJGv/WFuD
         PQDgPDE4O4R2ib2FYl0dWA2kO2w77+kFuUcPFKrgsJmEIScOY3X6cvxiMl2DlL4IprjA
         qTXojH1FShG9Vnk/JDECGIVsInefTO53uu5YB8BD2T3fSK34HRShBIxHiwaS9bQa3VeN
         FZFw==
X-Gm-Message-State: AOAM5334U1+8ckid8em9YKj+J1VO5Qd0cqECDhAW4O+JgHOPHdl+gwf7
        NI83yhK70hYaMdti4myjS39MiphzTRsXyEHU0dmLH8DP2RM=
X-Google-Smtp-Source: ABdhPJyxWxWJ37HEkg06FX+1wPZ9qkQd9j4qRCgDIFQw3xeAh2hf5hXyNumTfMW9/TcMz90+FV1Nb67s00bLyjFH55w=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr32370240otd.16.1635961722349;
 Wed, 03 Nov 2021 10:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-3-sakari.ailus@linux.intel.com> <YYLAbVNARsDeJm61@smile.fi.intel.com>
In-Reply-To: <YYLAbVNARsDeJm61@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 18:48:31 +0100
Message-ID: <CAJZ5v0hBy7TUu7eBkqSfQMEH24XsgSvOBQ-QPR4bk4kHumJW3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: Get acpi_device's parent from the parent field
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 6:02 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Nov 03, 2021 at 03:34:05PM +0200, Sakari Ailus wrote:
> > Printk modifier %pfw is used to print the full path of the device name.
> > This is obtained device by device until a device no longer has a parent.
> >
> > On ACPI getting the parent fwnode is done by calling acpi_get_parent()
> > which tries to down() a semaphore. But local IRQs are now disabled in
> > vprintk_store() before the mutex is acquired. This is obviously a problem.
> >
> > Luckily struct acpi_device has a parent field already.

Which I'm going to eliminate, because it is redundant.

The dev object embedded in struct acpi_device has a parent field
pointing to the same object and that one is used by the driver core.

> > Use that field to get the parent instead of relying on acpi_get_parent().
>
> I think the best if Rafael can confirm that we may use it like this.
> If he approved, nothing would stop me to give you
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

In fact, I would prefer the parent field of the dev object embedded in
struct acpi_device to be used and for completeness it should be tested
against NULL unless you know that the parent is not going away ATM.

> > Fixes: 002eb6ad0751 ("printk: track/limit recursion")
> > Cc: stable@vger.kernel.org # v5.15 and up
> > Depends-on: ("ACPI: Make acpi_fwnode_handle safer")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index e312ebaed8db4..7403ee2816eb8 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1089,16 +1089,12 @@ struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
> >       if (is_acpi_data_node(fwnode)) {
> >               /* All data nodes have parent pointer so just return that */
> >               return to_acpi_data_node(fwnode)->parent;
> > -     } else if (is_acpi_device_node(fwnode)) {
> > -             acpi_handle handle, parent_handle;
> > +     }
> >
> > -             handle = to_acpi_device_node(fwnode)->handle;
> > -             if (ACPI_SUCCESS(acpi_get_parent(handle, &parent_handle))) {
> > -                     struct acpi_device *adev;
> > +     if (is_acpi_device_node(fwnode)) {
> > +             struct acpi_device *device = to_acpi_device_node(fwnode);

Call this variable adev please.

> >
> > -                     if (!acpi_bus_get_device(parent_handle, &adev))
> > -                             return acpi_fwnode_handle(adev);
> > -             }
> > +             return acpi_fwnode_handle(device->parent);

And then

             adev = to_acpi_device(&device->dev.parent);
             if (adev)
                          return acpi_fwnode_handle(adev);

> >       }
> >
> >       return NULL;
> > --
> > 2.30.2
> >
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
