Return-Path: <linux-acpi+bounces-6142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2E78D84F3
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12998B20F8A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E412E1ED;
	Mon,  3 Jun 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RGhhYIUV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFA12C81D;
	Mon,  3 Jun 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424947; cv=none; b=F5w9vLPoPIaDPKKS/2kFxsxAu/Ly7HvDWmL4Qe8pUQ0Qr2HMT8Ir4t51PkhJjwvpDNsXyBhc8zR3FqU6k6dRFBLmYOD2BdorPrS3ucyI571CiQu3545PgGHOysYrmjAtS7gRvrqS/uNVZCtxkSSKtr6BC/TgzIGubuB5+g3rrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424947; c=relaxed/simple;
	bh=kGkn/VyFT7RT5SaJPj4Gnp36roPKLueE55uWRqmXPJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FlZb5yIJmRivwqkIpXLE0V6KYIbjWyN4wA5Z6XReiSwT4aX+LUkpzIVKpqk4JVa6naOG0noaTU/miDctsRD4iZxjHw10Ja408qPnYfu9eMpf0b4H3n+fPu5QEDI/fEZ/mZXNzSR/tHtApsypiK8wO/ri1e7fUYv4qZultAumA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RGhhYIUV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453AFoQL020531;
	Mon, 3 Jun 2024 14:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a8+iJWMkZBS4Gqc3lI03RH
	0aIEuaBm+EuMCpnqHFpkU=; b=RGhhYIUVn+9Z+ZK08GGcLMxszyei/rmGjzmWlc
	byowdPQDaG7mbzyQCHw7oyyhBBEKLCljoGLDRuK+9uXylBQBoZlBFwGramKpyGiK
	YY4YgnU4dkR+2xXU9YkcckmhzNiQ1D6MV1XKUcuYq+LUdE5L7ocEvdGrvXXN4Mdj
	6LP530wdpf2RAV+pSWmWm/YpO2bFEfWv3IlxP3ED16Qk9DfLqHvymSOexKPg5Aqx
	b+EIM/pfrATl7QeKBehTU+6GLR7TRlV8dTmMmhOr+KQkosGV3Wr4dL7dTsezfWcM
	RzyK4qcdh+DVwCvu3YMUrG6Hzp/NCv1fpmknas7Mp03s3+Bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qm59m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 14:29:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453ET2KL027199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 14:29:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 07:29:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 07:29:02 -0700
Subject: [PATCH] ACPI: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-drivers-acpi-misc-v1-1-fd7f7de1ce19@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAC3TXWYC/x3MwQqDMAyA4VeRnBeonSuyVxk7xDbOwNpJsokgv
 vuqx+/w/xsYq7DBvdlAeRGTT6loLw3EicqLUVI1eOc7F9wVc8KksrAaUpwFs1jEPvrgwi313dh
 CTWflUdZz+3hWD2SMg1KJ0zF7S/mtmMm+rLDvf61YnqWFAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oYU_7dzEqJu0rz6lv1-nKUAhHf7V139u
X-Proofpoint-ORIG-GUID: oYU_7dzEqJu0rz6lv1-nKUAhHf7V139u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030120

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/acpi_tad.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/platform_profile.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/acpi/acpi_tad.c         | 1 +
 drivers/acpi/platform_profile.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 1d670dbe4d1d..b831cb8e53dc 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 
+MODULE_DESCRIPTION("ACPI Time and Alarm (TAD) Device Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Rafael J. Wysocki");
 
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4a9704730224..d2f7fd7743a1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -217,4 +217,5 @@ int platform_profile_remove(void)
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-drivers-acpi-misc-8c26065d84f1


