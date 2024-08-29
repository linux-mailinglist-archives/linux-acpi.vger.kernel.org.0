Return-Path: <linux-acpi+bounces-7985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D76964E03
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1111C23104
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0D1BAEDD;
	Thu, 29 Aug 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="c0/2YIdR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BF1B9B2E;
	Thu, 29 Aug 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957072; cv=none; b=bs/85R3QPXoJQv44q+/xMoSyzwTp9XYPNspSHwGkeLaZgYz/mz0/dfdi2sfCtPn35Dv9+NilbfR94NDRsXF29xbWVhfEz2rKZ9f5QGRuXk3zr+CI5KW4nWUvXr69r8vYuZon8g3E6Rb4FJVVsXwGMZmmql6z1XexmxszQWAkEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957072; c=relaxed/simple;
	bh=1mP2WXzEu1T/V/DU7z3r3MxyDUKhG9ynlkh8+4AbtME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LF5ZWmtBfp2+Bsen8x0YfeEqE2CYqXD49KvZr8FTHKP55dd3YXQiUVjxJaOuOrf9TOVVj8AFOCEMibC+gX5sSoxDQkLNaBIZ7z+PSzj3l58l9Ln3cvY/gxiMfMukS7UObWNhrvlGWPaE3MUgrVOBouQ671DcbCxZO+xI8v21wro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=c0/2YIdR; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 643a3073f4df1198; Thu, 29 Aug 2024 20:44:21 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8C87A6A8C15;
	Thu, 29 Aug 2024 20:44:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957061;
	bh=1mP2WXzEu1T/V/DU7z3r3MxyDUKhG9ynlkh8+4AbtME=;
	h=From:Subject:Date;
	b=c0/2YIdROc3cN9g2CZaXyrxHRLW2qD1BhRyJp7w+ie3BFOb4wV5GHwzHJByLZ7JzH
	 SpJfLsJsDA1lGzpjnKqbq/HGtilLWsjjIJ1az8G4/hfvhaHe84a9TtQA/mTGU1jGz1
	 a93fGdc70rNcrmSRZ5FcIYnYhqIIj5ip8/+NIZQkeej9fSozZDq60CdYleBa99Z0Qx
	 lDBFEHmNi8IyV4wfcNQ3mPX/sEwfMNhA6eQ10NQiqNYhfl4t6Z3efrR2sR557Ce1JT
	 f0I9Ge1SBBLjRABTQof981KfZhR0cS/Shb1sQBfb1qsVJjSAiZ3a1NWXvVuvFoVf2z
	 szvGS+JtjvJOQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 16/20] ACPICA: Avoid warning for Dump Functions
Date: Thu, 29 Aug 2024 20:41:07 +0200
Message-ID: <1951739.taCxCBeP46@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Adam Lackorzynski <adam@l4re.org>

ACPICA commit 6031b34b5dbabfaaebe80e57e8e415790b51d285

Only include the functions acpi_rs_dump_resource_list()
and acpi_rs_dump_irq_list() if ACPI_DEBUGGER is defined, as
specified in the header.

This avoids a compiler warning by adding the ifdef for ACPI_DEBUGGER.

Link: https://github.com/acpica/acpica/commit/6031b34b
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 611bc71c193f..5b7d7074ce4f 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -48,6 +48,7 @@ static void acpi_rs_dump_address_common(union acpi_resource_data *resource);
 static void
 acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table);
 
+#ifdef ACPI_DEBUGGER
 /*******************************************************************************
  *
  * FUNCTION:    acpi_rs_dump_resource_list
@@ -160,6 +161,7 @@ void acpi_rs_dump_irq_list(u8 *route_table)
 					   prt_element, prt_element->length);
 	}
 }
+#endif
 
 /*******************************************************************************
  *
-- 
2.43.0





