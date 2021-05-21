Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44138D1AF
	for <lists+linux-acpi@lfdr.de>; Sat, 22 May 2021 00:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEUWwK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 18:52:10 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:43484 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhEUWwJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 May 2021 18:52:09 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LMmsEl007998
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 22:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=resent-from :
 resent-date : resent-message-id : resent-to : from : to : cc : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=pps0720; bh=q8QhXGTfWElVKM98+dODFF6vgoKg7xIj/f6m9TTGGAg=;
 b=frPs4Y+dbYFLrUGaiJiOjFAuwMXp3ts8jRzIBxnaEeTw7udOJ0kbSOU1TYudsrG4farj
 vw03aHRko903vx/Ddvx4i4b1vLUMapRsfMFHbptOx61Sq5+mj0QxdSPztt8BAUfe8qTZ
 L2L15Tioy4rp9vtvx02ItW53nZCNU6OpupTW+ZLJOFlh0x67IofJ6JAd4mTTCxvWTl78
 UHYZrj7f4075KfSeX9DWX1caFUZqKifwyFZz2UonRP7GgUvvPKE1HgPIvXuDxzxX3BkU
 XikRBps5Exp82rJOG5D1qYb8NWNPjQomp6WMxR2dCLW86aBUKl+jO9GwTcxerc8sDeKn nw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 38pedvbf0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 22:50:45 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 8039554
        for <linux-acpi@vger.kernel.org>; Fri, 21 May 2021 22:50:44 +0000 (UTC)
Received: from hpe.com (unknown [16.99.166.184])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 33B444C
        for <linux-acpi@vger.kernel.org.>; Fri, 21 May 2021 22:50:44 +0000 (UTC)
Received: from localhost [::1]
        by new-ben with IMAP (fetchmail-6.4.19)
        for <rja@localhost> (single-drop); Fri, 21 May 2021 17:20:03 -0500 (CDT)
Received: from AT5PR8401MB1012.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:742b::7) by DF4PR8401MB0507.NAMPRD84.PROD.OUTLOOK.COM with
 HTTPS; Fri, 21 May 2021 22:19:46 +0000
Received: from BN6PR17CA0022.namprd17.prod.outlook.com (2603:10b6:404:65::32)
 by AT5PR8401MB1012.NAMPRD84.PROD.OUTLOOK.COM (2a01:111:e400:742b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 21 May
 2021 22:19:46 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::8f) by BN6PR17CA0022.outlook.office365.com
 (2603:10b6:404:65::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 22:19:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 hpe.com discourages use of 15.211.195.18 as permitted sender)
Received: from G9W8455.americas.hpqcorp.net (15.211.195.18) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 22:19:45 +0000
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 21 May 2021 22:19:34 +0000
Received: from g9t2301.houston.hpecorp.net (16.220.97.129) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 21 May 2021 22:19:34 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 6B9894A;
        Fri, 21 May 2021 22:19:34 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 17E9E302F481D; Fri, 21 May 2021 17:19:34 -0500 (CDT)
From:   Kyle Meyer <kyle.meyer@hpe.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-acpi@vegr.kernel.org>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
Date:   Fri, 21 May 2021 17:19:06 -0500
Message-ID: <20210521221906.199436-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-OrganizationHeadersPreserved: G9W8455.americas.hpqcorp.net
X-MS-Exchange-Organization-ExpirationStartTime: 21 May 2021 22:19:45.9821
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: c2c59630-7983-4fca-f50a-08d91ca68a48
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G2W6310.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-Office365-Filtering-Correlation-Id: c2c59630-7983-4fca-f50a-08d91ca68a48
X-MS-TrafficTypeDiagnostic: AT5PR8401MB1012:
X-MS-Oob-TLC-OOBClassifiers: OLM:60;
X-MS-Exchange-Organization-SCL: -1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:15.211.195.18;CTRY:US;LANG:en;SCL:-1;SRV:;IPV:NLI;SFV:SKI;H:G9W8455.americas.hpqcorp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:;DIR:INB;
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 22:19:45.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c59630-7983-4fca-f50a-08d91ca68a48
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.211.195.18];Helo=[G9W8455.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-AuthSource: G2W6310.americas.hpqcorp.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1012
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.9729975
X-MS-Exchange-Processed-By-BccFoldering: 15.20.4129.035
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(750129)(520002050)(706158)(944506458)(944626604);
X-Microsoft-Antispam-Message-Info: WVXVTKN6YEfiLn2mzPVLgV5/hCmzRj2uWYKaO2/FfcR9rXGz5GG6KQldr0rZmpsCVX/AKfzMzcoEAdOTR+c6Cv7UIDJpd8xDDOEZtr/BvYIY6CCsrqFEjROn5KeX7N9dl8/ixnDF45/JtVjiBpaJ6BftIC/OzKg9+ED6tTYnYBtqow4jcBP8e6FSL4n9a9M6768gMp/FRJN/mXV+h+o2Xoo3u3mkM61T5vaiHNyLufogzNJzTIk0zc5U430m69mxUMfh0inYX7v6MyFBvfjIAQ+S2/8vTzs4NCHF/99Z47mSWzOA0DMEMyL7qTl4PygsVGUJ7i3c6VKFumSpG2fp0/bV4g7t5aq7uPhSJY8q8DtpfylfedqUH9I3TliWf+5KYzykTb3xPRxYZBImjbrFVGTcsKtMB0mF5+mUpG4NJ4HcPAmptIyLDo/ab1tqW5QkweB0B0RjblBH5PAYnExpqSygNX0RuumAoLe2+2q+771iVEmitjFhw7ngIatDiTlcQTjLZxe2V7CEd9a/2zLZ0Fhn+qi1cvVSi8JFcGDebf8=
MIME-Version: 1.0
X-Proofpoint-GUID: 5VkBMTDp3qGjuLcooP2hXFZqMQOwEmgj
X-Proofpoint-ORIG-GUID: 5VkBMTDp3qGjuLcooP2hXFZqMQOwEmgj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_11:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210127
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Revert part of commit 75c0758137c7a
("acpi-cpufreq: Fail initialization if driver cannot be registered").

acpi-cpufreq is mutually exclusive with intel_pstate, however,
acpi-cpufreq is loaded multiple times during startup while intel_pstate is
enabled. On systems using systemd the kernel triggers one uevent for each
device as a result of systemd-udev-trigger.service. The service exists to
retrigger all devices as uevents sent by the kernel before systemd-udevd
is running are missed. The delay caused by systemd-udevd repeatedly loading
the driver, getting a fail return, and unloading the driver twice per
logical CPU has a significant impact on the startup time, and can cause
some devices to be unavailable after reaching the root login prompt.

Load the driver once but skip initialization if a cpufreq driver exists by
changing the return value of cpufreq_get_current_driver() from -EEXIST to
0.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7e7450453714..e79a945369d1 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
 
 	/* don't keep reloading if cpufreq_driver exists */
 	if (cpufreq_get_current_driver())
-		return -EEXIST;
+		return 0;
 
 	pr_debug("%s\n", __func__);
 
-- 
2.26.2
