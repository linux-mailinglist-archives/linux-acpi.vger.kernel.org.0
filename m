Return-Path: <linux-acpi+bounces-1206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614897E0A58
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 21:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83707280E85
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22B23745
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Nov 2023 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BRkffatP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88B224F2;
	Fri,  3 Nov 2023 19:08:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DE7D4D;
	Fri,  3 Nov 2023 12:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqnbDEA7K+aFT6czuR4GnFxUWkdO9uZllJNz7WirK41WFLzRv/mqzd9iVAtFhr4JtahU5YazaRvIFTG0k7lYxtigbol0YYGx9kglDMahuAMehov5qTXE6Ym4i56KB9bE6WZVGdFAQSdCGJ4B7r1T/na7evFPBoSUhnaSAs2OA+iwN4+OgzFWX9UL56Peju/sOsVkQ//JrNP3Z3Z6y/yfugn+2AQrOaotGM/FwNgRbh00VrcenRc40peUZBHxoGybBVPmLO9HGr3aboLXNOr0RJMO7EeZYUVGFFCE0mRei2qS1opoJX22A5uNH46gWhgPaFy4uVhFowQoqCB6q/9Hdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1mFvWxxG1gDlJsQRp+1hd6XhnFf+gocwVTPX9COVag=;
 b=M/uoFTglDFULUwOzkU09wueaEH1OdgmeDyIfZ+Kh1YHYKnkjCzKWr5iMzFe/IsCKAMfVyooydvnWl7V6Kj3oqjJGenBlyZjpj3iKOBuj1pZQeIqDQ8u4jmNBnuDAtaRWhhmnHxgEAoh6LvuSXgG70bLDDOZtMPqpHyyz7hzXdbIFxFrb68n3mrtVXjX8uGWpRZRx346dRtaUt8vrMXMcLiMAR00sL6hiSVjkJDYWVYke0UY4Era7X2YYpSdUagnDzupNgqYcdvvP0G/38GMlfxXGxa4t6z4IxogULJIFQkfyxZWimLj/NfOyPny9yjRI+xZvVQZFHyY2TSZ6ReNoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1mFvWxxG1gDlJsQRp+1hd6XhnFf+gocwVTPX9COVag=;
 b=BRkffatP26p3xAQ+o2EW4kuF0OVeaX6c+Jx9pl3g9xrEU9udxXTxxLee2iSQsnkzrDBQqBjRsaqcVs6WLVoSF1lTU75XuaDRSAqRHcaspZWDY4OpaBivmSMXp1k7bI1IBHNVv3r7vfg1NCfCKBmYMz9MggPm+FUPraQvn75XKOE=
