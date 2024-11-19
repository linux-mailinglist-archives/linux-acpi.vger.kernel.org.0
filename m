Return-Path: <linux-acpi+bounces-9684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B79D2CBE
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB2AB30F8D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6861DACB1;
	Tue, 19 Nov 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHQALUwZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074481DA116;
	Tue, 19 Nov 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036897; cv=fail; b=pk0Z6Ad3aA/7Y5kiXXHgDoL/uxjjgVbbt+ADjb2G/82eCnyX8yeLsX1iHrrPKukakCmWmFPwjWNPDX3EeETMPMmqjA8Ph91hinJQOwr7Nu0tPxHEaZYnSYJQLdy4jw2rSLZcdhyG+lPGCquI1JnvNZgtIlZV0iOVPYyRZKsmmAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036897; c=relaxed/simple;
	bh=Ef7oQOGf2sOKgbZOMtFN/mM0DbbDnF1zOUyMqKgCTHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUbYlCUn5ciPv7PHGs7JjyllBuE7K6B7uopmeJgpG9kJrAbXg8EiZOzMHrroxkXwB//On7gJlU4BGBMSQe8OBuGvcEZQDa1XM0hmZ+MJ8EievkZ/0mVHRgD8kZNHFI343CmQzAXboubI8fh+GNjSDH5X/hcgzRI6oEzDUbGbrEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHQALUwZ; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIBDB850AgkTtmftts7wzgjnMvEQ+9i6/5nZwCrVEW1cn6gmzHi3v7Y5LhFRckIUV0kJBcFXVCMMocDgXie4kFPx16m8BLvxr7CSOUjMEgvR3+ew8Q3AuHNj4yQFMJv77wNMTifHSTqgwefQgF/qfIRmzJm6ADcn91Mnl7Ju07YqHfeJsG1N61XC2A2UI8NJpAyHd7SPI+kEVQPHcu4nSfdQIodETlqs09g7MMlKJsg/albOOO+aKOxSl9CPZyAtu2GATAZpUbv352FuZrvfMNEuXv8x8G8mMq9ufrrpZIP4wCQ1m/C+OeQHjsSecJDHZE19dXjyOS1IaF7B1e5y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvogErjJOwcVk46qfAaJGl6aKvOdsby22Z+cYER8yMQ=;
 b=fGLDQRw7LKwLi+rFapkKVOSZLk56VX8OVK1OaM+dE3faBrkNon3iLyyFew0STzxF84Gzl3MqnZsUa2yg7DueToQGjHIh9AqAxV87AT1GJYhujEg4gvBNGiazLvxFbwWI/tNrVOZb00kcdhcfDountls/LDBH5wHpZMs1N1msWKt4GiD01CEJ3FuGfsY8xWo0qMVK326d/L6NFVLnIRtXG6PxiFOzjrqXedXAGh7gUkzLa83C1gTPGlRAybRjExUca8ziu3xMKfnE+eLPKKGq50vguzl3APEv/lKwW+C3/G0oZlQgKvHO12WOH5SAUcmbzGv6rSXxSRVvYNN9DuwviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvogErjJOwcVk46qfAaJGl6aKvOdsby22Z+cYER8yMQ=;
 b=hHQALUwZfgpEBnhSyvfXAYlCspPqhvSHM0doWSPsEAXyYsEC2bQBFTvn2OzY9Q84Ux65HidN+Fr/tW3Vaf5WodNN/38HfvCcyfb1w6N+neuo2t59Qonk1ObGrkRYkpw2oPkFf9UdOPua9p/fuBBIPl7xltV/rpmfvmQVjauyZ4Y=
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 17:21:30 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::8c) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:29 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:26 -0600
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
Subject: [PATCH v7 18/22] ACPI: platform_profile: Check all profile handler to calculate next
Date: Tue, 19 Nov 2024 11:17:35 -0600
Message-ID: <20241119171739.77028-19-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119171739.77028-1-mario.limonciello@amd.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8c3051-13c3-43f7-9c59-08dd08be9b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7TzWH9uXUfksOny6Q1afVG/MtUTkiRZaQ60NipLZX/PZRJkgGTiDd08eZ1Ue?=
 =?us-ascii?Q?dK8dL2KVNpDqwLiANXm/aGtn3ypg337qgYJp6tnGjilW/KoYoBBjoEwjYVrk?=
 =?us-ascii?Q?oQywNfSIK7zuaJBGYtO1p7wtdDGgJRonOX5mBetawBaV7O66Gg7j15Mx+qUj?=
 =?us-ascii?Q?9xwack4dg+rHjXJm0emVnla8gV/E4jQtSLvVIrtKWtXEpHB1OOox7TgtaMHb?=
 =?us-ascii?Q?vNI1zm1ZJH5MnuH7X/5qS87At8msHmcUxa/FrXSywGNBLsJOf0MQ/F7KV2Lj?=
 =?us-ascii?Q?kg+xwhcG80k/pgKj2xq493SHYXD2roz3DtnvTXo+iHavC1Sz+I91aSPqAe3S?=
 =?us-ascii?Q?EgyKyjiq3g9Sk9v8P85xGi9v2KQrornw8XQdXw0SrYzJsDDblDwHBar+1+tr?=
 =?us-ascii?Q?6m1JAhXQxI7nLeacpHIzbDX1ryi4bYFux/4HYeEK8Eb/P6LdpwP07ypPIuCf?=
 =?us-ascii?Q?d3tusAmmDdzVPoA1Ylz/wJ+nkesobUed3QULCUi0Qk9nkqiutz0C9qNPqGHL?=
 =?us-ascii?Q?8+PKlGnDTJWN8hH3QPFZ+fWGXXt+SdU7rwsngBo3KWNKK8ZnG8SOlUW3tIhg?=
 =?us-ascii?Q?lX8YqFyLeqMLOkFEueXf4d2bgvA7K+ZmhGwFYwy5FWTE6tD+yxwcMMzDERKd?=
 =?us-ascii?Q?seDrZD2gyXee/6XPrJYvVQW+JN21Lx9SjclWYb0zIYEPbIulCnVdBotj7TrN?=
 =?us-ascii?Q?MP27rdEz7Xk5S+8A6foaUjezH5LcbSYwqrvS8fEreSiSpxtWrOuy+gXKvZa7?=
 =?us-ascii?Q?KFna2tHpldAeox6JrI2k5qibbQlHgdBBx5xtQE7aUsgDCmKD4MV62betGVJC?=
 =?us-ascii?Q?qUGzU9nqnCxoHxuzTFsON1hlW9Eu8r8LNq5UzDA8XUISai8+4rAEc0fFouT1?=
 =?us-ascii?Q?oL/3mvUQNE7bQ++LQkM4xfF+U/6yAh1zPZMma1zTOeX92CSbP017fMPaRT2e?=
 =?us-ascii?Q?6/ZghPPjrWd1m0bmhM12jw4r65mxXJ7JTPX/002vFf3JDFy559zJmGUaP/uO?=
 =?us-ascii?Q?aIws24FaVMMxd1lpi6myFri08BZu+EubkJPgYnfRI/fersAWqVrxIY9mAyVT?=
 =?us-ascii?Q?NH9KlXhJevihPbfl++9JLAcQAUMlueZLXLPSbIQCURm72Vg1z6TLwWtlcDOx?=
 =?us-ascii?Q?5iPb1gQS71olR40P1AwJ83ImpLhxf+F6juUjqXbF48xd56aJj6jSifD2OTgR?=
 =?us-ascii?Q?rlIWfhxwLsC2sD5b0xDwhtJAsoBLKkJUd/31hrElrkfIZqAsmrEcu3LvdSpi?=
 =?us-ascii?Q?I+Gzrfvm+Bny4xdM06ix09e119yLH9c5DGqQQq7kF1Mj5D78BtYQFWC//QvZ?=
 =?us-ascii?Q?v7eq4s+oAKSYX/nzrcuwkw50sEJ0euYjrh+z6DtpzUehmKWJzIJF6R7UgcLB?=
 =?us-ascii?Q?pdfdbOUSv1GNjgee9U+n+6ZTKdP1rTMqGjGDM5Vd1bt/wzlByQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:29.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8c3051-13c3-43f7-9c59-08dd08be9b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790

