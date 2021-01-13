Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA76D2F4F51
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAMP65 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 10:58:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:33998 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbhAMP65 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:58:57 -0500
IronPort-SDR: +t8qwMsc5xqYIPUVp0Hj1ZxPGExmQyF8zgd9LhIPppku6i5Y6IuFVg01fZgZ7UnPBlKzqT3+3B
 cWuRF+QBe0Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175644305"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="175644305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 07:57:12 -0800
IronPort-SDR: lbQWPZXLqGsSDf80WJjQnGlG4PZX+1GPvq2xE5EDCSui6aPj6gTkiWSREJWdBaFpKfFLLXOeuc
 BEPmhtzGcZqw==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="499305220"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 07:57:10 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kziXE-00DFLl-9v; Wed, 13 Jan 2021 17:58:12 +0200
Date:   Wed, 13 Jan 2021 17:58:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
Message-ID: <20210113155812.GT4077@smile.fi.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
 <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
 <20210113155504.GS4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113155504.GS4077@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 13, 2021 at 05:55:04PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 13, 2021 at 12:40:03AM +0000, Daniel Scally wrote:
> > On 11/01/2021 14:10, Heikki Krogerus wrote:
> 
> ...
> 
> > > +/**
> > > + * device_remove_software_node - Remove device's software node
> > > + * @dev: The device with the software node.
> > > + *
> > > + * This function will unregister the software node of @dev.
> > > + */
> > > +void device_remove_software_node(struct device *dev)
> > > +{
> > > +	struct swnode *swnode;
> > > +
> > > +	swnode = dev_to_swnode(dev);
> > > +	if (!swnode)
> > > +		return;
> > > +
> > > +	kobject_put(&swnode->kobj);
> > > +}
> > > +EXPORT_SYMBOL_GPL(device_remove_software_node);
> > 
> > I wonder if this also ought to set dev_fwnode(dev)->secondary back to
> > ERR_PTR(-ENODEV)?
> 
> Looking more into this code I think we need to call
> 
> 	set_secondary_fwnode(dev, NULL);
> 
> among these lines.
> 
> The real problem is that set_primary_fwnode() and set_secondary_fwnode() have
> no reference counting. If we have a chain ->primary->secondary->-ENODEV is
> being used somewhere we can't tell from here.
> 
> So, in practice it means that we lack of some kind of primary node to increment
> reference count of the secondary node when the latter is chained to the given
> primary. But it makes things too complicated. Any other options for shared
> primary-secondary chain? Standalone primary along with standalone (exclusive)
> secondary doesn't need this AFAICS. Perhaps a flag to primary like shared /
> exclusive that will prevent breaking the chain in set_secondary_fwnode()?

Or maybe I imagined only theoretical cases and we have no such issue?

-- 
With Best Regards,
Andy Shevchenko


