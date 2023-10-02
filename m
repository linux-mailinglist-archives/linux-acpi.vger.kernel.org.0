Return-Path: <linux-acpi+bounces-348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD567B5A14
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 20:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C3EF1281515
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFCD1EA74
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 18:31:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD641EA64
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 18:04:08 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA65AC;
	Mon,  2 Oct 2023 11:04:05 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 86a8d004266c595f; Mon, 2 Oct 2023 20:04:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 88BE16658DF;
	Mon,  2 Oct 2023 20:04:03 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/4] ACPI: thermal: Use thermal_zone_for_each_trip()
Date: Mon, 02 Oct 2023 20:00:20 +0200
Message-ID: <1873286.tdWV9SEqCh@kreacher>
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

Rearrange the code handling notifications from the platform firmware
to carry out one loop over trip points instead of two and use
thermal_zone_for_each_trip() for that, which is more straightforward
that using a combination of thermal_zone_device_exec() and
for_each_thermal_trip(), each with its own callback function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   58 +++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -95,6 +95,7 @@ struct acpi_thermal_passive {
 
 struct acpi_thermal_active {
 	struct acpi_thermal_trip trip;
+	int index;
 };
 
 struct acpi_thermal_trips {
@@ -285,14 +286,36 @@ static void acpi_thermal_update_active_t
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
+struct adjust_trip_data {
+	struct acpi_thermal *tz;
+	u32 event;
+};
+
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
-	struct acpi_thermal *tz = data;
+	struct adjust_trip_data *atd = data;
+	struct acpi_thermal *tz = atd->tz;
 
 	if (!acpi_trip)
 		return 0;
 
+	if (trip->type == THERMAL_TRIP_PASSIVE) {
+		if (atd->event == ACPI_THERMAL_NOTIFY_THRESHOLDS)
+			acpi_thermal_update_passive_trip(tz);
+		else
+			acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
+	} else {
+		/* Since acpi_trip is present, this must be an active trip. */
+		struct acpi_thermal_active *active;
+
+		active = container_of(acpi_trip, struct acpi_thermal_active, trip);
+		if (atd->event == ACPI_THERMAL_NOTIFY_THRESHOLDS)
+			acpi_thermal_update_active_trip(tz, active->index);
+		else
+			acpi_thermal_update_trip_devices(tz, active->index);
+	}
+
 	if (acpi_thermal_trip_valid(acpi_trip))
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 	else
@@ -301,25 +324,6 @@ static int acpi_thermal_adjust_trip(stru
 	return 0;
 }
 
-static void acpi_thermal_adjust_thermal_zone(struct thermal_zone_device *thermal,
-					     unsigned long data)
-{
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int i;
-
-	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
-		acpi_thermal_update_passive_trip(tz);
-		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_active_trip(tz, i);
-	} else {
-		acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
-		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_trip_devices(tz, i);
-	}
-
-	for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);
-}
-
 static void acpi_queue_thermal_check(struct acpi_thermal *tz)
 {
 	if (!work_pending(&tz->thermal_check_work))
@@ -328,17 +332,18 @@ static void acpi_queue_thermal_check(str
 
 static void acpi_thermal_trips_update(struct acpi_thermal *tz, u32 event)
 {
+	struct adjust_trip_data atd = { .tz = tz, .event = event };
 	struct acpi_device *adev = tz->device;
 
 	/*
-	 * Use thermal_zone_device_exec() to carry out the trip points
+	 * Use thermal_zone_for_each_trip() to carry out the trip points
 	 * update, so as to protect thermal_get_trend() from getting stale
 	 * trip point temperatures and to prevent thermal_zone_device_update()
 	 * invoked from acpi_thermal_check_fn() from producing inconsistent
 	 * results.
 	 */
-	thermal_zone_device_exec(tz->thermal_zone,
-				 acpi_thermal_adjust_thermal_zone, event);
+	thermal_zone_for_each_trip(tz->thermal_zone,
+				   acpi_thermal_adjust_trip, &atd);
 	acpi_queue_thermal_check(tz);
 	acpi_bus_generate_netlink_event(adev->pnp.device_class,
 					dev_name(&adev->dev), event, 0);
@@ -466,11 +471,12 @@ static int acpi_thermal_get_trip_points(
 		count++;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (acpi_thermal_init_trip(tz, i))
+		if (acpi_thermal_init_trip(tz, i)) {
+			tz->trips.active[i].index = i;
 			count++;
-		else
+		} else {
 			break;
-
+		}
 	}
 
 	while (++i < ACPI_THERMAL_MAX_ACTIVE)




