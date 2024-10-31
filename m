Return-Path: <linux-acpi+bounces-9173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05079B73A4
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EFAB23A3C
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE09415AD8B;
	Thu, 31 Oct 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MzIuSfe5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D528155A53;
	Thu, 31 Oct 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347850; cv=fail; b=tbbHbqc9jyActBBRdxfXHtGa0gRxeX69dMEITNcVghxnb3Sz1hNELuvp7p+ndKehsImFnrcNzlcVUl5gbn4McyTP1q8l/XGLJUhrzoWTVE97v2Y+pYA/K8q0J/aSZckn7vELH2WfM+1QkCiDM2PB4p8aTWip7C99UOnCQQASzdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347850; c=relaxed/simple;
	bh=mWOy5GM5UEJggDyZTxNZzpYHTp+vSago3fuXq6E9D30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HttnirmKDozYR6HIoOgnc1tvwp+Y6gqo9+8CjLcKPwGzPXxKY+irWlVO6phKPtQ0W1jqXkgVr1ALSJDNauwrm8yIzuiCzbtO/d68p3qeQ2oST9qlchhsHcETEByxigssZwcrGC5wWwem21mUer7A+Yv9qnUgWGe1RN1yDOEF9zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MzIuSfe5; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6X0UqIj8h7mGae1pK0C79dIxGYt/gyLyFiWDjN8KxjeTkGil2j/UTPgB5aPMUwqZSl+x0FufkwlFeLfpZpWNFmGDnz062gwbvDV6Gw2KwXv3Mk8pqbsjaSjIKMqbk57qftyis2vUvvudj7cFEpWsHpvGwCu8UInbdds/mZCLlQlI/PLEV2KdyyKUtG3a38091UeFVYRrPLv+/rbv10KDFTFmABz+Vt/ON6SDwI1yXMzlVYixLsAHB4YijqQdGaeQsQSaU7SNBMtTgeDUej3qIR4oEFSlQ7BI9myo9jPAbyWvjcHBP+HBH/fyn6SPOPsF8Dxzxtc/FQGbSlyvq997Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJzYNeaKYSJpkQy8diwOKNYtzHPdojNbidqIUCme8uI=;
 b=qcj7DGmwTNHB5mmEsihFShcdIaTyIzhz2D8sQ7xxgST7SOcqwiZqJ1LEAVFNOBYHRTzXmf3xBJZBz7UHO7jhs/vekP9ZA8ysmPNOoemj/9DWpdmIZCxB3wImYpFTvPAIgxzLAb09L79rcr3EYIOfjiChnvGDP/ivNXOOHl3hVvHtejDOvNx37WQM1/m8HNYHE5MQPqX/HyH5NyFL4s0XbvT7k/xwI65E/HvtdwjHtOJcKp+7Z9+p2S36K3rl7JG2Qlxj/T3olk5Yn4ffslBtS753FTHTuKmEsnX9MmMaiuB0vzlPc/YBB8B26slR4QnMu7e+1ycBEgVDOPoFwF+S4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJzYNeaKYSJpkQy8diwOKNYtzHPdojNbidqIUCme8uI=;
 b=MzIuSfe5+l+6GY3pdpdQE5iPxX4a8ABjm7H0Bs3iEOPN8MHl44izFtB2k1Erw6XmLmGTLLsQdd7sCVzwGL/k2agHfGwEZpuVQ03bbbrkTTrlmYsotT8ShzW1pNc5ki+w2bkoyV2IlyXl5CIO4t8zj3bI//ceeGJXUoFlxIXN45c=
