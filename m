Return-Path: <linux-acpi+bounces-20458-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHiQF82wb2nMKgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20458-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:43:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23347D94
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2B9A59FC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F943D50B;
	Tue, 20 Jan 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOzDNqOb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C343DA2F;
	Tue, 20 Jan 2026 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921043; cv=fail; b=lsFI3vQj3Yjb3OBAeJAcwf9bKdSCK9FWbKKCeWeiWEfn5VJP7ahKcrc4JrN1+SbgQR6htCUwxyqQTgaLv1ZVsrfDs+14TCWbCAppYt6V4oRCqZ4kUKDe56252Sjf0f6V7a3YWYyO7XAZi1Pfnm6Fl2FHpN8Z1CDwdENTlwMXSl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921043; c=relaxed/simple;
	bh=kNMRjzh7mhveP87SBfEJYCQOxAKf/CZiqHENMkOjnyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbNpd24+k1bwoYByCQCrovKBG6pOsqxGUA8YvSVAos1qRC8ToBnzPUddL+TvZ510fNtM49wNUDT8EO2t02dmE+Y3gy6J/3ZqYNbCEGt6JDDPOY9w09O1gptYTczXROiyzNySBgrUKCNAYWCjzbrwc38JZcXZnVpmSSnrd1KH2p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOzDNqOb; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxnOkr7FU4qkBO9h4K1j81ZG8IMbmtftMwKc06NlIl3BQV40lQ9YQ6WIHdfiF+fz/1v57tiujT4cITprMSOCPMwPYz0bYMVM8FqyMvGo0wABz2jDPFQmoRJW+NNIBlz02P3DoJxzL/WCqYo5IZ87KJ8i79SzlmyEsSNdKNOeHBC5oQd/BjS7Y70CDFwOZ/f3niql1FQcN+8z4zv5+ObWa8iadrEmh6Zcp9WADvyEbXj5PtqYwTXaoqbMGxXazdRj/oCrqcIlYITFTv2gO94NUkQN4Ff1aZETHeTZFwum9cCl4Ioob5CigIVSbJja+9dtYDCp440e7iBt9xsjaPvk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvneTKI715+Gvgx0qK6Lo4+8717PUPsKrSFrLB81dlc=;
 b=ham39iLb4SqCBcJkvbjPXxDbnp8UzREAlZ3VNWCnhocEJTJOkMzKI02yaGvIpbmjGha9VfuX3YFI7FQaZw5M1VTUKthcXRcj6QTzq7PnO0u6WhYWUOgdnhEfQtz1Z+FLMyMGCH95QxaeLvbHVQUPjC3yHWSZUr0xxHr9HT3JqVAWQe+ddAJPq0SPpDiOmoIHE12FgU9GqajEWDg4EiVTL/oOBmhpXBW3EwlIG+JLih2Vz4GOXwEaJch8CN3uv5ILOOdbnZEv4HQDDAMYnMLsopPM13caT/bYJcevi0rDO3CQ6RfrCJCZn/whkQlN9fqyxg8FxsIHnqJiBl/a3cCnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvneTKI715+Gvgx0qK6Lo4+8717PUPsKrSFrLB81dlc=;
 b=sOzDNqObrR8iD+BdRJUysYGG7Anar4eyQhZxe5fBq2XRwxhr13vRCx/cgqmuZPwfjo0daTtlYoFBK+VJTPUI0qsCWABYzPkXtHqijXbHQkqZHn1mdz6R2L3xUXm5p2weOXRGGxXD5jOdkd44GMKovx/Fj115pCjaVsytMlNGUD8HWfntM6AyhxrClCVv5utra29VmrTZAblEiAv/ljrztv3JUTIWlQhgbM1WY1iNdRQ79Cg+SmbTOCsFJGPKP/I/z1b1S8UZqsqzEO7k9tS+ZBWEoMrDsvOSdAXz/fAQruamWMzK/j2+c0yy/xbUdmR0OcVNc6wcPl3L4Mr7B7TRCQ==
