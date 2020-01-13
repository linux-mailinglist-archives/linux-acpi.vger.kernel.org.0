Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80946138D88
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2020 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgAMJR5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jan 2020 04:17:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:37746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgAMJR5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jan 2020 04:17:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAFC8B00A;
        Mon, 13 Jan 2020 09:17:53 +0000 (UTC)
Date:   Mon, 13 Jan 2020 10:17:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 09/12] lib/vsprintf: Make use of fwnode API to obtain
 node names and separators
Message-ID: <20200113091751.d63u7jbyh6p2rj23@pathway.suse.cz>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
 <20191003123219.11237-10-sakari.ailus@linux.intel.com>
 <20200102222041.GA29067@roeck-us.net>
 <20200103112145.GM19828@paasikivi.fi.intel.com>
 <20200103144253.y6fnw44oe7asyniz@pathway.suse.cz>
 <20200103183555.GA28369@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103183555.GA28369@roeck-us.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri 2020-01-03 10:35:55, Guenter Roeck wrote:
> On Fri, Jan 03, 2020 at 03:42:53PM +0100, Petr Mladek wrote:
> > On Fri 2020-01-03 13:21:45, Sakari Ailus wrote:
> > > Hi Guenter,
> > > 
> > > On Thu, Jan 02, 2020 at 02:20:41PM -0800, Guenter Roeck wrote:
> > > > Hi,
> > > > 
> > > > On Thu, Oct 03, 2019 at 03:32:16PM +0300, Sakari Ailus wrote:
> > > > > Instead of implementing our own means of discovering parent nodes, node
> > > > > names or counting how many parents a node has, use the newly added
> > > > > functions in the fwnode API to obtain that information.
> > > > > 
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > > > ---
> > > > 
> > > > This patch results in a lockdep splat when running one of my qemu
> > > > emulations. See below for log and bisect results. A complete log
> > > > is available at
> > > > https://kerneltests.org/builders/qemu-arm-master/builds/1408/steps/qemubuildcommand/logs/stdio
> > > > 
> > > > Guenter
> > > 
> > > Thank you for reporting this.
> > > 
> > > I looked into the issue, and indeed I can conform the patch introduces this
> > > as it takes the devtree_lock for printing the name of the fwnode. There is
> > 
> > I guess that you meant "is not".
> > 
> > 
> > > however chance of a deadlock in practice as the code in mm/slub.c does not
> > > deal with fwnodes (in which case acquiring devtree_lock could be possible),
> > > maybe for other reasons as well. The patch however introduces an unpleasant
> > > source of such warnings.
> > 
> > I agree that it is a false positive. alloc/free is called in OF code
> > under devtree_lock. But OF code is not called from alloc/free (slub.c)
> > and it should not happen.
> > 
> 
> Assuming that memory allocation is indeed called from code holding
> devtree_lock: The problem, as I see it, is that the order of acquiring
> locks is different. In OF code, the order is
> 	devtree_lock
> 	(&n->list_lock)->rlock

Yes, this happens when alloc is called in OF code under devtree_lock.

> Elsewhere, in %pOF print sequences, it is
> 	(&n->list_lock)->rlock
> 	devtree_lock

I believe that this order does not exist in reality. lockep "just"
connected this the two locks via logbuf_lock. When printk() is
called in the allocator:

	(&n->list_lock)->rlock
	logbuf_lock

and when %pOF is used in printk():

	logbuf_lock
	devtree_lock

From this two lockdep assumes that it might be possible to
use %pOF in printk() from allocator code:

	(&n->list_lock)->rlock
	logbuf_lock
	devtree_lock

But I believe that this does not make sense and never happen reality.

That said, I would still prefer when %pOF could be implemented
without the lock. It would make it usable anywhere without any
risk of deadlock.

Sakari, what is your opinion, please?

Best Regards,
Petr
