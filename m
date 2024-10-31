Return-Path: <linux-acpi+bounces-9169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FBF9B7396
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 05:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAC5285104
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 04:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47B14A09F;
	Thu, 31 Oct 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hX63oKhE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF941487C0;
	Thu, 31 Oct 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347841; cv=fail; b=BmfIP0v3SFeMPrvpaH5wCGplyIqYBoe8s5QtjQhA8vE5TJehlHUc0Gg+EYD+S6lySC5HBRSXCnJoil9hcAbc8pEligHyAlPbw+9wDpN4y5/KMz98ij4qRPgmG1doH64vx2p7jvV3ylii4B+ejWK7jIqqgVsbQOTomtwBKTgmlTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347841; c=relaxed/simple;
	bh=kZbx+5plx1y9L5bCopHfGpx/A+YaI2ZaYuLZ1EpbbYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYqk8npnMmB8+iUr7Y4+MYvs1hN0eedJZMyatScxvXJEgO5HQ8ScEZOEAfxqnp/JHdB69OzwfTtq+2wOUQWTgGy+PAInA39IivIHHuL51K9ocfuMdTDrwSR7BF8sQ30hQ5IjCmYBa4S3gflc2LXwELAvI2UE1sTnqTIslt7+qdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hX63oKhE; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEpfcGklEbmCl0hZT52wTOUPlOpjVkYbebwQ/PwBDuL3I/A++IPmRCFElNxGKuSunv0N9GNbKJdG55PX+2ZvEqjaK1C1vmiAbIMejraLVfKF4gzu5G86GB++rRoAwFyCNYjTc6REbkY4UO7fk76dbnbKfJQ1J7avKetvucEGr1jK3owNZBnvTnzghf/CzYP6CtP90iGpo+QtZZ5OmqYtWjyldCvMAoBSEQn4JUR2aLUdOIAbFpb3Xz4mqDH8PUp3uQ2w5r7MNA0O4NWRAfUiowsnvS5EgzMjuP7bx3nkPNf5rlSobG6lNISZCNxelmJZc/uA3iWwrzECyqZxGpYvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsZ5aFimorcU3PbFA/8AHd8NCIp4H4npWyPb1dAAxI0=;
 b=GZZBBysaeoXbdb6yqHzqXvfM9l/C6JT9q9mqBC0TFDKUnYj2tFS2p3+U2wHkO7LfmSpy5WwqL9A4zNqMCXXpAXUtwxiD+5sKGfxEkOi2h8FBzftVdnZWCpYzL35bOXkkKDhDgFLtZllYHbUplDZstGDF/ooszsuMFQ82iTMfkjn1/TPU3SQcJnpfhC1wdzQs29K0RppYhN1HkQWott9+ljS2WlE3gb9IOXC6ifB34y8MH+sYojv0f1CXYTqLZlje4+TwUP+SwL9cL9uAyfW9xE8+xBVF2rnx1leYcJyyffimjYP6DUHbZO8pDcXBaeh7H4VqfHqLErMx2nRhLPeVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsZ5aFimorcU3PbFA/8AHd8NCIp4H4npWyPb1dAAxI0=;
 b=hX63oKhEeCGkzTCAXJZb3CYMxw6S350DtUIMR3cgDhT3mSJeZohM9JjP33OkQTRSiEM1XV4ZDMadNeGLo4fBccqLQrx+pvnzMWWUOdnV+V0Ar6+By0AyFYQXhAV475l2aLgrIbeCeyRR7Cpwjt3j1m9ojggzHC/rdpOYkt0MANg=
