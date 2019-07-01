Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9E5BA37
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfGAK6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 06:58:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58928 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfGAK6U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 06:58:20 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8ee318da5a3211b0; Mon, 1 Jul 2019 12:58:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: [PATCH v2 2/5] PCI: PM: Simplify bus-level hibernation callbacks
Date:   Mon, 01 Jul 2019 12:46:45 +0200
Message-ID: <1631366.A1uHhESlUo@kreacher>
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
References: <4976412.ihyb9sT5jY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After a previous change causing all runtime-suspended PCI devices
to be resumed before creating a snapshot image of memory during
hibernation, it is not necessary to worry about the case in which
them might be left in runtime-suspend any more, so get rid of the
code related to that from bus-level PCI hibernation callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: No changes.

---
 drivers/pci/pci-driver.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1034,22 +1034,11 @@ static int pci_pm_freeze(struct device *
 	return 0;
 }
 
-static int pci_pm_freeze_late(struct device *dev)
-{
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
-	return pm_generic_freeze_late(dev);
-}
-
 static int pci_pm_freeze_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		return 0;
-
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
 
@@ -1079,16 +1068,6 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	/*
-	 * If the device is in runtime suspend, the code below may not work
-	 * correctly with it, so skip that code and make the PM core skip all of
-	 * the subsequent "thaw" callbacks for the device.
-	 */
-	if (dev_pm_smart_suspend_and_suspended(dev)) {
-		dev_pm_skip_next_resume_phases(dev);
-		return 0;
-	}
-
 	if (pcibios_pm_ops.thaw_noirq) {
 		error = pcibios_pm_ops.thaw_noirq(dev);
 		if (error)
@@ -1226,10 +1205,6 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	/* This is analogous to the pci_pm_resume_noirq() case. */
-	if (dev_pm_smart_suspend_and_suspended(dev))
-		pm_runtime_set_active(dev);
-
 	if (pcibios_pm_ops.restore_noirq) {
 		error = pcibios_pm_ops.restore_noirq(dev);
 		if (error)
@@ -1279,7 +1254,6 @@ static int pci_pm_restore(struct device
 #else /* !CONFIG_HIBERNATE_CALLBACKS */
 
 #define pci_pm_freeze		NULL
-#define pci_pm_freeze_late	NULL
 #define pci_pm_freeze_noirq	NULL
 #define pci_pm_thaw		NULL
 #define pci_pm_thaw_noirq	NULL
@@ -1405,7 +1379,6 @@ static const struct dev_pm_ops pci_dev_p
 	.suspend_late = pci_pm_suspend_late,
 	.resume = pci_pm_resume,
 	.freeze = pci_pm_freeze,
-	.freeze_late = pci_pm_freeze_late,
 	.thaw = pci_pm_thaw,
 	.poweroff = pci_pm_poweroff,
 	.poweroff_late = pci_pm_poweroff_late,



