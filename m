Return-Path: <linux-acpi+bounces-9477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530A9C2A12
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CE8283F42
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB813194C62;
	Sat,  9 Nov 2024 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WKj6cWMm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A26194125;
	Sat,  9 Nov 2024 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127383; cv=fail; b=MaZ5fKzQONS9i8n2uO2gw9B1KdQkTDeMLom0dRv9g7pHIOBiX8CFVzkZaKHqhmeiRYoZN5zaa2h5u0PlNYcY+n0VXg+4k24LTD/PpyECGRTaOKLtjObPGLFhKFfVFlfbgvq1cL4SYyMKnZNSP3+SslnJzPaXd0AEwUy2isd/2IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127383; c=relaxed/simple;
	bh=bsZ5S0XqXIx6iShhLJvyj3hXrAuYsaqPy/0QTkCK938=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7C0C6tgswAKr0t2UzgodW1HobLWNFok6Bm8SgZM+CP5ZRAhbGVnGsfLexnQ6jWguk57ekDSWnzAsDELszrsQqhcSEHM+vzVdAlKaZgpRXHNCvlzmQqJkoaPpx8aqY0MWbpGaP76jFS1h7MGs6Dv5vrWR5UTkDFmUhx/FRDlfXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WKj6cWMm; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsrbLHfJpOSZumFsK27H0MUa7e13/sU7Eodsv3ueTU8hivmQeV3sBrfskDI56NGsSjVMh/AnQJf5gTzLY5ffMa9+ydCkYAa8geKhMOKJZ/B8oARSxS+qNwKCr8MyAuAQDCXUBtIvLd1MDBX7S4Wuj9yHqs8D9e4vEe4H/xyGBpn+e4T/D+TEm1BFafsDC686BO+5HnlXZdE39uuPI7wlWZObEuNpv07JZQ88G++kLavWYXTr4syZJdUeiZ0WBlbsyshMJqxuTOSThxKJwCfReFQg6rj/oOyUhs7jM9Qx59dPuoYlvqX6IkknqpC3pXSwSD3UxVEr469Tsp0CJDNqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAhosvhTd9HzwxFi/2c19ZuT0eHX5TvU0LmaRci9rSM=;
 b=sUXX/Xp6b8R5ZN6VeFFToofqvzThX0wH20JC+jsnIQLCLxYwNbbZG+QKDCS3EHVcArqCRhKFnDTdJaalgXFX0ACbDrV5QNwG1J4qRhKYSMiPDNJMfiODZ4LttO69oqMwFypoQpO6tyq2TcAFY0b20LUnEgPrLCQ21ezp8tt5oLbkTiBkP324rR8YFtLeADnO800MiSfAb8AblCrsM6XogwbhQfVhiw4lYmotZPjZSnGhyKW74qCCyRscfTm5xBjVJgQeBka51tZOzUN93s8GHVPNR24JHh2S2sw11Oz1Dmb07bIZMFXKRifdz5MslAtaHViXBP2oWD58OvvreTByAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAhosvhTd9HzwxFi/2c19ZuT0eHX5TvU0LmaRci9rSM=;
 b=WKj6cWMmrptuHVDtxr6v4ADbUP8ISZCDdvZqYalORypjbuxG16s0jvDVQvB5OTG0xNnbqUkjEFaeg/+3uaPGuP4G1InTk3cGjyj3Ybv4xUNUwjGquRd6zuMbNX0fBRnILwN/LDPA8ll4LnS4peGTdvnaZLj54KLaYY6Gku1yYcM=
