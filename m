Return-Path: <linux-acpi+bounces-9026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B899B224E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E671C20FE4
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B36D18E74C;
	Mon, 28 Oct 2024 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVZDXmI1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AC18E751;
	Mon, 28 Oct 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080950; cv=fail; b=X0+kLxNu8Ag3VIZUyPK0yy7pcW6EgbSa0uk9PlunTKJj7fn7208vBdPy0culK7JyuEr+ThsJ7NYp7FqnhKQcIKTIkEo/uMIapUSYJUHIyjgHPAJVwQ7xn0jaa/5IjgQowS+I+FwHDBof3ulf0Tvs8JeJGxMH9Ic9bKJBgomYuRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080950; c=relaxed/simple;
	bh=hRMdJxh2U6nRN/XXacx1ArC9M1AvzMSxjV3SY+R5fm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1XOyE0e8/ugMKM6Q0yLCVoJwyuuMiUJIOQn4g2gWX2Hwq5xstxT07WVMDGkxxXMuGP7DZTXwtpRPYgePI2nFtZNgWdFUqsClX2fqSqI5FNsd6R7CgHOj1Z3z/jVq4wSfF98HBkvMJgj2Zn+rz/DxIg16vyqYIlbWqXXHto349k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVZDXmI1; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9k4fXoXVmobvHM9hPuMS3lKINN1n5KEOfCNLDD3IwWpN7kLIzeGgOI+mLMo/iOfoNlTuaBQ0i2BIUDv4CDz2lBWLnCxv78cwlHe//RsMTDam+ZeaCRo5qA0IvLa6g7AVaQLUcO7AJUQkCXaD4WlxWxRnJAo8lWzwjE+K6WcmUsiccgtUhDQ2IvyWJvtd5exycDMw0u/Cpd0L6jTaL3geO8HxTJT82+7oVDCYQXPd5TcFNUZZjt045tEA/qHivIhQfiOBI7bQ/tvT+oDayTBz+6CeQdCvSAWVjd32v2EnHMCgsa0UuF+/GnCoERnO/LZ6J1vsJc89f1cj1FMS0o4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA7mkXOyFAEZsu6LCLTcVYR3EdIJJE8Ibol0D0QosHs=;
 b=USR5t8BpYdXg2h9ZKb7flDB8INMPoWE7xd1JW06sLipr+q3Uh58OZPpJN9abvZg1W6az4phgQkopfw8l0lkAQlO1HYDh/R5hDlQQNuAsEaBAkwwWWvIdCwFS/Cp7wrKvOdX0fModuLGLBwXTiylsbc07p6Z4XSyXyb7+O00P5F7QGWrY0EiSiF8Sy0GWopmKnLSmi4O0hy8pSD51wwM73QlTDTKHhh7BbnG0JFEcm0j4TzMl7nipi4Q8I8dBAOTCbeVatUquTed89XJZmtcIj+n4HY7eVajgregFkgmTIfNYp7noW/sGBk5qItBHzllG7ZWU1P6exOaNu6BWbHX6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA7mkXOyFAEZsu6LCLTcVYR3EdIJJE8Ibol0D0QosHs=;
 b=sVZDXmI1Mz05dywID0eJ1KELna0nbToz5HeVRx0Mu6T43q1dgc4+uCUDg3daL+T7HrD4OVCR0Iw2UOHrf0Vmzq3DPCUJlUBDo8DZ75sRvS9LSXGAkqpaHuy2kY6KDzR1K4fmJ0Nsatj3VN8tOcq8SbXzyWjoBmNgs0otPwaCDsk=
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:02:22 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::73) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:16 -0500
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
Subject: [PATCH v2 11/15] ACPI: platform_profile: Set profile for all registered handlers
Date: Sun, 27 Oct 2024 21:01:27 -0500
Message-ID: <20241028020131.8031-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028020131.8031-1-mario.limonciello@amd.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: d4632f72-84fa-4983-55ce-08dcf6f48fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xH4HIPyIbHfiB1ZP0KqL7v9V8I19eEuT6UAZIxabX3Gi28bpdy4eseAKWc+d?=
 =?us-ascii?Q?0nl9FqCoK4vQrNKe0zOIdRRsdxpZLzAR371Fy8CqFHDJtpt7pxZBHtpWpq23?=
 =?us-ascii?Q?V5H1fCMHpRQyzjiMqxyofX7mTAgddmBxUhD3GD0NQ+uymIvVNSSbiRVBD/9u?=
 =?us-ascii?Q?XmUIM1S1pQpCacaVAxDDC9j8rnGJLin0E/M/eeIYchpBnk14n4V81zrgsVwH?=
 =?us-ascii?Q?M/thy+EYlZOh7wGR+kyum99lLSE09EnfwhnW6OwUtqLW0so9HVn+PSPPGrDy?=
 =?us-ascii?Q?Lq47O+gQIt6yj8dMUmyd4rgZY+WfhEy2aASFNYMDBy8XPx5+xQBUp0q7WSBo?=
 =?us-ascii?Q?cI55N18Rr9I4AnO6vSL8kOvsho1b9URw/HbrNhDXWTygt6QQbYMJYz2rHCnI?=
 =?us-ascii?Q?fkqnRXSLHEzc1pT1TMXXX4FpkifaXCJH0md1nYL/hy66gQ4HKM7j8B5aWxPW?=
 =?us-ascii?Q?osbXMvCDISAi9NeikPKAAC1k1Kaf58h+5Yj0NMIr4/JZIqQOXCRV1jnNzA1U?=
 =?us-ascii?Q?tmw2AoPd7nviiH4BlJ1l7iA+bvDPZVdNq7zPSyvAtoO2rpRE0BwZdwgAAfpd?=
 =?us-ascii?Q?GyMhMWcP6s1lB/sfd9kuJkXBkg+KPXEcT3C1wKVBJrVo7nxqOnWzhiPEt5Mu?=
 =?us-ascii?Q?1m9ks4Ah1ird68EWvF7+ieQLr+ssgHzPiLu3gV4egcrEh3x1OYt9nFhThrf6?=
 =?us-ascii?Q?dPlQnfcR+A0sc0ur+v4dHk54ZXJrcuj7n3fK0NiwvVLEJHc8a0JJt7ATF51d?=
 =?us-ascii?Q?v4FubE+dEfMyebPyeQnIMcgQGgYF3K96R2sQq1t8ENowuIrSYLgXAJWBn2ym?=
 =?us-ascii?Q?p74jt+PRQe9SG5wd09vnVmNx4h0R/0Q3mOSeh+HXot/D/IC1GcE5D8+C9cRm?=
 =?us-ascii?Q?zchz99YOmxnuQfZtNDaKZ7XnpFwYPLImxKsqt8uq4NZH3DpDTf3PN6FyLnJh?=
 =?us-ascii?Q?tpyPLm2mIXiNHQsc4c5A0r6/6uPxEJuzH2H1psjWbNtcVKSA86fv5jy5cjwW?=
 =?us-ascii?Q?/w9CvlK6zh9NvDNd8lI35y3CyZLznwd0Ytl88uHhBMrZ1BhpmzjuODQDV/IL?=
 =?us-ascii?Q?z4Hl0sDaOfN+ABS/iEyfer5fdhDjZ3I5v/dhTdhi+uNmVZH8Bh5lpSehfxHy?=
 =?us-ascii?Q?EILjkFlNRVUxSNVWCEM1O4mR/qh61ZjvM19K/jAS775G/GqSLsDbZR6nVQpm?=
 =?us-ascii?Q?AAUWiEkkORy5jf2VC2co+HVN9Qi0NmYl/IZk5giFwd184Kp6VHfpqiIlgTeV?=
 =?us-ascii?Q?i+mfPYrox7udrL3G/ZPdlilLF/lN+DOvF6pXcoeu4I0Nq3mGjpkxReuHQA5L?=
 =?us-ascii?Q?p5J1MKZMh9Pu+96OCAIhqt/NAnj6sLYruk9ZsSTj+hdRpvsecZmmTsjxl07A?=
 =?us-ascii?Q?gTcfY2pEHgWtKpp5JBkQg6rx//VT6fJLoWxLbygpR0T9+ej/Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:22.3998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4632f72-84fa-4983-55ce-08dcf6f48fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

