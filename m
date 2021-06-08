Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0F39FB13
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhFHPpV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 11:45:21 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:27087
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231253AbhFHPpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 11:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6dRnp3xuXe/1/VkIWW1Okf2KS5ATYLqNOyZRcD2TXWanOaCLRg1w3xdUr8UvtzjBoPtul5sY/p1EWlbC80++Kbc4aifm+aCBB/42nTAunv84QJbZUtyiLF11K2KsBJCWJPxW/BUESmAGWlS/JXE9Uc1KAc8SQALtIkXZId4N12CnSW24PejPCtaSYAbRvRHgBAgrMtNKinbTrR0XzQo5jySlwABadZqMdA10RhNMIjxDHdFaED/ZBQ3de+pXYXJ8nPHJ5M5CHnrAqsD9wjcR2j4mIGDmxS5X+0yDX3+Zd0douGRnBRfkENW3q9mvd80XKU9WoNAAG9V4loYoibgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E23a+Nyv2/aYiVzjkYrTu/4lnLkIQIU1vWmo91PfhSE=;
 b=iLZz1e3dYuohCidIUIKdlbU1w1sRSDWFdDnfe6+3cvFfpXdZwyYs+pFDnq6yjRHenNtyfyAKP9vT1TLz/eTZQh8NwSeZDPv3BdikXVnp3lHm7AC2TfhvSJKHKnjb+G+/HHy4F/ozIQpMcG7N3JWier45Pd1xvEUO6WUR3N9rn/OkiWK6aNIP6lZdM9mweZsdXp7hXxyLbxUBzf1hbbD4aR7QMvnMGJ+n0LSjBq05/jRTUKau/H3vbsWBX7YnFmcrgTQSDjR4DxP1pDKvGj4juiRh/LtLQLSgDUJWyE+jphgf2cJ9f/vkmc0GxEOICvrIErM5Kl/P9j0O1yxJb4nd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E23a+Nyv2/aYiVzjkYrTu/4lnLkIQIU1vWmo91PfhSE=;
 b=eP9Z1mcdG/LOIBUhHsujwAHlVRAdCZFE5d7EHs0sy2SegjX/bNMw6A7ZVRaHAjIE8fZsmfU2i3P0Ahx06TM7CxYKXb2VfpOfT0eMCTsDSyc1qN5roh9FnktjeHNHqdol2kZNCQ6+rQJXb3Iik6YMtdNYYLMWIG+tYbsmOKXd9Gk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 15:43:24 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 15:43:24 +0000
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
        Julian Sikorski <belegdol@gmail.com>
