Return-Path: <linux-acpi+bounces-9167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3419B7390
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE31C24089
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348D149005;
	Thu, 31 Oct 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="00HJhEU8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA821474A9;
	Thu, 31 Oct 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347840; cv=fail; b=PVzxD2/AfyQRpWrcoKNHfJ033RQu/fvI/MQeHKKsabrVg3I1lCgLBy5pC6RUfljqqnTeGJvNTRg0woypnarHhGip2xY8TRpKFhxL4VovFPZX98bQXLrCmE9PEij0SpGuWFtFRc6k29luZuZkV8S0kFXCAhJnBFIzuSupQbWCmDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347840; c=relaxed/simple;
	bh=kHSWXmoYwTA7lWKf20voObXAqnC26/Pqba/tidTV9C4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDXQs1DTz5qDLjkPY7jt0k89ykdgoU/jdd9geaLYwn64CvVtJJnr2z8k/EkG3/Yfff0iVN+jzc/Gy+jBMJRDmwU7vy/nPMvKqtEcUSSmMfNX/8oh8a3li6A1/A3+to0UMfD77xoI/KGZnLKs5lcynl/KT9B/vYDlwvSBXtWClgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=00HJhEU8; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmIrnJuG0HYA8slndJMHB18BE4SBDvBK0VDPtiXf6ru2QdDdQu7kVSPJZ7+N5+5qglcb0ut7vkRzVDbOyqOY4/Fc1eOI7BUDD6OgrMHGxxRkWL0mlesjpBymgDlwxptgof19o9BxsBZUGz9QeY2B/cIT7kQKeu2ElF9NIWcPP21/Vi9HaFiA8wfvIhOZRWdvVh0697Spk0El45fnMwhWgGXwJ9TlmpnKXizusBA7vGlVvLjxdYO4OBni1Tc8iN14WpRhunLPra9K2sb4JLMyv9AO7caFITph00nTsX+XSQw9JDZS7o0P3FznI9kuxnG4OPri8lcQ1gGq3Asb6iwesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9RBHR3gyJfqRzIdQq8UYU5tcO1bw9e9KrBG5YRN3FU=;
 b=SHnFKv6E4X5gOXXLGooC1YaSPwNsiGFYDvIs5RMI4x/AcnVJU8OAnYk6JrV6MfESWrlaf3cscjQPlzND1GN+g6CEDMkqYTiC6SMvm6AWlggBlYsau9G3VLRDFs5Rt2/8m8ATcMsTvvf8teeO87RWLQ9zGAxmrZido5AbM5Dx3FW2zu5dt4PvkFoc/XTSgc4Pak2s0Py4SerNLyWpbVucwVJ9VratD8B9a3LcJK4Fr9bHnUWk9PdG5gb9lYp7qOj9naF6W/Nb1508jqTS0ojDFySYbVK8EyStHdrINB+WEo2MqfK2OLQIxSDcX1CbkwgfVtS825NeXkEs8udwHdwFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9RBHR3gyJfqRzIdQq8UYU5tcO1bw9e9KrBG5YRN3FU=;
 b=00HJhEU8KrklNo54gQ14vGxKNYa4eKppr42J1I6YRjy1GFCHhP1aaW2299vBf5T4FDsYLn8/mq0PPdkPbdJEOxKMT8CKQ7cLzSRhQYvbjd+gowBtVmHpfdsF76dzKE90l8gLYBjT3NxSuUTny6rBoZbmg0bAemms1wLZEN/IsbI=
