Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943AC3A9D85
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhFPO2b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:28:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60678 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhFPO21 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 10:28:27 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id 6567bd7b4d9b253f; Wed, 16 Jun 2021 16:26:19 +0200
Received: from kreacher.localnet (89-64-81-4.dynamic.chello.pl [89.64.81.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3FEB9669926;
        Wed, 16 Jun 2021 16:26:19 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] ACPI: scan: Fix device object rescan in acpi_scan_clear_dep()
Date:   Wed, 16 Jun 2021 16:23:44 +0200
Message-ID: <7272740.EvYhyI6sBW@kreacher>
In-Reply-To: <3140195.44csPzL39Z@kreacher>
References: <3140195.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.4
X-CLIENT-HOSTNAME: 89-64-81-4.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In general, acpi_bus_attach() can only be run safely under
acpi_scan_lock, but that lock cannot be acquired under
acpi_dep_list_lock, so make acpi_scan_clear_dep() schedule deferred
execution of acpi_bus_attach() under acpi_scan_lock instead of
calling it directly.

This also fixes a possible race between acpi_scan_clear_dep() and
device removal that might cause a device object that went away to
be accessed, because acpi_scan_clear_dep() is changed to acquire
a reference on the consumer device object.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2115,16 +2115,56 @@ static int acpi_dev_get_first_consumer_d
 	return 0;
 }
 
-static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
-{
+struct acpi_scan_clear_dep_work {
+	struct work_struct work;
 	struct acpi_device *adev;
+};
+
+static void acpi_scan_clear_dep_fn(struct work_struct *work)
+{
+	struct acpi_scan_clear_dep_work *cdw;
+
+	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
 
-	acpi_bus_get_device(dep->consumer, &adev);
+	acpi_scan_lock_acquire();
+	acpi_bus_attach(cdw->adev, true);
+	acpi_scan_lock_release();
+
+	acpi_dev_put(cdw->adev);
+	kfree(cdw);
+}
+
+static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
+{
+	struct acpi_scan_clear_dep_work *cdw;
+
+	if (adev->dep_unmet)
+		return false;
+
+	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
+	if (!cdw)
+		return false;
+
+	cdw->adev = adev;
+	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
+	/*
+	 * Since the work function may block on the lock until the entire
+	 * initial enumeration of devices is complete, put it into the unbound
+	 * workqueue.
+	 */
+	queue_work(system_unbound_wq, &cdw->work);
+
+	return true;
+}
+
+static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
+{
+	struct acpi_device *adev = acpi_bus_get_acpi_device(dep->consumer);
 
 	if (adev) {
 		adev->dep_unmet--;
-		if (!adev->dep_unmet)
-			acpi_bus_attach(adev, true);
+		if (!acpi_scan_clear_dep_queue(adev))
+			acpi_dev_put(adev);
 	}
 
 	list_del(&dep->node);



