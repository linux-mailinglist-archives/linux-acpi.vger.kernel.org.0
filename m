Return-Path: <linux-acpi+bounces-7132-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A590941F65
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68F528348F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42018A6B9;
	Tue, 30 Jul 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tqrMCEkW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB118A6A9;
	Tue, 30 Jul 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363550; cv=none; b=WoVxErxhkkNMr0bJx4oVPTHxcOLumCkCEuiU51dHf51rePs0tsGlOjIXDEucavZVHZJWifHyGUk54v4PCnIojx2cwpHq2m0MLzZMi68frEpinNH66zbG2rIfTTR0qmYc7ra+iyDKdehAbUEMrv+YFkc5VcXVybcX/j1Me/o8Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363550; c=relaxed/simple;
	bh=Lw3o3WysVqe0lpIVzXtZiPYkXrCErMtGG0bqQ8x88U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaeM+7rAfwIsNEvBNCov8W3VcEVzsq/yfIWumdGG619471BYLHBBnivoGnkBIW5M6sQLc0O1OceXYRBYQnaQ/pcf/8DPdNUj1crJdCh2yhqsKraqhoyyEQWoM6U/s/zFP4Fd5wmRK/0pfY14AhKg3Ov2KJYWnP1JeP64PYBSv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tqrMCEkW reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 0046fc716da64a47; Tue, 30 Jul 2024 20:19:05 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0CDEF956ED1;
	Tue, 30 Jul 2024 20:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363545;
	bh=Lw3o3WysVqe0lpIVzXtZiPYkXrCErMtGG0bqQ8x88U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tqrMCEkW9MUaBV/SJg1+NhlZeUiFBqyPhm8gt1w9mVcSUZJAQPEZ7CDR7n4UHCGnD
	 AKTMQU7Q2T4t1oQ74Z0BugNJcCgdtLqYJmgLRr85heUDc51pH8S5Cib9C2/0cfXqvK
	 8Q3Nh+vaUswsf2h/rc3I6qa2SYJ4Ho/S2xk28n5E3e3ucqwQmDg7wmGyTuaxzsQSpz
	 iy2N0v+mAejiMdUS3Lo5fAzx3QJLRJLaRh0XTdkUehHr4yPSr33HF8hRHh2QJeopFt
	 f/rTa9dvk6+zBEAhahlGEm18teXlkQgloVmap/QeH0KvLjjXlPd2wIo/2Y1Nsvgqen
	 p3Qe4wOa2hPBw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 01/17] thermal: core: Fold two functions into their respective
 callers
Date: Tue, 30 Jul 2024 20:19:04 +0200
Message-ID: <14034461.RDIVbhacDa@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold bind_cdev() into __thermal_cooling_device_register() and bind_tz()
into thermal_zone_device_register_with_trips() to reduce code bloat and
make it somewhat easier to follow the code flow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   55 ++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -991,20 +991,6 @@ void print_bind_err_msg(struct thermal_z
 		tz->type, cdev->type, ret);
 }
 
-static void bind_cdev(struct thermal_cooling_device *cdev)
-{
-	int ret;
-	struct thermal_zone_device *pos = NULL;
-
-	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops.bind) {
-			ret = pos->ops.bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-		}
-	}
-}
-
 /**
  * __thermal_cooling_device_register() - register a new thermal cooling device
  * @np:		a pointer to a device tree node.
@@ -1100,7 +1086,13 @@ __thermal_cooling_device_register(struct
 	list_add(&cdev->node, &thermal_cdev_list);
 
 	/* Update binding information for 'this' new cdev */
-	bind_cdev(cdev);
+	list_for_each_entry(pos, &thermal_tz_list, node) {
+		if (pos->ops.bind) {
+			ret = pos->ops.bind(pos, cdev);
+			if (ret)
+				print_bind_err_msg(pos, cdev, ret);
+		}
+	}
 
 	list_for_each_entry(pos, &thermal_tz_list, node)
 		if (atomic_cmpxchg(&pos->need_update, 1, 0))
@@ -1338,25 +1330,6 @@ void thermal_cooling_device_unregister(s
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
-static void bind_tz(struct thermal_zone_device *tz)
-{
-	int ret;
-	struct thermal_cooling_device *pos = NULL;
-
-	if (!tz->ops.bind)
-		return;
-
-	mutex_lock(&thermal_list_lock);
-
-	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		ret = tz->ops.bind(tz, pos);
-		if (ret)
-			print_bind_err_msg(tz, pos, ret);
-	}
-
-	mutex_unlock(&thermal_list_lock);
-}
-
 static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 {
 	*delay_jiffies = msecs_to_jiffies(delay_ms);
@@ -1554,13 +1527,23 @@ thermal_zone_device_register_with_trips(
 	}
 
 	mutex_lock(&thermal_list_lock);
+
 	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
 	mutex_unlock(&tz->lock);
-	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
-	bind_tz(tz);
+	if (tz->ops.bind) {
+		struct thermal_cooling_device *cdev;
+
+		list_for_each_entry(cdev, &thermal_cdev_list, node) {
+			result = tz->ops.bind(tz, cdev);
+			if (result)
+				print_bind_err_msg(tz, cdev, result);
+		}
+	}
+
+	mutex_unlock(&thermal_list_lock);
 
 	thermal_zone_device_init(tz);
 	/* Update the new thermal zone and mark it as already updated. */




