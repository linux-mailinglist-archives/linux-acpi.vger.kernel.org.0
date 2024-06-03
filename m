Return-Path: <linux-acpi+bounces-6141-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA88D83F6
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 15:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE311C21D19
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D512D76D;
	Mon,  3 Jun 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FBO4yeRI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21712D775;
	Mon,  3 Jun 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421429; cv=none; b=Y/beNS7kGKbxdwwDOnLQNzz7ppKg8IkRL3UVEXus2eWD7vDY8SxTDVYn8kg+d9pOIJGjCmx/Z0TYSw97tm/GiPPd256a7SsPq6qSZ03zOygwh72kRcmNSskQEDTeyVFnnoZf3BLMD2vZBA1eQ9SCC46oB4ssBcxxwPQAzYfPN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421429; c=relaxed/simple;
	bh=siHlBxO9wikWFyrTMkjcWyiEolJXNVR3qUS+thQ+tXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Z7jQu0XPpd/qKXzIiIcWB2Bz9aJSDjD0ERZq9RwhSLMSP0lhPKeKTVsKdNwUGVmn4cBO5ojfVw27k6eGejL097SDVzSfMXm8tmcf4M1d+PWCLTa8WpoFwbb0I+rdaQLuAbfriH/Xinl6uW3Dq/VLMneJOZYdXJi1KvHPdXQq3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FBO4yeRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BS7DP009764;
	Mon, 3 Jun 2024 13:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OXLYl3qnVo2Nxrdc054HxK
	lC5QU9ymtPYz5OD7x+IJw=; b=FBO4yeRIYouwqmED7f3XTl2K61oG7TWh+4PudG
	gpjHdUhZkfjGJLTMCn+m5jnwB1lGAQCcG/86JQINAQtyTRiOzvrBO7L2qQx9fDWb
	bxt6IhIDyUzbsPKxHq0It4vjUlJG3WU+Pac/jZpOv9PtuKAfe0s3C1sQEDud6JWx
	k1ml1ce8SSYJaxwhbio1R3aWzNuQkNvvVw5sQwBvdkQA2ioIDB2iTQz2eIgeuuJa
	qFL6tGECZRHed4tqJsz+DaOmUC0H++QjXxUH3rmgprQg8A/ZUNRGY/lKNi6KUvhn
	orPadkazbAqoYsNpm551YPDVQ7uvlpse62m5LQ+lZbhAKz9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw3r483t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 13:30:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453DULhW025511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 13:30:21 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 06:30:21 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 06:30:20 -0700
Subject: [PATCH] ACPI: NFIT: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-drivers-acpi-nfit-v1-1-11a5614a8dbe@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAGvFXWYC/x3MQQrCQAxA0auUrA2kUxH1KuIiM5PagB1L0pZC6
 d0dXb7F/zu4mIrDvdnBZFXXT6loTw2kgctLUHM1BApnulCHY8Zsuoo5cpoUS68zCnUhcqbYXm9
 Q08mk1+2/fTyrI7tgNC5p+M3eWpYNR/ZZDI7jC9V7ZOeFAAAA
To: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>
CC: <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Y7V3rKMVbrXmgvnvhVJKm6m2dUQiV_zl
X-Proofpoint-GUID: Y7V3rKMVbrXmgvnvhVJKm6m2dUQiV_zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030111

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/nfit/nfit.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/acpi/nfit/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index d4595d1985b1..e8520fb8af4f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3531,5 +3531,6 @@ static __exit void nfit_exit(void)
 
 module_init(nfit_init);
 module_exit(nfit_exit);
+MODULE_DESCRIPTION("ACPI NVDIMM Firmware Interface Table (NFIT) module");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-drivers-acpi-nfit-e032bad0b189


