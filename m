Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465D5140C5D
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2020 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgAQOXN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Jan 2020 09:23:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:56284 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQOXJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Jan 2020 09:23:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:23:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="373663006"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 06:23:06 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 4965C20836; Fri, 17 Jan 2020 16:23:04 +0200 (EET)
Date:   Fri, 17 Jan 2020 16:23:04 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 09/12] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20200117142304.GQ5440@paasikivi.fi.intel.com>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
 <20191003123219.11237-10-sakari.ailus@linux.intel.com>
 <20200102222041.GA29067@roeck-us.net>
 <20200103112145.GM19828@paasikivi.fi.intel.com>
 <20200103144253.y6fnw44oe7asyniz@pathway.suse.cz>
 <20200103183555.GA28369@roeck-us.net>
 <20200113091751.d63u7jbyh6p2rj23@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113091751.d63u7jbyh6p2rj23@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Petr,

On Mon, Jan 13, 2020 at 10:17:51AM +0100, Petr Mladek wrote:
> On Fri 2020-01-03 10:35:55, Guenter Roeck wrote:
> > On Fri, Jan 03, 2020 at 03:42:53PM +0100, Petr Mladek wrote:
> > > On Fri 2020-01-03 13:21:45, Sakari Ailus wrote:
> > > > Hi Guenter,
> > > > 
> > > > On Thu, Jan 02, 2020 at 02:20:41PM -0800, Guenter Roeck wrote:
> > > > > Hi,
> > > > > 
> > > > > On Thu, Oct 03, 2019 at 03:32:16PM +0300, Sakari Ailus wrote:
> > > > > > Instead of implementing our own means of discovering parent nodes, node
> > > > > > names or counting how many parents a node has, use the newly added
> > > > > > functions in the fwnode API to obtain that information.
> > > > > > 
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > > > > ---
> > > > > 
> > > > > This patch results in a lockdep splat when running one of my qemu
> > > > > emulations. See below for log and bisect results. A complete log
> > > > > is available at
> > > > > https://kerneltests.org/builders/qemu-arm-master/builds/1408/steps/qemubuildcommand/logs/stdio
> > > > > 
> > > > > Guenter
> > > > 
> > > > Thank you for reporting this.
> > > > 
> > > > I looked into the issue, and indeed I can conform the patch introduces this
> > > > as it takes the devtree_lock for printing the name of the fwnode. There is
> > > 
> > > I guess that you meant "is not".

Right, that's what I meant. Sometimes small words can make a big
difference. :-)

> > > 
> > > 
> > > > however chance of a deadlock in practice as the code in mm/slub.c does not
> > > > deal with fwnodes (in which case acquiring devtree_lock could be possible),
> > > > maybe for other reasons as well. The patch however introduces an unpleasant
> > > > source of such warnings.
> > > 
> > > I agree that it is a false positive. alloc/free is called in OF code
> > > under devtree_lock. But OF code is not called from alloc/free (slub.c)
> > > and it should not happen.
> > > 
> > 
> > Assuming that memory allocation is indeed called from code holding
> > devtree_lock: The problem, as I see it, is that the order of acquiring
> > locks is different. In OF code, the order is
> > 	devtree_lock
> > 	(&n->list_lock)->rlock
> 
> Yes, this happens when alloc is called in OF code under devtree_lock.
> 
> > Elsewhere, in %pOF print sequences, it is
> > 	(&n->list_lock)->rlock
> > 	devtree_lock
> 
> I believe that this order does not exist in reality. lockep "just"
> connected this the two locks via logbuf_lock. When printk() is
> called in the allocator:
> 
> 	(&n->list_lock)->rlock
> 	logbuf_lock
> 
> and when %pOF is used in printk():
> 
> 	logbuf_lock
> 	devtree_lock
> 
> From this two lockdep assumes that it might be possible to
> use %pOF in printk() from allocator code:
> 
> 	(&n->list_lock)->rlock
> 	logbuf_lock
> 	devtree_lock
> 
> But I believe that this does not make sense and never happen reality.
> 
> That said, I would still prefer when %pOF could be implemented
> without the lock. It would make it usable anywhere without any
> risk of deadlock.
> 
> Sakari, what is your opinion, please?

The reason taking that lock is to be able to traverse the device tree data
structure to find the names of the nodes upto the root node. This happens
only when the full node name is printed.

Traversing the tree takes place through the fwnode framework, and currently
the framework uses only the name of the fwnode itself to print the full
path. It *could* use the full name directly, but that way removing the
full_name field (taking up some memory right now) would not be possible.
That said, I don't know if there are plans to do so. A quick look at one
system tells the size of this memory is around 20 kB.

ACPI does not use such locks in traversing to the tree, but it might do
that in the future, and avoiding the lock there would also require copying
the full node name to each node in the system.

If there are plans to avoid having logbuf_lock, then the problem disappears
with that.

How about disabling the lockdep warning now, and if it seems we're not
getting rid of the logbuf_lock in a reasonable timeframe, then look at the
alternatives, such as using the full_name in printing node names instead?

-- 
Kind regards,

Sakari Ailus
