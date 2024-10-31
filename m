Return-Path: <linux-acpi+bounces-9172-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767809B73A1
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084F41F25249
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6729F155325;
	Thu, 31 Oct 2024 04:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AvfRTWAn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458715443D;
	Thu, 31 Oct 2024 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347847; cv=fail; b=N0LGCXAkTF1xSUJyrKJ5sr4IQivk37vrvUb4xDd5Uqp3x+9n4RXApDvx/8nHewy+IU0Mz4eHi4L0cnAeSa1NpKbnkiEyyVMBkHHLhzgSOYe/a5qK3T3Hi810kPM8vuiQMpSbfvIAOeDTJXWfHnU58PydNomEVMiw06DxVTW8IVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347847; c=relaxed/simple;
	bh=iKLFe9FucDIr15NkiaQmVgbAANocew65IHkqIEp0gNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpHDeuTrrEIbJlOufDflHZyyDzc5c5kq+u+YLP8jLNdOTukcOjBfOx3v/ikuQH7AIYtqJH2zd09zR7rmB6l9yURbmCyb+DcOJulFT8UMSZ8fmqScmhQg6UU7TUFgsO0QhSpopZu13oq9pw8htAJfXVIVw0Ip/zMqxAzMvBezhcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AvfRTWAn; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KM7siR+jjimwybxdDbq1M5WCs5JVI8APEukNHmWofnUHplnVMPDjfhyFQ5CaklonGUUxxjphd+QUAB7c+jvB5B4LRal0Y30/SxfJq0RkvkqBfkfmI8wFYerBoNKIss/prOwj6+SlAVex3w/du9fZ33v7FQ2AyuDKFBzg8ZbmJtU7UdJNm48QqFsWDNXzb7Xp4YL+qERZsTAtNxtNu0P5FmrdOaIU3z0Gm9buIJJYNoztGScmLzX3OPbiJUGmcQA/6gFiBN+MkIsRqOUWBHHpwcxa4bdns/GcBI3A8NVqBdbx9KGxi7WxRyXS/+LI2sb+3GFI7xen8+O0Ctn8ngrPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISN2oysPyjxrEnFD4DuN9L23LJ7f9XkdxpR95o7X1xM=;
 b=whLmSnGcyYwVogbZLpLbN/MyP7JP/ghhLfTi0QuuUZBzLqWbLbJlyF/dT58AQk6l+ZjxzBBGyi2xL+L9XwC0YO6Hdfy5YE4yxgbibrPgl5qYsZB2gCydpeJwEn+RN7vN2Hrro33Nbvfg3ubHyZ9G8unMKytLgTtPkKQXcaWSPYAcQC1+wLQta6pjn8sHB/YpEuQZTX1ClnbdGLXnWo0It0yybhIgrJ+AcO4M5JwvEH1L1zr/R+kwJ9tYKYRIq4CsLxafEXMEaEz7rt6J2inc0WnpGgP+ZX8xTrjEVDbKgidkh9NmFdPA+4GrydwM8WORWGrgfh3pVJFRahgvqHJDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISN2oysPyjxrEnFD4DuN9L23LJ7f9XkdxpR95o7X1xM=;
 b=AvfRTWAnt7H6VTfMsrBMBJtjXG/LpNLBGOG1XWDbkJRdOJsX2QfQeN1O6+76xBbfr84LK6/DBH1ErZ30Y8wu1OuEWjhZSPXiNiwpebUe4UvKhE9stdBp1cefdUinWxJwFBI1+vCW/VEY4947fFSW2yLQ3KG8sCqfpSKllY/zzcw=
