Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5C45AB2F
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhKWSVd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:21:33 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:42829 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhKWSVd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:21:33 -0500
Received: by mail-oo1-f45.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so34268ood.9
        for <linux-acpi@vger.kernel.org>; Tue, 23 Nov 2021 10:18:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ODX7zplt597gumrah4EJq+C2+shJVAShDjoHD1puw8=;
        b=CRRpotUjLZdxBQqM2ugeK3jCYWQ2RAihQFQe8QUJ0dr86q0Fg5JREB490pyyfAKrxD
         LObPKL20Ur4Ow+VpAGqf7kRupzjEyAzmp5pkCI2u/HHIaER5peZfPOhh/lD2UZMFtABC
         7dFwkp8j9jnUGYb0Bp40dt9PnEF2B1NcRKzAR2zoeivNk29+qXYPzyr4buC2zZG8OrsC
         ckCX8FG4/Axvl7BV7bogTMie9zKxOCxVIiPOAL5INHl2kkueLWqQkLJc5KW/yx4BETQU
         ClnIyGP674FjeJvbR2qc6wkk2BW7clsmPLAN6HY/S1U7T6w0bubXODDwdwtRPrLMqFko
         ATAw==
X-Gm-Message-State: AOAM530d7wsdh3yc2LzBK7iZS9sG6JVAJIJZ6+pM4oJuwJCOp2UcsnFe
        MIdYjU/zXbelPyXGivzT6qurG+Iz/V6c1gLIBt8=
X-Google-Smtp-Source: ABdhPJw/7s8wSOQyRPodKz9db+FKUZy7z8ILqDZGhvnG/WFWrkh/8q5dRronlVafNnZpHYPfPJ/kPsXBHqK3KVgi0AQ=
X-Received: by 2002:a4a:ead8:: with SMTP id s24mr4416793ooh.89.1637691504715;
 Tue, 23 Nov 2021 10:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20211117180735.3109054-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20211117180735.3109054-1-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Nov 2021 19:18:13 +0100
Message-ID: <CAJZ5v0jAmAAQZ63z4k5=Q4cADwp9Y1c_4EpkU0G6jT6ZAJptYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Get device's parent from parent field, fix
 sleeping IRQs disabled
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 17, 2021 at 7:07 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi all,
>
> This set changes getting fwnode's parent on ACPI fwnode so it no longer
> needs a semaphore, using struct acpi_device.dev.parent field instead of
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
>  __dynamic_pr_debug+0xe2/0x100
>  __v4l2_fwnode_endpoint_parse+0x10c/0x450 [v4l2_fwnode]
>  v4l2_fwnode_endpoint_parse+0x11/0x40 [v4l2_fwnode]
>  cio2_pci_probe.cold+0x7fb/0x969 [ipu3_cio2]
>  ? _raw_spin_unlock_irqrestore+0x42/0x70
>  pci_device_probe+0xb6/0x140
>  really_probe+0x1f5/0x3f0
>  __driver_probe_device+0xfe/0x180
>  driver_probe_device+0x1e/0x90
>  __driver_attach+0xc4/0x1d0
>  ? __device_attach_driver+0xe0/0xe0
>  ? __device_attach_driver+0xe0/0xe0
>  bus_for_each_dev+0x7b/0xc0
>  bus_add_driver+0x14c/0x1f0
>  driver_register+0x8b/0xe0
>  ? 0xffffffffa0428000
>  do_one_initcall+0x5b/0x300
>  ? rcu_read_lock_sched_held+0x12/0x70
>  ? trace_kmalloc+0x29/0xd0
>  ? kmem_cache_alloc_trace+0x11d/0x630
>  do_init_module+0x5c/0x260
>  __do_sys_finit_module+0xae/0x110
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> --------8<------------------------
>
> since v2:
>
> - Move unwrapping the line assigning dev in acpi_node_get_parent() to the
>   first patch.
>
> - Drop removal of a redundant else clause in the first patch.
>
> since v1:
>
> - Drop the patch making acpi_fwnode_handle() NULL-safe.
>
> - Use original %pfw patch on Fixes: line, cc stable beginning from v5.5.
>
> - Get the parent from struct acpi_device.dev.parent, not struct
>   acpi_device.parent.
>
> Sakari Ailus (2):
>   ACPI: Get acpi_device's parent from the parent field
>   ACPI: Make acpi_node_get_parent() local
>
>  drivers/acpi/property.c | 14 +++++---------
>  include/linux/acpi.h    |  7 -------
>  2 files changed, 5 insertions(+), 16 deletions(-)
>
> --

Both [1-2/2] applied as 5.16-rc material, thanks!
