Return-Path: <linux-acpi+bounces-15996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C98B32BE0
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 22:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028F2A22368
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59D2ECE9F;
	Sat, 23 Aug 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VuGpkCIy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA52ECD14;
	Sat, 23 Aug 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979363; cv=fail; b=Blg8wc/Ru22rZvkfOyl9ipxILbmwzOfnipY8LKJwfcw7qKUNoTHJQlQdlaASgFFLSuzZBKTrlSb0pld5LRhbxM1xd36VGoVgwQuFys+0kjtHzrJ7gGwGfNwFO8bpVUXmtIOASONQTMw3NG1i3G5TSyJl4+rEXDMYEWHlJOrpFKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979363; c=relaxed/simple;
	bh=kagCTJSOk/eDWwS0XT7RmMqGzZ8il8TGCW0hXycF+k8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miqsls1hmVgzVR7q5Y99uJh/wCDmRTD25rC2WZEOIesi3yOulH+MLmZuDQBHKSuIXP4MyXkDCyXBUzXj1SeUMBstlIBVkT30DFmlFcfBAxz9lnLiJkYN88tDSN4amqrYP/synpzlFp7jw9QtUDBS4IJIC4HUVwoVwf83zmzVCIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VuGpkCIy; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjyBvHl3qCDdX8C4iPE6xXQ/P55vjOYXj5HZci7ABz2czOoMpAvw0g8uB0riHY++0qeTUI5CDwYImxzvdRzzlCumfwGW1bd9S/XZ0rRvEv9HQt0pvskOloMJoH/JuQ1SHwQ8BPzR04jBh2It2yPKEEEsuyJ2ZINGQkljhozWI4NybUdYRmrksPxramFhKdLyna/8QwG+PRooATwuoLc/qY2dYXmeQ4HUFZBxujA/GW8b6pqr75B3VlPSeVpJWBlRR6DMAqWBNh8iAtYOMqj2SKLGDn+wrXgQ08e7BSKQVFmkGwZkmOYqVp4CkelINC3JdcpmFoUhVO5UnV1V02YIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGZtofSKBrbRSB3tGgLMaCzV/4M4YGoyQQ7hmCABJTc=;
 b=FeOg1sl7fzSWGZeHATvE8dWqUrdfCRpv+unWQ5qZXUa2g6xRhP+/QCZZZdS/0bcYcgKpOmC+Kwy8J4005nrPaZOVo4zWblEQmQhBji84Dy69qRz9BsMKyzfjKqoLkijoXIMoQB/aebRX7cDfKDCuO7om8gJWkxYBjrXwAygUFThWUh+A45weJvIGDSCmwlAaggtglCRieIvrTE3uiY/CRlHmcej7h1uZ6LzDhXF0oMZGt9884mQ3U7IlQ30Oqu/jUOAvOaujdwtIYvMGQe6eOxGfNgOzinMxQ/9o9g8DOjB5yNHv2ekx0VUG31Z7BBVCOJhimiFu7FeRDPxdy7GKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGZtofSKBrbRSB3tGgLMaCzV/4M4YGoyQQ7hmCABJTc=;
 b=VuGpkCIyh6Ug9o1xF5JX3mpc+E6Y4ct+e8l4KGwzs0SQQTp69QPoN+OJNDiQn2NTtTwzlWukadqT6e6A/XrVo4yMuXCxbFAhVi5qFfQUbDDA+Cd6GXnSVDyCF1vWnSSlvnBnUkcDxozgf9WVozo//qCNW2Gzf3yu4ytQwL/HPuCqTjOHXBubgk9TpMP3GxAqSJ8qP50A30WnazRiZQS/PZiPw4FWxStCt1DKk1sitr/6cPBSMEzOQOaSi8pds8WsJKBIRVSRMpON11mqY7vC38JQN5a0GeIhX5pXk0rCvfVxOiul6MObCnsBd2L+5tGpPz4Q6Xr/wpJJMS17zupCnw==
Received: from SA0PR11CA0030.namprd11.prod.outlook.com (2603:10b6:806:d3::35)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 20:02:37 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::38) by SA0PR11CA0030.outlook.office365.com
 (2603:10b6:806:d3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 20:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 20:02:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sat, 23 Aug
 2025 13:02:27 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sat, 23 Aug 2025 13:02:21 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 6/7] cpufreq: CPPC: Add sysfs for min/max_perf and perf_limited
