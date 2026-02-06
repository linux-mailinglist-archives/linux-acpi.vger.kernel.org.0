Return-Path: <linux-acpi+bounces-20885-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L62Iwj8hWnUIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20885-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:34:48 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAFFF057
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ECFD303F24F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDF41325D;
	Fri,  6 Feb 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V56KH1Fv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D213365A18;
	Fri,  6 Feb 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388112; cv=fail; b=myy6nFsneWSv6WNcftjcl1V5dkYxfBppBxCHhdd02mvInOlURlkLJblt27QlKcGq7tNy5gwe51DSX9CS+jlO4pBgOVoxZbhlPSpZIaqOWd1vZyzhtoi0JE7B81fhILVR4C4KyNLgM5WhmkfNTV1W7sX+h+wcDHMEJf0Los7lVSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388112; c=relaxed/simple;
	bh=9SYRug7nfnawz+xxUCZ7hzhGqR9ruoG2AvaOhYDII4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoYhQYMC0GZQ5Wp8f2zz3M/lVwBkY7kfL1Fa9ARb3vglUbGa8cxKy+wYh5a2oTtKD8FExnzgXrBM0dkn7yxEDG62EdXkMbNjUktuB6xf5l1EJqLQBf/3OwYxKWWZZeplnXJaRyJdMVxracf3ZiboVRr0J02icSXkbwR1xjpGAHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V56KH1Fv; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EraPrXVQELpelgXyrSE2N7GzVJIbzM/Ixvrdefy9oKCfth6Gm1Rperj0NKfXQ1dlqWUQDOD853tJe0LVlycj2bubGr+u7pOIh1/ZpqREyq3JIbUQpN+kfMbtzTfUKpgb3Dcx7MdDquHx/WSZQNcPUAYXi9/9Eifc1LFpW8gSuQ4F6KAWwHF3nUhTFlIbDarwVacn9FwmTJ8ls1gv/p/r/Ck7p8HJchETpnKjaHUL4loroK6sxXq8buW1q6DhnePR0XYsu2kH6EjCNaRujYup9h3F+YGetB/9ulvJZ50oFWzhebWWaQwcvpZWLdAM7TXgX/uE1YPH1vtKoxmZANpajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDyt5yHUB5N0bQPfNRbfAsckdMVdsH3b8x1QojGPDsE=;
 b=FF8COXF0DZY481z7yCR67c4gfZqeJfqGunFDXM8T3II+RhHgxCXPNDPVIpYoOwnX160yPVuA5NO7JxgH0nlzsaokQUUTms84VLKiInvnhF0OTy+CRCf/5w3Z6Mslz+xnRV3LeIKbtVjKpe35yEXFEjF07Ifa7j1nYGpBFf1kBhFnm9IZNkRHL7kUf80Q26XcQl8l/TAyVbahwUu0JiwVFtqSE23wSeKW7yhknpnwsO7CAtGi8pKkyPd0sHwm9zPXu0cOWnQem5XXLULErJx0HQmHWdApIMbliaGu4E9pyXKgzDyalZ7hVjRNJpaCdVk4+ldod83JZm8nCLT4457Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDyt5yHUB5N0bQPfNRbfAsckdMVdsH3b8x1QojGPDsE=;
 b=V56KH1FvFTyK09aXl2JVmlaumCRozfoT6EONeCCYTndmUWTTRYr3k1/vUbLBuRYIuuREP+V3+IQDBB3n6y6mCi9T7rIGir5cr0K6sBhoQ7c5iJu5xLM9sz1AWOWp4uzsbFkjbNmCCev/0w6sut0w549DBfXrFzT9gRvXqkE/0FPXxZE9fcdPuHIHPUnkGECgK8yMan/mzY/uzui+LTNb+zuZhE/aHCZPtfAtvFel9ATJNLcJKQgT8PmjsCESrx9Sw9Vuef3f4f+PER553fQ/806TTmd/JJK3vOnvIOWWyX0ZbhMF4/roDXpLR5Y9W8iJGIlKPuOvAT+hPH0o4NSqjQ==
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:28:26 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::c5) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:28:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:28:06 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:28:05 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:58 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <yumpusamongus@gmail.com>,
	<dedekind1@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v8 5/7] cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks
