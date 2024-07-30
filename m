Return-Path: <linux-acpi+bounces-7135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BBE941F74
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F39D284BF6
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F218A6D9;
	Tue, 30 Jul 2024 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vVvawjvk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403418A6A9;
	Tue, 30 Jul 2024 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363702; cv=none; b=alcRPZu8f6MQJBAVqBJQm8fMCXhdxxyPu+9l+8EpGhiQpnrShj5M9AC/Z71IrU1RM7kgF0ZE+4fHwabJGskgW21/ySJNWANM4rEdsmdHYW+GIxa6SAF//cpyB6/ujhiIJQyChqYf0MMm5QCV5ROdvOtpTyQMR3fKf1ttjH6nkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363702; c=relaxed/simple;
	bh=CKvQ8iDiDIfYBQ6/5zRM3967i5R58heLjA4LZbsMWL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8TD3BWVfr9YEc0+aDKCKHfPXiNHY5BAb9743EOkyM2jolqG25Hl/1Bh2AR6SFF7LlQai4j6oZZC1sPSXMne8eaks/k0gO8gTM+DBYVl8UEa552JlVYs87T1gXqLnfNVpFJkx5VSAZFSJS+441MLH5aUWL4PBG1dSfTGICCWkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vVvawjvk reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 27c3185a60cb1a52; Tue, 30 Jul 2024 20:21:38 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C4E32956ED0;
	Tue, 30 Jul 2024 20:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363698;
	bh=CKvQ8iDiDIfYBQ6/5zRM3967i5R58heLjA4LZbsMWL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vVvawjvk0Yip7Ji3KJPz3MhCbU3+zEb0B8QR/+YhOhkUHgptkTqWBvcbLuPsB3x3j
	 cdXb8Ivn9JpVnfehcQxVdDjO1z0nuVToznOZFrCtCeHjtYseSFmZYLA1rblxW+jLeh
	 QmCKpH6cPHsAVnUPAj2oVtceh73Fyk7c8dB158WdKLr8SeW8yAaMJDvwDE6xmWTa4n
	 /5fwb1gn+EPAhDEzg9myjbmpYY9yT0SFMcVCepP0cJhgtijkE1lWfzq2gI329q3z8E
	 aM/DpgsDmPQSsVrxHF75EsqpKp3Nw0Y+9YouXmtUy0NKpIrlXxZPq0KhcXhsk4GHOc
	 3Ggh5kQivC9rw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 06/17] thermal: sysfs: Use the dev argument in instance-related
 show/store
Date: Tue, 30 Jul 2024 20:21:37 +0200
Message-ID: <4588023.8F6SAcFxjW@rjwysocki.net>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=24 Fuz1=24 Fuz2=24

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two sysfs show/store functions for attributes representing thermal
instances, trip_point_show() and weight_store(), retrieve the thermal
zone pointer from the instance object at hand, but they may also get
it from their dev argument, which is more consistent with what the
other thermal sysfs functions do, so make them do so.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -836,13 +836,12 @@ void thermal_cooling_device_stats_reinit
 ssize_t
 trip_point_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_instance *instance;
 
-	instance =
-	    container_of(attr, struct thermal_instance, attr);
+	instance = container_of(attr, struct thermal_instance, attr);
 
-	return sprintf(buf, "%d\n",
-		       thermal_zone_trip_id(instance->tz, instance->trip));
+	return sprintf(buf, "%d\n", thermal_zone_trip_id(tz, instance->trip));
 }
 
 ssize_t
@@ -858,6 +857,7 @@ weight_show(struct device *dev, struct d
 ssize_t weight_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_instance *instance;
 	int ret, weight;
 
@@ -868,14 +868,13 @@ ssize_t weight_store(struct device *dev,
 	instance = container_of(attr, struct thermal_instance, weight_attr);
 
 	/* Don't race with governors using the 'weight' value */
-	mutex_lock(&instance->tz->lock);
+	mutex_lock(&tz->lock);
 
 	instance->weight = weight;
 
-	thermal_governor_update_tz(instance->tz,
-				   THERMAL_INSTANCE_WEIGHT_CHANGED);
+	thermal_governor_update_tz(tz, THERMAL_INSTANCE_WEIGHT_CHANGED);
 
-	mutex_unlock(&instance->tz->lock);
+	mutex_unlock(&tz->lock);
 
 	return count;
 }




