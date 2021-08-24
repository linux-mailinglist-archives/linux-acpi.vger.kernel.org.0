Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71C3F6164
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Aug 2021 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhHXPRv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Aug 2021 11:17:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60710 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbhHXPRv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Aug 2021 11:17:51 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id f807926417465c02; Tue, 24 Aug 2021 17:17:05 +0200
Received: from kreacher.localnet (unknown [213.134.181.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5096D66A265;
        Tue, 24 Aug 2021 17:17:05 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: power: Use acpi_handle_debug() to pring debug messages
Date:   Tue, 24 Aug 2021 17:17:04 +0200
Message-ID: <2612145.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.106
X-CLIENT-HOSTNAME: 213.134.181.106
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudekuddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddutdeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use acpi_handle_debug() to print diagnostic messages regarding ACPI
power resources so as to make it easier to correlate the kernel
messages with the power resource objects in the ACPI namespace that
they are about.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -356,10 +356,11 @@ void acpi_device_power_remove_dependent(
 
 static int __acpi_power_on(struct acpi_power_resource *resource)
 {
+	acpi_handle handle = resource->device.handle;
 	struct acpi_power_dependent_device *dep;
 	acpi_status status = AE_OK;
 
-	status = acpi_evaluate_object(resource->device.handle, "_ON", NULL, NULL);
+	status = acpi_evaluate_object(handle, "_ON", NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 		return -ENODEV;
@@ -367,7 +368,7 @@ static int __acpi_power_on(struct acpi_p
 
 	resource->state = ACPI_POWER_RESOURCE_STATE_ON;
 
-	pr_debug("Power resource [%s] turned on\n", resource->name);
+	acpi_handle_debug(handle,"Power resource turned on\n");
 
 	/*
 	 * If there are other dependents on this power resource we need to
@@ -392,7 +393,8 @@ static int acpi_power_on_unlocked(struct
 	int result = 0;
 
 	if (resource->ref_count++) {
-		pr_debug("Power resource [%s] already on\n", resource->name);
+		acpi_handle_debug(resource->device.handle,
+				  "Power resource already on\n");
 	} else {
 		result = __acpi_power_on(resource);
 		if (result)
@@ -413,10 +415,10 @@ static int acpi_power_on(struct acpi_pow
 
 static int __acpi_power_off(struct acpi_power_resource *resource)
 {
+	acpi_handle handle = resource->device.handle;
 	acpi_status status;
 
-	status = acpi_evaluate_object(resource->device.handle, "_OFF",
-				      NULL, NULL);
+	status = acpi_evaluate_object(handle, "_OFF", NULL, NULL);
 	if (ACPI_FAILURE(status)) {
 		resource->state = ACPI_POWER_RESOURCE_STATE_UNKNOWN;
 		return -ENODEV;
@@ -424,22 +426,23 @@ static int __acpi_power_off(struct acpi_
 
 	resource->state = ACPI_POWER_RESOURCE_STATE_OFF;
 
-	pr_debug("Power resource [%s] turned off\n", resource->name);
+	acpi_handle_debug(handle, "Power resource turned off\n");
 
 	return 0;
 }
 
 static int acpi_power_off_unlocked(struct acpi_power_resource *resource)
 {
+	acpi_handle handle = resource->device.handle;
 	int result = 0;
 
 	if (!resource->ref_count) {
-		pr_debug("Power resource [%s] already off\n", resource->name);
+		acpi_handle_debug(handle, "Power resource already off\n");
 		return 0;
 	}
 
 	if (--resource->ref_count) {
-		pr_debug("Power resource [%s] still in use\n", resource->name);
+		acpi_handle_debug(handle, "Power resource still in use\n");
 	} else {
 		result = __acpi_power_off(resource);
 		if (result)
@@ -1004,7 +1007,7 @@ void acpi_resume_power_resources(void)
 
 		if (state == ACPI_POWER_RESOURCE_STATE_OFF
 		    && resource->ref_count) {
-			dev_dbg(&resource->device.dev, "Turning ON\n");
+			acpi_handle_debug(resource->device.handle, "Turning ON\n");
 			__acpi_power_on(resource);
 		}
 
@@ -1034,7 +1037,7 @@ void acpi_turn_off_unused_power_resource
 		 */
 		if (!resource->ref_count &&
 		    resource->state != ACPI_POWER_RESOURCE_STATE_OFF) {
-			dev_dbg(&resource->device.dev, "Turning OFF\n");
+			acpi_handle_debug(resource->device.handle, "Turning OFF\n");
 			__acpi_power_off(resource);
 		}
 



