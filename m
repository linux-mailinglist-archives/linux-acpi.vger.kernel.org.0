Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42539313E67
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhBHTDU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:03:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64290 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbhBHTA5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 14:00:57 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 201b9415583dcdc8; Mon, 8 Feb 2021 20:00:04 +0100
Received: from kreacher.localnet (89-64-80-68.dynamic.chello.pl [89.64.80.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1F95D6608B1;
        Mon,  8 Feb 2021 20:00:04 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v1 2/2] ACPI: OSL: Clean up printing messages
Date:   Mon, 08 Feb 2021 19:59:57 +0100
Message-ID: <3297462.0emgCRZMdL@kreacher>
In-Reply-To: <4653881.kBYL0eE9gL@kreacher>
References: <4653881.kBYL0eE9gL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddtgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfelheffhfetffelhfelteejffetteetgfetkeejvdfhfeeftdeufeevgeevieevnecukfhppeekledrieegrdektddrieeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeikedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgohhuhhgrnhhjuhhnsehhuhgrfigvihdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the ACPI_DEBUG_PRINT() instance in osl.c unrelated to the
ACPICA debug with acpi_handle_debug(), add a pr_fmt() definition
to osl.c and replace direct printk() usage in that file with the
suitable pr_*() calls.

While at it, add a physical address value to the message in
acpi_os_map_iomem() and reword a couple of messages to avoid
using function names in them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -9,6 +9,8 @@
  *   Author: Matthew Wilcox <willy@linux.intel.com>
  */
 
+#define pr_fmt(fmt) "ACPI: OSL: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -37,6 +39,7 @@
 #include "acpica/acnamesp.h"
 #include "internal.h"
 
+/* Definitions for ACPI_DEBUG_PRINT() */
 #define _COMPONENT		ACPI_OS_SERVICES
 ACPI_MODULE_NAME("osl");
 
@@ -327,7 +330,7 @@ void __iomem __ref
 	acpi_size pg_sz;
 
 	if (phys > ULONG_MAX) {
-		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
+		pr_err("Cannot map memory that high: 0x%llx\n", phys);
 		return NULL;
 	}
 
@@ -528,13 +531,13 @@ acpi_os_predefined_override(const struct
 
 	*new_val = NULL;
 	if (!memcmp(init_val->name, "_OS_", 4) && strlen(acpi_os_name)) {
-		printk(KERN_INFO PREFIX "Overriding _OS definition to '%s'\n",
+		pr_info("Overriding _OS definition to '%s'\n",
 		       acpi_os_name);
 		*new_val = acpi_os_name;
 	}
 
 	if (!memcmp(init_val->name, "_REV", 4) && acpi_rev_override) {
-		printk(KERN_INFO PREFIX "Overriding _REV return value to 5\n");
+		pr_info("Overriding _REV return value to 5\n");
 		*new_val = (char *)5;
 	}
 
@@ -575,7 +578,7 @@ acpi_os_install_interrupt_handler(u32 gs
 		return AE_ALREADY_ACQUIRED;
 
 	if (acpi_gsi_to_irq(gsi, &irq) < 0) {
-		printk(KERN_ERR PREFIX "SCI (ACPI GSI %d) not registered\n",
+		pr_err("SCI (ACPI GSI %d) not registered\n",
 		       gsi);
 		return AE_OK;
 	}
@@ -583,7 +586,7 @@ acpi_os_install_interrupt_handler(u32 gs
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
 	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
-		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
+		pr_err("SCI (IRQ%d) allocation failed\n", irq);
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
 	}
@@ -1071,7 +1074,7 @@ acpi_status acpi_os_execute(acpi_execute
 	if (type == OSL_DEBUGGER_MAIN_THREAD) {
 		ret = acpi_debugger_create_thread(function, context);
 		if (ret) {
-			pr_err("Call to kthread_create() failed.\n");
+			pr_err("Kernel thread creation failed\n");
 			status = AE_ERROR;
 		}
 		goto out_thread;
@@ -1121,8 +1124,7 @@ acpi_status acpi_os_execute(acpi_execute
 	 */
 	ret = queue_work_on(0, queue, &dpc->work);
 	if (!ret) {
-		printk(KERN_ERR PREFIX
-			  "Call to queue_work() failed.\n");
+		pr_err("Unable to queue work\n");
 		status = AE_ERROR;
 	}
 err_workqueue:
@@ -1165,9 +1167,9 @@ acpi_status acpi_hotplug_schedule(struct
 {
 	struct acpi_hp_work *hpw;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-		  "Scheduling hotplug event (%p, %u) for deferred execution.\n",
-		  adev, src));
+	acpi_handle_debug(adev->handle,
+			  "Scheduling hotplug event %u for deferred handling\n",
+			   src);
 
 	hpw = kmalloc(sizeof(*hpw), GFP_KERNEL);
 	if (!hpw)
@@ -1355,7 +1357,7 @@ acpi_status acpi_os_signal(u32 function,
 {
 	switch (function) {
 	case ACPI_SIGNAL_FATAL:
-		printk(KERN_ERR PREFIX "Fatal opcode executed\n");
+		pr_err("Fatal opcode executed\n");
 		break;
 	case ACPI_SIGNAL_BREAKPOINT:
 		/*
@@ -1407,7 +1409,7 @@ __setup("acpi_os_name=", acpi_os_name_se
 static int __init acpi_no_auto_serialize_setup(char *str)
 {
 	acpi_gbl_auto_serialize_methods = FALSE;
-	pr_info("ACPI: auto-serialization disabled\n");
+	pr_info("Auto-serialization disabled\n");
 
 	return 1;
 }
@@ -1712,7 +1714,7 @@ acpi_status acpi_os_release_object(acpi_
 static int __init acpi_no_static_ssdt_setup(char *s)
 {
 	acpi_gbl_disable_ssdt_table_install = TRUE;
-	pr_info("ACPI: static SSDT installation disabled\n");
+	pr_info("Static SSDT installation disabled\n");
 
 	return 0;
 }
@@ -1721,8 +1723,7 @@ early_param("acpi_no_static_ssdt", acpi_
 
 static int __init acpi_disable_return_repair(char *s)
 {
-	printk(KERN_NOTICE PREFIX
-	       "ACPI: Predefined validation mechanism disabled\n");
+	pr_notice("Predefined validation mechanism disabled\n");
 	acpi_gbl_disable_auto_repair = TRUE;
 
 	return 1;
@@ -1748,7 +1749,7 @@ acpi_status __init acpi_os_initialize(vo
 		void *rv;
 
 		rv = acpi_os_map_generic_address(&acpi_gbl_FADT.reset_register);
-		pr_debug(PREFIX "%s: map reset_reg %s\n", __func__,
+		pr_debug("%s: map reset_reg %s\n", __func__,
 			 rv ? "successful" : "failed");
 	}
 	acpi_os_initialized = true;



