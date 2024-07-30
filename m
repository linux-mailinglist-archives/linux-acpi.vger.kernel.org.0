Return-Path: <linux-acpi+bounces-7145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F278F94200F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1C3B2406B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7B18C336;
	Tue, 30 Jul 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="h37in00x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CA18A6A6;
	Tue, 30 Jul 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365636; cv=none; b=kLMzjdm3TFaYq61Xq17+rOtI9bI9RtPdS68oszbbhRL9Ky1/RKgqtth840apU+lFa+S4wIGbAZGm8qgHKzU1A6t4pi/YdOf9PxMrjYpQTK5VJuEVVU06ESC5WiMDrzCfwKXafUMeTN0KLmWB6Kwpau+awebNf4bMrwfYt+KIcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365636; c=relaxed/simple;
	bh=I5wrTjPzvOPUuHHWt55opVDedTaKn57CVQVNchCQhtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1KHXTssELxjRKKFktZgs1D0lcR+1VtzgwmgoYOWvLRZ1zO3PJirlK5QXwgQwLEKjVShaDaOMTOwOQ2MSp8UISOmrZthDzyS7Fl3f7Ssfxg39DelbcNy0xJuhh9w4DwFobde9ciysap63+OmHONalzZ2vyQpG4RbJ54MxNO5oZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=h37in00x reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 699ee15891400e5b; Tue, 30 Jul 2024 20:53:52 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D7558956ED0;
	Tue, 30 Jul 2024 20:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722365632;
	bh=I5wrTjPzvOPUuHHWt55opVDedTaKn57CVQVNchCQhtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h37in00xKY3fBMT6E03gqcGGdwDXkncI5CwOvv+JYto0ZMQUS4FAxs3Txbia5SDPi
	 s/XdVpxm9Wjttoy0XDCqt14wcka26IiZZ+2UN1QO2FY51fFASUbD0naQn+3tLNRCBQ
	 q1WlhsAancbZ3/ViJ+UqoY6pLVG1YWndsx0bP+Qmsn29zbGHa8RKI3GTqblRDonyOI
	 ztygvZe9HsXgl7X9gANrQz+QI/tCqMPAgpLKxBF1lxyPhJRqsseNltsEZeHNRtsjCU
	 uLzN+a7iwXFn+EI62YndNYhgHZ+ZcpZFM5st04flV62Ae8KEnsutEQ/MnpIesIuTnw
	 IIWPfJdcjn7sw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 15/17] thermal: core: Drop unused bind/unbind functions and
 callbacks
Date: Tue, 30 Jul 2024 20:53:51 +0200
Message-ID: <39176179.J2Yia2DhmK@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=36 Fuz1=36 Fuz2=36

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more callers of thermal_zone_bind_cooling_device() and
thermal_zone_unbind_cooling_device(), so drop them along with all of
the corresponding headers, code and documentation.

Moreover, because the .bind() and .unbind() thermal zone callbacks would
only be used when the above functions, respectively, were called, drop
them as well along with all of the code related to them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/thermal/sysfs-api.rst |   52 -----------------
 drivers/thermal/thermal_core.c                 |   75 +------------------------
 include/linux/thermal.h                        |   10 ---
 3 files changed, 3 insertions(+), 134 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -884,28 +884,6 @@ free_mem:
 	return result;
 }
 
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-				     int trip_index,
-				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower,
-				     unsigned int weight)
-{
-	int ret;
-
-	if (trip_index < 0 || trip_index >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-
-	ret = thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
-					upper, lower, weight);
-
-	mutex_unlock(&tz->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
-
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
@@ -954,25 +932,6 @@ free:
 	return 0;
 }
 
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				       int trip_index,
-				       struct thermal_cooling_device *cdev)
-{
-	int ret;
-
-	if (trip_index < 0 || trip_index >= tz->num_trips)
-		return -EINVAL;
-
-	mutex_lock(&tz->lock);
-
-	ret = thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
-
-	mutex_unlock(&tz->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
-
 static void thermal_release(struct device *dev)
 {
 	struct thermal_zone_device *tz;
@@ -1001,14 +960,8 @@ void print_bind_err_msg(struct thermal_z
 			const struct thermal_trip *trip,
 			struct thermal_cooling_device *cdev, int ret)
 {
-	if (trip) {
-		dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
-			cdev->type, thermal_zone_trip_id(tz, trip), ret);
-		return;
-	}
-
-	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-		tz->type, cdev->type, ret);
+	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
+		cdev->type, thermal_zone_trip_id(tz, trip), ret);
 }
 
 static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
