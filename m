Return-Path: <linux-acpi+bounces-14227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068FAD168D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 03:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2D5167431
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794154764;
	Mon,  9 Jun 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QiabjPro"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC693A1DB;
	Mon,  9 Jun 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749433753; cv=fail; b=p9E1RuPtBGcQKYpZoZMxLz7elOUN5D/FBkCYh/dkANVkig8jGMmNvjZQvnit8RKhzipkKfvGFS0fEymuV4EWvbLloaDctxFa0Vsciul2xMHz+0aHd4V6ywwAdtx/Gx5NwowdxycMKoS5vi3VKnUMTx118p2+vThwNffr3qSO3Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749433753; c=relaxed/simple;
	bh=6LO65NWkr9CsqGE/nu46lmM9ixy7mUfgPUhN4hcBQ3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPchVZ2ZAczE0gnlYDip9S1q+dEOUZJ/GqqdTCJJre3JFACxxzjyAPpQJFXkJQuGAveDjZX+hZ52INDEHs5mYhIeX3druZVFy2cVc8qTWfvfhaP1vYRZMrHRp7xIj7weDaFvq9gJyIoDBkuAtoAyWo9cbdlAsDEXZFfs1n08L50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QiabjPro; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9Re0yExPS45dXWNJ6eEJeU9VYRAjoS1uPSJXGRMGIU4N81GXTYhvbPNJSynb+OhoU14JkV4KZEqtKDWb/ISQ7as8XAFH3xm4zYfU49R+aQAiVsipanJizcAf8nOi46mfg7UUf/dJxoh0d8sjtMWzWAkaVgYkVp1Mft6WTKxG5HRMNomnT+/btCLMU2qekjegnNvoGxZ6oUa791CAXE7GW34svUoXyRoMVRxx2JFz2fYeZv7vPYOadCOlgVxy76H8e3nHR9snLMjRTcmx44i4CWExA1Ja2TeoP8ncTZxZhl/cET+tMO8nKfmjeLceoeo0A5I6HylGOM0gnfyURkwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uomt2b+025hqGpFqyoM1L5bRVFDAJs1sKlEqo3dD3pw=;
 b=CPwWRMgbyeK4FDFz8i35DYoTdUybSFB+bb8x/Ug3XbuL2Ih1FXR3izgA+v3gbQfRG34QHxNfY9vNpAin3KsuNp3yv7PsBQsvgjBlHLpFsDA05O5LRqYKoyC741hzmAUXltivEmziFxWzBWKEnTm8R5ax8V6pDUK7a026nz4RKJInURndWfrCQNJRGB6/mla0O9w+tzAPZ7q+33gAoe8070W46r4u79URJENGOBBYDlcSnEq2GLMyiPI1ZcCSLyV5Oge6Wn+/KkxkOh9IKfUGUfrmLBzVoYZFuBUp5ydqY3cN/V/iKgbRP9FO8QeAS/Q+7RcGzfKeHwmjENY6cpGQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uomt2b+025hqGpFqyoM1L5bRVFDAJs1sKlEqo3dD3pw=;
 b=QiabjProU9gQsVxwNvQXlSbP+WQJwp3AgVcQcqgEiXZbe2JPoGB0x9oEFvotjBPrj5Z/fCyhoiURMPw9HhNhohHoBO0NPWOEqATQrHw4z0LDog6za/fEWWqxn0tfsvujqcUIRsRMcBHFS8CSe5/nM4CbWWQlAqfyjp8WoWUz8tY=
