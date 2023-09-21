Return-Path: <linux-acpi+bounces-32-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA97A9BD4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C2928261D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D1987AD
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A241E3F
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:45 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A5AF6B1;
	Thu, 21 Sep 2023 11:07:26 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id f5571a811c8c5fc5; Thu, 21 Sep 2023 20:07:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id 85623664EBE;
	Thu, 21 Sep 2023 20:07:24 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 09/13] thermal: core: Rename trip point index function arguments in governors
Date: Thu, 21 Sep 2023 19:58:32 +0200
Message-ID: <3719288.MHq7AAxBmi@kreacher>
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

Rename function argumets used for passing trip point indices in thermal
governors and in the .throttle() callback to "trip_index" to avoid
confusion with trip pointer names.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c  |    4 ++--
 drivers/thermal/gov_step_wise.c  |   16 ++++++++--------
 drivers/thermal/gov_user_space.c |    6 +++---
 include/linux/thermal.h          |    2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -199,7 +199,7 @@ struct thermal_governor {
 	char name[THERMAL_NAME_LENGTH];
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	int (*throttle)(struct thermal_zone_device *tz, int trip_index);
 	struct list_head	governor_list;
 };
 
Index: linux-pm/drivers/thermal/gov_user_space.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_user_space.c
+++ linux-pm/drivers/thermal/gov_user_space.c
@@ -25,11 +25,11 @@ static int user_space_bind(struct therma
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
- * @trip: trip point index
+ * @trip_index: trip point index
  *
  * This function notifies the user space through UEvents.
  */
-static int notify_user_space(struct thermal_zone_device *tz, int trip)
+static int notify_user_space(struct thermal_zone_device *tz, int trip_index)
 {
 	char *thermal_prop[5];
 	int i;
@@ -38,7 +38,7 @@ static int notify_user_space(struct ther
 
 	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
 	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
-	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
+	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip_index);
 	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
 	thermal_prop[4] = NULL;
 	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -89,14 +89,14 @@ static int thermal_zone_trip_update(stru
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
  */
-static int bang_bang_control(struct thermal_zone_device *tz, int trip)
+static int bang_bang_control(struct thermal_zone_device *tz, int trip_index)
 {
 	struct thermal_instance *instance;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
 
-	ret = thermal_zone_trip_update(tz, trip);
+	ret = thermal_zone_trip_update(tz, trip_index);
 	if (ret)
 		return ret;
 
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -68,23 +68,23 @@ static unsigned long get_target_state(st
 	return next_target;
 }
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_index)
 {
-	const struct thermal_trip *trip = &tz->trips[trip_id];
+	const struct thermal_trip *trip = &tz->trips[trip_index];
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
 	int old_target;
 
-	trend = get_tz_trend(tz, trip_id);
+	trend = get_tz_trend(tz, trip_index);
 
 	if (tz->temperature >= trip->temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip_id, trip->type);
+		trace_thermal_zone_trip(tz, trip_index, trip->type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-		trip_id, trip->type, trip->temperature, trend, throttle);
+		trip_index, trip->type, trip->temperature, trend, throttle);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
@@ -120,7 +120,7 @@ static void thermal_zone_trip_update(str
 /**
  * step_wise_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip: trip point index
+ * @trip_index: trip point index
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
@@ -128,13 +128,13 @@ static void thermal_zone_trip_update(str
  * step. If the zone is 'cooling down' it brings back the performance of
  * the devices by one step.
  */
-static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
+static int step_wise_throttle(struct thermal_zone_device *tz, int trip_index)
 {
 	struct thermal_instance *instance;
 
 	lockdep_assert_held(&tz->lock);
 
-	thermal_zone_trip_update(tz, trip);
+	thermal_zone_trip_update(tz, trip_index);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);




