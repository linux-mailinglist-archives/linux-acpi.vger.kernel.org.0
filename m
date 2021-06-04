Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B51039BE12
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFDRIy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 13:08:54 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:19242 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229913AbhFDRIy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2021 13:08:54 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154H3Jrg011940;
        Fri, 4 Jun 2021 17:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=mnNbrv4LQindqcnO6qrDsMhC8Xmo4j6W8U9Irnc7OVc=;
 b=NuRh9c2fOv8qOHotoPQUaS01gCDZyhuoOPRAWtSeKE4UgQV+zoqMkGh3Bp27Co3LAHA9
 eJo+v2PamOicjZVgc4wZ2+Rttc3SCJVnqZVmS5MTKpD9Jncv2tiA6vwBaAqD1Gr1sEW1
 qPKxZiJakD4SNAQx7ZjU/VnmZgngtI8EGZxWcvHbXfC2f/zMuVsLqeIGOYteA8M9h6I0
 4AEmQUuEdBzOSHzdZ/Seys/Sz6L0wrysD3cTPS6+QPfS0gNRacNKPkQ/7CyX1/fMteIy
 qWduEaeFV5ucPb8AH7rXfH9a+CvJJGHfxE+6O4E9D9hM3fPGvCuJvXR6S8pidamcXG/J 9A== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 38y7kx7f6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 17:07:01 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 8EE025C;
        Fri,  4 Jun 2021 17:07:00 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 57E9D45;
        Fri,  4 Jun 2021 17:07:00 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 0507F302F481D; Fri,  4 Jun 2021 12:07:00 -0500 (CDT)
From:   kyle.meyer@hpe.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kyle Meyer <kyle.meyer@hpe.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] acpi-cpufreq: Skip cleanup if initialization didn't occur
Date:   Fri,  4 Jun 2021 12:05:00 -0500
Message-Id: <20210604170500.46875-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UbYehIXeRah83Elgj5o-H-uadL58mjfJ
X-Proofpoint-ORIG-GUID: UbYehIXeRah83Elgj5o-H-uadL58mjfJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_11:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040123
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Kyle Meyer <kyle.meyer@hpe.com>

acpi-cpufreq is loaded without performing initialization when a cpufreq
driver exists.

If initialization didn't occur then skip cleanup in acpi_cpufreq_exit().
This prevents unnecessary freeing and unregistering when the module is
unloaded.

Reported-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7e7450453714..8d425f14c267 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1042,8 +1042,19 @@ static int __init acpi_cpufreq_init(void)
 
 static void __exit acpi_cpufreq_exit(void)
 {
+	const char *current_driver;
+
 	pr_debug("%s\n", __func__);
 
+	/*
+	 * If another cpufreq_driver was loaded, preventing acpi-cpufreq from
+	 * registering, there's no need to unregister it.
+	 */
+	current_driver = cpufreq_get_current_driver();
+	if (!current_driver ||
+	    strncmp(current_driver, acpi_cpufreq_driver.name, strlen(acpi_cpufreq_driver.name)))
+		return;
+
 	acpi_cpufreq_boost_exit();
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
-- 
2.25.1

