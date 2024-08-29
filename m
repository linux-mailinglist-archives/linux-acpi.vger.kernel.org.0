Return-Path: <linux-acpi+bounces-7992-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81494964E12
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8F91F25602
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0621BDAA0;
	Thu, 29 Aug 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nY0xYsIK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266781B8E93;
	Thu, 29 Aug 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957079; cv=none; b=h1LvcL4n44uU+vbS1pcLXu4EM03L6LmhWjenwbB1ktT+IKbI2RWCn4LBS0bVwoWqSQnO2dqPzc5IhgLfPYy8XoLPsGUs5WMX91eRcG9gXF4FPDyipXXI7ko7ZI+xBxG4SnbfNPU2SERgmIoqfKD5WzLxytbD1UG6rfCE0KRskq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957079; c=relaxed/simple;
	bh=Il/Skd+5d8M3O4yIGQSaahTtK8lLASmpdQ9RuBCACGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+TNb09qtPZKqipoQ5Jfkl7OCWjW9EITKhPR4WdNL8Bp1rgZsaol9c0j+DjCf1U+IBOwFQ46G5jpcq6itbCS6jpIXQTUlIBWxBDzFig8BxI7wnG6jGaZQU+NCCg4Jwjlt1zrtkaqAI5urRWUxTCa2f/86u5j65b1vgSH3t9Etng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nY0xYsIK; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 5b254df988a955df; Thu, 29 Aug 2024 20:44:35 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9A4206A8C15;
	Thu, 29 Aug 2024 20:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957075;
	bh=Il/Skd+5d8M3O4yIGQSaahTtK8lLASmpdQ9RuBCACGc=;
	h=From:Subject:Date;
	b=nY0xYsIKLONuNr6oguIiqq8O3CkyoMKuHnOYpg14LonwrdE0sbQzTdXe/cyfqxaRC
	 boOiusFulHytPV5Wst6x3+vPGhBoXjOM+yjXCuImsKHmAZU87lh3Y4ciWxPLvJi3aQ
	 Nx5hrVRnJTL9GJCDIB73Vw3hJcYdauZlKQca0zf6IeumDVehOyMKHMrC60FYVQgcxV
	 RADQ0iwzUdOPHU6VDQZPAE8U4ZeQx/z6hd3Sj7fmwJXNIZiOirtEZ5sCijXOpV23dJ
	 okQ8L/N8fgki1sF5i5837MJG054kbXmUFZk2CzehABJ7d7va4mChtWf+m+aSraw44Y
	 JEfNJoe8euVVQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 02/20] ACPICA: Complete CXL 3.0 CXIMS structures
Date: Thu, 29 Aug 2024 20:22:30 +0200
Message-ID: <4925809.GXAFRqVoOG@rjwysocki.net>
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

From: Zhang Rui <rui.zhang@intel.com>

ACPICA commit eb2a2ff303416fb3f6c425d519dbcd6988dbd91f

Commit 2d8dc0383d3c9 ("Add CXL 3.0 structures (CXIMS & RDPAS) to the
CEDT table") introduces basic support for CXL XOR Interleave Math
Structure (CXIMS).

Complete the CXIMS structures.

No functional change.

Link: https://github.com/acpica/acpica/commit/eb2a2ff3
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 841ef9f22795..8cfcd1e1c177 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -567,6 +567,10 @@ struct acpi_cedt_cxims {
 	u64 xormap_list[];
 };
 
+struct acpi_cedt_cxims_target_element {
+	u64 xormap;
+};
+
 /* 3: CXL RCEC Downstream Port Association Structure */
 
 struct acpi_cedt_rdpas {
-- 
2.43.0





