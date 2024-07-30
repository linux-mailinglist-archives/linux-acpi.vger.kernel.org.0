Return-Path: <linux-acpi+bounces-7136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC36B941F7A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAF2B24E84
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5918B46E;
	Tue, 30 Jul 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VllSNXeU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13B188011;
	Tue, 30 Jul 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363719; cv=none; b=fuHA+kRZhnBG3bHvUYqBiPcwGpUh1sJp8zEKxSXlW0iOkMBw/6Ux13Xc96Hd0U/KmdoN9o5z3yytXamPjGDEn+jGIZ24TrnZrlrlIxTns3D4a4BAKQo6wQdbSz5dOLRjmthDs5GnzNzw/A9zFWdQRd6LZZDDfkQCumwTZP2rltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363719; c=relaxed/simple;
	bh=EfLcgc+QvrXR30l2a0w2IX5i1JNNXIEVvGDNJX6FF7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFE8NyLCDuwJxXHYaSmrDdkfEWR4OGlGUioQUX0rkWLn/FJ/pa8gBV9M97efsnYSWCPXi0d1ZCM9Udg53j5XTaHJC37pqPFdeBQYPyPyZx7bMSLsdzZ0RZfET9tWiIeEKLUtO7SZ58sRAphfqsb1Wu/baH3ttKUOwkKNV+XsRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VllSNXeU reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0dfcb0ba80d42fc1; Tue, 30 Jul 2024 20:21:55 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0014B956ED0;
	Tue, 30 Jul 2024 20:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363715;
	bh=EfLcgc+QvrXR30l2a0w2IX5i1JNNXIEVvGDNJX6FF7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VllSNXeUf4zhNmAzSs2NG9zYmxhD9H7roYO5WDQ+lKI4y9rGl0IDXpICELXT+5yav
	 cxmOW9HGr2vgJGS3+n063vWRGMBhlkpzS1sYQKRebRS8iOm880IHFJOhviq25+b3rX
	 xaON4/Ps3c2H5Uc+2tgmTqsRkV45Juc7IT42I8+iPtKShq03aMTg1JlCl6zSxNspr+
	 DfDI3EPb2tU6F2g0Tpfd7a5Y5y34T5ZM+CIRZSqXYJyqGYVeDJJYHXt5WkgvwfFKG0
	 TY+8VykkzeUHywEL+Rzr30IN/F5pnE7AL+bcLs3rODnTSF23oXPPM9diBVHFPJNmxh
	 yTSWZTvlFm95Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 07/17] thermal: core: Move thermal zone locking out of bind/unbind
 functions
Date: Tue, 30 Jul 2024 20:21:54 +0200
Message-ID: <2681296.7s5MMGUR32@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
acquire the thermal zone lock, the locking rules for their callers get
complicated.  In particular, the thermal zone lock cannot be acquired
in any code path leading to one of these functions even though it might
be useful to do so.

To address this, remove the thermal zone locking from both these
functions, add lockdep assertions for the thermal zone lock to both
of them and make their callers acquire the thermal zone lock instead.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c         |    2 +-
 drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -789,6 +789,7 @@ int thermal_bind_cdev_to_trip(struct the
 	int result;
 
 	lockdep_assert_held(&thermal_list_lock);
+	lockdep_assert_held(&tz->lock);
 
 	if (list_empty(&tz->node) || list_empty(&cdev->node))
 		return -EINVAL;
@@ -851,7 +852,6 @@ int thermal_bind_cdev_to_trip(struct the
 	if (result)
 		goto remove_trip_file;
 
-	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
 	list_for_each_entry(instance, &td->thermal_instances, trip_node) {
@@ -868,7 +868,6 @@ int thermal_bind_cdev_to_trip(struct the
 	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return 0;
 
@@ -892,11 +891,19 @@ int thermal_zone_bind_cooling_device(str
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
 {
+	int ret;
+
 	if (trip_index < 0 || trip_index >= tz->num_trips)
 		return -EINVAL;
 
-	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
-					 upper, lower, weight);
+	mutex_lock(&tz->lock);
+
+	ret = thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index].trip, cdev,
+					upper, lower, weight);
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
 
@@ -919,7 +926,8 @@ int thermal_unbind_cdev_from_trip(struct
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
-	mutex_lock(&tz->lock);
+	lockdep_assert_held(&tz->lock);
+
 	mutex_lock(&cdev->lock);
 
 	list_for_each_entry_safe(pos, next, &td->thermal_instances, trip_node) {
@@ -930,13 +938,11 @@ int thermal_unbind_cdev_from_trip(struct
 			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
 
 			mutex_unlock(&cdev->lock);
-			mutex_unlock(&tz->lock);
 			goto free;
 		}
 	}
 
 	mutex_unlock(&cdev->lock);
-	mutex_unlock(&tz->lock);
 
 	return -ENODEV;
 
@@ -954,10 +960,18 @@ int thermal_zone_unbind_cooling_device(s
 				       int trip_index,
 				       struct thermal_cooling_device *cdev)
 {
+	int ret;
+
 	if (trip_index < 0 || trip_index >= tz->num_trips)
 		return -EINVAL;
 
-	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
+	mutex_lock(&tz->lock);
+
+	ret = thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index].trip, cdev);
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
 
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
 		.thermal = thermal, .cdev = cdev, .bind = bind
 	};
 
-	return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
+	return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
 }
 
 static int




