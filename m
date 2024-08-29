Return-Path: <linux-acpi+bounces-7977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EA4964DF2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22072B21AD5
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62BF1B8EAF;
	Thu, 29 Aug 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cbjseovY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA531B86E9;
	Thu, 29 Aug 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957068; cv=none; b=f5SeOau4Esvc8OR+b/ihUmGLCEWcuUlC4hAUnKHklVi2jOP9b4aSB03winu35hO6O0krBpXBkFbEBjOF5ZSZPKEFW/f+kMfdooTxCpMvNfjftbPBNP1L3GcmD993iGdNEV5GmzfHdRAIinFJMcgqACBWuXFTBEGtQE8MGhCvc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957068; c=relaxed/simple;
	bh=Jx/BFerNDf7r5tR1yNitkZFck465J+ltG0IRRiB5vtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVRlwcu8raTgMtwedrMuo+4P1+s+1BsSxHJz53YrR649EZMYEFfBf0OgHVv5EZkp5kyB2k6qUBeG1C1inuiVk5aQZu04/0y7n9deD/qJLpBthzhP764NKFRZ2Nbi9uIf52eQL/ofN1t2HFqGO/hgnejfqlmW0OxuUMc7sU9JnW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cbjseovY reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 49512f7242cb57d7; Thu, 29 Aug 2024 20:44:24 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B7F1A6A8C15;
	Thu, 29 Aug 2024 20:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957064;
	bh=Jx/BFerNDf7r5tR1yNitkZFck465J+ltG0IRRiB5vtA=;
	h=From:Subject:Date;
	b=cbjseovY4lVygyiB81PefKCkpynKJ7qZiPXxX2pwj8A3xtl/1STyjA34kVQlYNT9A
	 WkZHMn/+9Ks56G21WxzEY+mDgpS3/suwViaLrqOWJp9O4873OchyM2IC8inuph6SPS
	 0qCkd+gFPjmnVWr584rS7kaYxJWMHG4YqmqbUPep1FrrP5DoeeDrOtAYf4si8jQJ9N
	 CFuVTSxOLhPieoa1EBFXOnrpXon0jReNBTW4qn036w2XrhY3yN12doFuqdSkPsrqJ+
	 rsnWmLbO8fIagQaMfbGIch+x1Pq652AX7M3EjRsonZeFXdI4FAu+pHwGO4MRNpWv6G
	 RHDs6CaLEwM1A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 13/20] ACPICA: Add support for supressing leading zeros in hex
 strings
Date: Thu, 29 Aug 2024 20:38:31 +0200
Message-ID: <23640949.6Emhk5qWAg@rjwysocki.net>
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

From: Armin Wolf <W_Armin@gmx.de>

ACPICA commit 86289439d9f8b9eda28c249da66ae230d6439491

Currently the leading_zeros argument has no effect when
converting hex integers. Fix that.

Link: https://github.com/acpica/acpica/commit/86289439
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/exconvrt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 4e8ab3c26565..9647325d290d 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -270,6 +270,7 @@ acpi_ex_convert_to_ascii(u64 integer,
 	u32 decimal_length;
 	u32 remainder;
 	u8 supress_zeros = !leading_zeros;
+	u8 hex_char;
 
 	ACPI_FUNCTION_ENTRY();
 
@@ -330,8 +331,17 @@ acpi_ex_convert_to_ascii(u64 integer,
 
 			/* Get one hex digit, most significant digits first */
 
-			string[k] = (u8)
+			hex_char = (u8)
 			    acpi_ut_hex_to_ascii_char(integer, ACPI_MUL_4(j));
+
+			/* Supress leading zeros until the first non-zero character */
+
+			if (hex_char == ACPI_ASCII_ZERO && supress_zeros) {
+				continue;
+			}
+
+			supress_zeros = FALSE;
+			string[k] = hex_char;
 			k++;
 		}
 		break;
-- 
2.43.0





