Return-Path: <linux-acpi+bounces-9857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D089DFA6A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5538D2819B9
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF74B1FA82B;
	Mon,  2 Dec 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wDCP2xs1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE11F9406;
	Mon,  2 Dec 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118716; cv=fail; b=fh3leaMqv9+E1r4vgwNV3J5hc0GNNMl4y0uKcx5v3aTKn6nBQgYgz8PwCu6uBzldhZ6Gq5e3FS+1bJ+H4dYTBHfE3bgApdsb3z2XCfobRJKJy9iPs4Ak5hUkvfBu/JCYMIAevU8XqQqiGLHz+cra7BwMgAeo14kI9JwAvgTTUPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118716; c=relaxed/simple;
	bh=unPzCMnUJFAJaoAgr6uPiA30SduoOCKrGWgNsfy25no=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPPsTkgAMO3uwlUlJgMxFSoOoBgx0w964yj4Kq2upVH9NqRF2xEA+zTaLBkbOF3MsseUyB65eSNMXH+8EXtesBK4WZBWG0avsbfzBsraVO45/o+pfwPXFZUjZBnDNY4FzGUm4JPtyz5DtyLyvS9C+Teen30lRZhmeEDxp3+KCN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wDCP2xs1; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6OiV5qUscdZ+hzm8UolSag9Lr9x+XUSd4+drD41Pdl8rql/r8eGN/Wk1s7WvaF5KYS/me/gpJcxbj0PhJgvsyA3T++/d+DMF9vT64bLTI5NzxU+1y0MuosAWdfordG37E5Jaa2B0+2kJJ+iRUV+XuctVurbNG+nY1amLTmmKDDpFfAC3gn2yH1Ybv6IgYImwbwveTSofjFvzmJodKKXYgytM2c2Ummw6MwyMT6qE3ruKn/iZYyNJ0Z59WnsJkDgj762HfrcAIbd+5EwN8DK3EroQB7njJUOoEvZ5RQwR8aG0pZICFIS1qRUaeGXB/Ez1w2TycmmHxRBB646VhGCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEMpx0Xko02t5+VOBOvFQ5yzKaAUqCfVq+KGuAIPsrs=;
 b=iVoIjPVJuDt4zL6gL2srV+2mTycRop6cQgVSmViESwz63TlIKYfdHzel9QdDGgaJuc5MXEcDzlOqkp9ILODXJKLesUtMRCacqKkBFd2ADFl4Ig8myF1IqAB66GByI6q7b4g5XXoH+kY8YXfktuQmp8RwESEKj3MpJsjmU/rtQPoP0BtJzw3L7o/hZCoTbM+ocbkniKjxQNOgwoWX2ySy96hi0pszriRDAxSX7tdjd70JLXCdzhXfJFWdeXISY3YEuNiK6aUAUIpDwd2VZOfDWX09ztnJ5u3W6AoqPIJc2WPKBkG+/V71e8XS4bXVJ2k3XHW4QY+Q945uLaqN9L9NQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEMpx0Xko02t5+VOBOvFQ5yzKaAUqCfVq+KGuAIPsrs=;
 b=wDCP2xs14HbaQujntIVKITmB09Z8XGeTxDNvkne5jF65Rvk0sIOeLRQYzHWweBmIB+/3ArZPknUrsxp1HSYhKAv6PDHQoNjw7trFUE/cE5r1sICrEGHCR6jRK8Q3d/KULht5Nx8aeGebht31JL8spXN391S61QePypfIaN8WIN8=
