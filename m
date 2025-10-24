Return-Path: <linux-acpi+bounces-18184-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058BC06439
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 14:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813253AC6EB
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACFF316909;
	Fri, 24 Oct 2025 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7uGKTtK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30E313529
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309097; cv=none; b=Bm/7RagugDVSXzapekTAi8UpSeC9TgjYsHGMqIwAu1Yt1o6izMBPyUPW4+7Pks8pc11+SRvJA1HxuRzYExqNjjcfncbwwXpEWx62gfpcZnjko4LQ3zXPrYR102u3Bbyjtb8grJLKyGDYBa4F/OCxHb/dLwLUYKxuRP/Cyb7MNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309097; c=relaxed/simple;
	bh=XiTDVkg1kAETpNdGmqCEBuwWFR6IVEd0PECMW0nJHq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNI1MtbrRAhkhsGiQDQ6BlZj0yTEsw3CLYGeMY2O2b0gfmtaK74oI51VX80I3rA+2M4ECsPgMFFG+MQ0pCi0UuxdZkaJ6JY+2JB2zFeO3aNVufoqdBE6ad3V41nJVJh7biW3NKciYg5q7FMQysdAOYVSEhXB/i82NeY8tHHaTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O7uGKTtK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FLBX022330
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 12:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2bAsfJsMqfmVZMLORayPyE/1jk3wBrKlzyf
	VzHYGp8s=; b=O7uGKTtKODlV1izXE+xekeaagbTBEkBALzCFByC/LBULekqcUMs
	tM4kZCOaiirBv+YkyHFrAHAz5cCbAgVP8jqaRfIg7iS7DAgiODvEGIRsRWNvcnDy
	zbQ2nGnhrfHVsXZGA23LXz6GhJ4FSAV5B8BnLmd+LYZuErzHzrUo4xN3AVKusmMO
	C4QTGyXf/wviu+OfxSrxBnB4XW6CKRwpeJDpl2gBTUGT9tpkOabEoNpImrOogzDs
	mW5bl8NOEyiNSGoulUCf/nu1BC3ci0SEo1cARRPa28o2GO02/PWsNMp62/uFnXcm
	ji0D4Scp9mgfYW2GjMoRnPgUs9Ri+EjSsjA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qny7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 12:31:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26985173d8eso46517265ad.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 05:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309094; x=1761913894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bAsfJsMqfmVZMLORayPyE/1jk3wBrKlzyfVzHYGp8s=;
        b=gdWtFtxxGIRsmiTROdAWSeEGumkpSiyVv7ViUcOrtBLuFcG5z8qxfX51QOy3YKoaPx
         ez1Oa2tXaTvQ0iqbOS64lyieBet5yRKGLeyO64/poDitt/veOotS/PGzMgjlV5Y12JXq
         xP28XqFeS4VDfNAn/S4VPOJAMxXVWRIzfnGXGMB6Lt1CPXK0c5xkpBd/xZHB+4oJIQx+
         M7kvfsyVtV5ihQ6D+CmSTPEEW1imdGVr09Pkl7ByqYElOsrf5FFlAiAGQzVCz5Yj+Xab
         DVbUBH+ZUZjzB41PV78yMZRbstvWtRWbIImC/seJJXjrHcvZzEXat9YTRgTB0J9UHGPb
         uqUw==
X-Forwarded-Encrypted: i=1; AJvYcCViL5/sjcJj/SMNc3LYMrqe/QGs0b+MPBrWjs+SL0oRtBE6tK2lswv9seqCrXlPjri74Y/JyBv9ggdv@vger.kernel.org
X-Gm-Message-State: AOJu0YyoW5DwPRETDAjpSkjnwhRjLaFbUA8zeMhCIBwGT4fjwhbZE4MG
	gC8zUMWGDVQnTeHCEO1HIgzEpN48my+4VUyJkQsOlxtmrjCycSTK4Z2xnQkFWe4K/Qfi8jUE7nh
	KGJjwSD/YSI4oicdtrVTbkA1numYUWna05eHZGwvbLYFJkjRRjubG4S5X72pGjziT
