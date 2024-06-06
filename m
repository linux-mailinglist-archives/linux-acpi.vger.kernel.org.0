Return-Path: <linux-acpi+bounces-6234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856F8FF1C0
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EC11F25449
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A019884A;
	Thu,  6 Jun 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ltzYZZvt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC719882E;
	Thu,  6 Jun 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690100; cv=none; b=LLdU4FtVAz8q6nJ2h0MsUju5HMSRswfnPc096i0K7Kt0N75vLGZfV/vah4MPSMv9L7pEOyKdj3qDeuUVaEZBVoLkqo5z6RvspDbPBYYeVpuaxQhGY+glzj89fuWpyKYM5A7Ho8BH5wsFZxdDxyPr3sh/FmoDKocUtPCGkkSDmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690100; c=relaxed/simple;
	bh=wg4h7O4jG8cXoH1WQWnL4PYOUK5fcD4JMUobVwTW6NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDqt7mZK87WeunA0xtS/xW1Fwubuf9i95cC2bXK22TKXp81kc/hJi3/Xkxl0hY2SdtC18RO6A5DsoSg8WzGgMK1/CWjKJWwisBs2JSCt6ddz9nGK9JBPwhNoGU1DU/YulLLa2dKxYnqwwuOOkhwyDDJxxAMtf275GOx85JPa3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ltzYZZvt reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id d6f453944614915e; Thu, 6 Jun 2024 18:08:15 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B3D106A6599;
	Thu,  6 Jun 2024 18:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1717690095;
	bh=wg4h7O4jG8cXoH1WQWnL4PYOUK5fcD4JMUobVwTW6NU=;
	h=From:To:Cc:Subject:Date;
	b=ltzYZZvtky3E15wzle5fdHwABVgEs9FAWVjXq+U5QeAAkWmOROiPiMq0qABDwGtba
	 AgfiO/0LEvscE/+x9T1+j5RINnieAygLZmhNdmiLKSbm3E/ruZVr/DsfMKveWLqBcU
	 tywbu3nt9wheRwEKarJtnv1sJrREDc3uz+667jUNwZZtul2elSr19hdSNpoFcL6u2+
	 FslzzNTe2M+YFG3j9tjQEfdjjnoGwR7FlqFzUpmEye5jKqoWgWcq2QlF8Gxx/IDFgs
	 rX0hJo8Qn40Zl+ayfKgXvA4Dfb2Iqs9jBou6uKvtzCx0JVZ5G2jSfDW0x+JSwdkXPD
	 v2ZwqXZVxZ1uA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Laura Nao <laura.nao@collabora.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v2] thermal: core: Do not fail cdev registration because of invalid
 initial state
Date: Thu, 06 Jun 2024 18:08:14 +0200
Message-ID: <6056838.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlrghurhgrrdhnrghosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgv
 rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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

Accordingly, modify __thermal_cooling_device_register() to avoid calling
thermal_debug_cdev_add() instead of returning an error if the initial
.get_cur_state() callback invocation fails.

Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()")
Closes: https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@collabora.com
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Instead of making the thermal debug code effectively ignore the invalid
     initial cooling device state, simply don't register thermal debugfs for
     a cooling device if its initial state returned by the driver's
     .get_cur_state() is invalid (Daniel).

Laura, please test this one even though I don't see why it wouldn't work for
you if the v1 did.

---
 drivers/thermal/thermal_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1001,7 +1001,7 @@ __thermal_cooling_device_register(struct
 
 	ret = cdev->ops->get_cur_state(cdev, &current_state);
 	if (ret)
-		goto out_cdev_type;
+		current_state = ULONG_MAX;
 
 	thermal_cooling_device_setup_sysfs(cdev);
 
@@ -1016,7 +1016,8 @@ __thermal_cooling_device_register(struct
 		return ERR_PTR(ret);
 	}
 
-	thermal_debug_cdev_add(cdev, current_state);
+	if (current_state <= cdev->max_state)
+		thermal_debug_cdev_add(cdev, current_state);
 
 	/* Add 'this' new cdev to the global cdev list */
 	mutex_lock(&thermal_list_lock);




