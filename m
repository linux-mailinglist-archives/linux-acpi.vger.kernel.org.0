Return-Path: <linux-acpi+bounces-6239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168AF8FF476
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 20:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 466C0B22D71
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2AC199387;
	Thu,  6 Jun 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LRBftX5x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74F198E74;
	Thu,  6 Jun 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697698; cv=none; b=l+DImWGznili8tB2O8DU/JL1fl8nwRjvN52RiGDUR+z27WG5H+K+fZgtNj1/ZW5C+KIFVll6+zFScNgBqmXv1tE1aabfyGvEF+tc78bsX/RTfKc5rlTb9+uNhHHhGs3FpFmfWw8PFVWJqg9agD9Pj5pX8l2FDQkc/DjssHz0QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697698; c=relaxed/simple;
	bh=M9XIPOULFDe6w6kGb/xahMh6Yl3IJasd1iK5x4l9yqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EN+3Y7WZeMXGAt6bkG3urpVmb69/AH7b2kl7sr4JVf67RtOvKtmgnJ+ysgbSkW5bECUdVCm3LFdx89qRm56Ym9aeWSWbMfTBC8rymoQz+RCmyy1KOm3LD9YkkIm5Tn431MmN1hMmQZTVpejT4zm3MDdYfl+1QHY668ALghf+PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LRBftX5x reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 436db8d5d006e18c; Thu, 6 Jun 2024 20:14:53 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 352946A65D2;
	Thu,  6 Jun 2024 20:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1717697693;
	bh=M9XIPOULFDe6w6kGb/xahMh6Yl3IJasd1iK5x4l9yqw=;
	h=From:To:Cc:Subject:Date;
	b=LRBftX5xDVJR0MW/8CQlboQhcFkEEFkZNIArPAVzKM7iV7dfh6+EnO3pNMNv8tOTG
	 /A2zwtBh7bhvJf+EOCLmNWo1qZ4thq6M3rOuhi1Jt8hV4f+iFBlS/DHSmcS31G555S
	 XpIwAR0ejTC3jYV724rc8wddTKWatK3XaQEcpSM3dWWje7NGND1uhazg6mjpdfTSnI
	 7TKHHSdX2myi62lLJ0DobgZhR4APtCoP1PcgPQAi3Qx+/XPaB8VM58y3dKcJwaN/XR
	 65XbwPrg6fk15ZocsOZblkzAA4A7Kh7zOSZ00Im/Az51O6W4ddSo+v2MJWlEJG7Kki
	 xZo0iqU895n4g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v3] thermal: core: Do not fail cdev registration because of invalid
 initial state
Date: Thu, 06 Jun 2024 20:14:52 +0200
Message-ID: <12456961.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhgruhhrrgdrnhgrohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v3] thermal: core: Do not fail cdev registration because of invalid initial state

It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass cooling
device state to thermal_debug_cdev_add()") causes the ACPI fan driver
to fail probing on some systems which turns out to be due to the _FST
control method returning an invalid value until _FSL is first evaluated
for the given fan.  If this happens, the .get_cur_state() cooling device
callback returns an error and __thermal_cooling_device_register() fails
as uses that callback after commit 31a0fa0019b0.

Arguably, _FST should not return an invalid value even if it is
evaluated before _FSL, so this may be regarded as a platform firmware
issue, but at the same time it is not a good enough reason for failing
the cooling device registration where the initial cooling device state
is only needed to initialize a thermal debug facility.

Accordingly, modify __thermal_cooling_device_register() to avoid
calling thermal_debug_cdev_add() instead of returning an error if the
initial .get_cur_state() callback invocation fails.

Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Add a comment to explain the initial state of a cooling device (Daniel).
     No functional changes.

v1 -> v2:
   * Instead of making the thermal debug code effectively ignore the invalid
     initial cooling device state, simply don't register thermal debugfs for
     a cooling device if its initial state returned by the driver's
     .get_cur_state() is invalid (Daniel).

Laura, please test this one even though I don't see why it wouldn't work for
you if the v1 did.

---
 drivers/thermal/thermal_core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -999,9 +999,17 @@ __thermal_cooling_device_register(struct
 	if (ret)
 		goto out_cdev_type;
 
+	/*
+	 * The cooling device's current state is only needed for debug
+	 * initialization below, so a failure to get it does not cause
+	 * the entire cooling device initialization to fail.  However,
+	 * the debug will not work for the device if its initial state
+	 * cannot be determined and drivers are responsible for ensuring
+	 * that this will not happen.
+	 */
 	ret = cdev->ops->get_cur_state(cdev, &current_state);
 	if (ret)
-		goto out_cdev_type;
+		current_state = ULONG_MAX;
 
 	thermal_cooling_device_setup_sysfs(cdev);
 
@@ -1016,7 +1024,8 @@ __thermal_cooling_device_register(struct
 		return ERR_PTR(ret);
 	}
 
-	thermal_debug_cdev_add(cdev, current_state);
+	if (current_state <= cdev->max_state)
+		thermal_debug_cdev_add(cdev, current_state);
 
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);




