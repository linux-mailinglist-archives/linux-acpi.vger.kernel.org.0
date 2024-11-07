Return-Path: <linux-acpi+bounces-9400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39149BFE1A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BD71F21F54
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB97F1DED5B;
	Thu,  7 Nov 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3bvoru3X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A01DDC06;
	Thu,  7 Nov 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959437; cv=fail; b=HclJE0ASD7ccp8d232wIMpnrXvVvetko73xXYAXDCtpqNN9UC+eUy0QSc9DykIVfpPrm191lU4oYJBWCkeSTxd0NZyT1CmP4oFBG1K/MlsBRMmswT2n4DpkBqeBaig8H2V+FJXKZH4W4e2WLAi+IFz/zlcT07TkLdHzItgo9BQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959437; c=relaxed/simple;
	bh=0CE18Owe0jR089hDMR68XR0Uui1Chr7ms5oQtc9in54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePsKmVw4MAx//7ZohNZ7CftLjwYNugXoV89g7yPUUDzIc75JZ5jQs+Zq6/TgbMhpOSiwx8alb5plB10HbTc06Piazed2KGOYRp+OIog3Vl6pnu9VAb6tiWAA2/IU4drmTkxrYrixEVKI/mTJvMovk7Ih0oNcBdltY48kJN2w1C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3bvoru3X; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikyobXq+DJSagPh6JbiR5TesvaisuOAtXnlCMlo+wYAkZ6d1zKgVzZ+wBZmu78FnUfR/6MRE6O+ZS5Aurm/M85HtSEM/XAPwXdv1KiQsGl1DadFzYfPEtxNcKHYyghHrt2+IyyM1ERN+x1XPyXGFnP4b+kCz2pHZSjjHlGJpmnNrD1zRtRQVnA71l9MafdOq8N3gFMnY8NFQUhhC+B7hhsSvYNS3+vqI5RZAsfkW+SqAUNxh4z5sDvvjFS6Hf8Zg227+WipjECYDh42dYJxd3TWMgA969oBdQbX8RLPckvYeb64pYuunIF7GyaZihNoB0P5HRY4MdByVdMkN5a2kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNjdOm1VjUvCTcCTPQGwwS/qIN8336LW0MbHgOASTXU=;
 b=zOA+nqbslJRzTxau9GIc341ruMDRUmWl7fvGcyziRoIRFc5gewg3Exg3PEJsWGcI6Qql+fnKgPrAwZG2hsvpVv7k3ZJR9NTPM4mRBv3utaBCUAv61LU6B5fTtUzbQDYx5HZYqWF7u5hC1egVrlB12af5Fz++81UPQo/S45bRcz3G8l4D9na4poEGzCItknKBVQCeD7QSOzJPEUj58LOtg1MC3DXBaGWqdgcxct2mETGWPdtK1AS3yeOtsTofnBbI3dlx97SuUrMZHRBjGIXG3/oRa06Eaqyal0Jdrax5BXj+JYISJEBpyITaDc6fgWAiQFQDndaOPM8pLzbHca7uVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNjdOm1VjUvCTcCTPQGwwS/qIN8336LW0MbHgOASTXU=;
 b=3bvoru3XLelmXIqgaZaScQ7uN0KV+JEhVDUB5wxbccJg3k7BUsX+yAC3zJVpnriZmwRQ7pnXYQKXQPUWhoDhHBNSz7NOWwA9Ul871TIpo9jDXYWDgls4DPmZfoCl5+ILYM5e4UErzaEpsiaIEFD62ZMIM8f6F22UN2XYesp9JAw=
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 06:03:52 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::63) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:50 -0600
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
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v5 15/20] ACPI: platform_profile: Add concept of a "custom" profile
Date: Thu, 7 Nov 2024 00:02:49 -0600
Message-ID: <20241107060254.17615-16-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdce361-5eb2-4b54-b141-08dcfef1f4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mymcLN+Jn6sTmUkjoyPP+z6RZjPKOgzl5IWjtE3XPwWXnfDHb12Bw9+zREEo?=
 =?us-ascii?Q?Lwn87StmWfEyCEHHZM6l3+lskVDTFfi/V/0rs60BzTU1PcLRSwUztJ44d0is?=
 =?us-ascii?Q?FmHAwNfxK+bMSkKWJarLFg9EIHVMasDHSNCfuaeBXvYWy6JiSBUSmyiiB3Kr?=
 =?us-ascii?Q?tCl3X1lWhfY+OO0F0+x0GlS3k4WTRHCwGnPXxlO7ARwbxY8rTRNQ6w70opJW?=
 =?us-ascii?Q?DeMy02SM8Q5WBEi9aK6sWq+UVfgciW5nZpjf7AVaiCLXl51vbWd4ooO4MATA?=
 =?us-ascii?Q?5on2SDEYP5BaRe3Yw8eaYQBI747pX30u/voYaNsXwkboboXglbN42xO7kGSJ?=
 =?us-ascii?Q?QpDkaNiwRr7FrQD7KPf4at0+0OZN4Gvf0O9JUHzbdyubu/aIe48eLPp5Qw5s?=
 =?us-ascii?Q?hBukPAU/rOTc+6hL1z5TI01x9dQGDpqZUklnMi1xUomtACpSVSwzW2gXK6p6?=
 =?us-ascii?Q?G+qZPnEitkPk/JpcB8nddcttPnb8WfQB21vt1nZgzyB5o3+xP6OQSz0DJdIs?=
 =?us-ascii?Q?tFqXe7JP6R1xLgaMU5FokaYGA4cc30ZrX2ltX6H5PJOb7l6IWzYnZAKITaoA?=
 =?us-ascii?Q?W1rr/1I/Z7uSHvU2JCZxhsJATN2Tsf8H5zOdPf4wlyJuMUocKWL0IMCK44qE?=
 =?us-ascii?Q?FBfqK1xdMm5fWXrR1O7hzPpnhrN6ePuo0cMsday8dgQkqZRbNuA6V9d8mWcy?=
 =?us-ascii?Q?qfEFB+fSdCBUG/cD6UkqOs3qn5jeBAdCsjrir2o4mMJxxJ/gq4wlMjW7W1Ep?=
 =?us-ascii?Q?RhsSVmjVD8Q7X0Zh8hvVJPtrAzSieCqMDbEgTph4lbL06z0UsAoMAi1C1pyP?=
 =?us-ascii?Q?BZfKsk5mVmrAeL+Zb/FRpCNG9BTGC9Iw1nVzkXIH3BFK4l+3mGBM+lKtAvmg?=
 =?us-ascii?Q?psJ7aFT+nKcawWvqEILUhn4sjEBx36KbWF5sx2yn0wdtWnP/RkSbSBZ4zVgh?=
 =?us-ascii?Q?b8eCCvFEp7dGf0Uvzdzf5btJjjfs3Zce7rmJxfPw+urreE4u2YHIjdVC+i0P?=
 =?us-ascii?Q?VQsWfMUjed2d+jDEMVhBwc/Qtyil1WOHxOCtfAe3PmeqEZvsW5mgfotFNViN?=
 =?us-ascii?Q?ypFa0WZ8UF+Hfqww18A1jM345xOoetPp8IaAxyt3IfQiUcQkNd8SknKpF1OH?=
 =?us-ascii?Q?NFDMSD2KdWXkkwly3c67kmIIUvXcJyryFYdyqJGgp+PBVIE3IQcmKde1EbQT?=
 =?us-ascii?Q?gg7qSCFuT2BVDgucpITVdTJSoiTygn8GuGX5vvmW7G0ie8NTirpiGw2z1XSt?=
 =?us-ascii?Q?ncX2aZvbfQnemjSAKTBqdLf7vILTQe0wBCWSx8smN3E0TlvYRa6IYg3JDyNR?=
 =?us-ascii?Q?fcP9ZLtfoG6SE3BbeK4TtjRhA5UtIwpe6TmxZw5wmlnbBqH5sN5TzUXl2rYm?=
 =?us-ascii?Q?r/JzDglyIkw0t1jw+zuNgE8m84rYRjzxEyuEvmeuG/Q5eXTIqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:52.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdce361-5eb2-4b54-b141-08dcfef1f4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218

When two profile handlers don't agree on the current profile it's ambiguous
what to show to the legacy sysfs interface.

Add a "custom" profile string that userspace will be able to distinguish
this situation when using the legacy sysfs interface.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c  | 1 +
 include/linux/platform_profile.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2ae0437623abb..b6f3388b4eef9 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -20,6 +20,7 @@ static const char * const profile_names[] = {
 	[PLATFORM_PROFILE_BALANCED] = "balanced",
 	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] = "balanced-performance",
 	[PLATFORM_PROFILE_PERFORMANCE] = "performance",
+	[PLATFORM_PROFILE_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index d92a035e6ba6a..07807c93fde74 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -23,6 +23,7 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_BALANCED,
 	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
 	PLATFORM_PROFILE_PERFORMANCE,
+	PLATFORM_PROFILE_CUSTOM,
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
-- 
2.43.0


