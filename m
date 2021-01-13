Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C996A2F4EC5
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 16:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhAMPat (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 10:30:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:31884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbhAMPat (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 10:30:49 -0500
IronPort-SDR: z5lnRgTOfbn2UGq9yJuYzQLNMikUq1RTtfBVxO9woSAqzH/0nPFBNCCFETCL8K4lvT6yogSoxE
 um/hVgPFdvyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174712314"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="174712314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 07:29:03 -0800
IronPort-SDR: G+To7TD1NwReV8AZ0Ts6sehgbYNwcsAcx12eXhai/LP4jqb2Rq3c0C9EB2kCJjiQA7VTxmNgUK
 vg+5HI5Z6w3Q==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="348854662"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 07:29:01 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kzi5z-00DDhq-FI; Wed, 13 Jan 2021 17:30:03 +0200
Date:   Wed, 13 Jan 2021 17:30:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
Message-ID: <20210113153003.GR4077@smile.fi.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
 <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
 <20210113113918.GA2584629@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113113918.GA2584629@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 13, 2021 at 01:39:18PM +0200, Heikki Krogerus wrote:
> On Wed, Jan 13, 2021 at 12:40:03AM +0000, Daniel Scally wrote:
> > On 11/01/2021 14:10, Heikki Krogerus wrote:

...

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

Actually it's a good question.

> We can't do that here unfortunately. Other places still have a
> reference to the swnode at this point and they may still need to
> access it using the dev_fwnode(dev)->secondary pointer.

Yeah, but in this case we potentially leave a dangling pointer when last of the
user gone and kobject_put() will call for release.

-- 
With Best Regards,
Andy Shevchenko


