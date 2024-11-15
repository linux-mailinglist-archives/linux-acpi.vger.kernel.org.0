Return-Path: <linux-acpi+bounces-9604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E19CF67B
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 22:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC1B286836
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAB31E2315;
	Fri, 15 Nov 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XwGHXTes"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BA187876;
	Fri, 15 Nov 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704477; cv=none; b=BnGAWcTbS/i5OYYpkNhJKdxkTX2cISjF9CeyVgBVuVqx6H8U/DNdJFG8P1WmW0r5393/Vy2LIyARLzigOTLXHx1Zv1ZsqNJz7ekGYbgAxd6E6yX2zXNqE9rM4ZaP+8w/11Kedw6Y8ajozZ6rq8Hap9bRrkWsEtKXlP5UxBLKzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704477; c=relaxed/simple;
	bh=yK9zm26dZQmpqsVLsOYysVBEsX34ShNxGUog0gTn6/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tw+0iP+cAESt/F0J7TdyiaCjK6emgz3jrfHXhWAt/LR283nYEbY/XjFf044FP+PHCxrIduUCRNrZaSPcDoXQbW06BUhzf51HePsprBj4e+Y7aWkfUAi6p1M7pxw0urcezEkuQjWtR+F3GbiQPlBD3uDuBpGfGGd1aWg6L5uRM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XwGHXTes reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 6c6606f39a3dc5a1; Fri, 15 Nov 2024 22:01:06 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3A3D4851B10;
	Fri, 15 Nov 2024 22:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731704466;
	bh=yK9zm26dZQmpqsVLsOYysVBEsX34ShNxGUog0gTn6/8=;
	h=From:Subject:Date;
	b=XwGHXTesMJsrOHtToV4Ym4i3kAV8WR4W8Mmea+la4z0NBwHxoirfWuUYmo9yBFNb9
	 kaiVYegHoU7G49PRklSi4oy+9SUO06TjPRyFIa6GTN9CW5cebC8gZHkMUs3Em0f7Va
	 UVQ0aA0/iEqGDwzZLhDJsfFwX0Yz3FZDvzDVPRJq2Ai3lgCwZYDVWRaanDpsynIE8L
	 w5Z+CfhYVdnkcjZGrKL2CYAs++IgMDed2aWxowERc5gXzvPxF/tMM1y6No8MHdBQIb
	 5fJe/glavIHrhyVnKMY08XHjqATah+Nsyx3NJQM+7DanR6ex3gNRzJmLWWjrprnOxW
	 wdS4LTYTWT9Fw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v2 1/2] cpuidle: Do not return from cpuidle_play_dead() on callback
 failures
Date: Fri, 15 Nov 2024 21:58:31 +0100
Message-ID: <3318440.aeNJFYEL58@rjwysocki.net>
In-Reply-To: <13636465.uLZWGnKmhe@rjwysocki.net>
References: <13636465.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggddugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghtrhihkhdrfihlrgiilhihnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphh
X-DCC--Metrics: v370.home.net.pl 0; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the :enter_dead() idle state callback fails for a certain state,
there may be still a shallower state for which it will work.

Because the only caller of cpuidle_play_dead(), native_play_dead(),
falls back to hlt_play_dead() if it returns an error, it should
better try all of the idle states for which :enter_dead() is present
before failing, so change it accordingly.

Also notice that the :enter_dead() state callback is not expected
to return on success (the CPU should be "dead" then), so make
cpuidle_play_dead() ignore its return value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # 6.12-rc7
---

v1 -> v2:
   * Make cpuidle_play_dead() never return 0.
   * Add tags from Mario (I have added them because the change of the patch
     should not make a practical difference, but if you want them to be
     dropped, please let me know).

---
 drivers/cpuidle/cpuidle.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -69,11 +69,15 @@ int cpuidle_play_dead(void)
 	if (!drv)
 		return -ENODEV;
 
-	/* Find lowest-power state that supports long-term idle */
-	for (i = drv->state_count - 1; i >= 0; i--)
+	for (i = drv->state_count - 1; i >= 0; i--) {
 		if (drv->states[i].enter_dead)
-			return drv->states[i].enter_dead(dev, i);
+			drv->states[i].enter_dead(dev, i);
+	}
 
+	/*
+	 * If :enter_dead() is successful, it will never return, so reaching
+	 * here means that all of them failed above or were not present.
+	 */
 	return -ENODEV;
 }
 




