Return-Path: <linux-acpi+bounces-6952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBB934FDC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 17:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40919281DC7
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2024 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B0614386E;
	Thu, 18 Jul 2024 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tdup5Dii"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4312C474;
	Thu, 18 Jul 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316243; cv=fail; b=Y50XV4nc1RB3D58zgqNNh83WqM2oAnUCEN5yxpOdjMFskDsoYIay3GXW+PZOGdez6OKys13+rZkIE9Ln/FABIihcopBweu3GToxtyHCIojQAUWJMmdbGLjs+vmk+biwLeOyUllLZudJfC6ZAcsCWA4MBdKh0E5arjsMdm77TbOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316243; c=relaxed/simple;
	bh=qe0My/fS6ORb82UBUClc8ewlAf5PUdiJxr9PXcGEOoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ui0wbzWgdfNkf6r3iSlLivuDEca7343/unSjAthls/PQLG18dLHmZjCgwF6GyFTZoPq9lb7LVSY4gibslBjTuOnMHEKYSYdZC3Te2A+SwBfDAzd9mayEm8VFhtN+UiafFrHpORUoe+mdTOe1CIh8nHnn0pwvTkeqcfGH+nMQENA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tdup5Dii; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkeeRuL4nffc+ztUp6uAir1y5DirTzLjM2AhPvgy5qM1LmTMBap56LV2lgNIE9RjuoLpi4XMFQL/6sS/2vFg4PGpjmngB8u+c+XbI2CVnrHCnjwhX/qxKn//HsOHtJlAO0NfHJ70bKG0qTJv6WAL+694Y/oQPce+PGOdr2MvcOY+7pVet8StUyhjvMcb+KbiH7VmPOUWFKJFKU7HQhct5KGV40eP/pk7fKS7AP5J5NaSu/2xfPd2ovPHei6cpUqkj9xFkJJ6VMHLOoMphk53ezJKfHh01vlApp0lN9x3PEoq0psu6vXgxZJc8Sy17sv9PUG6aRHvVBV/MK2fA3xjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK/T/mEu+GsotLmJv+cRS4lxGWytNi5SI6FRCdOAS+Q=;
 b=dzJK73CeMsZJacsJed5wvkF371WCTuz4mrP43W8tTLLpEjXNayLa3rcUwAXTX0+zbHZ9GCcHmqkl5upOQs1ZXe/jqAPZ7DN/1RfMMQcumacFuJ/OBsq7wvg7d2vpyQM2b/85zY14RONXDU3HWCICf5heujDIZ3UGSJwGOZtp0gNC7Me0+Y+JLzm9FMYxCl6EIC8DZpCd7avgEEG/6gSz6GbXWBXaQ1Cl1rNBwjOFOAUbe9F3Zvlfhj3bc1r1CPR4zBg6HnxcozhTu1P8GKImlTsBktJ8hf8SpT5+ghGsxXGqfeP5qicnDu9/EgPsQa+Q+CUDgAav66lUYgq2i3zn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK/T/mEu+GsotLmJv+cRS4lxGWytNi5SI6FRCdOAS+Q=;
 b=Tdup5DiiDs4kU7GSnaT26Ine5HR71qOm1OIg5rYOu90uKBSOcZK9F0gTnuC52gMXz+sn5+mc60+zpY/Fx9XueW5F9SdvQSVuSEHRiMwgKKX+O5gZ3RlYFczE9lny5rb1sJaRk5sXRp3zQ1GU5dNriGudLuGRISWpoeo6wppA8ts=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 15:23:58 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::6c) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 15:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 15:23:58 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 10:23:55 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shyam
 Sundar S K" <Shyam-sundar.S-k@amd.com>, Sanket Goswami
	<Sanket.Goswami@amd.com>
