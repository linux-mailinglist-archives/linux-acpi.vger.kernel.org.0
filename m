Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6374B297130
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750446AbgJWOSj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 10:18:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:19985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750426AbgJWOSi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 10:18:38 -0400
IronPort-SDR: LdIdsxg/i4l+hV2SP0a2+XyDZtebRf5JDFQ6GNM4zWOpFGaf/xxnfueA09x4+v7Q4RfPG069sb
 KGlwrTuGmRBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="166896945"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="166896945"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 07:18:34 -0700
IronPort-SDR: cwYGM98kQmo5KJhfcwDaNOrMZBL+vf98U/ZCNeQQ3f4kytt4mFOOdoehpAusvhwF4KkDJpOjtu
 O9YhvcDtzADg==
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="317104862"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 07:18:31 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVxum-00E8KY-TH; Fri, 23 Oct 2020 17:19:32 +0300
Date:   Fri, 23 Oct 2020 17:19:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] device property: Keep secondary firmware node
 secondary by type
Message-ID: <20201023141932.GW4077@smile.fi.intel.com>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
 <20201023123412.GA614478@kuha.fi.intel.com>
 <ef59c911-8d8b-783a-c756-05123f428302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef59c911-8d8b-783a-c756-05123f428302@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 23, 2020 at 04:03:20PM +0200, Ferry Toth wrote:
> Hi
> 
> Op 23-10-2020 om 14:34 schreef Heikki Krogerus:
> > On Thu, Oct 22, 2020 at 09:40:59PM +0300, Andy Shevchenko wrote:
> > > Behind primary and secondary we understand the type of the nodes
> > > which might define their ordering. However, if primary node gone,
> > > we can't maintain the ordering by definition of the linked list.
> > > Thus, by ordering secondary node becomes first in the list.
> > > But in this case the meaning of it is still secondary (or auxiliary).
> > > The type of the node is maintained by the secondary pointer in it:
> > > 
> > > 	secondary pointer		Meaning
> > > 	NULL or valid			primary node
> > > 	ERR_PTR(-ENODEV)		secondary node
> > > 
> > > So, if by some reason we do the following sequence of calls
> > > 
> > > 	set_primary_fwnode(dev, NULL);
> > > 	set_primary_fwnode(dev, primary);
> > > 
> > > we should preserve secondary node.
> > > 
> > > This concept is supported by the description of set_primary_fwnode()
> > > along with implementation of set_secondary_fwnode(). Hence, fix
> > > the commit c15e1bdda436 to follow this as well.
> > > 
> > > Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
> > > Cc: Ferry Toth <fntoth@gmail.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > FWIW:
> > 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Tested-by: Ferry Toth <fntoth@gmail.com>

The quoting above is broken, I dare to put it below without any quoting.

Tested-by: Ferry Toth <fntoth@gmail.com>

> > > ---
> > >   drivers/base/core.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index c852f16c111b..41feab679fa1 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -4278,7 +4278,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
> > >   	} else {
> > >   		if (fwnode_is_primary(fn)) {
> > >   			dev->fwnode = fn->secondary;
> > > -			fn->secondary = NULL;
> > > +			fn->secondary = ERR_PTR(-ENODEV);
> > >   		} else {
> > >   			dev->fwnode = NULL;
> > >   		}
> > > -- 
> > > 2.28.0

-- 
With Best Regards,
Andy Shevchenko


