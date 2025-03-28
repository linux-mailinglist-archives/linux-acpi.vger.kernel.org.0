Return-Path: <linux-acpi+bounces-12520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686E0A744B7
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C63A4FFA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 07:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE3211A05;
	Fri, 28 Mar 2025 07:48:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F421171A;
	Fri, 28 Mar 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743148089; cv=none; b=Oj8mugeMqj1EguaHzK/dE8WXaRhfXM9GfbOyDn0gEYNhIjzPQ9ImJNuOOC20aUCeJQSYjghdlc0YZ8BUfXJdYWYgMaOtPoO+d7vNRnK1nQuj9+aX0149jafk61N/g81VtKIt1hRVqytviBqcooNL+3rbIgKhbV6IZqcwHrL7sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743148089; c=relaxed/simple;
	bh=IWSfYK3ukHnxWl3RBO25f4Y1+/GOZMUiZZVobtATz8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VT0TpaHwyqolCqX2qJCIacRMT2glpBhufl7nkx0p9eBiEwgKM3fZ2gODcqFyZpa8bUIwNu6Vgtvp4LkxS7QiEfy7qDh7QQJwA22otW7V0rHKAJANuYD3FBXfXMZPGF/gdoLzMLoyyC1xvOn2bTOnXiwObODfd+kaOBTQRg/7b9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f5e55b0a0ba811f0a216b1d71e6e1362-20250328
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
X-CID-O-INFO: VERSION:1.1.45,REQID:cc3b53a5-0111-4e00-96bc-dfa742625284,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:cc3b53a5-0111-4e00-96bc-dfa742625284,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
	lease,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:0cf768b468af5a1b5f3fb68e35504a8d,BulkI
	D:250328154248NRJDV73B,BulkQuantity:2,Recheck:0,SF:19|38|66|72|78|102,TC:n
	il,Content:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: f5e55b0a0ba811f0a216b1d71e6e1362-20250328
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1370077647; Fri, 28 Mar 2025 15:47:55 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: o-takashi@sakamocchi.jp,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Riwen Lu <luriwen@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v1] tools: Fix compile error of pfrut/firewire
Date: Fri, 28 Mar 2025 15:47:50 +0800
Message-Id: <20250328074750.3524280-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value -rR of MAKEFLAGS implicit do not use make's built-in rules and
variables. Previous commit d1d096312176 ("tools: fix annoying "mkdir -p
..." logs when building tools in parallel") removed the MAKEFLAGS=
command for tools and caused the built-in rules for pfrut/firewire
failed to take effect.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 tools/firewire/Makefile               | 7 +++++++
 tools/power/acpi/tools/pfrut/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/firewire/Makefile b/tools/firewire/Makefile
index 67b6e9fca83c..8ba53e1173c6 100644
--- a/tools/firewire/Makefile
+++ b/tools/firewire/Makefile
@@ -12,6 +12,13 @@ nosy-dump : LDFLAGS = -g
 nosy-dump : LDLIBS = -lpopt
 
 nosy-dump : nosy-dump.o decode-fcp.o
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+
+nosy-dump.o : nosy-dump.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
+
+decode-fcp.o : decode-fcp.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
 
 clean :
 	rm -rf *.o nosy-dump
diff --git a/tools/power/acpi/tools/pfrut/Makefile b/tools/power/acpi/tools/pfrut/Makefile
index 61c1a96fd433..e682ee135f1d 100644
--- a/tools/power/acpi/tools/pfrut/Makefile
+++ b/tools/power/acpi/tools/pfrut/Makefile
@@ -8,7 +8,7 @@ EXTRA_UNINSTALL = uninstall-man
 
 CFLAGS += -Wall -O2
 CFLAGS += -DPFRUT_HEADER='"../../../../../include/uapi/linux/pfrut.h"'
-LDFLAGS += -luuid
+override LDFLAGS += -luuid
 
 TOOL_OBJS = \
 	pfrut.o
-- 
2.25.1


