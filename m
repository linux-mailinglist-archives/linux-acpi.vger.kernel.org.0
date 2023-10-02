Return-Path: <linux-acpi+bounces-345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC1C7B5A10
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 20:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2D7922818DD
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A181EA90
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8416014275
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 18:04:06 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA13B4;
	Mon,  2 Oct 2023 11:04:03 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 323f4ac4e097ed97; Mon, 2 Oct 2023 20:04:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id ACC1D6658DF;
	Mon,  2 Oct 2023 20:04:01 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 4/4] thermal: int340x: Use thermal_zone_for_each_trip()
Date: Mon, 02 Oct 2023 20:03:42 +0200
Message-ID: <3260859.aeNJFYEL58@kreacher>
In-Reply-To: <4871671.31r3eYUQgx@kreacher>
References: <4871671.31r3eYUQgx@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghp
 thhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 




