Return-Path: <linux-acpi+bounces-9680-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95D9D2C7D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BCD282785
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 17:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4131D7E35;
	Tue, 19 Nov 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZvM2T3RL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720A1D63EC;
	Tue, 19 Nov 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036887; cv=fail; b=P7KlMuPbRej0bpJkxnUYqZMJRSFtZGr/GnDzkyjc8J61LL2nVU5dCoGRLKdFlw4Tz/3livyDOj0nku382QGindcL8q99xgB5M5crdkozBi0wKIUArxe4JlgMMWd7rdThaQIg/duIBZXFXLvgAbZs/bII287vHdW/LOj2DFZw54Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036887; c=relaxed/simple;
	bh=31AW3D7L+1fTsGrX8PR1c6Lzz+tYtEk1o1RenZxATmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3rItJOlE7XDWjHYfoHPl2a0s4RGEOGTBx++VKD/Lqe7BjR7FmiG6Q6id4Cjc8GllWldy3vbQipGCHpzo5KnZgnT9UdR49jDcb3nOFbBnCrScqHpnz6JEhDKLY/7PQ7Pi0ZI8N9irTsAwh36EihuvkC4XRAbksgX6XKfWpiWxwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZvM2T3RL; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT1JQqNYKf0s9/nMqtWZZV4zlAuTeVsKE8V01VctW9T0XKAUcUcUmyMyPkoAEmxP9FciqPsbTi3No6dbMZXqx6nKT9Sp67LT6X7R+xN2KFQB/1f/SfsAD8MwleSa77jTUsMDnBi62fxK5l2Zu+f+7lAJoQhU7UJXxL24av53J8voAIkU9/mZIfPbG6mITiMB5a4apttgPpnsXd5cNxtDHrL6clDOTvGV30ZOZd7LKp0GwHGCCoc5W+eCFQHWLL6QR9/iLpC5hHQPLMam4JF7ONm7mkS5IHv6nqKD1ddEWw4+S495D5GrbgGu7+BE9F8UiJWYLzUx+cZLblfoxWRqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCLCYYN6yRq3E/e6+tiqhvpUaO+kwcSxOCVD3v5ilIY=;
 b=Qqin2O4eLCd45Lc3ZhB5IiFFnLkTRm4Ep5uX41kSkubRN+9JnOqAAfAy9RE7j0K+O+pNgmZNW2dXUJXgiNwA7nUdW0CEjt4rQmTu9873thwX3Q1FNwXMTStkJLYANAXJllUvAENtYqTLj/J66vbD1Hgvsb4ZROM5wDaZ0UoKCiWd0EmqMC776VaJbuD2yW/B+SNKOpPVZsJY4ripM7/T9uPUZS32Vfs5puIcAbXJ0ww0N0eEelpea4vU5xjM39h3aL+iVXan+DtW1tA2MCJ/z/mY3fLVe54IdF38qJTCiLL/C57w014F4NO6rV1FuYwkUCkVnwLqqEwR/VDVkGPKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCLCYYN6yRq3E/e6+tiqhvpUaO+kwcSxOCVD3v5ilIY=;
 b=ZvM2T3RLV5khqQuXDTgL/G9La0mrU/kB2Tuqv1CfR6XPiVgtQLti6wlXrgDvYjw+RgInQHRGFcyOhe5rN5qgW/7EGB88TmTYAeIUm51romHqPbzthqs5WQUqqYIrlJq0ZkfSeTo6jNOpiQ+N6Bq+30IRPp+FQ9VxXqa0Y8cVwPA=
