Return-Path: <linux-acpi+bounces-12666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E102A799FD
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 04:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F244B16C96D
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 02:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4876BB5B;
	Thu,  3 Apr 2025 02:35:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5BB666
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743647735; cv=none; b=O36c246KL+D72Gzb+PzY2ScwEaWXh9PZyAv2kaV95Ski+A4D9a+5C9NnrTJUuLKaWucoNSCpN9TAWgfm25dyKuORODCyeq4fyTTtEOcDqeFmQ4J3LTepKbq9Pz7NHK9zOV7tsrFFHcrtnzXPSNiIUEfvShOBc3fxS2cTh7DFse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743647735; c=relaxed/simple;
	bh=Ruw+mWz8AWpzkwY2u0LChHwIbBIBB55z+BZOgRk8Wjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PreWLjD7AjNFpf5LFPSvHRCpTEprqHWBFqR4514jNUigsYuDmt3UhJkIP4tWVBDinIX2+MuRymrm0u8q2QsEjDtEfO9QdpIQJqzpP50mG3CvrL8eIa6bI7gdjDbNIZV+Ag6zYE9Cp427KFukpCTDePN9sX3Moa3Arau4Ne/A/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4ca64b9a103411f0a216b1d71e6e1362-20250403
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:24bd6aa5-4422-42d7-99c7-0b65a3cd99d8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-INFO: VERSION:1.1.45,REQID:24bd6aa5-4422-42d7-99c7-0b65a3cd99d8,IP:0,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-20
X-CID-META: VersionHash:6493067,CLOUDID:af65ad12326339854ddb68e6d82cf883,BulkI
	D:2504031035268G54P6R2,BulkQuantity:0,Recheck:0,SF:19|66|72|78|102,TC:nil,
	Content:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 4ca64b9a103411f0a216b1d71e6e1362-20250403
X-User: shitao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <shitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1205809989; Thu, 03 Apr 2025 10:35:25 +0800
From: shitao <shitao@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	shitao <shitao@kylinos.cn>
Subject: [PATCH v2] ACPI / battery: Use rounding to optimize the power calculation
Date: Thu,  3 Apr 2025 10:34:59 +0800
Message-Id: <20250403023459.62055-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some batteries may have the problem of aging and losing power too quickly,
and users may immediately display 99% battery level after unplugging
the charger.
This will bring some unnecessary misunderstandings or troubles to users.

Use rounding to optimize the power calculation, and expect to display 100%
when capacity_now is only slightly less than full_charge_capacity.

Try to avoid unnecessary feedback from users about the battery not being
fully charged or dropping out too quickly.

Signed-off-by: shitao  <shitao@kylinos.cn>
---
 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8af5..8eb9dc98c2c4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -279,8 +279,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		    full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
 		else
-			val->intval = battery->capacity_now * 100/
-					full_capacity;
+			val->intval = DIV_ROUND_CLOSEST_ULL((uint64_t)battery->capacity_now *
+					100, full_capacity);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
-- 
2.25.1


