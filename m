Return-Path: <linux-acpi+bounces-10000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A79E64F4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F5816102A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BAD1925AA;
	Fri,  6 Dec 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qgMKz6mV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0B19258C;
	Fri,  6 Dec 2024 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455575; cv=fail; b=ulWPEV3aTEUGYtV4yoKTBHPO1elgK4JVOSPDoENdZDQogFMTV6fUsbzOmzUeWo3FY86ujs1cYmB6PP67eWDfMrhpohmBHABNQ94qWhqs0/ngUJ+wVrb85NNDEhqoNLpmDEb9g7kSJAAged34AmA/gqTwraqfVC+oxPOafycIvoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455575; c=relaxed/simple;
	bh=deBmNxDPRllsYpGw84ggzNBpWk7/UUVrK/nhCONp3v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npwOjZn71doSfLoVqPrHLXXdS2ecpDRE6dMTSBB34h4cUDK3kmG22tmYP+GetwbUFutAlY+qWjgqUPP+fPriQqt4dtnMDMt3+zG+dgk4FWDKvF1Ytd+j2OCJae/+ChLhe0H3xr9NBD+dV+fDDBWEAby00XLFWR8wIPemMyDOoJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qgMKz6mV; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bryeuWsawTdv/yQp7LOqWSjq1jAJSwaG0xvABGIh3We6lC9F+nAqIAYDFEA0jHdu3ldBD7YAH8xOIPwRsNcJbaF3jJRk0GpJEbofLst7xJDKKqyZdqaUaqskshqpHHEOUomJueu+O7/BeGJWldkiz845+ca46aq5zRdz/YRAumxA1rkweTOco69EjrE13jKmtAby7W+XlJL6GaK8sPaMxUpaS3Pmasj3n/wgrpdM4UF0RNKS2rIOb01iCmHVx187uBrgzEG2dcZRMaqwlIkmFxCzzV2rtFalgeuogOSumePSrTYbOR4AVKfNJMW6X8QemODSTeBMTHmQUr1S3FSl/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smp5omVcxem4nJZtzzeYdunSFxMaCj7p+L4/uAXrNJ4=;
 b=yFo1z+oaVclhX5hcvEmoSr89f4McHFA4ppQoQkEm6HaOkhV5u7UaqqtzLiwqP39xLdgZCqkLFZkDapCnotAM3M0b7K/x7glrMZZG6/6fAINqCsGPbSpakWAaHU2GpQg3b3gJrS01lO12vKlFpQEOFBTln8sZ8sritikA/+7dCc9mccQwsgSz6sY1sbbn6nBXzUGLWLxQHXxjfcGR259e7r7J9oxljZnwqf+ZLY4r9wB84qac+Zk4hZ45J+7s/ZnqMn9g15iauFmdYKA70ArXGoFsxA/Jbf8mPehu8mTbnla7r0ww88LyBzg9AYuqbdDUbP9Nk4ZfKWbdgPa0/kgfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smp5omVcxem4nJZtzzeYdunSFxMaCj7p+L4/uAXrNJ4=;
 b=qgMKz6mVPR0kzJwOd/xfRPJsCiV/GmCXREGf61Zli3ysIkPh/iwtxspUKQlOF6WYT3EyvlSUgj7mpfLBhMGOgoXfo4pqR+eLhcbFDym/Lt/gtN6F/bGiDA4mYfCDl7FuDQt7pbBI6cHH0pRJkST9COGnlRF6KoCy2+Ue75WLxpA=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Fri, 6 Dec
 2024 03:26:09 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::c7) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 03:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:26:09 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:25:52 -0600
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
Subject: [PATCH v10 15/22] ACPI: platform_profile: Only show profiles common for all handlers
Date: Thu, 5 Dec 2024 21:19:11 -0600
Message-ID: <20241206031918.1537-16-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: c73f2996-6e7b-49a5-96e2-08dd15a5ba49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRNTFFZNWpoNjRKaDMzVXh5WTBacU5ieGlpNlg4VTRpamFudUYxN0pxSFRp?=
 =?utf-8?B?VkFwZHJDdDZ1bDRtQUxYOWVUSlNpaFdxTGFmQ2c1QklXYVdZNjAzakVOZVFI?=
 =?utf-8?B?ZVNlajhkSlY2dFIwd1VuV3RzR1JXUGJkb2pEcDJ2amtKcUR1QnplSTN4STJj?=
 =?utf-8?B?dUU5UGdiNnFqYmc3UEdENHVVZ096eGJ6NkVJY3BRZ2kwbkdIZHY1b2YybmVP?=
 =?utf-8?B?YjF4MDVrRkgvc1dWS1ZqS0tBMG82QWlnS0hRWURyZUhQS0pHYVlHQmllSUty?=
 =?utf-8?B?WjB1VUJ0UC9HYVpzdVpIQXcyWE9FQU81L0xrL0piU1FSRWI0bXZuTVpMQzI3?=
 =?utf-8?B?em9yRWkwVnlvVGtxMXliWm5aa1N5STRvS051NTg2NXY0eGZCTm1PdjRMMlNi?=
 =?utf-8?B?bUNRMEkwTlRHOG9WN2NmemV2NGZYZzlxNS9zMHpTL1dnNGxmVVZLU0lKeGxM?=
 =?utf-8?B?N2Y4bzNSNnNXc01uS0tqQW9sYzJTRnRweU1MRHl2cVpUbHFCU3NoYWZxSERZ?=
 =?utf-8?B?aFJZazE1azYzSUlzbHFEZkw3UndoZzFQWi9ONnpXUlFKRjZSN3ljRkIxRDlj?=
 =?utf-8?B?aWxET3dhdFNmdWxQdzFkQUY3M3ZiQUIwcFdKdHhzNGcwRTFYWWRaTlRlNVFQ?=
 =?utf-8?B?OUpOdkJEYVB1Vnp5OFdVemhScG9hWlBYTytmT01PK2R5Y2ROaS90ODFVa1Ny?=
 =?utf-8?B?U0lpK0JmSXZ0RFJiZVpGV2V1RnZvbm1HQ2JSbzFZS1EzbTdHeTN3dXpOaEVY?=
 =?utf-8?B?VXFLVE94dnl3NG9sMnN0K1JlSmszR3dQNC9EREtoN0gwS3NsRWs3Q1o0Ykdm?=
 =?utf-8?B?MVZOdTU2M3QwS1hkb01ndHFOWkhTVnl6aFB3RnJjOHJXdW5vM1AvYW1MV1Uz?=
 =?utf-8?B?ZjI1QktkTmtvNVhKaDd4bC9UZGQzRkw1V3hFQXc1bGYrS3FPcmhDVXdPOHpT?=
 =?utf-8?B?bEgvSXlpNWxCTzBzK0lDb3NQR1JQWjFwNUYvcjd1NXFLODhiVzJVTHBWbHAx?=
 =?utf-8?B?RHZQaEI5NVdiTVVFTFJvY3Y2WTROa2N3NTJaOGlGOUV0YlgrOW9VY3hYSW43?=
 =?utf-8?B?KzBuNVZ2cGlsQkNFa21OZ2hlUTRaeXhQMy84UjZlUFpudkF4QXhJaHZBQThh?=
 =?utf-8?B?eUplSVhMR3gwZTVmUHZTOGtGVlA2VG12NDNZcXA2MTZuQ3ovS3Y2VXRNcGx6?=
 =?utf-8?B?eUxjdXlGM0M1bUp1S01Fa1p0c2JRZ1ZOWmhqRXZCdW5wdXdjK1Zkc1R2a1k3?=
 =?utf-8?B?cjExWG5VK2RBKzd6VHdWN3ovUnJtdlNWTkhaUEpXN01SaWhEM2F4dFJzREIy?=
 =?utf-8?B?TXEwTTJxQVhRMkVkSEhNbUR1QVdCR0hmTFBXdkc2Ry9Rc1B4ZEJUMStia3pk?=
 =?utf-8?B?ZlU0WTdtRVhObFVrWVYrbE83U0doRkRmODIxQkdsWVhUVHhVZEpvdEtBb1Fj?=
 =?utf-8?B?UmY4S1NSUnZFRzczWWxITkZJRU1pR2tuNEtpYk1peXpqVmxBMnNjVktLK20v?=
 =?utf-8?B?N0ZiYTJaRkZPblQxOTZOUGNqSTFHWXJaV1Y4U0ZKVDFSRjc3UE95RjhWQmRV?=
 =?utf-8?B?bytybVgzL0RFRm8yaFA5a0xWTThNeC8zMHh1UWFDMDJ1UVhhVnpLendkYXJ0?=
 =?utf-8?B?UDczVCtJQ1VhcmprWk1ERTNJc2k4VFhLWTlEM3V0SnNGc2RUdlcweWdSWlI4?=
 =?utf-8?B?V2RONG54bXBuTUExVjlYbEM3SWRVNFE5TnBEbmQ0bjJkaW5OR0hTdEFMN2JR?=
 =?utf-8?B?ZEJQY0NhZGVuSlJRYlVxZkJ1TGZyem41ejJMN3lBTGlreVFyQSs3dFFnaTUr?=
 =?utf-8?B?dGM2WVN5YmduVXJIQlZzQmZ2RHlVUlZqMnByTSt2WHprY3ZnUGhRY25kNVUz?=
 =?utf-8?B?QjNycEZpangvUzJhQUNkZ3VFcGErNzZ5Z1lhamJTdWZnM2YwWHJiRmhla2Vx?=
 =?utf-8?Q?DO5Y84TDFgReq1wwvuVocyDpRT+fPv+f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:26:09.4556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73f2996-6e7b-49a5-96e2-08dd15a5ba49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712

