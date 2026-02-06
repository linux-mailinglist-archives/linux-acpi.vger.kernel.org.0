Return-Path: <linux-acpi+bounces-20886-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNCzA038hWnUIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20886-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:35:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640DFF0B0
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE7330996F6
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73BC407572;
	Fri,  6 Feb 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CeG6mpGO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D7365A18;
	Fri,  6 Feb 2026 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388130; cv=fail; b=p9DXr+fpfPVdpA9a0vHhOPYNU5FMruHYbPQogF6GKa3xq0uSq6iL5Fd+cg7jXmZubkjsORRNYLW5lE59PqkwHbOsQ/pBNrp/rHmMCg5zHf3EPNex6fGH+os3z0f/vJMgXD8hh+qJEv82x0wC0bhax8VMgsgnLVPdAj6uCLqgQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388130; c=relaxed/simple;
	bh=XewuLvpL0ZmzplimTKyEAZbQVspFQsoy3kvc4U6h5gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5X6X/PP+Y5jzjMFk69VWPUdV/aWj2xZY8eBh58NgW4vfS+6EGAxGRi7tP3w7Knb+Z+lQnl8y+v5dXJjbTdI1XN2J2OFxiWrN8bSb5ibeElE7jdUw7WfS+LTycMbXp5NjDmFqxF/2MoaTVoW4/thiRBxGRhjhOSFsTFuesUy1c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CeG6mpGO; arc=fail smtp.client-ip=52.101.48.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+DnDZVPsPNv1ru/y3crdbvr1FMUxWCxFlTbthE/o5wUW3CHtGtAggGcB4CnJKKhD3fuLhXuS22QFysFLWa1ecj29oDNEyd8buWI5ATjxEThZRvCnQPYpw3B0i5A2yAShSIHV9aJ0WtCX7tljc9gIWJxibYr/Yk4k+sJ1x1uGjlNa1n4vicDw0at7xb5Zyym70VbyVffGMJvIDzGl93UtilX5Si1XRtv9U7fiEJdKLqmB1AZSgyacR7uuHA84+o1urA2J5NYLnvIOsJX5vSAcFG/sk01lG7k+LCYrRbHjb8TmmewjyZ39DJYmV5mGlzX2dLs2wCtThU2vLIk3/ULgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8MOomdhHjAPOJ87Rgba0vtEDQyQhATiCotUau7H7oY=;
 b=xVphwA2mAfXdnJGGuIKI+YU1yemEFcmQHbSaDseO59AGGaEIq/RyTFp/BSvfXqwMmGCEsvCbk0hKZf038+plqdbyLsl5VThywzWE4aXDbWf5lWGKCUjnxN1rKJCY4CyeXRcsBHomrLK1W3bq9SYj6DZ7SZFbUZD4BskllO5yLh+bhrJRjFjvb0XTWzQ9mx8rvFBsnQb4GDhW04w8vNgxPVDtBBLc3z/3mtiZjAcHPuWxplEFhW45NcYurOBvH2w0zcEg/5Fth1QGxqtxKvyzNOzw8RfsXAyfVJAGRYVxJta5B3g1bJGZ9EYqDegGtFMEnnZiwAXtm9i8JwY93VLAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8MOomdhHjAPOJ87Rgba0vtEDQyQhATiCotUau7H7oY=;
 b=CeG6mpGOaiXQkldA9DCMkmeYpZFDggYtnAaU8bz/Gq81sJQYqVFza69iprf5okkzinHDRevghquCv3WNKh1zki1yt5ah3GiNvUM4Wl4GqvVTK6YBly8jaefb9kjZqYt5P5c3SO2THJc0LFJ9FXZuzR5ZbZDq0twgqzdb/n4jMu0SOHF2NybZWpvSoDt5aAiEXt74GBnF+Pf6xhkpJOPwNTAs7Hmc5/Oi5cW8P9T6FVtpxlkO/oRl5HrCTNsMGnrKemFWZvKzYZuzdc4Xp5sfpMvk722yU7AHud/1M1f54eRG92J93NyoawcT10zTKSw2CbhnkhzZC69sWo24Zp90cg==