As multiple platform profile handlers might not all support the same
profile, cycling to the next profile could have a different result
depending on what handler are registered.

Check what is active and supported by all handlers to decide what
to do.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add Armin's tag
 * Use _store_and_notify() instead of _store_class_profile()
v6:
 * Handle cases of inconsistent profiles or all profile handlers
   supporting custom.
v5:
 * Adjust mutex use
---
 drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index a258f2481246f..ca997f4e9a5cb 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -408,25 +408,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
 
 int platform_profile_cycle(void)
 {
-	enum platform_profile_option profile;
-	enum platform_profile_option next;
+	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
+	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
+	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int err;
 
+	set_bit(PLATFORM_PROFILE_LAST, choices);
 	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
-		if (!cur_profile)
-			return -ENODEV;
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    &profile, _aggregate_profiles);
+		if (err)
+			return err;
 
-		err = cur_profile->profile_get(cur_profile, &profile);
+		if (profile == PLATFORM_PROFILE_CUSTOM ||
+		    profile == PLATFORM_PROFILE_LAST)
+			return -EINVAL;
+
+		err = class_for_each_device(&platform_profile_class, NULL,
+					    choices, _aggregate_choices);
 		if (err)
 			return err;
 
-		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+		/* never iterate into a custom if all drivers supported it */
+		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
+
+		next = find_next_bit_wrap(choices,
+					  PLATFORM_PROFILE_LAST,
 					  profile + 1);
 
-		if (WARN_ON(next == PLATFORM_PROFILE_LAST))
-			return -EINVAL;
+		err = class_for_each_device(&platform_profile_class, NULL, &next,
+					    _store_and_notify);
 
-		err = cur_profile->profile_set(cur_profile, next);
 		if (err)
 			return err;
 	}
-- 
2.43.0


