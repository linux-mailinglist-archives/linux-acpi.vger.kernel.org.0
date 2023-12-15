Return-Path: <linux-acpi+bounces-2484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFABE815092
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 21:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C44285893
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Dec 2023 20:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A754654B;
	Fri, 15 Dec 2023 20:02:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EC4597B;
	Fri, 15 Dec 2023 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 5a013ed72259bd7c; Fri, 15 Dec 2023 21:02:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 56A03668B59;
	Fri, 15 Dec 2023 21:02:14 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 5/6] thermal: netlink: Pass thermal zone pointer to notify routines
Date: Fri, 15 Dec 2023 21:00:36 +0100
Message-ID: <1975810.PYKUYFuaPT@kreacher>
In-Reply-To: <4556052.LvFx2qVVIh@kreacher>
References: <4556052.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are several routines in the thermal netlink API that take a
thermal zone ID or a thermal zone type as their arguments, but from
their callers perspective it would be more convenient to pass a thermal
zone pointer to them and let them extract the necessary data from the
given thermal zone object by themselves.

Modify the code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |   10 +++++-----
 drivers/thermal/thermal_netlink.c |   21 +++++++++++----------
 drivers/thermal/thermal_netlink.h |   22 ++++++++++++----------
 3 files changed, 28 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -213,7 +213,7 @@ exit:
 	mutex_unlock(&tz->lock);
 	mutex_unlock(&thermal_governor_lock);
 
-	thermal_notify_tz_gov_change(tz->id, policy);
+	thermal_notify_tz_gov_change(tz, policy);
 
 	return ret;
 }
@@ -475,9 +475,9 @@ static int thermal_zone_device_set_mode(
 	mutex_unlock(&tz->lock);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
-		thermal_notify_tz_enable(tz->id);
+		thermal_notify_tz_enable(tz);
 	else
-		thermal_notify_tz_disable(tz->id);
+		thermal_notify_tz_disable(tz);
 
 	return ret;
 }
@@ -1386,7 +1386,7 @@ thermal_zone_device_register_with_trips(
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	thermal_notify_tz_create(tz->id, tz->type);
+	thermal_notify_tz_create(tz);
 
 	return tz;
 
@@ -1490,7 +1490,7 @@ void thermal_zone_device_unregister(stru
 
 	put_device(&tz->device);
 
-	thermal_notify_tz_delete(tz_id);
+	thermal_notify_tz_delete(tz);
 
 	wait_for_completion(&tz->removal);
 	kfree(tz);
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -288,30 +288,30 @@ out_free_msg:
 	return ret;
 }
 
-int thermal_notify_tz_create(int tz_id, const char *name)
+int thermal_notify_tz_create(const struct thermal_zone_device *tz)
 {
-	struct param p = { .tz_id = tz_id, .name = name };
+	struct param p = { .tz_id = tz->id, .name = tz->type };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_CREATE, &p);
 }
 
-int thermal_notify_tz_delete(int tz_id)
+int thermal_notify_tz_delete(const struct thermal_zone_device *tz)
 {
-	struct param p = { .tz_id = tz_id };
+	struct param p = { .tz_id = tz->id };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DELETE, &p);
 }
 
-int thermal_notify_tz_enable(int tz_id)
+int thermal_notify_tz_enable(const struct thermal_zone_device *tz)
 {
-	struct param p = { .tz_id = tz_id };
+	struct param p = { .tz_id = tz->id };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_ENABLE, &p);
 }
 
-int thermal_notify_tz_disable(int tz_id)
+int thermal_notify_tz_disable(const struct thermal_zone_device *tz)
 {
-	struct param p = { .tz_id = tz_id };
+	struct param p = { .tz_id = tz->id };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
 }
@@ -370,9 +370,10 @@ int thermal_notify_cdev_delete(int cdev_
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
 }
 
-int thermal_notify_tz_gov_change(int tz_id, const char *name)
+int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
+				 const char *name)
 {
-	struct param p = { .tz_id = tz_id, .name = name };
+	struct param p = { .tz_id = tz->id, .name = name };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_GOV_CHANGE, &p);
 }
Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -14,10 +14,10 @@ struct thermal_genl_cpu_caps {
 #ifdef CONFIG_THERMAL_NETLINK
 int __init thermal_netlink_init(void);
 void __init thermal_netlink_exit(void);
-int thermal_notify_tz_create(int tz_id, const char *name);
-int thermal_notify_tz_delete(int tz_id);
-int thermal_notify_tz_enable(int tz_id);
-int thermal_notify_tz_disable(int tz_id);
+int thermal_notify_tz_create(const struct thermal_zone_device *tz);
+int thermal_notify_tz_delete(const struct thermal_zone_device *tz);
+int thermal_notify_tz_enable(const struct thermal_zone_device *tz);
+int thermal_notify_tz_disable(const struct thermal_zone_device *tz);
 int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
 				const struct thermal_trip *trip);
 int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
@@ -27,7 +27,8 @@ int thermal_notify_tz_trip_change(const
 int thermal_notify_cdev_state_update(int cdev_id, int state);
 int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
 int thermal_notify_cdev_delete(int cdev_id);
-int thermal_notify_tz_gov_change(int tz_id, const char *name);
+int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
+				 const char *name);
 int thermal_genl_sampling_temp(int id, int temp);
 int thermal_genl_cpu_capability_event(int count,
 				      struct thermal_genl_cpu_caps *caps);
@@ -37,22 +38,22 @@ static inline int thermal_netlink_init(v
 	return 0;
 }
 
-static inline int thermal_notify_tz_create(int tz_id, const char *name)
+static inline int thermal_notify_tz_create(const struct thermal_zone_device *tz)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_delete(int tz_id)
+static inline int thermal_notify_tz_delete(const struct thermal_zone_device *tz)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_enable(int tz_id)
+static inline int thermal_notify_tz_enable(const struct thermal_zone_device *tz)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_disable(int tz_id)
+static inline int thermal_notify_tz_disable(const struct thermal_zone_device *tz)
 {
 	return 0;
 }
@@ -91,7 +92,8 @@ static inline int thermal_notify_cdev_de
 	return 0;
 }
 
-static inline int thermal_notify_tz_gov_change(int tz_id, const char *name)
+static inline int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
+					       const char *name)
 {
 	return 0;
 }




