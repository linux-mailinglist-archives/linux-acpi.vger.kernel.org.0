Return-Path: <linux-acpi+bounces-7142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F95941FDC
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A181C236D0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420A1AA3CF;
	Tue, 30 Jul 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="PkL3bOis"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71C1AA3C0;
	Tue, 30 Jul 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364897; cv=none; b=BwEphKdw/TT8xjIRalVENEYPJSWUOLMHgRWQ/kViL3QAZMFdzvye9h0PcPvuctqABcMiOrMCEOChR1bYboz37JSuykDzyIDmzjeCR9m1dMNNpACW8/sSg2SEWaKsgta5RwiNS9DAAv2UCg0e87Ubeah7TQLLZSJEol7jGNuWR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364897; c=relaxed/simple;
	bh=/D+6mF4WoUoIOgFnDdNwfI9NAMMRMfYs+QPiPg2rjqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZH3byBnM8aQceW9u6XE1ACOTxr2uiiMjfl6T0eXvRfIJo0igL5vRkm6Rgi2L6Vf8YaXJwX6Q4wnB4Wk0Iwr4M7jRxBqCcRWri1ocDSkGe6vIDqyUprmgr1rZONRdOfWi3BDOhwNHcMbSXMlmziAsRG1kIFLoVeodLeIEWgLjK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=PkL3bOis; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id f5a4c46a7cce13f3; Tue, 30 Jul 2024 20:41:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 29FB0956ED0;
	Tue, 30 Jul 2024 20:41:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722364892;
	bh=/D+6mF4WoUoIOgFnDdNwfI9NAMMRMfYs+QPiPg2rjqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkL3bOissDY++Mtq9TPvghc8PnoR/A1DctrrMilMjynDUpsFEgwKsW1dM3KPQ5Xx+
	 ia5qs89nzh3yDsYl0gAkd0HuQhejVaTR8NRPB0IGWSJIvtnHRBJc1WpObUKVb4tldw
	 Mi3lG8ZBaN/B7G/WdvlUy3Da7fDNc3QrEltbXNnFoqgEkl8jd8y805rsusQhcfYyf1
	 BnO7VcuBJXB+ChBBj7Hu+U14/QyswnjItn1OO04GGmZfmj/GIJav/Wu1L54ikyfSXv
	 ayJ5oOzweM+6+kCjQyBP/PWLP1NHQrOYOB3CvrDrwQY8Vckz/eJ2f5u7x9GdN8GSfz
	 p5gurAMwJIfpQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 16/17] thermal: code: Clean up trip bind/unbind functions
Date: Tue, 30 Jul 2024 20:41:31 +0200
Message-ID: <18551558.sWSEgdgrri@rjwysocki.net>
In-Reply-To: <1922131.tdWV9SEqCh@rjwysocki.net>
References: <1922131.tdWV9SEqCh@rjwysocki.net>
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
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make thermal_bind_cdev_to_trip() take a struct cooling_spec pointer
to reduce the number of its arguments, change the return type of
thermal_unbind_cdev_from_trip() to void and rearrange the code in
thermal_zone_cdev_binding() to reduce the indentation level.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   54 +++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -761,15 +761,7 @@ struct thermal_zone_device *thermal_zone
  * @tz:		pointer to struct thermal_zone_device
  * @trip:	trip point the cooling devices is associated with in this zone.
  * @cdev:	pointer to struct thermal_cooling_device
- * @upper:	the Maximum cooling state for this trip point.
- *		THERMAL_NO_LIMIT means no upper limit,
- *		and the cooling device can be in max_state.
- * @lower:	the Minimum cooling state can be used for this trip point.
- *		THERMAL_NO_LIMIT means no lower limit,
- *		and the cooling device can be in cooling state 0.
- * @weight:	The weight of the cooling device to be bound to the
- *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
- *		default value
+ * @c:		cooling specification for @trip and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -780,8 +772,7 @@ struct thermal_zone_device *thermal_zone
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower,
-				     unsigned int weight)
+				     struct cooling_spec *c)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
@@ -795,17 +786,17 @@ static int thermal_bind_cdev_to_trip(str
 		return -EINVAL;
 
 	/* lower default 0, upper default max_state */
-	if (lower == THERMAL_NO_LIMIT)
-		lower = 0;
+	if (c->lower == THERMAL_NO_LIMIT)
+		c->lower = 0;
 
-	if (upper == THERMAL_NO_LIMIT) {
-		upper = cdev->max_state;
+	if (c->upper == THERMAL_NO_LIMIT) {
+		c->upper = cdev->max_state;
 		upper_no_limit = true;
 	} else {
 		upper_no_limit = false;
 	}
 
-	if (lower > upper || upper > cdev->max_state)
+	if (c->lower > c->upper || c->upper > cdev->max_state)
 		return -EINVAL;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -815,11 +806,11 @@ static int thermal_bind_cdev_to_trip(str
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
-	dev->upper = upper;
+	dev->upper = c->upper;
 	dev->upper_no_limit = upper_no_limit;
-	dev->lower = lower;
+	dev->lower = c->lower;
 	dev->target = THERMAL_NO_TARGET;
-	dev->weight = weight;
+	dev->weight = c->weight;
 
 	result = ida_alloc(&tz->ida, GFP_KERNEL);
 	if (result < 0)
@@ -893,12 +884,10 @@ free_mem:
  * This interface function unbind a thermal cooling device from the certain
  * trip point of a thermal zone device.
  * This function is usually called in the thermal zone device .unbind callback.
- *
- * Return: 0 on success, the proper error value otherwise.
  */
-static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					 struct thermal_trip *trip,
-					 struct thermal_cooling_device *cdev)
+static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					  struct thermal_trip *trip,
+					  struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
@@ -921,7 +910,7 @@ static int thermal_unbind_cdev_from_trip
 
 	mutex_unlock(&cdev->lock);
 
-	return -ENODEV;
+	return;
 
 free:
 	device_remove_file(&tz->device, &pos->weight_attr);
@@ -929,7 +918,6 @@ free:
 	sysfs_remove_link(&tz->device.kobj, pos->name);
 	ida_free(&tz->ida, pos->id);
 	kfree(pos);
-	return 0;
 }
 
 static void thermal_release(struct device *dev)
@@ -968,7 +956,6 @@ static void thermal_zone_cdev_binding(st
 				      struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td;
-	int ret;
 
 	if (!tz->ops.should_bind)
 		return;
@@ -982,13 +969,14 @@ static void thermal_zone_cdev_binding(st
 			.lower = THERMAL_NO_LIMIT,
 			.weight = THERMAL_WEIGHT_DEFAULT
 		};
+		int ret;
 
-		if (tz->ops.should_bind(tz, trip, cdev, &c)) {
-			ret = thermal_bind_cdev_to_trip(tz, trip, cdev, c.upper,
-							c.lower, c.weight);
-			if (ret)
-				print_bind_err_msg(tz, trip, cdev, ret);
-		}
+		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+			continue;
+
+		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		if (ret)
+			print_bind_err_msg(tz, trip, cdev, ret);
 	}
 
 	mutex_unlock(&tz->lock);




