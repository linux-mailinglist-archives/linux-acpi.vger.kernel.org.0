Return-Path: <linux-acpi+bounces-1481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2037EB7E7
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C29280401
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACBA2FC33
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lYTgdqqJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1135EE9
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:08:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247DA7;
	Tue, 14 Nov 2023 12:08:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACKe81I/dkv6oAfRnQjRns8TjBi4NZml7Ryxq+BdRHs7RKUOJe663EgknQRCi6t5CRv7WubdrNmc2VKQY4ZPDzBr+L328T2o2298p+Vk8jdEru0fR0Sn8Fuw/o0S2MC/3pM1x7s0L2WOvZ81pimIvs79qvsV998589qgMNec1kKrmdou3pzWVFlzfgJ6ovOTji9Isq7n2td5ZnlsCikdHgX2Ojg/keTPLeN+2BFx6VbL576ZL9BK7fh+wtaTAHOiIBamewKsj6oAw7dCt5RSPOXRbJlRLB5RKUsVFCp6lTFq/zpf9hacv8eHcZ72LSZVmL1xhPomaa2zeUrkHIBlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0uKy1Xm1rWD9Jdy+8po3LnaPS/HJN09FwRY9lmAFoI=;
 b=Kub9XDiOAakfT8iAje2X3sXke2H6BEIyaJLSzZFxLm1cnlm8lp02pUd08QQFZrtph2dY+dzBxwwK/bltgVALs+wIxc3f8E7pxyuNDv0hv9rMWZ09u//CTRGxP9iCsj9iTl+ODEO1o5lZd2vt7TpWV42fG0hPGTijXP51XjUtE/zlWMQjBJUKn2E20bk+SypyrlNLSG3lySvhcIwyl1pYhkCX2TtI/Nc/k8zZyQ4KwV09A/VWSGOCr7nJWHlWEITqWxtAaUJsp3IjsQsclv0kR3C2mX7DLN3Hop3/WJ7zJkmWhUWPf0rMLGwq7x1KhiTj8ZUG/GYyG6Gexzgpmy4+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0uKy1Xm1rWD9Jdy+8po3LnaPS/HJN09FwRY9lmAFoI=;
 b=lYTgdqqJPPT+CFZLkuFHjx9CFyl8KQj1xLoBvD0GKCkLwqgUOcjPVYjhXspIomO4KJGHWwgTUlFwcKASxU7cEYPaWcuC0/TJmmcITeiBfoBx8RTEMQJYva3T95mGp7a3cIIiGar1nXLBybyMUAyjOtj/DKqmrgON7u1hEmLXBuA=
Received: from BL1PR13CA0280.namprd13.prod.outlook.com (2603:10b6:208:2bc::15)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 20:08:29 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::f4) by BL1PR13CA0280.outlook.office365.com
 (2603:10b6:208:2bc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 20:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 20:08:29 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 14:08:27 -0600
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
Subject: [PATCH v3 0/7] Improvements to pcie_bandwidth_available() for eGPUs
Date: Tue, 14 Nov 2023 14:07:48 -0600
Message-ID: <20231114200755.14911-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 610ac2fd-a322-4f0a-d177-08dbe54d7845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eJe68kh5X0IFzbVx6LfZEbHj1T+YvcDAmMpKhXjBzcWiRCoZ0oo4zxAnRQm0Ly95fgfGVDykxoAZpYN5q/1X1fdHhQGjuAxMEBMNPSHAhIT7ZyKPg/mP9yJUFFhsUSG6n3j0d4r7bv6zEIrlt9Ytb5Axc2az+gCZLUQUVagEIGb4m/bFXpd+GPO2jlrsHIQCCEsPN+dCL2u/8rhci+D6cWVjG/GYoUCxb/NTT3Eg1swqLzfmvZCMXmkttW5NKAr9ycd0pf2Nn/JaQVPuCUInGhzrqNIPXY5I6Z3O/Q2aa33Hv7liSSqdJExq4Y+khuRagk5A1yjh3vKWby/NyATBYL/2skeGCvEHJ4C9XfEFkGhrfD2thq1opPxIETB4RADhkBw5PVgU4PpJlM4dNqog15HuWx+1Tt/1JfyB4NjoF0JTU65ee0E/xLguXDckmK2NZRNATtuAkn7l1kl01R79iQAytcD8DNCG7HqBb6TqvA5s52lPY6d8N3dq/hpKkMJhlL1X0yuFfgyBPE26a92ukFtMXmUMk9sfs64iC8TBb+pQKuyWBZTEL5YApLJuffH8bsmamyS/1ugGArpByIHw6BnezvVHi5QVAChwDVebLcz2wmE7G6xUEGHxaSxMdWT9Os+bCpJbvDuoXPLP1gsUMPUKUrLYHb6eT0e3pHoTrbhzCNL0vsEr+Oln7gDl2n3vc+XeIE+E28yQoddTaHco2kvhoBxhC+0TTMVEqYzS5+pC5ZAKMOnb8gTpAHnVJnj6ACDxzeRBFK+zMYQ/a+rM+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(7416002)(2906002)(40480700001)(44832011)(47076005)(41300700001)(5660300002)(40460700003)(36860700001)(82740400003)(36756003)(86362001)(356005)(81166007)(110136005)(6666004)(70206006)(70586007)(16526019)(26005)(54906003)(426003)(316002)(2616005)(336012)(478600001)(1076003)(8676002)(83380400001)(4326008)(8936002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:08:29.4734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610ac2fd-a322-4f0a-d177-08dbe54d7845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211

The wrong values are reported from pcie_bandwidth_available() which
can cause problems for performance of eGPUs.

This series overhauls Thunderbolt related device detection and uses
the changes to change the behavior of pcie_bandwidth_available().

v2->v3:
 * Stop lumping all thunderbolt VSEC and USB4 devices together, introduce
   is_virtual_link instead
 * Drop unnecessary patches

Mario Limonciello (7):
  drm/nouveau: Switch from pci_is_thunderbolt_attached() to
    dev_is_removable()
  drm/radeon: Switch from pci_is_thunderbolt_attached() to
    dev_is_removable()
  PCI: Drop pci_is_thunderbolt_attached()
  PCI: pciehp: Move check for is_thunderbolt into a quirk
  PCI: ACPI: Detect PCIe root ports that are used for tunneling
  PCI: Split up some logic in pcie_bandwidth_available() to separate
    function
  PCI: Exclude PCIe ports used for virtual links in
    pcie_bandwidth_available()

 drivers/gpu/drm/nouveau/nouveau_vga.c  |  6 +-
 drivers/gpu/drm/radeon/radeon_device.c |  4 +-
 drivers/gpu/drm/radeon/radeon_kms.c    |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c       |  6 +-
 drivers/pci/pci-acpi.c                 | 16 ++++++
 drivers/pci/pci.c                      | 77 +++++++++++++++++---------
 drivers/pci/quirks.c                   | 20 +++++++
 include/linux/pci.h                    | 24 +-------
 8 files changed, 97 insertions(+), 58 deletions(-)

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.34.1


