Return-Path: <linux-acpi+bounces-9859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CB9DFA6F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 06:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D083281987
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884BD1FAC57;
	Mon,  2 Dec 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uvlVn1M0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D81FA17F;
	Mon,  2 Dec 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733118719; cv=fail; b=RoumLJJPWQfr53ru5JtDL1sM5ZAn+yHz5mOQKnxTS3ObwwLMXLn3bbx/0avlK/UkKUteqmJ1O8AU7Wd8s0P6VbJPr3Olrm2oI7lIXyHn1NGlG3Kl0Z1NQslLRFfaHFxbsSFG8oC+Dmzn6FukGPySqorJa5rpZN5pO50DG6XJv0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733118719; c=relaxed/simple;
	bh=NQ4pJmqJ6qZZWa5lH+fhCRqJlKpGTIYwJ1ZjJRKXJeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fuuzdsOB4ub31oSWFyPdmxSPSreTWOdNr1dMuwx5In2xM7u9bpVfL1RZm8eFx71ZWiqFJSi8XGOQQV8k4XnhN0KeFVLYOyOlnZxjbm8GQu5v20DOFLXwCodQ+kHVQbWRRpPtqI7FQpCJVQra9DqgCZyplKdCLzNKtxz8/VR0M+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uvlVn1M0; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0x2ymeqLEKEcXY0ly4RTKMn7CUnxkWV4wKPTBBfIkCUxpnD1wRYWaQ54ygf1Y8aqrn9ZaAOfbbk4kMK4dayHQ4nHzN/pYdkFIBoPOLdWhhxlMBdicdB4iocITbgCF5mzWLLs3zeN7ymTYqYVqUD6CQKbqtQXG2g8/xsJLZ6mk3+bQuwG7iVQ2JweXlOw2OJTExdYqXcOkq8v1TCvvPANOMQ9NocNADBfprkTq2KtZRyfaXS2jqz66DZWZ2TF/jc3ST8tIMbN/43mmiYZaBdd8m874egxapbucwTzcAtYzGo2tr5xXxpWogg4vht2I18rAw7z4T26pIQKWj0pTn/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slJil58DB8gn2VuJwq6MCs6bH8SWzRC3d/Cv9r+sBAM=;
 b=l9+2ia5j0sswngaNnYOsayXpjnJuANrJP8PunIyO3fRkSgA43JdsTatZE6QJCY3NH3JycS+/zbTICc/iDwXxmiSz5hD6TVfwPTCrksFKbKHfmCetnoKycEiL36PS2WO5ympR2Aos+l75lebryEkNj6uhA3PQchbi5NwYo5MKlTtn7VTsBBvdH4Eyux9MkbEKU6w35v/vbrttRmc6oDEQ/J+NTs/m0RmarmLH7XkT2elzN+h87gOxnZc0p4zI8t04/Xvr2zjGCCg+vmz3lEvSBHdb9XlkqjBd+O2jfPI9pf87s2aB5SXNWtl65TVQNUyPDHrEdwjZI50gkOmcT3RB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slJil58DB8gn2VuJwq6MCs6bH8SWzRC3d/Cv9r+sBAM=;
 b=uvlVn1M0rGR+y8bLr4iNfk4wKKQWCB+JuHKviFPRReyR0T+MG6onYxT9NxtQxfhUHPGyh2KuoxNJE4GmHy4fU8hucKK4VisOUiwcDdTgiSWaAw/71Hi4zXtEaCO3pLefC9RCj0753cTiOwn/kx0dswN5qwS1fD+cXoz+2XoxOH8=
