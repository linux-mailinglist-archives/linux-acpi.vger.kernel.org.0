Return-Path: <linux-acpi+bounces-9855-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BA9DFA64
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE147281961
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C881FA163;
	Mon,  2 Dec 2024 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cn6kqbd/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CF1F9F73;
	Mon,  2 Dec 2024 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118711; cv=fail; b=lEz7VLqxdahjQ4Yxyf+Hy2Y0hr3+m44HIlIi8I8sgezD0Hyl/vAz+JEUO3oN4QQKSqMMsO5BhK1f9qUKXZxWHELj6iAPRtDWURBuSQhL2i0I0XvOMHCKXeok0gQHDNtIARutRnd3tEXECiLfNDUzmGRNsAbwvQCoN1ePFxI+2/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118711; c=relaxed/simple;
	bh=J6vY6Ly1mybX4QtNPFGmVNYhGmUsJ/VMfVVpXRSd+hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNG6DugZfz5aqElXoy/ZGGrrJ6zII3WJ5kXrp8gpKIQ1rFLyOs1TtN1p5ZA9W9UpwlXCNz77EcyFchH/kBMwv9sbHdQhVHrShkR9eB3GykMxVZ0Vcnk7SXZEigaSjSK9XESW6wAt0j1XBhGVnj5tfFFz6CcvBerhoGj/VX7J9sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cn6kqbd/; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgBWPw1aMo4pw0dmKGdGKLjv8ZPDw6lca49JyNkMpXv7GhvpskRhLwZhrXB5N6sll0lduzSOs7+SQ0fAo/OnAGMuxRJSi/GrgbUOX3AlSkmNEyzGPqe+UB/Zcj8UOoHIfO7w2CL+5/wN1UACQRk3kQkn1UwIKli0YpWvdV3XazRTeGAojNlLkdMm83uM58ps6f46jTDeYuf/xMb3iFvP8GjubMBVc+xAHQhGENzaDQBXINmuSpn/yno7F0Ij71pKvImJozkXgAwph1siuuXC/x5jJ6MchEbJtp8tu9ODJFGWwa+tswFiHrqR1SV6DQIez8MEn7meeWhCrYZFleBfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=figZ5FDaBxhpEPwjr9xklx6iqQpxEbgqRxOEyEEz6K4=;
 b=W040RTAvrIptZghv089pYIEWQOD/NOAeRyEqUK65tqfQFPLq19Czx1dQcd5emmKd1MJSEKPZD+xcwDP1g3m5Ta3UJ6Y8EhDw87lNNLxFGwSjc4CHpEwRkTdvE7QgO72sSYNkzt4eWPVk8KLrzn3YBPresUnL8rXSIxrB4Z7hhnW1mso1sYstiOisqc0wJIptGD4S6clGRBDCatPkGi67EL1VK+mz1RebuoO/xQdor6Ka7dn9JGshGMgG0PRGjQYXh5FqMyBmI6JSk9628Xql0oRzF0PLVJ6ii8BnK5mMPPzEGRDsCuXBRl3NUlx+KNZcTvh5wlpZnVtF4UztLY3OXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=figZ5FDaBxhpEPwjr9xklx6iqQpxEbgqRxOEyEEz6K4=;
 b=Cn6kqbd/U4AJeR4tCetyPX4WuvIDFv4B2/vla1XOS0MbqpdztPBZIDbGuKSTVdWxxY6C4PsJaXa+KW3B+ftZt7oGEaK2tYF04ThN6FXGXpdqc9sKPcz3rHCHHNxvaRJe4kZDC962ATdVQzc3/6gUmGV13Wxl6U5OFlcTQixIe6Y=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Mon, 2 Dec
 2024 05:51:46 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Mon,
 2 Dec 2024 05:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:44 -0600
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
Subject: [PATCH v9 11/22] ACPI: platform_profile: Add name attribute to class interface
Date: Sun, 1 Dec 2024 23:50:20 -0600
Message-ID: <20241202055031.8038-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e8f1b9-d8a7-4fbb-f579-08dd1295685d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0JmdEVkZGEwNXpTR0JxRlhzVSsxTWNEblN5dDQ4WGcxMGVFNGlHaVM1TE5H?=
 =?utf-8?B?ejM1SVlCd1dRbmRKVkVocDgyQzYzUXdOa21QaTNwMUxmN1V2OFFLblJYWVNY?=
 =?utf-8?B?YVV6LzdOcC80VjA5UTRuRVY3MXJuKzBlczk2MzQ5clFUeUF5Z2ZhRndZTjZY?=
 =?utf-8?B?SDhMVUpQUGJ3aEdXL2U0cGlWSEd3S3cyYWpFT2N5eTNnU0ZIWUR3b2hvOFhU?=
 =?utf-8?B?dHlTNHZscG0wTW0yYlpSNkRiejRSQ1pHMkVVcGhxTUFnRzRDeU04bzZiQTZ3?=
 =?utf-8?B?RDVkR3M0ajBEengyUWlWUnp1MzNHV2ZZczlCZ21BWU12NFBGV2I5Undkb092?=
 =?utf-8?B?ZnBvS3EyOHA5bmRQb3dseEdjUHdlNzA2dkYwTU5sS05MbWVoZFJRWUJzTzRF?=
 =?utf-8?B?QUNaVDJ2ZUxzMGRYbEhKMmh1ZnVuUmZJV0ZETWJ5Q1RobHpENEkxSmdYZEg4?=
 =?utf-8?B?bVQ0d1ZrZGNTWE9XKzhQSTJQQUtVcy91YlZlajRRWFpLV0wyTkRtai9mcUF5?=
 =?utf-8?B?aDlUK280MUFOVFFWcmp1SVRrSS9obmt1UmFNd3FNbjdyYnpkYlRaWU1kN052?=
 =?utf-8?B?SjR6YlRISWNGNm9MMWo0WElJeTZlL2xBMEJKYkJGMVBBRGVHbkZBMFZTMDVm?=
 =?utf-8?B?Y3BieHUwZUhtZHFuWGhpRHRUQ3hWZGFWMFFpRVdPU1ZEUjRrZjhoWk5PdHR5?=
 =?utf-8?B?ZXI5RVM2SmJMaWNjNFpHeGtEN01LbCtVN2JIanZYM2wxbmVXbVNmZGdOSDBL?=
 =?utf-8?B?VHdkNWo5VXZGZHJCbzlCY0dDT29CbHBOcE5JOGRWaFlsVWtBbkJ2YmV4T3RV?=
 =?utf-8?B?c2dNZW02a00vMFR3anlnbUJ4YnRJU2ZySmFxVFFmNWtnbFB1bWVYT3REeDVM?=
 =?utf-8?B?NjROQVpGRFV5US9kemxlYTkvTEpEMlprMVA1MXE0WEgxK2krUldmbllndXJn?=
 =?utf-8?B?cnp5WVJUYm8rME1LbkJMWHpMSWVpc0VLTzBoZU43MmV2UVBtc050Sm5iUnNl?=
 =?utf-8?B?djg5VTVITytiM2ZVditmamYwRzhGaEc4NHVhZlBwYTZBMUhFK1hITm9Yc0lK?=
 =?utf-8?B?UEdoZlFXeEkzYyttQ3lENU5ESVhobm5vTWQ4QTBIMk5IRCt2VEVLYTlnOXJh?=
 =?utf-8?B?ZjRNY3JiNGg2bnFPK0l3N3ZXL29mVkFSdnhjbklnOW00c2VSMTJwd25zcHFL?=
 =?utf-8?B?bjJ3cHFyakZJcFFDaWRENDE1dGdWWWwzQU1EQXRJc1hFUkVvdkJlc2pTbmhz?=
 =?utf-8?B?ZGdQZjlJVnVtdkU3blRNOHRnWTJNQzNOQll4SWdkNTQvS0txN3U2ZDhnVWo4?=
 =?utf-8?B?UkNGMXJoOHJZbjZvMWdPS28weUg2QUhOVXhqSkJaYjlybXdNTmp3dzRJdXgv?=
 =?utf-8?B?VUMrUldwK3JhcEJtUmxOWEtMUEoyTnpLcXc0aGFhcGkrU01xbGlKNVJyOGJ5?=
 =?utf-8?B?WTNWMGlXbW1XMVlqMHFvUHd1dVVxM3NoUk5yN1dja1VVRTM5UTFKTFhzL1NN?=
 =?utf-8?B?Ni93OVRrS2dGZ3RXUHdJRk9XbVhDR3dqbnZ5SDA0TFVZVlpjRlpvaVRFNGx2?=
 =?utf-8?B?clVoSElvcnorTXJDTWVyeHB1czhlQzlhZjdCWjByZ3hCL2s0WkY5OW0zTi9I?=
 =?utf-8?B?YkltVGFmL2ZXUEloUUI3RjFGV0wvWUMzd1lCNm1NdDAvWW9rRmdLOEI4NGNh?=
 =?utf-8?B?OSs2NTZkQjVRS1BHWUZCL0svUURqT1NMQmo4ckw2TG5UcGRiU0RmcWc2RVly?=
 =?utf-8?B?NWl1NnA3MXdaVi8xQmViOWxtWFVGb3JJV1lvNVp5Y3dxUG0vYThFLzRZVGlU?=
 =?utf-8?B?WjBJMnV2YkVQL0NxeU5VOUFia3FLdnJINnpoTS9lMlBvYjN1TVE3QjgxV3NG?=
 =?utf-8?B?U0MyblZrTGRTYWZZWEtMa092d2ZQc0Vaa3kxcTdhVTMxRmJiYlYvcGNKMlMw?=
 =?utf-8?Q?X2yMNbkMBO0g5TLOtQlBWJ7JQJgaCqrX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:46.5956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e8f1b9-d8a7-4fbb-f579-08dd1295685d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

The name attribute shows the name of the associated platform profile
handler.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 * Whitespace
---
 drivers/acpi/platform_profile.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 11eb60b09bac4..49a8bd6e97ece 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,8 +25,31 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * name_show - Show the name of the profile handler
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%s\n", handler->name);
+}
+static DEVICE_ATTR_RO(name);
+
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


