Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D9313E68
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 20:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhBHTDX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 14:03:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59452 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhBHTA7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 14:00:59 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id 10aa2af35271feb9; Mon, 8 Feb 2021 20:00:06 +0100
Received: from kreacher.localnet (89-64-80-68.dynamic.chello.pl [89.64.80.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 67C476608B1;
        Mon,  8 Feb 2021 20:00:05 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Subject: [PATCH v1 1/2] ACPI: OSL: Rework acpi_check_resource_conflict()
Date:   Mon, 08 Feb 2021 19:58:42 +0100
Message-ID: <4364959.MCEszuYnQi@kreacher>
In-Reply-To: <4653881.kBYL0eE9gL@kreacher>
References: <4653881.kBYL0eE9gL@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrheefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedtrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrieekpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhouhhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rearrange the code in acpi_check_resource_conflict() so as to drop
redundant checks and uneeded local variables from there and modify
the messages printed by that function to be more concise and
hopefully easier to understand.

While at it, replace direct printk() usage with pr_*().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1458,38 +1458,28 @@ __setup("acpi_enforce_resources=", acpi_
 int acpi_check_resource_conflict(const struct resource *res)
 {
 	acpi_adr_space_type space_id;
-	acpi_size length;
-	u8 warn = 0;
-	int clash = 0;
 
 	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
 		return 0;
-	if (!(res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_MEM))
-		return 0;
 
 	if (res->flags & IORESOURCE_IO)
 		space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	else
+	else if (res->flags & IORESOURCE_MEM)
 		space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
+	else
+		return 0;
+
+	if (!acpi_check_address_range(space_id, res->start, resource_size(res), 1))
+		return 0;
+
+	pr_info("Resource conflict; ACPI support missing from driver?\n");
+
+	if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
+		return -EBUSY;
+
+	if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
+		pr_notice("Resource conflict: System may be unstable or behave erratically\n");
 
-	length = resource_size(res);
-	if (acpi_enforce_resources != ENFORCE_RESOURCES_NO)
-		warn = 1;
-	clash = acpi_check_address_range(space_id, res->start, length, warn);
-
-	if (clash) {
-		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
-				printk(KERN_NOTICE "ACPI: This conflict may"
-				       " cause random problems and system"
-				       " instability\n");
-			printk(KERN_INFO "ACPI: If an ACPI driver is available"
-			       " for this device, you should use it instead of"
-			       " the native driver\n");
-		}
-		if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
-			return -EBUSY;
-	}
 	return 0;
 }
 EXPORT_SYMBOL(acpi_check_resource_conflict);



