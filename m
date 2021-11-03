Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA94443CB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 15:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKCOqm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 10:46:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhKCOql (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 10:46:41 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635950644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQWjT01lt3R0Xv+/aSfAVuO7pydPYL3MBaHFBNwN0sg=;
        b=n7XggwWpmgpMDmt3jqlQKuOkrYL3RO2fi8Jciq5xcN7OD6NwhgKLI2G59/xGCZlzNMwYx6
        y94qFkuv4DAHMCB9+lAe2zKTYTMNL+ysmU5iQ7Gzs9BAU3YclecRUwUYcxOyPfhzNjUCQ4
        ZLspzAWUrnfD12YJ1DrwO9Mzg/QckBDha+eTZKkUJX1wUJ/2xX+NH3EZzDTl5Cwtk/2HLy
        7dUuvZH7uIcnyTficghTb4TJAzCf/2Np+8K18+fI5HYoqXx12VOfo+bMrkM8PyGFx7BiQ2
        UCDdwLLx+3iNB3Lcmf4j8dukFZBT9my5BnaFLB7M+2bjewXNvlkc8qMF+ijhwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635950644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQWjT01lt3R0Xv+/aSfAVuO7pydPYL3MBaHFBNwN0sg=;
        b=Pk0YubPBCoL0xPBiZd3qd9zVREGyEGHtCVTzcYCRrvnLHnypqTqcwQmYY+QvJzwkLswKPd
        9v8ecb//g+N2YpCw==
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, mika.westerberg@linux.intel.com,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 0/3] Get device's parent from parent field, fix sleeping
 IRQs disabled
In-Reply-To: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
Date:   Wed, 03 Nov 2021 15:50:04 +0106
Message-ID: <878ry55mff.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

added CC: printk maintainer (Petr Mladek)

On 2021-11-03, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> This set changes getting fwnode's parent on ACPI fwnode so it no longer
> needs a semaphore, using struct acpi_device->parent field instead of
> calling acpi_get_parent(). The semaphore is being acquired when the
> device's full path is printed which now takes place local IRQs disabled:
>
> --------8<------------------------
> BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163
>
> ...
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x57/0x7d
>  __might_resched.cold+0xf4/0x12f
>  down_timeout+0x21/0x70
>  acpi_os_wait_semaphore+0x63/0x180
>  acpi_ut_acquire_mutex+0x123/0x1ba
>  acpi_get_parent+0x30/0x71
>  acpi_node_get_parent+0x64/0x90
>  ? lock_acquire+0x1a0/0x300
>  fwnode_count_parents+0x6d/0xb0
>  fwnode_full_name_string+0x18/0x90
>  fwnode_string+0xd7/0x140
>  vsnprintf+0x1ec/0x4f0
>  va_format.constprop.0+0x6a/0x130
>  vsnprintf+0x1ec/0x4f0
>  vprintk_store+0x271/0x5a0
>  ? rcu_read_lock_sched_held+0x12/0x70
>  ? lock_release+0x228/0x310
>  ? acpi_initialize_hp_context+0x50/0x50
>  vprintk_emit+0xd5/0x340
>  _printk+0x58/0x6f
...
> --------8<------------------------
>
> I guess one could argue it wasn't great to begin with that getting
> fwnode's parent required a semaphore to begin with, nevertheless John's
> patch made it a concrete problem. Added Cc: stable, too.

Well, before my work it was vprintk_emit() that was disabling local
interrupts. So this has always been broken.

Really it should be:

Fixes: 3bd32d6a2ee6 ("lib/vsprintf: Add %pfw conversion specifier for
printing fwnode names")

Regardless, the fix should go into 5.10 and 5.14 stables.

John Ogness
