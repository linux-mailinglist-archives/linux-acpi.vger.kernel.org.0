Return-Path: <linux-acpi+bounces-7130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEF941F5D
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443A31C228B5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B718B468;
	Tue, 30 Jul 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vP3XFBnN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF8187FF9;
	Tue, 30 Jul 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363439; cv=none; b=K7128NheArvC4nwZgw+qDkddP2VkIDEj28Mg3RaG8UnNqsZuPBtI9aNs4xRXEeSX88bzlcxF8+5xk1LpgCMeYXCQMHXdRhvdHe91/rEtS2Kbjonad5cq6NLBCj5B8vfUXByWg0EFNVonl4GCGtxGieOVSK+Hz/ZCftU/5wiH4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363439; c=relaxed/simple;
	bh=c9eTD1l1BXML5l9sgGPaC0hgzN5RssSinVU7S9llI8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD/LpBaaTLbjT73k8sTUqyyIr+vRkDcYe1qKG93P4XrTt+SY8A0p/ZQ43zHUBf7knLXZRRYh+qu3FyQWN4brhFUqni4ltUk17joZasz3Dlk5GB27dFKS3oksHM1yC++dLuCx3EaxXLm5c0OMAL4BRZUunO2kuIeQRxT+X7uguec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vP3XFBnN reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id a344f6141c964dfd; Tue, 30 Jul 2024 20:17:08 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C1E40956ED0;
	Tue, 30 Jul 2024 20:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363428;
	bh=c9eTD1l1BXML5l9sgGPaC0hgzN5RssSinVU7S9llI8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vP3XFBnNO0NyIWlkfESY7GPxhQErGbTfo6ezXEi5HEykC6ItuxJT/wXBooX/SV600
	 vWfhYvTuESzPbgNda4733Z/W2GdV+hGwI13sBGqBUF+rhKqOgMrj0AFBkxxu8/m3ZR
	 ATuR7As/bibxCkOyuhdliFMgIQhfvInTbbHjXJs5sD0lahkHh+q3fqLtOVpnFYHOpW
	 NpzYLPnGOFY/dipO21FqSAbZpE3w2nucZ0MMy2f3o0VEuasFjVB/BxPB4r2XbbvVVZ
	 QbCsOFx/5h8h9UDEACB5e6uF7RAiNEs7b0Y++m+QtZ7xoCZ1wyBE3u8hbWQVD9a++f
	 gEYgZqPetHyrA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 17/17] thermal: code: Pass trip descriptors to trip bind/unbind
 functions
Date: Tue, 30 Jul 2024 20:16:48 +0200
Message-ID: <3134863.CbtlEUcBR6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code is somewhat cleaner if struct thermal_trip_desc pointers are
passed to thermal_bind_cdev_to_trip(), thermal_unbind_cdev_from_trip(),
and print_bind_err_msg() instead of struct thermal_trip pointers, so
modify it accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -759,9 +759,9 @@ struct thermal_zone_device *thermal_zone
 /**
  * thermal_bind_cdev_to_trip - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to bind @cdev to
  * @cdev:	pointer to struct thermal_cooling_device
- * @c:		cooling specification for @trip and @cdev
+ * @c:		cooling specification for the trip point and @cdev
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -770,11 +770,10 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 static int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
-				     struct thermal_trip *trip,
+				     struct thermal_trip_desc *td,
 				     struct thermal_cooling_device *cdev,
 				     struct cooling_spec *c)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *dev, *instance;
 	bool upper_no_limit;
 	int result;
@@ -805,7 +804,7 @@ static int thermal_bind_cdev_to_trip(str
 
 	dev->tz = tz;
 	dev->cdev = cdev;
-	dev->trip = trip;
+	dev->trip = &td->trip;
 	dev->upper = c->upper;
 	dev->upper_no_limit = upper_no_limit;
 	dev->lower = c->lower;
@@ -878,7 +877,7 @@ free_mem:
 /**
  * thermal_unbind_cdev_from_trip - unbind a cooling device from a thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip:	trip point the cooling devices is associated with in this zone.
+ * @td:		descriptor of the trip point to unbind @cdev from
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
  * This interface function unbind a thermal cooling device from the certain
@@ -886,10 +885,9 @@ free_mem:
  * This function is usually called in the thermal zone device .unbind callback.
  */
 static void thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
-					  struct thermal_trip *trip,
+					  struct thermal_trip_desc *td,
 					  struct thermal_cooling_device *cdev)
 {
-	struct thermal_trip_desc *td = trip_to_trip_desc(trip);
 	struct thermal_instance *pos, *next;
 
 	lockdep_assert_held(&tz->lock);
@@ -945,11 +943,11 @@ static struct class *thermal_class;
 
 static inline
 void print_bind_err_msg(struct thermal_zone_device *tz,
-			const struct thermal_trip *trip,
+			const struct thermal_trip_desc *td,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding cdev %s to trip %d failed: %d\n",
-		cdev->type, thermal_zone_trip_id(tz, trip), ret);
+		cdev->type, thermal_zone_trip_id(tz, &td->trip), ret);
 }
 
 static void thermal_zone_cdev_binding(struct thermal_zone_device *tz,
@@ -963,7 +961,6 @@ static void thermal_zone_cdev_binding(st
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td) {
-		struct thermal_trip *trip = &td->trip;
 		struct cooling_spec c = {
 			.upper = THERMAL_NO_LIMIT,
 			.lower = THERMAL_NO_LIMIT,
@@ -971,12 +968,12 @@ static void thermal_zone_cdev_binding(st
 		};
 		int ret;
 
-		if (!tz->ops.should_bind(tz, trip, cdev, &c))
+		if (!tz->ops.should_bind(tz, &td->trip, cdev, &c))
 			continue;
 
-		ret = thermal_bind_cdev_to_trip(tz, trip, cdev, &c);
+		ret = thermal_bind_cdev_to_trip(tz, td, cdev, &c);
 		if (ret)
-			print_bind_err_msg(tz, trip, cdev, ret);
+			print_bind_err_msg(tz, td, cdev, ret);
 	}
 
 	mutex_unlock(&tz->lock);
@@ -1287,7 +1284,7 @@ static void thermal_zone_cdev_unbinding(
 	mutex_lock(&tz->lock);
 
 	for_each_trip_desc(tz, td)
-		thermal_unbind_cdev_from_trip(tz, &td->trip, cdev);
+		thermal_unbind_cdev_from_trip(tz, td, cdev);
 
 	mutex_unlock(&tz->lock);
 }




