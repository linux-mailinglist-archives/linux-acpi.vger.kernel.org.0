Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6A54444EC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 16:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhKCPvr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 11:51:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhKCPvr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 11:51:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C1B3A1FD38;
        Wed,  3 Nov 2021 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635954549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfsSMQ63Ciq0CR8DQZtZN6CvjWxicn8ShNavcOZog8k=;
        b=OXT0vTWDpUESk8U4Wgk46w3pODBVb9kWEAZUc+Oz+TR6ZM37ywxKCUKDnN8Ozm1ZBYLFVm
        jvIYy2hZrEt88+5ALWk0lpz+cr/cVikHdP/kbA8z8Sr2YHsUeYIkPZNQxvEegHWQITmyy1
        W27U8WfE8B3gPPM9/TFHRJM7F0S9nIc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4EC32C144;
        Wed,  3 Nov 2021 15:49:09 +0000 (UTC)
Date:   Wed, 3 Nov 2021 16:49:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/3] Get device's parent from parent field, fix sleeping
 IRQs disabled
Message-ID: <YYKvc2/gfLN/p034@alley>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <878ry55mff.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ry55mff.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

(and really add Andy)

On Wed 2021-11-03 15:50:04, John Ogness wrote:
> added CC: printk maintainer (Petr Mladek)
> 
> On 2021-11-03, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > This set changes getting fwnode's parent on ACPI fwnode so it no longer
> > needs a semaphore, using struct acpi_device->parent field instead of
> > calling acpi_get_parent(). The semaphore is being acquired when the
> > device's full path is printed which now takes place local IRQs disabled:
> >
> > --------8<------------------------
> > BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
> >
> > ...
> >
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x57/0x7d
> >  __might_resched.cold+0xf4/0x12f
> >  down_timeout+0x21/0x70
> >  acpi_os_wait_semaphore+0x63/0x180
> >  acpi_ut_acquire_mutex+0x123/0x1ba
> >  acpi_get_parent+0x30/0x71
> >  acpi_node_get_parent+0x64/0x90
> >  ? lock_acquire+0x1a0/0x300
> >  fwnode_count_parents+0x6d/0xb0
> >  fwnode_full_name_string+0x18/0x90
> >  fwnode_string+0xd7/0x140
> >  vsnprintf+0x1ec/0x4f0
> >  va_format.constprop.0+0x6a/0x130
> >  vsnprintf+0x1ec/0x4f0
> >  vprintk_store+0x271/0x5a0
> >  ? rcu_read_lock_sched_held+0x12/0x70
> >  ? lock_release+0x228/0x310
> >  ? acpi_initialize_hp_context+0x50/0x50
> >  vprintk_emit+0xd5/0x340
> >  _printk+0x58/0x6f
> ...
> > --------8<------------------------
> >
> > I guess one could argue it wasn't great to begin with that getting
> > fwnode's parent required a semaphore to begin with, nevertheless John's
> > patch made it a concrete problem. Added Cc: stable, too.

It looks like a generic problem.

If I get it properly, we should make sure that any struct
fwnode_operations implementation will _not_ use sleeping locks in
the .get_parent() callback. Or anything that is called indirectly
from from vsprintf.

Adding Andy into Cc.

> Well, before my work it was vprintk_emit() that was disabling local
> interrupts. So this has always been broken.
> 
> Really it should be:
> 
> Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for
> printing fwnode names")

Yes, I consider this to be the culprit.

> Regardless, the fix should go into 5.10 and 5.14 stables.

Please add the Fixes tag and the following into the commit message:

Cc: stable@vger.kernel.org # v5.5+

Best Regards,
Petr
