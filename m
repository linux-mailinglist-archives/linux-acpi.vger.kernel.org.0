Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7129D39BDB0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFDQ4C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:56:02 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:6673
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229791AbhFDQ4C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:56:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmlPahqcz4T16WKNmMVxAT3S9j+/mF8bc7WcsItpcj92enHAjseqrBn8ryjUBl4GUzWm5U5Rj8+pIMsUQfUKWpuCahXR3k0Rw1NG0jcUQMMplVMgvRCq58pAR7VsYiO1ckr6TsoP6n53hdZ0hyjdgD3ed0Xe/VQCDeOElI5wc8fvpe3xIS6gsqyGHtWx92xYXyavj29Uo4/fZi/OtHBCUX0aAXAqsHb0CHEfriLskphPuR6bsjpJA+SsX3/KBeVooaub8+j0GbHH8r/K5HGUQW9OcG01UOQ4aSRrG9TXbdiUiU5AZEXvFx76HTDUg3AD2WNo3G5RogtkwDqjafmAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUKyU41VeahsvY9ZV62MF69f70Ele8Y/jLRPhhl5Glg=;
 b=UpKW/gxafKjm4QJkYU8v74fulmMo6B67Jpn8fMxsbVOe6wQK9QY5/iSzwj0mDsIvkCAWTsRFNpk7ZS2aWffaZF7/Ywmi7xiQVbHA16cOwPjVLtazdXaEEJ2r2qoYLBrBn7RjOzRf896sTZM+fYruqaLBwOQAaSPmCYSF4xk5q1zcMpECebQSqkRb5L+pYc460gMY6h1yyKR7bYmZ8ooR8u55/PL+Z7FcZCUec9fhlp9POyOp6aN8QBLFBFXnYF9cEbL68QzhvpZLTIt41ukP2XKTEEybwm828ys1eZG7L6jg1XYdYYhqImTzVrUiRh19o+jMx51ydvkch1rZw0BijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUKyU41VeahsvY9ZV62MF69f70Ele8Y/jLRPhhl5Glg=;
 b=2AWgCmMUcBmpaBpUgelcvFlfVnyR3c+d49nUIkLQqoHxvZlchWFdNtEAU2niOEbWvSnDBDpFESyy4AQ13eX3E4YxmKsob+SI/+xIJT+RsJOyy+/L/uV8sk9/jHt//8JkyNEyYW4Hl+LravQTA4OS4YfHHGUnt96Q9g63FaUUVHY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2689.namprd12.prod.outlook.com (2603:10b6:408:29::31)
 by BN8PR12MB3156.namprd12.prod.outlook.com (2603:10b6:408:96::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 16:54:14 +0000
Received: from BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60]) by BN7PR12MB2689.namprd12.prod.outlook.com
 ([fe80::c529:c932:4b33:9b60%6]) with mapi id 15.20.4173.032; Fri, 4 Jun 2021
 16:54:14 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-acpi@vger.kernel.org, rrangel@chromium.org,
        david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, prike.liang@amd.com,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 1/2] acpi: PM: Move check for _DSD StorageD3Enable property to acpi
