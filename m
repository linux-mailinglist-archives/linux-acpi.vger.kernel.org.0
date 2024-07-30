Return-Path: <linux-acpi+bounces-7138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47D941F82
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE591C2332F
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88D18B49E;
	Tue, 30 Jul 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="W6FbsawK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7718B484;
	Tue, 30 Jul 2024 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363860; cv=none; b=dnNyK0Z7Eveit6HZOyhH6UPRXAWAinBU8wW6vN880iAi/D//dSqVdtdo0y7FVVfg9xJfyEDBhsFlmDX09WxKaGpXMBfChCgBh+u4djAnZj5BCDhIBhZR3Fe1vQd4ETZjnLBWpJ7VUycsaGxHOesP+YGbmhPOeORY65ID32eZmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363860; c=relaxed/simple;
	bh=fFf/gLPTjiOVMapVRfV5F0OVItXiQ3bssFo82sxe60E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjz4ftNLf9f8/OYUvdEqC6NNYnT6XgXeFEzwu74cZ2UIe3FOJqTQrbHylc17Lhx/1i6FvoipUX8YIWOu2jL3ukKYt9to2p0rZyfeQIlgKd06KOZ6qruMHFWjM6BLvK4SVfPK88CkUg8Ba++5cvVeDiZCIqnnKoeisWJq/Pcpfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=W6FbsawK reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 9863874557fb60af; Tue, 30 Jul 2024 20:24:16 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AED88956ED0;
	Tue, 30 Jul 2024 20:24:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363856;
	bh=fFf/gLPTjiOVMapVRfV5F0OVItXiQ3bssFo82sxe60E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W6FbsawKt9Eiy6U3xNtsFayIFTDehAc+mR6PMlbNHZl6iyhYn8GhBKYuQ2ylTSahy
	 lBHCAjM7oLZBzMcTOmDo7XpcdMzXD0WjR4Xty/hG1xw4T50dcfZlqosPa78veJ4qVv
	 7dreSYecVI6eUibbeMU7GMqQ/rzUrfDt3N0ASIGBEJOtAZYeJ7g5LgYcrMVTOUqPQx
	 tFxEVxomE71ugU1tzrkWnlDHXcMkW72yij7kq3/bUtLg98C3j5wEpzmJwJ9yjV+IIx
	 I6W30Mjf9RSQPuZmHUYaa0cBU6n8WuROCN4xdZ4pMDeQa0qcP4IA08PxtBC0CKJ8Pk
	 vW5TBG5P2E20w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peter Kaestle <peter@piie.net>,
 platform-driver-x86@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>
Subject:
 [PATCH v1 09/17] thermal: ACPI: Use the .should_bind() thermal zone callback
Date: Tue, 30 Jul 2024 20:24:15 +0200
Message-ID: <1869674.8hzESeGDPO@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
 pdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggv
X-DCC--Metrics: v370.home.net.pl 1024; Body=42 Fuz1=42 Fuz2=42

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI thermal zone driver use the .should_bind() thermal zone
callback to provide the thermal core with the information on whether or
not to bind the given cooling device to the given trip point in the
given thermal zone.  If it returns 'true', the thermal core will bind
the cooling device to the trip and the corresponding unbinding will be
taken care of automatically by the core on the removal of the involved
thermal zone or cooling device.

This replaces the .bind() and .unbind() thermal zone callbacks which
allows the code to be simplified quite significantly while providing
the same functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   64 ++++++-------------------------------------------
 1 file changed, 9 insertions(+), 55 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -558,77 +558,31 @@ static void acpi_thermal_zone_device_cri
 	thermal_zone_device_critical(thermal);
 }
 
-struct acpi_thermal_bind_data {
-	struct thermal_zone_device *thermal;
-	struct thermal_cooling_device *cdev;
-	bool bind;
-};
-
-static int bind_unbind_cdev_cb(struct thermal_trip *trip, void *arg)
+static bool acpi_thermal_should_bind_cdev(struct thermal_zone_device *thermal,
+					  const struct thermal_trip *trip,
+					  struct thermal_cooling_device *cdev,
+					  struct cooling_spec *c)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
-	struct acpi_thermal_bind_data *bd = arg;
-	struct thermal_zone_device *thermal = bd->thermal;
-	struct thermal_cooling_device *cdev = bd->cdev;
 	struct acpi_device *cdev_adev = cdev->devdata;
 	int i;
 
 	/* Skip critical and hot trips. */
 	if (!acpi_trip)
-		return 0;
+		return false;
 
 	for (i = 0; i < acpi_trip->devices.count; i++) {
 		acpi_handle handle = acpi_trip->devices.handles[i];
-		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
-
-		if (adev != cdev_adev)
-			continue;
 
-		if (bd->bind) {
-			int ret;
-
-			ret = thermal_bind_cdev_to_trip(thermal, trip, cdev,
-							THERMAL_NO_LIMIT,
-							THERMAL_NO_LIMIT,
-							THERMAL_WEIGHT_DEFAULT);
-			if (ret)
-				return ret;
-		} else {
-			thermal_unbind_cdev_from_trip(thermal, trip, cdev);
-		}
+		if (acpi_fetch_acpi_dev(handle) == cdev_adev)
+			return true;
 	}
 
-	return 0;
-}
-
-static int acpi_thermal_bind_unbind_cdev(struct thermal_zone_device *thermal,
-					 struct thermal_cooling_device *cdev,
-					 bool bind)
-{
-	struct acpi_thermal_bind_data bd = {
-		.thermal = thermal, .cdev = cdev, .bind = bind
-	};
-
-	return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
-}
-
-static int
-acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
-				 struct thermal_cooling_device *cdev)
-{
-	return acpi_thermal_bind_unbind_cdev(thermal, cdev, true);
-}
-
-static int
-acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
-				   struct thermal_cooling_device *cdev)
-{
-	return acpi_thermal_bind_unbind_cdev(thermal, cdev, false);
+	return false;
 }
 
 static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
-	.bind = acpi_thermal_bind_cooling_device,
-	.unbind	= acpi_thermal_unbind_cooling_device,
+	.should_bind = acpi_thermal_should_bind_cdev,
 	.get_temp = thermal_get_temp,
 	.get_trend = thermal_get_trend,
 	.hot = acpi_thermal_zone_device_hot,




