Return-Path: <linux-acpi+bounces-13682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC935AB320C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F3E3ACD90
	for <lists+linux-acpi@lfdr.de>; Mon, 12 May 2025 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C9425A2DA;
	Mon, 12 May 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VcTDFlAM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506D25A2BE;
	Mon, 12 May 2025 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039594; cv=none; b=cmmXtHNrNl8oc3FpnM+rkAqzrId8S0rfB9NyC/qDG91cMNJ/dbLAF1PgLzHQ0C9h/rFcMV22uAoiBaRlzshlhjXG73u0AGv4GTiuFmm/WwqOFRjzh4hmL1V/I767nAOoaTUb4ud+0xkSDdD4U3GaGoGmIXTWGX9IU4h7KqRQAC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039594; c=relaxed/simple;
	bh=PkHHRi91TsmNgeDiiqGzH6MLxD+zfbPOyGJVIBdp9bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVcNq3EiLv4rnXHFbBrmEpqxr+HaW5DFO1+wM8sHkraSy3oJrMrGr7yBxZ5BZql4XutFC/r/LdAQ7aAKb8mT63/F+QTegFH20yNF9rPDVYryE9cbB5tcSUguziXCpYlEePnklelab6Rybo5JzZoIeTWBZMD3yvHyDoj5Z5i9eaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=VcTDFlAM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54C8jqc51586901
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 12 May 2025 01:46:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54C8jqc51586901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747039561;
	bh=irTR9cBZ/bUuJJE/VFD2XvoxgAwJuCqUqRaQbxDTnhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcTDFlAMSO7tiJedpeu3nDD6gS5DKigxV5zB3FuQKYZuCYrH0Lnq6AyaDavtFxQ+5
	 ivDulsoeXhp5fga7oMz3GqsLoQUCH7YHtAGOBPydV4CeUV1qfkYmG4WfTZ17vkHC8X
	 RH3QbWUsZGXrV8DJbo7Rs8XEeCcGNJQYuntOy9EF5GEngLsIAzmYPxRn2BDdyqkMbx
	 w3IxvetoI01oDeyxtBGKYR7xymh7giIgJSqj4+DupWNwLFA0keD5peqp4UGQ3ZbuxD
	 Id5FCpC5mxUpyYR4tLAS4sui06LZxoaL6E9/ixZj6OIz3pKprWQZgCloVU3I3ImoLP
	 o3GbZYpLKgr/g==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org
Cc: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 1/3] x86/msr: Remove a superfluous inclusion of <asm/asm.h>
Date: Mon, 12 May 2025 01:45:50 -0700
Message-ID: <20250512084552.1586883-2-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512084552.1586883-1-xin@zytor.com>
References: <20250512084552.1586883-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commit:

  efef7f184f2e ("x86/msr: Add explicit includes of <asm/msr.h>")

added a superfluous inclusion of <asm/asm.h> to

  drivers/acpi/processor_throttling.c.

Remove it.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 drivers/acpi/processor_throttling.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index ecd7fe256153..d1541a386fbc 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -21,7 +21,6 @@
 #include <linux/uaccess.h>
 #include <acpi/processor.h>
 #include <asm/io.h>
-#include <asm/asm.h>
 #ifdef CONFIG_X86
 #include <asm/msr.h>
 #endif
-- 
2.49.0


