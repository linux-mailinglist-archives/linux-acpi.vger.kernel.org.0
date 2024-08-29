Return-Path: <linux-acpi+bounces-7987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963DF964E08
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EE4285C09
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799121BBBE0;
	Thu, 29 Aug 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="T36Bre99"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB01B86E9;
	Thu, 29 Aug 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957074; cv=none; b=o2zjGhX4KtsoaDRaLuAmmLrlJTugOgHaNBupuCxJwTMlb7nvLPVxBVMSvyWf1ls3NRau6ANny4njEzzYjklt59x0dkCNt3bs6gTJgep+Jo+R4TbEK24LRlWeCaQqKmvNGAyXN2G7i4jQ9PJHmmZW8u0mwUNxgN9MJ5TfX1zmAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957074; c=relaxed/simple;
	bh=8fEbeLnYU4nMC1bClHgAN5EGZvKR8zowTtz+r9ER89Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdkYEfkDrLqsVn3sCtZx3KPOLJjB+wMhUL9j6LKY1pPuISpGOcSbaRHmqlyfzzlFJMgqxk+PKCzDTiETkOplghS+Omj5gG7/GeR+FAjgnveXtOLZc69942Dnpywq/i/wSjKxoszOazkcQQKZHyQlipmjdpxbAxvFOuUR99ulAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=T36Bre99 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id cb4075e430ad626f; Thu, 29 Aug 2024 20:44:30 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AFE9C6A8C15;
	Thu, 29 Aug 2024 20:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957070;
	bh=8fEbeLnYU4nMC1bClHgAN5EGZvKR8zowTtz+r9ER89Y=;
	h=From:Subject:Date;
	b=T36Bre997+Ewq9t67M6CqMDvMTGfLdGLl8j/HiJskJCdtyY3sdFH8xIOPmIgZCWen
	 BSvmJ4Dh5D/48Fvl/DrCPBdW2DzMpM/HXc8Qjeea8rHheek05W9FuwmVMgvtpM3918
	 au/rmkPUYejFmvWur3yvUzmpDHauJCZCrJLhlK2InAKOdRueTkXtuGvOZ+qdbScNoa
	 sw2Ql8f9bS4QVdOFNUoorIrL+U5XR1N5RedzWESaB7aH79tSqogdzSbBYcCOKWplG4
	 ZvOVLjyThS3QZCa8njxjtHZqtzENJVayV8yrauLSSFfEHBB4MbbxWcKGjGIiWlUgpO
	 YVLAD6RBI1VRw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 07/20] ACPICA: Implement ACPI_WARNING_ONCE and ACPI_ERROR_ONCE
Date: Thu, 29 Aug 2024 20:31:36 +0200
Message-ID: <1985040.PYKUYFuaPT@rjwysocki.net>
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

From: Vasily Khoruzhick <anarsoul@gmail.com>

ACPICA commit 2ad4e6e7c4118f4cdfcad321c930b836cec77406

In some cases it is not practical nor useful to nag user about some
firmware errors that they cannot fix. Add a macro that will print a
warning or error only once to be used in these cases.

Link: https://github.com/acpica/acpica/commit/2ad4e6e7
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acoutput.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index b1571dd96310..5e0346142f98 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -193,6 +193,7 @@
  */
 #ifndef ACPI_NO_ERROR_MESSAGES
 #define AE_INFO                         _acpi_module_name, __LINE__
+#define ACPI_ONCE(_fn, _plist)                  { static char _done; if (!_done) { _done = 1; _fn _plist; } }
 
 /*
  * Error reporting. Callers module and line number are inserted by AE_INFO,
@@ -201,8 +202,10 @@
  */
 #define ACPI_INFO(plist)                acpi_info plist
 #define ACPI_WARNING(plist)             acpi_warning plist
+#define ACPI_WARNING_ONCE(plist)        ACPI_ONCE(acpi_warning, plist)
 #define ACPI_EXCEPTION(plist)           acpi_exception plist
 #define ACPI_ERROR(plist)               acpi_error plist
+#define ACPI_ERROR_ONCE(plist)          ACPI_ONCE(acpi_error, plist)
 #define ACPI_BIOS_WARNING(plist)        acpi_bios_warning plist
 #define ACPI_BIOS_EXCEPTION(plist)      acpi_bios_exception plist
 #define ACPI_BIOS_ERROR(plist)          acpi_bios_error plist
@@ -214,8 +217,10 @@
 
 #define ACPI_INFO(plist)
 #define ACPI_WARNING(plist)
+#define ACPI_WARNING_ONCE(plist)
 #define ACPI_EXCEPTION(plist)
 #define ACPI_ERROR(plist)
+#define ACPI_ERROR_ONCE(plist)
 #define ACPI_BIOS_WARNING(plist)
 #define ACPI_BIOS_EXCEPTION(plist)
 #define ACPI_BIOS_ERROR(plist)
-- 
2.43.0