If multiple platform profile handlers have been registered, don't allow
switching to profiles unique to only one handler.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v10:
 * whitespace
---
 drivers/acpi/platform_profile.c | 54 +++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 2a4f067c3c5c1..bdf69255ed9ca 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -198,22 +198,56 @@ static const struct class platform_profile_class = {
 	.dev_groups = profile_groups,
 };
 
+/**
+ * _aggregate_choices - Aggregate the available profile choices
+ * @dev: The device
+ * @data: The available profile choices
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static int _aggregate_choices(struct device *dev, void *data)
+{
+	struct platform_profile_handler *handler;
+	unsigned long *aggregate = data;
+
+	lockdep_assert_held(&profile_lock);
+	handler = dev_get_drvdata(dev);
+	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
+		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
+	else
+		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
+
+	return 0;
+}
+
+/**
+ * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
+ * @dev: The device
+ * @attr: The attribute
+ * @buf: The buffer to write to
+ *
+ * Return: The number of bytes written
+ */
 static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
-	int len = 0;
-	int i;
+	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
+	int err;
 
+	set_bit(PLATFORM_PROFILE_LAST, aggregate);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
-		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST)
-			len += sysfs_emit_at(buf, len, len ? " %s": "%s", profile_names[i]);
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    aggregate, _aggregate_choices);
+		if (err)
+			return err;
 	}
-	len += sysfs_emit_at(buf, len, "\n");
 
-	return len;
+	/* no profile handler registered any more */
+	if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
+		return -EINVAL;
+
+	return _commmon_choices_show(aggregate, buf);
 }
 
 static ssize_t platform_profile_show(struct device *dev,
-- 
2.43.0


