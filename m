Return-Path: <linux-acpi+bounces-9993-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AE49E64DD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 04:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC83169648
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2024 03:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E21922F2;
	Fri,  6 Dec 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YgXt6Y3Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168E190482;
	Fri,  6 Dec 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455551; cv=fail; b=Ni2i+cyGjQDHyDamMizNpRlL+S9tTSPXpWRRTc44lLhYzsh9gZ8Lzwo65VRmiHeEFKc3H2A2fw1yGV1e0WI/K1lFbDf+qsgVZ7zqIbgqDcDDUllzJUCoyitE48kQ/+oHnX21faMV/Avy75Pq2w3gKma++hEkISYmRDo1bbZI+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455551; c=relaxed/simple;
	bh=JewyXTxhFRqy6h34+YKrMpsgMeLgKwlZqckAx0I+7ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrVHY86w9Lh/rXFdIsbgckXWci2HsFHoQmWzf+hozRPb5VbA3Xd7fvg+OcwR6N+g4PAEe2IX6FIsuDNABH0MzwO1VE5AlC+iASDU6FLwio7RKQb6wVV4kksBcyIs6QlvSwlGZrhADxXH2ZdrP/Kp7qlQ5s6jzAUeyOJpba8Mf34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YgXt6Y3Z; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIzWVOz4BlAG3AupRYjg21REcNcznCvf0ncG1O+Y9Kzku979MPZUOx53MX6OKMELe5pl5JI39+ednSHKfELe+JES9kAqTkgX4ZcJ9bCTfPEFZpDlj+TzZ5zvOy7MppvrC7zNUwkV9Dy1DeBWoZdJRucdbd7YSIEOjOXkMq65A5I1LBvANLdwSXfdShboCl46zf4TZwiRRs5dIIORwGcyx2nO7O+oyqLWYeP9cMxQ8jxXg1aoHkKL7y+dWPc+fyke+OU8mwya9om9NFRN8N65QiF0rvlKcQhsCtJ9V3bE6hlfyDGCXh7FrsINQ0lU9pXqiG0SFvKGkZMfXcTV3wYAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=mCJJhqj3hV6GzcXguPbzpQO8UzCbUivxR/0JBYPdCAEcwo8mUkHKIXpoCaRH2WBINdPzxjLt2x+R0ezdxQS/elRQWeYgpJbrkOvknJcUSm1YV53OaKHngGdjgGQxQ+6b1/F5/T9UYmer1JYIzBcky/BL251HiuziIrWKO4lZhuSVss3f9zIv0R2dkCY3S7aeK2/wsX/78JehbOl7214isRnsFN29A59Z3Gu1IRMJh358eHYnACUGgeNg7SKiLLWsPwjBT9jSYESpYAse/6hX+XDiQLbS8qxhU2UIQ6ccxiwWnraf03bE8xDF4gIY70O+6ZwxLYByavUYa2bmaz7x5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se/DRSG0jq4mSe3JIlni8+u15VBvik79rcxTvY6iGeE=;
 b=YgXt6Y3ZUUpBN4ptRQrxW6dvM8CvjmuurXiLJvNUFu4vVjFz6bBi5NLoqDfAR4nFqMzwPZOC/RQivZp3dn/prdfReWFvoO/AkartYI6RHCSmkUZ2/251yaa5c4W4hFSqlbk5OFnxpTc3IPyiyE8kFqiq9FmQ9jCfYVmmF6igVY4=