Received: from BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Mon, 9 Jun
 2025 01:49:08 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:39b:cafe::97) by BY3PR05CA0055.outlook.office365.com
 (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Mon,
 9 Jun 2025 01:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 01:49:08 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 8 Jun
 2025 20:49:05 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <qiyuzhu2@amd.com>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael@kernel.org>
Subject: Query:[PATCH v5] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Mon, 9 Jun 2025 01:48:46 +0000
Message-ID: <20250609014846.313417-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527024259.56996-1-qiyuzhu2@amd.com>
References: <20250527024259.56996-1-qiyuzhu2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1dd48d-5fad-4557-be34-08dda6f7d2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJa+PyLb+JUdJxkOer4O2ZqjR3zKBWe08pF+R/A3EjvxGJS6CjDHNC8if3Ss?=
 =?us-ascii?Q?CWL1vqokuS2afCnZFCrXTOQ/OrIJomDgtaQXhh/Z3cRFGDP/JJd+B/HZ+dLc?=
 =?us-ascii?Q?ZIE20ZOQiHrmdTSkNZKCuOT8oiNsF5C/X4CjQ9ProQmuGentXi3zaA8SwGUi?=
 =?us-ascii?Q?MAa14JHXvJ/iBdkMsPDsizEKqoyZSwVGZrr2iFlk518U/guc70JYiZ3vNnVm?=
 =?us-ascii?Q?HzXjfUqUNk1bdf/f9L8aL2C6ucOGVzwlQZvGoxGHyc+XhH3O/6CYxakEI/fP?=
 =?us-ascii?Q?TZsDfD9djkBQS7VhSUFyXAyrCgErLzreQHvq4M7MlGKkKTijZNYpE+sLOrBc?=
 =?us-ascii?Q?+ZqKU7ceaeuy/VQslSQlHOiaUS+gOAbNeAScIK7zTPQ4ySpPAe13Su4yepvz?=
 =?us-ascii?Q?dYthgi8XkF4hHtQU1mNOzx+r4WYKBpIf8rWMPP1ST5gihk23yiFjq3Xym0GT?=
 =?us-ascii?Q?pvefUZJ9KNupjWkyJUGQ020jQbmq8DQzC8/UREoXet+V8thDeSiqqkueKsGd?=
 =?us-ascii?Q?NjqTh4fnw7SzwctcF1+BnqdEEXTD8Zo6ifDcz880zyYTBiF8Mb2l/AGHsJcB?=
 =?us-ascii?Q?DPNcc4d/HESx93H0vTJqeV7pYfzTr74eqHtvSn/CUlelzO/HgcHd+auUkCaN?=
 =?us-ascii?Q?c2MVovAwTU3LvMX3C/bHLKI+i8hFIGfCd4BRkTxWLomdiraYRetqsBUonW9R?=
 =?us-ascii?Q?Eqln7MipJmZhL7YGx2TgbbQRca8Hyqmp2xy3D3AOfVP2eTdN/rKGKnlK0BhI?=
 =?us-ascii?Q?aVJWGMXw+jUVIC/AagNd6BGWKapMVV5MwXL0cKzygh+UL0f9McNRsK+WMoq8?=
 =?us-ascii?Q?0vAKGeF7tHLmqq5inVLSCxx21nImhKZIopIVqekpT/L9MBaXbb+QCTzo2PaC?=
 =?us-ascii?Q?CKYjEDPaAwfVsfONsIoh/IyG6M45bt+hEORNjAmzPOoEcKxSjpkbcMyXpkEh?=
 =?us-ascii?Q?OZ+kAqBujUspbHFoI0u9swhKv0D2PZt58fMOc7PN4VdG0obqznMtZJy2hip4?=
 =?us-ascii?Q?Nw3PmYbjmhwP+WU5IOg1UQmmkEf4eYbLMMKnbOs13jAVkBvYQCBKmJP03QeD?=
 =?us-ascii?Q?PFyBZVxwZirvPGZwmoO4qqrkE/jFGB7290PIkJx1E1riOHXNjULXheBAuI/g?=
 =?us-ascii?Q?tPRzxNEWwtz7l2i/UHdbqYcYPck8U9Q1lMYNrrtmBe0DVd7U0YwdfJQ5tfVU?=
 =?us-ascii?Q?sh/FYC2ocQ0oLnTQe4nKrn+9b7/9tN8yClf2ix9TSeK8sUHra73gpEMcptaW?=
 =?us-ascii?Q?ew63PYSOo6K5wNhHgCaiFyCwTm8CIR8YOTm/66vhXJD6pdtBFLEGGl20bh1y?=
 =?us-ascii?Q?aR+hdgI4Ru9KHO/E3aNzllDUAAu0BAbgUU+cGVuczCqAaZHYm+YQ2vIbSibB?=
 =?us-ascii?Q?6M/+4Zy+Zd53jtnuQrtcibY6AhW9SmdERNXE6n3OWimzIj2LUJ5V0w+MEZ9L?=
 =?us-ascii?Q?G0JKvbQ36hwpHdG3r8B36xKsF9zul+glJ8kz3wk8qxiZkoyq3WNXX1LYKgEf?=
 =?us-ascii?Q?H1tfptc1x7wwrHrqiEaINYhoF6otfi/iVf1G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 01:49:08.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1dd48d-5fad-4557-be34-08dda6f7d2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651

Hi,Rafael

    May I konw the process of this patch, thanks!

Qiyu

