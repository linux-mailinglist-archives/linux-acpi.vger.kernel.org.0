Return-Path: <linux-acpi+bounces-13776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE10ABAE60
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 08:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9023BA8FC
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 06:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284681DE2BF;
	Sun, 18 May 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCv+jjeN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93E4C8F;
	Sun, 18 May 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550976; cv=fail; b=n9nAjycjI3L6JkHxcDg3SSrG/BfC9lm1NeWG3ksOe94EhEvC5XjaAj/PfyubJ1WqD9avm1Go9QCk6i0NnP3mfY6qIEdCvXfUqeukJQyLUp/U0pUc9yFUEp14baWGLhsvfDdXxEgmTDULhmd5tfNd7s+uN4d0atI7jGhQ8qq1Vyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550976; c=relaxed/simple;
	bh=/LY7QHNgaCk4N+sE4+vjETlVDIYlEymlc9hfJn1WOgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdIDxaCecQw7QKssheSmKRtCa6V+gWiiXpOpYH2EvNo7sF5DDXKiHWHiNHG3zklIb7LElnovtFpP6DWlmxuuIBi1Hpk/r2dXaTjojSWApQHBL4qhKj7dq9XqRFwG6U1dOhFo3KAGCSen6RzpvucCQ98ZM//4kQqRQltvY66a3fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCv+jjeN; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnmYgWe4vzaHqDC83qMla+KRVG6JX3C3+jtCItUxvLMhP8+tZOuox/SpdlqdlMopjG7Po5dSiDVnDSHDiIZAHinfqpC8SP3xP5+UZ5BEIxs2sMy2MGF/GqUzmw6c/hyy2mRtCymSjhqakU/l1cjWb66m3PVrVkxfNUz2x4fnOYMNyHGKV53IU+PQwPQzBzctTYYH59upiXZItcCWrNoolL7RCDrnVj+Hd4/yS+He9EoH9J3SjuAr/q22v7GUR30A8e9znLAnYexMqqGv2DhBbSK4L3TlJAuv+pvQ44G21B1GLsJXgY1gEquZ1ezeRuVQA1F98zrBmvJFZoGZK1oYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT/GU3YyurQR3KuYiNLJ5IeWw6p2aGBOXf0l74NYwlU=;
 b=v8SgTtY34mqe2pTviPz0101P764n9SDan6J3A/K9r68dhrp6EszOpCSSQlIMK7JCreK/2yUfxHYUj+ZQyMdcUj/cPnS5t78mJSGeXGevbD+wxDPjX1t5gtqzrDaDH/ue68LyXJ0JboHoBGqaEOYb2X6GiMvBxxpDkAU+iKkRNhoStTxFgUCiiPEXocX+5vawMJaSShEvk4QmA/k+9Iwd22QcHgZZrnnsd44HUDD0jypQQ8eiAxi/bJ5I9IHV5rRA96fym/EazI5CRL4j4G6kLvzCsVkQRs9fFRkwWY01ZEzAeI2Xz2/3Hk3NqUZ6K+uSig4oUTfmCCCB8ARtzKuL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT/GU3YyurQR3KuYiNLJ5IeWw6p2aGBOXf0l74NYwlU=;
 b=gCv+jjeNkTvW2wB5Bs7U8B1KsZJd277X7+K/9s+6GfqjYWt3y/XWMigPWT0EMSnu7fSpbbrBPiKdbCx+AlZjl/4uLHOfxquWySjz4oSurKRdC/N89l8aNx6bH9H2Ql0fu9DGqewD6vGk7HytFFnWZFNaxphZzgw2j2lw0EyLLi4=
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 06:49:31 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:110:cafe::c1) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 18 May 2025 06:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Sun, 18 May 2025 06:49:30 +0000
Received: from qyzhu-os-debug.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 18 May
 2025 01:49:29 -0500