Received: from BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:28:41 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::33) by BY3PR03CA0020.outlook.office365.com
 (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:28:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:28:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:28:15 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:28:07 -0800
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
Subject: [PATCH v8 6/7] ACPI: CPPC: add APIs and sysfs interface for perf_limited
Date: Fri, 6 Feb 2026 19:56:57 +0530
Message-ID: <20260206142658.72583-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: a46bfdc1-a465-49e0-1738-08de658c063e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8JEf+BASnWxwBdQbPHaF9UHB7CGFDrhBtHrhl3ctjuqJYic62QaOq5UHCpX?=
 =?us-ascii?Q?Ff+J/cmdTwcMEiKZw0lz928N/G5/WxSZxdDDHioObEjKvsqO7W3YMnd3AFY9?=
 =?us-ascii?Q?Z341UgHC7Q358OBBBwfLFU+vZt/WjKmZ35su3P6KZ8dIr25hBiVz/l9NEuxX?=
 =?us-ascii?Q?jY78rngluI8zMxjf+hZLFzk4lyygbMTDvI0C/13tBWSd3p0EfOjwAXX8ZVIw?=
 =?us-ascii?Q?G21IBx+p0JznLuTlDxeRM7kj/Fs8POCsxCVxHN/RptOV08MbquTQpmrxrz3m?=
 =?us-ascii?Q?HIcy+SI+KWi3/RRcq0RVnBSWU8cwEAWhuEprcfglRpEzM3LuRaHsrjxbld8B?=
 =?us-ascii?Q?kv3cy7QM4ofjEBRMscVzBlltlYUNt0kY5eqcDV8by2Q/T1S2FdLwH3wJYcYv?=
 =?us-ascii?Q?0xRVylTqoSFFhszkNqZXd0gu4TuuIfflWVImHZ+p84eTmSeMNlu3BlzJE9o7?=
 =?us-ascii?Q?UUz8AAWMVtorqf6SCRRIhZDF9KHKV+w4G105ZjKWGS3QartmfcjxFJSLs9iV?=
 =?us-ascii?Q?8n9IQ7sA9CUvSpqxOy2GaN11Ih9/+4E3uWWX3I+zb2l4nkvNmSE2dd0TTjFK?=
 =?us-ascii?Q?FM2CGfABC3aMb+LJbzp6+UBcBJCw599Whq2UUw4GeaitSHOgq0XyhWM/LVYV?=
 =?us-ascii?Q?SOgWtyiI5ZIkX/MqC+ek2+25WtR4APXhfWAFSk1h392pI7D+l9vPup7tqNLX?=
 =?us-ascii?Q?AEWNan0Fmm4fGjGtk3vzIlBjeNV6PatYwj2q66TgsBs5krj7gc7cGwWvzEPd?=
 =?us-ascii?Q?naJNnDkiqwcf37/+U/0aJluvNP8bKV4Iqtx8GLYbVEfBK2BjlF8swr5E+mR3?=
 =?us-ascii?Q?X64zPPQkp6YVlIiJzu5b7egyrVs/uMhoQwCkdXB4SmOFGNkvOCFGiwt6Nr1B?=
 =?us-ascii?Q?EnrTTTdZZhYXPFrbTS5XtZmFNpzEkGCOL2fgMRxabxyOC+zB09r0RF6z1gZt?=
 =?us-ascii?Q?sCSJGbyY6m1gNa/cbMWAq8NPWJLnKBvdQnk8ZZNoX1GSaboMiAxz1nNgqXWh?=
 =?us-ascii?Q?lq9Vmbap1hymUZOG7E78QYkPJvz/mvfZZfSS3BHaIjF7iZ96oV3dgbjrpwv/?=
 =?us-ascii?Q?/4An4QdAKfPjSFUxMS/MjrYbHVwcrs1sFfPLCE8ged2k3RyP6y55WWntnG3u?=
 =?us-ascii?Q?p8VJOTNqpP9ETnqULfRnDdNayMFihTfZPeDOj/5HcSy8dUad9S1HSqqPBny7?=
 =?us-ascii?Q?xFk+kRNKZlVk26SwFrqss3JMo5Uj7EbIlNRjgLwGYoIs0Jkp0MtYNypo7ajV?=
 =?us-ascii?Q?Bhwac12XeSV1D5QhQnatXG8dy7wCGjobZn+ev1N3FW4fiK0SuYEs2t/NRbET?=
 =?us-ascii?Q?Nl4mDS1JzDeeIOPEfky6qHUn2csuaARRtoLVJTapTN6SD1GzxTjr0oZbPpB0?=
 =?us-ascii?Q?jGWESUc5yzeXw7SOu3yG6ftIbgWONRfNyeeiHoQieP7UfG00AUYFWBOA9SzQ?=
 =?us-ascii?Q?dnsHEhBjDPXi+RLHGJdyZ7q84VRg/y57Gws1NqNjjOApa7WCpN3YgYN2orC1?=
 =?us-ascii?Q?tYwmgv3t9Zj0A4+Cn28wlyTI0yHP3qp587Wnx0SX11DPqTM6mtNr0H2Hy56h?=
 =?us-ascii?Q?UEoXMz0xYzf/y4KBelS5a2PaT89WSp7rKUIrhsiMcLAivlNjPmBx/Mrlcyyc?=
 =?us-ascii?Q?6wgNQ83SAR/nLBErT7b485kpQh1AR2l2rLrIUiSogeJl2Jr1Lu0lTghJhuS8?=
 =?us-ascii?Q?9hHhMUR1TX6fTaeBwSXLiNE1pCM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fyC//t+IJUEcvo4JvS1tl033cxyP2q4nPewkbnwSqrUajgE6KkgsiWgjdMlLNnQqVC48nD7J+Wxq2Q/1Nr3IZ7bJbp4DlOk00IXrirDDKvMbF5P5apWw6WCjvLdBFyt9xccJC8jKrOdojtE291jaXxg7JFmtobGIhBkoZ/aK4kz0dzKXv3+dEZTFkXipYyuzfl4LBjs4olMuPdLYDid3ap8avmlptjPqKYR5/uOJmAF/TMUqHsbLjyYiweEjkL79AXI+BsEgJ6a1KKR96ymUqoj2vmgM+eZxP5uRv80VmzJ+a7EOAdNMbIilPl1Vvk4rBF6pKsDiU+ZGwI2CdBXmxAs3NqsXnQ9ZmXysq4uiyqpi1ErvKMCnKfDQI5tpQ+qme1YvxxpG0Rb9UyFZwY+314CpQAtqea3u76KoLkjRj79MR7lTHx6+yvc5suwU0tna
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:28:40.6760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46bfdc1-a465-49e0-1738-08de658c063e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20886-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,huawei.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5640DFF0B0
X-Rspamd-Action: no action

Add sysfs interface to read/write the Performance Limited register.

The Performance Limited register indicates to the OS that an
unpredictable event (like thermal throttling) has limited processor
performance. It contains two sticky bits set by the platform:
  - Bit 0 (Desired_Excursion): Set when delivered performance is
    constrained below desired performance. Not used when Autonomous
    Selection is enabled.
  - Bit 1 (Minimum_Excursion): Set when delivered performance is
    constrained below minimum performance.

These bits remain set until OSPM explicitly clears them. The write
operation accepts a bitmask of bits to clear:
  - Write 0x1 to clear bit 0
  - Write 0x2 to clear bit 1
  - Write 0x3 to clear both bits

This enables users to detect if platform throttling impacted a workload.
Users clear the register before execution, run the workload, then check
afterward - if set, hardware throttling occurred during that time window.

The interface is exposed as:
  /sys/devices/system/cpu/cpuX/cpufreq/perf_limited

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  5 +++
 include/acpi/cppc_acpi.h       | 15 +++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 08e62b58eb83..9a879b5134f4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1979,6 +1979,62 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf);
 
