Return-Path: <linux-acpi+bounces-1482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FC7EB7EB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A6D1C20947
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F12C1B6
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PneRUGpo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FD35EE9
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:08:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7068AD;
	Tue, 14 Nov 2023 12:08:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKwy4Hv1qc+T2tLyhyfvtmI5AcUueh4RjD01JzLBpwEeKMA8HUB3OTlEo2E2rtrEHe2kcvGDb7E4hOhn2dmDRvyiwNuOBPAlg9zU6EkLfRgJwWXSqJYBTRYhlxescXamssajt3n7jIWxcfS4dmu30FkYo2ZQzXLp0SV+p3EJGMsh4cLD4fBrvvLiEFQC9HZu0an/q0PCWXtnwAuVdK+JvmTe78r7opWNYmucyi/pHxn67vxW4vqlZjJPDwwWyxSfvtToBvKcCxo5r4GEWhh/DR1HGO82vbGITVlarmcF1GZ3aEVnLn8M4tTRVGlQ+r/T7BYXknn8A7txxtrVI28uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb95XPxzHdwTy28PJuqb9/ZYrzEXJCqiKJH0uCKyWMU=;
 b=LHyVpRjFLhdUNrHWgsK3zYOp6TV0h7IekU87zA24MsW5OsmB5BsYseOtpU02u03SMSksI468J2yjmg7UL+F4QLuJA5DC1ZYKgbIrnf3V732svqbt8Tqofj9agnA7Z7EvdVyAlplatkI2FrbqqdlmC7P3A6eqfHZCbroQBj/sMa3BkxSDavUcNTfn73W0PDVWy6q/7eZ4GUgo1AtYvjbacKMcqvnfYXdI7feGSElqrpTUzt3IttTsniLyMsm5Y12K14lU2DOXIKuLRb2KHMCPeEashZcA9jfEPzWtUOFkPVkuRV+slOdr5j3S1PgjPFrLgocdI7PydEu7OXU6bsiH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb95XPxzHdwTy28PJuqb9/ZYrzEXJCqiKJH0uCKyWMU=;
 b=PneRUGpo0+av7uFyBnx3S2QE9WpIkv1qjjmhDjPgs8sk8RbJmfoOPPiLipAhkASr8fVNGCWjZ2559ieYd+hvcf22d6wwszP8TrhBRAPjSFCt1EH7pPZTlpZvZuoiKU8ZzFiiJXGCM1ck+9eg/aa6L1AB1vZfl3eml3orL8a0YFU=
Received: from BL1PR13CA0291.namprd13.prod.outlook.com (2603:10b6:208:2bc::26)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 20:08:30 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::70) by BL1PR13CA0291.outlook.office365.com
 (2603:10b6:208:2bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15 via Frontend
 Transport; Tue, 14 Nov 2023 20:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 20:08:30 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 14:08:28 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
CC: Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, "Maciej
 W . Rozycki" <macro@orcam.me.uk>, Manivannan Sadhasivam <mani@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, "open list:DRM DRIVER FOR
 NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>, "open list:DRM
 DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:RADEON and AMDGPU DRM
 DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 1/7] drm/nouveau: Switch from pci_is_thunderbolt_attached() to dev_is_removable()
Date: Tue, 14 Nov 2023 14:07:49 -0600
Message-ID: <20231114200755.14911-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114200755.14911-1-mario.limonciello@amd.com>
References: <20231114200755.14911-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3aa84e-79a9-4eea-56d2-08dbe54d78ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hHgBFIzEDSD49CUot8T922vTnblGs/0dFXwARcqkyAL2DkCg2q/xLBQ6yTCMXvqIU54DqQzGxXz3nDwZ/I6rVWso5Oum5FcVKD+vPfn2YcXIR2AZjGmsnyVcW0uq1M7I8whRl6ASE78efeAz5N2dENR2ceAB9flDWD5RJQMug1JE6+qIiePS6kANBoL/rJAQDMXA8K4doyezanzeseqEhKTgpXrnTetEhfPUPbYAsvaqkITq2z0CpV1LbUGz8RamvyAW/T6n4G3nnApQwddhZZt65SdxzyN9Xk8Fm/wQR1ryyimGGYuFqVzA5l9G6t3FSf8ltR118e8P3Ad9Ypd96xwJTotgS4xGF9WxChVNaatdwdMQiBXSy7aYPsVPvbXTp5/w4WKL3FBttKRnogo8PzA89Zu2M1CsebrTmWfWTXjo4SmwwYA7GQ6CPW/U5DG2Jfau2BfboUvRwDWeUZHErITkK1sFWlQVw9psoHZjMI+MhdA9PEWpO42tPUGkFueAUWiHWWqv4pcqkvoVqf2mLE6CDyet9uXrV3GPNbB9MYERqTbG7Q6FoCZDlEqjwBU087MQcj823q2fnXzdw5rl1Uu1v9evmtBgB84JUbe+WyC0V3uIDYq3Ge+FfyjH9sy2pLuyrOAj3dCKRn5pJaJVfMSfWR5C381VfdH8PXKaDStr0HiH+Jr9dzcc1HGaMiqBTYbeCumutucb5I8Omc5NGhZE4+hwzFgGcIQHOz6wfvmxNiwWqYysaJbA10Cdd+zZPAakx5vtYKHW3qxe1HRNnGkSnifFUqiRhA58m4PeyFRGI+ys4opEvsbbyTV5sGqF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(26005)(16526019)(40460700003)(7696005)(70586007)(70206006)(356005)(81166007)(54906003)(82740400003)(86362001)(36756003)(8676002)(83380400001)(426003)(47076005)(44832011)(36860700001)(336012)(6666004)(66574015)(2906002)(110136005)(478600001)(316002)(7416002)(5660300002)(4326008)(8936002)(2616005)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:08:30.1453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3aa84e-79a9-4eea-56d2-08dbe54d78ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934

pci_is_thunderbolt_attached() looks at the hierarchy of the PCIe device
to determine if any bridge along the way has the is_thunderbolt bit set.
This bit will only be set when one of the devices in the hierarchy is an
Intel Thunderbolt device.

However PCIe devices can be connected to USB4 hubs and routers which won't
necessarily set the is_thunderbolt bit. These devices will however be
marked as externally facing which means they are marked removable by
pci_set_removable().

Look whether the device is marked removable to determine it's
connected to a Thunderbolt controller or USB4 router.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Update commit message
---
 drivers/gpu/drm/nouveau/nouveau_vga.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
index f8bf0ec26844..14215b7ca187 100644
--- a/drivers/gpu/drm/nouveau/nouveau_vga.c
+++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
@@ -94,8 +94,8 @@ nouveau_vga_init(struct nouveau_drm *drm)
 
 	vga_client_register(pdev, nouveau_vga_set_decode);
 
-	/* don't register Thunderbolt eGPU with vga_switcheroo */
-	if (pci_is_thunderbolt_attached(pdev))
+	/* don't register USB4/Thunderbolt eGPU with vga_switcheroo */
+	if (dev_is_removable(&pdev->dev))
 		return;
 
 	vga_switcheroo_register_client(pdev, &nouveau_switcheroo_ops, runtime);
@@ -118,7 +118,7 @@ nouveau_vga_fini(struct nouveau_drm *drm)
 
 	vga_client_unregister(pdev);
 
-	if (pci_is_thunderbolt_attached(pdev))
+	if (dev_is_removable(&pdev->dev))
 		return;
 
 	vga_switcheroo_unregister_client(pdev);
-- 
2.34.1


