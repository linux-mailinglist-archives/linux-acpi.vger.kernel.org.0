Return-Path: <linux-acpi+bounces-20761-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNF7Hrw7e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20761-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D593AF27F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BE25302D930
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91725385514;
	Thu, 29 Jan 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snnkdr4p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415F3816F1;
	Thu, 29 Jan 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683796; cv=fail; b=ZavX10zMYEtRNSz44gLeLTRNxQydv8IQSn31jyBT0ZU6p/yTUQ9Cw8hKKLQJXuiLSqlfskyJzxhhGtRNt7XOuxdeZQEMBnttrWUPtRHFpJZg4ed3nauJbPdVyqB5ZHUXV5ygguRmceoMIRihM9Je18o5dzOpPZxCJEcjpJdfDPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683796; c=relaxed/simple;
	bh=L3qNnAx0khWE0Luo1h1QezbkUCfzTsHk5iYSJTIEeFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8Ybk8gj0nxeeeu5DY5OtRA8BC3pNd1bp+O1yzrl+sWa9BhHp2e0GQ0LA4HpEMSKVu9DmkDrltGq4cnCQxPYm3uqF52SyoyGwTmMVLc0FmWJfddhU6LOEOiK8/mJ7f3haZOGoSRqFH0f/kyySn9Rqi0YLo2PlZjDcTS0h86+058=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snnkdr4p; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihXxZek3GDveNnNGKXkCdDtbEl/f1Za2IL3vom4/EuQAO9c99tMQBvFhi4oOq/fym7isw76tdIpYRiBSs2eJvgXCATHmy4vdQjfHlYss4aEp+qMVzLfIyTled2EBHBEgpACANLI2g18pgqYLFlvHHwdVTbNJEsp70o6It6/jqf03HEu6uohB7yWOgGFoq5gbcK8LcGBztBjUrVbRcMYrKQ4gm+AeC2w/6KLzDfbs7ekDWWQnLptAvfN7ozUzex/006EgHYzvezRRiZkb+Yzwx6wE/K1uIKMV0mb0lfri3E9mD8Loo5DzCgOjan8CgWpP4rJUkh8BcNIieIpYF5WQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxrUtn2EnaNj7axE4JGgKF1vyBqfKeDIrgnErzXOufQ=;
 b=YrkL+UrSmBFEhHWZJJO3CJ5XX6WdVz8FZKXNBnrD3qiwH1d5ksJAnheoXeAub/pM/lCZ6r4PKJHkoVVVGa8r/Rllf23IqW9ZXvyyvwo4034K5GhQVyWpVXBU/GTuV5A5N4S6OUiqfic41KhbFbMkDofNjaWWwnuMHxi6eFRiNVpjnRJIG6EyDeh+G3qHJUCDfkKEw8sEoy7DZJ6tkDEutBwauRGuVbKWgnRqL6fUE7IBWlZulzHS+katyA8nUyS56PDkZvCgE9ZNHC4fNS5d92C+D5WGDriKQwpbVWf5ATlpn5v26b01tKYvygJ1P7obsBkOhlRxxxrOZ8YJFqE3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxrUtn2EnaNj7axE4JGgKF1vyBqfKeDIrgnErzXOufQ=;
 b=snnkdr4p8yQn9hV9PE49zQ0bW1kWWKMF56Dg2Z3aLkebNe+Lwb4OnC7+S4POn5HZirkuxMDltWmkKn3UMpwW7L/Ps4emgkIyAEgeirtv8WWz1ZK7hkCcnTgTMvg+fOrO3IHmgRRfOL5LqFkkRMVO9J1mq8FS/V66Mh76aJmc5ZaqA0TD6Qt/mAyJItndKAcilQXTJto5F7roPbrlZzpXeTwElZQAcfCKbb1xdNUF9ZUr7TSs6yiS6IvtbNK/PlI4pYtOQ6+9BeIHreUe0byhFHXSzOoEmvmssFvKEgqqhqWQTLsRh+6LSQ5d6JIH9nI/xl1jqQJWDjAHJTYCCdohPw==
Received: from PH7P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::10)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Thu, 29 Jan
 2026 10:49:49 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::12) by PH7P221CA0042.outlook.office365.com
 (2603:10b6:510:33c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 29 Jan 2026 10:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 10:49:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:49:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:49:35 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:49:28 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ionela.voinescu@arm.com>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <rdunlap@infradead.org>,
	<ray.huang@amd.com>, <gautham.shenoy@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <zhanjie9@hisilicon.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <nhartman@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v7 6/7] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Thu, 29 Jan 2026 16:18:16 +0530
