Return-Path: <linux-acpi+bounces-8418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B859D98648D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923CAB38F27
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342A13C695;
	Wed, 25 Sep 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lIHx3dJY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4A46088F
	for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277921; cv=none; b=uRtGkqGxsG9FK35xl/1JvbxO1pKirn9Jgi8B2D4HHyD0BAM7bhk4lC0l87WOctfOCFk2pAbatSjdITrbLaO0ijOjza4Al8l7aYA8QJL5+ntVRGTIm2N1i8SEuuoEpt8wRjFeRedKl9tcG10LMRAigQ6jx/peOBuVAeCwYtALGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277921; c=relaxed/simple;
	bh=/ZmUMys4DtorXcnR1Qb85Qe9XFVHtwDK3x2Oba/L4+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQO/c3ihgiDr5a29C/zYxcY8ynnPm3dxpbslZpnFRwnzUduHPoDb4tdRYJO+B4Ip2Lvp6X+sdpJpXCjmQ00j4OR385WLD+bJwhyh6PB7Lp/cedwk4Q0n1SHs674GfoTWAuc77SbNsIXC2+agOgyXxNlKtLJk9fw9wIg2KOt6Ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lIHx3dJY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c579748bf4so119356d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 Sep 2024 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727277918; x=1727882718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orIOabJvqf20M5UAV+7ODryvOD0sVY9jQ3+6D8aBSg4=;
        b=lIHx3dJY0s4/GfALNOr6YSNqLkyM6spHclF8dQDKNchnezjFzYLzTL73cx0yAgsb9D
         AE9ELp6LeCArE7KfwVTuAtxzYxACkd9ItWSeO6TWFGg+eqpKAmgLed8anpSSrkNVwpEP
         PV84MmoPZpnA+7I746Am38hr2ZvrWeJSTdzDmiOKp1G2itUflxAT7xodCLT0Hd4guTOq
         D9cFd0mIzJ7n00xytQlxNH22DzzGUsHhZuHzXlUOo9D5ueGvfpwexvys81PcAuqy0cUP
         +w0ANwdPZ4aL/cotIVc3jD2ZDVGYTF/Frmg5X2rLKgBO8JwE7XxVaqYA1OvDzpI7j+1M
         lvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277918; x=1727882718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orIOabJvqf20M5UAV+7ODryvOD0sVY9jQ3+6D8aBSg4=;
        b=hX7EKmDLWjbQP29cmp2kFn+wd1llZ8w7dEht2cd2oqbfFut1Ouv5G2piofZcABnrIO
         0wIQ7UTrkbpTokq1tr2bA7heQmmPNZYmisTdoMNnzUGC5u1SKnZVhGn36nsoWIT4ONpJ
         D78tYY25JVMDF98tXci5UYHNCegWemPDR5a7NQZ78cmGH0JTEb9t6/tq/h/riLLFBoeB
         v68Oz80Bl4Bc46wP3o2IjV+kJIfvuieFKDoyDAh3nqV1b7t744C9KCoZCuIBO1yFeqbV
         zGKuOnaAL4/BQ8sOhsQbQQLVouhNo5Vim9yc2OtVF9cTig7oRg4C8c061aWLsTZBSq2M
         2NHw==
X-Gm-Message-State: AOJu0YzL99IOtpaNVAaY1eUUduXQHQ7TMU8L6Z4NmI9ePusVxNrYpeF0
	63p309T44J/hLZM+lA0vQyXzLdoQgpOQoygkBghaBIojCZkiow296zg7LeQKEihisZ1IEA2nRde
	P
X-Google-Smtp-Source: AGHT+IHiFngUSnA8bK4RDalu/gI9E5kd/laZHZZZkJO9IZtX9rzd8lIUxM/bxgBqoO1qdJ3dIV5NXA==
X-Received: by 2002:a05:6214:3287:b0:6cb:2ad6:78ef with SMTP id 6a1803df08f44-6cb2ad67dd6mr16130356d6.4.1727277916341;
        Wed, 25 Sep 2024 08:25:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb254ead6fsm4583356d6.26.2024.09.25.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:25:15 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-acpi@vger.kernel.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	gourry@gourry.net,
	dave.jiang@intel.com,
	haibo1.xu@intel.com
Subject: [RFC PATCH 1/2] x86/mm: if memblock size is adjusted, update the cached value
Date: Wed, 25 Sep 2024 00:52:41 -0400
Message-ID: <20240925045242.3735-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing CFMWS, we need to know the current block size expected
to avoid accidentally adjusting the size upward. This causes a value
to be cached in a static global.  Update the static global if the
value is subsequently updated.

Print a warning that this has occurred for debugging purposes if
blocksize is changed at an unexpected time.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..0db7ce11e5c5 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1424,6 +1424,7 @@ void mark_rodata_ro(void)
 
 /* Adjustable memory block size */
 static unsigned long set_memory_block_size;
+static unsigned long memory_block_size_probed;
 int __init set_memory_block_size_order(unsigned int order)
 {
 	unsigned long size = 1UL << order;
@@ -1432,6 +1433,19 @@ int __init set_memory_block_size_order(unsigned int order)
 		return -EINVAL;
 
 	set_memory_block_size = size;
+
+	/*
+	 * If the block size has already been probed, we need to change it.
+	 * This can happen during ACPI/CFMWS parsing, since it needs to
+	 * probe the system for the existing block size to avoid increasing
+	 * the block size if lower memory happens to be misaligned
+	 */
+	if (memory_block_size_probed) {
+		memory_block_size_probed = size;
+		pr_warn("x86/mm: Memory block size changed: %ldMB\n",
+			size >> 20);
+	}
+
 	return 0;
 }
 
@@ -1471,7 +1485,6 @@ static unsigned long probe_memory_block_size(void)
 	return bz;
 }
 
-static unsigned long memory_block_size_probed;
 unsigned long memory_block_size_bytes(void)
 {
 	if (!memory_block_size_probed)
-- 
2.43.0


