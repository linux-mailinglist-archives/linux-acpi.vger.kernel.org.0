Return-Path: <linux-acpi+bounces-9168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B2C9B7392
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEEC1C240BB
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4B149C51;
	Thu, 31 Oct 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="siY8e2xG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9081474A2;
	Thu, 31 Oct 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347841; cv=fail; b=H02vKRFy9ySN+SrQKoraKLSnwj6APTn5AZkZ7/wAGwJOJ4JQUKgw18cBA0k+8NjONx/E2ee4DNCOcBZ7jjqh1rJm7LRNQYq1/XI2iVsOdVbc0AIldqkG8w5Ef3m+V6F8FTv76t77yWchSSzBZK/PMXZN+CCKC09/Vz/xLcvKcF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347841; c=relaxed/simple;
	bh=E+hQchgdGdaS267kdYfzGBDNAUhOSX4W0c+LvWbVk64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFAOAkE+HbcUoUCX0NenBQUTJ9XaRdIsNMOF2oEZSBwWYF5sjI+Jd7bk/GtmQL/prulmDvUoiw25jLaxXtntQae0Vkst+llCJWcRH52WcVDeCQVm+4pw9SCRd8sEJVMurE1WHcMX1gSdLYJilKFnWkLoAicByWU29B1x9rHNBo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=siY8e2xG; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9Jan57oOa/AYpr1J9NUyhLQTD+5WExy7Rpi5ehfA2TzIhfZFZzfvhtgKBEVzdEtbyYl8IHt0T/kwfyr8dWqu/PPpbv96zkEI6OoUzYu3lJj8V1/pw7Xj9e9j3/eUX4dxeM9Uue0ZgK4hqGDyBen5XXxAoquzO2i6h/2c4ag1KWJUK24OF2tdvymianLma2R3j5tTUofhrbCWS5Ja5YVM/gIydUamSInFQF9lvZJhT7gPAd3ddhwiGDNDzofFLtuJEJUrVFOAICEeH36kc9+n2dk/EmpFVD23neACnXCV3DYMMfQ6NgawA3jZsfeE0IDy0eARVZHpj6e3Zc4xoiY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru2E8mvU6PKJs63/fPnxqlo1YPE/bzu17chK5A3+i1Q=;
 b=VDfxg8c8POZHrp790t1jxufHcnhxQiWdT1MSDIG+UudzDavdbx93PtiXrKZA2tYkdIg9FPvYg4fpMEt+yhJR7kj0Oi16uYc2XasQVH+3r7wjT7O2tgGBYJpM0SKWakbIycp+PnwiBWAvZUjl2hhhIWEmdc2mnJYF1S3fRDjTCS5mLAyh65ZSQp3YhVrmfaiNN8pe+rJvIw6ejEGujEf7gPFj22t+2cea12pNTQFI/cDcJTcPtuH7fjC/8p0WMEUR0qq9Z5/95OgDrd2m5oD5gb7mjcQce5zkfw9iTBErSSOljKIwgOA5FcrmLrmebsPUANbyrvodVlsfMoBxDjOBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru2E8mvU6PKJs63/fPnxqlo1YPE/bzu17chK5A3+i1Q=;
 b=siY8e2xGLfwnFpsVb7BURVu5p+KXr2IMrJjqbMb5R5r6S2iYekj/+fHQUDfVkHBe1ywG47PgcsYevoq1RLu8Bw7ZkhfE1OiKlxJ+uaxg3sZkuYuf9cufpDTh9WtwVbNeSeltxzbe/l4arqiMLU7SjrrrupXfNVu5sdkTvhmNjqE=
