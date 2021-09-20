Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38AC4126B3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Sep 2021 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347829AbhITTVl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Sep 2021 15:21:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61144 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347797AbhITTTj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Sep 2021 15:19:39 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 4c775343fdb69fac; Mon, 20 Sep 2021 21:18:11 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D9E2E66A65F;
        Mon, 20 Sep 2021 21:18:09 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 4/7] PCI: PM: Rearrange pci_target_state()
Date:   Mon, 20 Sep 2021 21:17:21 +0200
Message-ID: <2559274.X9hSmTKtgW@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make pci_target_state() return D3cold or D0 without checking PME
support if the current power state of the device is D3cold or if it
does not support the standard PCI PM, respectively.

Next, drop the tergat_state local variable that has become redundant
from it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
    * Rebase on top of the new [1-3/7].

---
 drivers/pci/pci.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2583,8 +2583,6 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
-	pci_power_t target_state = PCI_D3hot;
-
 	if (platform_pci_power_manageable(dev)) {
 		/*
 		 * Call the platform to find the target state for the device.
@@ -2594,32 +2592,29 @@ static pci_power_t pci_target_state(stru
 		switch (state) {
 		case PCI_POWER_ERROR:
 		case PCI_UNKNOWN:
-			break;
+			return PCI_D3hot;
+
 		case PCI_D1:
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
-				break;
-			fallthrough;
-		default:
-			target_state = state;
+				return PCI_D3hot;
 		}
 
-		return target_state;
+		return state;
 	}
 
-	if (!dev->pm_cap)
-		target_state = PCI_D0;
-
 	/*
 	 * If the device is in D3cold even though it's not power-manageable by
 	 * the platform, it may have been powered down by non-standard means.
 	 * Best to let it slumber.
 	 */
 	if (dev->current_state == PCI_D3cold)
-		target_state = PCI_D3cold;
+		return PCI_D3cold;
+	else if (!dev->pm_cap)
+		return PCI_D0;
 
 	if (wakeup && dev->pme_support) {
-		pci_power_t state = target_state;
+		pci_power_t state = PCI_D3hot;
 
 		/*
 		 * Find the deepest state from which the device can generate
@@ -2634,7 +2629,7 @@ static pci_power_t pci_target_state(stru
 			return PCI_D0;
 	}
 
-	return target_state;
+	return PCI_D3hot;
 }
 
 /**



