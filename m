Return-Path: <linux-acpi+bounces-9677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0748D9D2C75
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCD31F22B84
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E851D63D5;
	Tue, 19 Nov 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wwKZUGXd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634E1D5148;
	Tue, 19 Nov 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036885; cv=fail; b=RP7PiWxz3xU8R+4abByMzWU3Va19ejT7UIuiY+c9qn1ZXUJMcURsxcMMUEeQSWMlWJtQcgEGUQ7kf+NwvxNJNjLIiGOcvSQUfZBDWSBxf7bwXZX1bqPUgK9BcTfgUv/bsyeI+PDBswlwhO9d5ocm0q+27ArcCd5Xt/4vdMvgBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036885; c=relaxed/simple;
	bh=ksb5hm91eMP5xMbwuBZ/g4WF0yYqTIq9mdxdxNxsttk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNYvQiagiRnDtenGLwv0mcLLqeJu5fMf4K3jtRmhZV30nyXhNuksyZUDhgCjicnY7cis4/YYoaxRGNU72/PovOmkQ7QA447MgAkK3Uga079JtPIWmpH+frIs6YhQ9FviEi8S0ycJ96bzfhFNuUQcjqfrlXdopEpyfvSkh8DofbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wwKZUGXd; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/C65OqjAzI8ak88f8Ufu6PfhzDR7a+VKXz0DPKd8pBA1voo/l+B+29PLDrM9D4m7shKMZTIIcHhBWAcVsgPmYwTswA/wQaJV5s/ocbUP4r36OKK7prVfHhO1FpSa3clDDYM74nCW+9hlicy5JWDbJRyYaYvz7Ne4L6gFfLMraof3eWMOYhJ+hjHRgjfh+SNcbJ76KDWG5HDcT1KzP7NpSKsLGsCBBDY5r7vuCGawk3b3VqHjoX20BjhWSMaWuqzAZX6IbqAjlHQK9hWVAJhFtOcpQjhapMjJDoSzzvk6UZMdx3zheqx9CZI3zuXgqgsoxZV5B81VoyRM4A38Ke3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6CFc0+6d4W6sohcGl253Idmf7tHdDPMClf+D9DQnQ0=;
 b=vxobHHC1dsjctDFjyiaNHcjZDT20ouYqddpIBcfslvFfqE8ry2mElSkccOhN60SG2nE7T6nZe/S2m0uEXvhRQKr77pKk+gnzonGrezext3YNK4rug1VUm2BmT5oIBmqffBlRqJ5vZ7WqkGcMrCPPS2EmOfXb54/SE+xhVuANLGM8nRnGDuz/pJEm9Z5A8Xi8/Xn8lKWiCVlD9+GRXx+/lvsIM9c9KEyRFkVHjcIe5T4adt3iRVuRaG3CXZUo/XtUo7viDBwPJeV1NiH5GVLvb34FRrN8BG93mbqlIom/iLB4WzudnKQLaasDJbck/PnXnuSp3mHsZoTv9rJv3mj1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6CFc0+6d4W6sohcGl253Idmf7tHdDPMClf+D9DQnQ0=;
 b=wwKZUGXd64EFjHOF0QWURh+V7oaUADvz5TQ3Cibbo6AC8ZwzGmeM6Hox3OE39v1665BtVVnk/awP00VEXin/WzaXD5r/MLjBC3+nFbUyqx0cTxUe0GYqpaG2eJ0/+XNRvThofV/yOnEEi06d6RspaQZNB+nAycB0DoZXfFxjuUw=
