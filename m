Return-Path: <linux-acpi+bounces-9997-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080E9E64EA
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CF8161748
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07577194C7A;
	Fri,  6 Dec 2024 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h6xEdGw3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBEF193438;
	Fri,  6 Dec 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455555; cv=fail; b=lITz6vqEPZV+xZNAfHQyV8+loHF6fvjfHWLUQf66z2e+Gll4hniti4K594GUlaBEkl0Uypzrs4JLbUUmmiQ+Gl/i1GBSzdmLQNyshp+u3QXE8J8mB0yE8NRHAH3dq3zHhy2SSb17GiQw/MTl0KH8IcozU5x8d4DGM9SCyHjnKbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455555; c=relaxed/simple;
	bh=VVG53fkGNnXY44nCUBwfGzttiX1QGh+kxAq81MkR3SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAKAwn2TZP1G5uApROyc/9jZMiybY/YMYQuTCU+PlMdyCbSgA0UQGJLzaHX2NSU8l8qNF/PqQhzLweRhC0kWmJDdhND7UPKcB7fl1/BiL6zxI4gBzI8wXQIFEvQNVspKdwbvE5S6UbBd4htdvzggV4679uANVnHvOjZjnhkiCMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h6xEdGw3; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipLOJjMpLarlk6hWhy9wWBQA4WXr+UUfpfTbfaqjykwciiIayGGOIdn/Xwkyd55NM4cJ3juEIEJeurwJXN4gBjIlgBv9O6ehM7inu1Iji+8mEQagT9DhcavCcZdjvBxW+Nb41vjCC20wy4HJhPrZf3j+EB0cnOpvRrms3IZCsLjzT3/C04Wez6U5vSMKscB9Ziyp3C1/xZ0Jpcsk6hJVyKBgqcxBtORK8t5Y500L28pQRbK8jf37wBTTfPvq68wvdZW3RXlP6mVelUk3xOclOZseQVxASFVH9LFuC5dhmX3Eq0a1PFYU5hseo9gRGde6kOHvyC1HVh92NGh0vQspDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBkt/mhA55cPaDFTq1KS/KVyCxO6SdjI4cviXYntBT0=;
 b=Tiwt1aWsEmgbuyWgPluOgaFdTAsJKaXfyVu+DMN8s8yaiD6C1ffTlIcoG+pLaUy1LGb7jmo2SmD2UJyjETUIazU53LKzbtCFltNMIDsPDcqhiWzceJS3QW0B6BQ1Sb5P3SyJfHNMR/EWHyLHtVIsEgGEnlXS1oUzkSxufMWu6LdomI7Xfl6WZQUXg9vMR2S5aBwccQ3wSJMp+4/JgDuSQKjI+kYK9AZGuWjKC9A9CQBSZWR/paairdF39Vyv0pZf4Lf7XCdvupH0gluQipFHlmRxXuDqd+GIphhPi6mS1mMTA3J7rlYiYGn8EOlF43MSU1eyZQ1LIBHloTGV3jiYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBkt/mhA55cPaDFTq1KS/KVyCxO6SdjI4cviXYntBT0=;
 b=h6xEdGw3IgvnZTs0JhsqsLkoiuxNLxFGidNR8jpnfLkZm8rW7vh7CkTm3hlXeqmABTdEJN2i17CDC90bj/I9Si5zjjaDT9m4db5PfTPTHS7IZ+JhzecjckaHdH3p9zRiTowfL9u2srq0da6iPtB09UvXDz1g8rxPeAX5+p7rrh8=
Received: from MW4PR04CA0053.namprd04.prod.outlook.com (2603:10b6:303:6a::28)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 03:25:50 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::5e) by MW4PR04CA0053.outlook.office365.com
 (2603:10b6:303:6a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:50 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:46 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v10 12/22] ACPI: platform_profile: Add choices attribute for class interface
