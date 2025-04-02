Return-Path: <linux-acpi+bounces-12632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8BCA7892F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 09:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C1218924BE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004C23371F;
	Wed,  2 Apr 2025 07:54:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAC2F5A;
	Wed,  2 Apr 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580443; cv=none; b=nVYB+bcOfO8No9ggDgcv3DXglAQF28k6gApfc8B/QcN5qS9F+PWG52Xer4q0gdUeUwbMgWsLPGaB7SK4RPHxMchLGTlsc/tmJ59KTCDLIjE8xq6kJOfaCstW9RRWCFKPyyjskuQB8r3oBRhCPoiP+ObQUu67O67sl35Ek9fT5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580443; c=relaxed/simple;
	bh=GXpIJY0qTn6iM4clIdE2Rbm3NHxaqOO6tpSO2HXyIB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NI3W6lYk0vWTDDc730zW5q1c4C4AlA2AD3blJ5IhHvDbmhpnC/M4GlDrwf66LDC7R4T6CRa90P9cKMCtPSFAfbqwuftYlfS9ymvZ5oS6dDRGU5Wl64+yho2tbT1yG+kzchPPUCe+quKM3Ugt0jtSYQvSiOBVr4Z/KFYhKdRcgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9e1615c00f9711f0a216b1d71e6e1362-20250402
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c06ae3ba-5694-49c2-afbe-f9a4d98934ad,IP:0,U
	RL:0,TC:0,Content:31,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:36
X-CID-INFO: VERSION:1.1.45,REQID:c06ae3ba-5694-49c2-afbe-f9a4d98934ad,IP:0,URL
	:0,TC:0,Content:31,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:36
X-CID-META: VersionHash:6493067,CLOUDID:34959bcfc0261e44c3041503def90f69,BulkI
	D:250402155354VL5IRVCQ,BulkQuantity:0,Recheck:0,SF:19|38|66|72|78|102,TC:n
	il,Content:4|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 9e1615c00f9711f0a216b1d71e6e1362-20250402
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1010428196; Wed, 02 Apr 2025 15:53:51 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: o-takashi@sakamocchi.jp,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	yu.c.chen@intel.com,
	Riwen Lu <luriwen@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] tools: Restore built-in rules for subdirectory tool compilation
Date: Wed,  2 Apr 2025 15:52:53 +0800
Message-Id: <20250402075253.1772541-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
when building tools in parallel"), the top-level MAKEFLAGS=-rR
(disabling built-in rules/variables) was overridden by
subdirectory-specific MAKEFLAGS during tools compilation. This allowed
tools like pfrut and firewire to implicitly rely on Make's built-in rules.

After the aforementioned commit, the -rR flags from the top-level
Makefile began propagating to subdirectory builds. This broke tools
depending on implicit rules because:
1. -r (--no-builtin-rules) disabled implicit .c -> .o rules
2. -R (--no-builtin-variables) hid critical implicit variables like CC

Fix this by filtering out -rR from MAKEFLAGS.

Fixes: d1d096312176 ("tools: fix annoying "mkdir -p ..." logs when building tools in parallel")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d138b17b8840..abf9cfebaf4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1431,11 +1431,11 @@ endif
 
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter-out rR,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
-- 
2.25.1


