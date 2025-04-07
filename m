Return-Path: <linux-acpi+bounces-12775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41762A7D8B1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 10:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A93E7A329A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B722A4F8;
	Mon,  7 Apr 2025 08:55:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78722A7E0
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016119; cv=none; b=lno3P/I3hwgPELlsTfrT//mO0RAkjTRYwUmTG9UvJ85iNGPfeL8wBgDWOSuLf+duIZHV5YDOHh7AWROqM0+cdBppVUXqWhhY3U+Cjqc5bQCcfqRwM6pi0JgvpBpWhXOk4JVJkBSRxWWgxIwRVFl1cSlhR1rKw1bvDIBrb+T6Y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016119; c=relaxed/simple;
	bh=YjK8kWVGAgGowNxbiKTxcOwn+2kgmVCAfQAJTInuKCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rGIAxf2rqqdzeoxsT9OgiZUlwXc5CH5JQqTBDX21nhDIG/pk4CwKBqP6Rgr9zC/H4aVditRxmumOiQRcBQluQUCqWE2eFKQMWSaxXWnOuJIQF95/GFq84cCDUaW4QjR/N6Kx9vlzPVzfWXBp6CBuH+x1zI4t7qdawu2WsZ4O9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 022d908e138e11f0a216b1d71e6e1362-20250407
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
X-CID-O-INFO: VERSION:1.1.45,REQID:edfea4b9-32fd-4eda-bc76-462cc0eceec4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:edfea4b9-32fd-4eda-bc76-462cc0eceec4,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:2737a47cea0e2ce19011c178cb45e07d,BulkI
	D:2504071655103C6EHFO0,BulkQuantity:0,Recheck:0,SF:19|66|72|78|102,TC:nil,
	Content:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 022d908e138e11f0a216b1d71e6e1362-20250407
X-User: shitao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <shitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 792370676; Mon, 07 Apr 2025 16:55:09 +0800
From: shitao <shitao@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	luriwen@kylinos.cn,
	xiongxin@kylinos.cn,
	shitao <shitao@kylinos.cn>
Subject: [PATCH v3] ACPI / battery: Use rounding to optimize the power calculation
Date: Mon,  7 Apr 2025 16:54:19 +0800
Message-Id: <20250407085419.494234-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the difference between capacity_now and full_capacity is
within 0.5%, 100% is arguably a better number to expose than
99% and exposing the latter may confuse the user to think that
there's something wrong with the battery.

Use rounding to optimize the power calculation.

Signed-off-by: shitao  <shitao@kylinos.cn>

---
change for v3
-Optimization problem description.
-Use 100ULL.

change for v2
-battery->full_charge_capacity is changed to full_capacity.
Thanks!
---
 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8af5..6905b56bf3e4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -279,8 +279,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		    full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
 		else
-			val->intval = battery->capacity_now * 100/
-					full_capacity;
+			val->intval = DIV_ROUND_CLOSEST_ULL(battery->capacity_now * 100ULL,
+					full_capacity);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
-- 
2.25.1