Date: Thu, 5 Dec 2024 21:19:08 -0600
Message-ID: <20241206031918.1537-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 81006754-bd3d-45f3-b5fc-08dd15a5aed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRIV0JXUWJuWW05UU9GZzR6ejh0eHMrbHp1RkdpRDdXU20rMnJHVFNkVWht?=
 =?utf-8?B?SzRUVlhaL2VNbXhtTEIrNXlYR0pvaEYveXNhZ0RpZ3l5VTJMTG8zKzRteWZw?=
 =?utf-8?B?OExoUS9CcUlGN0lUZWFlWWZZNzFYTjl1YjlHUDNaRjFQOVpxSDdWK3dCYnZo?=
 =?utf-8?B?cjJJR0xOR3hTMGhOV0JJd0xMV2xZWENDMnJGanpUKytFTkJ4L041RVQrd1Fi?=
 =?utf-8?B?KzVRMVZtazUrOFVSaHM1OWJ6dnlKd1pWa2YxbUlHcVNramVpbVhRNXlENjFP?=
 =?utf-8?B?anpELzdFRXhGbHFJbTFHQzgzOU5FU3RJbWswNG0yaDdxUGRtYzVuV2NUQkhI?=
 =?utf-8?B?NTZ5YlZMdzBxWERpdGJhS0NHdWNqM29FUEZLaGpEVGxlQTRrcUhIc2FFcCsz?=
 =?utf-8?B?UldDVTFiV0tub2luS1AzQ1ZEMmUxR2dWdXZJRjYrWjlvS2RXeUJkUzdoc1E3?=
 =?utf-8?B?RFhmdnBoUEJXVlkvbzZzaTdLTllWaDcyWG5Ea1c3T3JCNEl4Z3BiazRKTlpq?=
 =?utf-8?B?MHNYaCswTXV2K2JBK2JXa0NhZnZ4VDZjQUNyVkdFRndkcU53enp5SlpDQkM4?=
 =?utf-8?B?UjhFSlpuamNEM0hZalJ3VGtUU0t2djg4c1NxNjlKZkU5T2ViT3E0ZzFsNldR?=
 =?utf-8?B?NGxOVXF0Q0RTK0F2SUZZYkdPWUNMekVycDlrZWlUR1hhQWJCb2s2SEhRdFpG?=
 =?utf-8?B?d05zRitJcWJkQXp1REhHN0ptZ3N0M3o3Y2ZLTWpBNCtjVyszVUMvS3lFVWNY?=
 =?utf-8?B?QTc0NDkrVmtFWXgrQXo5ZU5kMTRrdzVxWU9WM0JDczFldmhPVTVRRXJncmJL?=
 =?utf-8?B?cDhDSlp5WWhLQ1BjYWw1dk45R0ZPQzMvSWpwSUs4YUpYUWI5WXNWN09ta3hB?=
 =?utf-8?B?T0RubDdlcDhzamRsMlczT1pRSStmMUlMQ3ZmcG1SazRaWmtwQTdadi9wODQw?=
 =?utf-8?B?dWVXNzluazBlS2t1K1JscG1TdWNhMUozaEUya2xPZlFPb3A1OG5rZEdhY0Ri?=
 =?utf-8?B?ck9QMUVybFROelFzVnBKTnJaM0xXMForRXNhRmFRMjFYZDhQdkdmRTJaYmM0?=
 =?utf-8?B?dDE1MERrRFZadCt1YjJOc09WdmxoL2YvS1AwbUg1bU8zMmdnOTVFc2xpSGhU?=
 =?utf-8?B?Nkx3dzFuYSsyY2RKdGl2OXNtK1FkRE1iUzR6N0pxTnJPL2ExTTBvUGtKTUxw?=
 =?utf-8?B?MndCdkxydFFLYVkxeXhRVWRWYXNPT2Jtd2lvSG5FQVd1cXdtQUM4WHVsV2RN?=
 =?utf-8?B?bllqVlI3RlJxRWpNbzhRNWtjVFVMeTVXU3ZqK21SRXJNVVM2ZFJNclRGUXZ6?=
 =?utf-8?B?OExsRVIxejFGNWJSZFZnNWV3RDlESzdFOWZ6YmJRNi9VUXdMNEhPNm9BalJh?=
 =?utf-8?B?Ung5YXNmY0pnL28yTGlWODEwa0hsakNLTGdTd0pBNzZacUc0QmRCc3Y3Tkdp?=
 =?utf-8?B?YzRUbGZaS1BTY2MvT1NhdzB3dDVCWU43WGNLUGJ6N1RhNHNnVkhzWWpxMUsv?=
 =?utf-8?B?NFgzU211OUdyYmQySmQ0eW1DaWJuMmxlcFZkT2o2UDkwS00vaFRndG82WDVy?=
 =?utf-8?B?aDFDMmlqUVBSbWZ3cUdzK0p6VTVOS0VpYlI1dHNCaXZuZU1jam0vR1BDMyt5?=
 =?utf-8?B?R0hGQ0cxbjBBeFRidHNwL2ZQYUFWUXBZUjhhWm03bURFM2N3cy9Sc2Q1aGZZ?=
 =?utf-8?B?L0JtNGVoUFEwd1VlaGJYQ2pLTW1OeGoxYjM4aW5RdGpFQWx3Sm84SjhsSEZm?=
 =?utf-8?B?cDBnUXQvZHcyb2RrMUFVZHVyZUZMaE9pbjh2cnRuSWhJN1ZMbFFleDRDeWZJ?=
 =?utf-8?B?emozaHdVSnRqcCt0WVNvclZhWTJacysyYUFieERpZEIrZ1FBN3RseXN0NVps?=
 =?utf-8?B?eWt6dk8vZU9YQlcybm5oWmt3RDhEZHpvVnhCVUozUUlyWGZLdGVOZnJkWnB3?=
 =?utf-8?Q?N4SwCIhy1ScQNycV0aGPIGcDx4XfWYa0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:50.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81006754-bd3d-45f3-b5fc-08dd15a5aed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

The `choices` file will show all possible choices that a given platform
profile handler can support.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 49a8bd6e97ece..885f41bca6c25 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,28 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -41,8 +63,27 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(name);
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return _commmon_choices_show(handler->choices, buf);
+}
+static DEVICE_ATTR_RO(choices);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_choices.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


