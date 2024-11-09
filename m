Return-Path: <linux-acpi+bounces-9463-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C69C29E8
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 05:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF5E1C2187F
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 04:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BA146A97;
	Sat,  9 Nov 2024 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fW4iGcha"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01A14658C;
	Sat,  9 Nov 2024 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731127353; cv=fail; b=WzpOhmfDgDH2gsoxBQteJu+szTF2H32tdpoD4grJ1oJdn1iqR38OcIZBHOh9NjoRv1iCc50aAnfWc1o/4Xb81gLfw93FWzdW8ChNdRqmp/i0eSYV8lJLAGeSvdotN/xqIeRu7YZbIkrjHWfDKuvgaK02HRMkx3vrb/PuUny3Cm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731127353; c=relaxed/simple;
	bh=vmgke1hNgi+9jY2YjBI6Ei/XWu/10vuyZ2DT0pBncCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoiBBU2pUnd/gse9YD+7XkeMrwlwEpVL0gs4ZiDmyt8fFlqN6ns36As/S/DbrfDaz3K6d0VGDzX41xDgmn1NdBN8sdLst+WKh0h27Ar/ycTjXhixwsX2XRhrWQ96J9XbAw1p87uHdoNQXd7gxPGkiLJ/zVY+wDbwCN9oviascfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fW4iGcha; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeADo22EtHaZb7IeoQdTC35nX4m4DVRUUZ5S43oKrSOX7tBD2oqIW6uNhwJfIK6Omhx9s+YVLIS8WA0znUUbvcycs9ron6XBQ1e/nLwdRWEVKaPY97qmAocj/RF/9gpHKaMtz05yawD/LREcemYu0pMntDZYKqpWiM91mBwAiO3WhOwjYTXp6HteJURyrt8Kxn9cx2Pi1d6PWO8tNrBhXCcBdlDll/MCqS4UW31eLZh0+YlC2O1eoYFOJ/zIFdiiPwUktyGODg/CJIf+tJNAC9AGoQtX6hSB62R1qNksHroRjX6twThDE69H6cjkpnOQZp3xkyJtKx9QI3xDM2kmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JOepbNXpw+MaowhRv9S0+a5ySr6FY/Rm6BniVYK8xY=;
 b=XhUx7/lKmWvwO8ckBGXIja7xdR5P0V0rqMfNmzRsnk1Hqop7O4A48jTAYAbYnkBhTBbIxaekIKUyZp9xhoiruUB0uFvHuGbOTVa2vsefWcca5XSAA0PailsFRH8oB5DwcmGiTEJlw2IycspkpNi7ERXpzZ4zVPonSqG3mRdoazJ2TJxg0g3jHFX8Nn7b0+UlkgI7lvtqwA+oHNFFnEDbGvMef98zza6OiSc/8gbC15OJDePXYmk/QsMw5yb9Z10plQAss+jhtk7pOGil/6dva96q8+yxNIzYaTwf/6QGYkN6CkV/gDQPPWXf9XNH9BJ9cdin/Bv6RAJlqNQeCxw/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JOepbNXpw+MaowhRv9S0+a5ySr6FY/Rm6BniVYK8xY=;
 b=fW4iGchauHs6ApJwxH4e6nEeUAoi8ZsRZiOg6FrbVYeX9neDR+P2xI2QaiMqEiwuBDxNqVV3Tj38a4opUxnjR1HW1zCXR3qmEiqQfwvTHNSnh9ey1mZfhow2ZErNAmzFYCb5GIgEiKik3FJFyFDh9n3xbhWqKuU6DqoN7F/0vmc=
