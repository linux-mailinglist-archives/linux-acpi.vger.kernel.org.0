Return-Path: <linux-acpi+bounces-20760-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBqPI6c7e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20760-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37486AF268
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E919302B8A4
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2473B3859C8;
	Thu, 29 Jan 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gir7q19I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9BD3816F1;
	Thu, 29 Jan 2026 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683784; cv=fail; b=JDWW6QMvLSypN2+ZUAq2sX1C854cKwTWPiJtwBpI9NKn+bWX+UzF0cNKrW9/JhBDItAF+JyOdULQl7h3/jBm5cWiB/wJoL143plOU/73drgU0877IMoGDGzxYlG+VO8E4/Nj2QdzO04B7oHavzId31wECpSBXbIS1+RTTXvZh+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683784; c=relaxed/simple;
	bh=TUz+q705Mc7OjrnRB+Kyox6KeNy7gISjZ6BEDLgosi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2kzz6KwWLnks3AvXX6+C5zzuli71/lYMUE3paHlMWHtYIVueCQNKRQ1DV0s4oaf9KTfOenKJFP0Nm8YpBzJd5sw/fgZeHJXLbwytgoZR+7IdTxgJTJWcyKOl3M0Yv1FhRSQUyfnBX9rYmV7Bs7kGmH3pm6ruteTY4H0W3iVjVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gir7q19I; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8C+RzwOq6GXOpQAJBFODJbtoJHZMK1gpUCnPctBjaeBsGkBaESrjMfrjt/5n3XIugrG7QkDhxNM/cpfPm+kcPyeFjxufQfmuMrrwAeu8dia5L4y8MWbQ6GYf2u3wUGAhK8QLxXu0JLdztq/NDAPLOk0HLdc2l2xpRSTJaAhFL9/OZvYe7CYIGp9RHQUEsVRtzK3rY2uKrUe5RuItgaR/UFBdSDbsVZxKk8YFRqnL9bUs6LCa/oesemB5WbclqAJx0cwChvxCcOka/aubrkHbvoum0Rr7g69vHcT+6Rgxd9gfYc2RqzvPV45DIXCt3Wv8D0wflLCmyH00GnU90vsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCOWXmztbCbleAOVmfwdIVKiL8Y1GTEjNUjgRyC31M0=;
 b=MlW4JQJ7voE2uFSO2fH3vHTfblB7tSsadgVcwO5EgPeDvUIXc3Lo2zBSsCkd5Bp6DsqXfNANhBDqdOIoGAhFX949Rga+5miJCRjm27gRmZcPJm++ELlj5TkwgwZwULunxuplB+lWClcG7/8tdgzX1EDmuZ7blb17BPlX+xA2fR+g0KWu7mYpKuzJu48niynycWCS/jq59bcKbgYvFPa9TFGxsktY7pcGVKFzcmyRDVvtMGHtuxHdCn5nPUlx/06qfBr3zr6S+B2lABWOx/NrmWc2wX2jP/J5aRyHiWx5A8gi7SB/Z5+fMzmZnFh94RmWDVhCBGppDhrVjAlp+CXPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCOWXmztbCbleAOVmfwdIVKiL8Y1GTEjNUjgRyC31M0=;
 b=Gir7q19IZjwNMHkxNd7dVdNQ5dCfA34XTBptkYJ7DTNkq0oLTJqdquCIpRo90GaWNh3p6O9Hav4NMvjAsPc6pvsQsCi/cO7WcXbsRkpL3TcTG8kMJXQcNoNKIBpKOP502TkhgN6hg2lJJRz+CWzgJP/8h8pq+/pRq/GJ14mZCeULK+MXhF3c1rz0ahMvgS4u3waSe9jWld7apkL2VCDS0xz2R2GCl8G3OG1IqYIqxkDl85EmzdgYKLEVKNtbFobTDyi+HZOaJ/USc2uI5eqrhLdmbaDTsP0wJrCHxgEBjhZCinZC6H9/kpQo2F0mnfooV+f343uQiTiz8qXqu20eXA==
