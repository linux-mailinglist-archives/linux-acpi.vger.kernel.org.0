Return-Path: <linux-acpi+bounces-9394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B19BFE08
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A599B23285
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72371D9598;
	Thu,  7 Nov 2024 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LtWUhb4O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AE1D88A6;
	Thu,  7 Nov 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959428; cv=fail; b=o9fkBBbkupI4gU2ettFl5vhSEmpiKl0tOM7BiQIhd0PHHFHZRpD5SncjSSY98/N/H8qX3hJg3LWMPNYsMx0oXtnVoxTN0mR/BCZyH8JgPrpfq6IqDo974KlA8FTfHJ9NvGhVAXpYRl6EoZOHVtdmd62oVdsP+UJYeGpgCub/Js8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959428; c=relaxed/simple;
	bh=OQXVw6u+M7syhHbLbRezlPZA30ypVFVMtBz8NgxSXIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sf7bldaxDvheeYHsNpPqEgekPvE/gA+SaAVm0b1tcTuiukjiwKhGEY+w1ymNFeCclz1KfUYmW8rwC4i733cTZ8eVdD10JP8ZEC+numxaA1XR6DK77ZdGkONiX3v9/wwKpHJPZPEGb2/AQnxK/GXE4cc/ZDJ387qb9aF3VnNr61w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LtWUhb4O; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dELxqkpltC3sUqSYSutrZqAmdnXVadWVMGhJGaDIufbl//HuxytVf0pMnj9LoaPQjKxCFSLvlf13ywbuP68DaSmzCMbL3H4TmxqHINA0D1Qo3557FqJ183COVsZ4C3MIo0CUnGKi035T/L2Z4U7xaE/vhaG8Bkyv7dydIzbB1CmQsIdixpvOiP2ctzV8bGIgLXAB76w87UIxRaXOR+WWw3RcZWwyZWaXVpyZLbYkyKbx0PcyspHeqqGTCJWcD/YcXkEdtns+8bU2wVXXHcd7izcJ7UiPSgYl2/KwR5C+vpBybfuynFYcN/euE7AffgnumhenwczQBL1OV1S+tqYwpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqKSai3N+X4lQ2c3ALLtn0M4GqhAaiwrFQCWs3AImhM=;
 b=ySL2CPiFT9KbxFAIlMdtCmfwqMROyOV8NtQwlKWY2evn1/VBeCqb08KpydddMJrfkE7WiNoi+4I1vewgyrzZHV3xtIZNQE/lRMc5rb6gHMCY7IUo3hgxM/FwnahxZI1ZqtwdmGRBlGjpY5oFoDU0J02BeGRac5rHHYTPjbsP9G51bM5DjwTnaxxxzrILwsoKw2708aPp7VQkRzZ1enmUUIWLT641Kh+Ju0hrW1ogXa0z25nXfh5jxL3k8toiRRKiim2jj5t8WnCD7vykisDRxihyVqdgW+28Ikv9Vs7IniltPj3M31N0++h3vkao0p6OA8NbXLPkCBMV1n1DysdE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqKSai3N+X4lQ2c3ALLtn0M4GqhAaiwrFQCWs3AImhM=;
 b=LtWUhb4ODckhbqdD6P1cxX0fs21ztDZpnx01yndOw3zbKWScIylny5hTgl/g5kYbMs2JUjwTKVGynYSXu4YAgyhtep3nkzJ+ZfjUpOKzg8P4UTCCocXUqO/2jCnkhohxbzCq7Z9xHXZWwZQj5SWJJq8ww4iJKk8EflmXShUBzTI=
