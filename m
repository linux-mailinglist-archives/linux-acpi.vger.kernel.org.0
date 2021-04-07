Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9F356EC3
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352995AbhDGOeS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:34:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54170 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353003AbhDGOeI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:34:08 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 1be56e04bab559de; Wed, 7 Apr 2021 16:33:57 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B6793669203;
        Wed,  7 Apr 2021 16:33:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/5] ACPI: scan: Fold acpi_bus_type_and_status() into its caller
Date:   Wed, 07 Apr 2021 16:30:01 +0200
Message-ID: <1778844.tdWV9SEqCh@kreacher>
In-Reply-To: <2192169.ElGaqSPkdT@kreacher>
References: <2192169.ElGaqSPkdT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.81.116
X-CLIENT-HOSTNAME: 89-64-81-116.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudejjedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdduudeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurdduudeipdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is only one caller of acpi_bus_type_and_status() which is
acpi_bus_check_add(), so fold the former into the latter and use
the observation that the initial status of the device is
ACPI_STA_DEFAULT in all cases except for ACPI_BUS_TYPE_PROCESSOR
to simplify the code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   80 ++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 48 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1763,50 +1763,6 @@ static bool acpi_device_should_be_hidden
 	return true;
 }
 
-static int acpi_bus_type_and_status(acpi_handle handle, int *type,
-				    unsigned long long *sta)
-{
-	acpi_status status;
-	acpi_object_type acpi_type;
-
-	status = acpi_get_type(handle, &acpi_type);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	switch (acpi_type) {
-	case ACPI_TYPE_ANY:		/* for ACPI_ROOT_OBJECT */
-	case ACPI_TYPE_DEVICE:
-		if (acpi_device_should_be_hidden(handle))
-			return -ENODEV;
-
-		*type = ACPI_BUS_TYPE_DEVICE;
-		/*
-		 * acpi_add_single_object updates this once we've an acpi_device
-		 * so that acpi_bus_get_status' quirk handling can be used.
-		 */
-		*sta = ACPI_STA_DEFAULT;
-		break;
-	case ACPI_TYPE_PROCESSOR:
-		*type = ACPI_BUS_TYPE_PROCESSOR;
-		status = acpi_bus_get_status_handle(handle, sta);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-		break;
-	case ACPI_TYPE_THERMAL:
-		*type = ACPI_BUS_TYPE_THERMAL;
-		*sta = ACPI_STA_DEFAULT;
-		break;
-	case ACPI_TYPE_POWER:
-		*type = ACPI_BUS_TYPE_POWER;
-		*sta = ACPI_STA_DEFAULT;
-		break;
-	default:
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
 bool acpi_device_is_present(const struct acpi_device *adev)
 {
 	return adev->status.present || adev->status.functional;
@@ -1953,18 +1909,46 @@ static acpi_status acpi_bus_check_add(ac
 				      struct acpi_device **adev_p)
 {
 	struct acpi_device *device = NULL;
-	unsigned long long sta;
+	unsigned long long sta = ACPI_STA_DEFAULT;
+	acpi_object_type acpi_type;
 	int type;
-	int result;
 
 	acpi_bus_get_device(handle, &device);
 	if (device)
 		goto out;
 
-	result = acpi_bus_type_and_status(handle, &type, &sta);
-	if (result)
+	if (ACPI_FAILURE(acpi_get_type(handle, &acpi_type)))
 		return AE_OK;
 
+	switch (acpi_type) {
+	case ACPI_TYPE_DEVICE:
+		if (acpi_device_should_be_hidden(handle))
+			return AE_OK;
+
+		fallthrough;
+	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
+		type = ACPI_BUS_TYPE_DEVICE;
+		break;
+
+	case ACPI_TYPE_PROCESSOR:
+		if (ACPI_FAILURE(acpi_bus_get_status_handle(handle, &sta)))
+			return AE_OK;
+
+		type = ACPI_BUS_TYPE_PROCESSOR;
+		break;
+
+	case ACPI_TYPE_THERMAL:
+		type = ACPI_BUS_TYPE_THERMAL;
+		break;
+
+	case ACPI_TYPE_POWER:
+		type = ACPI_BUS_TYPE_POWER;
+		break;
+
+	default:
+		return AE_OK;
+	}
+
 	if (type == ACPI_BUS_TYPE_POWER) {
 		acpi_add_power_resource(handle);
 		return AE_OK;



