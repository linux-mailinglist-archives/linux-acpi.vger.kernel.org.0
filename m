Return-Path: <linux-acpi+bounces-12584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDA7A77ABD
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8578188FE3E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA9202F80;
	Tue,  1 Apr 2025 12:20:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A01FE45A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510050; cv=none; b=OD8SYrDd2B2FsX2ktO9WoS8hPNyI19t/z7jbVT/AjrSspHZRdllv63auJbXdrNxapIqMWc1UI6uG4tLQmLR76n/XEOQhAWv2rQLqmqEKDDFILpVCOLAy6MydVI+YFJEG5LTdOBJ/LoZeNK7rEZAUQpTD8HyPNsxtokDogokvtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510050; c=relaxed/simple;
	bh=lj9KsgsGwd+uZhjYDHENKDpq7dKQqWlTpOInVbRh6+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+jFE/VC4KNCoGZSaP6kz2JSyJqaIfkJlDSC8+FyCb22tsEUCFwl8eEKNsdL9Qu2+cfaobQHrjOczzsYSO5RJI3Jym2gCXAWlArsks++y+/OSWQ2Fq402F4iumICojIpcl2eCQ8T1WflVLuovT5qPrXUcxR0J2yhMll42T1W838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b5cbf9180ef311f0a216b1d71e6e1362-20250401
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:77f84443-88ab-4b00-a774-47820ac58270,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-7
X-CID-INFO: VERSION:1.1.45,REQID:77f84443-88ab-4b00-a774-47820ac58270,IP:0,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-7
X-CID-META: VersionHash:6493067,CLOUDID:50413007da854dd15d1e8fddb39a0412,BulkI
	D:250401202036VYD8D63W,BulkQuantity:0,Recheck:0,SF:16|19|66|78|102,TC:nil,
	Content:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_USA
X-UUID: b5cbf9180ef311f0a216b1d71e6e1362-20250401
X-User: shitao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <shitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 676312059; Tue, 01 Apr 2025 20:20:33 +0800
From: shitao <shitao@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	shitao <shitao@kylinos.cn>
Subject: [PATCH v1] ACPI / battery: Use rounding to optimize the power calculation
Date: Tue,  1 Apr 2025 20:20:27 +0800
Message-Id: <20250401122027.302468-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some batteries may have the problem of aging and losing power too quickly,
users may immediately display 99% battery level after unplugging the charger.
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
index 6760330a8af5..e5181c6cf73a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -279,8 +279,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		    full_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
 		else
-			val->intval = battery->capacity_now * 100/
-					full_capacity;
+			val->intval = DIV_ROUND_CLOSEST_ULL((uint64_t)battery->capacity_now * 100,
+					battery->full_charge_capacity);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
-- 
2.25.1