Received: from MW4P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::34)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 19:08:22 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::85) by MW4P221CA0029.outlook.office365.com
 (2603:10b6:303:8b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 19:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 19:08:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 14:08:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Hans de
 Goede" <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
CC: Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Xinhui Pan <Xinhui.Pan@amd.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Mark Gross <markgross@kernel.org>, "Andreas
 Noever" <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, "Maciej
 W . Rozycki" <macro@orcam.me.uk>, Manivannan Sadhasivam <mani@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, "open list:DRM DRIVER FOR
 NVIDIA GEFORCE/QUADRO GPUS" <dri-devel@lists.freedesktop.org>, "open list:DRM
 DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, "open
 list" <linux-kernel@vger.kernel.org>, "open list:RADEON and AMDGPU DRM
 DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:PCI SUBSYSTEM"
	<linux-pci@vger.kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, "open
 list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: [PATCH v2 0/9] Improvements to pcie_bandwidth_available() for eGPUs
Date: Fri, 3 Nov 2023 14:07:49 -0500
Message-ID: <20231103190758.82911-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f6751c-6262-4a03-0cb4-08dbdca03f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gIUwtuiwRHSSxYI/2JfiMZ4O2VMiaEcxqYwqOw8zDk575QDZaPfQ+BvZWx8vvVuSsqpf3+FWZdrSI9tlgon47OH9oUI9p1kcU766+VQRq72lKAEt6VSK30OqIBKqdK6SlmsvE2ESo6cl0zhfgUtRyxvpaIPkQTw6XvxDIu4KLh2gXPoasjTOtyk6TsXUM2fpzOUO0QCU0/zdUJgKupZoCV1vxdB8KdB1RLC8kjytu7dYBkccilXY/5YbU3oPQKCRZwmbyxsDwIdAncPiihhpVnalzhw7cn9aHm1TlETsZ0W5txkPWz8Xjf9aC+/ucUuvvSxUby4zbfUIF35QcC6Uo/1WVMINQwulMQKmF+j81Df72FrloheE7ZsXcAj1hh4AYjZ6/U+8befnrvuOe1bdvFu0cmNEqiasE67YPcGeU4Bmk78I0N37sjrPj8Di7wMy6IgJsIeN4aRhX9HJXshuWmzRXkanhaBAVXosHkY5C2jCJvBohm1zONpPOhRWIB9zVX41vbIfpmSJfKkXb5OnILr1jFVtzzLqNGKkim44ObFmazl8CjoSBm67eajEBA+E6Jw1M4gsnggNFm4dRmZMaTbQNLl8dSeTagyAEpPpZXMqc+j9tFpMG8EgdqBLXuEzrNNMiZs2UriGE88lUErU8uLpCPNGwy8BXTd56uDVpRqB6mlNoSnmFuhPSGGiztUM/intx2Tx0IgFSh5FSv8f/ik4aEi5v62TYq3Aj6zqFXsLjDnGEOKszCycPmL/Tq6l
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(8676002)(70206006)(7416002)(47076005)(336012)(16526019)(26005)(1076003)(83380400001)(81166007)(426003)(356005)(36860700001)(110136005)(5660300002)(54906003)(70586007)(41300700001)(44832011)(478600001)(6666004)(4326008)(316002)(2616005)(2906002)(966005)(7696005)(8936002)(82740400003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 19:08:21.9164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f6751c-6262-4a03-0cb4-08dbdca03f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

Downstream drivers are getting the wrong values from
pcie_bandwidth_available() which is causing problems for performance
of eGPUs.

This series overhauls Thunderbolt related device detection and uses
the changes to change the behavior of pcie_bandwidth_available().

NOTE: This series is currently based on top of v6.6 + this change that
      will be merged for 6.7:
Link: https://patchwork.freedesktop.org/patch/564738/

v1->v2:
 * Rename is_thunderbolt
 * Look for _DSD instead of link
 * Drop pci_is_thunderbolt_attached() from all drivers
 * Adjust links
 * Adjust commit messages
 * Add quirk for Tiger Lake

Mario Limonciello (9):
  drm/nouveau: Switch from pci_is_thunderbolt_attached() to
    dev_is_removable()
  drm/radeon: Switch from pci_is_thunderbolt_attached() to
    dev_is_removable()
  PCI: Drop pci_is_thunderbolt_attached()
  PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
  PCI: pciehp: Move check for is_thunderbolt into a quirk
  PCI: Rename is_thunderbolt to is_tunneled
  PCI: ACPI: Detect PCIe root ports that are used for tunneling
  PCI: Exclude PCIe ports used for tunneling in
    pcie_bandwidth_available()
  PCI: Add a quirk to mark 0x8086 : 0x9a23 as supporting PCIe tunneling

 drivers/gpu/drm/nouveau/nouveau_vga.c  |  6 +-
 drivers/gpu/drm/radeon/radeon_device.c |  4 +-
 drivers/gpu/drm/radeon/radeon_kms.c    |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c       |  6 +-
 drivers/pci/pci-acpi.c                 | 16 ++++++
 drivers/pci/pci.c                      | 76 +++++++++++++++++---------
 drivers/pci/probe.c                    |  2 +-
 drivers/pci/quirks.c                   | 31 +++++++++++
 drivers/platform/x86/apple-gmux.c      |  2 +-
 drivers/thunderbolt/nhi.h              |  2 -
 include/linux/pci.h                    | 25 +--------
 include/linux/pci_ids.h                |  1 +
 12 files changed, 109 insertions(+), 64 deletions(-)

-- 
2.34.1


