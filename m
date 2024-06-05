Return-Path: <linux-acpi+bounces-6206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9B8FD75B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770651C240FA
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B693515A845;
	Wed,  5 Jun 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="OwFWNGlh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96720158875;
	Wed,  5 Jun 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618536; cv=none; b=Z9dVlmBtMJO9c2N1aQyRN/qGkWVZArTfgeJ2dBsr1/d3k1ExYORnpL8l2qrDqko3qz+5JS4t6lfieitTY78K2m/89ejNwlXtSUHjp2lZnn4oTdw32On32bYqDt6KVNrUuo5sq5nggCMR8HmzmgemA0RYAeiZCpdBJivVF//NC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618536; c=relaxed/simple;
	bh=zxD1cwFWyYIiwsBdznmwI88r68Qo758+nAqPtOAaj9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EzP6P8vpbOPZlMnJh+bFOByWNeDUChSn8QTYqJugp3IZ1zqwxoXSwDf/lcpI+p2wCba0Y8P7EACNk2D5mIFhP1IN3hZayioMTPFS/vfVAbBaMGB+VigZ4oK/KgNB6WXtStteSHeVareRlh9G8JaXVj3ZbmFGpf7AlmCqOd/X6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=OwFWNGlh reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.1.0)
 id 54c4fb9e1115c09a; Wed, 5 Jun 2024 21:15:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3FD77D503F3;
	Wed,  5 Jun 2024 21:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1717614928;
	bh=zxD1cwFWyYIiwsBdznmwI88r68Qo758+nAqPtOAaj9s=;
	h=From:To:Cc:Subject:Date;
	b=OwFWNGlhDNnwJ8Gkk+PMkrpaaukYQm1FN/qCMHbEyNAMbb92BAQgfi6+JXWHxiMB8
	 yj0FDzGSfK6zUoLcT9j/GygxUzOpHw6PVDFeufjSoXQKLYd5LtvyozD9ghn2F7e62p
	 G/H6l5LiIH8CtQ8vk/UY62UyzD7znJTfHeqRnhTAZiGLkMlsXw+/lpnAowymYbv4cu
	 GKKT4odam/PFALihFWrbUHF9PxNY2Nq5A6YHFNRUkKevQVFKOOmCHylpliUJOXRTGo
	 ulgj09rwvhGDdrBitVWTgDQK4Z8DNLpcLXUiK9ctkbmdaXEOi8/sEZvAx6yPlY+QOf
	 OelU0Sasewnug==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Tibor Billes <tbilles@gmx.com>, Doug Smythies <dsmythies@telus.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1] thermal: ACPI: Invalidate trip points with temperature of 0 or
 below
Date: Wed, 05 Jun 2024 21:15:10 +0200
Message-ID: <5784853.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtsghilhhlvghssehgmhigrdgtohhmpdhrtghpthhtohepughsmhihthhhihgvshesthgvlhhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
 thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is reported that commit 950210887670 ("thermal: core: Drop
trips_disabled bitmask") causes the maximum frequency of CPUs to drop
further down with every system sleep-wake cycle on Intel Core i7-4710HQ.

This turns out to be due to a trip point whose temperature is equal to 0
degrees Celsius which is acted on every time the system wakes from sleep.

Before commit 950210887670 this trip point would be disabled wia the
trips_disabled bitmask, but now it is treated as a valid one.

Since ACPI thermal control is generally about protection against
overheating, trip points with temperature of 0 centigrade or below are
not particularly useful there, so initialize them all as invalid which
fixes the problem at hand.

Fixes: 950210887670 ("thermal: core: Drop trips_disabled bitmask")
Closes: https://lore.kernel.org/linux-pm/3f71747b-f852-4ee0-b384-cf46b2aefa3f@gmx.com
Reported-by: Tibor Billes <tbilles@gmx.com>
Tested-by: Tibor Billes <tbilles@gmx.com>
Cc: 6.7+ <stable@vger.kernel.org> # 6.7+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -168,11 +168,17 @@ static int acpi_thermal_get_polling_freq
 
 static int acpi_thermal_temp(struct acpi_thermal *tz, int temp_deci_k)
 {
+	int temp;
+
 	if (temp_deci_k == THERMAL_TEMP_INVALID)
 		return THERMAL_TEMP_INVALID;
 
-	return deci_kelvin_to_millicelsius_with_offset(temp_deci_k,
+	temp = deci_kelvin_to_millicelsius_with_offset(temp_deci_k,
 						       tz->kelvin_offset);
+	if (temp <= 0)
+		return THERMAL_TEMP_INVALID;
+
+	return temp;
 }
 
 static bool acpi_thermal_trip_valid(struct acpi_thermal_trip *acpi_trip)