Date: Sun, 24 Aug 2025 01:31:19 +0530
Message-ID: <20250823200121.1320197-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823200121.1320197-1-sumitg@nvidia.com>
References: <20250823200121.1320197-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: f300450c-cd50-4085-f842-08dde2800212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4O/8A4XundXU/eGyycX2Jm28rosbpEmv8SBXU+Y0hUsb7f1MaD/uZCGmtq9v?=
 =?us-ascii?Q?YvxpeFWXNXLzFMLroLqUY7nnklvYiQZ3FKWUy4PUfqTYBFQP8xZQ++k9B/jH?=
 =?us-ascii?Q?AFie9ExNSTCf2o3/SJ6TU+qanvu4SoIYDNGM1jtNJdJMIXCQuW3QdY35Y6FO?=
 =?us-ascii?Q?yuiU8YhG/JUv5Nt4+thdccwzt7ekiqAsTJm11Kaj+fPmrgNMiVxgdwrQSp3T?=
 =?us-ascii?Q?Ywu759UwFZBDRuptJ9+UpvsaYu2crNbxQ7eGNtahvNYwP8OyaVsZB1xC6DkU?=
 =?us-ascii?Q?g6xjqQdAClHUnX4YVp9FaKlPEIIld5cbUTcs/Y4RdkNhRHGBAbZ3nAg/AVoQ?=
 =?us-ascii?Q?YToUqXYb1JMGJoS2h8jvADIlMawdDbz2h4c0Y4dnTy3cRrBEEvivBzZJSj09?=
 =?us-ascii?Q?32DZrddXbAwxZhZmwoL76HaNwSOjteBTsOwVKlJGOUyVf2ZkaWTDi9VJNkeQ?=
 =?us-ascii?Q?wUV/0RlBNupYDflS6ZQBoVnxr0BYQBm4Jq19JozXYco2EbHatTPB+nGUUNI0?=
 =?us-ascii?Q?wBTepPXEYJaya8UY7w4DeJsA1tK0XtLLH4oeD69d/CUUiAteCYZMh/sPLSqo?=
 =?us-ascii?Q?kdaYGcH6Exj08oww6XliOMsfK4fG4eilWe9988T1l3y1HN6TjrC+lQD7+b+J?=
 =?us-ascii?Q?S8fml4FVxcqxX018MrExaFSNAp6TkwT/fvTjfWpNQvEEB6tqWlI28PInFt9J?=
 =?us-ascii?Q?o3oWqFA5qX1pl2haqM6gyjs6PUmkOgt1EHBykMbPARxH6tSwXjx98T2BpM4L?=
 =?us-ascii?Q?3m8dkbQTiFf5ntcZbQDYIl9koqjUxdITx4kRo3AgbOqLnnvk+AiDRllWicOZ?=
 =?us-ascii?Q?6Ecyhp1y4CkVMxlwRf8jzEZ7Xv7OKbNeHO4EmOslHdJHlvvq8XgL+qPmxFBs?=
 =?us-ascii?Q?PElXm9Ze95zOyBqmPCey0LV2XJd6vqpkCuUHn7N4tcD2sBN10YZZT1tSAxT5?=
 =?us-ascii?Q?G/mahR6ioHGaapwoY6EKkMjGr5UDyar6X5v7X+FbbKDSYyz84dnoFM+HhRHx?=
 =?us-ascii?Q?vqTgdOIKwQekznSGOTdI6Q9RBKgqrdWQO3O1J/c6z/fGwtZzPUJHD9jJcK0i?=
 =?us-ascii?Q?NHiePGUtKwVYxsKHkGh74IBwrShCpcZ8xR+Tw6OSEVsNy8+r6feGWwb4b6w4?=
 =?us-ascii?Q?xrrB5aN3ShTeu8WirWUcPkc0Kuv2puXh8rBUJod7ZrPtNNkaWIV3a0nZs/XJ?=
 =?us-ascii?Q?VdiTwz3hKxBJ0P7XI1tH/IF5LNwjUe7lKXFxgeDb10tYQAiltZCG4zle+K/B?=
 =?us-ascii?Q?8VQBaIp4M3AurLSN8H+11DSIkQJbrNeUihToa3uwVBgON+RSar0Jfra6r9hx?=
 =?us-ascii?Q?8n5o3CPIZFjG0DCEVYrZfGkZ4HuJJmP8BghjN1YfNL/+iFKQiJFtDgwy5ror?=
 =?us-ascii?Q?1JPseaCr7Mak3kTdOGSXe/Nq296JlxhX0cTsSJZZo0eVHJCXP84gRsTFSit7?=
 =?us-ascii?Q?2aUknEJ76gRK7uvuY1zEGLJwr9/XMqqadDN9nLyInE0aGa8LcGr2ZvDzAmmk?=
 =?us-ascii?Q?AVfmogDaZpVWDmRRk5Uw/42NGs/g/j0/niuLNEzDjj2LgU52o1MY4l/PHQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 20:02:37.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f300450c-cd50-4085-f842-08dde2800212
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

Add sysfs interfaces for Minimum Performance, Maximum Performance
and Performance Limited Register in the cppc_cpufreq driver.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ab8cd337f43a..4bce0dbc48c9 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -327,6 +327,49 @@ Description:	Energy performance preference
 
 		This file is only present if the cppc-cpufreq driver is in use.
 
+What:           /sys/devices/system/cpu/cpuX/cpufreq/min_perf
+Date:           Aug 2025
+Contact:        linux-pm@vger.kernel.org
+Description:    Minimum Performance
+
+		Read/write a 32 bits value from/to this file. This file
+		conveys the minimum performance level at which the platform
+		may run. Minimum performance may be set to any performance
+		value in the range [Lowest Performance, Highest Performance],
+		inclusive but must be set to a value that is less than or
+		equal to that specified by the Maximum Performance Register.
+
+		Writing to this file only has meaning when Autonomous Selection
+		is enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:           /sys/devices/system/cpu/cpuX/cpufreq/max_perf
+Date:           Aug 2025
+Contact:        linux-pm@vger.kernel.org
+Description:    Minimum Performance
+
+		Read/write a 32 bits value from/to this file. This file conveys
+		the maximum performance level at which the platform may run.
+		Maximum performance may be set to any performance value in the
+		range [Lowest Performance, Highest Performance], inclusive.
+
+		Writing to this file only has meaning when Autonomous Selection is
+		enabled.
+
+		This file is only present if the cppc-cpufreq driver is in use.
+
+What:           /sys/devices/system/cpu/cpuX/cpufreq/perf_limited
+Date:           Aug 2025
+Contact:        linux-pm@vger.kernel.org
+Description:    Minimum Performance
+
+		Read/write a 32 bits value from/to this file. This file indicates
+		to OSPM that an unpredictable event has limited processor
+		performance, and the delivered performance may be less than
+		desired/minimum performance.
+
+		This file is only present if the cppc-cpufreq driver is in use.
 
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
-- 
2.34.1


