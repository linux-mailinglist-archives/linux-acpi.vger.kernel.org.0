Return-Path: <linux-acpi+bounces-28-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8057A9C62
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BDFB2302E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05D968C4
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:42:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E518B08
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:44 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B555DAF6A9;
	Thu, 21 Sep 2023 11:07:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 8de49c409fbac1fc; Thu, 21 Sep 2023 20:07:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id B0ABA664EBE;
	Thu, 21 Sep 2023 20:07:22 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 11/13] ACPI: thermal: Do not use trip indices for cooling device binding
Date: Thu, 21 Sep 2023 20:02:59 +0200
Message-ID: <113039009.nniJfEyVGO@kreacher>
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

Rearrange the ACPI thermal driver's callback functions used for cooling
device binding and unbinding, acpi_thermal_bind_cooling_device() and
acpi_thermal_unbind_cooling_device(), respectively, so that they use trip
pointers instead of trip indices which is more straightforward and allows
the driver to become independent of the ordering of trips in the thermal
zone structure.

The general functionality is not expected to be changed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  114 +++++++++++++++++++------------------------------
 1 file changed, 46 insertions(+), 68 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -568,94 +568,72 @@ static void acpi_thermal_zone_device_cri
 	thermal_zone_device_critical(thermal);
 }
 
-static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
-					  struct thermal_cooling_device *cdev,
-					  bool bind)
+struct acpi_thermal_bind_data {
+	struct thermal_zone_device *thermal;
+	struct thermal_cooling_device *cdev;
+	bool bind;
+};
+
+static int bind_unbind_cdev_cb(struct thermal_trip *trip, void *arg)
 {
-	struct acpi_device *device = cdev->devdata;
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	struct acpi_thermal_trip *acpi_trip;
-	struct acpi_device *dev;
-	acpi_handle handle;
+	struct acpi_thermal_trip *acpi_trip = trip->priv;
+	struct acpi_thermal_bind_data *bd = arg;
+	struct thermal_zone_device *thermal = bd->thermal;
+	struct thermal_cooling_device *cdev = bd->cdev;
+	struct acpi_device *cdev_adev = cdev->devdata;
 	int i;
-	int j;
-	int trip = -1;
-	int result = 0;
-
-	if (tz->trips.critical_valid)
-		trip++;
-
-	if (tz->trips.hot_valid)
-		trip++;
-
-	acpi_trip = &tz->trips.passive.trip;
-	if (acpi_thermal_trip_valid(acpi_trip)) {
-		trip++;
-		for (i = 0; i < acpi_trip->devices.count; i++) {
-			handle = acpi_trip->devices.handles[i];
-			dev = acpi_fetch_acpi_dev(handle);
-			if (dev != device)
-				continue;
-
-			if (bind)
-				result = thermal_zone_bind_cooling_device(
-						thermal, trip, cdev,
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-			else
-				result =
-					thermal_zone_unbind_cooling_device(
-						thermal, trip, cdev);
 
-			if (result)
-				goto failed;
+	/* Skip critical and hot trips. */
+	if (!acpi_trip)
+		return 0;
+
+	for (i = 0; i < acpi_trip->devices.count; i++) {
+		acpi_handle handle = acpi_trip->devices.handles[i];
+		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+
+		if (adev != cdev_adev)
+			continue;
+
+		if (bd->bind) {
+			int ret;
+
+			ret = thermal_bind_cdev_to_trip(thermal, trip, cdev,
+							THERMAL_NO_LIMIT,
+							THERMAL_NO_LIMIT,
+							THERMAL_WEIGHT_DEFAULT);
+			if (ret)
+				return ret;
+		} else {
+			thermal_unbind_cdev_from_trip(thermal, trip, cdev);
 		}
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		acpi_trip = &tz->trips.active[i].trip;
-		if (!acpi_thermal_trip_valid(acpi_trip))
-			break;
-
-		trip++;
-		for (j = 0; j < acpi_trip->devices.count; j++) {
-			handle = acpi_trip->devices.handles[j];
-			dev = acpi_fetch_acpi_dev(handle);
-			if (dev != device)
-				continue;
-
-			if (bind)
-				result = thermal_zone_bind_cooling_device(
-						thermal, trip, cdev,
-						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT,
-						THERMAL_WEIGHT_DEFAULT);
-			else
-				result = thermal_zone_unbind_cooling_device(
-						thermal, trip, cdev);
+	return 0;
+}
 
-			if (result)
-				goto failed;
-		}
-	}
+static int acpi_thermal_bind_unbind_cdev(struct thermal_zone_device *thermal,
+					 struct thermal_cooling_device *cdev,
+					 bool bind)
+{
+	struct acpi_thermal_bind_data bd = {
+		.thermal = thermal, .cdev = cdev, .bind = bind
+	};
 
-failed:
-	return result;
+	return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
 }
 
 static int
 acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
 				 struct thermal_cooling_device *cdev)
 {
-	return acpi_thermal_cooling_device_cb(thermal, cdev, true);
+	return acpi_thermal_bind_unbind_cdev(thermal, cdev, true);
 }
 
 static int
 acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
 				   struct thermal_cooling_device *cdev)
 {
-	return acpi_thermal_cooling_device_cb(thermal, cdev, false);
+	return acpi_thermal_bind_unbind_cdev(thermal, cdev, false);
 }
 
 static struct thermal_zone_device_ops acpi_thermal_zone_ops = {




