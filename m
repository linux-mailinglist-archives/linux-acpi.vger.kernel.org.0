Return-Path: <linux-acpi+bounces-13522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E9AAD4B7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689661C069D5
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE01DD0D4;
	Wed,  7 May 2025 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvO7oVJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57D19F120;
	Wed,  7 May 2025 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593948; cv=none; b=B0E8nTc+Hphb9aSeCgcGDcR/SCYSA7yem0cSs+hwrlb1CnSTfgy7bfN2HwoSBVAdEZTFWz42Zw2mAIZqnyGLBUwWyP+PAm1bPbSNw7zuw3lPsYYbss1dEF0aB9Gbve8hVNGee1jIHGYwKh8IXdXoTzzNhoDYB/JohqlIdBTvYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593948; c=relaxed/simple;
	bh=bJOPeGGSh2Hw2WYlIOpZFbgaiLdVuE2W8tajBVDaQy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZHOLwXZKElwxC7wMx39vTRF9JRMDPkZkMjojqmLSIXwvgaBpXqwOa4e+OWLaTJyeM+Pxl7FiFOBwP/FNLaD4Ri/4Cu0YIQGkyjp9+a6T/2FIqYsEn8kByxBql/lA0dj7dmNi7cwkYbO2vFQSBO8aYQp3smmYg+SkPYd6TQmfnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kvO7oVJ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H92D018448;
	Wed, 7 May 2025 04:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2Om2K7NlYvLRzOhsIO8jYO
	3DWzMyXxpUINZ4XmAMLyc=; b=kvO7oVJ3njDlZ1TxIs0M2Z5Wyxou6ZXBhhpzgo
	U/7aUVWZrjx51MP+f95H6ZrFOkfJQ2aZonLfFnfwfDBHVkAdF0XeIS04h3u1f0qx
	FG/daGRFFGUVr1uldnoclsOzRv7z9nD4wcY7rXn4wl1oEUcZQBo96bXCsOfZOV0P
	U18v2EYnWvClmDLNF3e3pOTcPb2+sQLMc7MUv+mkDOPhT6a9pqwQikJ0dRDoe3QM
	aQDZ/ADfCwWxWbYIflzedDNANh89j8gOFUpYfs4tgalXnJQdW/lPUrYAwxu2ySmg
	t71uKEJNgKtOicEmnQtuRp/60Ha0rO3IeO2nGYHIjn0fvIxQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tbcem0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 04:58:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5474wQcL024060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 04:58:26 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 21:58:18 -0700
From: Huang Yiwei <quic_hyiwei@quicinc.com>
To: <will@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
        <james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: Huang Yiwei <quic_hyiwei@quicinc.com>, <xueshuai@linux.alibaba.com>,
        <quic_aiquny@quicinc.com>, <quic_satyap@quicinc.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        <kernel@oss.qualcomm.com>
Subject: [PATCH v2] firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES
Date: Wed, 7 May 2025 12:57:57 +0800
Message-ID: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GLsHI0RIUWKu5gdmYMBz8SANGRwsj428
X-Proofpoint-GUID: GLsHI0RIUWKu5gdmYMBz8SANGRwsj428
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=681ae873 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=SRrdq9N9AAAA:8 a=COk6AnOGAAAA:8
 a=fApEDmPMNfUvMO555Z0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA0NCBTYWx0ZWRfX6Rn8YeXmmXlh
 8GpKTqm0o0g3oJnIqsBw6tDxkPEc5S/AhFbfATzlTfFODfY9J+SOQsbHwKp2wcPhVwM1Ef/76mw
 sJ3IWTHtCxzADK8ZOvz3XOpZQc64M4AAkEmSvcSf3DR0rCIA4pwAP9A5A7un16hIiKhqSrCK7zN
 vJ+sk43RiOfAfB6MzfMNYBy+IC5fGgfqzky50CUkkzQ5YBRkGyF+tZUrerFnAKYgEyBROwYefmM
 EzzWBwmEEvhdKKsi/igvIw7suB+WNh0Hops4sbqEBLKvnD/Dp4cTF6Pk/2VEWgaQfcpGwvuiGWx
 fbCKcXAFgH+82iA/xnLqa8xa+Skr87yIAReETKbeJRN4xoR88ctHp/yLEa8XG9MvlqEp4dJMjzB
 WyrihCYGNNEL8MdyZ+JYsEvU89n0HJADbBH1Yk9JREVL2h1CpnASDc6qGBHvweO9W+PPn+pD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_01,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=540 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070044

SDEI usually initialize with the ACPI table, but on platforms where
ACPI is not used, the SDEI feature can still be used to handle
specific firmware calls or other customized purposes. Therefore, it
is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.

In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
in acpi_init()"), to make APEI ready earlier, sdei_init was moved
into acpi_ghes_init instead of being a standalone initcall, adding
ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
flexibility and usability of SDEI.

This patch corrects the dependency in Kconfig and splits sdei_init()
into two separate functions: sdei_init() and acpi_sdei_init().
sdei_init() will be called by arch_initcall and will only initialize
the platform driver, while acpi_sdei_init() will initialize the
device from acpi_ghes_init() when ACPI is ready. This allows the
initialization of SDEI without ACPI_APEI_GHES enabled.

Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
 drivers/acpi/apei/Kconfig   |  1 +
 drivers/acpi/apei/ghes.c    |  2 +-
 drivers/firmware/Kconfig    |  1 -
 drivers/firmware/arm_sdei.c | 11 ++++++++---
 include/linux/arm_sdei.h    |  4 ++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..070c07d68dfb 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -23,6 +23,7 @@ config ACPI_APEI_GHES
 	select ACPI_HED
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
+	select ARM_SDE_INTERFACE if ARM64
 	help
 	  Generic Hardware Error Source provides a way to report
 	  platform hardware errors (such as that from chipset). It
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 289e365f84b2..0f3c663c1b0a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1715,7 +1715,7 @@ void __init acpi_ghes_init(void)
 {
 	int rc;
 
-	sdei_init();
+	acpi_sdei_init();
 
 	if (acpi_disabled)
 		return;
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index aadc395ee168..7df19d82aa68 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -31,7 +31,6 @@ config ARM_SCPI_PROTOCOL
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
-	depends on ACPI_APEI_GHES
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 3e8051fe8296..71e2a9a89f6a 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1062,13 +1062,12 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-void __init sdei_init(void)
+void __init acpi_sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
 
-	ret = platform_driver_register(&sdei_driver);
-	if (ret || !sdei_present_acpi())
+	if (!sdei_present_acpi())
 		return;
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
@@ -1081,6 +1080,12 @@ void __init sdei_init(void)
 	}
 }
 
+static int __init sdei_init(void)
+{
+	return platform_driver_register(&sdei_driver);
+}
+arch_initcall(sdei_init);
+
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 255701e1251b..f652a5028b59 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,12 +46,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
-void __init sdei_init(void);
+void __init acpi_sdei_init(void);
 void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
-static inline void sdei_init(void) { }
+static inline void acpi_sdei_init(void) { }
 static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
-- 
2.25.1