Subject: [PATCH v1] ACPI: APD: Add AMDI0015 as platform device
Date: Thu, 18 Jul 2024 20:53:24 +0530
Message-ID: <20240718152324.3449253-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b6650e-6722-4e19-434d-08dca73da54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?beLUUpOOO5BZ2jpz9+PUAE1fThYb2mpzRdE5Xg2HkL65CDj02kxxdf6alAVw?=
 =?us-ascii?Q?u8zC/GQXEvhpIwSDpGv2CwWTS8dcj9rJ8DX6PyXmU1ob0hxRt+mQb6338D3/?=
 =?us-ascii?Q?+ojzwrFxwncSxNGK2Fc8PHUmMDRJDi2VrdElQ7H8Ft3guciT1NUWQRi0P+m7?=
 =?us-ascii?Q?2GJ5H16L11075d8iUSvdbrukInNKnhNE1NyxkGij7/Z2KGi/7esJVkrvHxFa?=
 =?us-ascii?Q?9PgMCF3BMbIkWmz8YSYlCs4oJkoRthjgchQ+XLupENvZpTUxvM/Z8KYEyB3s?=
 =?us-ascii?Q?qy5fSexPrO7HQ8yZ9IRmhVVuad8JQ5k+UcEfYRv9VSGOGcEtKRNa9PixGkBu?=
 =?us-ascii?Q?xAcZhey76/LVK5DS6fTaumlHMl0MnaOUXiHkGeZK5Kkna93MnLXXg/lig0rW?=
 =?us-ascii?Q?fuCfhJCpCYaEatcbOTvzxkLMngatYCuPIu5GaCj7JeoSAK/bS6UwRV+Qoeab?=
 =?us-ascii?Q?sDqH6pxvcXtIgOchcVWRsNQHs89CuR5uTyxUSpxtoJAQN1i8ExII9IK7V7JD?=
 =?us-ascii?Q?eznlBzTUhhbMBntY+dpxeqOfYo9u0eGqg6hr2dpKp57Pe5bZqpQFLr4WTWD9?=
 =?us-ascii?Q?trZDEN4ckqw6FlTfKHVVWobDBVvXR44xUBON4J9qveQZJwCIf2k1z66/OnpJ?=
 =?us-ascii?Q?qXRUc5LMAeTaOv2iRnUxfvKWIdOQQ3//WD0QQoadaWHVPJzUYM/h96/SVfEm?=
 =?us-ascii?Q?/GZPsJC2suG+DmvinG+4A/ycSvRIcDOIYE9UYY6MUHyxwA1XOmRt63FF5dGi?=
 =?us-ascii?Q?Ac6qE9ZsuKeUbo2/DLfmBijD5Q4VMRmIKuCCxDYGfze1IjZpfxOMsNb3yoJw?=
 =?us-ascii?Q?ZmBHV+632yHg8F3YMvt2ngKDj84bIGbymp6b8cWEVWHhOFmAuxHEemtSJ7BC?=
 =?us-ascii?Q?R9hCzNKWtDRV679jND8ysmh2o8tfnzXWaSfcX/vLoqhk4yxnyZvWxfl904u7?=
 =?us-ascii?Q?Sn0L26KQWP3eMeF9UodtGk1wfZ/RK7oOaVHMIRDCWjX9rMYOdwpVUaMDNMux?=
 =?us-ascii?Q?I25QOQYxYdA72aV/c/wiSofswlW40geR27ESMH1kXi6Q4CBtZ0l0XZB/YwhR?=
 =?us-ascii?Q?YQJDzpkQ1b5qwGbrzOldGJYb87VtnqHW/vmzt3WFDwRN8l5Cntogrp4VpOvI?=
 =?us-ascii?Q?3ByQHOnZQ0UlpFVslD2EwyHJ0EJwdpTk4Eefw/dOiQIDRWm4yb34DLdgp+3A?=
 =?us-ascii?Q?tn8uCITGrxVbQ65fBw6sXcJ97+m3hMa/Qwb8l8hBoxeU72yV+zYUaPDxasAJ?=
 =?us-ascii?Q?Shg6rGJPTZuCGxRJ5Yn/Q0HwqaIzm9oRDL9/PqSTC+Ej7wsRGbRTPUgXJ0r9?=
 =?us-ascii?Q?d38Lu7U3JLWGTB4TUfLyRJoQMluVmLmyjobjTDFcIfJvkYvFRCTqS59fUnQi?=
 =?us-ascii?Q?vOFhGOdkCqm9L3Z/B3g66ZTmaMdJnn4bCU8zfQybafhQ1mbZ6nBVrR9ApwOk?=
 =?us-ascii?Q?j4ageQvOuj3QFCA94C6GDDPeDuEYIs5i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:23:58.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b6650e-6722-4e19-434d-08dca73da54b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236

Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
for the I3C device on the latest AMD platforms.

Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/acpi/acpi_apd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 80f945cbec8a..6c502268879e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -118,6 +118,11 @@ static const struct apd_device_desc wt_i2c_desc = {
 	.fixed_clk_rate = 150000000,
 };
 
+static const struct apd_device_desc wt_i3c_desc = {
+	.setup = acpi_apd_setup,
+	.fixed_clk_rate = 125000000,
+};
+
 static struct property_entry uart_properties[] = {
 	PROPERTY_ENTRY_U32("reg-io-width", 4),
 	PROPERTY_ENTRY_U32("reg-shift", 2),
@@ -232,6 +237,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	{ "AMD0040", APD_ADDR(fch_misc_desc)},
 	{ "AMDI0010", APD_ADDR(wt_i2c_desc) },
 	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
+	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0022", APD_ADDR(cz_uart_desc) },
 	{ "HYGO0010", APD_ADDR(wt_i2c_desc) },
-- 
2.25.1


