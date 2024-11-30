Return-Path: <linux-acpi+bounces-9832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53279DF106
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B392818DA
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Nov 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77B21C1F2A;
	Sat, 30 Nov 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="isD6464r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCC51AAE24;
	Sat, 30 Nov 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975683; cv=fail; b=M9X7Svz3w1KNiIMwncbwzaxslRQJPEKYpjPXECbpqmurbNFxM+sMgpX3+8HHuCCcqw8YXc2IjCLGTPgDXkYzKEB0SxqT7zij+5zbpGsWA/+96nyDvLfd2dhKq+FAcNPCVXsSSstXIIZfDZpDF5ML7Th0tzmmTHwICb8dLqkLXwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975683; c=relaxed/simple;
	bh=IOvZRKAPWNZC84/xYTtOAnd86sJc053Z0HhsqFxH+/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7NKq11233XsCOlbFZWfUsXCsz2hxJGWHyYvD/dk1JC7rtcEJRjsBTp8SolJLzUlZVeH5h8sigTMhovYyxycb7C5i0k4vrZzq51KSD/1u7nY/IUivJNVOnQw+czH5N84QHLPsDTCajlrZ+sV/f/Z+R8EoSNuXWbOnSaBw8nk3c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=isD6464r; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWpY9YiPFhzFyZz6SsUiJQCkGGbrgbfHCXIRrDsLHRjgiU1UgwtQ1x9bsvJCJUuES9G3Gc7qiQgTUqZtkr3E9pzmsVBqEmPUpYTcw4A5Gr930ekkWB08OD1/bn+WCDGh8iG5cs6L3ng/3yvpX5IzfQ3u2NRjtxtc7IGaz1UvV6HeU9wm9NQWlOAhwilkUPCkpC1kRypu3C85VwtKd+tNT9M8ic/sKAutWQ1GpO/NbhJxoFSl7a+i+V0CgEGsjarUmPp/RGRB8J7hmQb++OAcYCGeKpVbCa1yIcJid5/aTsXbnIOb89UcDa4gm+Qor6vDhmwbAEHRIJz1cZ3Z+yK7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rQuoDc8UaCkJTYhrzlrm3g5L3+wEqX60J51gCi0g+c=;
 b=BUHlwp59lrO2NEi3MvMvhD2ULF6jycDBsIFPXqkt8CkWqhM0A2nVrjBzGPUHU0cQs6T/b/kcg5j3cIhfLDrCoawu5HqvuSnUM67TCaSI3Trtjg6jUT5DV0W5xu3Rbqsb4NNOGWq+gkmiUbpLQ1kIlpWZGa4dZFLnBXIGtFMULP99X/dt4eGnjC/mXAEX8eRYEvEvMVvTT1dQ/Aat+G/IH5tTu6jUPwvEzVhkf1F5QleFmhhFM5Pwf0Y3QQmCuM0u98ze1/CilDVDVHNoHiP0Te0/9oMqCeMd9x7Xy9tvxoPsuv6VkjVy+m2LcF93S9Vtz5pITwedD50eCaE0Vc0Ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rQuoDc8UaCkJTYhrzlrm3g5L3+wEqX60J51gCi0g+c=;
 b=isD6464rh4xxaNLI9TJ/3ImFvE3laZYB7lw269Knf9zUXV42bYibLCg9vcFk3PRcIQ26io/wQDkEcBPhpuFY0tDZ5exRtYLP6cIOlMbIQPRJkLqQVRx0hwQHefdbb5HkBzRl2s/Bq4vtdKyTH9vK8xaf3jFnL9DGenZ90aMsgxs=
Received: from SN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:805:f2::22)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sat, 30 Nov
 2024 14:07:54 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::81) by SN6PR04CA0081.outlook.office365.com
 (2603:10b6:805:f2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Sat,
 30 Nov 2024 14:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Sat, 30 Nov 2024 14:07:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 30 Nov
 2024 08:07:52 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE
 (32-BIT AND 64-BIT)" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, Peter
 Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>, "open
 list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:AMD PSTATE DRIVER"
	<linux-pm@vger.kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v7 08/12] platform/x86: hfi: add power management callback
