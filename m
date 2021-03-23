Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668B346B67
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 22:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhCWVxv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 17:53:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:60340 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233747AbhCWVw4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Mar 2021 17:52:56 -0400
IronPort-SDR: uDIiTSZusj7A2ASwSo1gF1R9x5gXLCWyso5AmMwH9Kzu6/2j9wXOcC1YBTqggwnKlT1czTTekQ
 P2zZzmod4g9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="177695397"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="177695397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 14:52:55 -0700
IronPort-SDR: ZJ5Yk3iJk8rLGTHKpkq9E5xlQLvhNxXaRxUmuPzXq4fLGIa6eVcbSH/mwFwC1jX5jB0cUdogZd
 uRzF5JdiX7Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="604446185"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2021 14:52:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH] ACPICA: Always create namespace nodes using acpi_ns_create_node()
Date:   Tue, 23 Mar 2021 14:20:33 -0700
Message-Id: <20210323212033.2033633-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Vegard Nossum <vegard.nossum@oracle.com>

ACPICA commit 29da9a2a3f5b2c60420893e5c6309a0586d7a329

ACPI is allocating an object using kmalloc(), but then frees it
using kmem_cache_free(<"Acpi-Namespace" kmem_cache>).

This is wrong and can lead to boot failures manifesting like this:

    hpet0: 3 comparators, 64-bit 100.000000 MHz counter
    clocksource: Switched to clocksource tsc-early
    BUG: unable to handle page fault for address: 000000003ffe0018
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0 P4D 0
    Oops: 0000 [#1] SMP PTI
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0+ #211
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
    RIP: 0010:kmem_cache_alloc+0x70/0x1d0
    Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 6f cc e7 7e 4d 8b
20 4d 85 e4 0f 84 3d 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a 01 <49> 8b
   1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
    RSP: 0000:ffffc90000013df8 EFLAGS: 00010206
    RAX: 0000000000000018 RBX: ffffffff81c49200 RCX: 0000000000000002
    RDX: 0000000000000001 RSI: 0000000000000dc0 RDI: 000000000002b300
    RBP: ffff88803e403d00 R08: ffff88803ec2b300 R09: 0000000000000001
    R10: 0000000000000dc0 R11: 0000000000000006 R12: 000000003ffe0000
    R13: ffffffff8110a583 R14: 0000000000000dc0 R15: ffffffff81c49a80
    FS:  0000000000000000(0000) GS:ffff88803ec00000(0000)
knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000000003ffe0018 CR3: 0000000001c0a001 CR4: 00000000003606f0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     __trace_define_field+0x33/0xa0
     event_trace_init+0xeb/0x2b4
     tracer_init_tracefs+0x60/0x195
     ? register_tracer+0x1e7/0x1e7
     do_one_initcall+0x74/0x160
     kernel_init_freeable+0x190/0x1f0
     ? rest_init+0x9a/0x9a
     kernel_init+0x5/0xf6
     ret_from_fork+0x35/0x40
    CR2: 000000003ffe0018
    ---[ end trace 707efa023f2ee960 ]---
    RIP: 0010:kmem_cache_alloc+0x70/0x1d0

Bisection leads to unrelated changes in slab; Vlastimil Babka
suggests an unrelated layout or slab merge change merely exposed
the underlying bug.

Link:
https://lore.kernel.org/lkml/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com/
Link:
https://lore.kernel.org/r/a1461e21-c744-767d-6dfc-6641fd3e3ce2@siemens.com
Debugged-by: Vlastimil Babka <vbabka@suse.cz>
Debugged-by: Kees Cook <keescook@chromium.org>
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Fixes: f79c8e4136eac37255ead8875593ae33a2c16d20 ("ACPICA: Namespace:
simplify creation of the initial/default namespace")

Link: https://github.com/acpica/acpica/commit/29da9a2a
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/nsaccess.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 3f045b5953b2..a0c1a665dfc1 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -99,13 +99,12 @@ acpi_status acpi_ns_root_initialize(void)
 		 * just create and link the new node(s) here.
 		 */
 		new_node =
-		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_namespace_node));
+		    acpi_ns_create_node(*ACPI_CAST_PTR(u32, init_val->name));
 		if (!new_node) {
 			status = AE_NO_MEMORY;
 			goto unlock_and_exit;
 		}
 
-		ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
 		new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
 		new_node->type = init_val->type;
 
-- 
2.29.2