Received: from CH2PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:59::24)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 05:51:49 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::17) by CH2PR03CA0014.outlook.office365.com
 (2603:10b6:610:59::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:46 -0600
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
Subject: [PATCH v9 12/22] ACPI: platform_profile: Add choices attribute for class interface
Date: Sun, 1 Dec 2024 23:50:21 -0600
Message-ID: <20241202055031.8038-13-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8db48d-e11a-4351-0a6a-08dd129569ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXpYc0tMZ2hBdG9XSW9LVzFNUHBlRDNvTVBzbXNFSUluQStaUlJLVGVCODFj?=
 =?utf-8?B?ek0xbk9Oc0p1RWJ5OFZjUm1SNlpDK1JRZkJzY2MzM3kzU1o1amkxdm9jOC9t?=
 =?utf-8?B?azB6NTl1eUFYSHRCcFF1QWtrQmp1Rnd6MzNXaGxHZVVqZStOcUtXZmNEQ1dq?=
 =?utf-8?B?SStKK2UxM3lLVFJ4bVdpa1pXbFhhZFJTNVh4UjVabnJGN2tJWW52NUFxVC9o?=
 =?utf-8?B?NnRVZUxrL2FkWks1RDdVeWdheEJBb3MxVFFmQ0x1cGkySXAyeFZOampIMnBW?=
 =?utf-8?B?WnFUcUlBaVQ5cExnWGdlTzBjeG5HeGpkbnk3T3cyR0dxaDlVVWxnVVUxcjZD?=
 =?utf-8?B?YU1SQ0k0aWNuRnMwU0R3S2REVldzYUhIYjlQRzBlQm5aYlNGbmlHdlRXclNv?=
 =?utf-8?B?bjUra2FCazZOVDZIMFZ6OUFRM0ZsZ05DdlcwdmFTdlJ4ZExubkVJNUo0eVFI?=
 =?utf-8?B?OGQrdjhUdmlzWGZLYkVKd1F4Y1UyanpRZW9WZ3RqM3FMM1VSZFpVMTVjWmk5?=
 =?utf-8?B?bFdvbk1OZWZWbjU0NnlmSDBDaEhHdzRFY3hwcHBrNlRQY0R1M21qamdIOG1P?=
 =?utf-8?B?ZHg3WkcxemcxOGdsM0NDdDR4K0N6aER1aUUvKzlEQm5ic2xhVjZXRzdHY0V3?=
 =?utf-8?B?RkpEZHhaT3FxRWp4TXJ6eWhPdmd3MWY2eUlXWkk2OVpJbUxpYVRKandUUUc3?=
 =?utf-8?B?TS9BWXVwU3JUYjhLd2F5aVo3SVNMS1I2WmMySDlvT2N1MU9mUnU4b0Voa3JE?=
 =?utf-8?B?bmNzcUpxMVprcUN4Qm1DZDVuMVpiOE9YdHl5L3BNWTlaODlFb1BzRWQ3K094?=
 =?utf-8?B?NnRDR1FWdkNJdzVDVnZqSGpHQVc1T0grMjVONDA4TkdJMFh6dUpOOEsrYnAr?=
 =?utf-8?B?TVhrTS9rR05jTEdPMGF2eFFCQ3dqbVI4eTFWN1FPenozRFM0V25yYzF0em5s?=
 =?utf-8?B?SFVVNHhYRURhUmxhQ005dDB3bmZzN1FkMWUvVWUxVUdsSU1Uck1oczdlOW9R?=
 =?utf-8?B?V0dMVmdKc0p2bkV1d1ByZEgzcTIzR0tHd3JyR2RnM2wvbXltdTk5QklkMy9C?=
 =?utf-8?B?aTVxY2Zlc3VidWFZK0NQcjRTMEJTMUxrSEhyY1BKa2hpdFJsaXZhQ3JiTUtT?=
 =?utf-8?B?UjUwT2QvR3NHZ05vZkNmSHB2ZnFXdEJEd1o2YTFYSER2TUV6NUFXUnprZ1Jq?=
 =?utf-8?B?TWE4a0t6Slg1OFVvRWplK1kxYjJWOHpNWkIxMGJISk80RGlVWi81MERuY3RV?=
 =?utf-8?B?VlVnWU9JVkhiU2hBdVEvMWRROHNVMkh3aGNNdkNDSDY4NlhFQnRNdXYvN3ZO?=
 =?utf-8?B?emV6VDZoVlpCU21CUnZPU2NQdDdYTUVTdEpSbzR2d04wclYxVy9VVHBlV2oz?=
 =?utf-8?B?V05vY3RZTDRUZ1g1UTVQeFF6NGRoeWpYS0FPa3NhWEEzQjN6L3VoR2Rrb0hk?=
 =?utf-8?B?TDV0MWFvY0lFbHR5SHluTmhBR0hIUXpEYUhHZ2V4SStBWUZHeGwyMi9TQ2NR?=
 =?utf-8?B?T1NMQ28rK0hCOVV1Y2N5TmJ1WmxJVDZHZHE1S1NubTZzNFBCTXFiMEx0REs0?=
 =?utf-8?B?ZWlabEZLT0lTQm0zcW1LQVJGT1BvbTV1UEs1TmprSHBtQ1A0ek85cXhuTzh3?=
 =?utf-8?B?ZDljTmpQUjdldnF0bzFZaXd4RmRRazRGbGxXWmkvbFN1T2xydGV6dkF2cVU2?=
 =?utf-8?B?WFRPVWoxZHRpajk0SHNzTWhxYzNpeGdpV1djcllMU2ZtR29YYjlHRi9iWWJY?=
 =?utf-8?B?VFY3TkYzckVwOW1VeFluSmZDckFHUjhxcGZvaml2c1cyZ2Rqb2RtVGxVbVIz?=
 =?utf-8?B?SWNTMkhzL28rMC9jVlB0eWorMEw3RnFlT2c3SDlIUitWVWZ3TUxqb0pCMkhn?=
 =?utf-8?B?U2NTZTRYSjBCS3ZuV1AzdmZPVFNjZFZrZzRUSDlTaitOeFZ3SmM1aGhzcUsz?=
 =?utf-8?Q?7p++BDZOu9c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:48.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8db48d-e11a-4351-0a6a-08dd129569ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460

The `choices` file will show all possible choices that a given platform
profile handler can support.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v8:
 whitespace
---
 drivers/acpi/platform_profile.c | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 49a8bd6e97ece..885f41bca6c25 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -25,6 +25,28 @@ static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
 static DEFINE_IDA(platform_profile_ida);
 
+/**
+ * _commmon_choices_show - Show the available profile choices
+ * @choices: The available profile choices
+ * @buf: The buffer to write to
+ *
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
@@ -41,8 +63,27 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(name);
 
+/**
+ * choices_show - Show the available profile choices
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
+static ssize_t choices_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+
+	return _commmon_choices_show(handler->choices, buf);
+}
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


