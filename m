Return-Path: <linux-acpi+bounces-7980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C666E964DF9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051421C22B9C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A300E1BA273;
	Thu, 29 Aug 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Z23Br0Bc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E01B8E8A;
	Thu, 29 Aug 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957070; cv=none; b=jSFBoyr2R5of7qQ/lavLNgEyR+WtpDAhrzHsqjznzqr3vjmlZnhrF9qkXGz5Ocg0J/fuhZADVhHL/HP02Us7OA0Yw0NmkUgwU5Vfafktsnur6lhZ44i2Idaxs24ZaoYrRYIhoxOk40NXXI7R/Vj0rYPdM3hnj2KDCn8Krs6WsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957070; c=relaxed/simple;
	bh=cTDGQeXn/UXpQxaDF8475FgHbDNwc6X4AJq9LfX0Yjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfZxiHenDMWFuCd/VzzzLot+1WTWyRmJDj+WsUUpbtgd/UucJybPFR0pYjq08kM2DzP/cyxql86doKYcN4gZg92SpHiO+jS46JuJjYmkp3tA7e2FfeB7MgrAjXIf0sZOek1Exqye2uJlerT3tyuGK78TIn5o9XOSWH9g5glGoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Z23Br0Bc reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 57492ccb5a3ae04f; Thu, 29 Aug 2024 20:44:20 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A261F6A8C15;
	Thu, 29 Aug 2024 20:44:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957060;
	bh=cTDGQeXn/UXpQxaDF8475FgHbDNwc6X4AJq9LfX0Yjc=;
	h=From:Subject:Date;
	b=Z23Br0BcK3m8UW6G9Z9P2x69EMd2HAfBTeYDHNX0hjQcAaVu4HlFCZMTro2DT8WOe
	 A0x7sBt945qkQulNN0TR2h1dbDwoXjAAnxSYwm9X+8kOz9c2GXn2yYohDWduudRFia
	 beULqzudr303bMNDirZsRFswYUCUny87t7vBI1FC80RefJoucFw/ClxAP0mu7RiocB
	 K9ufOxXQu30138nj3UJfo1GVKn4lIfE2KvyTHjFLkLYxRe6si9Dw+o3yr+dwcDubwJ
	 px0bQAlMGKQkwrJsPO76c9M4E3oTXXvMxrk5og07lSdw45PbZrf6FYVFv0YfTcTnee
	 4yDm6+EkuXaWg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 17/20] ACPICA: HMAT: Add extended linear address mode to MSCIS
Date: Thu, 29 Aug 2024 20:41:57 +0200
Message-ID: <46631863.fMDQidcC6G@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Dave Jiang <dave.jiang@intel.com>

ACPICA commit aaa08569b81aa4d9ff59f91f00e589e98d499e6c

Redefine the 2 reserved bytes at offset 28 of Memory Side Cache Information
Structure as "Address Mode" and add defines of the new value.

    * 0 - Reserved (Unkown Address Mode)
    * 1 - Extended-linear (N direct-map aliases linearly mapped)
    * 2..65535 - Reserved (Unknown Address Mode)

Link: https://github.com/acpica/acpica/commit/aaa08569
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 89f0df489dc3..199afc2cd122 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1796,7 +1796,7 @@ struct acpi_hmat_cache {
 	u32 reserved1;
 	u64 cache_size;
 	u32 cache_attributes;
-	u16 reserved2;
+	u16 address_mode;
 	u16 number_of_SMBIOShandles;
 };
 
@@ -1808,6 +1808,9 @@ struct acpi_hmat_cache {
 #define ACPI_HMAT_WRITE_POLICY          (0x0000F000)
 #define ACPI_HMAT_CACHE_LINE_SIZE       (0xFFFF0000)
 
+#define ACPI_HMAT_CACHE_MODE_UNKNOWN            (0)
+#define ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR    (1)
+
 /* Values for cache associativity flag */
 
 #define ACPI_HMAT_CA_NONE                     (0)
-- 
2.43.0