Received: from SN7PR04CA0224.namprd04.prod.outlook.com (2603:10b6:806:127::19)
 by IA0PR12MB8648.namprd12.prod.outlook.com (2603:10b6:208:486::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 04:42:29 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::23) by SN7PR04CA0224.outlook.office365.com
 (2603:10b6:806:127::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Sat, 9 Nov 2024 04:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Sat, 9 Nov 2024 04:42:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 22:42:27 -0600
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
Subject: [PATCH v6 07/22] ACPI: platform_profile: Move matching string for new profile out of mutex
Date: Fri, 8 Nov 2024 22:41:36 -0600
Message-ID: <20241109044151.29804-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241109044151.29804-1-mario.limonciello@amd.com>
References: <20241109044151.29804-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA0PR12MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6680f159-39c2-4474-fda5-08dd0078ead3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlhtbWxLTGVWbS85Z3YwRkJTcnJSZHVGQnBDLzJHNXRTNzBhSndGaDFkcUl2?=
 =?utf-8?B?MWZVMHZJWkZqMlpMK1V3Ynl1VG9mWUdjci9CVk0rWGhUZ2JZbTdKSEplL2VU?=
 =?utf-8?B?b0lrZ3BnbE0vWGF6Znd3OHgzQU5TTFpuR0hPbUpHWlVuUmFpTGhLUllrSGpM?=
 =?utf-8?B?blVYZkNpcGtHTXFFZWJmUzRaVzZNN1cyVU10QzViZ0h1UCtyY0lZSFRETSt2?=
 =?utf-8?B?ZGQyUTIrZStJbW13UGx0U1FadW5QeFdZK0liUkdCQ0lVcUtTOTMwR2dzZUY3?=
 =?utf-8?B?UE5DNGhXbkdwelU5ZUlDMnJZWWlSRVBQQTZldWpPWlRVWXRZeVYwVGgydzc1?=
 =?utf-8?B?N0FHeEREeWNzWFYrbXlnd2Z4UlRpL25BNC9nWFh4YTdQUEZZbkhvMnNSd3Bv?=
 =?utf-8?B?VFRuVmZrN3VqTS9mN1ZYamVmcGxuaFRiQk9yTWVHNm1YVnZacXhaVk1yNDVM?=
 =?utf-8?B?cHNJemc2cUFFbFZtdmdrWDlERWVwL0RGazc1VkNucjNzbTgwT2VYT042UEtF?=
 =?utf-8?B?ZUZMMjk2aytFaWFLSnhaZXVzbStoMEU0V0dhWnV4K0dORkZJaiszM3BNR1oz?=
 =?utf-8?B?NTA5VzJzK3hvYTZWOUdTMTRkQ1VYNTIrN2xPY2JqL1RKZG1HdU1RTjA2SExM?=
 =?utf-8?B?MVVzSnBvenF5MzZuY3JkY1VsUFBVNXViUUNwOTN1RE5XOTF6RUk4Z2VETDAv?=
 =?utf-8?B?L2FvYjNLWkk3ODFKZlVSNmN0UXdWT2Zyd243U0VBTGM0M3p1RXlObnpuWWRq?=
 =?utf-8?B?L1FXenB4MXdWdXNvQ2tXNW5Sd2hNRDhWTjJGajVCdjlLTWJVcjhwbnBYdEpj?=
 =?utf-8?B?ZEV5WVJGSS9BaFZMZitwK0lwa0V4dTdkbElveUpqd3J2Z05jRDJoSytRTWpM?=
 =?utf-8?B?U2d1RUNNc2ZENWVIai9TUlhXSCtObCtKTUphMWpQNFF5anhmdk9CbmtHU2Nl?=
 =?utf-8?B?ZzF2SHJ2L2tNeXZzRlBVbE9ldnNCdVRKVVdONERJSEhkVHhxUVNlb3c4SUpp?=
 =?utf-8?B?WlNmWklZREZGemcrVXBGeXhNTGc2NnUvTHF3aXlrQlNESVJwVHlmelF2ZEVt?=
 =?utf-8?B?RUhndjhGMG92SzVTa2xjNTRnT2ZEaHJ2WDN6Wld1dURuZElLZVZZRVorZStT?=
 =?utf-8?B?aEpNNHpQSjZDUU8remV0cGNEc1hwa1JmR1ZRMEFwb2NWTHR2MVUxeUxGaTlJ?=
 =?utf-8?B?RDFBYllkZUpkR0xSdXIxN0lUN0NwM2Z1am9tM0tGVXNmUytDTlA0ekRNam1s?=
 =?utf-8?B?bEdBeThmTGlaT0pkdnczZ2JjY2Y0RjR2SitpM09nVU16bHVhZTBjMEo3a1Yw?=
 =?utf-8?B?WFNYTVNrTitFemJ3VEg0c1ZyZVRTZm9oVjNEei9wTUxwbFNWWlNjb25rQmcw?=
 =?utf-8?B?ZFdrZkdSV0tOajFrTWdTTGJFTzRkNEgyOFhadlA1RG53Z2w4bGJZR25RUnlC?=
 =?utf-8?B?eldpVklDaC90MVAzbjYxVGxlbXZ4dE9ZZWNOaG03WlJ6cCtOQUdFM0FVUEpM?=
 =?utf-8?B?Z0JqM1ppTCtReHo3TmZydVJEaCtPeTZQbnFwSHJ2d0x4WVpwbHNHcUdrWkEr?=
 =?utf-8?B?M29peTl0cDlGRVZPZXh6SFNOK3JUU2JwK2ZVTFRTZitwN3ZyT3Ztc0pESnNh?=
 =?utf-8?B?eERlS0RqWVBRSzFrTGlrbEhtVWM1NkVkSXp3clZPQ21PVGVZT3lYSS8wMzVl?=
 =?utf-8?B?QnhaYStlSzdIVmk3VGVVOW9EVzc3Yk1uWUpwSTlWNXFFU1JzTm9OT2pxT0Fl?=
 =?utf-8?B?RExiaUp2eG80ajBCUVJIcjdWVUZ4VDN1d3JDRTU2c0ZvSEd2bDMwY0xoTU1Z?=
 =?utf-8?B?Q0F5aWZ4T2dhRndCOWxSTEhTY3RBbVRaWHdRc2djQ25ERDd4MGRQa2IzN2hn?=
 =?utf-8?B?N0VzV1JtajlOSkpXUHRWNS9ZZE5US1VVNVE2N0FQL0RWaXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 04:42:29.1534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6680f159-39c2-4474-fda5-08dd0078ead3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8648

Holding the mutex is not necessary while scanning the string passed into
platform_profile_store().

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4f5623fc27c09..45ffd85a71dd5 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *dev,
 {
 	int err, i;
 
+	/* Scan for a matching profile */
+	i = sysfs_match_string(profile_names, buf);
+	if (i < 0)
+		return -EINVAL;
+
 	err = mutex_lock_interruptible(&profile_lock);
 	if (err)
 		return err;
@@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *dev,
 		return -ENODEV;
 	}
 
-	/* Scan for a matching profile */
-	i = sysfs_match_string(profile_names, buf);
-	if (i < 0) {
-		mutex_unlock(&profile_lock);
-		return -EINVAL;
-	}
-
 	/* Check that platform supports this profile choice */
 	if (!test_bit(i, cur_profile->choices)) {
 		mutex_unlock(&profile_lock);
-- 
2.43.0