Date: Fri, 6 Feb 2026 19:56:56 +0530
Message-ID: <20260206142658.72583-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206142658.72583-1-sumitg@nvidia.com>
References: <20260206142658.72583-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b91229-4550-461b-5078-08de658bfadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nH9Z+/kzF084K9F4DOfAlg9e6KwBgB51G24gdTZDCjfeSFxyHnIViSlgY6yc?=
 =?us-ascii?Q?uiATrkmrJEmxweX9eybROoWGxnavlYnHKBCcJPhqnW9MH5tss3/mggVWa8yl?=
 =?us-ascii?Q?xV7iZGQJX4aQKTLvL9skJYuoVTH/Imbp2uFTTl+mlCDMDVC5CT3Bu/IqXV2V?=
 =?us-ascii?Q?pOqDLHTwpZBayO4tPYy4rYUyI+e35017BwY2ufuyoq16+3DyUgHZ3f4Izw75?=
 =?us-ascii?Q?mmTEN5csQ5Vh9zDI3V+oIMN4qEP3i+ntTP1oWZAsqMndo7AxdMTBBQOc3sG7?=
 =?us-ascii?Q?MlM4/74eNNt7WtRQq6MvZqGxur63vRe+9Q6kBEcaklhh3pNgV3JuK80UlknD?=
 =?us-ascii?Q?dYWT6TEocPs6DfJWBpuCJ92l/p+u5zh6UNaKk/GE1WkA+3fG00OXQ+Pjtvk6?=
 =?us-ascii?Q?GVtQm8qu07tlVQ24HL3KzPs0vMqopu+eyu5TCUiCwVohmSPnj9DXPmMBmVGm?=
 =?us-ascii?Q?Hwsd3cmTUVpssypObri9gqAGL36kOA/xqmFg4f2sgkF8kWLBmEctP31L8DFw?=
 =?us-ascii?Q?LgrB4y4hKe1Hrp0OKmbOpknPTnGXhFvtkzYhRPEaGXpIzVAtERWibxwdAUOG?=
 =?us-ascii?Q?mF3n0N5/Vx/4upzA5CcPSaBn+nViBiNBQExZhY/px/8rXLWjJ6bGtjAceeC1?=
 =?us-ascii?Q?32kj6B4Jrh61qsAujMqtePnFWowfLQP9TiQiZqHO+u5Zd1H4yQfcKizulglm?=
 =?us-ascii?Q?0JasccrE4DfugGgcEgqHJgfQQVUOYTFjCvMEyIu/G+/see4/l1XDCMy5eeyK?=
 =?us-ascii?Q?x0zzMZC5vl5SqhHFReTmpDLn9dZxfie//YxuBnRQm5qU74yZvtkWd0bwrzT2?=
 =?us-ascii?Q?vz+izqMd/DAWsCOrfduk1Hk34JDR+HFCksMwuH2y6kisR0lrHsHyaKLu3LoW?=
 =?us-ascii?Q?rv8vQU9rxuH5KErvtlkc/4NHrHYISPWPLqYQOQVv30hbPC49XeEFVCF4CuC0?=
 =?us-ascii?Q?LqHMn+imo8RfSGgwSQLa/NYegxxM3rBRgzqKBrukSpypGTlzZ88cUKHJ25Uo?=
 =?us-ascii?Q?7HJnl74kQVktwGtVwO5ZPgsHnl5QG+53eSAX4MDpRxA20+ObiotyyP5rhznA?=
 =?us-ascii?Q?O7e9jtc/qTcavDXVT/scB4Nc6OtfpjLVHPbspJmxgkpbQNEw3JWZB8O17NDe?=
 =?us-ascii?Q?PpCsIpMZrEaIB2Il9B9uZH2PVkzHP6Z4XZiO8GCOdYwTAI/7KS2VcnixVR/R?=
 =?us-ascii?Q?EC8w4kXpjMnqlMxb2rMbQ7hxFqIjT1XJ3DXdfmzzQOGdjVmzBeYBs4jngCRO?=
 =?us-ascii?Q?XaBtl7pSio+p6M+bLH0Ho4Vo5aeA0WELCVQoB4QSi8KJ4YuqoAFMVJvdVbPP?=
 =?us-ascii?Q?HnTs3KYGlaYS6N54BLBA3Uj5uKtsUqKFhpLJVsIjzdR9MpRLLSOyyKpNKjSg?=
 =?us-ascii?Q?haAILYSMkpZzaoaZhuk6xGrze+7D3ok5dYcIlLOhFgRuEQzOQcChjL9hu3rV?=
 =?us-ascii?Q?Yi/cZ+UBV67IvyLj5CZI0m3ZcegRvObXQhlPyronbCzYw0R4++lrKvFjDJgP?=
 =?us-ascii?Q?dTUE4W/169ZdYvAtwJy5ralTveHdexrkxMAUmHzz8t3shVp5ZDCDedQShDvw?=
 =?us-ascii?Q?WNKqmzicEVSd5AU8JcdIDgQRDk326xIUoJF7Etspw5ddXu98M8x1/0zcPgYk?=
 =?us-ascii?Q?mZSjzgQEdBWz41zck5wQ9cclYXiNTPsf/Sx17CzftlOikE7Qu3p+bAqHP/a7?=
 =?us-ascii?Q?fJioTvGb6mGMWY4yn1Goly6LDdk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c1yLNWbNdNZNbfPgAbFmQmj6Mcyu+4+jNFjBDC/hj866mfKyGa1wJJ34E1sGKhaoz//vG0y3xm63JrLQY/e3GgKRlhJAb9i4F/40M5my9g6sB0ARsYUElC7P4TytCmBIgGXl+uHV7wQjmi0FZu+e0zWvS+BIp1DlcKQk+6EneDSFYnj4Kc4x9n5YoHtORym0H8MuOJxcFymr4h498gMCeo3o2G9T22f5BIbNvdXQJC1r+X4OTKP9GUo8ynywORowCzxkhahuYX0FiTyQssLff+QBZFCWgbjyL5UfuABb7rS8E0iPJNWwgC6dAdIdDqsKYSxV8mZ3Kuw3C4p603y+F7InO1K7bmHH+EDBQooUE7TMUIT7dwSl5jXjfIpF3cFFBpnxfk51tR1M9lOLfnvIW0x43Sj6rqQoJauXdx/JyJOQQumiz3phaD6K+9xxPyKz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:28:21.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b91229-4550-461b-5078-08de658bfadc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20885-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C1AAFFF057
