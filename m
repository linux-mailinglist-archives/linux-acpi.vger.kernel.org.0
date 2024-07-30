Return-Path: <linux-acpi+bounces-7141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F0941FD4
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D471F24C12
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170A18E03B;
	Tue, 30 Jul 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oyu50oux"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996E18E021;
	Tue, 30 Jul 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364553; cv=none; b=gO2IUrJOSJI8T8p6mG8zqz9d76ieenpdbdMoeWeZHkM70io9jJ+YuDFt8mx2ZQtI4NdQqXj6d8lRxpbnik7mtr0c8NYVQpzTwmXNgfC5T2zE+smXQTH0bc0lX5IW2P9nZ/ccHiqzYsKskAhvhdq29AH7x5bsD6vc2/t3sxk/WUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364553; c=relaxed/simple;
	bh=4wojP9ZCpR4Hsd+s/sEjQKI3e5YgpIrqWY426/gncu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mym1p4zYzXVwpNOr1AKrJumF/fM9RFDXVXVTRcSkosJtgQc2aw/x8a4FSsy1USia4EDMxYc3l2UQvoZWTgiNWDikLEL+c/Me4MgtTaSnzsUelP+XqFEEiUyFBTY67VMGSaW6jEQ7If7u+djP4Q7Xal4mPIjdOXRmD+4INHjM6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oyu50oux reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3ae184a448c06880; Tue, 30 Jul 2024 20:35:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 56E17956ED0;
	Tue, 30 Jul 2024 20:35:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722364548;
	bh=4wojP9ZCpR4Hsd+s/sEjQKI3e5YgpIrqWY426/gncu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oyu50ouxGN2H6i57lr7A43hzXfkGx8NpIbLx9EOaIgZ5/hK6Ay/cDlaf4f0QPnNFJ
	 OnkoTqiAdoYmOxwkTBBcNQsv0BgJMO5d6qjILaO/zwb89NfEh1l+807YP5Phlk2W2C
	 t4p8DQ7Rv4uu6rG7EcpW/pbKV4t/jGitDCQzsDEqDHSZN8ZeXdS+wJYFsDAX0Wu/Ww
	 FgZlXp+DSu/VG8pTGn70o1DwaIAGx+xfd/rmPVlw6fiGLowp7UqVUvq5WKaMauhLnr
	 XaT+k1A8Yj6b1lzq6MVaptfpBetDDFeIuho3a2u+cDW4YytpP9jERGyFdD1CFgPmtv
	 Rk6B8qI7mu57g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 14/17] thermal/of:  Use the .should_bind() thermal zone callback
Date: Tue, 30 Jul 2024 20:35:48 +0200
Message-ID: <2731136.q0ZmV6gNhb@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the thermal_of driver use the .should_bind() thermal zone callback
to provide the thermal core with the information on whether or not to
bind the given cooling device to the given trip point in the given
thermal zone.  If it returns 'true', the thermal core will bind the
cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

This replaces the .bind() and .unbind() thermal zone callbacks which
assumed the same trip points ordering in the driver and in the thermal
core (that may not be true any more in the future).  The .bind()
callback would walk the given thermal zone's cooling maps to find all
of the valid trip point combinations with the given cooling device and
it would call thermal_zone_bind_cooling_device() for all of them using
trip point indices reflecting the ordering of the trips in the DT.

The .should_bind() callback still walks the thermal zone's cooling maps,
but it can use the trip object passed to it by the thermal core to find
the trip in question in the first place and then it uses the
corresponding 'cooling-device' entries to look up the given cooling
device.  To be able to match the trip object provided by the thermal
core to a specific device node, the driver sets the 'priv' field of each
trip to the corresponding device node pointer during initialization.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_of.c |  171 ++++++++++---------------------------------
 1 file changed, 41 insertions(+), 130 deletions(-)

Index: linux-pm/drivers/thermal/thermal_of.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_of.c
+++ linux-pm/drivers/thermal/thermal_of.c
@@ -20,37 +20,6 @@
 
 /***   functions parsing device tree nodes   ***/
 