Received: from DS7PR03CA0345.namprd03.prod.outlook.com (2603:10b6:8:55::29) by
 MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:10:42 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::c5) by DS7PR03CA0345.outlook.office365.com
 (2603:10b6:8:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:38 -0500
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
Subject: [PATCH v3 12/22] ACPI: platform_profile: Only remove group when no more handler registered
Date: Wed, 30 Oct 2024 23:09:42 -0500
Message-ID: <20241031040952.109057-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: de47a983-6d2e-42da-ec9b-08dcf961fc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzsDlELE6f7TinTUQ7C+SHBpAAs8EPw8dwACqIadmSgWoWhKpuKKi4bpyuiC?=
 =?us-ascii?Q?Pzl/8x7UA2HeM7fSRbQdCMfoog8H5B2m/aHe7HrOGPO6o+a9SJadNT3HNsxo?=
 =?us-ascii?Q?DEjMyo/drKvZM4RQkZtNDDInGD+WGnYQxUbMVXvP053eW9J5zlEi6XDH/Jqk?=
 =?us-ascii?Q?naGGtmxtvsL95D9vr0beSWhcZ4RVFyqhmoqlUxOMmbqs+oouB7xp6J08npcm?=
 =?us-ascii?Q?oAlnQeqEvmJW/wyYHv4SPaT23K3lIXCud7TYTsUz9I4V1O8oRwKIjI0xMC21?=
 =?us-ascii?Q?X1V7TooPZ61BArpo2CGkSd0Dtvtpm6hV23N47PNYcQg1Dc6crrWjBgsVbOcq?=
 =?us-ascii?Q?c+XqlaRLt3SjJd3KwiVboxvPxC2RZBWyjQNseMUdzs6H5CKLeL5Ht4oy81G9?=
 =?us-ascii?Q?rF+kLt20nReHKjUiS6A5n6vHxqur9T7Tnt0NaPxvWUKWbla1vBS6lZJ9eeBX?=
 =?us-ascii?Q?h1OJmH1tfRAJCrk1Cl9MxIbmKYb4Eqlhim3EaUcTXIZ5xpsQaY8Egt+kILAW?=
 =?us-ascii?Q?M+pSopcqkenCFCbx+sKa2dziYGLZXSwxV7qIX/TNKERNlqSjsRqUe4IygyIx?=
 =?us-ascii?Q?l6mQWrNzJVbyneD9lS76C5LWcsCNeYlBdwMOiefGQWmzzpDU6dl1xdQofvvB?=
 =?us-ascii?Q?RSdYM548A537kaMq7ADoNXudfa6QXj93mLDRNoPpSPPUoHjB9mt1oOPa2qUT?=
 =?us-ascii?Q?+W9F6gzGt6Js3S3W5WfdfwkR/r9gTcBwyv9LZJhuEvkC2oxK/VFcuHH+Ewkx?=
 =?us-ascii?Q?I8O5gs3tndndxNCYY+rtS7/r7TsAlFYgNPsrG4SACOlPhyN+z2IghbWnoobd?=
 =?us-ascii?Q?ZEeFsbhS7ckiaDZUoB7RyoZpxGNpQ8Hx+lP5N8i4MYXCcB1NGy56VbKac2WM?=
 =?us-ascii?Q?AE0O8zOcrFw9Dz+KhIzQj3fC4s6dW4/WPh+OiL8R4TuQLIiYWXiMALG4cilZ?=
 =?us-ascii?Q?6ybCzm1ey5ZvD3pCLyyXR4XW1ObuQ6c6osxnbcLF+ay8S+0Q9pGqLv7Dhjxj?=
 =?us-ascii?Q?G/VM/8HqnZlGAVkfyJXEPtvwSyUPU6+O4gg/HP+078vZvrGt8qoBCw5g+LtF?=
 =?us-ascii?Q?LgeB82OpltgXFEYb7IeH9z34mOIx9U8VXbzzJssFMR13r+Tq288tJy/Djeqw?=
 =?us-ascii?Q?lvKHtYfPDWu4Bi/VSZrJDD4qw7H+tG+pTux2w8ILanUExTcwL7+TFfZ2qM22?=
 =?us-ascii?Q?EfwXTXgV61DbeqiQDk1awYcI9wq9IieFkRdApYTxf0TywBQudZUutQWSX8JA?=
 =?us-ascii?Q?SL4ttaswy/a7pwFLzC/uVkOUt3NQLDyH/HKsZIT1gn2kX660JguMo+bpt9Fd?=
 =?us-ascii?Q?Jp9SOqZvxSwO4ED/32nzgEJcq1DeKOw7o/qhFWiwG7W8OoO3FuGRvrJ7ubw9?=
 =?us-ascii?Q?UZ8kwtYhJj+C/W8yS4ig+Mb2/WdN8Fr1UfuMVNO8u5XiDQmyAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:41.5340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de47a983-6d2e-42da-ec9b-08dcf961fc22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

As multiple handlers may register for ACPI platform profile handler,
only remove the sysfs group when the last one unregisters.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2d971dba2d917..b70ceb11947d0 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -23,6 +23,12 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
+static bool platform_profile_is_registered(void)
+{
+	lockdep_assert_held(&profile_lock);
+	return !list_empty(&platform_profile_handler_list);
+}
+
 static ssize_t platform_profile_choices_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -184,8 +190,10 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 
 	list_del(&pprof->list);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
+	if (!platform_profile_is_registered())
+		sysfs_remove_group(acpi_kobj, &platform_profile_group);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


