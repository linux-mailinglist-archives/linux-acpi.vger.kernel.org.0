Return-Path: <linux-acpi+bounces-36-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A107A9C6E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A797B2263F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC915A5BE
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763C3F4A0
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADACAF95D;
	Thu, 21 Sep 2023 11:07:33 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 120831ec96c186fd; Thu, 21 Sep 2023 20:07:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 3665E664EBE;
	Thu, 21 Sep 2023 20:07:31 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update functions
Date: Thu, 21 Sep 2023 19:49:24 +0200
Message-ID: <3534976.iIbC2pHGDl@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to reduce code duplication, merge update_passive_devices() and
update_active_devices() into one function called update_trip_devices()
that will be used for updating both the passive and active trip points.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -43,6 +43,8 @@
 #define ACPI_THERMAL_MAX_ACTIVE		10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
 
+#define ACPI_THERMAL_TRIP_PASSIVE	(-1)
+
 /*
  * This exception is thrown out in two cases:
  * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
@@ -202,18 +204,25 @@ static void acpi_thermal_update_passive_
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
+static bool update_trip_devices(struct acpi_thermal *tz,
+				struct acpi_thermal_trip *acpi_trip,
+				int index, bool compare)
 {
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
 	struct acpi_handle_list devices;
+	char method[] = "_PSL";
 	acpi_status status;
 
+	if (index != ACPI_THERMAL_TRIP_PASSIVE) {
+		method[1] = 'A';
+		method[2] = 'L';
+		method[3] = '0' + index;
+	}
+
 	memset(&devices, 0, sizeof(devices));
 
-	status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
+	status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_info(tz->device->handle,
-				 "Missing device list for passive threshold\n");
+		acpi_handle_info(tz->device->handle, "%s evaluation failure\n", method);
 		return false;
 	}
 
@@ -231,8 +240,9 @@ static void acpi_thermal_update_passive_
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	if (update_passive_devices(tz, true))
+	if (update_trip_devices(tz, acpi_trip, ACPI_THERMAL_TRIP_PASSIVE, true)) {
 		return;
+	}
 
 	acpi_trip->temperature = THERMAL_TEMP_INVALID;
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
@@ -273,30 +283,6 @@ static void acpi_thermal_update_active_t
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static bool update_active_devices(struct acpi_thermal *tz, int index, bool compare)
-{
-	char method[] = { '_', 'A', 'L', '0' + index, '\0' };
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
-	struct acpi_handle_list devices;
-	acpi_status status;
-
-	memset(&devices, 0, sizeof(devices));
-
-	status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_info(tz->device->handle,
-				 "Missing device list for active threshold %d\n",
-				 index);
-		return false;
-	}
-
-	if (compare && memcmp(&acpi_trip->devices, &devices, sizeof(devices)))
-		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
-
-	memcpy(&acpi_trip->devices, &devices, sizeof(devices));
-	return true;
-}
-
 static void acpi_thermal_update_active_devices(struct acpi_thermal *tz, int index)
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
@@ -304,7 +290,7 @@ static void acpi_thermal_update_active_d
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	if (update_active_devices(tz, index, true))
+	if (update_trip_devices(tz, acpi_trip, index, true))
 		return;
 
 	acpi_trip->temperature = THERMAL_TEMP_INVALID;
@@ -460,7 +446,8 @@ static bool acpi_thermal_init_passive_tr
 
 	tz->trips.passive.tsp = tmp;
 
-	if (!update_passive_devices(tz, false))
+	if (!update_trip_devices(tz, &tz->trips.passive.trip,
+				 ACPI_THERMAL_TRIP_PASSIVE, false))
 		goto fail;
 
 	tz->trips.passive.trip.temperature = temp;
@@ -482,7 +469,7 @@ static bool acpi_thermal_init_active_tri
 	if (temp == THERMAL_TEMP_INVALID)
 		goto fail;
 
-	if (!update_active_devices(tz, index, false))
+	if (!update_trip_devices(tz, &tz->trips.active[index].trip, index, false))
 		goto fail;
 
 	tz->trips.active[index].trip.temperature = temp;




