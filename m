Return-Path: <linux-acpi+bounces-9302-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C49BD079
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60361F23099
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7C61552F6;
	Tue,  5 Nov 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+6+0jFa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360414E2D6;
	Tue,  5 Nov 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820823; cv=fail; b=mtmHqqgc3mEb/h41C8DV4qYq0MkS1lzX9+8Ltsq83y7tGuqTF2pvtS6KulOOldNX6Fzlq4EaGuXfmhIg0VFY/VPx6FQ98RfTkmq3zABGpXRUOoXaB8I0MIVtoWw/g3WM/wN7Mk9mKNLo9xLcxN4XmlYWTEYUI1s+DD+mhG/cYDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820823; c=relaxed/simple;
	bh=vmH80ZPsQiWyuhHi93KG5eLUcVTYH8g9LsY0szntTDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GspamskvqSgEpbKW2bIvVxqqElwOnagDNXltboiFGqWSaVLah3ET8V4dQVT9hHOkpKEihOujF3oBH94YqGYyYZgMLRB0ew2DuGd1uUYMxi8cc5P8Sy1fmK7vp4BZRAWawE4m4xzYqpjsgDJoDObmkoSZhun/RuwCIBNG+JUANZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+6+0jFa; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/I2I5od0xbUO9lQpo2oyy55IrvGoL6O7auBP3A4ptK1B+OEyQ1/DDEW3JHWhD5jXWJGm6coj/XRin5bCBqlDXxMk10pJyA7Ykmr0fqapI5MmHHYvag0fFysOKhHiBdTlUrEfZbJQTpTy8QX5YBVQ/DfgD1qYJ24HzSMwvXd6mqqHTIrVa3pK/cke023CrCGrIEhtrwTHfvHD2SAr5vbzXsRda32FfgU2zPc5jE5Pj8LNXW1hEW/tBRv+tRz5z7bUTmi2Ohl3lqhpTPuIQb+5hesg3E2H4X/YyJpomg50GqFLVaFxtQJep90Gsn6xvd30vbPVUmHoFSQhCBZafvLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpOOny12FmSUBq/F94SaWglUWvl7NYuCERlhr18ZrG0=;
 b=CeDhq06BaDxq90sdH/ST6ZRB73E32ASydCT5Msg9D8OKN9Rc17YInXtKuh08w/q1TcMyAHSPAdiYW3+HbsNpJdYVNUwZ0ELejVB8tN21j7bCF0Ic3DNuWBY0CgF9Ip1tZ42aQskENIAhbEins3VZdODNL+USOXnwT+0Id/D+JIBqhkR/04srjE3svzxq+o0XBDZReFEU9zWBjrqbPwBz1OkJuU5rAHXYY/SSn0GWqI8DnAooO6m+y+pdJpRFJwoWamfJ92nNQCj0UdGEeCqPnd3plujKNqUeyO6xbrqTOxBnpHLHX3occlZtvNWrgcbE9pRb9G0EGrK0jW2S0u1/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpOOny12FmSUBq/F94SaWglUWvl7NYuCERlhr18ZrG0=;
 b=P+6+0jFaiml2Cm1kD5edUDgd1x2kzJiYA2JuwCMTwF3OU81PWc0k3TlVueJhmco+Ehkp/cqPmhlnj8M+j1VwtUSndhzRuvUsR8s66XKAdKwgU1/p+U7kjZnTdEhW7sy0/LeJuue4u/I5TO3ZdeUZ9C/QxGLcVpUtPyATU4OWvGA=
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 15:33:38 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::8f) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:37 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:35 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 06/20] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Tue, 5 Nov 2024 09:33:02 -0600
Message-ID: <20241105153316.378-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105153316.378-1-mario.limonciello@amd.com>
References: <20241105153316.378-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fdb62f-4ecc-4fbd-e19b-08dcfdaf3800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dJyRmJYGBY2BUPla5l3t5xXPk6pTXX/RaiQcLhD+aTMyzbebAdVBVuKsP+eY?=
 =?us-ascii?Q?3X2Yn4dlZ8AE3wlqjliuQ7MM6Nz3z8n0SmX1BENPzgr0Bu4fagT9rvR+zZay?=
 =?us-ascii?Q?aO00XrFp2f2ZCC0tufWKbu7sRTZ4HgpyJQb0hveWpmAvmJb4QTvznAsvyd6Y?=
 =?us-ascii?Q?+mPu4zo8bry7C9Ao745nWLTQjx78VOcqrCfVik0WMnThjESQY5mc9FgZxK3Q?=
 =?us-ascii?Q?fDvO+YtFRXyd8LiJS2wukIKeEtbFvvuak7H8uGUgK+sPiBHXncW0DQnLCdOC?=
 =?us-ascii?Q?PDsrlunjqBzo3x/zS8w2nZInC/RgkS5PWvk+9v5F6+IC5rwpSHJR03PGS86p?=
 =?us-ascii?Q?b4X3zaw7GPM6IA0SnHfgKTwJrLdJvoaaS7dATaxC2AvTvA1Xw58bD37m+UhJ?=
 =?us-ascii?Q?u2+FYm2qD91PjFYcl1BfWH+Q0uHXSZ000o2HCnFoKjVtggSJfcFdwT+K3n88?=
 =?us-ascii?Q?BhlbKOEolCnJvvAWVW8UWFAJ+vrtaHugO3X7REjsr2AyA3Axrwo1gDYIQC0I?=
 =?us-ascii?Q?8AVdk7KMhfz84+WNxMoZihCW4SznAoxbjqm4fbyT/4/G15iNrzriiF4G9W75?=
 =?us-ascii?Q?WvEnaP2tUlkTZwVYm1c3s+ZPycB1vQgSOmTDEdIQcbwzxSNzOVFlJLlcaLvb?=
 =?us-ascii?Q?E4NA6L3Mys+dewHKOt4jMMH4XxeuOTFMW4/CUT3k0oBDXa/GCvG/TWOlaqFE?=
 =?us-ascii?Q?hYGA1Dqifrac/ddBa+NOqHBgEwIbKZkkpAt8ITkwovh0ljy46pn2HCh25MAj?=
 =?us-ascii?Q?CfNSJmLeRzxJfSAJ26AtWG9B5vadWFzXgGSsUfgE6q9q9d3oLrwGBut9wJsg?=
 =?us-ascii?Q?R4VcRsz51d+02hbGObvhF5Rc30wZbuqn1tZL08P5vhUjVOYPJhsXqzaBjEOC?=
 =?us-ascii?Q?S7IfZb+vtg8uuL7wIaaCnHjYapcs6Cn1w9EhKv6sBZZ8cXxxm0T/dExhvjeK?=
 =?us-ascii?Q?xNil3q+IY9goefgQzkzoXI/CF8T+xTHSWj0CwAsVAlNWdLMMnOeG+sozzRwc?=
 =?us-ascii?Q?K3c4r7L6xdGhL5hcNk3WCV4NVeDFV8KbIqmBbmGoyTAVaC/S3QNks4JuGPog?=
 =?us-ascii?Q?QDKCnoGA9HpqsE4My0YJ4NR37hQGZcvb02SZokU29aRSOScq9oHKMURPEqHA?=
 =?us-ascii?Q?kz2oBXCqaRtYpHih5eUlpegegWPGfjT4iufEfg1/pnasWUGLc6LrU23QCvi8?=
 =?us-ascii?Q?TQ9Ks5eDmWxzUPzhLO5eEOllSS5Q4jStNOpWHCg7/Y4j0rh7liqwRQ5+fB6k?=
 =?us-ascii?Q?NKNAZlke6zGzdpy+VVhaI5M2OZSI2BPSK0lbS9wEIBXX20b4R/PCI/PolzhB?=
 =?us-ascii?Q?i1ozHWjEMOUGIsp6LpLCbJcCH6MWcWPahwBvNMB7O7GgiB6XnDE/CbYUEWX3?=
 =?us-ascii?Q?xKZUSgB+MbxGd8poy3BUnzfJ1TXu46XM4+eqBqFCVLdoG+LotA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:37.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fdb62f-4ecc-4fbd-e19b-08dcfdaf3800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4e8a155589c21..70e7f1ba68676 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *dev,
 {
 	int err, i;
 
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
 	err = mutex_lock_interruptible(&profile_lock);
 	if (err)
 		return err;
@@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -ENODEV;
 	}
 
-	/* Scan for a matching profile */
-	i = sysfs_match_string(profile_names, buf);
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	/* Check that platform supports this profile choice */
 	if (!test_bit(i, cur_profile->choices)) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