Received: from BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Thu, 29 Jan 2026 10:49:36 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::f1) by BL0PR02CA0026.outlook.office365.com
 (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Thu,
 29 Jan 2026 10:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:49:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:49:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:49:22 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:49:15 -0800
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
Subject: [PATCH v7 5/7] ACPI: CPPC: add APIs and sysfs interface for perf_limited
Date: Thu, 29 Jan 2026 16:18:15 +0530
Message-ID: <20260129104817.3752340-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8513ec95-5976-4773-2ab9-08de5f24180c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mN9VcamhzCG1Ocf/9WQcZi+rQTmteGNQh4tOj9hEKZVqlP3jrvVv/+Ddauy0?=
 =?us-ascii?Q?p5w3QfzXljGM+AnEt2tSvy6ne6o1mAZvfsa6Ghjnt4yvFTBeDQLsauk04FRs?=
 =?us-ascii?Q?oa1CqNw9Bk/TVBZ3EK7ombqOiZnz7aDjvQjMAAB6vtM2xPh4EngQZnI+Oi2y?=
 =?us-ascii?Q?pUSQagayn7wmiQZ8l2knHk9zM+E9J6Tw4mel5lWRG8KDfG5XFLMr9nE9EIC6?=
 =?us-ascii?Q?V5yWTYiMwX5tHh/1LXO6E17buejywtnUQO7CbR0tvuaHUZbaKNcZYgCYTos6?=
 =?us-ascii?Q?9CvTMJHcKxywx66//rh65ov8Ejxp+ddUl6vsvpNR0xllHp6oSvwKPcv0bfoG?=
 =?us-ascii?Q?jnKZzZT354doCfEw9zUMveZu8JV9NxZ0s/fxBqbxnBvv/GbX3v6AwXuNVMyf?=
 =?us-ascii?Q?WJ/sGI+cWTrqFIKvpsQawuqov+H08s10wKHRFXR4hhtNImvwe1G5M1kGJg3G?=
 =?us-ascii?Q?vC3qAn1mUSD2xHtS+tVCgpTLLqVQcVvuJYksQQFZY/qJk7GkBxkZXUgUNDmD?=
 =?us-ascii?Q?mpbFhBaVt5dgrLXD/HeMgczfgQ5Eak5X57PpW7LoUV4lPom8GemDK9NUqxwc?=
 =?us-ascii?Q?D3z6y09lBL67dh0/7q1Jg6AhPwakZ59x8otSzq3lSUQ7NPsBQMduDQvjysMW?=
 =?us-ascii?Q?aGMnIDQ+qomp2+6gobq0LE6uqbZ0L8lUj5G2HGe9bEis7nmWfIB2sdnVgfcO?=
 =?us-ascii?Q?WcqZ0DTUQ6rEau4Y+MD+jCp1/YmPHpxSryfYYPaOG6rPwVT1wkkRG+hj2F7t?=
 =?us-ascii?Q?mfqzmDv3yOyiMdCe88IZYDKrqxMa+j0YfK63LAxZhWdwd4cWQe6dOBv1bw6H?=
 =?us-ascii?Q?smA8YVvhqDHwV6bI2KCXZfch9s+9RT5vn++5S5BGleSMW32EfLNKI2pa19wB?=
 =?us-ascii?Q?YDTPJ0ug4TUHUDoq9Mw0rUE6AH/PmTzTx1YvVxTLOHNOOy2N7AR99WCFUj3c?=
 =?us-ascii?Q?5WinBb1Qb8FTGmhPxBk6fxl9I3h4pvnK45vxTxbYByfCPW4MMtyqKR1QhpNr?=
 =?us-ascii?Q?gdbPb0xJADfep2wSFiWtHrervcN8jsDw+Fo6vEMrSSsQ2ltEZq4qGV1zYAkZ?=
 =?us-ascii?Q?B3c8aUr1lgoZhRnTSoWJdRceS0rewDRVuZG/Q9hVg0CztY2qEPXmLpJtaXOG?=
 =?us-ascii?Q?hCFVbaD/nzFUevjhk6E8LJcjbzmxMAA9BVIwzdfyUoL7EMqB6b1wHuyYDBjq?=
 =?us-ascii?Q?OrF1HGX2tdKzjTZ/HEjh51m9DDI14x/GZFhJCQoUzPjlrKWSPz6nguiGBeDZ?=
 =?us-ascii?Q?gK/vyeMLVPxyqRH9c4t0QJw3LUSCdOmqSzDZ5vnxoiH7UqE/E0Azug9sFpi0?=
 =?us-ascii?Q?PBnvfBbhZcXlKb2fX/2giNrfomOlyf9eEZagX4+xKHqDdQwfxb7Fz5ErVcyh?=
 =?us-ascii?Q?R8oFCNre/iL4ObyI46NkIKXAeh8OSM9woYtvLARQH7IhmougKshdclXERQLi?=
 =?us-ascii?Q?hsS3kB1JEIOO3QMH/2axOKXT3nQCCnONR42FFzfC59w+DZWerZx0Qit2HxtD?=
 =?us-ascii?Q?dchnido1PPrk1KaNxSNcKsdwqdbQ5//IujR764ScE9G2qXCnTmlRBEUlY2qA?=
 =?us-ascii?Q?JsuVJRz619swoBNHv96BvTw3sEJmeCK54wwWWF1RuMk4HQMFU0cMpYCtayiL?=
 =?us-ascii?Q?1Kw1TQ6zGhI44lE7+UJLSg+d1Kcc8SWRwDN4p2rFDynBxAgryGCIuqMx9ES9?=
 =?us-ascii?Q?CE+JuxPVMe6M5crnLcf5oKfHIC0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:35.8456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8513ec95-5976-4773-2ab9-08de5f24180c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20760-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 37486AF268
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
---
 drivers/acpi/cppc_acpi.c       | 56 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c |  5 +++
 include/acpi/cppc_acpi.h       | 15 +++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index b2b8daab69ed..bf008fb80934 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1797,6 +1797,62 @@ int cppc_set_max_perf(int cpu, u32 max_perf)
 }
 EXPORT_SYMBOL_GPL(cppc_set_max_perf);
 
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
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8787185cd8b0..ca49e25aba5d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1080,12 +1080,16 @@ static ssize_t store_max_perf(struct cpufreq_policy *policy, const char *buf,
 	return count;
 }
 
+CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
+			 cppc_set_perf_limited)
+
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
 cpufreq_freq_attr_rw(auto_act_window);
 cpufreq_freq_attr_rw(energy_performance_preference_val);
 cpufreq_freq_attr_rw(min_perf);
 cpufreq_freq_attr_rw(max_perf);
+cpufreq_freq_attr_rw(perf_limited);
 
 static struct freq_attr *cppc_cpufreq_attr[] = {
 	&freqdomain_cpus,
@@ -1094,6 +1098,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	&energy_performance_preference_val,
 	&min_perf,
 	&max_perf,
+	&perf_limited,
 	NULL,
 };
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index b358440cd0e2..f3a04ccd10b7 100644
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
@@ -178,6 +183,8 @@ extern int cppc_get_min_perf(int cpu, u64 *min_perf);
 extern int cppc_set_min_perf(int cpu, u32 min_perf);
 extern int cppc_get_max_perf(int cpu, u64 *max_perf);
 extern int cppc_set_max_perf(int cpu, u32 max_perf);
+extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
+extern int cppc_set_perf_limited(int cpu, u64 perf_limited);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -290,6 +297,14 @@ static inline int cppc_set_max_perf(int cpu, u32 max_perf)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_perf_limited(int cpu, u64 perf_limited)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.34.1


