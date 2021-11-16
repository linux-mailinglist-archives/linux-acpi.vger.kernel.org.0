Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB1453A8A
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbhKPUJT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Nov 2021 15:09:19 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44542 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhKPUJS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2021 15:09:18 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 51b55b9c7d7e3a71; Tue, 16 Nov 2021 21:06:19 +0100
Received: from kreacher.localnet (unknown [213.134.175.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4909D66AAED;
        Tue, 16 Nov 2021 21:06:18 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: Emit debug messages when enabling/disabling wakeup power
Date:   Tue, 16 Nov 2021 21:06:17 +0100
Message-ID: <5517426.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.214
X-CLIENT-HOSTNAME: 213.134.175.214
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrfedvgddufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudejhedrvddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrddvudegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Print additional debug messages when enabling and disabling wakeup
power for an ACPI device object to facilitate more fine-grained
debugging of problems in that area.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/power.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -716,6 +716,9 @@ int acpi_enable_wakeup_device_power(stru
 
 	mutex_lock(&acpi_device_lock);
 
+	dev_dbg(&dev->dev, "Enabling wakeup power (count %d)\n",
+		dev->wakeup.prepare_count);
+
 	if (dev->wakeup.prepare_count++)
 		goto out;
 
@@ -734,8 +737,11 @@ int acpi_enable_wakeup_device_power(stru
 	if (err) {
 		acpi_power_off_list(&dev->wakeup.resources);
 		dev->wakeup.prepare_count = 0;
+		goto out;
 	}
 
+	dev_dbg(&dev->dev, "Wakeup power enabled\n");
+
  out:
 	mutex_unlock(&acpi_device_lock);
 	return err;
@@ -757,6 +763,9 @@ int acpi_disable_wakeup_device_power(str
 
 	mutex_lock(&acpi_device_lock);
 
+	dev_dbg(&dev->dev, "Disabling wakeup power (count %d)\n",
+		dev->wakeup.prepare_count);
+
 	/* Do nothing if wakeup power has not been enabled for this device. */
 	if (dev->wakeup.prepare_count <= 0)
 		goto out;
@@ -782,8 +791,11 @@ int acpi_disable_wakeup_device_power(str
 	if (err) {
 		dev_err(&dev->dev, "Cannot turn off wakeup power resources\n");
 		dev->wakeup.flags.valid = 0;
+		goto out;
 	}
 
+	dev_dbg(&dev->dev, "Wakeup power disabled\n");
+
  out:
 	mutex_unlock(&acpi_device_lock);
 	return err;



