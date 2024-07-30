Return-Path: <linux-acpi+bounces-7152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF8942034
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53596B22BFE
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADC18A6B2;
	Tue, 30 Jul 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="K3vOaiVO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2051AA3C6;
	Tue, 30 Jul 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365902; cv=none; b=HGrkdm4uzCk9eDK3AcjCefkBhKL+i35yKBeA3gX7NhlqbV+LOhlxAcsU19OVq/UOgDFxvzRMzijMP/3s5dNMABAQJu6dpeULq4RRpHKjePbWOCKQGEtGoKteRRwClW3QTE6UdnsYeTNOZ2OJZgSUBsf0ryNjHOYRz/jW0I9D81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365902; c=relaxed/simple;
	bh=9sI8dLmpmLX69ixBYbjmN0+VshBfVmPHiYMC98pwSyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Df2Y1GMMAHl/pDWDsi9yZoErm8pzON2wS05h0raH3XAjgp31CyXsO+quAsZRVW/04bENJH2wyclSQ0pQw2lbW3qb9nqg7/WLgoV7SA1sX8OBNk454Uj2vuK6eimDTz0BNvoZ42DzCACChpF67WIr1//sJq9U4AjJkdurXVQ6T10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=K3vOaiVO reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ce24f7b150ca37d7; Tue, 30 Jul 2024 20:58:18 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C264B956ED0;
	Tue, 30 Jul 2024 20:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722365898;
	bh=9sI8dLmpmLX69ixBYbjmN0+VshBfVmPHiYMC98pwSyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3vOaiVO5LWRbFaB3YKtZkd6VqLXwhhPbwBsysX/xyeEeSzB0x/dAhKPkp9+joLnS
	 SveQFPeNUqgoDOenm++lN5Fi4ml4zJ1OdSlpdaPU8KCcRMQlhCVg+slbxIUOgrgs6h
	 mHbtYtGSXjkuqk7SZTGKItFglUJOOFSaacHp+omW2XYIhEaB4NUcPMsv01uvHqyanG
	 R55v0YEUWHK3GdWAYxmus/ILzRLBGkRQUrGfTQXJDLJNC8L2lh8JmgcbuAIQ9J+hCN
	 epMqq7OE/8NqpxMXMMXy9pDNo84LShYpNiptFjTbBBB45ojaqymews4tMGqqt/A91M
	 stuZqKucNZ+DQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 10/17] thermal: core: Unexport thermal_bind_cdev_to_trip() and
 thermal_unbind_cdev_from_trip()
Date: Tue, 30 Jul 2024 20:50:49 +0200
Message-ID: <5331091.6fTUFtlzNn@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=54 Fuz1=54 Fuz2=54

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
are only called locally in the thermal core now, they can be static,
so change their definitions accordingly and drop their headers from
the global thermal header file.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   10 ++++------
 include/linux/thermal.h        |    8 --------
 2 files changed, 4 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -777,7 +777,7 @@ struct thermal_zone_device *thermal_zone
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
+static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 				     struct thermal_trip *trip,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
@@ -883,7 +883,6 @@ free_mem:
 	kfree(dev);
 	return result;
 }
-EXPORT_SYMBOL_GPL(thermal_bind_cdev_to_trip);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip_index,
@@ -919,9 +918,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev)
+static int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
+					 struct thermal_trip *trip,
+					 struct thermal_cooling_device *cdev)
 {
 	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
@@ -954,7 +953,6 @@ free:
 	kfree(pos);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(thermal_unbind_cdev_from_trip);
 
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 				       int trip_index,
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -246,18 +246,10 @@ const char *thermal_zone_device_type(str
 int thermal_zone_device_id(struct thermal_zone_device *tzd);
 struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 
-int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-			      struct thermal_trip *trip,
-			      struct thermal_cooling_device *cdev,
-			      unsigned long upper, unsigned long lower,
-			      unsigned int weight);
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
 				     unsigned int);
-int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-				  struct thermal_trip *trip,
-				  struct thermal_cooling_device *cdev);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,




