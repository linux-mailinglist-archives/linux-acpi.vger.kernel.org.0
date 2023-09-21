Return-Path: <linux-acpi+bounces-37-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F6A7A9C3E
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 21:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2668282AE5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFA99E5C
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Sep 2023 18:43:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888718C14
	for <linux-acpi@vger.kernel.org>; Thu, 21 Sep 2023 18:10:44 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE22AF6AC;
	Thu, 21 Sep 2023 11:07:25 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 7e05a53f9afe0d47; Thu, 21 Sep 2023 20:07:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by v370.home.net.pl (Postfix) with ESMTPSA id B6180664EBE;
	Thu, 21 Sep 2023 20:07:23 +0200 (CEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used for cooling device binding
Date: Thu, 21 Sep 2023 20:01:43 +0200
Message-ID: <45837158.fMDQidcC6G@kreacher>
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

Add new helper functions, thermal_bind_cdev_to_trip() and
thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
binding a cooling device to a trip point and unbinding it, respectively,
and redefine the existing helpers, thermal_zone_bind_cooling_device()
and thermal_zone_unbind_cooling_device(), as wrappers around the new
ones, respectively.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   54 +++++++++++++++++++++++++----------------
 include/linux/thermal.h        |    8 ++++++
 2 files changed, 42 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -600,10 +600,9 @@ struct thermal_zone_device *thermal_zone
  */
 
 /**
- * thermal_zone_bind_cooling_device() - bind a cooling device to a thermal zone
+ * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip_index:	indicates which trip point the cooling devices is
- *		associated with in this thermal zone.
+ * @trip:	trip point the cooling devices is associated with in this zone.
  * @cdev:	pointer to struct thermal_cooling_device
  * @upper:	the Maximum cooling state for this trip point.
  *		THERMAL_NO_LIMIT means no upper limit,
@@ -621,8 +620,8 @@ struct thermal_zone_device *thermal_zone
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-				     int trip_index,
+int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
+				     const struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
@@ -631,15 +630,9 @@ int thermal_zone_bind_cooling_device(str
 	struct thermal_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
-	const struct thermal_trip *trip;
 	bool upper_no_limit;
 	int result;
 
-	if (trip_index >= tz->num_trips || trip_index < 0)
-		return -EINVAL;
-
-	trip = &tz->trips[trip_index];
-
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
 		if (pos1 == tz)
 			break;
@@ -736,14 +729,26 @@ free_mem:
 	kfree(dev);
 	return result;
 }
+EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
+
+int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
+				     int trip_index,
+				     struct thermal_cooling_device *cdev,
+				     unsigned long upper, unsigned long lower,
+				     unsigned int weight)
+{
+	if (trip_index < 0 || trip_index >= tz->num_trips)
+		return -EINVAL;
+
+	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
+					 upper, lower, weight);
+}
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
 
 /**
- * thermal_zone_unbind_cooling_device() - unbind a cooling device from a
- *					  thermal zone.
+ * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip_index:	indicates which trip point the cooling devices is
- *		associated with in this thermal zone.
+ * @trip:	trip point the cooling devices is associated with in this zone.
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
  * This interface function unbind a thermal cooling device from the certain
@@ -752,16 +757,14 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				       int trip_index,
-				       struct thermal_cooling_device *cdev)
+int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip,
+				  struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *pos, *next;
-	const struct thermal_trip *trip;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
-	trip = &tz->trips[trip_index];
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
@@ -784,6 +787,17 @@ unbind:
 	kfree(pos);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
+
+int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
+				       int trip_index,
+				       struct thermal_cooling_device *cdev)
+{
+	if (trip_index < 0 || trip_index >= tz->num_trips)
+		return -EINVAL;
+
+	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
+}
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
 
 static void thermal_release(struct device *dev)
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -320,10 +320,18 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
+int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip,
+			      struct thermal_cooling_device *cdev,
+			      unsigned long upper, unsigned long lower,
+			      unsigned int weight);
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
 				     unsigned int);
+int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip,
+				  struct thermal_cooling_device *cdev);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,