Date: Sat, 30 Nov 2024 08:06:59 -0600
Message-ID: <20241130140703.557-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241130140703.557-1-mario.limonciello@amd.com>
References: <20241130140703.557-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a76525-df0e-4b74-1e6c-08dd1148626e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YAfc/GGAmEQzQjL0jLsNTPC47CfAppFN+FdeJ+1UjwCVTXO5I9xVEE3JSRK?=
 =?us-ascii?Q?wOS/SrN+rBwIDV/LgVDTmWDsrvEpIKqTVB/EQS+unIY9zR3jxJPt0MyoVPCV?=
 =?us-ascii?Q?SwBwVlJA4fMCv0csp6d7Ia6nnp+TgwFb3fsNQco4l8u1rVQYvlMJ9ryaXBg9?=
 =?us-ascii?Q?Vs9WiT34e7Kj23aQ1IrlPN1XylwUrhLF7uVxPVWgmbEfiv7EfvAkTsZKy9yH?=
 =?us-ascii?Q?oZrja9qy7D7ZCXUZyGjS/IS4ftRP6JUPkQz508NDAxhvFDDHbxzPElQJuuOu?=
 =?us-ascii?Q?uNRfHNuzWO1tCzWX9y+NHNJdFBRRqg2JzTDyIMdIcNcu1ZzNLpEDdtUMVylZ?=
 =?us-ascii?Q?Ef+QeqBsbATYVq5K6z9LAgaqOa9pXBuxBDr0QKCy8pIXrgtDykz3JL77pj/s?=
 =?us-ascii?Q?avv/xPVysPN0a+Qvm2jGYiK8khbUVmEcPB8zjlTTd6mkNwrVpTQO42YeAYom?=
 =?us-ascii?Q?JfvkBcgER/YP1WQ24HxigHa6YEFjj3OoJNdu2AzIBGSGjV6fEQ2zm2+MXGY6?=
 =?us-ascii?Q?Rcj/WbSNR/Lit6LlO1oN739Haug26OcQHifjNkuUvTKtLX4x1GQbCgpe+9J2?=
 =?us-ascii?Q?St65nohF/7xYniBkn7zDwZMoR7qpD91qebY+QDvt/SLf3CJQk49srs3vYyN+?=
 =?us-ascii?Q?Zc3pGhDJM3AxNu2VWK+q2vCPVBRGKlct0jDjD64ttbFy+NPJvh6Vv6Ji8lhl?=
 =?us-ascii?Q?SflO3T7I0Ib+GvrNFykvrS+kavjPMDVCf2uViLbe6WfA3qFqAU4SN/MbeQ/f?=
 =?us-ascii?Q?1xmAf/kr3i1MUGpbqQtiUjmaeTkrx2TFKSof1zGK0IlR5/jX2tcpjo1VFc3Q?=
 =?us-ascii?Q?4sflx1KYmj/e5vbrlAUWgTW4AnC90n1uGSd6e/c8zOTE041ChRe+T+26Ek9U?=
 =?us-ascii?Q?Ea6+HTvvQssXQPxTqX93HSWm2h16N3Bs+BdlfJEEp44d38l1dkINKltVLsgU?=
 =?us-ascii?Q?Mh47uLXHQ0+u7bqvnuUrMwwiJcyxr161DV8fLf02eWUTHkxt/4fOKqWw8cXP?=
 =?us-ascii?Q?Zn2swmuC65CUqmcROaBLVtBqbSos3Y4Ml0ZaaO5jdZGhe4BVUtbHcbjtZdWE?=
 =?us-ascii?Q?HzHSWdFxyxYsn6YZ7YN/pfIIKj6Nvqqk0s5C07ZkHy+pXT0UTVAV2sBxwnMk?=
 =?us-ascii?Q?msTr1tG19yxUnHWRKbFGcFWRGDry0Poj689VCYfRGfmAG+4KJZEZd18z+DOk?=
 =?us-ascii?Q?dx9rZ0bvHipIFSvystHuIKORVb78/Yf6s9BbkjXjSF5Xr3RmYSdhbYmPR8zz?=
 =?us-ascii?Q?tpqHRBsqCu1CPS5t/f3ZJz9Z+FVUgMalgj2Td/Asbsh4FjN/AymC3qJv5QL7?=
 =?us-ascii?Q?rCupfq3VL73OB8TB6ddV9nvTMd5XGLCd7RWFAyGstVSU9TtTMZ894wl+fVTE?=
 =?us-ascii?Q?GQk3je6kVVA5v0en0br5kbxZDys+VpKyW0sxnUX38xklgVRkpzy9IKk05LaB?=
 =?us-ascii?Q?WMi9u9Ww7qpCPi5URIwSFOckOO2xA2KF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:07:54.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a76525-df0e-4b74-1e6c-08dd1148626e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329

From: Perry Yuan <Perry.Yuan@amd.com>

Introduces power management callbacks for the `amd_hfi` driver.
Specifically, the `suspend` and `resume` callbacks have been added
to handle the necessary operations during system low power states
and wake-up.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 922a9ff0d447a..80ccc50ee0914 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -380,6 +380,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
 	return ret;
 }
 
+static int amd_hfi_pm_resume(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, true);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int amd_hfi_pm_suspend(struct device *dev)
+{
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		ret = amd_hfi_set_state(cpu, false);
+		if (ret < 0) {
+			dev_err(dev, "failed to disable workload class config: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
+
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{"AMDI0104", 0},
 	{ }
@@ -428,6 +460,7 @@ static struct platform_driver amd_hfi_driver = {
 	.driver = {
 		.name = AMD_HFI_DRIVER,
 		.owner = THIS_MODULE,
+		.pm = &amd_hfi_pm_ops,
 		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
 	},
 	.probe = amd_hfi_probe,
-- 
2.43.0


