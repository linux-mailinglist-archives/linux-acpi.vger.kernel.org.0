Return-Path: <linux-acpi+bounces-13907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88770AC469D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 04:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F86189489E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1319AD48;
	Tue, 27 May 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1vqm6Ces"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757680034;
	Tue, 27 May 2025 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748314298; cv=fail; b=g+e3Q3A0oVhEr0EBMVxzxQtyH/o/jRCPZzwyrNQewV4mAUyTQz7ALi4yD7k5ImYywF9eMlcMCLkum8HP0Mqh5DSveEWo40hI9iMITSigM7oQTfowzDDeKx+/JMwg0+9NTQl6Po0/WuTU1KYfemHwLWA28kVeaprlExvGhXO/SJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748314298; c=relaxed/simple;
	bh=2eNu7ByAmQ8AxSvMKkIT7iFJmvmIxJVJINprX+UjGMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcmZlGbeWtDF3NLWpoeRTNc2w51t6q9w703XcPayXgoRotsv0J9zdjbUON61BdyKknwBdtu5+LlwZ4RkCiUgif92MeEuGXcqbDtfk6BN1XJqIcqMKlza0y8eXcZILufr1lI1IJpaAwLMaXMK8G4UvT+q22xdBNINw/SvER4vtY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1vqm6Ces; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzX/7OhYZpHw0HFk68E8WaY0pOuivs1Dzvy0hEO3STb843C0KgtU+a5gfHD3MlDyf07ODtOzg+YFC8i/2bB1week46TooDzLPeRT7zmZ5/pN2pagomeIV9DCogFYIImY78+hmDqEoTWaOsN2QlRGNaEw/UBN2PuEckNDsOOApMnsisHR0SLoQ+k+bYNVlmKVg0TMCGVGOPin+eUdjz6G5rwWg2Pym+VlmBzVVd8yJeEVl4St35B+RE0vhLmLovZ8hCQqq5S9Wn25ErnevGGh2n8nYYAbiv6R1BbRkhXdZ9Py+g4g/IOfpvKyLYNwGqShB8vJbUlwHH6PfBA78tqJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pW2l12BSzlXKe6Q4n+wdyegqXZLmeZjyudZAmJ52c0=;
 b=e5xaKuSYuKl/mWL8L30aMC/cMeQ4eFsLTxboGogWrD/Ow/H/fd6wd3lC9v2v9fVLvfjUM2u5I9/2eiq+Z36k6PoyrULFGQ6dn6qEW445s1kaIXaFrkaTe0zqtHmlqshXXXAXyCLPL1ug1IpJf2WahEzVvZQhVt/RGFxA5OIO6RmR5N8LRHOnNeTVaXdEZFjz7Mm8gYWoDqbT1cXTBIZdJji0hlaPTFomb1zuBPPfdv+4nEVdSjcIBA/yMhCnPDyxrC9sJu3YkSmgdWYsFWq0p/ugubMKzJyO8wGF4gGzvVqhsk5Jx47AQQaiO8TUFczKpRqT1KLgujNxaCUR6PUdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pW2l12BSzlXKe6Q4n+wdyegqXZLmeZjyudZAmJ52c0=;
 b=1vqm6CesQhCI5uh8NyiAKsJ/6x0Iu3zqgPn2PBF+NQnao3BWCkT9kQ29tn3mnFQ97KoVo9f04xIsnQINd1eAnfKjeL82RB64N1C67luFG13eSVLWsY10SXYRzur6MK/tTQ0YZVpG/o/8+llOv/b/1Rf1UB0oLAYaA0MZY3xUcxY=
