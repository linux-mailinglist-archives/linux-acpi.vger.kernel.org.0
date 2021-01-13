Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99642F4A63
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 12:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbhAMLlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 06:41:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:11586 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbhAMLlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 06:41:07 -0500
IronPort-SDR: 0i/DJgzDG2v72HNx/gP4SEJejiEDICLZHB/KkUkUET9U+x6OXX4BvavmY/zXEuj0XG4JoPUmGx
 s+APbaj6DHKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157372307"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="157372307"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 03:39:22 -0800
IronPort-SDR: F4QfWDhQmMVhm/NBOenRV64v/39JG/j8AwMg5wJsMkCr3vaTbrJI8I9ozWX/mELeduZ0GDaAIM
 BGP8qV/wx+OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="464880901"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2021 03:39:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Jan 2021 13:39:18 +0200
Date:   Wed, 13 Jan 2021 13:39:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: Introduce
 device_add_software_node()
Message-ID: <20210113113918.GA2584629@kuha.fi.intel.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <20210111141045.14027-2-heikki.krogerus@linux.intel.com>
 <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f552de5-4839-a1e5-3012-c56f9fa3bdd5@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Wed, Jan 13, 2021 at 12:40:03AM +0000, Daniel Scally wrote:
> Hi Heikki
> 
> On 11/01/2021 14:10, Heikki Krogerus wrote:
> > This helper will register a software node and then assign
> > it to device at the same time. The function will also make
> > sure that the device can't have more than one software node.
> > 
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> 
> I like this change. One comment below, but for what it's worth:
> 
> Reviewed-by: Daniel Scally <djrscally@gmail.com>

Thanks!

> > +/**
> > + * device_remove_software_node - Remove device's software node
> > + * @dev: The device with the software node.
> > + *
> > + * This function will unregister the software node of @dev.
> > + */
> > +void device_remove_software_node(struct device *dev)
> > +{
> > +	struct swnode *swnode;
> > +
> > +	swnode = dev_to_swnode(dev);
> > +	if (!swnode)
> > +		return;
> > +
> > +	kobject_put(&swnode->kobj);
> > +}
> > +EXPORT_SYMBOL_GPL(device_remove_software_node);
> 
> I wonder if this also ought to set dev_fwnode(dev)->secondary back to
> ERR_PTR(-ENODEV)?

We can't do that here unfortunately. Other places still have a
reference to the swnode at this point and they may still need to
access it using the dev_fwnode(dev)->secondary pointer.

-- 
heikki
