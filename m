Return-Path: <linux-acpi+bounces-1488-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F617EB7F2
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 21:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20438B20910
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B352FC2B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Nov 2023 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m4gWFlrW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060635EF5
	for <linux-acpi@vger.kernel.org>; Tue, 14 Nov 2023 20:08:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C2132;
	Tue, 14 Nov 2023 12:08:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/hfy5NfHD7sAMP/irV7tQQoDswq5E8nLa8kaZfJonOJGKTN87NVSmBtRoY33OHAcBfQ/TSn2fb/2AXXCYGU0rkAwkv97s2UgThI4a022Yjnv+EE+KeUUtRbTm5+4C2LFVawZDa2r6PN+r6mMqyy6lyE4EEsEgmpLY8Tc+0fkoGu66TfvP3fYC5AlYZKRXFnlki7Rh2k8QZH9WrqvqkXN1LXgZAEKqo9H4khrWEekeyRcG0gwhTu8E8xMLA4ZU+sT/JtM3RWQQuiKbUagFQKZfdYWqeJY7iQ5DIkS5WIRRM0MADt4vk1hPHizewFbxnk2E3hvKIcyuJtfcEETbr40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGQJ2s9aczHwLlKwGw5MbAsL0y0CXVt2bqkXEOEvYPE=;
 b=I9x3QWCO6J/SOwGWsHRigxPqstIyqyC/ZUaU8zaF6rlK/4NOQc1ldlXmqHGX3rQ8gKPVJGpMir+3F5eu21tERAomS3RSuVGm7Lc93g5v8ZFtmTrrXOET2Qy8q5H+IxSJQ1lTiGOPnBr3h8vcIQeGfj4UOEr7iGv2aBKA7PdBkZm6iSVR7PH4SUGENbMlv3Ah9I5y1NPMjnGAX3cYVos4hRcgrbIK9GCxb5kdHMhw4ttH6bS71WqQENEloXAJ7fIH8RZEOmx8kjOMzxQXN4wVJefCYy9zxdNz8Xqh5RpA8WnI0eba4yvxYA03vzIq7NAj2mbGzRnuwzIuZbR9lAav1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGQJ2s9aczHwLlKwGw5MbAsL0y0CXVt2bqkXEOEvYPE=;
 b=m4gWFlrWMMUv9/vnDDQkKzY5AzbWqD0gn4E1bF2n/ry8zz0Q8JtB5FhvyPN+6/sek7PgEoZtTx9GVgfva8IvhUR//F2hWzxrGWJuNpX1/GzH+/P0D1FQA8d0cUhdPcHIY2SC2KtCvtOPLwrn6BQvT2vdL58ZwxxBUq3B22r1bpY=
