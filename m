Return-Path: <linux-acpi+bounces-7134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB3941F6E
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E670B27B36
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0018A6C4;
	Tue, 30 Jul 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GVdkdFEy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C418A6A9;
	Tue, 30 Jul 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363617; cv=none; b=lI0JndUfkYqKoPJ2T3LkDOxl2WvaWSAD+GzFeIugq922aG22sRUNHQAdHiwzxtO/wZ4TQHqaAWIYDd1YfjNq77oPjvc9+9hYwRw/Yat9IHt51aTfGZp/iUzd96ZUFRTBhr63uGnhzlvXnAOS0y+v8PxYR7dqlVQFqMjGkrFlXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363617; c=relaxed/simple;
	bh=QVEw6rWBoxDjbvO18QM1Bapo8a9fIcuzys0JWKUXTVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKg1yVhb17ucpvanedanF/1/rkkjs5ru4fMV7LaHfollP0yKoh2QNemikCMD9N7DaIbxsLM7bGU118WlhrvagJ8AfcCuoA3ZQrb6JJamhPrjfkapEUaN3XArnaJrJ2Fv6gCvt2LI1AMRRwtkWd34rpFFOGqBWNKVQsWTlOEF87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GVdkdFEy reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d92c00fda7d97e56; Tue, 30 Jul 2024 20:20:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 34B9A956ED0;
	Tue, 30 Jul 2024 20:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363612;
	bh=QVEw6rWBoxDjbvO18QM1Bapo8a9fIcuzys0JWKUXTVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GVdkdFEybrFo9jtxvLHxotQm8CCgB0/v4o0UzAN9KG9lyU94sW5vJJr08ExmOQnIv
	 WvSGzv+4S/gNumCUkFQDYI3et9Y6PDjqL4NMGFsKMP6bOsBqJFD9mtq9aUC9hFMmjS
	 6b1Zpye2ZBzLXPrebgZpKuGjX39vVj97FV91NWXBTJGcukLL/o3c9praH8RZ62y13G
	 zgYwjJhi7dzXHBUpA415lCRKNA9QDDBFxLneSBeXR5x6rO41Rrn9Cskyj6tPIjgJDb
	 byrIWk6tTmjnQKnDHR9PUOgcjgBIYJ/x2qE/htGlJWpc1LUeq5gwwVcyQ6wkiz484X
	 XapWFSynRo4uw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 04/17] thermal: core: Clean up cdev binding/unbinding functions
Date: Tue, 30 Jul 2024 20:20:12 +0200
Message-ID: <3324744.oiGErgHkdL@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new label to thermal_bind_cdev_to_trip() and use it to eliminate
two redundant !result check from that function, rename a label in
thermal_unbind_cdev_from_trip() to reflect its actual purpose and
adjust some white space in these functions.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -806,6 +806,7 @@ int thermal_bind_cdev_to_trip(struct the
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
+
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
@@ -821,8 +822,7 @@ int thermal_bind_cdev_to_trip(struct the
 
 	dev->id = result;
 	sprintf(dev->name, "cdev%d", dev->id);
-	result =
-	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
+	result = sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
 	if (result)
 		goto release_ida;
 
@@ -849,24 +849,26 @@ int thermal_bind_cdev_to_trip(struct the
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
+
+	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {
 			result = -EEXIST;
-			break;
+			goto remove_weight_file;
 		}
-	if (!result) {
-		list_add_tail(&dev->tz_node, &tz->thermal_instances);
-		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
-		atomic_set(&tz->need_update, 1);
-
-		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
+
+	list_add_tail(&dev->tz_node, &tz->thermal_instances);
+	list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
+	atomic_set(&tz->need_update, 1);
+
+	thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
+
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
-	if (!result)
-		return 0;
+	return 0;
 
+remove_weight_file:
 	device_remove_file(&tz->device, &dev->weight_attr);
 remove_trip_file:
 	device_remove_file(&tz->device, &dev->attr);
@@ -914,6 +916,7 @@ int thermal_unbind_cdev_from_trip(struct
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
+
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
@@ -923,15 +926,16 @@ int thermal_unbind_cdev_from_trip(struct
 
 			mutex_unlock(&cdev->lock);
 			mutex_unlock(&tz->lock);
-			goto unbind;
+			goto free;
 		}
 	}
+
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
 	return -ENODEV;
 
-unbind:
+free:
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);




