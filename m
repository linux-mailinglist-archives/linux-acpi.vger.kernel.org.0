Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4C11212F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 02:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLDBya (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Dec 2019 20:54:30 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44328 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLDBya (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2019 20:54:30 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id faa3772347af143e; Wed, 4 Dec 2019 02:54:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH] ACPI: PM: Avoid attaching ACPI PM domain to certain devices
Date:   Wed, 04 Dec 2019 02:54:27 +0100
Message-ID: <1773028.iBGNyVBcMc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Certain ACPI-enumerated devices represented as platform devices in
Linux, like fans, require special low-level power management handling
implemented by their drivers that is not in agreement with the ACPI
PM domain behavior.  That leads to problems with managing ACPI fans
during system-wide suspend and resume.

For this reason, make acpi_dev_pm_attach() skip the affected devices
by adding a list of device IDs to avoid to it and putting the IDs of
the affected devices into that list.

Fixes: e5cc8ef31267 (ACPI / PM: Provide ACPI PM callback routines for subsystems)
Reported-by: Zhang Rui <rui.zhang@intel.com>
Cc: 3.10+ <stable@vger.kernel.org> # 3.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Rui,

Please test this on the machine(s) affected by the fan suspend/resume issues.

I don't really see any cleaner way to address this problem, because the
ACPI PM domain should not be used with the devices in question even if
the driver that binds to them is not loaded.

Cheers,
Rafael

---
 drivers/acpi/device_pm.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -1314,9 +1314,19 @@ static void acpi_dev_pm_detach(struct de
  */
 int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
+	/*
+	 * Skip devices whose ACPI companions match the device IDs below,
+	 * because they require special power management handling incompatible
+	 * with the generic ACPI PM domain.
+	 */
+	static const struct acpi_device_id special_pm_ids[] = {
+		{"PNP0C0B", }, /* Generic ACPI fan */
+		{"INT3404", }, /* Fan */
+		{}
+	};
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
-	if (!adev)
+	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
 		return 0;
 
 	/*



