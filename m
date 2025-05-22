Return-Path: <linux-acpi+bounces-13846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82DAC02B7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 05:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52553B0393
	for <lists+linux-acpi@lfdr.de>; Thu, 22 May 2025 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E409C1442F4;
	Thu, 22 May 2025 03:12:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9BD13957E
	for <linux-acpi@vger.kernel.org>; Thu, 22 May 2025 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747883520; cv=none; b=hes0D0uGe4cJbrfZsniJL29r+0lePy2oog5sVcP1kkDJ5EkejNS31uVEHz6XaKsFPaE97YMJO/5mJy0y3A4zduvYbRA/IDKQO11/yUpWd6w3dENEkns/kwDRufaq3ZIzSgUymMa20V9YRXHIZIy0UH+fBLF1qzi4QPQHYokVuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747883520; c=relaxed/simple;
	bh=YjK8kWVGAgGowNxbiKTxcOwn+2kgmVCAfQAJTInuKCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8GEkg38DKYhnvBcczQ7zZGONz09JQZHk3syJ0JGU3HNZUd7WiN65JLq3IVTcEhfahrqRLW9r51TIMRkVLcdbQeIoKmIs5Ma1bOILOssvAoayoeajSVxTmmwb+iPqVb6sjEeE7Voth85o/SbUwpq19p0oeTFBAt1fH+s/rF6Q54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 81786f0436ba11f0b29709d653e92f7d-20250522
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:39c60749-e755-4f83-8be9-c447bdce87d9,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-INFO: VERSION:1.1.45,REQID:39c60749-e755-4f83-8be9-c447bdce87d9,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:0b49b18b702cf05e5b86cceeb25ddd41,BulkI
	D:250522111152B63CIZ9H,BulkQuantity:0,Recheck:0,SF:19|66|72|78|81|82|102,T
	C:nil,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 81786f0436ba11f0b29709d653e92f7d-20250522
X-User: shitao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <shitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1747760062; Thu, 22 May 2025 11:11:51 +0800
From: shitao <shitao@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	shitao@kylinos.cn
Subject: [PATCH v3] ACPI / battery: Use rounding to optimize the power calculation
Date: Thu, 22 May 2025 11:10:56 +0800
Message-Id: <20250522031056.2401832-1-shitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJZ5v0hVQTq8f0bgeSa4+qYWosBHXADXLXviMxNnpafAV0NCmw@mail.gmail.com>
References: <CAJZ5v0hVQTq8f0bgeSa4+qYWosBHXADXLXviMxNnpafAV0NCmw@mail.gmail.com>
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


