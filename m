Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5A4DE0D2
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 19:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiCRSOt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiCRSOt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 14:14:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB014939DC;
        Fri, 18 Mar 2022 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647627210; x=1679163210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZcLZFns2cmqmUDYsf79yEaH3pnYex27zE67UUmjrAQU=;
  b=PrPujoHJH+SZDrMGogNvPpMufkdHurjQmdh0x5c7p3hAGzTYo4vxwJmR
   Gi6DUuujeBg3g2ZqI3gAfNSbBbOgAPoMeIeUfrYe927nYbnIfMBjg8t8M
   04oqWCVHCuKPLY8qeSbXWBe8zh+sxdoKrGDqw64wbF5gQ5AzWDSxnkRp8
   lya8WF9j0LBhfMp1Bplr+2Y4NzlFROgjmPSgBBtZxuPY4/Fr4bNBeRHJu
   9OuKQvvecB3u0hBKsv/fpjAK0g6vQWPOebT5ucNFetRxIw67flhFYI7mV
   xMavr6svoQILCavL3sDUpRsARds2iIko7otmdQ343WSNOTJ3LkVhtKcoM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="256920621"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256920621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:10:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558577638"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:10:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVH2f-002Npa-DH;
        Fri, 18 Mar 2022 20:09:37 +0200
Date:   Fri, 18 Mar 2022 20:09:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "'Rafael J . Wysocki '" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/6] property: add fwnode_property_read_string_index()
Message-ID: <YjTK4UW7DwZ0S3QY@smile.fi.intel.com>
References: <20220318160059.328208-1-clement.leger@bootlin.com>
 <20220318160059.328208-2-clement.leger@bootlin.com>
 <YjSymEpNH8vnkQ+L@smile.fi.intel.com>
 <20220318174912.5759095f@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318174912.5759095f@fixe.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 18, 2022 at 05:49:12PM +0100, Cl�ment L�ger wrote:
> Le Fri, 18 Mar 2022 18:26:00 +0200,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> a �crit :
> > On Fri, Mar 18, 2022 at 05:00:47PM +0100, Cl�ment L�ger wrote:
> > > Add fwnode_property_read_string_index() function which allows to
> > > retrieve a string from an array by its index. This function is the
> > > equivalent of of_property_read_string_index() but for fwnode support.  

...

> > > +	values = kcalloc(nval, sizeof(*values), GFP_KERNEL);
> > > +	if (!values)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = fwnode_property_read_string_array(fwnode, propname, values, nval);
> > > +	if (ret < 0)
> > > +		goto out;
> > > +
> > > +	*string = values[index];
> > > +out:
> > > +	kfree(values);  
> > 
> > Here is UAF (use after free). How is it supposed to work?
> 
> values is an array of pointers. I'm only retrieving a pointer out of
> it.

I see, thanks for pointing out.

Nevertheless, I don't like the idea of allocating memory in this case.
Can we rather add a new callback that will provide us the necessary
property directly?

-- 
With Best Regards,
Andy Shevchenko