Received: from CH3P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::10)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 14:57:17 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::99) by CH3P220CA0016.outlook.office365.com
 (2603:10b6:610:1e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:57:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:58 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:56:51 -0800
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
Subject: [PATCH v6 2/9] ACPI: CPPC: Clean up cppc_perf_caps and cppc_perf_ctrls structs
Date: Tue, 20 Jan 2026 20:26:16 +0530
Message-ID: <20260120145623.2959636-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120145623.2959636-1-sumitg@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bbe3ec6-c4eb-4dc8-e136-08de5834347d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?02JnfW57BbHKgCLbaRMvItZlxUfu+Zxqd2k+/GlSMkFgvzIHQvGzOEeOLQGI?=
 =?us-ascii?Q?8k8UA8vm+B0IQaGcZ/8lmRsCc00yFTlBL8rQOS8waH5A9PjRI0EK3+EGsKNc?=
 =?us-ascii?Q?XjXkKaorcnoW+wv+x25ecvd9Y3Xfnqu10EMG/AaHBbwzJ+LK2a/N4O/4Ggju?=
 =?us-ascii?Q?zGNo6x9iQAwMCRNGnDk7YWlm+s4pznRZ8Ku81zJIGDAnZhFJIoFiMxoyQu6L?=
 =?us-ascii?Q?sZXQwkhzagxtQQihMdPRNkMtj2mlRZoxbRMruSbEKQdZco94Wbihkuzi3k33?=
 =?us-ascii?Q?kq2rF8YOTMQx/iVBv+2/nwUA5pVbRuFlD0EgVmrEXxy9i5rmCxI3Hz3lRDFt?=
 =?us-ascii?Q?/NHnGOHhJ7UZuDE8NfkwrOqXhwp+EiHcg8RHlEyO7BSX0LvvIZlyUPJrDcew?=
 =?us-ascii?Q?O+QHbscVlU/qu3TPvgMSYQYQxpP0UnACDr/ke8vgj16UktePzTEMfftwTPoJ?=
 =?us-ascii?Q?9Dd5feY1Ld2unEU5IztskZymm4ANVJQ1yF9bcSQaJ1ltzZw/367G1YhdSaaA?=
 =?us-ascii?Q?dwn+nJ+nXYIiiLQKVIvljtSIZpATCPAnln35LAZdEoObJWLIy0TPr7yaZq0a?=
 =?us-ascii?Q?+0ISPZZRmy2ENnh5/e6KUW3W0t7RaR+R7bw/Dv+xPEr2K+kAQnQ4cFcZ9gLD?=
 =?us-ascii?Q?vRgQ7bhGxgItF0PhBqPGiL/fXyewmvudCr/bwNucaVzLC/yxNA/Jp+hZnQly?=
 =?us-ascii?Q?waMbsdpw0fMsAdLDQ22sT/lf7sWv22ojGPMGy6WvkW7rVo3OX3Zinm3nka/n?=
 =?us-ascii?Q?EvaLRbqWMCi+u2Lvbmw5WHrVkZQqs2toZT61oM5m4JUixloSyiQFGlzeWLJR?=
 =?us-ascii?Q?3QOaubNeJ1rRf8myllNxsFFaCCIfmN9Ivn8zwD1MQaVxIEeeLOgIHFMsdUrE?=
 =?us-ascii?Q?07UiCBZDs4doHCB+fHTm8zVihtZmRZHNTvIHWQ8rObyk1Ok2Sv5JoHouHn/+?=
 =?us-ascii?Q?E/JJhtqGe69KlSrzHuqsuXr37vY+w2Q8KivfwwfcsIMr+WwIf3dZ0B3Ipyfk?=
 =?us-ascii?Q?RPu/mDpIWYyfRhNJ2uaSTk4nNbOT6ueoIVXzXCEjEMEslj5GwAMw3rBPTTHL?=
 =?us-ascii?Q?Ao38SnTpYHxSsaDyzOAMTDDPE0IRVRM6LufLpph5FiZqEQHmm8PS8Roplv9A?=
 =?us-ascii?Q?FOdnhZkSeN154manw7a56cAZEnzeATIYn0ekfNfQcEA7FLodyHamCuhKgF6n?=
 =?us-ascii?Q?vfHXdETftFoAiUOVCUy+7WlFWgo1E/MGxKlojKPHJ5heZjFd6R96rW7R8tQL?=
 =?us-ascii?Q?EOEP68xYULeGgJvArWo+TpHcL9k0IHc44b3xOG89o8ymf0hkjO8QiYrrcfkH?=
 =?us-ascii?Q?z5kWwFi+8gUzWv27BCpSJX+rDuziF/IwfKATyTkQUP5OW+Nrk3OzF4boNVlc?=
 =?us-ascii?Q?CGOhKZJAd1Ex+51l9jFc99ih4lgAREYHYn9lbjenXsIyKjccyvshVnq32aOp?=
 =?us-ascii?Q?tGHScA2dkLsoVW6YFxK5UhZ++3mPGrsWs+UFVxjK3Zu5Z6tyxyP19RwyNxJN?=
 =?us-ascii?Q?q8WK30ozqueayT4mQUV3r32c0823/q0M/UG59Rr5oOKTVmxDUYcpz5Xy6Vy+?=
 =?us-ascii?Q?Ufs3unXo9vp/18YDLeOIplpFzDSoSy+XEQqOXzkoLhVLAeYNrXchkHB2b7BA?=
 =?us-ascii?Q?uijY7zHdqQkiaSFJeY+RDAEgy3tus42yxONueyqVrJb7YMCaOZYe+VQlzCDQ?=
 =?us-ascii?Q?qkLkDuvlC3EYS57m+0pNy7XLsOk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:17.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbe3ec6-c4eb-4dc8-e136-08de5834347d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20458-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,arm.com:email,nvidia.com:email,nvidia.com:mid];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DD23347D94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- Remove redundant energy_perf field from 'struct cppc_perf_caps' as
  the same is available in 'struct cppc_perf_ctrls' which is used.
- Move the 'auto_sel' field from 'struct cppc_perf_caps' to
  'struct cppc_perf_ctrls' as it represents a control register.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 include/acpi/cppc_acpi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4bcdcaf8bf2c..6573a759eb8d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -119,8 +119,6 @@ struct cppc_perf_caps {
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
 	u32 nominal_freq;
-	u32 energy_perf;
-	bool auto_sel;
 };
 
 struct cppc_perf_ctrls {
@@ -128,6 +126,7 @@ struct cppc_perf_ctrls {
 	u32 min_perf;
 	u32 desired_perf;
 	u32 energy_perf;
+	bool auto_sel;
 };
 
 struct cppc_perf_fb_ctrs {
-- 
2.34.1


