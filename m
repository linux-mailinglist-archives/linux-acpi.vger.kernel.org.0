Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F04446D4
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhKCRTd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:19:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:53002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhKCRTc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:19:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="211602890"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="211602890"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:07:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="501172609"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:07:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miJjF-003K4I-P2;
        Wed, 03 Nov 2021 19:07:13 +0200
Date:   Wed, 3 Nov 2021 19:07:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH 0/3] Get device's parent from parent field, fix sleeping
 IRQs disabled
Message-ID: <YYLBwX3HN2pT6ZkD@smile.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <878ry55mff.fsf@jogness.linutronix.de>
 <YYKvIPp6BEMXBJZs@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYKvIPp6BEMXBJZs@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 04:47:44PM +0100, Petr Mladek wrote:
> On Wed 2021-11-03 15:50:04, John Ogness wrote:
> > On 2021-11-03, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > > This set changes getting fwnode's parent on ACPI fwnode so it no longer
> > > needs a semaphore, using struct acpi_device->parent field instead of
> > > calling acpi_get_parent(). The semaphore is being acquired when the
> > > device's full path is printed which now takes place local IRQs disabled:
> > >
> > > --------8<------------------------
> > > BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
> > >
> > > ...
> > >
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x57/0x7d
> > >  __might_resched.cold+0xf4/0x12f
> > >  down_timeout+0x21/0x70
> > >  acpi_os_wait_semaphore+0x63/0x180
> > >  acpi_ut_acquire_mutex+0x123/0x1ba
> > >  acpi_get_parent+0x30/0x71
> > >  acpi_node_get_parent+0x64/0x90
> > >  ? lock_acquire+0x1a0/0x300
> > >  fwnode_count_parents+0x6d/0xb0
> > >  fwnode_full_name_string+0x18/0x90
> > >  fwnode_string+0xd7/0x140
> > >  vsnprintf+0x1ec/0x4f0
> > >  va_format.constprop.0+0x6a/0x130
> > >  vsnprintf+0x1ec/0x4f0
> > >  vprintk_store+0x271/0x5a0
> > >  ? rcu_read_lock_sched_held+0x12/0x70
> > >  ? lock_release+0x228/0x310
> > >  ? acpi_initialize_hp_context+0x50/0x50
> > >  vprintk_emit+0xd5/0x340
> > >  _printk+0x58/0x6f
> > ...
> > > --------8<------------------------
> > >
> > > I guess one could argue it wasn't great to begin with that getting
> > > fwnode's parent required a semaphore to begin with, nevertheless John's
> > > patch made it a concrete problem. Added Cc: stable, too.
> 
> It looks like a generic problem.
> 
> If I get it properly, we should make sure that any struct
> fwnode_operations implementation will _not_ use sleeping locks in
> the .get_parent() callback. Or anything that is called indirectly
> from from vsprintf.

Not sure how I may help here, but if there is a requirement to all *printf()
to be non-sleepable, then yes, this should be done in that way. I'm not sure
if every single %p extension does this...

It may require to update fwnode (source code) documentation to reflect the
requirement. Also might_sleep() / migth_sleep_if() in the API calls may
shed a light on (potential) issues.

-- 
With Best Regards,
Andy Shevchenko