Received: from PH7P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::31)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 17:21:19 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::3b) by PH7P220CA0032.outlook.office365.com
 (2603:10b6:510:32b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:19 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:16 -0600
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
Subject: [PATCH v7 12/22] ACPI: platform_profile: Add choices attribute for class interface
Date: Tue, 19 Nov 2024 11:17:29 -0600
Message-ID: <20241119171739.77028-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33ff0b-0f57-4363-7948-08dd08be9529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jXSw30kV1770SIMDhc+03bzYiPyGBTJ0dZb9VqsrDErIWCEYFfX6mzEAK8P?=
 =?us-ascii?Q?VoCAXZSOlEK2+82Fjc76qTT9kmTfHhHPsbwhhSGQEPPu3uPpZAQEbSTPA0/I?=
 =?us-ascii?Q?tlsD4z4lf/ahogZZdzQ5hKP5FWYBCecGP1qtZfe/wzIgvS/+unTyS+dOKtJ3?=
 =?us-ascii?Q?dI7kX4DxSL1EMkkpJDnQh+uuCI/pHZENzpezDtiqSwFwtXMWP9TRxGEW7kxc?=
 =?us-ascii?Q?c+xSGbtipK09BtyFl3W43Z7N9KrLbdeJwhIdIolKn364KJXvy5d92F+il3cB?=
 =?us-ascii?Q?byxkC9/o0QpJoHIJJgf6+CtLssTrxjH7mu3gXQS5uw7+feHzVYqB3oaETi1z?=
 =?us-ascii?Q?RbhXjlZNju6keCNW9rWcjhtOmmXwnYhjWnSfdCXNIk4COzVr4YITeHJ2SskE?=
 =?us-ascii?Q?hiqt0zhkvu8d276TQAO3VaMnIF9pIbJDBSEGk5tquzpyjcNGuklf7VNYwR84?=
 =?us-ascii?Q?S1fim4TY34HeqrXSFvzwkrgRYLFsOzAQ28Dm9s/LvLxGPH6aWm/AJu0X/7N6?=
 =?us-ascii?Q?n9uEoe9pEzVY5xxIlozy9CKahdtpsP7G1EPIcnKoPUeHuo4wAB9QsX52bfo5?=
 =?us-ascii?Q?jyL+C8wSk5p0dDrK6PQvHSRRNQH5Eh+rrqnBHcBsdYX9CQkmsdIYyHfMCQnW?=
 =?us-ascii?Q?PRCnIgPtnafwauZXFJckB19BS7ExGBLbmXxmZQ3R1er3/rDS0Qap8Vdpqckh?=
 =?us-ascii?Q?qEPvs9Mr/OogZayhQz9fXEDM6K8qDCc4s1hiixskZiKL1FA+tpdDPjItezK9?=
 =?us-ascii?Q?iHjeiBFyW5BDvEiE9ZnFhBXCtikbsL0pQsD4smr64Bsf7DD0YNnbIposkVOu?=
 =?us-ascii?Q?1u+hK4XpDPEGej2aVxSWmBYXPF2SDZzgTzcYyY0tG0KPWO/eCvEivzkhWrBs?=
 =?us-ascii?Q?gVvYO6+Au+mr9B1r7okIqBoDNDELgJX+sI2kF987ITbImOqkznOeS7GrIXKd?=
 =?us-ascii?Q?Bk9aeBnPFZg6/IMQHc+EwHGzNsxVEikPUN540aMFPSd60ljkorCBE3deiSGU?=
 =?us-ascii?Q?vhFBzTiyveOMLG23P7RvDQs+S2PMCxqZexKVqv+faR075NX2mns3duKyQr3t?=
 =?us-ascii?Q?TViEMHLtktSywFMmQWpRvnQ5w0g/+Nv6vL2iO/ochx7iPirM3usMYZPX7zk+?=
 =?us-ascii?Q?3EaQpONnoiTPw5cQ0Nf8bAU7tFirsraPWH1EGf9+kVf3G927oeXdoqCTn2rf?=
 =?us-ascii?Q?OXhz1+i9BAkMZm77S0MtYvgXH57F66Pq8TjVwxFFV6PE7br+mSqsR6pIsBEx?=
 =?us-ascii?Q?kMRGJfk4p8D1Cgu+qRt1Ugk4hgTiVfAdvSGOU6IDp6i18UDKdc+2Inp9y/Ic?=
 =?us-ascii?Q?Xk0kF/EbLrssC22+8ZoXVmIcuHqh3VoOfTirGRS6NABmbDIEb18gZYKAM4pw?=
 =?us-ascii?Q?kplSmVhkNa2txCMIAsdXHNNMlK2jt5B2p5Mi3NVN7Rfk+g/R+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:19.3622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33ff0b-0f57-4363-7948-08dd08be9529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829

The `choices` file will show all possible choices that a given platform
profile handler can support.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Drop locking
v5:
 * Fix kdoc
 * Add tag
 * Fix whitespace
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a9d7ec3c85844..9d6ead043994c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,27 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
+{
+	int i, len = 0;
+
+	for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
+		if (len == 0)
+			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+		else
+			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	}
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -41,9 +62,27 @@ static ssize_t name_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", handler->name);
 }
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return _commmon_choices_show(handler->choices, buf);
+}
+
 static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(choices);
+
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
+	&dev_attr_choices.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


