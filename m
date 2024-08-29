Return-Path: <linux-acpi+bounces-7986-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE64964E06
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B21C20CB7
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C01BB69C;
	Thu, 29 Aug 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TL+oV/87"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61C1B5832;
	Thu, 29 Aug 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957073; cv=none; b=SnBXt/G0+zj1XjkOlxG+qgvhDU/fsrkVd75dKK3++VCDVnz1pmzwTCRqYPN/rKy3lbbyMs+A87Q1ri+RuqbEXEvzqnRbZMkVd0HBQTZOa645WHVHRX4C8nKrhtwOmU9FVztYl8IcTythhLmt5K0xZvwmEsRHxcEd+Va6RRgQ/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957073; c=relaxed/simple;
	bh=9VvRDYMIhcmiIAtIr14hUIJwDhBgrG/Q+hQ5W2XHwjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzqC/tybC/0y6a9FF1SM8QVbAZ/BL/deZyQqWKzuK4ya8FjIFCg3wYE3n+CFbb1p2nGbk1n4i55GebSSa+ZpvJK9o2FbCZ4z3ZZW9fB3YrvStMvaGmt2VXbsqZlecfwdOtBE79gQXXqBYxUnbdiMfI3MJJFck2IayznPrNfU66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TL+oV/87 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1addb6147f9438a9; Thu, 29 Aug 2024 20:44:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A565B6A8C15;
	Thu, 29 Aug 2024 20:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957069;
	bh=9VvRDYMIhcmiIAtIr14hUIJwDhBgrG/Q+hQ5W2XHwjo=;
	h=From:Subject:Date;
	b=TL+oV/871+AstnupCBvtzuvyoxIEjqBI2IC3RdMzURcHYR/u5PQwWevtF/lxCtg4K
	 jWb7V50IZILVJqeZQ1nQWLn9y85TWgD6THlkf+xgaRSDlk0XDn7SiQQ12Hhl8EtG+O
	 JP5wrzV8XQb/ZiNKJMC2xuW6+dZY3VQoaEbLSEtQgwF3c/njWMPUHuAaXeBrS1fP+F
	 MPGZ9iya3BgWbzmc0bDcXAS+5mGAm//oa5OFmfQAPDVbiW2/pfZBcwBmJY9d6J/T+V
	 jbayb5J2MbDDG94H6iVB/u4AW7qylq1tcLc/PchS1QzD3CIe0dqY+GRuYIVBX31vWb
	 keXOQuZ9h6ahQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 08/20] ACPICA: executer/exsystem: Don't nag user about every
 Stall() violating the spec
Date: Thu, 29 Aug 2024 20:32:31 +0200
Message-ID: <7712103.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Vasily Khoruzhick <anarsoul@gmail.com>

ACPICA commit 129b75516fc49fe1fd6b8c5798f86c13854630b3

Stop nagging user about every Stall() that violates the spec

On my Dell XPS 15 7590 I get hundreds of these warnings after few hours of
uptime:

$ dmesg | grep "fix the firmware" | wc -l
261

I cannot fix the firmware and I doubt that Dell cares about 4 year old
laptop either

Fixes: ace8f1c54a02 ("ACPICA: executer/exsystem: Inform users about ACPI spec violation")
Link: https://github.com/acpica/acpica/commit/129b7551
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exsystem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/exsystem.c b/drivers/acpi/acpica/exsystem.c
index f665ffd9a396..2c384bd52b9c 100644
--- a/drivers/acpi/acpica/exsystem.c
+++ b/drivers/acpi/acpica/exsystem.c
@@ -133,14 +133,15 @@ acpi_status acpi_ex_system_do_stall(u32 how_long_us)
 		 * (ACPI specifies 100 usec as max, but this gives some slack in
 		 * order to support existing BIOSs)
 		 */
-		ACPI_ERROR((AE_INFO,
-			    "Time parameter is too large (%u)", how_long_us));
+		ACPI_ERROR_ONCE((AE_INFO,
+				 "Time parameter is too large (%u)",
+				 how_long_us));
 		status = AE_AML_OPERAND_VALUE;
 	} else {
 		if (how_long_us > 100) {
-			ACPI_WARNING((AE_INFO,
-				      "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
-				      how_long_us));
+			ACPI_WARNING_ONCE((AE_INFO,
+					   "Time parameter %u us > 100 us violating ACPI spec, please fix the firmware.",
+					   how_long_us));
 		}
 		acpi_os_stall(how_long_us);
 	}
-- 
2.43.0





