Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4643B44C9DF
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 20:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhKJT4p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 14:56:45 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41824 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKJT4p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Nov 2021 14:56:45 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id e2f8576be3979567; Wed, 10 Nov 2021 20:53:55 +0100
Received: from kreacher.localnet (unknown [213.134.187.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2842866A9A4;
        Wed, 10 Nov 2021 20:53:55 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Kyle D. Pelton" <kyle.d.pelton@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: PM: Avoid removing power from unused hardware too early
Date:   Wed, 10 Nov 2021 20:53:54 +0100
Message-ID: <2623493.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.20
X-CLIENT-HOSTNAME: 213.134.187.20
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrudekgdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrddukeejrddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtohepkhihlhgvrdgurdhpvghl
 thhonhesihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
unused objects") causes power to be removed from some hardware
resources that appear to be unused too early, which leads to boot
issues on some systems.

To address this, move putting the unused ACPI device objects into
D3cold to a late initcall.

Fixes: c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by unused objects")
Reported-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
Tested-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2559,12 +2559,6 @@ int __init acpi_scan_init(void)
 		}
 	}
 
-	/*
-	 * Make sure that power management resources are not blocked by ACPI
-	 * device objects with no users.
-	 */
-	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
-
 	acpi_turn_off_unused_power_resources();
 
 	acpi_scan_initialized = true;
@@ -2574,6 +2568,22 @@ int __init acpi_scan_init(void)
 	return result;
 }
 
+static int acpi_turn_off_unused_devices(void)
+{
+	mutex_lock(&acpi_scan_lock);
+
+	/*
+	 * Make sure that power management resources are not blocked by ACPI
+	 * device objects with no users.
+	 */
+	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
+
+	mutex_unlock(&acpi_scan_lock);
+
+	return 0;
+}
+late_initcall(acpi_turn_off_unused_devices);
+
 static struct acpi_probe_entry *ape;
 static int acpi_probe_count;
 static DEFINE_MUTEX(acpi_probe_mutex);



