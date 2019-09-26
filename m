Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE8BF670
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2019 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfIZQJD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Sep 2019 12:09:03 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:4024 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfIZQJD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Sep 2019 12:09:03 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QFsk4p004487;
        Thu, 26 Sep 2019 12:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=ylV98xz8orQHQHuDVexiqAGE/sArJSvLKvsDJ71Gqo4=;
 b=jovORRrNQ9vTA8lglRpykqmAXOMbogf3uDmwrYOEuDmut1qFmAzRMCNg6ELZrwvLxeeI
 GJhg1bETTaPApqal8IqaSjkASfW6Wx405lCN3Rn0opXXHbc73mOsENhbWEfi+QKFoP6K
 V61SZfeT7OORDv5CKvpuj6Bgwyh4yB5UTHwianqv1Fl7aX+jvIV+UiGOm7i4wGFvPu5O
 yBjBvIPuZge5eHJRQPjZNwlA3aAGCUEnUIyIEvjeRHQT65YfsOIPNZyi3Thadv557KmW
 5Auf+8yXMhhge30+8m7moyTu3+fPM4S2Qgs8lGiPWSFVYvD+nlH36jdS+7i8TsPzkkfE Ng== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2v5ex4sx2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 12:09:02 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QFv0bU071248;
        Thu, 26 Sep 2019 12:09:01 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2v90e289e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 12:09:01 -0400
X-LoopCount0: from 10.173.37.27
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="465330244"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        'Paul Menzel ' <pmenzel@molgen.mpg.de>
Subject: [PATCH] ACPI: PM: Revert "ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360"
Date:   Thu, 26 Sep 2019 11:08:57 -0500
Message-Id: <1569514137-2307-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_07:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909260142
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts part of
commit 71630b7a832f ("ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360")
to remove the S0ix blacklist for the XPS 9360.

The problems with this system occurred in one possible NVME SSD when
putting system into s0ix.  As the NVME sleep behavior has been adjusted
in d916b1be this is expected to be now resolved.

Cc: 'Paul Menzel <pmenzel@molgen.mpg.de>'
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196907
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
The particular failing configuration was reported by only ever failed for Paul Menzel, so hopefully
he can test on his failing system.

 drivers/acpi/sleep.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9fa77d7..2af937a 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -362,19 +362,6 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		},
 	},
 	/*
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=196907
-	 * Some Dell XPS13 9360 cannot do suspend-to-idle using the Low Power
-	 * S0 Idle firmware interface.
-	 */
-	{
-	.callback = init_default_s3,
-	.ident = "Dell XPS13 9360",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
-		},
-	},
-	/*
 	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
 	 * the Low Power S0 Idle firmware interface (see
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057).
-- 
2.7.4

