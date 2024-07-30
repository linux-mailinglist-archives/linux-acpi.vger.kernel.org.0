Return-Path: <linux-acpi+bounces-7137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDC941F7F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55C9B255D0
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9518A6DF;
	Tue, 30 Jul 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ouYQfA6w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCD18A6A9;
	Tue, 30 Jul 2024 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363810; cv=none; b=qSCRylqLz4YsK0jxDqGtaNKdssfbvc6XKaDm8a8cNxbKz3NgqR3v7zerU1ssARna52wpi3v355RkQybxV4SchHyXkYjYdceFJP2ZaKnSn8G3/CX1pel9n8MB07Xp/BfldmPqg5rbTgqud3moOq3wsW8wHVeqoiypbIstTAUE+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363810; c=relaxed/simple;
	bh=Qb8br/vYDxwoplIJZm4RYBfSu7yRRiPHE51oAyH7OIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMdLMiYXq8zmEeO1oUrd/uCaDh38q576Apo2F/IwB36O2R5BguZUn//WsOH1R4U13PKJP/TmbvgxFYPFij3ekZP3bbUXdElAHKEOJs+CA9OUlFrvvUzyFUMf5yU0pjmmMLtD03Pk5/uTZpxSoEYZbhBa0ZqW5hIswD/XCOmzI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ouYQfA6w reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ff954b6e5b4296e5; Tue, 30 Jul 2024 20:23:26 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B69F7956ED0;
	Tue, 30 Jul 2024 20:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363806;
	bh=Qb8br/vYDxwoplIJZm4RYBfSu7yRRiPHE51oAyH7OIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouYQfA6wHHEqQMaqk/TnALI11BIN6PNxgeRzcBT43lZOMNU4590RioYBWqPet6XXj
	 AdcVgO19ClcxIR3FkKxZ8c7gb7vlYSD+SSW8zx5pOBh30nDc95rjOOt1ZdoxP4461B
	 UlSnKfKOkX3njOTlewE7Ote/967GR74RTpcuxO3/55AT0YV3Vm7YXunv+76ho9CEZd
	 q8SQ5WOt8tjwZZTgKpXQoIS4dLZQ4gE30l4XPci9ZGRiko6XB77rKVPmMVeLlJ+0X4
	 gokiaePiAvHkKc7cuKXALF6JRJzmLjM0YS/lUQVuUbZMthjQzPbb2DijGZcaZ7qVcW
	 ir4Tmq8mYRweQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 08/17] thermal: core: Introduce .should_bind() thermal zone
 callback
Date: Tue, 30 Jul 2024 20:23:25 +0200
Message-ID: <2902112.88bMQJbFj6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current design of the code binding cooling devices to trip points in
thermal zones is convoluted and hard to follow.

Namely, a driver that registers a thermal zone can provide .bind()
and .unbind() operations for it, which are required to call either
thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip(),
respectively, or thermal_zone_bind_cooling_device() and
thermal_zone_unbind_cooling_device(), respectively, for every relevant
trip point and the given cooling device.  Moreover, if .bind() is
provided and .unbind() is not, the cleanup necessary during the removal
of a thermal zone or a cooling device may not be carried out.

In other words, the core relies on the thermal zone owners to do the
right thing, which is error prone and far from obvious, even though all
of that is not really necessary.  Specifically, if the core could ask
the thermal zone owner, through a special thermal zone callback, whether
or not a given cooling device should be bound to a given trip point in
the given thermal zone, it might as well carry out all of the binding
and unbinding by itself.  In particular, the unbinding can be done
automatically without involving the thermal zone owner at all because
all of the thermal instances associated with a thermal zone or cooling
device going away must be deleted regardless.

Accordingly, introduce a new thermal zone operation, .should_bind(),
that can be invoked by the thermal core for a given thermal zone,
trip point and cooling device combination in order to check whether
or not the cooling device should be bound to the trip point at hand.
It takes an additional cooling_spec argument allowing the thermal
zone owner to specify the highest and lowest cooling states of the
cooling device and its weight for the given trip point binding.

Make the thermal core use this operation, if present, in the absence of
.bind() and .unbind().  Note that .should_bind() will be called under
the thermal zone lock.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |  106 +++++++++++++++++++++++++++++++----------
 include/linux/thermal.h        |   10 +++
 2 files changed, 92 insertions(+), 24 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -84,11 +84,21 @@ struct thermal_trip {
 
 struct thermal_zone_device;
 
+struct cooling_spec {
+	unsigned long upper;	/* Highest cooling state  */
+	unsigned long lower;	/* Lowest cooling state  */
+	unsigned int weight;	/* Cooling device weight */
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
 	int (*unbind) (struct thermal_zone_device *,
 		       struct thermal_cooling_device *);
+	bool (*should_bind) (struct thermal_zone_device *,
+			     const struct thermal_trip *,
+			     struct thermal_cooling_device *,
+			     struct cooling_spec *);
 	int (*get_temp) (struct thermal_zone_device *, int *);
 	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*change_mode) (struct thermal_zone_device *,
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1000,12 +1000,61 @@ static struct class *thermal_class;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
+			const struct thermal_trip *trip,
 			struct thermal_cooling_device *cdev, int ret)
 {
+	if (trip) {
+		dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
+			cdev->type, thermal_zone_trip_id(tz, trip), ret);
+		return;
+	}
+
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
 		tz->type, cdev->type, ret);
 }
 