@@ -1017,18 +970,6 @@ static void thermal_zone_cdev_binding(st
 	struct thermal_trip_desc *td;
 	int ret;
 
-	/*
-	 * Old-style binding. The .bind() callback is expected to call
-	 * thermal_bind_cdev_to_trip() under the thermal zone lock.
-	 */
-	if (tz->ops.bind) {
-		ret = tz->ops.bind(tz, cdev);
-		if (ret)
-			print_bind_err_msg(tz, NULL, cdev, ret);
-
-		return;
-	}
-
 	if (!tz->ops.should_bind)
 		return;
 
@@ -1355,15 +1296,6 @@ static void thermal_zone_cdev_unbinding(
 {
 	struct thermal_trip_desc *td;
 
-	/*
-	 * Old-style unbinding.  The .unbind callback is expected to call
-	 * thermal_unbind_cdev_from_trip() under the thermal zone lock.
-	 */
-	if (tz->ops.unbind) {
-		tz->ops.unbind(tz, cdev);
-		return;
-	}
-
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td)
@@ -1497,8 +1429,7 @@ thermal_zone_device_register_with_trips(
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops || !ops->get_temp || (ops->should_bind && ops->bind) ||
-	    (ops->should_bind && ops->unbind)) {
+	if (!ops || !ops->get_temp) {
 		pr_err("Thermal zone device ops not defined or invalid\n");
 		return ERR_PTR(-EINVAL);
 	}
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -91,10 +91,6 @@ struct cooling_spec {
 };
 
 struct thermal_zone_device_ops {
-	int (*bind) (struct thermal_zone_device *,
-		     struct thermal_cooling_device *);
-	int (*unbind) (struct thermal_zone_device *,
-		       struct thermal_cooling_device *);
 	bool (*should_bind) (struct thermal_zone_device *,
 			     const struct thermal_trip *,
 			     struct thermal_cooling_device *,
@@ -246,12 +242,6 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
-int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
-				     struct thermal_cooling_device *,
-				     unsigned long, unsigned long,
-				     unsigned int);
-int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
-				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 
Index: linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/thermal/sysfs-api.rst
+++ linux-pm/Documentation/driver-api/thermal/sysfs-api.rst
@@ -251,56 +251,6 @@ temperature) and throttle appropriate de
     It deletes the corresponding entry from /sys/class/thermal folder and
     unbinds itself from all the thermal zone devices using it.
 
-1.3 interface for binding a thermal zone device with a thermal cooling device
------------------------------------------------------------------------------
-
-    ::
-
-	int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-		int trip, struct thermal_cooling_device *cdev,
-		unsigned long upper, unsigned long lower, unsigned int weight);
-
-    This interface function binds a thermal cooling device to a particular trip
-    point of a thermal zone device.
-
-    This function is usually called in the thermal zone device .bind callback.
-
-    tz:
-	  the thermal zone device
-    cdev:
-	  thermal cooling device
-    trip:
-	  indicates which trip point in this thermal zone the cooling device
-	  is associated with.
-    upper:
-	  the Maximum cooling state for this trip point.
-	  THERMAL_NO_LIMIT means no upper limit,
-	  and the cooling device can be in max_state.
-    lower:
-	  the Minimum cooling state can be used for this trip point.
-	  THERMAL_NO_LIMIT means no lower limit,
-	  and the cooling device can be in cooling state 0.
-    weight:
-	  the influence of this cooling device in this thermal
-	  zone.  See 1.4.1 below for more information.
-
-    ::
-
-	int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				int trip, struct thermal_cooling_device *cdev);
-
-    This interface function unbinds a thermal cooling device from a particular
-    trip point of a thermal zone device. This function is usually called in
-    the thermal zone device .unbind callback.
-
-    tz:
-	the thermal zone device
-    cdev:
-	thermal cooling device
-    trip:
-	indicates which trip point in this thermal zone the cooling device
-	is associated with.
-
 1.4 Thermal Zone Parameters
 ---------------------------
 
@@ -371,8 +321,6 @@ Thermal cooling device sys I/F, created
 
 Then next two dynamic attributes are created/removed in pairs. They represent
 the relationship between a thermal zone and its associated cooling device.
-They are created/removed for each successful execution of
-thermal_zone_bind_cooling_device/thermal_zone_unbind_cooling_device.
 
 ::
 




