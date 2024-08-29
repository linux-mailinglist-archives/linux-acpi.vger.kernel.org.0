Return-Path: <linux-acpi+bounces-7974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D151E964DEE
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6345E1F2196C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119E1B8E84;
	Thu, 29 Aug 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jUoEGvwh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8241B5832;
	Thu, 29 Aug 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957067; cv=none; b=pvrTQiKDTbeThPIaeqA02E/d2+YS3FQQI9wNk4cMQhi0veaU3gR0OdHOuMSnrjuY3TI2BIOwd46JUKAXu5Ls5QAREOmQ7mBFaVLa1IolXMtPDTLhyta8XxqTEdGMYTNpf+L0hIgxeBG0yu8S0PHv/JvKN3D/mNJq+KBgdF5wBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957067; c=relaxed/simple;
	bh=Atu+xXyCVD3GRZg4LEOA0rmnqtiiKHU9Is28nBj7sZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwE3KxpE3H1Qqlkbp8dDyXjaIuCQ4ZpbUNcNiuqDD1klCXQRbaMgWxN4GNn+to5Zbm28rlfKY1T+qUvmXE3pMUttVz6WD07xz+BGH/wohQw7gw8ZeKrBSn8xsNg7XpXv+sgKdtSqa75iVdCHc96cdu+FGOC7fYevXt4bLPuGlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jUoEGvwh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 62da0b2b23048a9e; Thu, 29 Aug 2024 20:44:17 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 011F06A8C16;
	Thu, 29 Aug 2024 20:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957057;
	bh=Atu+xXyCVD3GRZg4LEOA0rmnqtiiKHU9Is28nBj7sZk=;
	h=From:Subject:Date;
	b=jUoEGvwhtrXxqZHGGNzRJoQ1bTrU5GRQKQy+yiYYuLLlhrrB2FVDAKrVY3PMUJPcC
	 rJtgtCbZI2jf2gUQRAQFwlZbqjt14GUGBxNstXhANskZIiV0BjWl41ORQmQTcU4/H/
	 hiaBl85bzPQx9jPAcnLHvw58ta2Ja57r61V0IdRaHXSKLPWK1kjUs4ENzR8lCMhJtP
	 9XG0gPT9JPUAgJpYWwuRkyFUKS74pvEWGTrPklGMM8lhFsPwJpSo6CD8KgQ3cKNe8R
	 pfTGw9VM9RtQDW9c2e1oCq1cGeSfnn64FWZSN/YVPFNZzDLvlqppfLMa2hvbr9NgES
	 50HsAbmaEyEzg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 20/20] ACPICA: Setup for ACPICA release 20240827
Date: Thu, 29 Aug 2024 20:44:01 +0200
Message-ID: <5504899.Sb9uPGUboI@rjwysocki.net>
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

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit 86c762afe5bf915e8101a0455513368e2a60dd80

Link: https://github.com/acpica/acpica/commit/86c762af
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 99bb45a46600..6c1cd90efae8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20240322
+#define ACPI_CA_VERSION                 0x20240827
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.43.0