Received: from BLAPR03CA0156.namprd03.prod.outlook.com (2603:10b6:208:32f::29)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 20:08:38 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::36) by BLAPR03CA0156.outlook.office365.com
 (2603:10b6:208:32f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 20:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 20:08:38 +0000
Received: from test-TBI1100B.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 14 Nov
 2023 14:08:36 -0600
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
Subject: [PATCH v3 7/7] PCI: Exclude PCIe ports used for virtual links in pcie_bandwidth_available()
Date: Tue, 14 Nov 2023 14:07:55 -0600
Message-ID: <20231114200755.14911-8-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 48817130-7df4-4be1-d229-08dbe54d7d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qAEcpAVAXE9PXfFweQl4igx5vpKZd0ofDnpX0YV1pNSqDaCySAQp0y9Ur4zDYhUM7tStS82ffe2XSKYoRwoEIINxzyMpFVwKs0yLdlmwzfRNcPwzsOhxT85sXtEQvdLYd0qK2l9iZYlpc2IRalPaJEQVv8xREhLaEIH2SzPr4Fmm4q+ET0jHerwQYmJ4EoWWlg+Y3KTSOumnC6Drw5XEeRZIvdjLQ2bTWsCBmxE9O0FiPTJWiA8dkor06HXQ/i7+eAyVviuGONqmAb0lzkAKbkqOqF9UOh5IBdWTSZRDpMjoFy6UmTtru2kno/pLYoO4tjaibjmVEjqFezgEi3XfAuSOg6DAaE+rbzhdV3SLEQwLWK7r4mc8XUuaufDF+xzZeUDAP0DXkbYxXTCjsJsubCvpxECHhC78dC0Q2ufhNzGdnZ3MOwol4/UZa3p8vSIDftwOVCGtHgetLPGij0XsayxntsEHge0JbJgkz19oFxeCj3Qaml3BzeW+nIvyrSgrvLbCQjRtfDZzZ3o13uDC9BTwWFwrx/L+++MkSFkTm9F6xI2YGf0P6+vFFNR6tcEO3rOqrXEsLenzBVLHEdtHoJFwSQlh1ukOiN5fXQnEb+r+mJaYnvxhlODakorZkF2v/A+LSLZBpDvnZhhpre5JUI6w0Uxpc72KJSUsM8YwkRjKSoqkmFwKAEn+KnUFBcaS0dPvQzomDp/QRCcBip1HPwCQvr3wg3B+Q4NmCNp8OVe13S3KoFkRjJ+K6gfgC063
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(36860700001)(966005)(86362001)(36756003)(70586007)(70206006)(110136005)(316002)(54906003)(356005)(81166007)(478600001)(82740400003)(1076003)(2616005)(5660300002)(7416002)(2906002)(26005)(16526019)(7696005)(44832011)(6666004)(47076005)(426003)(336012)(8936002)(4326008)(8676002)(83380400001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:08:38.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48817130-7df4-4be1-d229-08dbe54d7d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275

The USB4 spec specifies that PCIe ports that are used for tunneling
PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s and
behave as a PCIe Gen1 device. The actual performance of these ports is
controlled by the fabric implementation.

Callers for pcie_bandwidth_available() will always find the PCIe ports
used for tunneling as a limiting factor potentially leading to incorrect
performance decisions.

To prevent such problems check explicitly for ports that are marked as
virtual links or as thunderbolt controllers and skip them when looking
for bandwidth limitations of the hierarchy. If the only device connected
is a port used for tunneling then report that device.

Callers to pcie_bandwidth_available() could make this change on their
own as well but then they wouldn't be able to detect other potential
speed bottlenecks from the hierarchy without duplicating
pcie_bandwidth_available() logic.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925#note_2145860
Link: https://www.usb.org/document-library/usb4r-specification-v20
      USB4 V2 with Errata and ECN through June 2023
      Section 11.2.1
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Split from previous patch version
 * Look for thunderbolt or virtual link
---
 drivers/pci/pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0ff7883cc774..b1fb2258b211 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6269,11 +6269,20 @@ static u32 pcie_calc_bw_limits(struct pci_dev *dev, u32 bw,
  * limiting_dev, speed, and width pointers are supplied) information about
  * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
  * raw bandwidth.
+ *
+ * This excludes the bandwidth calculation that has been returned from a
+ * PCIe device that is used for transmitting tunneled PCIe traffic over a virtual
+ * link part of larger hierarchy. Examples include Thunderbolt3 and USB4 links.
+ * The calculation is excluded because the USB4 specification specifies that the
+ * max speed returned from PCIe configuration registers for the tunneling link is
+ * always PCI 1x 2.5 GT/s.  When only tunneled devices are present, the bandwidth
+ * returned is the bandwidth available from the first tunneled device.
  */
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width)
 {
+	struct pci_dev *vdev = NULL;
 	u32 bw = 0;
 
 	if (speed)
@@ -6282,10 +6291,20 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 		*width = PCIE_LNK_WIDTH_UNKNOWN;
 
 	while (dev) {
+		if (dev->is_virtual_link || dev->is_thunderbolt) {
+			if (!vdev)
+				vdev = dev;
+			goto skip;
+		}
 		bw = pcie_calc_bw_limits(dev, bw, limiting_dev, speed, width);
+skip:
 		dev = pci_upstream_bridge(dev);
 	}
 
+	/* If nothing "faster" found on hierarchy, limit to first virtual link */
+	if (vdev && !bw)
+		bw = pcie_calc_bw_limits(vdev, bw, limiting_dev, speed, width);
+
 	return bw;
 }
 EXPORT_SYMBOL(pcie_bandwidth_available);
-- 
2.34.1


