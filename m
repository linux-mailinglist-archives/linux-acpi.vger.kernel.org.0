Return-Path: <linux-acpi+bounces-7139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC53C941F97
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC12285874
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86689189B89;
	Tue, 30 Jul 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kxVpww3g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A31662F7;
	Tue, 30 Jul 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364417; cv=none; b=JyGN1IAy5kP3aufvGddljFzW4tEQdm+7xny0xfZH1upnKzOxIGBySuYvdsT/waYBp4JUozouUBW+YzHVYpbj1pxbVmg7meKHCztC7sARkMDbXdzGBXv/JEuxjlnGW6vz2AJ6R9sr3ZjxnBT4DBJyB5FFXg9gufRsQvPG8fgio+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364417; c=relaxed/simple;
	bh=1OBo5ac7UB980Vwp9IAp/IzlYLKbqDBtnTkktrSInEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWCGrbrw/vqJ1JlfGspO7NMrDSOKaV8lA5uq0YczYMD+NyfrdMt5yJvxeJbLxL/m04Gmzf4MEploucTbrPwKB30zzaUcWXe1a93aayQU83kBkiIzkhAIZFAWIr0vdLkxA0w5q0FvIJb+L47n329AWIc4Jvi+jSyXiBcbhS7cXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kxVpww3g reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 3b628da5022b9dc8; Tue, 30 Jul 2024 20:33:33 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8F388956ED0;
	Tue, 30 Jul 2024 20:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722364413;
	bh=1OBo5ac7UB980Vwp9IAp/IzlYLKbqDBtnTkktrSInEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxVpww3gkRboC5/DX5eRm0xJHayHx2aOJiphYQPpQguW7TuLOeex0kd/Uf5ny6kes
	 VnGxuEW1HxUVvoV+XlcqYv/lw064F8H0tenzVBDEkCbgViZwm6sCqYQ90ofKHpItPu
	 nEuUN2PFcfdeFvFgN8zmP1G9RdGjcGLpNC6YYMt/5LtHvgvAd2bkt3gM8tn8jS7MGV
	 2LfMOqF72Aqbu0kvd58EI7Cl63oMBsyKUU6dUYCbMYJMPqVWp8axrC0TBZRThAIfHJ
	 fuJF1DAR3aCdmJs8s9qgVMz1ohss7RcBLOJGmKhlOexbjk7hapenQQrv63ENwSBh9K
	 f6TCBAl6Tj85g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Peter Kaestle <peter@piie.net>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind() thermal zone
 callback
Date: Tue, 30 Jul 2024 20:33:32 +0200
Message-ID: <2242500.C4sosBPzcN@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphgvthgvrhesphhiihgvrdhnvghtpdhrtghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=32 Fuz1=32 Fuz2=32

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the acerhdf driver use the .should_bind() thermal zone
callback to provide the thermal core with the information on whether or
not to bind the given cooling device to the given trip point in the
given thermal zone.  If it returns 'true', the thermal core will bind
the cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

The previously existing acerhdf_bind() function bound cooling devices
to thermal trip point 0 only, so the new callback needs to return 'true'
for trip point 0.  However, it is straightforward to observe that trip
point 0 is an active trip point and the only other trip point in the
driver's thermal zone is a critical one, so it is sufficient to return
'true' from that callback if the type of the given trip point is
THERMAL_TRIP_ACTIVE.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch only depends on patch [09/17].

---
 drivers/platform/x86/acerhdf.c |   33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/platform/x86/acerhdf.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/acerhdf.c
+++ linux-pm/drivers/platform/x86/acerhdf.c
@@ -378,33 +378,13 @@ static int acerhdf_get_ec_temp(struct th
 	return 0;
 }
 
-static int acerhdf_bind(struct thermal_zone_device *thermal,
-			struct thermal_cooling_device *cdev)
+static bool acerhdf_should_bind(struct thermal_zone_device *thermal,
+				const struct thermal_trip *trip,
+				struct thermal_cooling_device *cdev,
+				struct cooling_spec *c)
 {
 	/* if the cooling device is the one from acerhdf bind it */
-	if (cdev != cl_dev)
-		return 0;
-
-	if (thermal_zone_bind_cooling_device(thermal, 0, cdev,
-			THERMAL_NO_LIMIT, THERMAL_NO_LIMIT,
-			THERMAL_WEIGHT_DEFAULT)) {
-		pr_err("error binding cooling dev\n");
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static int acerhdf_unbind(struct thermal_zone_device *thermal,
-			  struct thermal_cooling_device *cdev)
-{
-	if (cdev != cl_dev)
-		return 0;
-
-	if (thermal_zone_unbind_cooling_device(thermal, 0, cdev)) {
-		pr_err("error unbinding cooling dev\n");
-		return -EINVAL;
-	}
-	return 0;
+	return cdev == cl_dev && trip->type == THERMAL_TRIP_ACTIVE;
 }
 
 static inline void acerhdf_revert_to_bios_mode(void)
@@ -447,8 +427,7 @@ static int acerhdf_get_crit_temp(struct
 
 /* bind callback functions to thermalzone */
 static struct thermal_zone_device_ops acerhdf_dev_ops = {
-	.bind = acerhdf_bind,
-	.unbind = acerhdf_unbind,
+	.should_bind = acerhdf_should_bind,
 	.get_temp = acerhdf_get_ec_temp,
 	.change_mode = acerhdf_change_mode,
 	.get_crit_temp = acerhdf_get_crit_temp,




