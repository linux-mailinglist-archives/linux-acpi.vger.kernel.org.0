Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07823340CF2
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCRS3N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 14:29:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51586 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhCRS3I (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Mar 2021 14:29:08 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id b1fe4718ae2cca52; Thu, 18 Mar 2021 19:29:07 +0100
Received: from kreacher.localnet (89-64-80-250.dynamic.chello.pl [89.64.80.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 018B0668FA9;
        Thu, 18 Mar 2021 19:29:05 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI: power: Turn off unused power resources unconditionally
Date:   Thu, 18 Mar 2021 19:28:28 +0100
Message-ID: <20994880.EfDdHjke4D@kreacher>
In-Reply-To: <3108574.44csPzL39Z@kreacher>
References: <3108574.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgfegudduheduleetheduhefgueefffeujeffheeggeetgeekgeetheevffehjedunecuffhomhgrihhnpehuvghfihdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeekledrieegrdektddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdektddrvdehtddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgurdgvrdgsohigsehlihhn
 uhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to the ACPI specification (section 7.2.2 in ACPI 6.4), the
OS may evaluate the _OFF method of a power resource that is "off"
already [1], and in particular that can be done in the case of unused
power resources.

Accordingly, modify acpi_turn_off_unused_power_resources() to
evaluate the _OFF method for each of the unused power resources
unconditionally which may help to work around BIOS issues where the
return value of _STA for a power resource does not reflect the
actual state of the power resource [2].

Link: https://uefi.org/specs/ACPI/6.4/07_Power_and_Performance_Mgmt/declaring-a-power-resource-object.html#off # [1]
Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/ # [2]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v2.

---
 drivers/acpi/power.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -1005,18 +1005,9 @@ void acpi_turn_off_unused_power_resource
 	mutex_lock(&power_resource_list_lock);
 
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
-		int result, state;
-
 		mutex_lock(&resource->resource_lock);
 
-		result = acpi_power_get_state(resource->device.handle, &state);
-		if (result) {
-			mutex_unlock(&resource->resource_lock);
-			continue;
-		}
-
-		if (state == ACPI_POWER_RESOURCE_STATE_ON
-		    && !resource->ref_count) {
+		if (!resource->ref_count) {
 			dev_info(&resource->device.dev, "Turning OFF\n");
 			__acpi_power_off(resource);
 		}



