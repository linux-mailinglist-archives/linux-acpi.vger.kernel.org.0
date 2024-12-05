Return-Path: <linux-acpi+bounces-9944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C07C9E554B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 13:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262D816B056
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4354F217F41;
	Thu,  5 Dec 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YpOQGx8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F1C3C03;
	Thu,  5 Dec 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401481; cv=none; b=pHKpf4PiVmRCt0Ey0UpHp8T1diWtSW6nrYTtzFpGqpC6PWbg9sWj1iIRowXMrY+7DCaBbUgP+HfiR+RhMpxzPUeQMY0btBfQ2piDrcLLr0rS2m60BbG0ZpayrcOkaJOTODWZXE6a30HdXLZSz3cuTg1dLVXerXjhiEGMba+2JTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401481; c=relaxed/simple;
	bh=6HOpsc625EGjC9PL02c3HToHWwFMARP9I2Vi0twgIrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnKNiHkdmZ76Z8I7IVRL4rOqykEhyTqXvtuPBhw3EMHqopwH930zy56G9Isqoe8wf28SlDtcEdWiw3/y8UIAwWhyYXy0QAcs+lyvcgBSI95PXVMt9k8Td1QLnc13seBDoNDnufIg+c9ADwtx2Wd3xeKdlhNfCrsWff4RgnfeiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YpOQGx8j; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id a11382d7935d7579; Thu, 5 Dec 2024 12:24:36 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 88CB515F00FF;
	Thu,  5 Dec 2024 12:24:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1733397876;
	bh=6HOpsc625EGjC9PL02c3HToHWwFMARP9I2Vi0twgIrs=;
	h=From:Subject:Date;
	b=YpOQGx8j1i8ximeDtP0jet2Kgcq/S07XVQDZoWoGp549h4TA9ib79Wzi+isWkIYLc
	 t4iehrv36QW2woWClLQ+SsKLY7EIDFI+9pYGQjActjoXR61TcZVvVSs1EFZCEaGh7j
	 +18l7IxfFBkbQ0Bs0FRJWoOLHksaltggG5peethbxmToy+CaH04pLxlqYqvmElJ6HU
	 l2AfzGk3tHQKvF4zmQ5LBbRMd4qScppx2pVimiM1zznpaSyyUK9w8D+kxDvqz8I4m7
	 ebhVOnB5aFrU186PGLbpgQI2VNwnqjQF6dHBSzFT6MRYasBFm1fLIPCtco7Za6CcO8
	 O1yMY0+NVLk+Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
Date: Thu, 05 Dec 2024 12:24:35 +0100
Message-ID: <5857066.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegoufhprghmkfhpucdlfedttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()

As stated by Len in [1], the extra delay added by msleep() to the
sleep time value passed to it can be significant, roughly between
1.5 ns on systems with HZ = 1000 and as much as 15 ms on systems with
HZ = 100, which is hardly acceptable, at least for small sleep time
values.

msleep(5) on the default HZ = 250 in Ubuntu on a modern PC takes about
12 ms.  This results in over 800 ms of spurious system resume delay on
systems such as the Dell XPS-13-9300, which use ASL Sleep(5ms) in a
tight loop.

Address this by using usleep_range() in acpi_os_sleep() instead of
msleep().  For short sleep times this is a no brainer, but even for
long sleeps usleep_range() should be preferred because timer wheel
timers are optimized for cancelation before they expire and this
particular timer is not going to be canceled.

Add at least 50 us on top of the requested sleep time in case the
timer can be subject to coalescing, which is consistent with what's
done in user space in this context [2], but for sleeps longer than 5 ms
use 1% of the requested sleep time for this purpose.

The rationale here is that longer sleeps don't need that much of a timer
precision as a rule and making the timer a more likely candidate for
coalescing in these cases is generally desirable.  It starts at 5 ms so
that the delta between the requested sleep time and the effective
deadline is a contiuous function of the former.

Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com/ [1]
Link: https://lore.kernel.org/linux-pm/
CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263
Reported-by: Len Brown <lenb@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The previous RFC version of this patch is here:

https://lore.kernel.org/linux-pm/5839859.DvuYhMxLoT@rjwysocki.net/

The difference between this version and the RFC is a changelog update
suggested by Len, the Closes: tag and the tags from Hans and Mario.

---
 drivers/acpi/osl.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -607,7 +607,27 @@ acpi_status acpi_os_remove_interrupt_han
 
 void acpi_os_sleep(u64 ms)
 {
-	msleep(ms);
+	u64 usec = ms * USEC_PER_MSEC, delta_us = 50;
+
+	/*
+	 * Use a hrtimer because the timer wheel timers are optimized for
+	 * cancelation before they expire and this timer is not going to be
+	 * canceled.
+	 *
+	 * Set the delta between the requested sleep time and the effective
+	 * deadline to at least 50 us in case there is an opportunity for timer
+	 * coalescing.
+	 *
+	 * Moreover, longer sleeps can be assumed to need somewhat less timer
+	 * precision, so sacrifice some of it for making the timer a more likely
+	 * candidate for coalescing by setting the delta to 1% of the sleep time
+	 * if it is above 5 ms (this value is chosen so that the delta is a
+	 * continuous function of the sleep time).
+	 */
+	if (ms > 5)
+		delta_us = (USEC_PER_MSEC / 100) * ms;
+
+	usleep_range(usec, usec + delta_us);
 }
 
 void acpi_os_stall(u32 us)




