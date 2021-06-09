Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579E13A1CE2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhFISmZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 14:42:25 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:43969
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhFISmX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Jun 2021 14:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcR3dXe5G9QnRqtuuk1Kel0uwG9qAYS7Yu2iBns/e+OVJaiM8ZRBNPDifRsQX5DGoh2wqJShsQMrzTA2eSWt3jOtbODBDYmrVbAgsae2v1Z8OipekxL2urAYYvboNXIuOEkw7qjDnQhny55XUvp1AbS8KgEgZWQ5P6VK3tR7/Xj5S2Q98DnZtANS/NQp+NWpyHMuEITLTX2h+ZpSBrD9abAH6aPJTDpp6U765aUnFL0aFn6SsZyHdvT5/C0xy+gHe6yU4UU/tsbOSERbPw84rbHb0wG7sf3HuHAJt2uLzcy8bDA40K/YBkXa4sHJ0F9GEXxoy1naG/u1+dyFadJ3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+zzckDZxGaw/DdS4Grb9AIl1c6pRPUbfIZ4++psXfU=;
 b=I83QFxCghKoKWHF8IC+HrfWCi0ZNoACuNKwAFmTarHmovCYgh8mYlhHTJ5FA1X4MeljAOwcmfxICRrQFTN5nXdyZASOX9t1FRRNRn8caI9r1Qa4amIEHzz216hfU1PpDKIMzD+gc2LZlajR7aJyeWnU6PdEB6vSxSOeIVlyhZ94q1mvTyOKn46CeyICGg4vTAgD9txRfsWERWKw3pT9yah14t2le9yXu437RL375jtpxNDMIw8pM9L5ijuWVcyK/VHzQTRah2vFzNlH2MEiqY0fMU06nltxO0N9dIM/xBKSBhd+vgtoZ6hLfx1TPxAFkCMQP6PVogT/71MlChyJzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+zzckDZxGaw/DdS4Grb9AIl1c6pRPUbfIZ4++psXfU=;
 b=eadoUn1rx9Wel1ps0LCNE419qP/exhuL//jl+XO9WxnGFuWcw5rHluRK1NDnh5llUIuZqhsSqK3f0Esvz0MAgw9CC87tokzXeDpm7hf0LnLoC69gRLEw//n5Jh4zuZJ3Nas2NTwomnW+tWmHIaPQs7glj4woMqSUHZq9IUDvCAE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Wed, 9 Jun
 2021 18:40:26 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 18:40:26 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Julian Sikorski <belegdol@gmail.com>