Subject: [PATCH v7 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint
Date:   Tue,  8 Jun 2021 10:42:55 -0500
Message-Id: <20210608154255.8693-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608154255.8693-1-mario.limonciello@amd.com>
References: <20210608154255.8693-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SA0PR11CA0140.namprd11.prod.outlook.com (2603:10b6:806:131::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 15:43:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c2d58c-efbb-4e19-176f-08d92a9426db
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24478917B6286608B359C1E7E2379@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzCFoJUagUGgI3jjXs3b7TnA0DepC67ieWXq1KFeuNlFbFmqCsb6C4nGtSnNsU/h6Li8MatToRWiVLBlPRL5UDp3MCelo2TJrUFHWJuAEM5ltqmRLTegAHMXkpG6m9oCIP3nKCon18ua63V4Zzk/K6zlEr3SRZwxmDcRGv6h6sEVcXsQf9RZqPx7c7T9hE2VdBsboZJcdDwRGgoOIOL4qVFtfdxGZ5WynYmeE/FM3DGsLu49Zou6YiUNILWE4RpI+cf7U6mloYs6fh4sy0rzViPI6KC6y7pScZKDjzzLslHVzteDD3KKuogK3T+oxMsTXwD20mQvc/Mg3262lEHFG6exwkY42nC67Po/ou2v9igUlWLezBf2ZWVrgF6kqUxSTXStXCvF+shVDN+zwE5zQ30rTKVUc+UF5SaO9XjI2ohx+Cn/+r2/ik+ExPlYkWR0VUz845w4tfHJSsk3DcRZqfAwZGV7qmRfTtMvcgjFFj/FuChFFzdqSsxXNjEndnqAojGWu9GR8vmN3ETtgfK42GYtj12cdK0cTEJxG8i+NmiVhA2I+6jNwL09Eoz1HNloZ3NZwKsUlRPoS9xxGG/coFnbvGev8BPEHIgGyK2SPUP5KprdVy6TF46RT0xFHjzAhvfHLqyWMisMdklLh3jKwrRIgwdQ+oEJ8TXhDpo65wTJ+WrrgOpDeGkwsuRiNLIs605H9r1ia+s1/HucaYrsGPMZmH8igJSk7tQMfZa0TVsnuq9FZrt7JURgzjXFH2wvSNMASp9xE7/+I8I1NyTL/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(7416002)(66476007)(8936002)(6486002)(1076003)(66946007)(66556008)(8676002)(966005)(52116002)(7696005)(26005)(4326008)(16526019)(186003)(478600001)(316002)(5660300002)(54906003)(38100700002)(86362001)(110136005)(38350700002)(44832011)(83380400001)(2906002)(956004)(2616005)(36756003)(6666004)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbH9YqS8rbR/Ck7bhUs1NlR0cl8Ny8pviKxKg5C23wGu/kLpARu/FMW2YdMn?=
 =?us-ascii?Q?BAtI7vPtRjN7xeqFzJ0E2B21zt1P7V/iP6Il1ump7twnlJa+uROSW1mvkzS2?=
 =?us-ascii?Q?MjKKuqYl3B2+QMdDrvy9OZxy9DAJ9m4LLOWEeA73wgRqZBUvUMlJdg5RpSnW?=
 =?us-ascii?Q?u3d8efFz5kFdqsp47d367anVaiC2YItMjFWm1cKcUsZ41cp8/h6FqskiSEBX?=
 =?us-ascii?Q?yRUUxyTVwrtbN0B9e5DciL2QWM6BjPgeRQeRAXDNxiIMjITZz1DMlRF5nqx0?=
 =?us-ascii?Q?5nkPzO7iGSUrafarMpEfVeYYtP38owvyWJ9GYxvJucbBw1IP029mnxrl7DMz?=
 =?us-ascii?Q?vjOUHLmBi3KAgbLohG87T3YQqftiNw+MfMIXaqPhKyt3L94PKyvo1/2+agsU?=
 =?us-ascii?Q?ARvahTpciW+xr+bIxiBbeEfvV1KsvIguIC2TxvGRS30B2JTDtyUReDY/Ac0t?=
 =?us-ascii?Q?pSHwdXGnGX2uAESbSR4GParJXNdG1QJ514PMgX+lEhGOSRAAgZluso+Qvus6?=
 =?us-ascii?Q?riUy3/np1HAErEpEDNA5h1qbDTrpW6aWuBaDhl6xWq/HTTxK2UgSjTUo07cv?=
 =?us-ascii?Q?64lmIrJm1bMwVoWkRgGfR5CnkECJI/mGXM8u63pPb89LHmuJycVg7uWb/CM8?=
 =?us-ascii?Q?Xtg/5Zd3i5xOAfeL3/vdzp1/xplTaViEiea4YZ6ueM+yzol0GCGTjhlT53NK?=
 =?us-ascii?Q?+awe8uQA1VsLKIwN7lHnY9gOKAtVBQzWjcUzqmMdq3bYa5VNkFHfWTqQAQUC?=
 =?us-ascii?Q?al02QbsCA+Mf3ho3+tQIuWA1CLUJPAHGS8gj1AopXagk5gHbQqjEvspMSN9u?=
 =?us-ascii?Q?CreM8FCtGybFOKFFO1EN3Ubw/GWDyri16VWBBVexyjdl8L+ZjvwDk2ejCsm3?=
 =?us-ascii?Q?kU6jPLtZ9AFmEqgqI991GatCLYz0noid5OVBUtNtutMe2fZmPm9U4UoaXh8m?=
 =?us-ascii?Q?kTbitcEbAU5K4lcAHdu8W4BjF0XS8o5Xj/ZN5TG+Ov1NjTpzd8hKQBGOj6sl?=
 =?us-ascii?Q?45cSTHzIksBkzb2Y3EZ8MfAStExzvTQr7r9YRAnRmlPwk0ebDI+nprljYpWN?=
 =?us-ascii?Q?1xizijBBBRVkuV3pgDtAXFYvBExKgohLipVaBhMGtHYCHx8G5EHAxMm/j5bj?=
 =?us-ascii?Q?AcEjHQ+md+dp4SKbFZfwPhVYEXoreu1pFQxPbvbv1M2buQmMQjW8u2u3oOsi?=
 =?us-ascii?Q?G7lOjMykW8CcfLTzfq0Y0irSlhJoCmHu3PNPKUVgDrTKkHAKOYx3a3mKCIIe?=
 =?us-ascii?Q?X/ZXy5GsnDrDYpeJggfCPzFyHuTjTEvadA8Xs6SJuxIDmeYsB+Ltx8zkFIR+?=
 =?us-ascii?Q?RozpKnrCTc+AWaZg5AGO9Bzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c2d58c-efbb-4e19-176f-08d92a9426db
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 15:43:24.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkspBgjKTNLqOJXvS+0Sq+wBSYTnR8lOP4+uZYMQpl3ebMxSgXbAA1TiZz3TTebMqCXhXtAim//c5fBLmIuUGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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

CC: Julian Sikorski <belegdol@gmail.com>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
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

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index c45f2d76b67e..31e0025a913e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1356,6 +1356,9 @@ bool acpi_storage_d3(struct device *dev)
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

