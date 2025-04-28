Return-Path: <linux-acpi+bounces-13332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931BA9ED97
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFC17B92E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039B226157A;
	Mon, 28 Apr 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7nrpeQe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92B261398;
	Mon, 28 Apr 2025 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834855; cv=none; b=o1/dyIRrr5WlbukyRV2ASIXuyQiCmWQxzFPu7lB59RVJNrZJLtlgCkr1RJr17XlWn19QTaKt/0LH0x9l3/MkNJkAJnAKJb3waqYbKyYCqfLqFn5nGIPdbaUdcCyfurLEAsMc/byGCzSLq8yJseqoezbDWUpAzMLjBpvKxkX1DIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834855; c=relaxed/simple;
	bh=jXwUVvExxc5z7Z8jSiT7683GcJvsn0SjsTrr/ZaHQ7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GLXnwSgCyuF/75M8rxOOlBWvyyzzDxXXG+mr1Whjg3eB8VR5qZHU5n0JbNcsCj0ClqCRIS46WIae69HkSKHZLLv6JcatlXe4qJe1sGbirdeNeiXcsGLssOtK2cPYNkfepMpkE+TBakBqkzkD/2e8xlPSQCYe9TqH6CeUWoTRd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M7nrpeQe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8fBf7010204;
	Mon, 28 Apr 2025 10:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eWaIen6eo2SXPif9Yt6V2b
	lg9we19vELALYOzhSIwtc=; b=M7nrpeQeE08a79PiuiT/onuZBlKondtEc4KlAX
	y2XiCzDCeYv3VtRL+e6xNaRWjsAcI69yogdvdVJ0CpBGJfZ8hbBBQcXU0ciLrltW
	mU18z/0hRRQh3q7u5pn8zNrkv3ufYPQiQdd6A37BKc1W7ccascZ13kiTqAFLSaT6
	lXQZVK22qhR5wVWrTKPfgRZrKMJ+P++4/Zux26LOhoa/aRAjOiJH3LOvV0ChE0uU
	meZFgXnQpfewT7fByQq8wiL9KXOXCFqSmkvKW/WlwKm5yAzWUXqPm3HzOt3R49F+
	j75blA1+uIEVLhr7AMc6zLH2siVQIY0He0fUi8ZwxeQdKEDA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468pevfu88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 10:07:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53SA755w003634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 10:07:05 GMT
Received: from hyiwei-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 28 Apr 2025 03:06:59 -0700
From: Huang Yiwei <quic_hyiwei@quicinc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>
CC: Huang Yiwei <quic_hyiwei@quicinc.com>, <xueshuai@linux.alibaba.com>,
        <quic_aiquny@quicinc.com>, <quic_satyap@quicinc.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        <kernel@oss.qualcomm.com>
Subject: [PATCH] firmware: SDEI: Allow sdei initialization without ACPI_APEI_GHES
Date: Mon, 28 Apr 2025 17:56:23 +0800
Message-ID: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J4vdveoOh9iAt7PvfjFwRV7BSYaA87bJ
X-Authority-Analysis: v=2.4 cv=aeBhnQot c=1 sm=1 tr=0 ts=680f534a cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8 a=COk6AnOGAAAA:8
 a=ODOW-txAOSA8bPpV2xoA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: J4vdveoOh9iAt7PvfjFwRV7BSYaA87bJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA4MyBTYWx0ZWRfX1WcCnLhv2G4G qk+Is7tNLX0h15/gqmvE97xI7941ISJfzPn9Y0giX7IRIHDRlhz8M2f2A7myxmdd0ZnEUYpjEEn iDcOMigECOaf2pKNQsWPgM75w5bgACdFm0Gny75mpgvvmcZft2lVas5HOnmfkpbbytDObirsLeE
 iZ55j8U3aMpRIUjcKM8DbBr8WOoVH8D3hz+GieLZErHRfztbRhRo7sciCX46KHtPOhJgzeFkkaP 0K8D1YFWv03WUP7A/yH2HTDvLBjeBH3X5OOxgxCzRhGsWT6C2/RuG8pjSmKdDj2aIqxiUjv2qST WdAXeX/HIFchjGd3xuCJsb6FdcaKzpkZ/y8Q2TZIpLIZXpNifstrivr3NZiO8VSdYwJ+leC0/+f
 5xfjQUNaKB3QS0KtYR03DiqK6BR/9QiTh+/mrPjdOhInnI/00NpAk+byp4LqjKhPijoLA3s9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=537 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280083

SDEI usually initialize with the ACPI table, but on platforms where
ACPI is not used, the SDEI feature can still be used to handle
specific firmware calls or other customized purposes. Therefore, it
is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.

In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
in acpi_init()"), to make APEI ready earlier, sdei_init was moved
into acpi_ghes_init instead of being a standalone initcall, adding
ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
flexibility and usability of SDEI.

This patch corrects the dependency in Kconfig and allows the
initialization of SDEI without ACPI_APEI_GHES enabled.

Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
---
Link: https://lore.kernel.org/all/20230906130900.12218-1-schspa@gmail.com/

Current patch has been verified in the following scenarios:
  - ACPI_APEI_GHES enabled and ARM_SDE_INTERFACE enabled
  - ACPI_APEI_GHES disabled and ARM_SDE_INTERFACE enabled
  - ACPI_APEI_GHES disabled and ARM_SDE_INTERFACE disabled
  - SDEI works well with DT node and compatiable firmware when
    ACPI_APEI_GHES disabled

The scenario where CONFIG_ACPI enabled but not used has not been
considered in this patch due to the absence of such platform.

 drivers/acpi/apei/Kconfig   | 1 +
 drivers/firmware/Kconfig    | 1 -
 drivers/firmware/arm_sdei.c | 9 +++++++--
 include/linux/arm_sdei.h    | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

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
index 3e8051fe8296..ddb10389b340 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1062,14 +1062,14 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-void __init sdei_init(void)
+int __init sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
 
 	ret = platform_driver_register(&sdei_driver);
 	if (ret || !sdei_present_acpi())
-		return;
+		return ret;
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
 					       0, NULL, 0);
@@ -1079,7 +1079,12 @@ void __init sdei_init(void)
 		pr_info("Failed to register ACPI:SDEI platform device %d\n",
 			ret);
 	}
+
+	return ret;
 }
+#ifndef CONFIG_ACPI_APEI_GHES
+subsys_initcall_sync(sdei_init);
+#endif
 
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 255701e1251b..1a54f0eebb0d 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,12 +46,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
-void __init sdei_init(void);
+int __init sdei_init(void);
 void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
-static inline void sdei_init(void) { }
+static inline int sdei_init(void) { return 0; }
 static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
-- 
2.25.1


