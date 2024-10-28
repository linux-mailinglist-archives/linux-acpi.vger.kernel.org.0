Return-Path: <linux-acpi+bounces-9023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8319B2243
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE391F21BBA
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 02:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCD18CBE3;
	Mon, 28 Oct 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1dH3byZW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004E17C7CA;
	Mon, 28 Oct 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080943; cv=fail; b=atiYzyyZz3XbD3aGqwsxyCgT3XDKk0RzZ0kGCgDa3wgUsHA8d+5eZ1UZIGiMfJj+XL6cfybTiiInhBBojOHmVIVST0HJmwAfBZlVcjM9Flo0MuLhL2KFOuSjXKYQk7zkp2h0hYXR1WGORp19T3R7Zk2ZGBAThbw9JVJKMC4Z/Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080943; c=relaxed/simple;
	bh=XLPamADJLZfp+QRrnpgSyNvglDNODtTm97g6ac54/RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG+lbgPA/DT3Mlp5mhMVqRCyRGlCI2j7jyOqILwmIZuIw+NzPoqJRAFGz0HRg0AIhaDK+clpldVOi0PAs2+MzV4Wag5o7lBtM1CPOQdgLLxxsScr+2CFKguj+ENUiii0BQQBlfcTnvigCc+8+qifKWmOWT+fEOy/tC+fJJG2cgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1dH3byZW; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2TIHntpxidNf2J8oFxmAlQH1KQlqdnroqC+layPDlf4XvDENPVxnw5jeOP5gnYUtd3mNT17VSJkIIn7hCFJrVxrXaektthOlQGc2Rtabmmy7+EE9o2BARiDcoRczTvZ93l/fbaGVJNX7U4kuAUoRlmIJsO7dGuuuIWFsoAMKWQTcqtAKnwvrkvv7NrPQ3wfKO8eGYRv97LxYYvXSZftbfWUocM2st2PfuTsFcjTYgmBuUFeJ8+h3IiYmk9jm6Dv5XanKQrq++GvDOI/Dqef706YQ2Hp+P4khFP7P9TiafJXBUD9H5vStee2BVgoLSDZjKho3GfQCTH1+/vjaZrDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V748tjTCdtkIRvVRuGKJfwfBGGpjQy/Ltv/OSoFcYZE=;
 b=EJWiLZ5YKxUekmoDi8zsLQMb42G2sZQCIklaoGcHRWXEfCHCw4lnhPBWIiIkWawYD4h9jKNWisVldg8WsQZGi2tfAgmk+649jMhdbsoYBVSB+0O7je7JcTikk7nlymTJTkv0iODG6+vX94xbH5ojdkFhpaOXMpJudblBetamitZlxGMxnp+9IajcG4JzLG98jBdIqMLUEqPJrueteOx5+tItQh6nfU92GJ4bE2bRmr5MBAHEUzrORyrme9nxqkM86mI8OehroApbzQyBExn30W78OwYHbZSewfifRoyOAL5+S0+UPk0x+JUU+nLBeuhFZqWHAdhEHX5pHmFFYWxdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V748tjTCdtkIRvVRuGKJfwfBGGpjQy/Ltv/OSoFcYZE=;
 b=1dH3byZWAy8mFk8reJ66Xcap3YROTKxoxKng6q6130zZqLXiVS6vMZgzDYcKBVNlUhLbB9QjzAok9fCt3qJ/ZeUxJvwyx2YJUStvWvIPlDoj8sz6HxvCjJg0JmWGaKtVhn/zMDr6YBPCDiADb4WGzLbMFPdfwnaEb56KJrALruE=
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 02:02:15 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::a2) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 02:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 02:02:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 21:02:10 -0500
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
Subject: [PATCH v2 08/15] ACPI: platform_profile: Require handlers to support balanced profile
Date: Sun, 27 Oct 2024 21:01:24 -0500
Message-ID: <20241028020131.8031-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9532b3-6ed7-4dc4-8774-08dcf6f48b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBmg31NCNpnfuO48sxGLwdoRLxwn6iRmSPvkGVckpQGlHFjvslfSffYDpfCD?=
 =?us-ascii?Q?xkX+FwAOmnBoumgyofXBAwo3GldtqSlrxsVO+b/FNuq3lyOcH/WpLxROwffG?=
 =?us-ascii?Q?F8+Bmiq4ld6sia8VymocB35q3S3ukNedy25NyykkLRtLmaS/hR+MdcbIE75O?=
 =?us-ascii?Q?/Ff8dd0jQIru0jHDG5L+e/Emgqsv+N1QTUg64uLv0shDZXRxweQYqreudQPM?=
 =?us-ascii?Q?PGNCslaulCrQb38dHI64MFvIO/4rQzIW3sVJKhc9htStudb5PumS4h6p8WE5?=
 =?us-ascii?Q?Upkl9wbod9geNAfE2mqvt1tPL6mcDbGRywnElmybSfsHo7gnspIJE6KqS3s+?=
 =?us-ascii?Q?grj841xVUySkLNkEpcdVArkF0qIsEWlH9aOOb8xy7urGaRBGZKRL2Mh3lnXO?=
 =?us-ascii?Q?JhguQEC+FLqrp6ip5Trj1Cr2N0QcNkV2yOVTicZGQuxl41WYPLQyxd1kFMW9?=
 =?us-ascii?Q?kUYYUmg5ce+d8vXCHylSfXlIszu8KS8iwKHGytH94WEqXxrMo3fN9jrtGadW?=
 =?us-ascii?Q?z0BHV55Q/w30yubjEhd9Uy6VqQenDSlF0nqqegUoSzyvIF6FKavwHlFuHs9N?=
 =?us-ascii?Q?nBta9gIEBEeqbGQjl69C/3N8ZBvxWxUANW2ZiHNvbJNcGmAOdBkXndasktXt?=
 =?us-ascii?Q?rHLV3Y1fnoYOrmhZ+nurq4eRK6oslKV4OAeZL6bFvr1hUaRnzN4bnFEqZEFr?=
 =?us-ascii?Q?Q43SBEpgtBoNnCtPNdHlBLM0WBSi+HmD54jcUVd4jO37hzpZ9IzFE1wnflvq?=
 =?us-ascii?Q?Xn2N5DmNOwGJrxdb+ubiw+PeKYtkFZE9DvP5CC96u4KVJOMAlQUV+womMavb?=
 =?us-ascii?Q?PjiUrdzvbWdx3zBPuBP3LK94b9ofgtMpYv6x+10Xw7QLmER2+Z5GYodD/aBD?=
 =?us-ascii?Q?h0slhsr1zVIJrIG7Edf3Ae+UXXkBEG0zvCV/lT9DuzbCXMBFMu0SdbNVY17a?=
 =?us-ascii?Q?B2wPD75NBaHDdWVaYRlyGm+CNTl3SRX+jlNOmeZjOlmUMBm3tSZ8II0p321c?=
 =?us-ascii?Q?Prn9JO9G0AQ8Q9mEcwqMjjSWtR5dzf4VzbgnWf0H/Lp1rtqjN5CN6DneikfE?=
 =?us-ascii?Q?MiyGtox4De476SiY8ZO2cGHWsnaLmjXpbykBufEkAQpJKmSoSgocP9NVlJaE?=
 =?us-ascii?Q?eR/Q4e1NBzlUi1sVJKTSVtVCKX8SBhDplDwsYp6K35b09ONOky5cO/iTPLCB?=
 =?us-ascii?Q?WIIf+Lul4uNiyOfWNxND5pl25tn6cziuMMi2KWiT3O9l4GGg3ucCZM8eENqS?=
 =?us-ascii?Q?BtzoInuysewEKY2MY153yFBTDijIX2QFAfY1QSBfOCFIBPnoo5dn3xX7E+hg?=
 =?us-ascii?Q?2udr+06KW6fn5soq5JT5LteXDL6P/qgksjff1fFtviadtbGASuRB44NtUcmT?=
 =?us-ascii?Q?v43MYdl4LLQ1C4wgOwydKalFobxqJbQ98mnoP3LD3pPiI0Aszw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 02:02:15.2904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9532b3-6ed7-4dc4-8774-08dcf6f48b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

As support for multiple simultaneous platform handers is introduced it's
important they have at least the balanced profile in common.

This will be used as a fallback in case setting the profile across one of the
handlers happens to fail.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index ede1550170f1a..c0d0775831214 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -190,9 +190,14 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
 
-	/* Sanity check the profile handler field are set */
+	/* Sanity check the profile handler field are set and balanced is supported */
 	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
 		!pprof->profile_set || !pprof->profile_get) {
+		pr_err("platform_profile: handler is invalid\n");
+		return -EINVAL;
+	}
+	if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->choices)) {
+		pr_err("platform_profile: handler does not support balanced profile\n");
 		return -EINVAL;
 	}
 
-- 
2.43.0