Received: from PH7PR02CA0009.namprd02.prod.outlook.com (2603:10b6:510:33d::11)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:21:22 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::e3) by PH7PR02CA0009.outlook.office365.com
 (2603:10b6:510:33d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 17:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:21:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 11:21:19 -0600
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
Subject: [PATCH v7 14/22] ACPI: platform_profile: Notify change events on register and unregister
Date: Tue, 19 Nov 2024 11:17:31 -0600
Message-ID: <20241119171739.77028-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bef7e0-8f32-4fa3-846d-08dd08be96e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7i3wFtMUUJH+4lYzO3EOCK0jmgwfrzn2UQtyRQO7qBbRw497R/11O++lIwM?=
 =?us-ascii?Q?1vqalbXj8U10S0lT2Hpz65gclY3ipEFoH2LQjDIZ5dZUFEJRkLDXVYBMKFK8?=
 =?us-ascii?Q?xKXjKuNRckqifBlDXntQPCiGp8dEdS6clsiIkwPKOtr0KCZDK82ah90bI0IE?=
 =?us-ascii?Q?8Z5Y8IRHOMMKlj2UI5egZKQWfYbY7xEsDFWp6ML8Rm71HPhH1w3IDXG53y7z?=
 =?us-ascii?Q?G7pZSA72uY0XLtmBviIFOUAt2aFsnPE8hEEzJ68rjFwCNXwxkZOtqevn1Gm1?=
 =?us-ascii?Q?Xtm9dIzf2Os4qgloq/Mg16PTRDgxtdqpcoMQXvK3Rrv1BML6f+8CcxQeK2ru?=
 =?us-ascii?Q?CmfdpSKNjJ0TL73cGNarl47bNEGVdTmxNL8gn0A5Zu4sowbucpXrkW1Y90Pj?=
 =?us-ascii?Q?FmGzBRIl8HYd0edP61waESWNyIFBd1Y1zTSywnyjRithj3VJrogbK4EH+ysJ?=
 =?us-ascii?Q?0quwMkDSE1oRPyIGtylzrlw0Ev07+vYoAh2RNiFyCAmDimu2K6vGmfSi9ZBt?=
 =?us-ascii?Q?Kg2cWgT4PyvqfuW6OK448425nvxIHhlp8L+dXXg3z2wMfQ1tv43Au4IrvKy0?=
 =?us-ascii?Q?nORvFNWCRqxqk9/cFuUi681uzS6p9GYcgXuQA3LmqlgPxpRU8+GahqS71Rst?=
 =?us-ascii?Q?qK54/ojdBhkzDrxrBU6h+KGaSBZolpFk/z+j1qxF62VJe8ISJso740XV7A2/?=
 =?us-ascii?Q?yhnb+84z/scxY7KGkuSutn62wUGfsQT0x6wKL67iLU7MBS1ODwODa0QJ3Vab?=
 =?us-ascii?Q?c0J2h4Puupx/61vDXNUaBjNDyEuN4YY13CQwW4CJPsekkTEuXO7XHgkQ3Azm?=
 =?us-ascii?Q?pNjzy93pAVJNQOl0Q9G3mlTAYDV/C3x2n5iuzA14hh3Vq5TFYglPKI0QXPQM?=
 =?us-ascii?Q?b1c7ZeXHGWIoqbJW01e6Cg9eoADVi4OtNIdJNSdE/25hPQ53HML4R/rv9Yxy?=
 =?us-ascii?Q?yB6gdBsrIbRqXY8mv1N4JPMo5H9MlmiovibTMJu5fBO30AmNtfuKMVGzaNV5?=
 =?us-ascii?Q?e7NqBcmUibRGmYasXpX+FpfGxEMNVB03BYKbQ0ZCA4Gk7kka789B5baTviN5?=
 =?us-ascii?Q?4w5Y125aGsAIaqc/SrpijYCPLQIQaDdApXwLq/DJd4AztVcsBoQRN2DcPafu?=
 =?us-ascii?Q?O61fk1BXcdykCE6B7mQSlQP77ajoe6k5h3jojXltJJQtJHK+wMctqBjsH6mR?=
 =?us-ascii?Q?6LgdXNYqHsgbewHQnVWb5I56Ona6eMETsqAS6wfnsFEifleNIqNtq47QWps1?=
 =?us-ascii?Q?CSPreT75HCF825rIYhOq2Tk0uu27ZudkCjGVTFBW6RWzvpk21E/i9RK6eDeh?=
 =?us-ascii?Q?+31pVU0HyF68Re5PrOeZUxcjCE4u3eawLDuBemxkQ/rip9IZc2L3Or/s1ab6?=
 =?us-ascii?Q?madxJAAKsk1qg5SN7R4+AKMpx0xb+VhMw4+ZODnL4ZNCxtWDLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:21:22.3217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bef7e0-8f32-4fa3-846d-08dd08be96e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

As multiple platform profile handlers may come and go, send a notification
to userspace each time that a platform profile handler is registered or
unregistered.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Add Armin's tag
---
 drivers/acpi/platform_profile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 1530e6096cd39..de0804305b02c 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -363,6 +363,8 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 		goto cleanup_ida;
 	}
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	cur_profile = pprof;
 
 	err = sysfs_update_group(acpi_kobj, &platform_profile_group);
@@ -393,6 +395,8 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	device_unregister(pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
 
 	return 0;
-- 
2.43.0


