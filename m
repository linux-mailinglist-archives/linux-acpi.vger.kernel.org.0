Return-Path: <linux-acpi+bounces-14123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87DCACD9B9
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C7D3A4FE7
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A328A1C1;
	Wed,  4 Jun 2025 08:26:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73520288C0F
	for <linux-acpi@vger.kernel.org>; Wed,  4 Jun 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025595; cv=none; b=gTfmf94abdO2KGarAP0iKY+kg8tvyob4v5o6YamzGdQjUWLS/FyGods1zbTBHTsxxkVQzfN9djtNkHXCAqHEeT/IVMcEwHEhPY96L04EQA9C7FkCStGbxkjEzjeiMEtCoFfdPJbqJ6s23XnbAZ15JHN2cSGqSFfF76KDqLam+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025595; c=relaxed/simple;
	bh=nTKAFUGHyMprPWo3Jgu0eCyU1Xtk1EidN7UdK99XVR4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nWBoZ1slfA7ls5Vaj9hevjMymUvcG6kq/IjJgFEHSd89oCnIGMDXuYG/djY7Sd/u22sVSIx38Qa1EgjwweOH9dGytU/hGy9m99GU97caD8RbRkqPuRTS3G/g741ajHCtlzBPzLD9NN6+IO0d3SpxbQdZtp4O7C/Kkb9rOpzEc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9abd23ac411d11f0b29709d653e92f7d-20250604
X-CTIC-Tags:
	HR_CTE_8B, HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE
	HR_FROM_DIGIT_LEN, HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN
	HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:80281099-7b6e-41ce-9418-00069a96da26,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:80281099-7b6e-41ce-9418-00069a96da26,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:dbf8849afc0002b0b214a8d8b1c962d0,BulkI
	D:250604162626IZ9CMQRX,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-UUID: 9abd23ac411d11f0b29709d653e92f7d-20250604
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1064113673; Wed, 04 Jun 2025 16:26:25 +0800
From: Li Jun <lijun01@kylinos.cn>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lijun01@kylinos.cn
Subject: [PATCH] acpi: pm: del init error to 0
Date: Wed,  4 Jun 2025 16:26:05 +0800
Message-Id: <20250604082605.119965-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The init action consume additional CPU cycles. the
acpi_enable_wakeup_device_power should assign a value
to 'error' before it is read.so the var don't need init
to 0.

Signed-off-by: Li Jun <lijun01@kylinos.cn>
---
 drivers/acpi/device_pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index dbd4446025ec..f77042c930a7 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -851,7 +851,6 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
 {
 	struct acpi_device_wakeup *wakeup = &adev->wakeup;
 	acpi_status status;
-	int error = 0;
 
 	mutex_lock(&acpi_wakeup_lock);
 
@@ -864,7 +863,7 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
 	if (wakeup->enable_count > 0)
 		acpi_disable_wakeup_device_power(adev);
 
-	error = acpi_enable_wakeup_device_power(adev, target_state);
+	int error = acpi_enable_wakeup_device_power(adev, target_state);
 	if (error) {
 		if (wakeup->enable_count > 0) {
 			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-- 
2.25.1