X-Gm-Gg: ASbGncsQzdJa79mQKtp+pef8TVeejtCs5xEDaGGQ9NiyxpANEXRffCseIUhSMMMRLZT
	hPzZ/5xCvUaCK8zrp+nSaPD7bb9+2JMiDIm9hOtOnWjpqsYByDPBN44Tvr8WGqbYIq46yTLTFNE
	nA38o744dtMztKr4jgBNgheCpLXpQyKyvBb5pP4Bx4BVx2Wg3qtYnLyXMOoGU5DoTpNlJIHzibh
	actxvgv2Qz5u5NumiPIgHASCnbf3EethldBFMMjm98Mr4fJCcYnvdEpv3zZnX/SZb0eJBmWCxGx
	fZqkDeKN1mIXy0ydNhHu5IQkdoy3Mc4EZ/yyyLP8b/j752dBB0xi2GlD1Nc/FqwLQYoKEeehPXt
	P8AkHQoi/SWcM+wBJzC4bdvCdQi64K0OzvVv1OqUefsQGzMf8hlbX
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id d9443c01a7336-290cb46bf6emr323434235ad.51.1761309093997;
        Fri, 24 Oct 2025 05:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEucBc3iLZLhsl0wh3jp8jpvtimkKB//Sc+M+8IumHk8rQsjhXsplOGeikn1LVFuY+rB3c6XA==
X-Received: by 2002:a17:902:d50a:b0:290:bfb7:376f with SMTP id d9443c01a7336-290cb46bf6emr323433855ad.51.1761309093557;
        Fri, 24 Oct 2025 05:31:33 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda72d0sm54981275ad.16.2025.10.24.05.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:31:32 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: rafael@kernel.org
Cc: lenb@kernel.org, cp0613@linux.alibaba.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Subject: [PATCH] ACPI: SPCR: Check for table version when using precise baudrate
Date: Fri, 24 Oct 2025 13:31:25 +0100
Message-Id: <20251024123125.1081612-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX2axXYrflw44e
 EyWPSXEvofEwNqY46sedtYD97vGx0f+zV/EDGlCNH1aaNJfU5Z/GfdUe2DoN1nJsx6Afr8szvKg
 sz1rl9sNtg0c1spVNZGH3HWtWBPXZAJb1cIwoGrETBDaNQrUAokQchVM+XOzMwdMn13yFORtWD0
 JaoGn++ujj6p3tJvcsiV4MW5klBrHMgnqdaYZaOe3Gc8JQAzVIt2o3SkK1aqo0WDxstJYKnmnwz
 XyqNnqCtYFaFXtAu0jGhK/kv1dCqXX9X+m17HcnqWxBgOJ0+RoDqEYCCr35B6SMM0S9t+YyHv5R
 jgugqd+9kRGLlI1F69KPw6qkVqP0Ajw0Se+X5MD7cvSdrxK5J5Bgedj+K4BbdtJX0hxwASeMeO5
 GcgA0PJ4SefdoN2Pod4K1re48BNR+w==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fb71a6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=3rrkCrMOeJKuegrRhzgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: hhE5VITBje-L3efbSyCpWbn2ofkYM3cr
X-Proofpoint-ORIG-GUID: hhE5VITBje-L3efbSyCpWbn2ofkYM3cr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Commit 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
added support to use the precise baud rate available since SPCR
1.09 (revision 4) but failed to check the version of the table
provided by the firmware. Accessing an older version of SPCR table
causes accesses beyond the end of the table and can lead to garbage
data to be used for the baud rate.

Check the version of the firmware provided SPCR to ensure that the
precise baudrate is vaild before using it.

Fixes: 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
---
 drivers/acpi/spcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index d4d52d5e9016..73cb933fdc89 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -155,7 +155,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	 * Baud Rate field. If this field is zero or not present, Configured
 	 * Baud Rate is used.
 	 */
-	if (table->precise_baudrate)
+	if (table->header.revision >= 4 && table->precise_baudrate)
 		baud_rate = table->precise_baudrate;
 	else switch (table->baud_rate) {
 	case 0:
-- 
2.34.1