Date:   Fri,  4 Jun 2021 11:54:02 -0500
Message-Id: <20210604165403.2317-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::29) To BN7PR12MB2689.namprd12.prod.outlook.com
 (2603:10b6:408:29::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 16:54:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85936ccf-5e78-405d-4a98-08d9277961f5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3156:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB315679F5D6EA0B9109E852FCE23B9@BN8PR12MB3156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAku6sdUnt54Pc9B8O9Og+1lA13fRVuHCn7k6wqihasLzgkcaBYVcw3zyGrHNb3eOEpfCOaqUWpmmw+I7uGF5EVYR6l5K8yfBUamhwS4Me5rto9WcPAxUQqvhOa9SmM9ZsgqikCrs0HtjwoRjz8Q56ET1bVRp1wbcQB5Rhl8KVykOQw87iim8lWJ9VESGk7DEWDjcN1Fy+XWeP49EZEXjjZzOr0U8G6/YS1733/fdw1TNGZQBEM8g5TzcwLdwaRY/gwMQOnXtCw1CskqSa251K6SUKRhxJntJyoHd/GtctrueFQPO2Yit+wIER6zBsBLHfJV/PfB9/wSjGGIN8q9r7tziVagyoB9sZw75a4pfpWsrbRgkDjRKENCqxnDSJf77Q8MKtuSxlqYGfyhdQWqmuVrrfRMXiZvxM8QLJbk9Pg/6t3eQ2nu36VvsxL7Und42F0L7q6qCoj7wh5AHyxAJdpXl+/R4iupqWOeVkPOiP/bDGebzEVsduUM70SEgKfEWjEOuJJK4eSFdlaJVkbz8MeUYJXt7wovMpghLnCEtMUFrfwt5fRWeVQ7rSSA4vTJujZEp+NeX0Flq3OJvICNst3/NZXIObWyxV1Z2tpfn9bv47zl1dyTrGikuqx+6kChCD7A0AuMCF9YZFUPoL7ZwQWW8RfZxpk+n66Gma+aZhn1KFME7k+pw0ME9u//7zpirWUQF/jEGuF7i1CYNVvAFcHsDqClGiBGuMn+QI7fZ3OtT+Vzk5B/43NS0qTBh5uZfIa2qCsz1RwI3NhXe6ZbTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(7696005)(52116002)(44832011)(2616005)(956004)(110136005)(1076003)(86362001)(83380400001)(16526019)(186003)(6666004)(66556008)(36756003)(38100700002)(38350700002)(966005)(4326008)(5660300002)(8936002)(66946007)(498600001)(66476007)(2906002)(45080400002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F+CFd0SBt2RzUupywDT2uykj6HtWL4vnYYVT8lplI/EEoGAO/eJRLTkYnFKK?=
 =?us-ascii?Q?vnq64Nr9619r2XaIGUmH8oYYJb4VqbMAFKLVLZEsMdmGBhBoAmmhoor2Ed71?=
 =?us-ascii?Q?LomKSSqpUYLFZpg9GvL7hZXRah0xn/aQVVbIS6SNwLFbY/6pV9dzW4mxIUSu?=
 =?us-ascii?Q?Qx61ZeQh7mEBG6GV/kgeW8Wa0RHIyEaFFs+DdED2VdDpWSZwkJUBZNH/dUeT?=
 =?us-ascii?Q?wJaFMkfgJ2FmtwBR8x11gFKw7V7hO/hwLGVDh0h+opYCnXXza3SDpcXgd21a?=
 =?us-ascii?Q?wx/KgiefnLeNqMpJ60ksHu2oTQMhENjsszfk6Jz0tLXKnOAkE4viCEbjDA/e?=
 =?us-ascii?Q?1qyjQkXLmZQJgsvIewqAm9Iqyhxjg5592xPn+ZhtDN/ww8DlVu7nXDFulhii?=
 =?us-ascii?Q?KU9S3BHwXp/ZjbMoa/8ICnzDhGu/gjPO8FBcZcU4TMRYL2nXlJMZFwGB/QOv?=
 =?us-ascii?Q?wCbLIwJz2btQ60t991pu62Qp5ED1BMRRzs/k4PP+aLM9US6ccZQTFzbIu1Qs?=
 =?us-ascii?Q?2AATVNtXg2cjeOxhPTM2Np/VWq3qI5LTlQPV5WJluS6ycCPFCPGVb0r3WAno?=
 =?us-ascii?Q?qoAtJyko3PKarBc+K5WXaMe6V7QTggZ9uFIUKmq1Ztopvg5Ne4QlR3n+ChlP?=
 =?us-ascii?Q?nN2P0Eo1z16+YDUzzAwQ0HwI6KZuPC2WXS/FV0SSWuAi0uMLxVKYShf3eLc+?=
 =?us-ascii?Q?8YVVnMOL3WenXgGuYK/6iuo0+K6HtLBE1SmjokV6CTp75+Oq8vmhBMSGwDId?=
 =?us-ascii?Q?SCNZs5oa4KwxjKOVn/+mdSGuIB9OjpagQ8D++3SucylystoaqK1mPzorSr/N?=
 =?us-ascii?Q?sX07Ixe+8JY5eXO6q9uUBFKTx67S1Hch/RazcTY/v8wxtK+9R0CTV/HHN++m?=
 =?us-ascii?Q?mSQpGCpNk2aPK1S6rJGWkmC03EqajnXP9JamVPlWyyz4wdk5zyUX9RKkdIsk?=
 =?us-ascii?Q?ha3nKM7Xp+qFFTS+IvrgkywRjQ/xqVZgx7jFJz1m2zxXDk54I/BXCK03LXuS?=
 =?us-ascii?Q?aYuSMshGcafecflcQQIh8Yc/U6z1DeKSKXS0Ayg4AchUHnw/WcwYVoWopV4y?=
 =?us-ascii?Q?75DzXVL8172hHSXpyHWCO9FC9DE+GaXAkdUYS84f2Dhu9usyEIONUfr/5y83?=
 =?us-ascii?Q?oNSWrwKy1RfYDl5COzGEL6DwPrfb8C+SVxpGp3MnK3LPWS8LUEiQME48Gf0P?=
 =?us-ascii?Q?20TzEYunri0czrNbHfXfNDcZsLdtFl+7Km3xJ+h4cHv7Y6VYbEqsVAWApTYi?=
 =?us-ascii?Q?UfC2F2NcKxXvFdEUlxIkc/K5DTj1LU27QqS1fxGrpMXWQOlltdB39jdak1Zi?=
 =?us-ascii?Q?vlSZgUJ/cnpd3chRqX5/F7E0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85936ccf-5e78-405d-4a98-08d9277961f5
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 16:54:13.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhcuHyUTnbIonhQWvVKVEzuWb5LZnkMsghm/M8vYHjxNOCNmF536wv9glnDAhFkL2geTLHxfJic3ZF92QMmldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3156
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Although first implemented for NVME, this check may be usable by
other drivers as well. Microsoft's specification explicitly mentions
that is may be usable by SATA and AHCI devices.  Google also indicates
that they have used this with SDHCI in a downstream kernel tree that
a user can plug a storage device into.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Suggested-by: Keith Busch <kbusch@kernel.org>
CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
CC: Alexander Deucher <Alexander.Deucher@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Prike Liang <prike.liang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/pci.c  | 28 +---------------------------
 include/linux/acpi.h     |  5 +++++
 3 files changed, 31 insertions(+), 27 deletions(-)

Changes from v4->v5:
 * Correct extra "Link:" word in commit message

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..1edb68d00b8e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+/**
+ * acpi_storage_d3 - Check if a storage device should use D3.
+ * @dev: Device to check
+ *
+ * Returns %true if @dev should be put into D3 when the ->suspend method is
+ * called, else %false.  The name of this function is somewhat misleading
+ * as it has nothing to do with storage except for the name of the ACPI
+ * property.  On some platforms resume will not work if this hint is ignored.
+ *
+ */
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u8 val;
+
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..8fbc4c87a0d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..dd0dafd21e33 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
-- 
2.25.1

