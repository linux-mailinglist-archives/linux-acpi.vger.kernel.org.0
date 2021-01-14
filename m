Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF82F6313
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhANO0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 09:26:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:58501 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbhANO0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 09:26:05 -0500
IronPort-SDR: TDMe6LdtLjRGuZ8lKfkYMxJMTrtDJJSVQTW0w9Bw3CKAG8vWc/MU9SKNG+eKxNNbPyDhmvb+V3
 +c5XOCP1MMsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165460677"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="165460677"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 06:24:19 -0800
IronPort-SDR: wjo3JEq5Z7etD61x5dHXSeFHh6gJJdzfdd8jSXbekk17AFuZU32aQSpp8aQeDKH6fHgIo3tbYl
 s4MX/Mzh9VFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="465266602"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Jan 2021 06:24:16 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 14 Jan 2021 16:24:15 +0200
Date:   Thu, 14 Jan 2021 16:24:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
Message-ID: <20210114142415.GC2864731@kuha.fi.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
 <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
 <20210113113918.GA2584629@kuha.fi.intel.com>
 <20210113153003.GR4077@smile.fi.intel.com>
 <20210114131948.GA2864731@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114131948.GA2864731@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2021 at 03:19:52PM +0200, Heikki Krogerus wrote:
> On Wed, Jan 13, 2021 at 05:30:03PM +0200, Andy Shevchenko wrote:
> > On Wed, Jan 13, 2021 at 01:39:18PM +0200, Heikki Krogerus wrote:
> > > On Wed, Jan 13, 2021 at 12:40:03AM +0000, Daniel Scally wrote:
> > > > On 11/01/2021 14:10, Heikki Krogerus wrote:
> > 
> > ...
> > 
> > > > > +/**
> > > > > + * device_remove_software_node - Remove device's software node
> > > > > + * @dev: The device with the software node.
> > > > > + *
> > > > > + * This function will unregister the software node of @dev.
> > > > > + */
> > > > > +void device_remove_software_node(struct device *dev)
> > > > > +{
> > > > > +	struct swnode *swnode;
> > > > > +
> > > > > +	swnode = dev_to_swnode(dev);
> > > > > +	if (!swnode)
> > > > > +		return;
> > > > > +
> > > > > +	kobject_put(&swnode->kobj);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(device_remove_software_node);
> > > > 
> > > > I wonder if this also ought to set dev_fwnode(dev)->secondary back to
> > > > ERR_PTR(-ENODEV)?
> > 
> > Actually it's a good question.
> > 
> > > We can't do that here unfortunately. Other places still have a
> > > reference to the swnode at this point and they may still need to
> > > access it using the dev_fwnode(dev)->secondary pointer.
> > 
> > Yeah, but in this case we potentially leave a dangling pointer when last of the
> > user gone and kobject_put() will call for release.
> 
> The caller has to be responsible of setting the secondary back to
> ERR_PTR(-ENODEV). We can not do anything here like I explained. We can
> not even do that in software_node_notify() when the association to the
> struct device is removed, because the fwnode->secondary is still
> accessed after that. The caller needs to remove both the node and the
> device, and only after that it is safe to set the secondary back to
> ERR_PTR(-ENODEV).

I studied the code again, and it actually looks like this is only a
problem when device_add_properties() is used and there is an
expectation that the node/properties are removed automatically in
device_del().

When this new API is used, the only place that needs to access the
swnode using the secondary pointer is software_node_notify(), so if we
simply handle that separately here, we should be able to clear the
secondary pointer after all. It would look something like this:

        void device_remove_software_node(struct device *dev)
        {
        	struct swnode *swnode;
        
        	swnode = dev_to_swnode(dev);
        	if (!swnode)
        		return;
        
                software_node_notify(dev, KOBJ_REMOVE);
                set_secondary_fwnode(dev, NULL);
        	kobject_put(&swnode->kobj);
        }

I'll test that, and if it works, and you guys don't see any problems
with it, I'll use it in v3.


Br,

-- 
heikki
