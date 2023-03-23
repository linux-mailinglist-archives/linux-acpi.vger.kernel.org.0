Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3454B6C6DF1
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Mar 2023 17:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCWQmv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Mar 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCWQmh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2023 12:42:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E522B60D;
        Thu, 23 Mar 2023 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679589618; x=1711125618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QnRaJIF3EpOb8hSEiYlIAUUJVc3HnkQOIqPjAmEqYKY=;
  b=gLz28SjhdADxMmrWTwlUtPeKUIjyewnYCRdmmgzX9TKMydBIf69emfN+
   GbMPy2xKh/uHQLHh5h9T+llBD0sm9pRMNLF0CAn6B52AvJCU0tM8Sk/9I
   tZGx3YIze8lSRuLAe9bVy9Fs82uD0kZmD7SrhjGA4W/yQBZ8/LeFEDiVq
   lvNq1OdrZBpwLOOAwk8PBkb3aGaqqAv1hzSGEKQdJnGdqGBBKvUWSyPbE
   /6AGN1Yp97txUEYOyq0LpLZYlaClzUJAs6KPxoJ+vbaG/4XLNzGH+0IXu
   bM7AUVxICRxQ0FKRAgqKvG4K9Wp/lcwKRHV++c1q+fUpDhC5x4Sva4G/c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339585564"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="339585564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682371092"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="682371092"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2023 09:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfNyg-007Zsq-33;
        Thu, 23 Mar 2023 18:39:50 +0200
Date:   Thu, 23 Mar 2023 18:39:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 3/7] net: dsa: use fwnode_get_phy_mode() to
 get phy interface mode
Message-ID: <ZByA1jZybGE6MXkc@smile.fi.intel.com>
References: <ZBrtqPW29NnxVoEc@shell.armlinux.org.uk>
 <E1pex8Q-00Dvnr-5y@rmk-PC.armlinux.org.uk>
 <ZBxcGXSVe0dlzKZb@smile.fi.intel.com>
 <ZBxiqJo470A7bkig@shell.armlinux.org.uk>
 <ZBxkZYXrfugz0gYw@smile.fi.intel.com>
 <ZBxm3XrQAfnmbHoF@shell.armlinux.org.uk>
 <ZBxpeLOmTMzqVTRV@smile.fi.intel.com>
 <ZBxu4FvyO2JDwmMq@shell.armlinux.org.uk>
 <ZBx7xxs0NQV25cFn@shell.armlinux.org.uk>
 <ZBx/mO/z3t3dQCAx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBx/mO/z3t3dQCAx@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 23, 2023 at 06:34:32PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 23, 2023 at 04:18:15PM +0000, Russell King (Oracle) wrote:
> > On Thu, Mar 23, 2023 at 03:23:12PM +0000, Russell King (Oracle) wrote:
> > > On Thu, Mar 23, 2023 at 05:00:08PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 23, 2023 at 02:49:01PM +0000, Russell King (Oracle) wrote:
> > > > > On Thu, Mar 23, 2023 at 04:38:29PM +0200, Andy Shevchenko wrote:
> > > > > > Do you modify its content on the fly?
> > > > > 
> > > > > Do you want to litter code with casts to get rid of the const?
> > > > > 
> > > > > > For fwnode as a basic object type we want to reduce the scope of the possible
> > > > > > modifications. If you don't modify and APIs you call do not require non-const
> > > > > > object, use const for fwnode.
> > > > > 
> > > > > Let's start here. We pass this fwnode to fwnode_get_phy_mode():
> > > > > 
> > > > > include/linux/property.h:int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
> > > > > 
> > > > > Does fwnode_get_phy_mode() alter the contents of the fwnode? Probably
> > > > > not, but it doesn't take a const pointer. Therefore, to declare my
> > > > > fwnode as const, I'd need to cast the const-ness away before calling
> > > > > this.
> > > > 
> > > > So, fix the fwnode_get_phy_mode(). Is it a problem?
> > > 
> > > No, I refuse. That's for a different patch set.
> > > 
> > > > > Then there's phylink_create(). Same problem.
> > > > 
> > > > So, fix that. Is it a problem?
> > > 
> > > No for the same reason.
> > > 
> > > > > So NAK to this const - until such time that we have a concerted effort
> > > > > to making functions we call which do not modify the "fwnode" argument
> > > > > constify that argument. Otherwise it's just rediculously crazy to
> > > > > declare a variable const only to then litter the code with casts to get
> > > > > rid of it at every call site.
> > > > > 
> > > > > Please do a bit of research before making suggestions. Thanks.
> > > > 
> > > > So, MAK to your patch. You can fix that, and you know that.
> > > 
> > > Sorry, I don't accept your NAK. While you have a valid point about
> > > these things being const, that is not the fault of this patch series,
> > > and is something that should be addressed separately.
> > > 
> > > The lack of const-ness that has been there for quite some time is no
> > > reason to NAK a patch that has nothing to do with this.
> > 
> > To illustrate how rediculous this is:
> 
> It's not. But does it make difference?
> 
> > $ git grep 'struct fwnode_handle \*.*='
> > 
> > gives 134 instances. Of those, only five are const, which means 129
> > aren't. So I question - why are you singling mine out for what appears
> > to be special treatment.
> > 
> > 
> > Let's look at other parts of the fwnode API.
> > 
> > void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
> > 
> > Does that modify the fwnode it was passed? It calls:
> > 
> >         void __iomem *(*iomap)(struct fwnode_handle *fwnode, int index);
> > 
> > in struct fwnode_operations, so that would need to be made const as well.
> > The only implementation of that which I can find is of_fwnode_iomap()
> > which uses to_of_node() on that, which casts away the const-ness. So
> > this would be a candidate to making const.
> 
> Correct.
> 
> > bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child);
> > 
> > I'd be surprised if that modifies either of those fwnodes.

> It does. Now your time to be surprised.

Oops, I put it into a wrong place. The above does not touch them, but...

> > It seems
> > to use fwnode_for_each_parent_node() from the child, which passes
> > "child" to fwnode_get_parent(),

...this one touches.

> >	which itself is const. Therefore, it
> > seems there's no reason not to make "child" const. "ancestor" can
> > also be made const since it's only being used for pointer-compares.
> 
> All getters return _different_ fwnode which is not const due to modification
> of the _returned_ fwnode.
> 
> Do a bit of investigation, please. Thanks.
> 
> > unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
> >                                              unsigned long flags);
> > 
> > Similar story with this, although it uses
> > fwnode_graph_for_each_endpoint(), which seems to mean that "fwnode"
> > can also be const.
> 
> Correct.
> 
> > My point is that there are several things in the fwnode API that
> > should be made const but that aren't, but which should likely be
> > fixed before requiring const-ness of those fwnode_handle
> > declarations in people's code.
> 
> OK.
> 
> I started doing something about this as you may easily check with `git log`.
> Now, instead of playing a good citizen of the community you are trying to
> diminish the others' asks.
> 
> I think the further continuation of this discussion doesn't make much sense.
> But thank you for your opinion.

-- 
With Best Regards,
Andy Shevchenko


