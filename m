Return-Path: <linux-acpi+bounces-10004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA19E6501
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8597289932
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59881D63E8;
	Fri,  6 Dec 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOpy6c38"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C41D63DD;
	Fri,  6 Dec 2024 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455591; cv=fail; b=KJ9lGuxUQnzZR+rGO8df9sGYgrHLb5rBlNY0GaRHUJrDnx2offEHinIPMOlPQkdsgSRo4r0tsMLHLt/44nA11eOxyocTDQxADRI9pN7K8DJV6JdtsGYtYj01UxqYYRytaK9vcSxb25rxbfJaBtp8z4pZI+2qBJ8MXMau/CSfOTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455591; c=relaxed/simple;
	bh=sGbhaHKnxUCeVfIBw82qjrNg9XZ+yXrpKwhADJks/s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+9dgme9M3JZmv4nKI4bcIMNBdCeUBN3FVpQwnoumueUi3yLMq+I0franbMiA2Tgu27Mm/EDFbtrQg0rbLRT64+TN62EKrRoFoMF5H5CPB/Z8R3UB5Fq+ibMTYN3ngznocJmB5/0SjVnmGaBYwkNbo2muL8/CbpVSEvUMAHw0p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOpy6c38; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOAkc9C+Pk+JRJkQnPvnc98kKsS46AbEzukw6C/QgI6oIZFwVQX/ZjVzO4rfZT2PcLHgZXXBAR/qY699qS2lehnDhZuA8pI1zVMyp+PTeRvav1lR91RmiDvmtDy1bqrONWCGmtmyCfcIaXGbrNHGk6c2lCN+yijHiCfpsH+RpGZB2KxJLi+WQUFbN2AkCj0QcKdOAiFBqn2Ad0VH2fcytSiKj0VwFi+CUH0VS3ukOy4zjHGhTGOuT2KmtudFqA91hfij7Ra5654svoetV9AKjjQJdW1bZBzmStA1uNHR7GnzwaYGT+vTrsb7hLkkAWJAUbAOl/qp7fSJ/65Vx+LSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLxGtY8u6XPIuvTDIyjdhEuXrsUsoVVsd3SCaU9OYQg=;
 b=cyTChPY+9wgB7yJrpZfS6tzyJ/zXFJ7cyD2S7XY/blVOQZdoBR6wCIWzsOph57hbEZNKK43Aj14wRiSaG1Xs6aDZDt28Vho0/fcjZUfRzuouQ+aKYhAgPzT+x5dACn/PwIhm2riuMCIF4NZ076x/b3HOnOVzm/gqI43ZNYe9ovhd65pdHaNpbL4UDNfIWTJfMZdNgVJ1kUWFMi9UkdJzsEPCtSvZkofm6JAVRR1G7MFyKG/T78kqievfmL8ycLg9orGUli57uowl5apBy3LePEzOsJJ5QLN00CjyQdk70xl7seD+6K4d0uHn8RC8BqGTLzOol3FhyYbVaAOxkKB6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLxGtY8u6XPIuvTDIyjdhEuXrsUsoVVsd3SCaU9OYQg=;
 b=AOpy6c38LXWUdLYknaTWnTUs5kzwE4L8QWG5sfz3P2NhevXgdt6Xw0DJ6ljei8XbR87A35rzB+KscgC/KQ5YUIh6KUJdLP3hKh9M1Mt/O89ohcqRUIZ/DJeX3debFkfZ5I6uP020dmyW58W8ztB/3gnWGpCyAL8zlNlMx9ZEJwk=