Received: from CH0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:610:e6::27)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 06:03:42 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::97) by CH0PR03CA0292.outlook.office365.com
 (2603:10b6:610:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:39 -0600
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
Subject: [PATCH v5 09/20] ACPI: platform_profile: Unregister class and sysfs group on module unload
Date: Thu, 7 Nov 2024 00:02:43 -0600
Message-ID: <20241107060254.17615-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b08a48-9931-4637-9aaa-08dcfef1ee66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zi44XaYeXA0Q/xlwwKJFktFrcXMuuhlWzczoywW2uL+odWoRqXo90Rr51NUB?=
 =?us-ascii?Q?WfKfMm6/ZQRSMrTeL1AcWhydXE95QLBLON3uxcs3SrqKrJ6hcb+48obW3tZU?=
 =?us-ascii?Q?d8uXcT6ksRAEVY1/fuFHXUOcjOHOglju3nvrWHJknWf55gw2OyIhvF7d/jjg?=
 =?us-ascii?Q?cC7gHbWyVP2lkGgmG7V8XebIauCI/ixpVwi3ntcFhMQZx9KxC0BgdYbvUymx?=
 =?us-ascii?Q?x+Z0AwMMJs4wemhpz49BmwYH2XuGF1p+HwfHJtfOI3Uxr3aHahtidC3c9/tK?=
 =?us-ascii?Q?4EC2BwcYmmd2JaacjhRIOq2US/NEZDa1eHTGd/NED4Q/4kpliZwKItnkR528?=
 =?us-ascii?Q?Ge7hs6BNmRG9DGNADkYBJ9AmZF3Kq0BwuCbUdAcnZ+svtEgWB9J1qNzvZr4X?=
 =?us-ascii?Q?te7/4AWXypUvTFgzwJg8IfmlMC7gBoPr2IL13vwavBCWHgF2XRtSib9ugog5?=
 =?us-ascii?Q?R2po0FAna3LCIadSaCVXeWlrgJ+i2WQLIW9Tmx0Kr4A5oz8w3qsuZ+2omtLz?=
 =?us-ascii?Q?uGfD9/4CbUeh04amtB0ZJmFVooVc6Jo54ViUtYcoCI4LiQEV1XdGuWEyt352?=
 =?us-ascii?Q?Pz9ccxafxy5ikBNcGIK9Wz0NbPV4MDb6FRTDRHuENLVk4W1BXK8CZoNY6PJy?=
 =?us-ascii?Q?s+rQZ/1kq2lf9jOEBPvzhB30ulfdVCDmg/SliIHVx+KzBc32u66QdGiyj8iq?=
 =?us-ascii?Q?7+eofj3jyfDYL+PUSGRL3VpzjZCeQYirnBwxUX0oUAvjxqKHBaeaBPIHZF4p?=
 =?us-ascii?Q?wnVsE0CZJjPe24Wf43d4I+Cu0UgqEe2vptRf+F8JZbe/c9xTgzPQSsn4L6Ig?=
 =?us-ascii?Q?n9gnY4L/43h/Uwcg8D8qaPFL+D89HUsqNv/4XDM+nHZA90P7LFH0UUdhA4kl?=
 =?us-ascii?Q?hgPeufxBZ9bKaL+Od48jw0L/QNiBC96GZ2pqU8Fu7zk5EN+1iltoDXZmYC5V?=
 =?us-ascii?Q?UVJotGRHpOWzU+tsIm6NFVAnIFcvZSf4ODRtOHU6j2DAuDEmtWTmK0zVns04?=
 =?us-ascii?Q?vyjfVaHUDh4h+6y6+VWBAYDwCNnHIS+uEd0A6q6e/3RlJ+TfL8MXTmrvgTN1?=
 =?us-ascii?Q?jUtd9b3pNhxAU3mxNUrUsWpIKRHcoOfVShYI4cSENTc+PLNaL/0pCR0eiSTu?=
 =?us-ascii?Q?0QcD5hf4kJv8coINs2H7YyjGK8xLkbrm9kjwYD4aGrp2RjsGRICG8sRc5SXW?=
 =?us-ascii?Q?G9/3xF80OzHhwVU0+PhHuWIxk8V1PqhcTbo+I64CDERR90whSqBrnrAUZzv6?=
 =?us-ascii?Q?F0blLjBS9pA9P3+vjvDXEf7wEmD4bAPhxynhxep+FAo+fZ5tUDoxg2p6vbh4?=
 =?us-ascii?Q?MO5yxQf7DBonKCZ5zIfz+jZpeO7HsVwD10PKYK2Y8pSERnHAZh6qAgR2r1ue?=
 =?us-ascii?Q?JIei+r2vCOYasiIhxuVQcJ5S2CWE667rhZS2m6tmeLJ+CrDuyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:41.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b08a48-9931-4637-9aaa-08dcfef1ee66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313

The class and sysfs group are no longer needed when the platform profile
core is a module and unloaded.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 652034b71ee9b..9caf070f77f6a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -224,6 +224,13 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
+static void __exit platform_profile_exit(void)
+{
+	class_unregister(&platform_profile_class);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+}
+module_exit(platform_profile_exit);
+
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
 MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
 MODULE_LICENSE("GPL");
-- 
2.43.0