Received: from PH7P221CA0064.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::18)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 6 Dec
 2024 03:25:46 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:328:cafe::2c) by PH7P221CA0064.outlook.office365.com
 (2603:10b6:510:328::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 03:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 03:25:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 21:24:21 -0600
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
Subject: [PATCH v10 08/22] ACPI: platform_profile: Use guard(mutex) for register/unregister
Date: Thu, 5 Dec 2024 21:19:04 -0600
Message-ID: <20241206031918.1537-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ae3787-458a-4eb3-c408-08dd15a5ac9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGRDdlpQcWtlUlJxUkNnZkFSQVUxRDVha2pNQXBqYW9kOTc3d0oyTTlmSi81?=
 =?utf-8?B?aG00SGVlNy9OOTFneENGcGM4WjJtcjR1K0lnOFUxZFY0SzFDQWRkTUgvdktC?=
 =?utf-8?B?R2p1WGRvTk5YTDIyOGxrSFU1akkrSFllNldnQnpRRVZzYXZEcnJqT25ZOUNM?=
 =?utf-8?B?clFvWXhiSHlDWVdOSTRheTNIZkU4UW14UEQrZ3BrM0tQdzRQRVlObGhaVVdh?=
 =?utf-8?B?QUN4R2o0bTBZRmJwcUY5TFdQRFQ3bFk4bXF2VEtOaTcwa1RmT1MwR0NXVW5o?=
 =?utf-8?B?TU9QMUxHeWl4RkJLd1MwaWIxMU5FWnJYYk0zK0ppdkxBN0U2c1Nob3dXeDZ6?=
 =?utf-8?B?K1BCeWtDRzRFRjVxNEMrRDVJTWtITnYwWStyY2dmQ0JGcVlXdGdTbWt6VkRR?=
 =?utf-8?B?VnY0WXlyMmczUFVYalRPVlZDNkR0cGEreVYyY3Nma214T05SUlZtWC9FVUFZ?=
 =?utf-8?B?WVg5ZkRDd2JuSkI4Y0Zia1B0Rmw5S29WdCtOMVpsQWM1dHJ2MHpoWWFzaHgr?=
 =?utf-8?B?WGQreGVZQ2dheE91Q1Vaa09vZ0czMndjMWR0a1dKM2hZOWJuQ3h0c0cwd3N2?=
 =?utf-8?B?THI1ci9MdmVGcmFHeHp6bXY1VnAvWHpWSmJ1VFVlcktGZXJYUk1WZ2s5b1Vl?=
 =?utf-8?B?VEg3bGhtbGordGhGTVJ3ZWYySGxRYnNkTVJmNFIrRXlob2FyOU5od2JGR1lm?=
 =?utf-8?B?OFE1VXhha1MydDUwTldSOVlYalE3UFc2US80N0hCdzh0M2ZZMjB4ZDMvNm9C?=
 =?utf-8?B?QlNnb09ncXlIbVFJbU9BY2dmNU01ekdUKzJwVGZkRGlEd2FxRkZiVkk0R0NQ?=
 =?utf-8?B?bGZkK1NKbnhGOVFaOTk5MmUvaEdobnJFR3dHeDNJeldaRnUrODNHbFJwRXp5?=
 =?utf-8?B?OUtHc3NOTjFaNWw3Z3A0QXNMdnFuMUg0a3hZV1BDd3BOd0psMVliaGoySUFK?=
 =?utf-8?B?UHdZMEhrVE56ZmtSK2E1ZFZaZ3RFa0dQMW5Db2h5TjJhWUFDSHFHYVJhV0tj?=
 =?utf-8?B?QU9udGhYS2lpc0JOSU1zeTA2SFlSWUhZZmxWKzBYTDg4WkRZQ0FQWU9nLzlv?=
 =?utf-8?B?MGJHKzhrU0ZmOTNWVHJ6WkI4d28wWmJmRm40NGFUMm5YT1RYWGU2QWlwZzlp?=
 =?utf-8?B?WFZReDJQbTRja0NiekZnckhIK0NQakNrUXlpa1Z3eVFXTDJPL2R0WTNNc0hX?=
 =?utf-8?B?OXJnT2ptS3FjQVFrMFJNS1pWWTA3dWZKT28rTXYwN3lJZGs3aHY4ck1ubTlm?=
 =?utf-8?B?c0ErNFRuZXc0cE5tTVQvbXp4WFU3Uktpdk9MdThKTGxmeldMSkw4a0V2cG5j?=
 =?utf-8?B?ZTVaNDJGd29zZ2N4ZG1CbGRkUlg1KzFpd1JRNHNSUjNNZTF4QmJYRUtuWXNZ?=
 =?utf-8?B?djQyTzhtNnlReXVJeXNjWVpYYTJaSFRvTml6SlIxSWxiU1ZlbVM5dENuNXd4?=
 =?utf-8?B?K2lrNHRDVHJyQ3pKTkxoZkozMitkMnh3ejBRTEROQ25lNlRBZldML0c3a2Y4?=
 =?utf-8?B?WFFaUjRPcFljU1NlalRMeVU0Vk9Kc0dwWVpKb3BRSm9Hc1c5S1NXSUpnT0tZ?=
 =?utf-8?B?V3FuK2R2OHVkVUtxRXBNNWhJdDVXWi9mWW5wYTRGTHV2UTBqRlpERHBJTkZ5?=
 =?utf-8?B?VCtMRFZjcURUY0NyamNhSTMrMWtEbHpJSlJzWTJwQlhlOUt6Y0h2VjdHSlkr?=
 =?utf-8?B?eVU0bE1PZnJjdDYxMnB0TGpUVkMvY2ZqUytRT3RGbmx3eFN1MmIzQlRUZVlL?=
 =?utf-8?B?MmMxTkVOZjlRTHgyczZURUpVdDF2bjlmTUFHb2R2RlIwOGZsVmZwWmkxSVIv?=
 =?utf-8?B?Q01KSW11VHNDcUQxdzZKUHpiZVZPNFpBWmRTSWtNSlBHd25VVDZncEM2UjZy?=
 =?utf-8?B?VzViV0c2Y2hySVN4dnRUTzBad3FPV3JKZjljc2pQbjl2UGU4TWhobkZ3WnN0?=
 =?utf-8?Q?rQPIJNzu8pVbcqadg+5EDaiyOJ7Jp5cy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 03:25:46.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ae3787-458a-4eb3-c408-08dd15a5ac9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

guard(mutex) can be used to automatically release mutexes when going
out of scope.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 45ffd85a71dd5..9729543df6333 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -184,32 +184,26 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		return -EINVAL;
 	}
 
-	mutex_lock(&profile_lock);
+	guard(mutex)(&profile_lock);
 	/* We can only have one active profile */
-	if (cur_profile) {
-		mutex_unlock(&profile_lock);
+	if (cur_profile)
 		return -EEXIST;
-	}
 
 	err = sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err) {
-		mutex_unlock(&profile_lock);
+	if (err)
 		return err;
-	}
 
 	cur_profile = pprof;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
 int platform_profile_remove(struct platform_profile_handler *pprof)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	guard(mutex)(&profile_lock);
 
-	mutex_lock(&profile_lock);
+	sysfs_remove_group(acpi_kobj, &platform_profile_group);
 	cur_profile = NULL;
-	mutex_unlock(&profile_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
-- 
2.43.0