Received: from PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::23)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 04:10:37 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::7a) by PH7P220CA0080.outlook.office365.com
 (2603:10b6:510:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 04:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 04:10:36 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 23:10:33 -0500
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
Subject: [PATCH v3 09/22] ACPI: platform_profile: Use `scoped_cond_guard` for platform_profile_show()
Date: Wed, 30 Oct 2024 23:09:39 -0500
Message-ID: <20241031040952.109057-10-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaf378b-a87c-452e-4bdc-08dcf961f946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSiAMMF/HABaf6wLDcC3SI6gjdH37W61RhFmk8U76xTmc8prJLEDOBD9UD98?=
 =?us-ascii?Q?3APkkm+C2ix7weHmj/jDB8qrICX/TL8KKxu1NPQVau6z/X1SsRCOFP/7sszw?=
 =?us-ascii?Q?rht91ug2NE8Ist/39hBhtMfpWatIe5I76ZH7ffsCaezWoNKIu1M8CQpNzdh6?=
 =?us-ascii?Q?LkUKdDU24t+ieTrSOkk9sCEJXyyJjY4PUK79yhZR6ADaCyS1OltgzbVJ5SR0?=
 =?us-ascii?Q?LH6/9/qBd0Kq+lX4OQBF/i0vy0nONlGI1ATwJxJ2LZsOL6XKL+DQnznJaZ2a?=
 =?us-ascii?Q?w+TCB8TlRE0Y8/TVF/md01kyiCWSogmY12RvXDLp6kNTWdfG/aVHsvY1oJqG?=
 =?us-ascii?Q?eMfv8vLdL+sywS8t02DfqXOPYZK0OEWOEt3MF/nHgbTgnz0OvQSAzvkbqQgM?=
 =?us-ascii?Q?DJfrZO2s5dY9cG5Ygmh0ZWkx+dGFbsUdPacBvJbCDvr60C1XpWGpx3giocYy?=
 =?us-ascii?Q?lgxvDzgNiSdoGrtNgvKnkQ1vYKyzcAhoBzMQ7hsg5Ku1buP9kjBgK381oZnE?=
 =?us-ascii?Q?hOBmrPNwidi1fOHpHCjK3hQhhXqtsHVQigCEPBRr/0V5e5wdeyjN/Fju3SEI?=
 =?us-ascii?Q?+LRPngvSUWl9mEb7UKtEDiyOz1KTEQzGiG0SGRImXJ1r5JqWEA7HqSX5TO4e?=
 =?us-ascii?Q?Jtgv9GtESOQuaqyFHgYsxcGhxm+9hW/Q6a0ZLpCPp47+ziVfFwhDzQiCECqi?=
 =?us-ascii?Q?TpXU+ust7QHx1Garh78kFhlSC7nB1OMd3rneXnjFRyJ9nGE5jiy+hjFDcnpd?=
 =?us-ascii?Q?DMIRoGlpSZrGFjL3Qqe5TPPEzEVpWH1NAjMreR0+uKgIzbq2YozttB+nPt1L?=
 =?us-ascii?Q?Cv9gVwgxWfN79yVJ7quDqCEP3PSxYhIZq8EwodXYH+naBd7mUg7N/s/YTq5Z?=
 =?us-ascii?Q?vzWBUdSkQoIEXZOHXvuuU168niGLL19PHod8BFhtK/1zJN70vRWStzP6sI8C?=
 =?us-ascii?Q?bLix0fZea3LQbT+/RQVkoY2Fl9/1FztAMf9DToJJyYhzbknsQIv/ILh8s/Pc?=
 =?us-ascii?Q?1vBLg5eplnpf6618sHb3urkTb1xD4jrCLftATk5Y0Bn7dzamYuxWvVNgRS73?=
 =?us-ascii?Q?xYz4jzU8JBJUcJWx3HNk9rfkwRRcFLNj6ZcQ7oBa1rgHdS2sDMm4csqrm9ql?=
 =?us-ascii?Q?05Ugpm3f+i4KW+mXYiTCuCOO/pVkUBZK5h85Ktn9BkFgycEMrFIH4Y3/cWg6?=
 =?us-ascii?Q?c7PxWEcFt79MIP7Iwt+VpHvGrC+hE0hbro1MJ1NAzPtHIHZxTYL/m/w41KhL?=
 =?us-ascii?Q?QgF4D8ZMXAV9TLmOEZ6ylFTC4AobF/uU38q2XSiuGlkVhSbOOf7jOezA+3br?=
 =?us-ascii?Q?EN+Cpc8AxDNz2spK3YilhBwh/JKENYPMQ3+IEwLQb9FoLGM3AhtQRSbi9fIt?=
 =?us-ascii?Q?ls0gjx9FnRb0oJ4Uq5YtIwDtyeDvaN3WM/RKecL0PAwzCYgZyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 04:10:36.7326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf378b-a87c-452e-4bdc-08dcf961f946
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

Use scoped_cond_guard for the interruptible mutex in
platform_profile_show().

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 79feb273c1def..b48dd34301f13 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -53,20 +53,15 @@ static ssize_t platform_profile_show(struct device *dev,
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
 	int err;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!cur_profile)
+			return -ENODEV;
 
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
+		err = cur_profile->profile_get(cur_profile, &profile);
+		if (err)
+			return err;
 	}
 
-	err = cur_profile->profile_get(cur_profile, &profile);
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
-
 	/* Check that profile is valid index */
 	if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
 		return -EIO;
-- 
2.43.0


