Return-Path: <linux-acpi+bounces-11653-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91DEA4A47E
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 22:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266923BA696
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369821C5D4D;
	Fri, 28 Feb 2025 21:08:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68A17A31A
	for <linux-acpi@vger.kernel.org>; Fri, 28 Feb 2025 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776936; cv=none; b=JAbPXAWVLUf6YjDdqF134Uw+kBnGb4515RNeb+fVWb51Db3j75fY430exjxNHH1LN8G9A31CWegsaiQD529znkznWrWEpra1DMjRePEtuP5FXxLoEmkUQshSAwZtknrmnPyFVqoFacJlVIOBYGnbLvF74llCd6fiTjghKUVNH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776936; c=relaxed/simple;
	bh=HvE4FYJRqbGJDKKOWbnPwXRjHiw6Cb5DncnUcoso/OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OY8g4V+23BeeG1qdm628NaK4X/kEWFvJY2/DV1oyoEDhlEcAu2CezbFXainCwVeWDbK5suO5WwTFMkodWgncpL1KUAGH1C0a4eQ9vXdOyUInsJjfXNxoGFG0R6Br2RhFx6g5n/R4dzAiji7DRRwAnkJDznB5Zi+N2toFth2gjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from bozeman.lan (pool-96-240-17-61.nwrknj.fios.verizon.net [96.240.17.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mpagano)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4E7B3343056;
	Fri, 28 Feb 2025 21:08:53 +0000 (UTC)
From: mpagano@gentoo.org
To: linux-acpi@vger.kernel.org
Cc: robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	Mike Pagano <mpagano@gentoo.org>
Subject: [PATCH] ACPICA: fix build with GCC 15 due to -Werror=unterminated-string-initialization
Date: Fri, 28 Feb 2025 16:08:34 -0500
Message-ID: <20250228210834.811164-1-mpagano@gentoo.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix char length error which appears when compiling with GCC 15:

In file included from ./include/acpi/actbl.h:371,
                 from ./include/acpi/acpi.h:26,
                 from ./include/linux/acpi.h:26,
                 from drivers/acpi/tables.c:19:
./include/acpi/actbl1.h:30:33: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   30 | #define ACPI_SIG_BERT           "BERT"  /* Boot Error Record Table */
      |                                 ^~~~~~
drivers/acpi/tables.c:400:9: note: in expansion of macro ‘ACPI_SIG_BERT’
  400 |         ACPI_SIG_BERT, ACPI_SIG_BGRT, ACPI_SIG_CPEP, ACPI_SIG_ECDT,
      |         ^~~~~~~~~~~~~

Signed-off-by: Mike Pagano <mpagano@gentoo.org>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf..e72f74b45 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -375,7 +375,7 @@ typedef u64 acpi_physical_address;
 
 /* Names within the namespace are 4 bytes long */
 
-#define ACPI_NAMESEG_SIZE               4	/* Fixed by ACPI spec */
+#define ACPI_NAMESEG_SIZE               5	/* Fixed by ACPI spec */
 #define ACPI_PATH_SEGMENT_LENGTH        5	/* 4 chars for name + 1 char for separator */
 #define ACPI_PATH_SEPARATOR             '.'
 
-- 
2.48.1


