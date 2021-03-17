Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C787033F608
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 17:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCQQuT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 12:50:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47332 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhCQQuA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2021 12:50:00 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id b5a2283f45a98cea; Wed, 17 Mar 2021 17:49:56 +0100
Received: from kreacher.localnet (89-64-80-90.dynamic.chello.pl [89.64.80.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A50E0668F2A;
        Wed, 17 Mar 2021 17:49:55 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH] ACPI: scan: Turn off unused power resources during initialization
Date:   Wed, 17 Mar 2021 17:49:55 +0100
Message-ID: <2527835.vZkJICojNU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevudefgfeguedtjedvhfetveegleduveeuvedvjeekleefhfduhfefheekffefveenucfkphepkeelrdeigedrkedtrdeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrledtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that on certain platforms unused ACPI power resources
that have not been explicitly turned off prevent the platform from
reaching the lowest power state in suspend-to-idle which leads to
excessive power draw.

For this reason, turn all of the unused ACPI power resources off
at the end of the initial namespace scan for devices in analogy with
resume from suspend-to-RAM.

Reported-by: David Box <david.e.box@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    2 ++
 drivers/acpi/sleep.h    |    1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -139,6 +139,7 @@ int acpi_device_sleep_wake(struct acpi_d
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
+void acpi_turn_off_unused_power_resources(void);
 
 /* --------------------------------------------------------------------------
                               Device Power Management
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2360,6 +2360,8 @@ int __init acpi_scan_init(void)
 		}
 	}
 
+	acpi_turn_off_unused_power_resources();
+
 	acpi_scan_initialized = true;
 
  out:
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -8,7 +8,6 @@ extern struct list_head acpi_wakeup_devi
 extern struct mutex acpi_device_lock;
 
 extern void acpi_resume_power_resources(void);
-extern void acpi_turn_off_unused_power_resources(void);
 
 static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 {



