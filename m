Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099A23A9D86
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhFPO2c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 10:28:32 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51626 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhFPO23 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 10:28:29 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.1.0)
 id fa8fdf3f9a700f0c; Wed, 16 Jun 2021 16:26:21 +0200
Received: from kreacher.localnet (89-64-81-4.dynamic.chello.pl [89.64.81.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C8FC866993E;
        Wed, 16 Jun 2021 16:26:20 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] ACPI: scan: Make acpi_walk_dep_device_list()
Date:   Wed, 16 Jun 2021 16:22:50 +0200
Message-ID: <1881350.PYKUYFuaPT@kreacher>
In-Reply-To: <3140195.44csPzL39Z@kreacher>
References: <3140195.44csPzL39Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.4
X-CLIENT-HOSTNAME: 89-64-81-4.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrfedvledgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because acpi_walk_dep_device_list() is only called by the code in the
file in which it is defined, make it static, drop the export of it
and drop its header from acpi.h.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c  |    7 +++----
 include/linux/acpi.h |    3 ---
 2 files changed, 3 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2145,9 +2145,9 @@ static int acpi_scan_clear_dep(struct ac
  * negative value is returned by the callback then the loop is broken and that
  * value is returned as the final error.
  */
-int acpi_walk_dep_device_list(acpi_handle handle,
-			      int (*callback)(struct acpi_dep_data *, void *),
-			      void *data)
+static int acpi_walk_dep_device_list(acpi_handle handle,
+				int (*callback)(struct acpi_dep_data *, void *),
+				void *data)
 {
 	struct acpi_dep_data *dep, *tmp;
 	int ret = 0;
@@ -2164,7 +2164,6 @@ int acpi_walk_dep_device_list(acpi_handl
 
 	return ret > 0 ? 0 : ret;
 }
-EXPORT_SYMBOL_GPL(acpi_walk_dep_device_list);
 
 /**
  * acpi_dev_clear_dependencies - Inform consumers that the device is now active
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -668,9 +668,6 @@ extern bool acpi_driver_match_device(str
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
 int acpi_device_modalias(struct device *, char *, int);
-int acpi_walk_dep_device_list(acpi_handle handle,
-			      int (*callback)(struct acpi_dep_data *, void *),
-			      void *data);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *,
 						    struct property_entry *);



