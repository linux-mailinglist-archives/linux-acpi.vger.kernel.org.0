Return-Path: <linux-acpi+bounces-9713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070939D4D90
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EB21F21358
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096D1D86F1;
	Thu, 21 Nov 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="XpunXTwP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A361D7994;
	Thu, 21 Nov 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194912; cv=none; b=egu3zyvzbYZoiw7scIvFTjypPtcaOtl02ZfszHFpYJ324qQ808lgS6jL6DVyktTXrrbnZFhNPiY5CxHpXX+ULnCqxsEWJ4M1kETPLhcB5iTub2MzmuiX9hXtyW8iYB/14vr+js9NMVTTYS+OyLqY4xIq/mp843Zt7rplLjCl4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194912; c=relaxed/simple;
	bh=XLkXT/TGAeY7kklfNbJ6h2NBpv3lbfCGvZ+Thptz5l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g1qheK3yl49roEGrF/hpD/rMeEQX2QPf7k2L2LtNNMBj0MvPHw56wcf+cncn7GRXU3PkbUwQEK3l9iHMH0QKGEvsEjRizlaeCqBRgR6JwXPgNcj2hNPh3bT9ofKrCDIoZzzApYnWvCBe4vlHRM7Iia0dWXHeordvn4UMUU29DSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=XpunXTwP reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 46089e4d199c0ed7; Thu, 21 Nov 2024 14:15:01 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EE3169119C0;
	Thu, 21 Nov 2024 14:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1732194901;
	bh=XLkXT/TGAeY7kklfNbJ6h2NBpv3lbfCGvZ+Thptz5l4=;
	h=From:Subject:Date;
	b=XpunXTwPhUpr1udOYVBw1+ULZPa4aq67URoBST3e/TkrGbjbAbwUE2UPcl3odYHm7
	 EFyZif00ohAwh/MwWDe5M89kpV3oO8QG95Bb+Vea+r5AwQEm/foFq+IbLhmyoEIvJ6
	 lmph5FmQFhyWJM4/NQDc/jaNSo7ePnLiIDOafOa6RLqZEGzten/eve6SdW27WVfltI
	 w3udc9hN1DaeELR57lP+DSHnv0kEHQQqW0jOh5+I8yBm7WwkaBU0/yqcF72XuagldV
	 7wDxCog8fUoqzb0hQkYKV2+zJanxned/TgQEfCfG5VQpQu5w+9e6FmkJazNuKWtD30
	 oOChqUAiGPK+A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject:
 [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
Date: Thu, 21 Nov 2024 14:15:00 +0100
Message-ID: <5839859.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopegrrhhjrghnseh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As stated by Len in [1], the extra delay added by msleep() to the
sleep time value passed to it can be significant, roughly between
1.5 ns on systems with HZ = 1000 and as much as 15 ms on systems with
HZ = 100, which is hardly acceptable, at least for small sleep time
values.

Address this by using usleep_range() in acpi_os_sleep() instead of
msleep().  For short sleep times this is a no-brainer, but even for
long sleeps usleep_range() should be preferred because timer wheel
timers are optimized for cancellation before they expire and this
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
Link: https://lore.kernel.org/linux-pm/CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
Reported-by: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a follow-up to the discussion started by [1] above and since
the beginning of it I have changed my mind a bit, as you can see.

Given Arjan's feedback, I've concluded that using usleep_range() for
all sleep values is the right choice and that some slack should be
used there.  I've taken 50 us as the minimum value of it because that's
what is used in user space FWICT and I'm not convinced that shorter
values would be suitable here.

The other part, using 1% of the sleep time as the slack for longer
sleeps, is likely more controversial.  It is roughly based on the
observation that if one timer interrupt is sufficient for something,
then using two of them will be wasteful even if this is just somewhat.

Anyway, please let me know what you think.  I'd rather do whatever
the majority of you are comfortable with.

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
+	 * cancellation before they expire and this timer is not going to be
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




