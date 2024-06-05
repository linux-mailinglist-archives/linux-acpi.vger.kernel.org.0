Return-Path: <linux-acpi+bounces-6205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEF8FD658
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 21:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69982287119
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934C144D2E;
	Wed,  5 Jun 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DNZ1Pomi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07391420BB;
	Wed,  5 Jun 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615051; cv=none; b=QML80XybCaaItizeiChEWcGLK3IKqU8y/zMBtl67JPVn/lkV7Q14Ws85mpfrI78PC8fKKnAfVi/CvkOmdc62KlFflu+Y+jnu2UWMNBoXjLJO3LzdEHnqOJv9w+0MBADAnvspSXSqr/BJUGIZOo0azTnU5r9+7vrMPb6aOWMOSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615051; c=relaxed/simple;
	bh=yYpHplzEsye8kf7WqC0u0zc6c/VEQwOHkTd7TJ2eSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKLw25lzvsbqe/cbNfDqsFzRLh2W7TnFEHEdvKf2lny3oosQd07TUAyicMma1Fhm23Ikau8ffMrrkyh2T1WH+iv9o/N2BqE64h/s92MLf4XD3SsQCrX0G+aMA3GDL7uwA2EB3aWErGSZ2zrcC/4w+cNawylId32Cy2gJaqlzNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DNZ1Pomi reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 456ddfee378ce88f; Wed, 5 Jun 2024 21:17:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id ACEC8D512D3;
	Wed,  5 Jun 2024 21:17:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1717615039;
	bh=yYpHplzEsye8kf7WqC0u0zc6c/VEQwOHkTd7TJ2eSrE=;
	h=From:To:Cc:Subject:Date;
	b=DNZ1PomiVvIv0QpJaNUplGgDKrquROEVkQMWQx9T+vS925/pefnhDfSNDMGExVW9U
	 mueLu1ifKRGI47/VHeKLOxd2fd/PdyRh3cYditPN7Tyx4jHJ0U/7LcidW1rdobEs6W
	 1gK39zR2Wrh/CNk9VYJPvPKEaxtNBPk5h2+q4M98EPvzqlzAdWAvCDabEon8GVB4mS
	 Vt3cDOHBFAq6T7rhwLGvzTzi//WiHgnBsWpmJCACKDVWD6oxYhMWPW//XJ5ly18i71
	 OxUdXCsW6DPxw9ZRsNgzSbuVG3spmGpMNCBrT8oAH4pS3BEyQJA1We8nP2C/ICtd6G
	 X8WkfMmmCggFw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Laura Nao <laura.nao@collabora.com>
Subject:
 [PATCH v1] thermal: core: Do not fail cdev registration because of invalid
 initial state
Date: Wed, 05 Jun 2024 21:17:17 +0200
Message-ID: <4569763.LvFx2qVVIh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgudefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggr
 segrrhhmrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
device state to thermal_debug_cdev_add()") causes the ACPI fan driver
to fail probing on some systems which turns out to be due to the _FST
control method returning an invalid value until _FSL is first evaluated
for the given fan.  If this happens, the .get_cur_state() cooling device
callback returns an error and __thermal_cooling_device_register() fails
as uses that callback after commit 31a0fa0019b0.

Arguably, _FST should not return an inavlid value even if it is
evaluated before _FSL, so this may be regarded as a platform firmware
issue, but at the same time it is not a good enough reason for failing
the cooling device registration where the initial cooling device state
is only needed to initialize a thermal debug facility.

Accordingly, modify __thermal_cooling_device_register() to pass a
negative state value to thermal_debug_cdev_add() instead of failing
if the initial .get_cur_state() callback invocation fails and adjust
the thermal debug code to ignore negative cooling device state values.

Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
Reported-by: Laura Nao <laura.nao@collabora.com>
Tested-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |   11 +++++++----
 drivers/thermal/thermal_debugfs.c |    7 ++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -964,7 +964,8 @@ __thermal_cooling_device_register(struct
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
-	unsigned long current_state;
+	unsigned long val;
+	int current_state;
 	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
@@ -1002,9 +1003,11 @@ __thermal_cooling_device_register(struct
 	if (ret)
 		goto out_cdev_type;
 
-	ret = cdev->ops->get_cur_state(cdev, &current_state);
-	if (ret)
-		goto out_cdev_type;
+	ret = cdev->ops->get_cur_state(cdev, &val);
+	if (!ret && val >= 0 && val <= INT_MAX)
+		current_state = val;
+	else
+		current_state = -1;
 
 	thermal_cooling_device_setup_sysfs(cdev);
 
Index: linux-pm/drivers/thermal/thermal_debugfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_debugfs.c
+++ linux-pm/drivers/thermal/thermal_debugfs.c
@@ -421,6 +421,8 @@ void thermal_debug_cdev_state_update(con
 	cdev_dbg = &thermal_dbg->cdev_dbg;
 
 	old_state = cdev_dbg->current_state;
+	if (old_state < 0)
+		goto unlock;
 
 	/*
 	 * Get the old state information in the durations list. If
@@ -463,6 +465,7 @@ void thermal_debug_cdev_state_update(con
 
 	cdev_dbg->total++;
 
+unlock:
 	mutex_unlock(&thermal_dbg->lock);
 }
 
@@ -499,7 +502,9 @@ void thermal_debug_cdev_add(struct therm
 	 * duration will be printed by cdev_dt_seq_show() as expected if it
 	 * runs before the first state transition.
 	 */
-	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations, state);
+	if (state >= 0)
+		thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg->durations,
+						state);
 
 	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
 			    thermal_dbg, &tt_fops);




