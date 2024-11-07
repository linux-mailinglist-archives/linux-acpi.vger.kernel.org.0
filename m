Return-Path: <linux-acpi+bounces-9390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09F9BFDFC
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2211C21A7F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFBD198A08;
	Thu,  7 Nov 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BINiz304"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D719750B;
	Thu,  7 Nov 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959420; cv=fail; b=fsA8nF7sDUsZocwW55S7UyxTASwtBACvNUp1mL4lamLBuemRgSbn0qv1UIvvVLhd6SO7jMuwRBuHpYWNhmew1u2Lnr86SPB+rev01HdlmNX77NSjdvQtrVTRdZ6HbnZFbZStOhhfY0CSAx6LFk50IpmrbSCNbRuJQZm2enePxAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959420; c=relaxed/simple;
	bh=DDkbAG6s/28zVI9+vavafl2eH/ICGR+F1er0g86Vvb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0kE31KlTpWMXrH5VMgq1U6V8WEaeAmNuMpYn/BQtofcS1yzyJ4ipFL+mucHgXdVNJGQWpf57cd1jrhJ/Do7T4/12Zd4tPn79smncUjtn1l0e/3+kA7ClNtewh2b/eilyxgR3+IGkahOdkM65yD4uyUmgNZVw/9Y6i5QI9pxpcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BINiz304; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csQlib47aALnd/QbBRSA5QZ7tni8LaSWVaFY7fkuUO1QQfibBvVvRtijvkQxa1Pe3jZOrWXn8FGhCbM0CxFMlfbciXQ+3YoMfDJnyV7tyu9ntAJgeCgjQkjuguB1oA4DCLa+IZVPVav+c/KgNEEjEBCUULUHxXaPAmO8mFM1GHYXx9h5XFF3f6Aq5jALbyZaiU9cZEsf3D9zI/FYu/Ce6evCW9RIjE+zGDGaioBVbVqrnXj/4kFjTmrfu6g+jeUuZFS7jnY3ftEyuWd4iMnWD1dDh6nyuz1fp5UjRpzn1Qxebd22niZyGQx0dJgwrGKOovN/jgxSMn673fAuM13ppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJwrJ761+yqKmHSkFl44f4+2ZO6F8u0PriKiwW84Lds=;
 b=kHZIKTXawryPczyJr9nvOHYFTmWVHeVu9SzvVVxRBk7NCxv4JsipnHayxDLOen2y0D+g3+kin+ZXjJlv49cXtDlLl8ZKhPIKX7CC2DfprHZhWdhC8jrBZpSTc4sKOyDtT7wK0trgAhwlGJqMcdr9bwCwcwZNWxO2PLR0qBQFCbdkni2j8cx2RWm49I0O9BnG/Mbp1c/V42SC6tOSpal+xkqBo40e0aFNWE8lSOx5oMY4wQZRCXfuao98E234Anok8sV+zos2PVsYTHiq5Atj7jvHR9EvsDuKSZXG0e5kuhZ2p8uslTfCQbsKoOnsgjTG9IBKxMtChJkqyEtNjEW84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJwrJ761+yqKmHSkFl44f4+2ZO6F8u0PriKiwW84Lds=;
 b=BINiz304ZcTjPON1TUJIaZX99S7CTVTCdQuTDZLivDMtCLBY33btb6I9FMw/qVAGmdNciBDFTSvPLv1XaUjbuCKRVrKRpxC8o83oKpcUqHAFGFFICFlqZlOo6Hnxr9wvyZ/4/6H5S3HG3Ur7ODW+UaRcR3T+nOBZjmTK2hLHiO0=
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:03:36 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::24) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:32 -0600
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
Subject: [PATCH v5 05/20] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Thu, 7 Nov 2024 00:02:39 -0600
Message-ID: <20241107060254.17615-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107060254.17615-1-mario.limonciello@amd.com>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5a763e-c87e-4efc-76cb-08dcfef1eb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEIxd05IaDJCdFliM29CZHVvZnBoUXVtS2FpMUtvNUNDTTJkblQxTlQ5ZU14?=
 =?utf-8?B?TDBrU3I5QkRzcGpSVFJGd3RWRGE1T0NQR25QT2Y0SzhFTDQrY2Q1K0pFTzUz?=
 =?utf-8?B?MFpXc0JtQ01MaGZIWlp0bnlPV1dQajJnZXhadVFERnY4K1kxUFdLcGZzT0dZ?=
 =?utf-8?B?SjdQRGdHQk1PSU90SmdoS1hFQUtRUGFOWmIrTHE3R0JabVlVMFdhOUM2Wkxt?=
 =?utf-8?B?bHdkOENaTGFzQW5OdTlQSjR0TlFpQ2lnQm9oYnY0V3lRbHlOWlNIMytBeEpn?=
 =?utf-8?B?QWNXVkZCRjc0d2lFa0pmbW82VlYxVDFKUm1qb1hJN0drWWlGRnhzVGJoWSsx?=
 =?utf-8?B?Nkg2b2s5QTV0bHZicEZUSUJmWmkrNFV3cVNBL1FlYzJmUUhUTWovanpVeS9L?=
 =?utf-8?B?QVkrMzdpSXdWdnU0UWd5TjQwZjA0ekgrRkRYN0p6amJQOUI1K1YydkxrVm9F?=
 =?utf-8?B?ZWVkRTRhcjBoOXhWOU1WL2l2T0FVTEdEcGIvN1ZzeFJXd1FPK0VJaXNIemJn?=
 =?utf-8?B?dThBT1k2UmhPSnRJUDJaMTdYWTFvL294SUk4dEtBMzZ1dkFSRnBFTGwxVUFq?=
 =?utf-8?B?WHBUbDJicHZYSkZmcGpaVThoSEJoSGlGYlBBNHVYZ05XNVF0clNGT05vbmx1?=
 =?utf-8?B?OUxSN0ZzVFUvV1NyUGNlNE9lTElOZWE4eHdBbHAzQTB5L0txaGsxNGluZmx4?=
 =?utf-8?B?Nm5Ga05PaG83cmdGcnl3L3BHb0FjNmYzSEoreGJzTFBITmsrdXNNVmhkOXht?=
 =?utf-8?B?ODZjTDcyWW5kZ3ovTzFZNFFKRldWU25CV0hIZXpaMVNLc1R3NjBaMkVORC9V?=
 =?utf-8?B?UGV5ZHRmUm9leStmTEd3bndjSmVXS0djWUJ6V2F0T0YwOVJycDdaZEpSYjVJ?=
 =?utf-8?B?eGgrMVRuSlVOcHdvdWpibkJQV0NXYU4reVB1cXpGUnpHR2FaY0JUT1M2VHVW?=
 =?utf-8?B?QTR3WWt4TTNMemlKQlp2NmE3NmprUlRDbzltT1d6NFNRZlFWSi9RanA1THh2?=
 =?utf-8?B?VXA5aVVET0NTcGdHZVBxYzJISzlidlVDeEZpSXp6MERSUkwrRGovb3BmbE5C?=
 =?utf-8?B?NTJoZDNFdzUyY3oxWnYvSXFxUDl1OHNzb1g1WG1GWExITVBPMTVqSDRXSmQ3?=
 =?utf-8?B?ajNwdCs1UmtpSW1zR2ttdzlhTTg4eTIzQWFOanhacnY4c0dSSmFya1h0MkFW?=
 =?utf-8?B?T2FoUU9EWWdwR3lyMXpUY2xkUnExQms2Z2NXM0dGQTBIaVF5S3R6RzlxSUdK?=
 =?utf-8?B?eS9jc2lhZmRkM0RVNURGZ2pwOWhCVmtUTHd5S2tiRktZWEVJenFUSFpHaG42?=
 =?utf-8?B?SXJoTGwybkpoVXFQaDVIcm5lQTZKWi9hL1l0dkt2aGYwSUF0SC9XcDhpYzVl?=
 =?utf-8?B?OUxQbHo0d2pmOFhWNkpwNzRkSVl0VlRydlRTS3pRNjQ4eW5VWmdjYlZwS3By?=
 =?utf-8?B?S25nMngxbUsyaE5vOHZXbGJUS1c5TVcvaGhuTTZtUzlQMWVVMFRDY09VeG92?=
 =?utf-8?B?NUVwN09aOVVtZituTzlmNkFjL3hvUjVDK3Zub3dESkljRXpTRVd6WWlMMmNq?=
 =?utf-8?B?Zy9Xem1YYzZxUnJWNXpjWngxZlZMWEowMmJDQ2pvM3czQ0V0R2kwSzlXd0Jw?=
 =?utf-8?B?N1FzYzYzMUtOY1MxM0xmcnBQb1NieVpkSTBqYTd5U1RQY295dDY2QVhUZ05w?=
 =?utf-8?B?eU51aEVQRmUvSXRibzBrdGZQN2Z3bEZCd2dNV3dMK0pzMzVXRWJMNndwVTdX?=
 =?utf-8?B?SVptL0hCL2NUWjZDSVNPR0NOazdiMmc0T2NxUjhmZDJuTXRsU01BSkV1WTRW?=
 =?utf-8?B?c1BvcVFNZEh3VTJ0N2lQeXJVK21LYmZNQUpIaUxJRHV6SzRlclRyamh1RWR0?=
 =?utf-8?B?MHp1VEo5SkZZOVM4MkNCNGE4RDFXazlMUWdJYmJQMzRPTnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:36.4983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5a763e-c87e-4efc-76cb-08dcfef1eb3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ce3aa1361721e..fbdf3cdf1141d 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *dev,
 {
 	int err, i;
 
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
 	err = mutex_lock_interruptible(&profile_lock);
 	if (err)
 		return err;
@@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -ENODEV;
 	}
 
-	/* Scan for a matching profile */
-	i = sysfs_match_string(profile_names, buf);
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	/* Check that platform supports this profile choice */
 	if (!test_bit(i, cur_profile->choices)) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


