Return-Path: <linux-acpi+bounces-367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E067B6BB6
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 278F72817E5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE47328A8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:34:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237D2137C
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:26:50 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9BA1;
	Tue,  3 Oct 2023 06:26:47 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 790a30df8c9ae96b; Tue, 3 Oct 2023 15:26:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id B05B36659AF;
	Tue,  3 Oct 2023 15:26:45 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 6/6] thermal: int340x: Use thermal_zone_for_each_trip()
Date: Tue, 03 Oct 2023 15:26:35 +0200
Message-ID: <3532950.iIbC2pHGDl@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify int340x_thermal_update_trips() to use thermal_zone_for_each_trip()
for walking trips instead of using the trips[] table passed to the
thermal zone registration function.

For this purpose, store active trip point indices in the priv fieids of
the corresponding thermal_trip structures.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Mo changes

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   76 +++++------
 1 file changed, 41 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -67,6 +67,16 @@ static struct thermal_zone_device_ops in
 	.critical	= int340x_thermal_critical,
 };
 
+static inline void *int_to_trip_priv(int i)
+{
+	return (void *)(long)i;
+}
+
+static inline int trip_priv_to_int(const struct thermal_trip *trip)
+{
+	return (long)trip->priv;
+}
+
 static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 				      struct thermal_trip *zone_trips,
 				      int trip_cnt)
@@ -101,6 +111,7 @@ static int int340x_thermal_read_trips(st
 			break;
 
 		zone_trips[trip_cnt].type = THERMAL_TRIP_ACTIVE;
+		zone_trips[trip_cnt].priv = int_to_trip_priv(i);
 		trip_cnt++;
 	}
 
@@ -212,45 +223,40 @@ void int340x_thermal_zone_remove(struct
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
 
-void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
+static int int340x_update_one_trip(struct thermal_trip *trip, void *arg)
 {
-	struct acpi_device *zone_adev = int34x_zone->adev;
-	struct thermal_trip *zone_trips = int34x_zone->trips;
-	int trip_cnt = int34x_zone->zone->num_trips;
-	int act_trip_nr = 0;
-	int i;
-
-	mutex_lock(&int34x_zone->zone->lock);
-
-	for (i = int34x_zone->aux_trip_nr; i < trip_cnt; i++) {
-		int temp, err;
-
-		switch (zone_trips[i].type) {
-		case THERMAL_TRIP_CRITICAL:
-			err = thermal_acpi_critical_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_HOT:
-			err = thermal_acpi_hot_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_PASSIVE:
-			err = thermal_acpi_passive_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_ACTIVE:
-			err = thermal_acpi_active_trip_temp(zone_adev, act_trip_nr++,
-							    &temp);
-			break;
-		default:
-			err = -ENODEV;
-		}
-		if (err) {
-			zone_trips[i].temperature = THERMAL_TEMP_INVALID;
-			continue;
-		}
+	struct acpi_device *zone_adev = arg;
+	int temp, err;
 
-		zone_trips[i].temperature = temp;
+	switch (trip->type) {
+	case THERMAL_TRIP_CRITICAL:
+		err = thermal_acpi_critical_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_HOT:
+		err = thermal_acpi_hot_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_PASSIVE:
+		err = thermal_acpi_passive_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_ACTIVE:
+		err = thermal_acpi_active_trip_temp(zone_adev,
+						    trip_priv_to_int(trip),
+						    &temp);
+		break;
+	default:
+		err = -ENODEV;
 	}
+	if (err)
+		temp = THERMAL_TEMP_INVALID;
 
-	mutex_unlock(&int34x_zone->zone->lock);
+	trip->temperature = temp;
+	return 0;
+}
+
+void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
+{
+	thermal_zone_for_each_trip(int34x_zone->zone, int340x_update_one_trip,
+				   int34x_zone->adev);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
 