If multiple platform profile handlers have been registered then when
setting a profile verify that all profile handlers support the requested
profile and set it to each handler.

If this fails for any given handler, revert all profile handlers back to
balanced and log an error into the kernel ring buffer.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 47 ++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a83842f05022b..db2ebd0393cf7 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -105,37 +105,42 @@ static ssize_t platform_profile_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
+	struct platform_profile_handler *handler;
+	unsigned long choices;
 	int err, i;
 
-	err = mutex_lock_interruptible(&profile_lock);
-	if (err)
-		return err;
-
-	if (!cur_profile) {
-		mutex_unlock(&profile_lock);
-		return -ENODEV;
-	}
-
 	/* Scan for a matching profile */
 	i = sysfs_match_string(profile_names, buf);
 	if (i < 0) {
-		mutex_unlock(&profile_lock);
 		return -EINVAL;
 	}
 
-	/* Check that platform supports this profile choice */
-	if (!test_bit(i, cur_profile->choices)) {
-		mutex_unlock(&profile_lock);
-		return -EOPNOTSUPP;
-	}
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
+		if (!platform_profile_is_registered())
+			return -ENODEV;
 
-	err = cur_profile->profile_set(cur_profile, i);
-	if (!err)
-		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+		/* Check that all handlers support this profile choice */
+		choices = platform_profile_get_choices();
+		if (!test_bit(i, &choices))
+			return -EOPNOTSUPP;
+
+		list_for_each_entry(handler, &platform_profile_handler_list, list) {
+			err = handler->profile_set(handler, i);
+			if (err) {
+				pr_err("Failed to set profile for handler %s\n", handler->name);
+				break;
+			}
+		}
+		if (err) {
+			list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
+				if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
+					pr_err("Failed to revert profile for handler %s\n", handler->name);
+			}
+			return err;
+		}
+	}
 
-	mutex_unlock(&profile_lock);
-	if (err)
-		return err;
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 	return count;
 }
 
-- 
2.43.0