X-Rspamd-Action: no action

Update MIN_PERF and MAX_PERF registers from policy->min and policy->max
in the .target() and .fast_switch() callbacks. This allows controlling
performance bounds via standard scaling_min_freq and scaling_max_freq
sysfs interfaces.

Similar to intel_cpufreq which updates HWP min/max limits in .target(),
cppc_cpufreq now programs MIN_PERF/MAX_PERF along with DESIRED_PERF.
Since MIN_PERF/MAX_PERF can be updated even when auto_sel is disabled,
they are updated unconditionally.

Also program MIN_PERF/MAX_PERF in store_auto_select() when enabling
autonomous selection so the platform uses correct bounds immediately.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e394cdac7f87..b277530ac420 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -287,6 +287,21 @@ static inline void cppc_freq_invariance_exit(void)
 }
 #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
 
+static void cppc_cpufreq_update_perf_limits(struct cppc_cpudata *cpu_data,
+					    struct cpufreq_policy *policy)
+{
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u32 min_perf, max_perf;
+
+	min_perf = cppc_khz_to_perf(caps, policy->min);
+	max_perf = cppc_khz_to_perf(caps, policy->max);
+
+	cpu_data->perf_ctrls.min_perf =
+		clamp_t(u32, min_perf, caps->lowest_perf, caps->highest_perf);
+	cpu_data->perf_ctrls.max_perf =
+		clamp_t(u32, max_perf, caps->lowest_perf, caps->highest_perf);
+}
+
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
@@ -298,6 +313,8 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	cpu_data->perf_ctrls.desired_perf =
 			cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
@@ -322,8 +339,9 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 	desired_perf = cppc_khz_to_perf(&cpu_data->perf_caps, target_freq);
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
 
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret) {
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
 			 cpu, ret);
@@ -869,6 +887,27 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 
 	cpu_data->perf_ctrls.auto_sel = val;
 
+	if (val) {
+		u32 old_min_perf = cpu_data->perf_ctrls.min_perf;
+		u32 old_max_perf = cpu_data->perf_ctrls.max_perf;
+
+		/*
+		 * When enabling autonomous selection, program MIN_PERF and
+		 * MAX_PERF from current policy limits so that the platform
+		 * uses the correct performance bounds immediately.
+		 */
+		cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+		ret = cppc_set_perf(policy->cpu, &cpu_data->perf_ctrls);
+		if (ret) {
+			cpu_data->perf_ctrls.min_perf = old_min_perf;
+			cpu_data->perf_ctrls.max_perf = old_max_perf;
+			cppc_set_auto_sel(policy->cpu, false);
+			cpu_data->perf_ctrls.auto_sel = false;
+			return ret;
+		}
+	}
+
 	return count;
 }
 
-- 
2.34.1


