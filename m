Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E4A444276
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 14:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKCNgc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 09:36:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:11312 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbhKCNgc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 09:36:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="255121445"
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="255121445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:48 -0700
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="450066068"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 06:33:47 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 1AB4C204C0;
        Wed,  3 Nov 2021 15:33:45 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1miGP0-002lac-Je; Wed, 03 Nov 2021 15:34:06 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH 0/3] Get device's parent from parent field, fix sleeping IRQs disabled
Date:   Wed,  3 Nov 2021 15:34:03 +0200
Message-Id: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This set changes getting fwnode's parent on ACPI fwnode so it no longer
needs a semaphore, using struct acpi_device->parent field instead of
calling acpi_get_parent(). The semaphore is being acquired when the
device's full path is printed which now takes place local IRQs disabled:

--------8<------------------------
BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:163

...

Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x7d
 __might_resched.cold+0xf4/0x12f
 down_timeout+0x21/0x70
 acpi_os_wait_semaphore+0x63/0x180
 acpi_ut_acquire_mutex+0x123/0x1ba
 acpi_get_parent+0x30/0x71
 acpi_node_get_parent+0x64/0x90
 ? lock_acquire+0x1a0/0x300
 fwnode_count_parents+0x6d/0xb0
 fwnode_full_name_string+0x18/0x90
 fwnode_string+0xd7/0x140
 vsnprintf+0x1ec/0x4f0
 va_format.constprop.0+0x6a/0x130
 vsnprintf+0x1ec/0x4f0
 vprintk_store+0x271/0x5a0
 ? rcu_read_lock_sched_held+0x12/0x70
 ? lock_release+0x228/0x310
 ? acpi_initialize_hp_context+0x50/0x50
 vprintk_emit+0xd5/0x340
 _printk+0x58/0x6f
 __dynamic_pr_debug+0xe2/0x100
 __v4l2_fwnode_endpoint_parse+0x10c/0x450 [v4l2_fwnode]
 v4l2_fwnode_endpoint_parse+0x11/0x40 [v4l2_fwnode]
 cio2_pci_probe.cold+0x7fb/0x969 [ipu3_cio2]
 ? _raw_spin_unlock_irqrestore+0x42/0x70
 pci_device_probe+0xb6/0x140
 really_probe+0x1f5/0x3f0
 __driver_probe_device+0xfe/0x180
 driver_probe_device+0x1e/0x90
 __driver_attach+0xc4/0x1d0
 ? __device_attach_driver+0xe0/0xe0
 ? __device_attach_driver+0xe0/0xe0
 bus_for_each_dev+0x7b/0xc0
 bus_add_driver+0x14c/0x1f0
 driver_register+0x8b/0xe0
 ? 0xffffffffa0428000
 do_one_initcall+0x5b/0x300
 ? rcu_read_lock_sched_held+0x12/0x70
 ? trace_kmalloc+0x29/0xd0
 ? kmem_cache_alloc_trace+0x11d/0x630
 do_init_module+0x5c/0x260
 __do_sys_finit_module+0xae/0x110
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
--------8<------------------------

I guess one could argue it wasn't great to begin with that getting
fwnode's parent required a semaphore to begin with, nevertheless John's
patch made it a concrete problem. Added Cc: stable, too.

Sakari Ailus (3):
  ACPI: Make acpi_fwnode_handle safer
  ACPI: Get acpi_device's parent from the parent field
  ACPI: Make acpi_node_get_parent() local

 drivers/acpi/property.c | 15 ++++++---------
 include/acpi/acpi_bus.h |  2 +-
 include/linux/acpi.h    |  7 -------
 3 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.30.2

