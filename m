Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AB340CF7
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 19:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCRS3O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 14:29:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63892 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhCRS3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 14:29:10 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 820c3476cb80a778; Thu, 18 Mar 2021 19:29:08 +0100
Received: from kreacher.localnet (89-64-80-250.dynamic.chello.pl [89.64.80.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 42D9D668FA9;
        Thu, 18 Mar 2021 19:29:08 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI: scan: Turn off unused power resources during initialization
Date:   Thu, 18 Mar 2021 19:25:12 +0100
Message-ID: <9860889.nUPlyArG6x@kreacher>
In-Reply-To: <3108574.44csPzL39Z@kreacher>
References: <3108574.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttddvnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfekveffledtuefgueevudetgfeukeegudeufeeljeetgfetleefudevledvtdejnecuffhomhgrihhnpehuvghfihdrohhrghenucfkphepkeelrdeigedrkedtrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrddvhedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugdrvgdrsghogieslhhinhhugidrihhnthgvlhdrtgho
 mh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that on certain platforms there are power resources
that are not associated with any devices physically present in the
platform.  Those power resources are expected to be turned off by
the OS in accordance with the ACPI specification (section 7.3 of
ACPI 6.4) which currently is not done by Linux and that may lead
to obscure issues.

For instance, leaving those power resources in the "on" state may
prevent the platform from reaching the lowest power state in
suspend-to-idle which leads to excessive power draw.

For this reason, turn all of the unused ACPI power resources off
at the end of the initial namespace scan for devices in analogy with
resume from suspend-to-RAM.

Link: https://uefi.org/specs/ACPI/6.4/07_Power_and_Performance_Mgmt/device-power-management-objects.html
Reported-by: David Box <david.e.box@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Expand the changelog somewhat and make it build with CONFIG_PM_SLEEP
       unset.

---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/power.c    |    2 +-
 drivers/acpi/scan.c     |    2 ++
 drivers/acpi/sleep.h    |    1 -
 4 files changed, 4 insertions(+), 2 deletions(-)

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
Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -996,6 +996,7 @@ void acpi_resume_power_resources(void)
 
 	mutex_unlock(&power_resource_list_lock);
 }
+#endif
 
 void acpi_turn_off_unused_power_resources(void)
 {
@@ -1025,4 +1026,3 @@ void acpi_turn_off_unused_power_resource
 
 	mutex_unlock(&power_resource_list_lock);
 }
-#endif