Received: from SA0PR11CA0176.namprd11.prod.outlook.com (2603:10b6:806:1bb::31)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Sat, 9 Nov
 2024 04:42:56 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::e0) by SA0PR11CA0176.outlook.office365.com
 (2603:10b6:806:1bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:54 -0600
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
Subject: [PATCH v6 19/22] ACPI: platform_profile: Notify class device from platform_profile_notify()
Date: Fri, 8 Nov 2024 22:41:48 -0600
Message-ID: <20241109044151.29804-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaed80e-568f-4178-f5ff-08dd0078fafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BStWwf7phVdXShOdKPDwNGrNYWq0V2JhgUOBQ6NQKN9EvkekpAtBc5Nuewuq?=
 =?us-ascii?Q?8iPiY1iAHFjqYh14YK6ho4ozevpf5JXkygAxn5BhZ/h1t8OLjAkFYI5rxV8c?=
 =?us-ascii?Q?4fk1kLYJSWOsDDOOpF5WgGh6bzAhAOBnbT7NYNOLqzNBL599R/pjymhirjup?=
 =?us-ascii?Q?M0BApE57e7R6iE/5SK+Q1Wxza7CiEIJCaHDJJbFU2s7y9JBx6iM8wCGftn2x?=
 =?us-ascii?Q?SsQ77zjBC6buaLcuQKCyIVVoOPdvS2TmhPLeKi37QLwsjUCImzL2ePJqHdjx?=
 =?us-ascii?Q?xzdzd14zVFRzSSF+3LNaIMtoA0MquW6EjQmAr2NnQz7rdQzfrYrkjIXZwwm/?=
 =?us-ascii?Q?JoRkpvrmU2PLZP4pHa/hkwiFAAkj9jvNGH6+wns4q6IaFKFwLSb51CMDMlqF?=
 =?us-ascii?Q?VZ85cCnVj5QzW3Dcm668W3i9RQsk7pY//uFoY/DAaeLuzS3MKVRaqhlPaUy0?=
 =?us-ascii?Q?MclijuF0OtqNmhCXpInZl4jMq4dhcpTWIbi6++f9vb2kND9IXDmOWHUM9we7?=
 =?us-ascii?Q?5SKZLmGSuD7inB1RkCDZXDyVqeLkstg0EzauEPvoW/x/k7gGKV1WvpDrZCOD?=
 =?us-ascii?Q?Hit4FN1jlMWzNiqghs5UzhVCENiS46OIRfxjd70f6RDPZpH55NTvgo+VwDwP?=
 =?us-ascii?Q?FH6gOX26kRo0+R+7StOe0Jp/aO2jMIY3qB9dVNcHCKiIEmuQyv4kZu6b2qei?=
 =?us-ascii?Q?3XTCTQjI3NivPnT+nY/9raVIytQwXK6iI0i4AD+KRZ6A8XINojo92PURP0El?=
 =?us-ascii?Q?qKekarKtpr8vGssclu3aRh13HnYaNB0S+/nq4rNNPv0cDWuEAKyjaFsXYdVB?=
 =?us-ascii?Q?SwTAiEoqeGbaFEgyePYFsTqJ9GIysutrcrgE9TeBVo6kET7aU5gVhZtB44tu?=
 =?us-ascii?Q?02byNFo6pKn2Sn42TdGmB0QBZGKRY/ubepmatsZTRFNKVPUx6Gw4B2OFYl2G?=
 =?us-ascii?Q?M8EzTLKfVg+SNPqhbqnj31RTJCfp/fUT5wAk7yr8g/RntmsYAKj1Aksp7np9?=
 =?us-ascii?Q?xcwlkRdrjpCs+usAiM3no8qVRTihPOEL9CttZJtVhzaTfHrCQ9psHn0BVWuF?=
 =?us-ascii?Q?+lWyC6rnQ6Mn/y9YiYQ236tMybcvRD3FpisgnvmH1ppkPUZakh20aGlTx6Gb?=
 =?us-ascii?Q?2Y0y+sYb9M4AwDN680oP+X2iUY9nkxAeLBLQJ3UMZ+UAuFKmjc/x+6Kbws7T?=
 =?us-ascii?Q?qHQrmS6KyNgTeeqtu+60kAUzg1eZ1wna/K4inYSH2E9fnrtJr82Zt+6OW+j0?=
 =?us-ascii?Q?0dR/fsJk+V14F5+zymXFIM6kHdIFA72tR6NPO5ex53LJKBEZFPnxKHIgmm+v?=
 =?us-ascii?Q?O3/W6rxIFR/GBd/AzNMQ5sXhdtCOMVuUOF9i7Ab3UaRqx1mx1h5j4yuBtjW2?=
 =?us-ascii?Q?i5fbVXSeSe5dwDEmx59lUa/JEr1OKo8MN8+Rgx89OKsak3ATCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:56.2523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaed80e-568f-4178-f5ff-08dd0078fafa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

When a driver has called platform_profile_notify() both the legacy sysfs
interface and the class device should be notified as userspace may listen
to either.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c574483be4fd1..7ad473982ab11 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -417,6 +417,7 @@ void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	if (!cur_profile)
 		return;
+	_notify_class_profile(NULL, pprof);
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
-- 
2.43.0


