Return-Path: <linux-acpi+bounces-15581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831EB20038
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F8A16B15B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DA2D94BC;
	Mon, 11 Aug 2025 07:24:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604382BB1D;
	Mon, 11 Aug 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897052; cv=none; b=elnYyaWlkJtylFZZ9Wro/E8CPs7oX5KlCEQ/b60aKC3auNi/O8U1XtGVlOpiBdR6lVT/H/e868cJcY5Tq0aKdrXfH5pQJGAopYMzbNh2TkPgDBbDZsVc9CLK2ulJ+f6ac1Al3uYUv+e9WhGdRS2+tKQfjaOcfAfwhJdZb+jsCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897052; c=relaxed/simple;
	bh=kRP5oP8XQwPONb0qFYCeZrgna/xmATw2HO0oZB3kITU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6n+r6SwHGn9UnlFtzf/4a7ytd3Gv2O/2Z3b7BHUezgiMj1uIfV+o00UyYDFjX++HgUjW7F/3R4Xs1KvA6WG/fJqVFF7zuD9q3j8M1Ng7N3CgBm7p60CWIW7ay8Mko3M8RiRI9IziHpqrkf+5hzdrN1ghT+Ng3QvrChZPT1UprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23587d56768411f0b29709d653e92f7d-20250811
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c7240ac8-b254-4a7e-b893-399339aa0807,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.45,REQID:c7240ac8-b254-4a7e-b893-399339aa0807,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:6493067,CLOUDID:c9379ebdce43914cacfec9a73b5e9b96,BulkI
	D:250811152356F2SSOFHD,BulkQuantity:0,Recheck:0,SF:19|23|38|43|66|72|74|78
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: 23587d56768411f0b29709d653e92f7d-20250811
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(106.16.203.49)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1750111063; Mon, 11 Aug 2025 15:23:54 +0800
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
Subject: [PATCH 0/2] ACPI: processor: idle: Per-CPU idle driver for hybrid CPUs
Date: Mon, 11 Aug 2025 15:23:49 +0800
Message-Id: <20250811072349.753478-1-tianyaxiong@kylinos.cn>
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

Yaxiong Tian (2):
  cpuidle: Add interface to get cpuidle_driver by CPU ID
  ACPI: processor: idle: Replace single idle driver with per-CPU model
    for better hybrid CPU support

 drivers/acpi/Kconfig            |  1 +
 drivers/acpi/processor_driver.c |  3 +-
 drivers/acpi/processor_idle.c   | 60 ++++++++++++++++-----------------
 drivers/cpuidle/driver.c        | 16 +++++++++
 include/acpi/processor.h        |  2 +-
 include/linux/cpuidle.h         |  4 +++
 6 files changed, 54 insertions(+), 32 deletions(-)

-- 
2.25.1