Message-ID: <20260129104817.3752340-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129104817.3752340-1-sumitg@nvidia.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: e004a1ce-70ae-48c1-8043-08de5f241fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGGlYdE+02Ty4TUMVwfSzt3Y+8qeOeVbV8qT/kDyvr6rWm3F1r0Q96VLD6R/?=
 =?us-ascii?Q?4v6ckd3KVCzQVd3HUnCAfSVjl3IWMNL3Tw9rrbnG9lw1fsGwC78XhtBOfVkU?=
 =?us-ascii?Q?ZL6/XTb6KtLof3UX5l4w/AmIoE9O0VHq0Cd1vQiU6zlR4st19fI3diqk987Q?=
 =?us-ascii?Q?q6Tthmx2tUgSPFTCrTRtgugyEtCzl4kSN48a2Vfv4JcbV9CuMJ+Dvj7Ohi3/?=
 =?us-ascii?Q?O2sPNURb5aJXUexOs703DOpOi0IRXXvt4dAe2FkeET5vO2rKk+RUGVuURwX9?=
 =?us-ascii?Q?yYM+pfCCUrRuAHSep3XXaS6jweFkBcMgP0uqskROKnQfYGAeyNSn+Tv0s8Wo?=
 =?us-ascii?Q?YpnkKnPCQKagMeHs8/CwblzuoBETUWmjrH0HfNnuh4pdthm+8dCw1LrkB2Qs?=
 =?us-ascii?Q?zr5YbKVHtDDDqbEf2JJ7f6CoNwucjvq3R+NwJ/L57hwwAXPCwe+kw83hQUq5?=
 =?us-ascii?Q?bHzT3EwX91fGb/B/a4QbzLDgzJT+su6px0ZvXBLzz4etTbSPJFixt2Zng4hW?=
 =?us-ascii?Q?J4/8c9UoYn/8xVEdSbMk++XVuqY9Q91ldajVtltkUjQ8YkOul8V5bjbqVv05?=
 =?us-ascii?Q?x0rqvCtO4QcxRthbJ6XM5sx18YP5oQghtL+qgMHn11ddvbYWfGs9cJhzjQ2G?=
 =?us-ascii?Q?Qo0LVpT8F/Nh9Xa1jNiZ8HGjcxmGeCe4RrfheRpwEBJW1+FL8R+vMRNFKKQ6?=
 =?us-ascii?Q?24wq5k6vmepdc0mh5RHCU6wGmE3B+ZfPdv+3V2MywySyABi0ly/kQiqi1Yzf?=
 =?us-ascii?Q?kSaEwoSzRgrkz0Jx2D71AYbEwTFopJdGfzGU3R/A+ocn2RXMCsqmnoT3egr8?=
 =?us-ascii?Q?qPWgzqH0nuXUrKwkJk9BDYWJ8kSvGRH6eVYpaEs5D9bpOtnOxy2oD8GEZeBM?=
 =?us-ascii?Q?iZVRcpfmbNxVZ2dj7a6RJ3sX62wiRRhLHDIXgjJhz5p4Nx/92yVZUejMEDyM?=
 =?us-ascii?Q?IPGKjL5tdr2blm0E2NbzVUQL1uW+NHRHvxcOdTidqA6WagnNOaaTunE77fsA?=
 =?us-ascii?Q?4mWTNN5cqu4/BGAT06eYmM5MsxqJffAA2tf5KsyzDbQve4oNh1uVtJ8MEDU/?=
 =?us-ascii?Q?w6DJa+otjpOXo+v6nKElsrHKW1uXZKws/JPsh0Qec+tGP48UZ/VTNYOlMomx?=
 =?us-ascii?Q?ZDabABqRPadp8jCmkDCrWjhSxbu24bhYuiSrulbvxUPbQII0pHjYf8mruFGY?=
 =?us-ascii?Q?FbMV00vyAWBJpQFtUIvgqivkzg6A8lL7H3RwkCvnkCl88+1Qx5VuJMy19K2i?=
 =?us-ascii?Q?DGhWO9VIjh0fHY7ZKtd1P2vEW8TF5gtCj+uuw/ZTA7u3CZYgtwZ5K4hEUvkb?=
 =?us-ascii?Q?gb0GfsmMAGy/uuhO3RPN1WLbpd0UY5dxf6gUSIzLn37IDE7OdwQDuRbPF1es?=
 =?us-ascii?Q?rHsaPwrAC3mwsrnrQGTh5LCA24dMey0EBR7VHkRUsNQrmmVsA3Ms7dUzCYYw?=
 =?us-ascii?Q?9SPk+2XFKn0DNFMT120+MGRMqZJKQXlBry/J6iw8LC7qtcF61VDfYFg/yiY3?=
 =?us-ascii?Q?dZJjrrmZde0fLRPv33pdTDjyQQKmuWUFmYz1rsSCuhSyyXB/83zHXJ8Nwbrw?=
 =?us-ascii?Q?Y7HJwl4u/15hrIl21IZaV6iuJVkWSJQDs0FtYJ/lhMpDuo6ZsdhRYccS7ILV?=
 =?us-ascii?Q?uPmuGOLDQuhMkNUNCwec2YlENwXC5gYeVwAHFCS4HwnOuA6UtvJmYrWn8apD?=
 =?us-ascii?Q?YCZsl5CrpmWbQGd42/o3IGyIMVc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:49.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e004a1ce-70ae-48c1-8043-08de5f241fde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20761-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2D593AF27F
X-Rspamd-Action: no action

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 3a05604c21bf..0b0c07c074bf 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,50 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Minimum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the minimum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Maximum Performance Frequency
+
+		Read/write a frequency value in kHz from/to this file. This
+		file sets the maximum performance level (as frequency) at
+		which the platform may run. The frequency value is internally
+		converted to a performance value and must be in the range
+		[cpuinfo_min_freq, cpuinfo_max_freq], inclusive.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:		February 2026
+Contact:	linux-pm@vger.kernel.org
+Description:	Performance Limited
+
+		Read to check if platform throttling (thermal/power/current
+		limits) caused delivered performance to fall below the
+		requested level. A non-zero value indicates throttling occurred.
+
+		Write the bitmask of bits to clear:
+
+		  - 0x1 = clear bit 0 (desired performance excursion)
+		  - 0x2 = clear bit 1 (minimum performance excursion)
+		  - 0x3 = clear both bits
+
+		The platform sets these bits; OSPM can only clear them.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