Received: from CH0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:610:e6::12)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 05:51:53 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::a6) by CH0PR03CA0277.outlook.office365.com
 (2603:10b6:610:e6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 05:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 05:51:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 23:51:50 -0600
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
Subject: [PATCH v9 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Sun, 1 Dec 2024 23:50:23 -0600
Message-ID: <20241202055031.8038-15-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202055031.8038-1-mario.limonciello@amd.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7547a0-a4f0-455f-3742-08dd12956c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqcknQRE6ubQ1KstDGPnidC2YKhJTtXBrKfjo5H3HVVbH5O5QiB1GjoyfZ8u?=
 =?us-ascii?Q?sBj1XJbGnBMnAz2HVIgxqs3UKIRkZbYp+oFFF0zZnznLyX9Xr7S9JjOirkv4?=
 =?us-ascii?Q?ZYEKsHc1/rA60eiLKakH5NtXE03b3mogJm9ysFVzwZkjsQ7CoQJvT9GrVuy3?=
 =?us-ascii?Q?XGYjKK3QiKD7r6cQQR15k+hmoT3vshiUf7kcBhgi+JFSRJt5mObMqMFuPzht?=
 =?us-ascii?Q?QWBRgu546rrZHMDPW19fqUM1ONYTvCEqEnyKauSC9foc4dYCIZbldCSUOdz8?=
 =?us-ascii?Q?Xir+66MAGqQR+zbwFfiAPrNNGcm+sAJIAK5kRkGnOAg/WmS6rLvP9uJswJy6?=
 =?us-ascii?Q?NeJ/QT2pFFBQizR3s1H7gXbYD7zBA7nibzlXnCQi08SC+/CoP8e8kDAFTiqo?=
 =?us-ascii?Q?NPmHPjeY/BSy0Tm+v24sd8zIpqzkwhCRoQdPa5Hzi3DMG8qpMTcxWEj8Vnuy?=
 =?us-ascii?Q?jVzv7JAwZwuzeE0Tm57GOzxAbCGhnHuFWIdkLqDQG2cYUCCC9dT/lWkS1f62?=
 =?us-ascii?Q?qDDXRXtGPMkUW5op1XUqyIE03Akz5dkUGwBwxGwJOLozOL1WX9VJlvQkW1bu?=
 =?us-ascii?Q?BhahlJFg6VSIP4dIYSI94s/Gq7lOKGVHanSwLr4CS0avIK06BW5GXMWmdsWc?=
 =?us-ascii?Q?MeeYK49kgeWdm6HPRy+GqthezAMMF9wA9pCy7P8QyBzxgwB4frhjYou+5Uhi?=
 =?us-ascii?Q?i/52GiQmJJRPZVc0T6qwbgsw1SQgDRJa1fb5CxSmZcWqX1ydNSfkr0KaOgrX?=
 =?us-ascii?Q?he5gaTrVX9/ROl46W6ksbrBZSpbYsGVW/PchXlOy7IQ0WCIKAo8nktMuNNrb?=
 =?us-ascii?Q?8Y+JQKYiJRdwJIhlt+OnUuc0zBZ6dZhFRmWbMyn8dSRPbAA8BdRuTTiXT+hv?=
 =?us-ascii?Q?QUwg4tZL2ZhupZ4hxhF1NI71usDSAlNzWwj/1bgIbXq5x3HU6iN6RMGzv8I6?=
 =?us-ascii?Q?Z0TZfTrZ7EwATynuBmlc50Z+UHXILLVXHlaMiXYxg0qbnj8SnYnQGZnPyFSJ?=
 =?us-ascii?Q?C8IntSgOnQbKiyCzpBo971QI9y6LutyM07LmWu+McMMAuRlXAVlOmiagHCcc?=
 =?us-ascii?Q?lKIrRbnjG/gmGhdbCxWYOdEkIvcof9S9k+h+tpS/VaPv7u52ySDN5/fJGGgo?=
 =?us-ascii?Q?P6s/y1DptKlaY5IFDdT6PPi1nMQe64sj8rhEkS0Vd2m88+coXaBCZWYEgUC9?=
 =?us-ascii?Q?5FQhaNjW6yrTk2WsIQriv2CCIAjzLl0hOs6kLrQO3FgkYlzUZkEp2rrmHGqz?=
 =?us-ascii?Q?KapsIfWeXVCfl19LAOQXU9KpymVvJNaH/TCs+XMSYQ15oVEsz58U6WcpVyv4?=
 =?us-ascii?Q?wXw3qvbyYT2eqx/LL+dDu0ha2khnqju9sRbzMxTcfXSJ/OCEQzN4atjuh5tv?=
 =?us-ascii?Q?y4PfomhbhJJSrjJmXpLck7GYFH42811+BaLMeMrsBk/QmwddptIlg9NrR8ab?=
 =?us-ascii?Q?7+LvpEnuF6xrsX4XfAWxJTZ6rNrfVJSZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 05:51:52.8781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7547a0-a4f0-455f-3742-08dd12956c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fdff374aab128..bb0178e52ff6b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -358,6 +358,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		goto cleanup_ida;
 	}
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
@@ -388,6 +390,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
 
 	return 0;
-- 
2.43.0


