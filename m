Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E53D190864
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCXJAh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 05:00:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:20966 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgCXJAh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 05:00:37 -0400
IronPort-SDR: qnkRrk8dRVN+G537O+kvzZIABLND26NrsQ0navDd75kGe74ERGCgMVKXjJNNO11aHPuQVczmtC
 rnRCFNueKk1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 02:00:36 -0700
IronPort-SDR: vpnLhlvTmPW7k2IFJ/gjiBq0FDDSH0EkGkar9BCsBrlGEISbGHJUdqwQDU1DWRfYHXEnEydqxP
 21CYrVmCZVqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="393216216"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2020 02:00:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jGfQL-00CU45-N9; Tue, 24 Mar 2020 11:00:37 +0200
Date:   Tue, 24 Mar 2020 11:00:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: Add ACPI support for USB interfaces
Message-ID: <20200324090037.GB1922688@smile.fi.intel.com>
References: <20200323195543.51050-1-andriy.shevchenko@linux.intel.com>
 <20200324062635.GB1977781@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324062635.GB1977781@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2020 at 07:26:35AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 23, 2020 at 09:55:43PM +0200, Andy Shevchenko wrote:
> > The ACPI companion of the device has to be set for USB interfaces
> > in order to read and attach the properties described in the ACPI table.
> > Use ACPI_COMPANION_SET macro to set this.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/usb/core/message.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> > index 5adf489428aa..d5f834f16993 100644
> > --- a/drivers/usb/core/message.c
> > +++ b/drivers/usb/core/message.c
> > @@ -5,6 +5,7 @@
> >   * Released under the GPLv2 only.
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/pci.h>	/* for scatterlist macros */
> >  #include <linux/usb.h>
> >  #include <linux/module.h>
> > @@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
> >  			intf->dev.of_node = usb_of_get_interface_node(dev,
> >  					configuration, ifnum);
> >  		}
> > +		ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
> >  		intf->dev.driver = NULL;
> >  		intf->dev.bus = &usb_bus_type;
> >  		intf->dev.type = &usb_if_device_type;
> 

> And what does this "fix"?

It links the firmware node of physical USB device to USB interface.
Otherwise it will be no firmware nodes under a corresponding folder.

It mimics what is done for OF in couple of lines above.

> Is this a new feature, what isn't working today without this change?

Yes, it is a new feature. I can't tell it fixes anything, because no complains
so far. I doubt it previously works.

> And if it is a fix, should it be backported to older kernels, how far?

No, no need for that. Usually I put Fixes tag when I would like change to be
considered for backporting.

I'll probably update the commit message to clarify all this. Would it be enough?

-- 
With Best Regards,
Andy Shevchenko