Received: from PH7P220CA0089.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::14)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:10:35 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::10) by PH7P220CA0089.outlook.office365.com
 (2603:10b6:510:32c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:34 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:32 -0500
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
Subject: [PATCH v3 08/22] ACPI: platform_profile: Use `scoped_cond_guard` for platform_profile_choices_show()
Date: Wed, 30 Oct 2024 23:09:38 -0500
Message-ID: <20241031040952.109057-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031040952.109057-1-mario.limonciello@amd.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: c15bb5b4-4b8f-4709-34b2-08dcf961f7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ummZYh2LH5vJN3GrknABRToIXN67YQVin4AivSSbPTKuVx+rwVB3EiceRyon?=
 =?us-ascii?Q?pZWCW0kJZnroRTYAF2fcJXPQRwWOBHrIdNSN1hdNSGGZsrz94tQWC4puPANO?=
 =?us-ascii?Q?SBoWyvo3otR/FumO/4XETZikZ199JAsR/8PM6U4pMp3NM29LVfV9Hx4gu3Rm?=
 =?us-ascii?Q?I5ZBtPXZKIkZBdcKAmxA/HpeEpTTgg1jmycho26dEaZH06ZVZUQV91ym8N4J?=
 =?us-ascii?Q?p7kQCe1rYx16Iwa/X+ubrPDM3ncfkqUoC6LPrKd+7hAClUl5VF9edbMIVRTi?=
 =?us-ascii?Q?gvZNv52s6YTME5cQii9Ph4O54dxndVUeecUMW0qxoYNowPxxonYKpboRadBN?=
 =?us-ascii?Q?66WFoZVySr5CsLNyO88YJnjXXDBnvG/AGt6UW31rq7lQW7MR3HQSsbWz0918?=
 =?us-ascii?Q?iGAFUiZgoD2axmoD6mDWXm9o5LMWcn9A5goZf2hGUKt64WbYh6mMvAkhfh/F?=
 =?us-ascii?Q?aT6WeZyrVGjL9jW2GFx1wi51juFIgbgEgbt3ACItGhWEgk4QPUpuOkWU8Pab?=
 =?us-ascii?Q?/ry47nxQfrMvJzL5FxenA2viW5njN6kfH3t55rrCtRUQkw0CTteAN3OpO8nW?=
 =?us-ascii?Q?MazPi5n8tKAO8XnqQ+zGTs+QPSWq80XOoiQi7GJZ2f9m7vDNKV1FbxlMzBon?=
 =?us-ascii?Q?2+mXHQQFT56I7GjFmJavMivVg1E88GiY5XvAHTAoJyyIkgAnazn3DbQVkCqS?=
 =?us-ascii?Q?ApWkN2lBRkEcxtsvcDeC8Iy8wrTOVUrIzdFoMQA2k+lm39p4nUnk7/ILwQpW?=
 =?us-ascii?Q?9XcVpsCR7D5XwzQrs+65TbLYYIUcdsJBIXLBQGZ1TCRNKVHo+5oiJyUojLo+?=
 =?us-ascii?Q?8SgEUlLLLrSSOHVfA5CEnMgEeV8scge4BQDdnJcIeeRhR6gEcb/na+J7cktQ?=
 =?us-ascii?Q?dW1eFFdU80ktGs3vg002ms8y8k1yheFxzYi+LvTa7wzYTv/SyOa1frQ9klcu?=
 =?us-ascii?Q?q38Kl5ZIKAMXMZFewcNdayQVWk7mGgfIntW9LAxAD340IF3h5ys3kOGQGP9h?=
 =?us-ascii?Q?bOcNlyz9S4Iedq+HGceON0svx00sUye5xocoGsW0vG08qdvgAjZbZ1ni785s?=
 =?us-ascii?Q?TCp7/yktEeq9DwB4zx6quXbNNLii+yhmNudN46nQx9UHWKZ/jelah0rIBMzR?=
 =?us-ascii?Q?u57LtnmIqPBHsSeeBqGG/jCHoWt8ecXUx1W7/TNyBnvANqiAJX1ijkZV8Xpx?=
 =?us-ascii?Q?AHyKT+brF49rccF+zzEHzWAYaujgVZ8Tf5pg6igqrLAnf1zYBxipNzo3qEp7?=
 =?us-ascii?Q?IbpYsvoL1GhqIOmc51fblIQhEmNd0XFTu6G0xyjaiB4//Gm0yr/zDwBhz9iG?=
 =?us-ascii?Q?7E3VziBvusEN5FWbdoGbH3XxObSaDK+toLBW+k/STtdQPRZthnqoe45Hwa/e?=
 =?us-ascii?Q?ZWnxyuZe4vVbBqGUmIV+TqFAl89FzlFiUXZA8wlMNBOdcopD5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:34.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15bb5b4-4b8f-4709-34b2-08dcf961f7ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337

Migrate away from using an interruptible mutex to scoped_cond_guard.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index cc2037147c0fd..79feb273c1def 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -28,25 +28,21 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 					char *buf)
 {
 	int len = 0;
-	int err, i;
-
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
-	for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
-		if (len == 0)
-			len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
-		else
-			len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+	int i;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
+
+		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+			if (len == 0)
+				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
+			else
+				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
+		}
 	}
 	len += sysfs_emit_at(buf, len, "\n");
-	mutex_unlock(&profile_lock);
+
 	return len;
 }
 
-- 
2.43.0


