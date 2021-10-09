Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F55427ACD
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 16:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJIOZz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 10:25:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41572 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhJIOZz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 10:25:55 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id b706c1e87c7be95f; Sat, 9 Oct 2021 16:23:57 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5DB4C66A755;
        Sat,  9 Oct 2021 16:23:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI: LPSS: Use ACPI_COMPANION() directly
Date:   Sat, 09 Oct 2021 16:23:55 +0200
Message-ID: <4687529.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_HANDLE() macro returns the ACPI handle of the ACPI device
object returned by the ACPI_COMPANION() macro, so it is more
straightforward to evaluate the latter directly instead of passing
the handle produced by the former to acpi_bus_get_device().

Modify the code accordingly (no intentional functional impact).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -712,14 +712,13 @@ static void __lpss_reg_write(u32 val, st
 
 static int lpss_reg_read(struct device *dev, unsigned int reg, u32 *val)
 {
-	struct acpi_device *adev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct lpss_private_data *pdata;
 	unsigned long flags;
 	int ret;
 
-	ret = acpi_bus_get_device(ACPI_HANDLE(dev), &adev);
-	if (WARN_ON(ret))
-		return ret;
+	if (WARN_ON(!adev))
+		return -ENODEV;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 	if (pm_runtime_suspended(dev)) {
@@ -1266,7 +1265,8 @@ static int acpi_lpss_platform_notify(str
 	if (!id || !id->driver_data)
 		return 0;
 
-	if (acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
 		return 0;
 
 	pdata = acpi_driver_data(adev);



