Return-Path: <linux-acpi+bounces-9396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6859BFE0F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 07:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15FC281D76
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803011DC1BD;
	Thu,  7 Nov 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czPmi3XN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DD9194A44;
	Thu,  7 Nov 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959433; cv=fail; b=C7ZOaE09y2M5DSuoAjjxFS6v9nMMWZXhYh+tRjhDCrtr4Eh3+bHC5TJdEzt+418RGrzhAUQ4IYGIRdPVX51YxDgU6IH3Ybhy+ao8ZUE04YndgWVnKxPVNBlvtp4hzuGZfmVOT6EWiK9ayuwJ7wvl77HGcHfAaRwNZranz+O9Gnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959433; c=relaxed/simple;
	bh=/J035DqGcKwrpg7UOyQsQjC7qLIPU4AKT/W+VfqOGHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMQM8Kegj2ypMcJVys6t9eb4NXl/L+JP0HNoBKve+DKr2t24BNTiu2GHGfKX6WgQ5VJIXzi+bIXrrggZ8XY0zoq+GjE1ECMb4cCEXwPHZ5cVLWmWn74W4Tddw4I0l1iqwqcSUcLJ1dgWhNvYpXzcVjpY4xb8/+Hwf9lBfgJsYG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czPmi3XN; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFG6mHH4cdIO0naquAZhil7EqDfFb0Sc5xUXe4wbKFFBA1XIRgi8c4H9bpwulfW6AolClrvcdeFYM19e9vXokjkUnlHTWasFbmkEZCL93ghko/LDQxzwYxVstbZuPZjfsKSbe3+XSu8qvtLqiAF7qkYlCK+o790qqKaJva2u9OhHCDsLwjIRz4od2eeHeXWPsNb2si8Nr0wRxa/YBCaIjz9LBX1qu9ciz5bouwrI19WN2YjOzOiTQx+MpMVDxYr+6MEN9elZCgmpY750eodm9Mwpz0Ibt3wV6hFs0sWWibl4ai39e/iX0jB+6oiR/Gn9TJfrPTQC4dcCiH4tZFjkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XqfiSKg39ndSnN6DpO8ObLRygWns2SrPtfou36eZxM=;
 b=Nt3MlfqUsjQQ6KvsfztxheXUmRYV1XQc/Gv0ghOvRNbZzn+iYA2Y+c1xTrlWZfzVJ1kXODd7BpiyHMM7pZ7kTGecEmJqs+y1lLM6bMLebqtTt38R47Y2b2+kACOLmgn3rttHnRhT1PWJChqMjx0OJzWQ7EISbxMnix6qS/pAfcIz7N97Itzfa9MQ6qKzB+SEp0mwC4ad2ScCcoDAO75AGStWpitwpXFItkxvpM+PEP9yCjoDegDy8kjdN9qZ7NPJWYT+qbi6UHOsbQE46hOjaLkCfuGfmLkAnLIMMnX+O4s/KahWNtzS8xvNG+bxW4kO3z0+3Ue9fNTJBhvGT1c3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XqfiSKg39ndSnN6DpO8ObLRygWns2SrPtfou36eZxM=;
 b=czPmi3XNuD/XXZR/cyQb7PPwtYJG9Z5zsnJ1T//gbJjdS9BKeMmGBLoyNZCtc4/WWLhDPuHbX2dXLrPOBhWCJ7wZbj2s85GZ5/CDB3VRgGQb6z3ihq5lSJS0Id1hLCPDtR5003Ft1oZkLym0C8ZMIkN34wAhR+Wsja87fI/fmYA=