-static int of_find_trip_id(struct device_node *np, struct device_node *trip)
-{
-	struct device_node *trips;
-	struct device_node *t;
-	int i = 0;
-
-	trips = of_get_child_by_name(np, "trips");
-	if (!trips) {
-		pr_err("Failed to find 'trips' node\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Find the trip id point associated with the cooling device map
-	 */
-	for_each_child_of_node(trips, t) {
-
-		if (t == trip) {
-			of_node_put(t);
-			goto out;
-		}
-		i++;
-	}
-
-	i = -ENXIO;
-out:
-	of_node_put(trips);
-
-	return i;
-}
-
 /*
  * It maps 'enum thermal_trip_type' found in include/linux/thermal.h
  * into the device tree binding of 'trip', property type.
@@ -119,6 +88,8 @@ static int thermal_of_populate_trip(stru
 
 	trip->flags = THERMAL_TRIP_FLAG_RW_TEMP;
 
+	trip->priv = np;
+
 	return 0;
 }
 
@@ -290,39 +261,9 @@ static struct device_node *thermal_of_zo
 	return tz_np;
 }
 
-static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_id,
-			       struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
-{
-	struct of_phandle_args cooling_spec;
-	int ret;
-
-	ret = of_parse_phandle_with_args(map_np, "cooling-device", "#cooling-cells",
-					 index, &cooling_spec);
-
-	if (ret < 0) {
-		pr_err("Invalid cooling-device entry\n");
-		return ret;
-	}
-
-	of_node_put(cooling_spec.np);
-
-	if (cooling_spec.args_count < 2) {
-		pr_err("wrong reference to cooling device, missing limits\n");
-		return -EINVAL;
-	}
-
-	if (cooling_spec.np != cdev->np)
-		return 0;
-
-	ret = thermal_zone_unbind_cooling_device(tz, trip_id, cdev);
-	if (ret)
-		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
-
-	return ret;
-}
-
-static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
-			     struct thermal_zone_device *tz, struct thermal_cooling_device *cdev)
+static bool thermal_of_get_cooling_spec(struct device_node *map_np, int index,
+					struct thermal_cooling_device *cdev,
+					struct cooling_spec *c)
 {
 	struct of_phandle_args cooling_spec;
 	int ret, weight = THERMAL_WEIGHT_DEFAULT;
@@ -334,104 +275,75 @@ static int __thermal_of_bind(struct devi
 
 	if (ret < 0) {
 		pr_err("Invalid cooling-device entry\n");
-		return ret;
+		return false;
 	}
 
 	of_node_put(cooling_spec.np);
 
 	if (cooling_spec.args_count < 2) {
 		pr_err("wrong reference to cooling device, missing limits\n");
-		return -EINVAL;
+		return false;
 	}
 
 	if (cooling_spec.np != cdev->np)
-		return 0;
-
-	ret = thermal_zone_bind_cooling_device(tz, trip_id, cdev, cooling_spec.args[1],
-					       cooling_spec.args[0],
-					       weight);
-	if (ret)
-		pr_err("Failed to bind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
-
-	return ret;
-}
-
-static int thermal_of_for_each_cooling_device(struct device_node *tz_np, struct device_node *map_np,
-					      struct thermal_zone_device *tz, struct thermal_cooling_device *cdev,
-					      int (*action)(struct device_node *, int, int,
-							    struct thermal_zone_device *, struct thermal_cooling_device *))
-{
-	struct device_node *tr_np;
-	int count, i, trip_id;
-
-	tr_np = of_parse_phandle(map_np, "trip", 0);
-	if (!tr_np)
-		return -ENODEV;
-
-	trip_id = of_find_trip_id(tz_np, tr_np);
-	if (trip_id < 0)
-		return trip_id;
-
-	count = of_count_phandle_with_args(map_np, "cooling-device", "#cooling-cells");
-	if (count <= 0) {
-		pr_err("Add a cooling_device property with at least one device\n");
-		return -ENOENT;
-	}
+		return false;
 
-	/*
-	 * At this point, we don't want to bail out when there is an
-	 * error, we will try to bind/unbind as many as possible
-	 * cooling devices
-	 */
-	for (i = 0; i < count; i++)
-		action(map_np, i, trip_id, tz, cdev);
+	c->lower = cooling_spec.args[0];
+	c->upper = cooling_spec.args[1];
+	c->weight = weight;
 
-	return 0;
+	return true;
 }
 
-static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
-					    struct thermal_cooling_device *cdev,
-					    int (*action)(struct device_node *, int, int,
-							  struct thermal_zone_device *, struct thermal_cooling_device *))
+static bool thermal_of_should_bind(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   struct thermal_cooling_device *cdev,
+				   struct cooling_spec *c)
 {
 	struct device_node *tz_np, *cm_np, *child;
-	int ret = 0;
+	bool result = false;
 
 	tz_np = thermal_of_zone_get_by_name(tz);
 	if (IS_ERR(tz_np)) {
 		pr_err("Failed to get node tz by name\n");
-		return PTR_ERR(tz_np);
+		return false;
 	}
 
 	cm_np = of_get_child_by_name(tz_np, "cooling-maps");
 	if (!cm_np)
 		goto out;
 
+	/* Look up the trip and the cdev in the cooling maps. */
 	for_each_child_of_node(cm_np, child) {
-		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
-		if (ret) {
+		struct device_node *tr_np;
+		int count, i;
+
+		tr_np = of_parse_phandle(map_np, "trip", 0);
+		if (tr_np != trip->priv) {
 			of_node_put(child);
-			break;
+			continue;
+		}
+
+		/* The trip has been found, look up the cdev. */
+		count = of_count_phandle_with_args(child, "cooling-device", "#cooling-cells");
+		if (count <= 0)
+			pr_err("Add a cooling_device property with at least one device\n");
+
+		for (i = 0; i < count; i++) {
+			result = thermal_of_get_cooling_spec(child, i, cdev, c);
+			if (result)
+				break;
 		}
+
+		of_node_put(child);
+		break;
 	}
 
 	of_node_put(cm_np);
 out:
 	of_node_put(tz_np);
 
-	return ret;
-}
-
-static int thermal_of_bind(struct thermal_zone_device *tz,
-			   struct thermal_cooling_device *cdev)
-{
-	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_bind);
-}
-
-static int thermal_of_unbind(struct thermal_zone_device *tz,
-			     struct thermal_cooling_device *cdev)
-{
-	return thermal_of_for_each_cooling_maps(tz, cdev, __thermal_of_unbind);
+	return result;
 }
 
 /**
@@ -502,8 +414,7 @@ static struct thermal_zone_device *therm
 
 	thermal_of_parameters_init(np, &tzp);
 
-	of_ops.bind = thermal_of_bind;
-	of_ops.unbind = thermal_of_unbind;
+	of_ops.should_bind = thermal_of_should_bind;
 
 	ret = of_property_read_string(np, "critical-action", &action);
 	if (!ret)




