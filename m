Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD149D29E
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jan 2022 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiAZTmv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 Jan 2022 14:42:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55472 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbiAZTms (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jan 2022 14:42:48 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 51f411f5bb0726d0; Wed, 26 Jan 2022 20:42:47 +0100
Received: from kreacher.localnet (unknown [213.134.162.63])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8E47C66B311;
        Wed, 26 Jan 2022 20:42:46 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: ACPI: Replace acpi_bus_get_device()
Date:   Wed, 26 Jan 2022 20:42:45 +0100
Message-ID: <4389553.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.63
X-CLIENT-HOSTNAME: 213.134.162.63
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudeivddrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddrieefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace acpi_bus_get_device() that is going to be dropped with
acpi_fetch_acpi_dev().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    7 ++++---
 drivers/pci/hotplug/acpiphp_ibm.c  |    5 +++--
 drivers/pci/pci-acpi.c             |    6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -226,9 +226,9 @@ static void acpiphp_post_dock_fixup(stru
 static acpi_status acpiphp_add_context(acpi_handle handle, u32 lvl, void *data,
 				       void **rv)
 {
+	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
 	struct acpiphp_bridge *bridge = data;
 	struct acpiphp_context *context;
-	struct acpi_device *adev;
 	struct acpiphp_slot *slot;
 	struct acpiphp_func *newfunc;
 	acpi_status status = AE_OK;
@@ -238,6 +238,9 @@ static acpi_status acpiphp_add_context(a
 	struct pci_dev *pdev = bridge->pci_dev;
 	u32 val;
 
+	if (!adev)
+		return AE_OK;
+
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
@@ -245,8 +248,6 @@ static acpi_status acpiphp_add_context(a
 				"can't evaluate _ADR (%#x)\n", status);
 		return AE_OK;
 	}
-	if (acpi_bus_get_device(handle, &adev))
-		return AE_OK;
 
 	device = (adr >> 16) & 0xffff;
 	function = adr & 0xffff;
Index: linux-pm/drivers/pci/hotplug/acpiphp_ibm.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_ibm.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_ibm.c
@@ -433,8 +433,9 @@ static int __init ibm_acpiphp_init(void)
 		goto init_return;
 	}
 	pr_debug("%s: found IBM aPCI device\n", __func__);
-	if (acpi_bus_get_device(ibm_acpi_handle, &device)) {
-		pr_err("%s: acpi_bus_get_device failed\n", __func__);
+	device = acpi_fetch_acpi_dev(ibm_acpi_handle);
+	if (!device)) {
+		pr_err("%s: acpi_fetch_acpi_dev failed\n", __func__);
 		retval = -ENODEV;
 		goto init_return;
 	}
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -89,9 +89,9 @@ int acpi_get_rc_resources(struct device
 		return -ENODEV;
 	}
 
-	ret = acpi_bus_get_device(handle, &adev);
-	if (ret)
-		return ret;
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
+		return -ENODEV;
 
 	ret = acpi_get_rc_addr(adev, res);
 	if (ret) {



