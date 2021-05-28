Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D339458A
	for <lists+linux-acpi@lfdr.de>; Fri, 28 May 2021 18:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhE1QEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 May 2021 12:04:20 -0400
Received: from mail-bn1nam07on2071.outbound.protection.outlook.com ([40.107.212.71]:31205
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229608AbhE1QEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 May 2021 12:04:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaE1lqP/D89rh74b6hwC0m85o09y6TQf+We5vt7f3X1F378DVQRkcM76t9vb1nTsadSqOchwvvNukAYzK9HHt2aJcfx8XV2x8oSMGrIKL3mfn9Fr/SYpvtBkj10xTkTdhJju2guCLLMlovJN6tkuJsoKYnIWmC9eS75t4W3IzAFNeVGLpbOt6hCbTivtz2gOecf1oaSfWzcBZJK5aD1u9A4qUByuXJg1NpPaVFW+6jU3Dcbr292BngogFMxeIYnL8p7IAaDiOjLF47uhwKc0JzZ4ZCNoOTGyzMi0uYECw6P1/67Oor6zWC9eQR6qhKdmjkX5wUlXzlk+lXiYcVEoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXpKy8pT5Bx8wKuxpeXDWexX/6t0wJQJvf2oJNghKOw=;
 b=CtgbR98ChLhOvhzisqUUJYhZiiL3YL9wXksnx90qjoE/1S8sskzP28zxPJgmBxdNv/UI/fAjkgw68KMYNrh8yzdPVt8w9JBOX4ewHCoqZv4qsVa5m7u/wvBMrPaEVFuy+cNTRuHP/+Bu1wVlbopwDsVWqhWMCEx71xEzAHmY5QIszv65j66Gd8aKZGDQeccT2ul1Exxe6nXjXOV1mnflxDa9U0ugin8FLSRw0knEonoK6lNE6M+lVym5MX6VTnlRrx9FMr3d9qguCNWlTbQv0NzZhrNsb8FpHuFKgXTKSemQvONKSnciiHfYIb3Jj3j3sl5xgEacpGN8mWPGhnaecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXpKy8pT5Bx8wKuxpeXDWexX/6t0wJQJvf2oJNghKOw=;
 b=rYPoEkDcAbm6Fx31TcjyH33N96Zkidznms8FMMVoEU9MP05oBQp+yG/3h6fAdEBEvbVIVHu3KB9r/hAQIUXPmgsvpJ3UQzJ1ByG2CMYsmqMn1zs0IqTLVn1hXIlMPe7jjvoCqG+85VipgdGFC3Ax3E0SFOsxaICG57AlR4IewFk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 16:02:39 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.032; Fri, 28 May 2021
 16:02:39 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Liang Prike <Prike.Liang@amd.com>
Subject: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI device instead
Date:   Fri, 28 May 2021 11:02:34 -0500
Message-Id: <20210528160234.9402-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN4PR0501CA0155.namprd05.prod.outlook.com
 (2603:10b6:803:2c::33) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN4PR0501CA0155.namprd05.prod.outlook.com (2603:10b6:803:2c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Fri, 28 May 2021 16:02:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca08f4a9-7884-4a22-bd40-08d921f20434
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4902B190985620BDE6426E70E2229@BY5PR12MB4902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPC/7ZZ9W1tcv1j0pIahSgU8NOXDbwtQ7Y//3sxEVh+ddPIoIeD/2ss8yRanVwdO6hRegF7GhWuuy1yZi72LdU9Zcx3LIvQeDbtqTOdS3uLtFI7lo+3GPnokxEDk4SuhuHzKvKDfXPfXt34ObTwUUuxCVrH1StMpf+S8jxaiehr13kTlsHrVpL6y32oH/c7vPtFiuzmc2a9l5VVtPIQwZ/9yuF2HsZrfHuKa+fFhH2toGiowYXAvErgVuYjHZf2SjgOMD4RQ5nMo22U+nQOLSzNaCf+2cobgof0duvmScf2em433yzMb2vlUEfToaQUQjdzbhNxrN/GqOeDqCh5FGXjpaxXtkOxEltLV8BvIai7aZasPvq68FYS4HJrDpLHaUnjV5QmUf4R447dKEPvPwqIC9HZuELC/nCRRDam9UwdCaCk1ds2RGFzhJSecKzPCZAKVMIbvC0Pd+PsPw5onseQ2eetD3GIeIjJGfIViUUhA2mEBXiU724RtU6inyZvjeED7lhx5EWdrYn9Aa5sNOYa7+mAEYHD23hJceCSiEHp5k0VwhO5zpFP27+qwXZI5U53EQ6LPROj50vF3yo3z/ByucTRiyjRvHyTloszgRs/znun+YThlY7UuUEL46PHN9n0sSJLJxaUVnRqAZAQ1LmBRT6M3wu/hJw6gnhCo6fg/zQ8y37btvMFkntyZOn6CdaU7ECi19OGl9uUVDf77CGPuCZCBPikubDttE83Ybms+OaR8kbFhcpQt3RnOLoa893BOvrR95OWGCMxiHgM9lYsYBr2RFOxpR17XpT6DohZCgepgoGDNaZ18uDoq1t2D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(2906002)(110136005)(86362001)(186003)(5660300002)(16526019)(26005)(316002)(54906003)(966005)(2616005)(1076003)(6486002)(956004)(44832011)(66556008)(478600001)(83380400001)(38100700002)(38350700002)(66476007)(66946007)(8936002)(4326008)(6666004)(8676002)(7696005)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?er6tmKshT0muZMa/qIIltqB4HaShC9LYYlZQJ+yPdYVWoU9wKK/3kGSJ8Cj1?=
 =?us-ascii?Q?rtT2bb1Pr8OLnW0MTAfzbgNphbIuSv003ZJpbP78kkzBMd/rkOvn+3nhboIb?=
 =?us-ascii?Q?iko4Ex/3Ft6e+qoS5bxmW/v3K5/C1lUEWYvQlyP2Roerz3MwHzCKDMUxGlwZ?=
 =?us-ascii?Q?R+E0xN8/ZXuc+8n8STrtC6b6/aQOgK5Wsez9nVgVS6I8crCbZtahM7XDUos6?=
 =?us-ascii?Q?+j/V93bI6MBvU8Oagt3EV4Tgde3uW5BsqMimIspM/gUmHwr2GBzit9MbJoeT?=
 =?us-ascii?Q?6EKj3hdr2hrkXzxRHxSjBVPUUacD/eT/jL9XW0vMiURNToD8nzGSr+1im3QL?=
 =?us-ascii?Q?6cvEcjnrF0D8MzZOTfGi+rm7K9OxUuzmSrahvCGgIK6lw+w80kNh8cFllLgr?=
 =?us-ascii?Q?bXMmhVVdD3mkFUjD6eO7TBOVhZ2k6frnMEemzHO2WAggIHx8J642MJaTWved?=
 =?us-ascii?Q?gqYuSlwLohQltQ7YcXwhWs+gzilO5qmTEcApJRb+njPKyNaRAnL0J8Uer7Ec?=
 =?us-ascii?Q?aBYunoyeGOJ8nEMnUTRPyznsuObjTZq7r98CR30LUgb8TRqtR+mkcsrk3pzw?=
 =?us-ascii?Q?6BvSTj1CCQ4ofuFjBLGoUk8PrI/AwUa/kcGolspc0fwNCDW6fhnlWmtQe5IJ?=
 =?us-ascii?Q?hmssy5a6JXqo+QaJ2AzANzGdsyvkGStnk3JbVSYKKzU4DyIlEK97lpnYpKcJ?=
 =?us-ascii?Q?wnRPnVGQLgr3gWA71c0Wd88cHF1JlblGVxfKWgaXjNfHCd8IW+zYERTkXQ/c?=
 =?us-ascii?Q?Niu4OeOs+G5iXq+KYzX5+hRFAvAzSebNtFSEJcD01ocLSTCXG89uV+qDYKw6?=
 =?us-ascii?Q?EirSFBMuIcgHe0oC9sZUrk1kWGKHoZogq7fLG4Md09tbQXKjKz09o4IKNZKX?=
 =?us-ascii?Q?W0I8FZ9qiXHbnW+W40MvTcLKJgMIDkpLCdvr2C4y9Z9oz4KcC0QHyhS/I822?=
 =?us-ascii?Q?4SHZ9+mDxg5J93VjJM+ZhyrVVuu0TozgQmhbJnH2eL2qH4QGx3cd8MWbR1x2?=
 =?us-ascii?Q?KiYgpPi8FTPAfz+pIkbWFNgY6Bk/LKKTwXKxu+Gj0IGcthcmyJ/hqpUO16di?=
 =?us-ascii?Q?psnHBUIFHo5ZgpbKRZ1bkrEaCiT5COTvbSuxaM9igJQbz3TpzLslf0Ul7BtP?=
 =?us-ascii?Q?6UOhiRY8eH6dJKY1wSyZo4cP19FXiCg8LdpesZx8Sh/yivGXQx3gK6cesqDe?=
 =?us-ascii?Q?Ssogni1Z1gxoiR9EN9/7OY12LYotLnBWLbIM4zy6/ypIOXeSWlBZ4moa87dp?=
 =?us-ascii?Q?k8cynbSAQ+9QHR26vvx3orifztLbgq6Yh58vixTfD+d0D9tE2vxDfHPDQUwy?=
 =?us-ascii?Q?MyQeI83VVkhRI1/OhVQk+dSg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca08f4a9-7884-4a22-bd40-08d921f20434
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 16:02:38.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGBFBIqjWmV8r7pOq51ncTabM5wkl0o4Rv/3UOjn2ClpAklGxfi+XhE1ZPFmFQx0bB6n9/TYdukQBt3TA/lA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The documentation around the StorageD3Enable property hints that it
should be made on the PCI device.  This is where newer AMD systems set
the property and it's required for S0i3 support.

So rather than look for nodes of the root port only present on Intel
systems, switch to the companion ACPI device for all systems.
David Box from Intel indicated this should work on Intel as well.

Link: https://lore.kernel.org/linux-nvme/YK6gmAWqaRmvpJXb@google.com/T/#m900552229fa455867ee29c33b854845fce80ba70
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Liang Prike <Prike.Liang@amd.com>
Acked-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/pci.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

Changes from v1->v2:
 * Drop the old PXSX/PEGP logic instead of supplement to it
 * Add references to other discussions on this topic
Changes from v2->v3:
 * Initialize variable at beginning of function

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..3aa7245a505f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2831,10 +2831,7 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 #ifdef CONFIG_ACPI
 static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 {
-	struct acpi_device *adev;
-	struct pci_dev *root;
-	acpi_handle handle;
-	acpi_status status;
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 	u8 val;
 
 	/*
@@ -2842,28 +2839,9 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	 * must use D3 to support deep platform power savings during
 	 * suspend-to-idle.
 	 */
-	root = pcie_find_root_port(dev);
-	if (!root)
-		return false;
 
-	adev = ACPI_COMPANION(&root->dev);
 	if (!adev)
 		return false;
-
-	/*
-	 * The property is defined in the PXSX device for South complex ports
-	 * and in the PEGP device for North complex ports.
-	 */
-	status = acpi_get_handle(adev->handle, "PXSX", &handle);
-	if (ACPI_FAILURE(status)) {
-		status = acpi_get_handle(adev->handle, "PEGP", &handle);
-		if (ACPI_FAILURE(status))
-			return false;
-	}
-
-	if (acpi_bus_get_device(handle, &adev))
-		return false;
-
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
 			&val))
 		return false;
-- 
2.25.1