+/**
+ * cppc_get_perf_limited - Get the Performance Limited register value.
+ * @cpu: CPU from which to get Performance Limited register.
+ * @perf_limited: Pointer to store the Performance Limited value.
+ *
+ * The returned value contains sticky status bits indicating platform-imposed
+ * performance limitations.
+ *
+ * Return: 0 for success, -EIO on failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return cppc_get_reg_val(cpu, PERF_LIMITED, perf_limited);
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
+
+/**
+ * cppc_set_perf_limited() - Clear bits in the Performance Limited register.
+ * @cpu: CPU on which to write register.
+ * @bits_to_clear: Bitmask of bits to clear in the perf_limited register.
+ *
+ * The Performance Limited register contains two sticky bits set by platform:
+ *   - Bit 0 (Desired_Excursion): Set when delivered performance is constrained
+ *     below desired performance. Not used when Autonomous Selection is enabled.
+ *   - Bit 1 (Minimum_Excursion): Set when delivered performance is constrained
+ *     below minimum performance.
+ *
+ * These bits are sticky and remain set until OSPM explicitly clears them.
+ * This function only allows clearing bits (the platform sets them).
+ *
+ * Return: 0 for success, -EINVAL for invalid bits, -EIO on register
+ *         access failure, -EOPNOTSUPP if not supported.
+ */
+int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
+{
+	u64 current_val, new_val;
+	int ret;
+
+	/* Only bits 0 and 1 are valid */
+	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
+		return -EINVAL;
+
+	if (!bits_to_clear)
+		return 0;
+
+	ret = cppc_get_perf_limited(cpu, &current_val);
+	if (ret)
+		return ret;
+
+	/* Clear the specified bits */
+	new_val = current_val & ~bits_to_clear;
+
+	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
  * @cpu_num: CPU number for per_cpu().
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b277530ac420..7c3de48ef2e0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -985,16 +985,21 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
 	return count;
 }
 
+CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
+			 cppc_set_perf_limited)
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
+cpufreq_freq_attr_rw(perf_limited);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
 	&auto_select,
 	&auto_act_window,
 	&energy_performance_preference_val,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3fc796c0d902..f7afa20b8ad9 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -42,6 +42,11 @@
 #define CPPC_EPP_PERFORMANCE_PREF		0x00
 #define CPPC_EPP_ENERGY_EFFICIENCY_PREF		0xFF
 
+#define CPPC_PERF_LIMITED_DESIRED_EXCURSION	BIT(0)
+#define CPPC_PERF_LIMITED_MINIMUM_EXCURSION	BIT(1)
+#define CPPC_PERF_LIMITED_MASK		(CPPC_PERF_LIMITED_DESIRED_EXCURSION | \
+					 CPPC_PERF_LIMITED_MINIMUM_EXCURSION)
+
 /* Each register has the folowing format. */
 struct cpc_reg {
 	u8 descriptor;
@@ -174,6 +179,8 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -270,6 +277,14 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