From: Zhu Qiyu <qiyuzhu2@amd.com>
To: <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <qiyuzhu2@amd.com>
Subject: Re:Re: [PATCH v3] ACPI:PRM: Reduce unnecessary printing to avoid the worries of regular users
Date: Sun, 18 May 2025 06:49:10 +0000
Message-ID: <20250518064910.220145-1-qiyuzhu2@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0ibrZOLi8yi1VzTPVVTTTb7S7_5RO4knfNJcaL9vOWYjg@mail.gmail.com>
References: <CAJZ5v0ibrZOLi8yi1VzTPVVTTTb7S7_5RO4knfNJcaL9vOWYjg@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 42274da6-bd9c-47d6-c5e4-08dd95d8242a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MPWdD/7pkIpiDAk28BVouPN+4f5eCmqxDa2x+w42QqW00Jo+Fq35UJWy4218?=
 =?us-ascii?Q?ipkP/0O0ECMkXejLafu0DQevcVJML+b630WCb4SFH4kANeHIWPAS+p+jX3gU?=
 =?us-ascii?Q?qWRJl7SqSikg0lsxPEPC+pbfnNhUslSXE5TXWCWePeFB/cTYd5b+bJbI85Qt?=
 =?us-ascii?Q?beNigOnW9YavXjOFqyofajRS5jIu7et0myuxPn/dCCwQVjaCm9aXntkyiNr9?=
 =?us-ascii?Q?4yGAOAKxiegKydDR0yf5u58bYPAi+5H+T508+Tasygs4pGW7MmCDL8eefZqf?=
 =?us-ascii?Q?Gd6NvPkPJzHsihXK+9wcfu0QO9z8YwFtg8vsX3HYJdYcWEAE3vI6h4NAZwNo?=
 =?us-ascii?Q?D2MThq4Nu0Ao5NhThHHhckT8hneMr24AWGyLMU3EAvzVV0Eiy6tIftx1WvvC?=
 =?us-ascii?Q?GHLyAhExr6YKMJLDu1l9MLm5ksoQWXkMKfxHQI14bF6ss6NzqMZq5ZhpvFG2?=
 =?us-ascii?Q?GvKTlrHmGZMiHJ1qaxluSedruUr4bJEqvMjPgPDE41l1eE3RBxyWkWTp+F3g?=
 =?us-ascii?Q?gSJ6X0kn/wToTywkpPXMD7U+m0Z3yrGwC/D5NmxzyNZOKPAUivTiFCPPVTOU?=
 =?us-ascii?Q?rtBOs18kiqKSQlkueZ1xyUYm+QFjXZQaeqhLZn3fqPLImqeWlJ4KsxZMTaZ8?=
 =?us-ascii?Q?BZaQhKLp3yBnftGSulLA8q0jvG/+R4hFszn9YCoLYBivBIXY/VQwliQ1yztk?=
 =?us-ascii?Q?2wTidBWgVHxXHGm2WCOPYpK3aTjOpC4vPfEqM9fSbd9BhxcWKCNv2/0ajRnp?=
 =?us-ascii?Q?rbievTeYhQ8SueFjbMLHtQs8OPH2FD9/xySPylxBwZn5qpDusbeSwHbSablV?=
 =?us-ascii?Q?+1aSssUka1MGvs1/iTua8pljBnm8Fa3a/yAH3MMuK6F0WH+QLb0ErMjJbGEN?=
 =?us-ascii?Q?CfF0xH5ptSfRpom1jLJQD9/wPH+AJ09DIzdTKLVcPzDd4GfGz+ZMmN3eX+TP?=
 =?us-ascii?Q?mHdDPxoWtvw7nduEU2Hf4C5IT4h0+i2/tMYgqq1WaloIQnFc1lozJVzIX9Io?=
 =?us-ascii?Q?b4dJD9poFzRjChiE9rjQP4FKoGpA+qAuC3g5FqyETVSbHh4g5cygQOq2y9zi?=
 =?us-ascii?Q?DfelkKfw5WT65R+aX+EOPaSis/EcMno2frOVdxGVqpTlTkjBeVcl3/duegzo?=
 =?us-ascii?Q?Al25CW0hoqeXwXgD016K2ay9Hy02oZqEpfv5QIODZLx2u4JJu4ZWV8+I2S7E?=
 =?us-ascii?Q?2u6yPgq9KQdkBdVbdbE9qO2BI5RMa1aiMHgiYRTmo5kzQqEATxIpruNRmNZG?=
 =?us-ascii?Q?+tI0TN/8ZIcvqjmaPwkEiF0V298eGlYjuEA4eSnkvOdTaKDmETzHhG8VCITw?=
 =?us-ascii?Q?bTGe6FQao6uk1OVTT0kuWdKi7vrVNqDn+C3pcg+UN5IDnm4eJleHJVHK+GQQ?=
 =?us-ascii?Q?8DnERzXx227T3OtSTmDefLFBzX3NG4Kx1Tnlb7eQl6mDDQKy7dbLzQcAT0gv?=
 =?us-ascii?Q?Gz7wJXIU4NG2ZfGk+iPFBydd8VUdTSm9o7Drx/OtFWtlXJgW/b6pGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 06:49:30.8308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42274da6-bd9c-47d6-c5e4-08dd95d8242a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407


Hi Rafael,
  
  Thanks for the suggestion, so we can only print the warning when the th->handler_addr is zero, and for
th->static_data_buffer_addr and th->acpi_param_buffer_addr, efi_pa_va_lookup() will return zero if they
are not necessary.

  Patch v4 has been sent, please review.
  https://lore.kernel.org/linux-acpi/20250518062507.218855-1-qiyuzhu2@amd.com/T/#u

BRs
Zhu Qiyu