Received: from CH2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:610:20::21)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 06:03:47 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:20:cafe::41) by CH2PR07CA0008.outlook.office365.com
 (2603:10b6:610:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 06:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 06:03:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 00:03:44 -0600
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
Subject: [PATCH v5 12/20] ACPI: platform_profile: Add profile attribute for class interface
Date: Thu, 7 Nov 2024 00:02:46 -0600
Message-ID: <20241107060254.17615-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 104e5c5b-4d52-4539-d8fd-08dcfef1f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H04FeNJN/hxjT5+xuSQE1Oxv9/DhQGnS9bNYNuFQ4mzksSjMcbTW9TRT48W4?=
 =?us-ascii?Q?po0Km9VJdMNulqmOgbJsGLnMkOBknQmxVsiDBOq4N3x1oCgyfSlIELKCNYHp?=
 =?us-ascii?Q?KCIM4ZNSZP8xdGrwdhC09/EvhsEpc0XbUP6gt7vUx+tSPvvbHAoYYoroZBNS?=
 =?us-ascii?Q?Tdsw8Hj4O5mbWJghs62Ifpho0pz5QU670HwjDuwm3dIFoFQ2XFE+Tcn4CPEp?=
 =?us-ascii?Q?AD9prGmdEiJd32mFr2dWUeTFDtkjT/dDGGmdkpMSIC0vJAJIarJORPnYjo9k?=
 =?us-ascii?Q?8bbukk4gZuEuKeVLHW4jDEfx51inzax66QjoTEZ/k45pSuyAQOOzp9UVslIA?=
 =?us-ascii?Q?8xc2hVpo+NDydnUumUtPaT1GDKNndB9TBvoKHg2Llh8SvlXgFLldtfwBfaGi?=
 =?us-ascii?Q?li7+/KzrnJaRsBR/XFuK5h/GpRP9/Er0FYq/BpSiX3vL1B+lPDKjUVZv2qVo?=
 =?us-ascii?Q?cxtDdDyL06sCE0JOXG3dknL1TAUqN32n2StZkEWL1UG8Rx3HbGp/XdL19A7Z?=
 =?us-ascii?Q?X6tqDckJANse0R58yGWRiXVWfGROp32QbAb+HuDoVJt8/WzLVa51LTxSUVIu?=
 =?us-ascii?Q?QtEiBKtmj3C7Fzbs5GwtQPoHSxh8sw45xdBGp8iEoUebmxu/Zm453yHn7h7G?=
 =?us-ascii?Q?jwmhTM1aUKMXdlINSfAPCIstYCNFnf7UdkWBJp4pm4XzkFyGsdheS1LRizwW?=
 =?us-ascii?Q?Cp8tjEP5FH7Vpe3PUtsC3lfoSc23UoDTnpbikZCrjCUdgeA9xe8xhtVsLr2O?=
 =?us-ascii?Q?dKTgHt0cWBxajDj/dYQyZwAUGcC1VGwCNpu42nPFJjPMUmdaacDX+rGPkYef?=
 =?us-ascii?Q?dIxWQoF0yRyCRYSpgIP9/X2EMueeD4YuVkEyr0cbfQKvQVK9GiEj4bM6kruC?=
 =?us-ascii?Q?QcrvpjZPjYfkOONJ7cVgA9vZ26w6zMdDweCoCRIgxQBZJGLOYK1Viz6/s0dE?=
 =?us-ascii?Q?uSo5Z8v+GGn7PPWdFF58VhHvJgmbd5/m99iXcgVyGIA3TNE0ocEjryFl1dXZ?=
 =?us-ascii?Q?2yz6bqKIXdPtDpyPFnMeu69DLUVQAC4Zq+NMkfYmCjhgqP8n/2Hxzj4TVT5p?=
 =?us-ascii?Q?2DvRagHsirvKAGXsOHTqdIvw7l9l0E1YA4JgV4c04xlflNpi0EHaayCylMuV?=
 =?us-ascii?Q?fQKLirtoI/D/bEnxEgbpYYjBx3iBDOYpVSZ9aRGGOOiZIUjTrwZ/IQiMPjIP?=
 =?us-ascii?Q?lJ2gStg66BArf/2e+isdvY+RptC2LKiolz1NLFvu3lfthEUWSswd4sXYJzpK?=
 =?us-ascii?Q?qEtryT3jFy1ewAMFyp57Pr0lJhJaShjpiGng26tFdp/HdNNI9zDZJeUOIDpf?=
 =?us-ascii?Q?aPkU23HRTAqRA22wkz8Hw28LZvCmrHRKcN3qjrlXQVjmkWTch3KZ03/F7fZo?=
 =?us-ascii?Q?/fZN06y3dui8z7vzDQbUldtTy79AsfpdpqApRcMbJhwWDcQyqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:03:46.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104e5c5b-4d52-4539-d8fd-08dcfef1f176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677

Reading and writing the `profile` sysfs file will use the callbacks for
the platform profile handler to read or set the given profile.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Drop recovery flow
 * Don't get profile before setting (not needed)
 * Simplify casting for call to _store_class_profile()
 * Only notify legacy interface of changes
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 110 ++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 5e0bb91c5f451..35e0e8f666072 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -65,6 +65,62 @@ static int _get_class_choices(struct device *dev, unsigned long *choices)
 	return 0;
 }
 
+/**
+ * _store_class_profile - Set the profile for a class device
+ * @dev: The class device
+ * @data: The profile to set
+ */
+static int _store_class_profile(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	unsigned long choices;
+	int *i = (int *)data;
+	int err;
+
+	err = _get_class_choices(dev, &choices);
+	if (err)
+		return err;
+
+	lockdep_assert_held(&profile_lock);
+	if (!test_bit(*i, &choices))
+		return -EOPNOTSUPP;
+
+	handler = dev_get_drvdata(dev);
+	err = handler->profile_set(handler, *i);
+	if (err)
+		return err;
+
+	return err ? err : 0;
+}
+
+/**
+ * get_class_profile - Show the current profile for a class device
+ * @dev: The class device
+ * @profile: The profile to return
+ * Return: 0 on success, -errno on failure
+ */
+static int get_class_profile(struct device *dev,
+			     enum platform_profile_option *profile)
+{
+	struct platform_profile_handler *handler;
+	enum platform_profile_option val;
+	int err;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	err = handler->profile_get(handler, &val);
+	if (err) {
+		pr_err("Failed to get profile for handler %s\n", handler->name);
+		return err;
+	}
+
+	if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+	*profile = val;
+
+	return 0;
+}
+
 /**
  * name_show - Show the name of the profile handler
  * @dev: The device
@@ -106,12 +162,66 @@ static ssize_t choices_show(struct device *dev,
 	return _commmon_choices_show(choices, buf);
 }
 
+/**
+ * profile_show - Show the current profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ * Return: The number of bytes written
+ */
+static ssize_t profile_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	int err;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		err = get_class_profile(dev, &profile);
+		if (err)
+			return err;
+	}
+
+	return sysfs_emit(buf, "%s\n", profile_names[profile]);
+}
+
+/**
+ * profile_store - Set the profile for a class device
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to read from
+ * @count: The number of bytes to read
+ * Return: The number of bytes read
+ */
+static ssize_t profile_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int i, ret;
+
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		ret = _store_class_profile(dev, &i);
+		if (ret)
+			return ret;
+	}
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(name);
 static DEVICE_ATTR_RO(choices);
+static DEVICE_ATTR_RW(profile);
 
 static struct attribute *profile_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_choices.attr,
+	&dev_attr_profile.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(profile);
-- 
2.43.0


