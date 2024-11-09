Return-Path: <linux-acpi+bounces-9469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EF9C29FA
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C5E1C2164D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245915442A;
	Sat,  9 Nov 2024 04:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vg6byXr+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B614E2E2;
	Sat,  9 Nov 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127362; cv=fail; b=HrpgokYDQkxdER3H8h4s4aYoCtK0GW25M+moswYHiys23TbedhOxvz8UAv9SlakC80KCCIorcU1IWX8xNuwjsvp5nDw0clvLmFY4fduVwwDQ75HID2QxpQ312k/zIU3716AY1SIerLXouD3qWo58Tk+ecW2Ov8aMes1pP+yAMWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127362; c=relaxed/simple;
	bh=HGDYb6E3Ep9CGITCDX/pPIR65jpsAY74b5ZZzMATpFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpy3z0jucT4BybE761ADQbB2vaTZBqN24NjohAzLSAxiDv1yuslJ35jz6rnyEcDsz2VkKzTQNJ+AsLeW6PkeEcxNB7AfOLW8JGRSrnUSI4P+G+KXSfQtCQP5mPITUOuqycpwAHuavsq6OUd/jL8XoKMvIIdD1QcaJuu9SR+OiNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vg6byXr+; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL3VgvL5QYp3mFvWRkbKgAG4EQyN1w990kTg8KgG0BjJ8mQOzEUlYJjJ7PpmToAQW0pymjobSZRO8e0/KKCcWD/HPdWf90wx1Owd13I+iPMBwKPCzsTraBre8hMu8WJxnxX3CqJevgcF5IiippvJv/L0bcF+xHWMY9ypmAIGE4N0ZmHbMPTDJ8gd1cma8NA17ps3bfLpU+rM4E4wC2PGMZJCw7AUP4rZwsISZ5CR5IiCh/Rk7ipPIgHxlaszABtGvwBKQ3Hp0VpCODv0AP3yo2WsiuhYdG8yvhzNAgcXEmgsJhrw+LZYkFjm7UD/T1TIqPt4yO4DRSDohUrMAtK94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOXcBrBLAH9/3L6MbvMpLc15RNFiukcUladgc2K1Irs=;
 b=IxCYn3iu1vQMfLZBrdCfLEyCCofWyIxhrxakRrD9qsPkmAMw6vvbdKqw7kiDrxMYr469Ui6QSGltNPSti4gRlfnUPcjOpXQmZtbAu/aMNUtwgZichm2N5J+TO/98OxWAeqdEbQZolwZPNzzxOLacY98cqokbCkmcb5FQdIWRoTI2Fs0utOA5quuqCYPiWhA3fHrF57Rj4Fiwtw5hFxamqIeZBCRDWHtNsWgi9s1CY9QXWy/DqDo5UWQ+4pN1H7U16awP1zQQW0hgeGr7IACLsGmUZso2jWwCTlOm2EoEPC4Rz7XLhVbiwgfig51yU/Cd6jqQAEGg+Qzpm6iQuG7eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOXcBrBLAH9/3L6MbvMpLc15RNFiukcUladgc2K1Irs=;
 b=Vg6byXr+JSSw0rvmkAGju6yEWm9+hMFb2LZFyVHRtZDCnk3MKzFOpL56mOM5EsPwMdK4YlR+SxB3q/4QGo4A2MJt4Km1RgTfccA3qT3fg/r+Vqmpxcnf1lePP0VG7uUVoVu8ZArUDJMjMvH1vRWc+wKBPCXbjstGzJpbkj773ac=
