Return-Path: <linux-acpi+bounces-9307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF39BD08E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DAB281EBA
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8801AF0AD;
	Tue,  5 Nov 2024 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mOD2Edm4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ECC17A5A4;
	Tue,  5 Nov 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730820828; cv=fail; b=diC7JnCDVYNx0dbgvY0sBIetB3E8mVKgB/9Ai96gNmq/sLWYx8mwWpNF2cBUV7TJWTlaiWHcQen/tVcHwps9RVFgzp8RV0JlxuR5tliEdciEGLOSLWpzjWPbPwo3m/hC/LFb7R19q3UxeYJLEsngpfz5Vhr8eF/xolrmugIY/Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730820828; c=relaxed/simple;
	bh=ma6d5NxwyV3xz0uFiVwWHAoPzdOxFIKFXHz9yd0C6P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5Zk7k/HBLpUOlUY9nXZXkFh2G7k6NCnJQ6fupaR4IJey840SgFfvSosTFr0B5lzyW+xNQpCxn6DIR2mhTy830fJk5qT/sHMLlZN7q3p/XuuZJQBqnCTy4n0ZhcVpeLyTJxlWiaIOPiJbfkVaxqfIZgmF9O+rrWLyLoXbUT3WM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mOD2Edm4; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qv2nBvxEYkPKB71wMpYDe87JHVmB85c/rYW2ygm+DftL25PMk15XxDJ76KwQdWnWrJHrr10I9mO0F8/K2+6veiGdj/zqHlDEYNPk892+68q2S5l8va7VXWpu77esBRBZZ/thfN3fsOcX3bQysYTK1VijrLU8ltWXwXHXurm3TQVH74YyFPePEJiwK2uZVhFUnl3kUCM7wNS0q7oEajOhUpcvXLe1NjYtatvUxry+k1boC2ylTMTsdpXRzg5R1S9SNlAhXsyR1cjAPyVJ2hZBT6CAzUDaJH/MLSzG9KZx4ajJvyc2ZqoQv7Lzh1kJQIsg2dexzb9dmw2xL6a8WMiRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LMnJlDVc5gGEZL8b37BBEZ+USZkmvhj/BqsNTn8yQE=;
 b=g+w0CJAFm4HTXCtX22QE4lLvMRM584J7kolRTUwa7JwH5DRMOLd+732dWYxkpf6yM3s8E4QLdF+JgRNmSSsIoOvuEfiO1blyFAaNb9EKrBnMYRBVyX79tpOT5EMlBeLtk6BOp64ZOmLn+v5WnvKEplPmRrM8WoUIDnEMm+V9fCKuilrEGHofJbXoYEflcIvOACxG7khouAGyrkmg1V+if3mGzviecFxlPNg3wBrqZDL2iZ7OpYOOKkNNIxTpAbidZEt8gP2B9IfxGZKKTvieM4Mgafjl98mKHE0MYl1QFJwdHLk9wHezdSzsTPFaz3HxKbjwqdqjIdXWOvy8+4hO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LMnJlDVc5gGEZL8b37BBEZ+USZkmvhj/BqsNTn8yQE=;
 b=mOD2Edm4yWz0/WJ7Q/D/TLj4emUZK3XE0fXRIjaXGH+KkOmA+oB1HEG8SoACnA4lt2GUPaIhDfUcTwSRfRKhBchFWJfsybZ+EHpZMLWQ404axOQz03h7U3CA7F02dZZivSj4xXq7Wdm81fXp3PIl4/u4UtFrqs1taNMBLs7qBy4=
