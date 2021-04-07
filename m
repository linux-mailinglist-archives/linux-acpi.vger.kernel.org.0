Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E72A356EC8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353059AbhDGOeR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:34:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49220 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352993AbhDGOeG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:34:06 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 3570bd9b78a477a8; Wed, 7 Apr 2021 16:33:55 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 9AA71669203;
        Wed,  7 Apr 2021 16:33:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 3/5] ACPI: scan: Drop sta argument from acpi_add_single_object()
Date:   Wed, 07 Apr 2021 16:31:54 +0200
Message-ID: <3102232.aeNJFYEL58@kreacher>
In-Reply-To: <2192169.ElGaqSPkdT@kreacher>
References: <2192169.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.116
X-CLIENT-HOSTNAME: 89-64-81-116.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdduudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdduudeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the initial status check for ACPI_BUS_TYPE_PROCESSOR objects
into acpi_add_single_object() so it is not necessary to pass the
"sta" argument to it, get rid of that argument from there and update
the callers of that function accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1681,15 +1681,18 @@ void acpi_device_add_finalize(struct acp
 }
 
 static int acpi_add_single_object(struct acpi_device **child,
-				  acpi_handle handle, int type,
-				  unsigned long long sta)
+				  acpi_handle handle, int type)
 {
 	struct acpi_device_info *info = NULL;
+	unsigned long long sta = ACPI_STA_DEFAULT;
 	struct acpi_device *device;
 	int result;
 
-	if (handle != ACPI_ROOT_OBJECT && type == ACPI_BUS_TYPE_DEVICE)
+	if (type == ACPI_BUS_TYPE_DEVICE && handle != ACPI_ROOT_OBJECT)
 		acpi_get_object_info(handle, &info);
+	else if (type == ACPI_BUS_TYPE_PROCESSOR &&
+		 ACPI_FAILURE(acpi_bus_get_status_handle(handle, &sta)))
+		return -ENODEV;
 
 	device = kzalloc(sizeof(struct acpi_device), GFP_KERNEL);
 	if (!device) {
@@ -1910,7 +1913,6 @@ static acpi_status acpi_bus_check_add(ac
 				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = NULL;
-	unsigned long long sta = ACPI_STA_DEFAULT;
 	acpi_object_type acpi_type;
 	int type;
 
@@ -1938,9 +1940,6 @@ static acpi_status acpi_bus_check_add(ac
 		break;
 
 	case ACPI_TYPE_PROCESSOR:
-		if (ACPI_FAILURE(acpi_bus_get_status_handle(handle, &sta)))
-			return AE_OK;
-
 		type = ACPI_BUS_TYPE_PROCESSOR;
 		break;
 
@@ -1955,7 +1954,7 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_OK;
 	}
 
-	acpi_add_single_object(&device, handle, type, sta);
+	acpi_add_single_object(&device, handle, type);
 	if (!device)
 		return AE_CTRL_DEPTH;
 
@@ -2229,8 +2228,7 @@ int acpi_bus_register_early_device(int t
 	struct acpi_device *device = NULL;
 	int result;
 
-	result = acpi_add_single_object(&device, NULL,
-					type, ACPI_STA_DEFAULT);
+	result = acpi_add_single_object(&device, NULL, type);
 	if (result)
 		return result;
 
@@ -2250,8 +2248,7 @@ static int acpi_bus_scan_fixed(void)
 		struct acpi_device *device = NULL;
 
 		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_POWER_BUTTON,
-						ACPI_STA_DEFAULT);
+						ACPI_BUS_TYPE_POWER_BUTTON);
 		if (result)
 			return result;
 
@@ -2267,8 +2264,7 @@ static int acpi_bus_scan_fixed(void)
 		struct acpi_device *device = NULL;
 
 		result = acpi_add_single_object(&device, NULL,
-						ACPI_BUS_TYPE_SLEEP_BUTTON,
-						ACPI_STA_DEFAULT);
+						ACPI_BUS_TYPE_SLEEP_BUTTON);
 		if (result)
 			return result;
 



