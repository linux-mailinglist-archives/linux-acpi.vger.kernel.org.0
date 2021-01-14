Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A52F62A2
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbhANOCa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 09:02:30 -0500
Received: from mga14.intel.com ([192.55.52.115]:64257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhANOCa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 09:02:30 -0500
IronPort-SDR: yxBeRgV46G0OXxt2EuNS1dTJReuZT8BLLDfNU1FQUQ/GgWMn6BxM2/7+chHw1FE/w+CeWZXVw3
 MFxACtLtk8Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="177587528"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177587528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 06:00:44 -0800
IronPort-SDR: YQM+ZwmYxir5mt/GQNL8nFQW8fJzbU/DuBxHPNjaVxDkdqEiwiPFJU8LBRidzr36y7wXpAl3Xn
 YkE//FKZrrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465258899"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Jan 2021 06:00:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 14 Jan 2021 16:00:40 +0200
Date:   Thu, 14 Jan 2021 16:00:40 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
Message-ID: <20210114140040.GB2864731@kuha.fi.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
 <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
 <20210113155504.GS4077@smile.fi.intel.com>
 <20210113155812.GT4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113155812.GT4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 13, 2021 at 05:58:12PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 13, 2021 at 05:55:04PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 13, 2021 at 12:40:03AM +0000, Daniel Scally wrote:
> > > On 11/01/2021 14:10, Heikki Krogerus wrote:
> > 
> > ...
> > 
> > > > +/**
> > > > + * device_remove_software_node - Remove device's software node
> > > > + * @dev: The device with the software node.
> > > > + *
> > > > + * This function will unregister the software node of @dev.
> > > > + */
> > > > +void device_remove_software_node(struct device *dev)
> > > > +{
> > > > +	struct swnode *swnode;
> > > > +
> > > > +	swnode = dev_to_swnode(dev);
> > > > +	if (!swnode)
> > > > +		return;
> > > > +
> > > > +	kobject_put(&swnode->kobj);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(device_remove_software_node);
> > > 
> > > I wonder if this also ought to set dev_fwnode(dev)->secondary back to
> > > ERR_PTR(-ENODEV)?
> > 
> > Looking more into this code I think we need to call
> > 
> > 	set_secondary_fwnode(dev, NULL);
> > 
> > among these lines.
> > 
> > The real problem is that set_primary_fwnode() and set_secondary_fwnode() have
> > no reference counting. If we have a chain ->primary->secondary->-ENODEV is
> > being used somewhere we can't tell from here.
> > 
> > So, in practice it means that we lack of some kind of primary node to increment
> > reference count of the secondary node when the latter is chained to the given
> > primary. But it makes things too complicated. Any other options for shared
> > primary-secondary chain? Standalone primary along with standalone (exclusive)
> > secondary doesn't need this AFAICS. Perhaps a flag to primary like shared /
> > exclusive that will prevent breaking the chain in set_secondary_fwnode()?
> 
> Or maybe I imagined only theoretical cases and we have no such issue?

I think we should really start looking into the possibility of
removing the whole secondary coupling, because that is the thing that
is crippling us.

Br,

-- 
heikki