Received: from MN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:52d::23)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 15:33:43 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:52d::4) by MN0PR04CA0006.outlook.office365.com
 (2603:10b6:208:52d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 15:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 15:33:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 09:33:41 -0600
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
Subject: [PATCH v4 13/20] ACPI: platform_profile: Notify change events on register and unregister
Date: Tue, 5 Nov 2024 09:33:09 -0600
Message-ID: <20241105153316.378-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb73ce3-1014-4a32-3352-08dcfdaf3b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8T/ysVAj+sKZB55JIzIGENyoNceC/AYqU6XDmZusZLBEFMpJFrzkxK1bOIzH?=
 =?us-ascii?Q?Jcf9Hq7If5nrUYfWUneTnQDp2s4w+/v/3IUybO/z1OWd6S/PgPu1+od6jwq9?=
 =?us-ascii?Q?Fv5YHCimdpKV6sQfPCtbYQQkrDpTJgCQuLC+1XHxNfysCsooNwr7KVsSO0OB?=
 =?us-ascii?Q?QrkRx1FCzz+hKfMMMBFRCiHRheQbXG2/FqRTtm9oAMYtWb4AJLQzv+w/R/8q?=
 =?us-ascii?Q?1kAGIxoCNxqYJFKMUpRyL0NrKOg6y1xeYfzRLFHNicsorOa0GMe4S4jsIvYJ?=
 =?us-ascii?Q?K8/8Wqhr5XUvQmWMw9I/6OrjJcBXcdeeXvJsaMw12LiO/rcPYIAtubjFIzNn?=
 =?us-ascii?Q?FMceu7Bv+SVA4nlEKOaDvH4Q11t/ORKyWIgwNrl58EhNnwBBl56L0OTq2+9L?=
 =?us-ascii?Q?AgRWMqSBbu63ItZq9NumFaJbU86b8ybaBVbx94N6YByq84+zNG5X73AZ/p9m?=
 =?us-ascii?Q?pfH81Hvn+vOHr+hC7NZgWrcC/6/5T81DtZvdaFhHRWYm6BkiGENvTaNu9TF1?=
 =?us-ascii?Q?G47Q+1ALfxZMVwNty5P8v27RAOsfnDLq2a1S2NJUxgRIvwZiKKHtwUX4uLvy?=
 =?us-ascii?Q?JlQU+Go1H4vNa6D9aHpdVZt4TliY3NR3jGPCTLtGZJMd1O4nytsfQ/7KC9GB?=
 =?us-ascii?Q?7CDqJi8Vlw8iLsBdPdIriy+J9DZg4bjR5PVGGzHLX9E2FrTRS5WfYUWXuyno?=
 =?us-ascii?Q?SmYdEfMZ4x7hg8fqYcSQIL0s099dNb4RRe49e2ddfEK2EZVqwR1AyId5g3Ax?=
 =?us-ascii?Q?Dqsc5i23C9Tx3XlQEicqB5u6VH2QXjcOv3VV8Vhqq92rMwYjlKzgjQ4iG7dn?=
 =?us-ascii?Q?fCrqB3QTLEhEg8CZEe/oE6KenytVeWr4vMCY0wUQzZimv7ZbCRLQriS8PHOk?=
 =?us-ascii?Q?Yk4tDBJNkmOUng/CZSwcjNcoliOhDaoJB25SloSP9V9WzAE+XrqO7lu+Tw4Q?=
 =?us-ascii?Q?REtUZRzfWK2Ak6OGjv5WuHxfL61SsZxQ1BE4lqpi8sgVyzmbjsZmcsw++bfF?=
 =?us-ascii?Q?f541IVfHsrN5MkebJuJOp44UPyp+6692WqeucvEQ+jkzK6YWEJgD/k/pJt4L?=
 =?us-ascii?Q?4Es8forHx9/X8MQAm2z4UuELqg1/tlszQFKA/80V+Kg56e6N+hv54N9YBwF+?=
 =?us-ascii?Q?eaQZhT8Q1Vu44LJsqj0jPsBLLmxgKDIYRetWZ3ax7pFHLpPMS+cRLDUK2kIj?=
 =?us-ascii?Q?M+JnjE/VUPWpeC3swXc/AEIBskXUWy8eVqeueCWDAWH3zTa/zngYKuJKMtEP?=
 =?us-ascii?Q?jJw9EItk2QKm9mzPGKCoUrl8+I/tpnqxqu4EqohIuTM7Fcmby4aw9GHtv9O3?=
 =?us-ascii?Q?S3UWEifUpEvQSLSUnHTLpeRqivJypDwz8DLAq7O43Jql7j9uita4rv9WmhVd?=
 =?us-ascii?Q?lCeb1HCGOeAXwSQUptllXHQCY3rDQCEGNCaLVPVfiYJDsp3FVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:33:43.2016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb73ce3-1014-4a32-3352-08dcfdaf3b1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79083d0bb22e3..c9917daf683cb 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -404,6 +404,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	if (IS_ERR(pprof->class_dev))
 		return PTR_ERR(pprof->class_dev);
 	dev_set_drvdata(pprof->class_dev, pprof);
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	cur_profile = pprof;
 	return 0;
@@ -419,7 +420,9 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 {
 	guard(mutex)(&profile_lock);
 
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	cur_profile = NULL;
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
 	device_destroy(&platform_profile_class, MKDEV(0, pprof->minor));
 
-- 
2.43.0


