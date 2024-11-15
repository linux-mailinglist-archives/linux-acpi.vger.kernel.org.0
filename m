Return-Path: <linux-acpi+bounces-9603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B499CF678
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 22:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713CF1F21E2A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696471D5ADE;
	Fri, 15 Nov 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="g+L3x3j/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FE18C031;
	Fri, 15 Nov 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704476; cv=none; b=CCpqY2E3YSK+dcEz14nPiUckzz5I+ijeCKJYFAK4B4gqSZsrMXKr4E9z6t69IJszvlMMM9UrThGcvwPRK0/vKaKkO6+ujQaRJzJphJAe9o7iKEmjTPWOF2YdK0oFRO2IU1zBCIxQY4ouSEzdiCIFLK93YpMFqk2PNBAxNC3wqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704476; c=relaxed/simple;
	bh=upJvO75RZUD4V28E2J8nhVTj4rALy/xtpQVUlI5PaSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiTDXsJaG5Q0bsvp0P5LxdxENlqD/hE5nf0hCqlFNZXknrxC0C0vi+owMFRCaHLfxRXgSFDVFkBBYTpwe3+Ri1hwZ1aHFKLTOaSN9HqlKfVJ620JJKw6NyCdydFJ3YRYQ8aQFGgbUYB4K3h0/WPyq0d75ds3K6XXtH824qB/tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=g+L3x3j/ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 86c8986785aa934d; Fri, 15 Nov 2024 22:01:05 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AAB74851B10;
	Fri, 15 Nov 2024 22:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731704465;
	bh=upJvO75RZUD4V28E2J8nhVTj4rALy/xtpQVUlI5PaSc=;
	h=From:Subject:Date;
	b=g+L3x3j/85bJtbCypqMyylThaWK3nNPdKQLVZuyO/7w/xK7dRLdqS5uJBwcTvXSiP
	 /TvGi5YgjdJYEBm00pZhJFg+fzsjD87xNts0r90ByLvqoXr9p6lpY4fDPAS9xfwGWp
	 Y1q4jzBPSUs6ZcC+PChdwEry1jP+Oz/5QxRI1UOf4lx+Id5DZY0V9ybMLL7yxQZhkL
	 oKKMQVjGYeQr9XV+/bo9m3nhfxSeMwDyt2pVXHylVeACq2t5157XyjSx24kPcs/s0E
	 Evy69a8cv5XGtwbz18tDZFnyGigFkr4G+2h4zCRQRvQXBbgHv9Rs6Jvz4y5SefFM1g
	 s2G8gM2Izq3cA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v2 2/2] cpuidle: Change :enter_dead() driver callback return type to
 void
Date: Fri, 15 Nov 2024 22:00:25 +0100
Message-ID: <2285569.iZASKD2KPV@rjwysocki.net>
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

After a previous change, cpuidle_play_dead(), which is the only caller
of idle state :enter_dead() callbacks, ignores their return values, so
they may as well be void.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

Interestingly enough, the only user of :enter_dead() idle state callbacks
in the current mainline turns out to be ACPI idle.

---
 drivers/acpi/processor_idle.c |    7 ++-----
 include/linux/cpuidle.h       |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -61,7 +61,7 @@ struct cpuidle_state {
 			struct cpuidle_driver *drv,
 			int index);
 
-	int (*enter_dead) (struct cpuidle_device *dev, int index);
+	void (*enter_dead) (struct cpuidle_device *dev, int index);
 
 	/*
 	 * CPUs execute ->enter_s2idle with the local tick or entire timekeeping
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -578,7 +578,7 @@ static void __cpuidle acpi_idle_do_entry
  * @dev: the target CPU
  * @index: the index of suggested state
  */
-static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
+static void acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
@@ -591,11 +591,8 @@ static int acpi_idle_play_dead(struct cp
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			io_idle(cx->address);
 		} else
-			return -ENODEV;
+			return;
 	}
-
-	/* Never reached */
-	return 0;
 }
 
 static __always_inline bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)




