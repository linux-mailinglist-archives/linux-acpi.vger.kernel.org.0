Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB545356EC5
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbhDGOeR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 10:34:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50430 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbhDGOeH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 10:34:07 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 6ec13df0c764e0e7; Wed, 7 Apr 2021 16:33:56 +0200
Received: from kreacher.localnet (89-64-81-116.dynamic.chello.pl [89.64.81.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AE642669203;
        Wed,  7 Apr 2021 16:33:55 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 2/5] ACPI: scan: Rearrange checks in acpi_bus_check_add()
Date:   Wed, 07 Apr 2021 16:30:56 +0200
Message-ID: <12741615.uLZWGnKmhe@kreacher>
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

Rearrange the checks in acpi_bus_check_add() to avoid checking
the "type" twice and take "check_dep" into account only for
ACPI_TYPE_DEVICE objects.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1831,7 +1831,7 @@ static void acpi_scan_init_hotplug(struc
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+static u32 acpi_scan_check_dep(acpi_handle handle, bool check_dep)
 {
 	struct acpi_handle_list dep_devices;
 	acpi_status status;
@@ -1844,7 +1844,8 @@ static u32 acpi_scan_check_dep(acpi_hand
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+	if (!check_dep || !acpi_has_method(handle, "_DEP") ||
+	    !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);
@@ -1925,6 +1926,12 @@ static acpi_status acpi_bus_check_add(ac
 		if (acpi_device_should_be_hidden(handle))
 			return AE_OK;
 
+		/* Bail out if there are dependencies. */
+		if (acpi_scan_check_dep(handle, check_dep) > 0) {
+			acpi_bus_scan_second_pass = true;
+			return AE_CTRL_DEPTH;
+		}
+
 		fallthrough;
 	case ACPI_TYPE_ANY:	/* for ACPI_ROOT_OBJECT */
 		type = ACPI_BUS_TYPE_DEVICE;
@@ -1942,27 +1949,12 @@ static acpi_status acpi_bus_check_add(ac
 		break;
 
 	case ACPI_TYPE_POWER:
-		type = ACPI_BUS_TYPE_POWER;
-		break;
-
-	default:
-		return AE_OK;
-	}
-
-	if (type == ACPI_BUS_TYPE_POWER) {
 		acpi_add_power_resource(handle);
+		fallthrough;
+	default:
 		return AE_OK;
 	}
 
-	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
-		u32 count = acpi_scan_check_dep(handle);
-		/* Bail out if the number of recorded dependencies is not 0. */
-		if (count > 0) {
-			acpi_bus_scan_second_pass = true;
-			return AE_CTRL_DEPTH;
-		}
-	}
-
 	acpi_add_single_object(&device, handle, type, sta);
 	if (!device)
 		return AE_CTRL_DEPTH;



