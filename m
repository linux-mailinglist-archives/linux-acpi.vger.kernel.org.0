Return-Path: <linux-acpi+bounces-7993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17751964E14
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78B6286A30
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BA1BE222;
	Thu, 29 Aug 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="jtF4U1DT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6E1BD50B;
	Thu, 29 Aug 2024 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957080; cv=none; b=YswGneAmZ+nHq/HmlPefjHmR8PXvzINteZsIBbncupBpyqWQwKKExbazN5ocMWycXaaY59hBh3njE/SzObPZmf8p4ykY3k/06nQIYsTFOfM4kM5prLjoVaT9TGDr0EHQTnGlGkGISz3PrOXfwKD9x4dKHFqCy92FMFq9ezen/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957080; c=relaxed/simple;
	bh=E8ydJwBJUB5MO/SQG1BfSZO2V6OEqXzR/C++xGdTKec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE2D5tnbXbUOqtOrMGQAlfnVrQCM0NHB87Fy0FhwZ2S2+RBX5p+k7TRMF1m728SgyLjiVolUVcziWLrHrVzgoBIh9a1GM+hz1d5JjKfT/9TLGHBYy0kI2+EgYl/EB7fQszwDnVZ0RP2lt5FKDXB3YLFlYoE4gl7W1a6rWO+Da7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=jtF4U1DT; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 312d5ee09a964c8d; Thu, 29 Aug 2024 20:44:36 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AB21D6A8C15;
	Thu, 29 Aug 2024 20:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957076;
	bh=E8ydJwBJUB5MO/SQG1BfSZO2V6OEqXzR/C++xGdTKec=;
	h=From:Subject:Date;
	b=jtF4U1DTkp+3hu8+snHDFewci2DIHTn32OdjmTlF+3dlTnduvXSMHnG+ruYQG2hN1
	 Mb19/4ZhGQZqat1Am/tqBsw51ZXUwaV99/m+iRzwWJ+yc7s+I9MCmnBUfvz2hQYf6Z
	 5Ca/72Beypeaqm4A7rU8w1qzm8sSqOBy0ahAQE49xrcXbXiWUXCQCiKM2RUT7kEzGG
	 RFWxcozOV3jXxIkWpJrwUfiQqu59xR9tccIX8mPPff/YlQheqjSdNFmQWNgFdcwKVe
	 LjpntKfoNPRkyd+VO+p+0y9x3rFAjiNWzQUwf+C1YvaoJKIaQNMr4UUoi5ay1KEWck
	 x5gWEjSqJ1d5Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 01/20] ACPICA: haiku: Fix invalid value used for semaphores
Date: Thu, 29 Aug 2024 20:21:43 +0200
Message-ID: <4599054.LvFx2qVVIh@rjwysocki.net>
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

From: Adrien Destugues <adrien.destugues@opensource.viveris.fr>

ACPICA commit 49fe4f25483feec2f685b204ef19e28d92979e95

In Haiku, semaphores are represented by integers, not pointers.
So, we can't use NULL as the invalid/destroyed value, the correct value
is -1. Introduce a platform overridable define to allow this.

Fixes #162 (which was closed after coming to the conclusion that this
should be done, but the change was never done).

Link: https://github.com/acpica/acpica/commit/49fe4f25
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 4 ++--
 drivers/acpi/acpica/utinit.c   | 2 +-
 include/acpi/platform/acenv.h  | 6 ++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 8d7736d2d269..c85bfa13ac1e 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -140,7 +140,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 			(void)
 			    acpi_os_delete_semaphore
 			    (acpi_gbl_global_lock_semaphore);
-			acpi_gbl_global_lock_semaphore = NULL;
+			acpi_gbl_global_lock_semaphore = ACPI_SEMAPHORE_NULL;
 
 			acpi_os_delete_mutex(object->mutex.os_mutex);
 			acpi_gbl_global_lock_mutex = NULL;
@@ -157,7 +157,7 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 				  object, object->event.os_semaphore));
 
 		(void)acpi_os_delete_semaphore(object->event.os_semaphore);
-		object->event.os_semaphore = NULL;
+		object->event.os_semaphore = ACPI_SEMAPHORE_NULL;
 		break;
 
 	case ACPI_TYPE_METHOD:
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 92fbaef161a7..6d78504e9fbc 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -154,7 +154,7 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* Global Lock support */
 
-	acpi_gbl_global_lock_semaphore = NULL;
+	acpi_gbl_global_lock_semaphore = ACPI_SEMAPHORE_NULL;
 	acpi_gbl_global_lock_mutex = NULL;
 	acpi_gbl_global_lock_acquired = FALSE;
 	acpi_gbl_global_lock_handle = 0;
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 337ffa931ee8..3f31df09a9d6 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -252,6 +252,12 @@
 #define ACPI_RELEASE_GLOBAL_LOCK(Glptr, pending) pending = 0
 #endif
 
+/* NULL/invalid value to use for destroyed or not-yet-created semaphores. */
+
+#ifndef ACPI_SEMAPHORE_NULL
+#define ACPI_SEMAPHORE_NULL NULL
+#endif
+
 /* Flush CPU cache - used when going to sleep. Wbinvd or similar. */
 
 #ifndef ACPI_FLUSH_CPU_CACHE
-- 
2.43.0





