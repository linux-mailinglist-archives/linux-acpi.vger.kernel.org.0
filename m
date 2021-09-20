Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770A4126B1
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Sep 2021 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbhITTVj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Sep 2021 15:21:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60240 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbhITTTh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Sep 2021 15:19:37 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id ff32e75a87175858; Mon, 20 Sep 2021 21:18:09 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E56266A65F;
        Mon, 20 Sep 2021 21:18:08 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 5/7] PCI: PM: Make pci_choose_state() call pci_target_state()
Date:   Mon, 20 Sep 2021 21:17:27 +0200
Message-ID: <12860712.dW097sEU6C@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pci_choose_state() and pci_target_state() implementations are
somewhat divergent without a good reason, because they are used
for similar purposes.

Change the pci_choose_state() implementation to use pci_target_state()
internally except for transitions to the working state of the system
in which case it is expected to return D0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---


v1 -> v2:
    * Rebase on top of the new [1-4/7].


---
 drivers/pci/pci-acpi.c |    3 --
 drivers/pci/pci.c      |   54 ++++++++++++++-----------------------------------
 2 files changed, 16 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1394,44 +1394,6 @@ int pci_set_power_state(struct pci_dev *
 }
 EXPORT_SYMBOL(pci_set_power_state);
 
-/**
- * pci_choose_state - Choose the power state of a PCI device
- * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system. This is the value
- *	   that is passed to suspend() function.
- *
- * Returns PCI power state suitable for given device and given system
- * message.
- */
-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
-{
-	pci_power_t ret;
-
-	if (!dev->pm_cap)
-		return PCI_D0;
-
-	ret = platform_pci_choose_state(dev);
-	if (ret != PCI_POWER_ERROR)
-		return ret;
-
-	switch (state.event) {
-	case PM_EVENT_ON:
-		return PCI_D0;
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_PRETHAW:
-		/* REVISIT both freeze and pre-thaw "should" use D0 */
-	case PM_EVENT_SUSPEND:
-	case PM_EVENT_HIBERNATE:
-		return PCI_D3hot;
-	default:
-		pci_info(dev, "unrecognized suspend event %d\n",
-			 state.event);
-		BUG();
-	}
-	return PCI_D0;
-}
-EXPORT_SYMBOL(pci_choose_state);
-
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
@@ -2843,6 +2805,22 @@ void pci_dev_complete_resume(struct pci_
 	spin_unlock_irq(&dev->power.lock);
 }
 
+/**
+ * pci_choose_state - Choose the power state of a PCI device.
+ * @dev: Target PCI device.
+ * @state: Target state for the whole system.
+ *
+ * Returns PCI power state suitable for @dev and @state.
+ */
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+{
+	if (state.event == PM_EVENT_ON)
+		return PCI_D0;
+
+	return pci_target_state(dev, false);
+}
+EXPORT_SYMBOL(pci_choose_state);
+
 void pci_config_pm_runtime_get(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -910,9 +910,6 @@ pci_power_t acpi_pci_choose_state(struct
 {
 	int acpi_state, d_max;
 
-	if (acpi_pci_disabled)
-		return PCI_POWER_ERROR;
-
 	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else