Received: from SN6PR04CA0096.namprd04.prod.outlook.com (2603:10b6:805:f2::37)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 04:42:35 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::c3) by SN6PR04CA0096.outlook.office365.com
 (2603:10b6:805:f2::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:35 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:33 -0600
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
Subject: [PATCH v6 11/22] ACPI: platform_profile: Add name attribute to class interface
Date: Fri, 8 Nov 2024 22:41:40 -0600
Message-ID: <20241109044151.29804-12-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2ef65f-6756-4112-7808-08dd0078eeab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1dJI+7yXu88LGjn2IxnW8dKqCKLsEyh3YaECzTc5G3U5lSI1F+nRrwUdSmH?=
 =?us-ascii?Q?Vc8i4t+MAvtidgV08i4HuQzKpwRACvj6BGEN8BLVIpPWWNHJZlkVy2JMWCI1?=
 =?us-ascii?Q?RH6YPHB0andCFM256p7fME2cWpt/9nUWzImYdGUimDpME/084/Fm+Hsb87jc?=
 =?us-ascii?Q?9cWvCxjByXdxTsxhlVj50SrlHhNkV2qCOFaSRQVWl/akLfXTewZ6C5aRDRtZ?=
 =?us-ascii?Q?n0MivMiglYuj0putQzcmJYqF/sebbB+zn3LTF9RcOxdM7GtsQUi/LgZIWgd2?=
 =?us-ascii?Q?Nfk5DlqSqfvSpEGbBj6QU+JcThvIsZWhxez+BpjKXoxApbpP205yNAaEPLJ9?=
 =?us-ascii?Q?zkUZEb7IozEdIR8ZmFC0jklFo9DlR2Qu0vR8mWOj5H7ZUTFWyDeFGBuvaDYf?=
 =?us-ascii?Q?9mA2GzeS4hLjoLZ6vhQLaRMLwZ3A4SLlUMAA1AdkatgryxcN+7f4BUnDwoFK?=
 =?us-ascii?Q?Z34rz2sRpz+OVXU4nh7c2cscYpmuG82QpIaub86e2fB9RBofVYrmsZ8ZLmk3?=
 =?us-ascii?Q?vj71YbRPfkFnyBzPX7loBCBpd2cmxUKIVgPirQVp/fOMA3/mlrETE0IW3bEj?=
 =?us-ascii?Q?e3iwiUeEuOLWzY4NhQjX5Vgm91OmVi5bUTVBOH43IudzQBpc05DXNEKkVNHc?=
 =?us-ascii?Q?zEJ+Cyvkcu/v4N9D86jCsrAeMJ3OcuHwr7RXXu2zCbRMTaQTWCIX58U5CThu?=
 =?us-ascii?Q?Ewxs5kedN6hJ+w8UNr8TWv9AvHSR48QLyq6TT4sgDKWRKASoO4i1NK6aM/wg?=
 =?us-ascii?Q?SlZLFdz/z3/2Yg0Sn6u91vhW89akw/L9/1XexEwn0hZTvYLpnRqXR9HkhWY8?=
 =?us-ascii?Q?3bkJoxH7CbQbsLtkFKaD0hH/T3cZsxy29BTn+HBKi97if/aS/Vys3hCe8gKf?=
 =?us-ascii?Q?JC9/MeICfZz1yXfmANH8TeR7C1TzpWnOj71ciIEwWY/Gf57fMO+cyLRmxE9q?=
 =?us-ascii?Q?SOET/weXb79iXzlQKIYVhwOl6jVXhIUgxp3ipn7S6vml/WSOczQuLAm/NP4z?=
 =?us-ascii?Q?mRg1/x37sAQ14wFtR/U18ozHii8rZjIIir1F7m2Y7bDoJotOjrjstO6UEKUb?=
 =?us-ascii?Q?FKy7AXKZllDksR0oACQevSknmxPJVPriW3dcVVPuguccvO0tH78F4Dgzgys+?=
 =?us-ascii?Q?mAya/72jRSb766xSDvR3CuJ9j5FDALhNGF99ZEv3IoMk5MlMcUBkoTHy0bBF?=
 =?us-ascii?Q?oiQXV4o5CQG2o9uSsfTvZ4YL+34Ok0YF0dLiad9bz/HDbTBVM2MtihGYyYLq?=
 =?us-ascii?Q?zuz0bO9jBFUj9xyWguFSuhSeRtjairHhx+Nw8eqwyMeJ/v8ilzIHGmqq2pJL?=
 =?us-ascii?Q?CP6O1vrLW3reDGhEBNjiZYUguq92oUcdp973llbXKwIamanAJdOIF4Ykiz8+?=
 =?us-ascii?Q?xBRhot89PtFV/9tDBsJdmttaAbI3kFZa6eqnqO2N/G6LO6yCPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:35.5831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ef65f-6756-4112-7808-08dd0078eeab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ef6af2c655524..4e2eda18f7f5f 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,35 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * name_show - Show the name of the profile handler
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr,
+			 char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		return sysfs_emit(buf, "%s\n", handler->name);
+	}
+	return -ERESTARTSYS;
+}
+
+static DEVICE_ATTR_RO(name);
+static struct attribute *profile_attrs[] = {
+	&dev_attr_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(profile);
+
 static const struct class platform_profile_class = {
 	.name = "platform-profile",
+	.dev_groups = profile_groups,
 };
 
 static ssize_t platform_profile_choices_show(struct device *dev,
-- 
2.43.0