Subject: [PATCH v8 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint
Date:   Wed,  9 Jun 2021 13:40:18 -0500
Message-Id: <20210609184018.26017-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609184018.26017-1-mario.limonciello@amd.com>
References: <20210609184018.26017-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (165.204.78.25) by SA9PR13CA0168.namprd13.prod.outlook.com (2603:10b6:806:28::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 9 Jun 2021 18:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a2c0ba-a958-4837-190c-08d92b760c8a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB278147D0B998E880925F4942E2369@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OM/DsM81ed44BLm00AB1tqH0W6AVHDaFEIzxEbiEfZNTrOIiMls0L2wvhMwb+7qp2mlfGI/c1um9WXNi3oNtvJOtFTTG9hpMP6ngeIbcMAxZoZtHUy9l9DsOYC5T2Kf9TCKrmwxW1BvWlZb4ER/0UoW0R6MOaqZEWDjYZnnBSPg6p+W6dGteoKUm+1Cj6KfVna5UTFZSzPBJTG9qBKHOru4C4rlhQMRDC6TQKIa3dKu0IbitShRjS2NOqyVaYArcXv9jkVauVCV46wKXULTcOl37c23WKINsGqStJxQs7TsWRRdiPFZFZKT/72KKqXM5eyraAilu0haS0Mzjusb95Yl5xx6YbC7qeWKa5WFcWUuQLl1yEKmHy/rIkEx2vtfuMLgfGQ55ADdmuCIFdJS6iUL/x2l2op9UYdVzx0RHoOi4HSVqfCO3OuAlsdJO8iMm4qALmk5pyLmYU4fpGs8lYJQlHlFuU3SPwqdwl2rOMZ24vGRyFsHJx6XDdmvKGkH/jK2jJXghZiVw7xVYkW9oNFP5rQcJQxGr8WlNWoD65E2BQGVJWzNccuGI2VlMw6ym7+XWUHkutAd9B1ni6CRL6JhxpAe0fJ/nslYriCmjlj7WF/SxJaAJ0lcIjmj+10udC0k14UppnzWu03IdxNqIE9mWz4zM0tKs/cv4fLOAhJPGw41RQ6mWCeutIjaN7ln8UFE+JKL/yndBWPw6L7Xy2mPRGum6ipfnUJsBzwNiSWCdss1lrFlGB7Kvt8hT5EDqPgWJqaVUSRKt5onyk0463g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(36756003)(38350700002)(66946007)(5660300002)(6666004)(38100700002)(2616005)(44832011)(966005)(478600001)(6486002)(66556008)(86362001)(45080400002)(8936002)(54906003)(66476007)(110136005)(26005)(4326008)(7416002)(316002)(83380400001)(16526019)(2906002)(52116002)(956004)(1076003)(8676002)(186003)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dkafhBJMxrKF23rPFGjYqHvdpXjf3h8cIHesXpRxf+sf4Q5nAg1S/sruurI7?=
 =?us-ascii?Q?JqzMRI4PPDq9PWat0W/yjYqSBgOOAlVbzaOUYkYa9rq2UrF7JKIyNYv47xtQ?=
 =?us-ascii?Q?CAvjScQG0ssziuhzsCHES0k2WZL19xTr1GYEV2lU7B65D3fXowR4byhBjhL0?=
 =?us-ascii?Q?La3ZFR5DEVw8i4ZRigUXolACwpGAiPkIK0QG9qHwKhkvqQHFjbpHkdH2+Fam?=
 =?us-ascii?Q?lLp4cSsXafQnsIPVwnpAH2ZU5r6U4oOBKlXJbcNuvw4nJUTAAjasrD6EzsJI?=
 =?us-ascii?Q?+G4IaevA+z9k/3bsrE72vMiMB11qADLZ+hJqtuq0RJu15154sMlgifgAaKlY?=
 =?us-ascii?Q?EtXNROtCPjlD87y2CtaOD+Ou8UiKpWOUQ9BJxgSglHf3lgZGOBKDkwfIyyCr?=
 =?us-ascii?Q?gKuLA6vE6Z3ZPhvZdRkPG7D9ab565Ea1vvvDW3Tv0T9mOnLYFIaHTWNubEH5?=
 =?us-ascii?Q?zZKGhsM38oiRIQu4dKMMe93PVRJ0XQ5bGt1GgxRavPEF203Hff003dZL3THw?=
 =?us-ascii?Q?R7dN8yplbI8Q0Q+MN7KGDSPDCgRsrkryo/VWAvuUS7UqtiXIvgXDwjnifM1a?=
 =?us-ascii?Q?YbdDJj/sW+wgfFGIHpDYD28jhZCc7Gn2T41T9LdY2qonO9Eo+H0YfgrTEVsM?=
 =?us-ascii?Q?iG1dY3UbVyZbiy62fr9yDk1f48IBTehpFEI8oc5bq+YZYpEWZ0XCIOtwJmYu?=
 =?us-ascii?Q?4HFj5A5P5m+gMVUEO6r73NiITOgQ0hOfkHD8oq13m3ujLZzFwV7iHG3r+rc7?=
 =?us-ascii?Q?Sx2G/ncuJokMPW+LzTF/ROLDe/f2fI+9hlLjjFw757xj0z03cibZofeoHEjX?=
 =?us-ascii?Q?+hxPTHC0iWVw1GQ44dQw5BPH9PlwagSSr+nGIw6bPYexwHLHdDHf0yYtnVPM?=
 =?us-ascii?Q?FU4Eetnb7KhVIQNLkA9cdQUSW02EuBDOiLb13acvgjvOcIs8igNB5ezcR0ud?=
 =?us-ascii?Q?YHAhWicJgvA49xPBrzbWCTwjl3S1JS+m4Ds3k4SIgvjCnZFidkQEYx+U8XV+?=
 =?us-ascii?Q?M7um7jY9gDJwhOiCC9Mc/tv7uFe66lp1P9yobgWh7hagmxeumXDLsYFBYicM?=
 =?us-ascii?Q?byszjRZUITSj2n2BaGHi21hoPHHKG8EldIG9bxNNGiliFaGG6EEReEYhJavj?=
 =?us-ascii?Q?vedIbBjhduoCkVJPKQm87Jz78PBNzOZh0l0GeGZPl8zGTOVynfaDFuSTp2hW?=
 =?us-ascii?Q?CP4JU/YommtHPzi8DQdztqeVysN6dPoDRjJ/GA60zpdOxLWdjUDjG7d6zlgV?=
 =?us-ascii?Q?ru+qmkcUIbiWnqzWslQytyXgEs0jZIrrkjLHyi0i7i4ymr3t4wRLUyf7VdzS?=
 =?us-ascii?Q?yaP/bv0FGyr6r3K5apFqkCkk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a2c0ba-a958-4837-190c-08d92b760c8a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 18:40:26.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk4cSRDP81sBqdviSOATpBBe2X0K3RwaQMuP8vcQsHYWxBxOmOyXBGOtXtcNt0CEE8YmUL689DRyU+e79xphVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AMD systems from Renoir and Lucienne require that the NVME controller
is put into D3 over a Modern Standby / suspend-to-idle
cycle.  This is "typically" accomplished using the `StorageD3Enable`
property in the _DSD, but this property was introduced after many
of these systems launched and most OEM systems don't have it in
their BIOS.

On AMD Renoir without these drives going into D3 over suspend-to-idle
the resume will fail with the NVME controller being reset and a trace
like this in the kernel logs:
```
[   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
[   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
[   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
[   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
[   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
[   95.332843] nvme nvme0: Abort status: 0x371
[   95.332852] nvme nvme0: Abort status: 0x371
[   95.332856] nvme nvme0: Abort status: 0x371
[   95.332859] nvme nvme0: Abort status: 0x371
[   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
[   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
```

The Microsoft documentation for StorageD3Enable mentioned that Windows has
a hardcoded allowlist for D3 support, which was used for these platforms.
Introduce quirks to hardcode them for Linux as well.

As this property is now "standardized", OEM systems using AMD Cezanne and
newer APU's have adopted this property, and quirks like this should not be
necessary.

CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Prike Liang <prike.liang@amd.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Julian Sikorski <belegdol@gmail.com>
---
 drivers/acpi/device_pm.c |  3 +++
 drivers/acpi/internal.h  |  9 +++++++++
 drivers/acpi/x86/utils.c | 25 +++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 
Changes from v4->v5:
 * Add this patch back in as it's been made apparent that the
   system needs to be hardcoded for these.
   Changes:
   - Drop Cezanne - it's now covered by StorageD3Enable
   - Rebase ontop of acpi_storage_d3 outside of NVME
Changes from v5->v6:
 * Move the quirk check into drivers/acpi/x86/ as suggested by
   Rafael.
Changes from v6->v7:
 * Move header location
 * Optimization of force function
Changes from v7->v8:
 * Add tags

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index c8600978b283..c40fc135ff0c 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1360,6 +1360,9 @@ bool acpi_storage_d3(struct device *dev)
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	u8 val;
 
+	if (force_storage_d3())
+		return true;
+
 	if (!adev)
 		return false;
 	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f973bbe90e5e..e29ec463bb07 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -236,6 +236,15 @@ static inline int suspend_nvs_save(void) { return 0; }
 static inline void suspend_nvs_restore(void) {}
 #endif
 
+#ifdef CONFIG_X86
+bool force_storage_d3(void);
+#else
+static inline bool force_storage_d3(void)
+{
+	return false;
+}
+#endif
+
 /*--------------------------------------------------------------------------
 				Device properties
   -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index bdc1ba00aee9..5298bb4d81fe 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -135,3 +135,28 @@ bool acpi_device_always_present(struct acpi_device *adev)
 
 	return ret;
 }
+
+/*
+ * AMD systems from Renoir and Lucienne *require* that the NVME controller
+ * is put into D3 over a Modern Standby / suspend-to-idle cycle.
+ *
+ * This is "typically" accomplished using the `StorageD3Enable`
+ * property in the _DSD that is checked via the `acpi_storage_d3` function
+ * but this property was introduced after many of these systems launched
+ * and most OEM systems don't have it in their BIOS.
+ *
+ * The Microsoft documentation for StorageD3Enable mentioned that Windows has
+ * a hardcoded allowlist for D3 support, which was used for these platforms.
+ *
+ * This allows quirking on Linux in a similar fashion.
+ */
+const struct x86_cpu_id storage_d3_cpu_ids[] = {
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
+	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
+	{}
+};
+
+bool force_storage_d3(void)
+{
+	return x86_match_cpu(storage_d3_cpu_ids);
+}
-- 
2.25.1