Received: from DS7PR03CA0344.namprd03.prod.outlook.com (2603:10b6:8:55::28) by
 PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:10:43 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::b1) by DS7PR03CA0344.outlook.office365.com
 (2603:10b6:8:55::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:42 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:39 -0500
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
Subject: [PATCH v3 13/22] ACPI: platform_profile: Require handlers to support balanced profile
Date: Wed, 30 Oct 2024 23:09:43 -0500
Message-ID: <20241031040952.109057-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3b3f41-0eb3-47de-d1ea-08dcf961fcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/1TFd2NHflb2IxWb7X6eZb5HT1hH6TFLCNKhZcme83fy7SxZins6bKuM4iX?=
 =?us-ascii?Q?h4UGQr9atsp7bi5CSQ2IKSD/fkN4QqWVFaru1Cu+JOleQd727nSCvYK6zH/C?=
 =?us-ascii?Q?ONEo41AVWPqlhDKgnJXHqZzhCthBUa1VvsvGOR8xXChImwUDcPEj8Jw49Q00?=
 =?us-ascii?Q?XpXAvTgbckTv/8qEgGGRVm60vK8iRBBlJH0UbYi21HMUUbmpSxT9sS/fMfOP?=
 =?us-ascii?Q?im97VvE+ShN5ur7FGeW2sllbCt2Eev1OdwiF63ZIRdCp3iUxDpbQnRDBav83?=
 =?us-ascii?Q?LwnbeNqqCIub6TzDfZZdzBCKLfHyOWF0c7FzWHuJOrLfePdp/B35oCWudQsF?=
 =?us-ascii?Q?k/fX808J96dUTbSo1qMuY8NKBshyuZUIBkuhYnl05KHc6N5wA5uaSbPtvmhW?=
 =?us-ascii?Q?w3poWHQrUyHCx0ActSLGiNMt0lsW86DGwAt+NbACm+GF87Kx+62A+tvfZmmC?=
 =?us-ascii?Q?Jv9kOPXVCBwB5BHQzfhSoW8cnZLPcYVz0ZWJ4AXXH91fbE7d7lP48TqZeev/?=
 =?us-ascii?Q?wYzZxIjwwjeZesOTvSn7vfQKc8lqrkAxe1mbZPLFmAPuDDzacPzZ1WAzuc18?=
 =?us-ascii?Q?iGLUlFtgU7DM59cVfjjf3mU6YaNZBJVThPvx66q/GbM1Nia4ceE8EXG3OYI3?=
 =?us-ascii?Q?Snlf+slyFDqfXZprBZQJzzioW/onovCz6C+6hqbAI0Rjq+PtGYElfz20aqQk?=
 =?us-ascii?Q?EUeNVeXj0Hsy6wUNxGX6Bt6X0TTk2F4+aeZzaGRGH+fjxKOIcnNFc0bB2cx3?=
 =?us-ascii?Q?W9R3MkfYkENuiN81upGVJwpVu+O4Uo/2P1F9Qd6G7Iumnuem+qWkt69r1Azz?=
 =?us-ascii?Q?9UH4qNghKD4ikFva/EzfztKz02kTQFkW/cArg84hqXuau+jEyn4D5ymySLqi?=
 =?us-ascii?Q?cEllKuUK986kyz1t7dIX+/trm81pKwJ6lLLmNmg7VddXcjDr+zHjVCQJ9XHA?=
 =?us-ascii?Q?QoD0zlDU0iXFJ2nzhUKalLNx1/J7wEev+AMB970g4gYkrGKFdvxEpRz3bWkW?=
 =?us-ascii?Q?RSFssJJ8pGkX51rPLtieMq70mLxix72V0Czg+hmPg9OLC5NjilqH1oV/NCDH?=
 =?us-ascii?Q?bX+Gcdk3R1gHDHaRBQV3qv4X2H2aTEL9XEtrEq6RHZAnwBuRNp8AhRy9j0aW?=
 =?us-ascii?Q?TnvMD3BIXAPQOkj/REXH8uEm4gMWtawuy0Hbc5QNY4T5HuepW0+4W5NSy7Zt?=
 =?us-ascii?Q?pnl7RJ9fAxEBno8WlSitchhpNDDpTwPvv9sHRUwpYFmMgkmmt9IbFTuEIhjE?=
 =?us-ascii?Q?HBHqb3e60guFyM2787+XgmBEWlYKTsN7ob3Ua+iHJ4YbqXyngVXSf7EpViji?=
 =?us-ascii?Q?B5JLHxqjxsSvzakzYiiVloMq/Egb1NwVWWxWkloKEa0pWM622yDPwyO/9tDZ?=
 =?us-ascii?Q?OA0ngqQvl48mvaor48z66wMDIJLxTj4nFUkOfcKleatpz/4+lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:42.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b3f41-0eb3-47de-d1ea-08dcf961fcc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253

As support for multiple simultaneous platform handers is introduced it's
important they have at least the balanced profile in common.

This will be used as a fallback in case setting the profile across one of the
handlers happens to fail.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index b70ceb11947d0..57c66d7dbf827 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -164,6 +164,10 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		pr_err("platform_profile: handler is invalid\n");
 		return -EINVAL;
 	}
+	if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->choices)) {
+		pr_err("platform_profile: handler does not support balanced profile\n");
+		return -EINVAL;
+	}
 	if (!pprof->dev) {
 		pr_err("platform_profile: handler device is not set\n");
 		return -EINVAL;
-- 
2.43.0


