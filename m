Return-Path: <linux-acpi+bounces-1487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080FA7EB7F1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E73B2051F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6232FC30
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mcOGpZwC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0784D35EF0
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:08:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF3124;
	Tue, 14 Nov 2023 12:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLFqqwBliHfL5CRK424gmlMBxUetwKos43G+9Gk2pOKiEzjbT8RjRaWQfLL7y1SXkkBdgFp6Qu6fIH91r0SBo2K6fVySdbL1sNLBeNEnXz6G3vmwPYXYmD0RSgidek8KqExpbcpEV5SEvZ05r0uquR5u21hnqhRVaNatrZAYzaYarfdMOWbq7fNkJHiTAbEKd7BA7omebk5uTnT3t2YLOl70TUeEZ7GDLoE2G3kRQJ4bAaOYMLDD+1CPbcaVfbWKWFhx9nOxe/cEOU97hg48dc9WIP4qsGj3P/O6fsR5wJjuz2OQEP5gDudka/ZLkeF5C2iQwxK35rLkYfRe587EDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJzGKPDUmP7pviUBNdyibSeuU9WM7t2twfOHK0K1rUY=;
 b=fDc/P8+CuBXwMv71paD72ag+YpsWPzdBLk2ISG3YX2YuNUmJUpLmpqijduxwWg1cvLgo4+RxtObpQZaAABweP4CSl45Ba4osMVGGoqpGijP5zoTd4FNWbBVmYUxFdk8Y92YDlL5IXfwFBa7N+zbrCbqu7ix0jZmpDBgCFKr0PhrzgulZ9x6G9L2uePrBG1cPSYcn4ayQnmj7r9lfnrKeH/+m+7LGAf2BsaOgZRunOsUtphvWs8yXLwwSYNWKkohGC9Ti1RVwB+57qi/omKcrvB7cF0fLQ/Y6k8cnet1ycKkuuISvBNSHiTom6sVLA8jmdJWnrRWIxkcOgM+gcB1VDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJzGKPDUmP7pviUBNdyibSeuU9WM7t2twfOHK0K1rUY=;
 b=mcOGpZwCtYx/uY9lW5p07eYdz1td1/xiFRpHXFv7XL26c9z6BoPRPcUKI1XnUODuGym9XVy/eHDLKRV2sTFxAwgxYNxlk4ejN2YGouIP7R6AxwIJj+BP78LYE9hjA1Axzyc20ZvYYvrrRHB7ZyPgJNGhjd5q5A7AhHHcg944ocw=
Received: from BLAPR03CA0153.namprd03.prod.outlook.com (2603:10b6:208:32f::19)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 20:08:34 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::87) by BLAPR03CA0153.outlook.office365.com
 (2603:10b6:208:32f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 20:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 20:08:34 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 14:08:32 -0600
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
Subject: [PATCH v3 4/7] PCI: pciehp: Move check for is_thunderbolt into a quirk
Date: Tue, 14 Nov 2023 14:07:52 -0600
Message-ID: <20231114200755.14911-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abb656f-3e41-40b1-15e6-08dbe54d7b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jMOIA6xYltxfdXkxdG8T5SNQSet4XxKcJUYea9nqU/AGmbdBm/3l0O9MOhguF4Jye6V9bSgAp55xqDHW2vyRgJ44UnWcb5yOa5lXWDQPsKqo+Qn5Eb/8ewCg65MwtveWRvu1KPDaSqGQp1CdXDwZ5OkQcLg8dA0xe3Pv4w1uNHvu8KADEYRIJ/nm6oUjFn4LcgJWUpxxwGvQfM/jnuUksw2ejUE6EZbdzPk7c14ClOUIT/SZdB8GMhW0hyQl4nSSF1/8McopxnTBtObagCAv/EJsIE6bqJe2by+DhWkp0YvE7xy5gjp1cZCubyvtElaYblAkGPo9tksJuw6cYgIlxt2WXHNnqOXIqyMlZSPq6jM84wfPQpoE6UA+QLVYswFHt6WcJun31oFAaZuvrQZJr2vj+Xihwig0NvVWCtkB//HkvXe6JNyG8lxiLmUS5OaRX3llwusJNYH0bmT2McMW7go2jRcdQ1YUtsQpGxX1wZIVJw1BjiL2xgVjjc8p0t4aCKVKM+ed7R29gb1D+MWc+kze9YtXSwvIbPisE75k/Apj7kl6kzOYZfoAj7g/ymWMWWEepxI6IlYfiRlWtdvtsKH+nZppsKsFO9PzGaGmhF1/zfmd5aWw+1mcDBQ0tSF3WpZXjcRFHEjIZ6CK+vYsrsg25mqT1028Qxh6NX/NTpOTJQOTeBjEYiNQNAxJ1XsSi6TEy++8jj2FaMs0h71hVZYzIm5elxX4/fbmmzX6nmLey/bviK53zmIpvN0/4cV/U8BH4GT3sWSeq943r85igA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(41300700001)(54906003)(70586007)(70206006)(86362001)(110136005)(36756003)(356005)(81166007)(82740400003)(478600001)(16526019)(26005)(1076003)(336012)(6666004)(2906002)(426003)(7696005)(7416002)(2616005)(5660300002)(83380400001)(40480700001)(44832011)(316002)(47076005)(4326008)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:08:34.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abb656f-3e41-40b1-15e6-08dbe54d7b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

commit 493fb50e958c ("PCI: pciehp: Assume NoCompl+ for Thunderbolt
ports") added a check into pciehp code to explicitly set NoCompl+
for all Intel Thunderbolt controllers, including those that don't
need it.

This overloaded the purpose of the `is_thunderbolt` member of
`struct pci_device` because that means that any controller that
identifies as thunderbolt would set NoCompl+ even if it doesn't
suffer this deficiency. As that commit helpfully specifies all the
controllers with the problem, move them into a PCI quirk.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Reword commit message
 * Update comments
---
 drivers/pci/hotplug/pciehp_hpc.c |  6 +-----
 drivers/pci/quirks.c             | 20 ++++++++++++++++++++
 include/linux/pci.h              |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3917d..40f7a26fb98f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -992,11 +992,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (pdev->hotplug_user_indicators)
 		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
 
-	/*
-	 * We assume no Thunderbolt controllers support Command Complete events,
-	 * but some controllers falsely claim they do.
-	 */
-	if (pdev->is_thunderbolt)
+	if (pdev->no_command_complete)
 		slot_cap |= PCI_EXP_SLTCAP_NCCS;
 
 	ctrl->slot_cap = slot_cap;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..fa9b82cd7b3b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3809,6 +3809,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
 			quirk_thunderbolt_hotplug_msi);
 
+/*
+ * Certain Thunderbolt 1 controllers falsely claim to support Command
+ * Completed events.
+ */
+static void quirk_thunderbolt_command_complete(struct pci_dev *pdev)
+{
+	pdev->no_command_complete = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
+			quirk_thunderbolt_command_complete);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EAGLE_RIDGE,
+			quirk_thunderbolt_command_complete);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LIGHT_PEAK,
+			quirk_thunderbolt_command_complete);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
+			quirk_thunderbolt_command_complete);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_2C,
+			quirk_thunderbolt_command_complete);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PORT_RIDGE,
+			quirk_thunderbolt_command_complete);
 #ifdef CONFIG_ACPI
 /*
  * Apple: Shutdown Cactus Ridge Thunderbolt controller.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1fbca2bd92e8..20a6e4fc3060 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -441,6 +441,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	no_command_complete:1;	/* No command completion */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
-- 
2.34.1


