Return-Path: <linux-acpi+bounces-15668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64CB25D98
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 09:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F035A0153E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE726C399;
	Thu, 14 Aug 2025 07:29:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC3259C83;
	Thu, 14 Aug 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156588; cv=none; b=HIhq0KvvIqtAaBavw8/mXI+vk+U4aQ07+J5kBSyqZl+5oRgDX337Hj1d6lncxvG5bIpq9qrHVe6Kjzr20CN4Lz3iei/IpCNGRXI3kzOuhPK/FqRuPyclIelE89jqac8ezSqhFoQBZzustqPD9PAxXxoeHpcB/ChBSn5dZSAXi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156588; c=relaxed/simple;
	bh=6NDjjCsQASG5ZZOQnM0m9/VFP2301fUlMsPXAXbht4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dBTJIVSziNx1ROB+sL0LbkjMrah9LTLlcnDvk83dqgT2ul0MpaDy+GdgVRalRSpE0eaPVeJJpuUKH7r05IKYbewk52M1Pw74zypanCEI3w549o53OCrpZidF8E73zIcF0GF2DZlbaZniWo6LOb8AQL3Tirsj7brrR9YBiqBBEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6fcc959c78e011f0b29709d653e92f7d-20250814
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_C_CI, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:265ac78d-44e1-410e-a988-49924ad70b26,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:265ac78d-44e1-410e-a988-49924ad70b26,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:afcbee8ec8a41c6e65ebd45262442616,BulkI
	D:2508141529406YEDDMS0,BulkQuantity:0,Recheck:0,SF:19|23|38|43|66|72|74|78
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 6fcc959c78e011f0b29709d653e92f7d-20250814
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.165.11)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 755108821; Thu, 14 Aug 2025 15:29:39 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 0/2] ACPI: processor: idle: Per-CPU idle driver for hybrid CPUs
Date: Thu, 14 Aug 2025 15:29:34 +0800
Message-Id: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses limitations in the current ACPI idle driver model
for hybrid CPU architectures (e.g., ARM big.LITTLE, Intel Alder Lake),
where different core types have distinct _LPI-state characteristics.

This series introduces:

1. A per-CPU idle driver model to accurately represent idle-state per core type.
2. A new interface to fetch cpuidle_driver by CPU ID, required for early
   registration scenarios.

This issue was initially discussed at:
https://lore.kernel.org/linux-pm/97e8bc72-e44b-487a-91ba-206732094955@arm.com/T/#t

Changes since V2:
- Fix "using smp_processor_id() in preemptible" BUG in patch 0002.

Yaxiong Tian (2):
  cpuidle: Add interface to get cpuidle_driver by CPU ID
  ACPI: processor: idle: Replace single idle driver with per-CPU model
    for better hybrid CPU support

 drivers/acpi/Kconfig            |  1 +
 drivers/acpi/processor_driver.c |  3 +-
 drivers/acpi/processor_idle.c   | 66 +++++++++++++++++----------------
 drivers/cpuidle/driver.c        | 16 ++++++++
 include/acpi/processor.h        |  2 +-
 include/linux/cpuidle.h         |  4 ++
 6 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.25.1