Received: from PH7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::24)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:10:34 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::3b) by PH7P220CA0068.outlook.office365.com
 (2603:10b6:510:32c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:33 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:30 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Corentin Chary
	<corentin.chary@gmail.com>, "Luke D . Jones" <luke@ljones.dev>, Ike Panhc
	<ike.pan@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	"Alexis Belmonte" <alexbelm48@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, Ai Chao <aichao@kylinos.cn>, Gergo Koteles
	<soyer@irl.hu>, open list <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:MICROSOFT SURFACE PLATFORM PROFILE
 DRIVER" <platform-driver-x86@vger.kernel.org>, "open list:THINKPAD ACPI
 EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, Mark Pearson
	<mpearson-lenovo@squebb.ca>, Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 07/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Wed, 30 Oct 2024 23:09:37 -0500
Message-ID: <20241031040952.109057-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 484dd568-93f5-4507-ec33-08dcf961f75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e71TkawE/VVJhavUe2bn/BnDqzDmCLHHFVGbLw/cW3NYKLMqpAZVzEt4pyzY?=
 =?us-ascii?Q?Eeoc1+QMqMBfZBCyQsCI3uOLVzLq/wYHq92MaFfU41AfTiaUMp6v69E5/JyE?=
 =?us-ascii?Q?E/lsnRVd0VAej4BUato2tE3aMAKI2ga+ioRP7dUozvjbiEcWvc2NKUUk/i/s?=
 =?us-ascii?Q?REl6jxpGSPD3gwhLIp0BObYHrxjxhMJsTp7HMqdgg0rEPRfNmMwL+8DYBWZT?=
 =?us-ascii?Q?gS5cNQy2MEoAibEwczyl6tPWbyvw4xRvq5ZM0H0hpKi+P4kBVR5A7EN+ibIs?=
 =?us-ascii?Q?jpU6IFUxVHkdV+wIVwOhR1hUGXeOlsIS41yYWd6tbqeaPr9J3DkLqa6OSHro?=
 =?us-ascii?Q?KH7I/XpYaEAPSLz1/T2moczezkVww0f9+PfuxQhnIVEJGtaEWNq/9WoWsp5A?=
 =?us-ascii?Q?oLlqBzO5/6itXOdTLU9Kti3vviLVeL4w2Pcr6Bl/ERdsxfdc6ncofq3jURvJ?=
 =?us-ascii?Q?YA8Bq1aEWzpm2ih81j5drENqWbZnHsFWEIw0zXV4Mx9ZLqIVoV9wI+SNREj9?=
 =?us-ascii?Q?2DrheqQB5e+XN+4pWD67YJP7idrr6VxIcH6LYg24YlqR9Xj8EY0kaW08eKaJ?=
 =?us-ascii?Q?ti0Lh+8iaSQ+4c6RP46vZjytk0ZjkOmwuN7H6TtKKoGAfM0yatQnxtVSNJM0?=
 =?us-ascii?Q?78OM22CyKIwyAA6UAqHrBE0SO1ngHp98zRTqEvCfh3CM/HOs13ycJA5jIXTO?=
 =?us-ascii?Q?Mmr4hStX5VkTj8xfGWI/nsw5td7+wrfPJv9ft6U/xlC21dbJ1EqQKJYmim3i?=
 =?us-ascii?Q?koHYWGbqOoMHei87ubOuxQ7sDNPnaRMJ1mEIKsh0UIX+mMtIIB7b9dkhtPUL?=
 =?us-ascii?Q?m6hIYntndSmJR473j58Z7rFuZvLCdz7o4qKJbnsfoqyhxQqi0hLtfkgnRdpZ?=
 =?us-ascii?Q?WBGpjXD7pThOcbFi85RKyoAiFDH/l4k5WFkwkG03O+e3Q2kuhHOL2uRPSy7W?=
 =?us-ascii?Q?LOF58zhusrIPtAB7Q1sB0VhbBCrjJ+vxben8jURMyB0q/37083wx5BXy+/Bg?=
 =?us-ascii?Q?3Fa5388X4VZRyZhRDVmQOVYQN4hiXAFTJTkgQ3xR76uEe+j7XU9jIxqK5W9W?=
 =?us-ascii?Q?itManpPNf+vCU2p2AP1KVCBKUgMFjOJjw9iJ7O9/eWDptU7zgZHmkZ9Kxsmi?=
 =?us-ascii?Q?xR3fbctD1sAKyG8Fd4K+/ehxd9OpWmvl8z6CovoWnouC9eUKJ4HsxaijH2Nc?=
 =?us-ascii?Q?+z07TG+xtPkWqFwMHUGLKK5UtA6/CIeVzz/BF7lOUCFVCT0EDqec11NU8Eoa?=
 =?us-ascii?Q?mBVajcL03nQwzFQsHuHl090A0fdQzD2nA01/R0Zr4Kmufpp7roxChJnLzQZZ?=
 =?us-ascii?Q?W+SOroZm5zTU+bYKFKKQvnWLTJptVL4PS/gSC9B4qNdyUhdcv7jlYkiSRPzv?=
 =?us-ascii?Q?LmwzDeg760tcXKrU0Ud/kfMpG+2qcLAG/t14scfoocaT0Nvakw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:33.4670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484dd568-93f5-4507-ec33-08dcf961f75f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f2f2274e4d83e..cc2037147c0fd 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -191,34 +191,29 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 	list_add_tail(&pprof->list, &platform_profile_handler_list);
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
+	guard(mutex)(&profile_lock);
+
 	list_del(&pprof->list);
 
 	sysfs_remove_group(acpi_kobj, &platform_profile_group);
-	mutex_lock(&profile_lock);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


