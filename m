Return-Path: <linux-acpi+bounces-7983-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF79C964DFC
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3701C226FD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F141BA882;
	Thu, 29 Aug 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CS0E4Ppn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949191B9B40;
	Thu, 29 Aug 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957071; cv=none; b=a9i0BydKVLry+Z8r0OlBPQB7VtSHdVYzthDjGhHv9k7Rc9S9ecHBhwYd7n3Thfr3+UYA72uymCH3/hhZRqdPSnnO6b023H5SM+OYkl5Pg22FCcDTVF5cKnmwjnhB9RJSclhPLfIsuEwERwZKX4pQvve8XIruHKXZa5lfgT4rLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957071; c=relaxed/simple;
	bh=HzMJ/uZdWToDtRXGQNX+YGchahkVJYxZl3cBRKqyuhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOb9jj1q9MeZGrdRedR77dDBzQ+WJ+7nAauBFz3PeX0UsqgeQ07boI09Cfmc6DCCW/NqJsRj21vSqqslFcox5D8++Yo0k6cvDGcy8aY+bxMuEUHeNy2abbQETlaGDv5JPelefjT0c69nh00aCNNrOfHmgQZ5Dg6CkZwx6Idc9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CS0E4Ppn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 1bf1df12ccb76b4d; Thu, 29 Aug 2024 20:44:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AC5426A8C15;
	Thu, 29 Aug 2024 20:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957062;
	bh=HzMJ/uZdWToDtRXGQNX+YGchahkVJYxZl3cBRKqyuhw=;
	h=From:Subject:Date;
	b=CS0E4Ppn4KiYysZYm3QWgqw+EC41vdWezKafBWX4C10E5S/VVI47KwRa85BYhP5ZS
	 yxOVMMffR3tQr8/q/2cP+AWXigPcHoGumm5dIbczKCbxEnKrOj2RJOINSVLrjrucAu
	 xWsVl2FYb3mIIAgUUV9qfgXDh0hE9Z3l5gER6uRHW0O3bnTxBGoEGQ3igHvsbHV0XF
	 sjDOU1VYkG7FDwTt5jGojKvsq1KxIeETkkckxTm38RWug1M0SgyeElMjcV30r/KUjF
	 s3GPA+KMwkRQiqFbpXyKxe0rdoyUVelFxNpzpiZxC6gY+vjW/zkHiwEzB/MDXKHp39
	 8M0A5UykMki8A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 15/20] ACPICA: Add support for Windows 11 22H2 _OSI string
Date: Thu, 29 Aug 2024 20:40:07 +0200
Message-ID: <3650555.R56niFO833@rjwysocki.net>
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

ACPICA commit f56218c4e4dc1d1f699662d0726ad9e7a0d58548

See: https://github.com/microsoft_docs/windows-driver-docs/commit/be9d1c211adf8fabe5a43de71c034b1b6d7372de

Link: https://github.com/acpica/acpica/commit/f56218c4
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utosi.c | 1 +
 include/acpi/actypes.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 251bd396c6fd..99b85fd6eccf 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -75,6 +75,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2019", NULL, 0, ACPI_OSI_WIN_10_19H1},	/* Windows 10 version 1903 - Added 08/2019 */
 	{"Windows 2020", NULL, 0, ACPI_OSI_WIN_10_20H1},	/* Windows 10 version 2004 - Added 08/2021 */
 	{"Windows 2021", NULL, 0, ACPI_OSI_WIN_11},	/* Windows 11 - Added 01/2022 */
+	{"Windows 2022", NULL, 0, ACPI_OSI_WIN_11_22H2},	/* Windows 11 version 22H2 - Added 04/2024 */
 
 	/* Feature Group Strings */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 85c2dcf2b704..80767e8bf3ad 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1311,6 +1311,7 @@ typedef enum {
 #define ACPI_OSI_WIN_10_19H1            0x14
 #define ACPI_OSI_WIN_10_20H1            0x15
 #define ACPI_OSI_WIN_11                 0x16
+#define ACPI_OSI_WIN_11_22H2            0x17
 
 /* Definitions of getopt */
 
-- 
2.43.0