Received: from BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 03:26:24 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::88) by BLAPR03CA0021.outlook.office365.com
 (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 03:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:26:21 -0600
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
Subject: [PATCH v10 19/22] ACPI: platform_profile: Notify class device from platform_profile_notify()
Date: Thu, 5 Dec 2024 21:19:15 -0600
Message-ID: <20241206031918.1537-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a89134-6688-475e-c3e1-08dd15a5c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdmVzF1SXJjMlBpYTNTODZiRC9XTEZrNUc0QmZkcEJaQjZjckpjdXBNdDBV?=
 =?utf-8?B?UFJLaXJiUkxZb3l6b0ZabC83NXZRQnRkS0dxTkpxRHA4bVJLWlRaYk5NMlI5?=
 =?utf-8?B?bGdGMVNPYi9QUEpDUDk4SS9rcjMvOUprRjdaTU1ReWkyTHpiai9FQUVOVGtj?=
 =?utf-8?B?KzRDZ3JENGJPTFZTZ3Z2bGI4NGFLNm1ITEV2cW9IUXhlUXQzSG5sNkdEb255?=
 =?utf-8?B?KzA0V21DRUhJb290MWJjTmZ6MjRrZVRzeFdYbURxeDFUbHd4d1ZRTjN0NUpH?=
 =?utf-8?B?NGhuaVlrM1Zsd3lpam1DTDh3ejRXRDdxU1lsMlpVamZYd2s4RlZ6Misvak1l?=
 =?utf-8?B?cWZobjcwZ3FFSFU2Q3lZL2txeWkzMGQ3TUJ0QU9JT1VKbmJuK1F1ajBFUFhr?=
 =?utf-8?B?UDZFSDRKU3lrY285TkJBVktoUHRmVnM1eHp1cG9qNEZnRDZHYjFCOVBQYndL?=
 =?utf-8?B?eUlhaEtlRmdqdU9QWUZ4WU5GUmd6VDdqd0RzaEd0K01WN0xxd1NVRjl1dk1k?=
 =?utf-8?B?UXB6cWg5OG10QWMxOWNWU3BPZVBiVTVsRWowQXpLN0hOK2ZZcE5Ka0syNU8r?=
 =?utf-8?B?ZExtT1pMS3NnaU9RS0lVM2FHWkJBRE1tRkNYRmJIeTd3dFpROHZrbW9MSVls?=
 =?utf-8?B?dU4zQlJkWDRYQWJzT21zYXJjVDVXMWNMelBDNmNZeFJzZXB5dWZJM3YvWEcx?=
 =?utf-8?B?eU1UUWFzbElaL0p3OFdQcVNROStFOEhQUlQ0ZHZ1aXVnZ0VkYzFweUk3cTNR?=
 =?utf-8?B?QUc5a3RkS3lWSGthOUJvUE5ZaXBwbGcvZGdVaTgzcitoY0MrM0YzMWppaG0r?=
 =?utf-8?B?YTFZRDVqRDI4dThKM0RDbzBkOERQSnhPc25sWWJLemRSeTVJOGhmM3phazVF?=
 =?utf-8?B?eHdnYXVGMXMxSGpYNXUwZHJ5L2syTjV0YzJOaitzS3gxbTErdG1xMitPYlZh?=
 =?utf-8?B?RnU3Zkh5QXpVNElheG1wb0RtdXEyZld6Q0dNN05YU3hlb2wxRzVkZ2tleWYx?=
 =?utf-8?B?OWM4WUpVSWErUEdEeDIxQ1JGa2dRRjJHWTdKMUtBVTlaZUYzeWtvZElSajI5?=
 =?utf-8?B?RzlSWEpXK0VvKzZjMUxKVXpscDNGN0tMcUpBUmQ0Z21aZ3UzRW1oTElXcHN4?=
 =?utf-8?B?S3BaZEhHQmJNeXE2eElxT0pwS281NzNOUVltV1Jmakw0R1oxSUVuQWxjYWs5?=
 =?utf-8?B?S2ZpNEpyajUxZUM2SXM2Sk9udmdIZ3g5Njh1QWs5aWo2SXZwSWlrVTZJcEdn?=
 =?utf-8?B?QWVXOGFETjJVZW1Va004T3VXVWpMWlVQbXdsYk9rV2xIcEdVM3ZCdEZkZGk1?=
 =?utf-8?B?b20xZEEwTjhWV3UvNXBlRmg1N0NnZ3pSamdneHc0b3BBL0pMNFkzZVpoR05H?=
 =?utf-8?B?amlFdmFBSUlKUkFGME9UQmg3N2tVVjJMbkl0NDNMS0UzZGJWcWhEK082b3dt?=
 =?utf-8?B?Rkc2RWlaM3dQZ2poYlFTcSsxc2xtZHJXdTUxa25oU3Z2SmIzdFFDK2FhbTRO?=
 =?utf-8?B?RlI2OStma3h6cmFiV3Y3Q1lEV1VDVVFXdEdLaUYxekYyQ21qR0dlZDNJaEls?=
 =?utf-8?B?MWIvcjZvL3NWZEc5TVI4RENyYm9TL0tPSTF4ZElRTVphK2YrV0U2T3RGcDhE?=
 =?utf-8?B?WWhkSXZvM1podGZuYUZmZC9DVVFzYk5pUllKZVZUVDlXVGdwMGs5blVZUGdk?=
 =?utf-8?B?R2xycVVrQVpJOWMra2ZnNys0Tk5ib24wMlJVb2kvUmNHdDdxQ01WaURRcXFV?=
 =?utf-8?B?ams2SnFjc2xWeU4rV2JIRXQ4Rm02bjVhRzdvYzdrakV6UXMvL0Evc1JocnN1?=
 =?utf-8?B?dTVQZ1d4RWVpeUxHZ0t1UThzUnE2Q21Cd0pkMnpjQnpMN0J3OWNheXRPTmpO?=
 =?utf-8?B?dCtJRUxCQ0dSYXVseW02ejFubEdmbHJHZm5meGUzWW82TWloQlZyeTBlQy8v?=
 =?utf-8?Q?HDpF8xaqcbLwpy/JLmo+NDMsqcRnPvUO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:24.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a89134-6688-475e-c3e1-08dd15a5c2fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

When a driver has called platform_profile_notify() both the legacy sysfs
interface and the class device should be notified as userspace may listen
to either.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a1fdc56537baf..e105ef48409ec 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -412,6 +412,9 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
+	scoped_cond_guard(mutex_intr, return, &profile_lock) {
+		_notify_class_profile(pprof->class_dev, NULL);
+	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
-- 
2.43.0