Received: from BYAPR02CA0009.namprd02.prod.outlook.com (2603:10b6:a02:ee::22)
 by SN7PR12MB8603.namprd12.prod.outlook.com (2603:10b6:806:260::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 02:51:31 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::3f) by BYAPR02CA0009.outlook.office365.com
 (2603:10b6:a02:ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 02:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 02:51:30 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 21:51:27 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: Re:Re: [PATCH v4] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Tue, 27 May 2025 02:51:04 +0000
Message-ID: <20250527025104.57038-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0h+CSu80-ZBbU-_RpHbdG8As4rrsKbXLM4RqY12JtV-Cg@mail.gmail.com>
References: <CAJZ5v0h+CSu80-ZBbU-_RpHbdG8As4rrsKbXLM4RqY12JtV-Cg@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SN7PR12MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cb84ab-388d-47bb-1415-08dd9cc96289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fsnFu1ftrgrdqlvfxPrj/1DuZl1b1xaHtIjX7yP5buUUrTrBALR8Ti9B78Sz?=
 =?us-ascii?Q?mm9+urbSY288E3T06wmrNk3AFuS4Z+dDPUbM6oZqM0yZz4aBNHlFVWO16Egh?=
 =?us-ascii?Q?etEkM9DQ7vxkyfPWetF9Efi5lDgk4jwrCW2V6rbDmLynG1AZ6sJ99wRnvSPV?=
 =?us-ascii?Q?0ga4QPJGcMwqLZVXACnPrCnBda0BjCKSZHDquQxs1rxFH/RMPBjj8PY0l0BY?=
 =?us-ascii?Q?lxd4LjrXaNVS/BmdB1M3FVWZNDc8QWSLSXF8eviEjJdghFHFyONWiTGUnpj9?=
 =?us-ascii?Q?10VU8YnXIX5AM3j3BWm+43l7NU43MAi52pWHnuav2W/EQcFAQyb4qIoDckaH?=
 =?us-ascii?Q?fLXGPDIBKEy9qWDh1ZyqfGtl3WCywPwWswpF8CQbKf3563SXJrPJKqn+7TWv?=
 =?us-ascii?Q?8tJu9GPP6LFAyWo083r9xRW00/LYk/kfVovlomeK8aL7xIyqQJLpakWrOWp4?=
 =?us-ascii?Q?LUJAitHFn2+7dOBtHAxC+F3d6hS2J43KmvpEZznoz7qxsYAjoduzvgZ4A2d+?=
 =?us-ascii?Q?47M/UYFzfRu8cJXL+eEXY9wLuVp7/aEzpX9OhR9hi9cAC7ewx9OtlZ00Kd+1?=
 =?us-ascii?Q?9nDhvuzKQJYbIyEYL4BKg77NDjLOD28tq+7GYL1javHGV3DQP6Fo8/2XX8YO?=
 =?us-ascii?Q?BoiR6OauH6qW/WVjriZHsB223EHFQfRtTYK84xEA2aYkPlqHI4WZMSOA7259?=
 =?us-ascii?Q?wU+8YYeqHCM6cWkCCdORs4GAre57bp+PnTonwvKFP2GHgkeQwwbY515x89DW?=
 =?us-ascii?Q?6ITiMbXLamJjrsVgZqbqgV8GL8Um08Kw4oR5ZTI4s3jGuphxAoqEdxA63xfc?=
 =?us-ascii?Q?3WMsfDD0P0/AqWTXV/sg2MKFWMlaumTdvuYELkDYgE411S9C96ZW7uQ41ZeR?=
 =?us-ascii?Q?CvH6AN88EtvcIqbbgAdjcjW/0uNcA7n+mDmnlK9e9Ib9QfdjRDdJMRyVrtz9?=
 =?us-ascii?Q?g4T0AHbgmAfYx7F94DDUOGzTSz6aWNhxt9L0NDxyixmOfMr4BoRKSx/Z11p1?=
 =?us-ascii?Q?Yxzy31U3FYGMecYuuZojPip6P5P6Dy2MGGKXu+gxbrZK5DMPR/QrkFcXfA/1?=
 =?us-ascii?Q?mCPOk1ll4CJ9JlifdPqsOA4qIVW9YMvex4QBBRYhvdyknIw4TtfzMKscHxWw?=
 =?us-ascii?Q?0zXKTMfoAKzBae6biugkELZz2pk62NMuynaLRJvSaKaMxr82PtHNVe4gSZyC?=
 =?us-ascii?Q?m2i8+QjxHhkSlFnr26rEAkQK6afHBve6wWUOVx8Qr3wIZKwGRc9dgDZyMSPs?=
 =?us-ascii?Q?H6XK3AVyqIUYXPC/cLWeIrk5XDIhGmGG9eIrNvH1nxt9rdnzpcMccREFR1Es?=
 =?us-ascii?Q?0LnmzheGVaE5gnAlpeImmwL0ISA0wXw6DX0wk/XZq1N01sE+Im540LyVAC07?=
 =?us-ascii?Q?Kh1HjXIMlGH9Kx8TqnXwDxC5EcKDT4MuE5TMU13kfsRCmEfMvigt2KTAVRlD?=
 =?us-ascii?Q?ifamBCDbA/5j78vGNXGTGrf5OmZkmfh0JI6/SGC+CK9lEM/8uWNNtNv3ayvA?=
 =?us-ascii?Q?GrUdZL3R8nFpN88=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 02:51:30.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb84ab-388d-47bb-1415-08dd9cc96289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8603

Hi,Rafael

  Thanks for the review, and your consideration is correct.
  Patch v5 has been sent, please review, thanks!
  https://lore.kernel.org/linux-acpi/20250527024259.56996-1-qiyuzhu2@amd.com/T/#u

Qiyu

