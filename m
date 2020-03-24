Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F621908CA
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCXJN1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 05:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgCXJN0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 05:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AD42070A;
        Tue, 24 Mar 2020 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585041205;
        bh=7HWdrYTEqvWjB6B9X3QdVKUr6q4Frj27zL9SaAhYbG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EeGgix5WWjYKoeZsSBxBjhKziJJUoNHP3m7jAzd4yyufKKXrINLjZNkhSBi6cik0K
         D5SGqRwkoZzW3RxhFVOdRrSQa1TXHt155uLgbFnX/Vzo9TcFdHVvcbBLDFK2LJRX9Y
         CM0xaUFp/FXMNtejXt0/oJuZc06O7IYVHBp5M11U=
Date:   Tue, 24 Mar 2020 10:13:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: Add ACPI support for USB interfaces
Message-ID: <20200324091321.GA2137714@kroah.com>
References: <20200323195543.51050-1-andriy.shevchenko@linux.intel.com>
 <20200324062635.GB1977781@kroah.com>
 <20200324090037.GB1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324090037.GB1922688@smile.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2020 at 11:00:37AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 24, 2020 at 07:26:35AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 23, 2020 at 09:55:43PM +0200, Andy Shevchenko wrote:
> > > The ACPI companion of the device has to be set for USB interfaces
> > > in order to read and attach the properties described in the ACPI table.
> > > Use ACPI_COMPANION_SET macro to set this.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/usb/core/message.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > > index 5adf489428aa..d5f834f16993 100644
> > > --- a/drivers/usb/core/message.c
> > > +++ b/drivers/usb/core/message.c
> > > @@ -5,6 +5,7 @@
> > >   * Released under the GPLv2 only.
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/pci.h>	/* for scatterlist macros */
> > >  #include <linux/usb.h>
> > >  #include <linux/module.h>
> > > @@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> > >  			intf->dev.of_node = usb_of_get_interface_node(dev,
> > >  					configuration, ifnum);
> > >  		}
> > > +		ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
> > >  		intf->dev.driver = NULL;
> > >  		intf->dev.bus = &usb_bus_type;
> > >  		intf->dev.type = &usb_if_device_type;
> > 
> 
> > And what does this "fix"?
> 
> It links the firmware node of physical USB device to USB interface.
> Otherwise it will be no firmware nodes under a corresponding folder.
> 
> It mimics what is done for OF in couple of lines above.
> 
> > Is this a new feature, what isn't working today without this change?
> 
> Yes, it is a new feature. I can't tell it fixes anything, because no complains
> so far. I doubt it previously works.
> 
> > And if it is a fix, should it be backported to older kernels, how far?
> 
> No, no need for that. Usually I put Fixes tag when I would like change to be
> considered for backporting.
> 
> I'll probably update the commit message to clarify all this. Would it be enough?

Please do so, what you have now is insufficient :)

thanks,

greg k-h