+static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
+				      struct thermal_cooling_device *cdev)
+{
+	struct thermal_trip_desc *td;
+	int ret;
+
+	/*
+	 * Old-style binding. The .bind() callback is expected to call
+	 * thermal_bind_cdev_to_trip() under the thermal zone lock.
+	 */
+	if (tz->ops.bind) {
+		ret = tz->ops.bind(tz, cdev);
+		if (ret)
+			print_bind_err_msg(tz, NULL, cdev, ret);
+
+		return;
+	}
+
+	if (!tz->ops.should_bind)
+		return;
+
+	mutex_lock(&tz->lock);
+
+	for_each_trip_desc(tz, td) {
+		struct thermal_trip *trip = &td->trip;
+		struct cooling_spec c = {
+			.upper = THERMAL_NO_LIMIT,
+			.lower = THERMAL_NO_LIMIT,
+			.weight = THERMAL_WEIGHT_DEFAULT
+		};
+
+		if (tz->ops.should_bind(tz, trip, cdev, &c)) {
+			ret = thermal_bind_cdev_to_trip(tz, trip, cdev, c.upper,
+							c.lower, c.weight);
+			if (ret)
+				print_bind_err_msg(tz, trip, cdev, ret);
+		}
+	}
+
+	mutex_unlock(&tz->lock);
+}
+
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1101,13 +1150,8 @@ __thermal_cooling_device_register(struct
 	list_add(&cdev->node, &thermal_cdev_list);
 
 	/* Update binding information for 'this' new cdev */
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops.bind) {
-			ret = pos->ops.bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-		}
-	}
+	list_for_each_entry(pos, &thermal_tz_list, node)
+		thermal_zone_cdev_binding(pos, cdev);
 
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
@@ -1308,6 +1352,28 @@ unlock_list:
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
+static void thermal_zone_cdev_unbinding(struct thermal_zone_device *tz,
+					struct thermal_cooling_device *cdev)
+{
+	struct thermal_trip_desc *td;
+
+	/*
+	 * Old-style unbinding.  The .unbind callback is expected to call
+	 * thermal_unbind_cdev_from_trip() under the thermal zone lock.
+	 */
+	if (tz->ops.unbind) {
+		tz->ops.unbind(tz, cdev);
+		return;
+	}
+
+	mutex_lock(&tz->lock);
+
+	for_each_trip_desc(tz, td)
+		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+
+	mutex_unlock(&tz->lock);
+}
+
 /**
  * thermal_cooling_device_unregister - removes a thermal cooling device
  * @cdev:	the thermal cooling device to remove.
@@ -1334,10 +1400,8 @@ void thermal_cooling_device_unregister(s
 	list_del(&cdev->node);
 
 	/* Unbind all thermal zones associated with 'this' cdev */
-	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->ops.unbind)
-			tz->ops.unbind(tz, cdev);
-	}
+	list_for_each_entry(tz, &thermal_tz_list, node)
+		thermal_zone_cdev_unbinding(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1412,6 +1476,7 @@ thermal_zone_device_register_with_trips(
 					unsigned int polling_delay)
 {
 	const struct thermal_trip *trip = trips;
+	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *tz;
 	struct thermal_trip_desc *td;
 	int id;
@@ -1434,8 +1499,9 @@ thermal_zone_device_register_with_trips(
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops || !ops->get_temp) {
-		pr_err("Thermal zone device ops not defined\n");
+	if (!ops || !ops->get_temp || (ops->should_bind && ops->bind) ||
+	    (ops->should_bind && ops->unbind)) {
+		pr_err("Thermal zone device ops not defined or invalid\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1548,15 +1614,8 @@ thermal_zone_device_register_with_trips(
 	mutex_unlock(&tz->lock);
 
 	/* Bind cooling devices for this zone */
-	if (tz->ops.bind) {
-		struct thermal_cooling_device *cdev;
-
-		list_for_each_entry(cdev, &thermal_cdev_list, node) {
-			result = tz->ops.bind(tz, cdev);
-			if (result)
-				print_bind_err_msg(tz, cdev, result);
-		}
-	}
+	list_for_each_entry(cdev, &thermal_cdev_list, node)
+		thermal_zone_cdev_binding(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1650,8 +1709,7 @@ void thermal_zone_device_unregister(stru
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		if (tz->ops.unbind)
-			tz->ops.unbind(tz, cdev);
+		thermal_zone_cdev_unbinding(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 




