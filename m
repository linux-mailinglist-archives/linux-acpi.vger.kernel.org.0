Return-Path: <linux-acpi+bounces-17481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A525FBB0F3B
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1242518843CE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86390306B3F;
	Wed,  1 Oct 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EReUeRWy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232B306B18;
	Wed,  1 Oct 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330980; cv=fail; b=YguTTjplB6AbYCxnVo252OIJHBN5amTKc2MK/3HTuqj1K3gTZ23nbpjggmsNctAlIpqo6d6yrzYfj/WaK0MNP2EJAOetrXc0Cz0jCJHVvSqwkzUk8N4clrHawkRmDHb/iqDGDz9/M2TY4pG0/qh/AYlqUVUAu8LE20DZNmBBiko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330980; c=relaxed/simple;
	bh=3vPZuFusBJhAGDS/bJ6j5uwiPqlTX+matI0/zfnG9dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkSpA8pmh50QcNjpVdRUgXv0AEY4gRpC/fw4PaReU6FQglgv5yflFbA3V8nB1izQiPdXMDSR86oyKyZpn8O5ZHGQYoqv8t+K7PqggF9k9SPH0GsfkoliTXcmeqvNvGGNWKr4Ly4B+KjF9qoL4/M/JFYZ+qFV/odQB9rvHoDDLTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EReUeRWy; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMbvJM2GjQDcc+GCGfUgpJNdsnx3C7o+KlI/FKJZhtFCllppwT/sk72f9woJvExQ6aRj7kTkg57mw4trZjbSRQRMbzaGIWrhmvPZg1TScc11kQJiddgYcCSG6Y2T3IWMKhw95Nmfl3wvN8xCBNlZyrqjvlMIyNyK5vSPSEeDCt80zCy4JH4dfCfF1e4FxlX3clAOO4kv5a3n5SSjane5E174co70FS924crChMZiiDqFq7M/A+Hcu9wkZ3njVRDVATFfODCfF/GOaFqe2C8AXKWh4gCf+jk3aD72t+Jfs8d9j3ZQ/4I+N+eeD2rvGPqqgrS9U20tOoatA8HUZf0gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umytqkzZlESBFLaNtS0b9DPwhwcRoqPe/Jqvc6fjskI=;
 b=N9IxyKoyBBjcshAzN1ynJsZVhW80rKwqI5m4Z1RCMz5/n+4IJcppivYyZy2WJ+V9NhF161nF5+GIpJZQoXxjYnZ3L0rnVqs/+BcZfH4QFYEaCBPw7ANjCmmUWClfQ9lvM4gCKsW/WybWDZzhG+UFkLoycBR2RAhwivPJDkxBgn7FhkRkVG7cJk6a6I7ittrS4pFp+I4ZReQT+mdNtkgSynXFtHewx/BFuk2AHOlpT7i6G+HUE7Q8LlEHMNepnwSbJUy8B7jyCqIfwINYfGs82fm07GoeIeEddJNCvzMypCp7STo8i2WUAMleEQzbEeDR79s43Gtm3Qq91Vb8wHlKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umytqkzZlESBFLaNtS0b9DPwhwcRoqPe/Jqvc6fjskI=;
 b=EReUeRWywucSaSmml+lTGwm9eAZzBLSrU0f+q2IFUhYoKKQSepSXgFJgqUFqta/Z/1wlKsCaXQVr95brp2uu3mijOiHp69DY+Rn4JuEuAokFqP4YqNI8oVnfnkHtsb14aWxVneTDbxgIS0EL6eov7DiK5TNvG7ZpZ9Evf3mp9v/8QdLh3jdcTZkeJzmthxOEyLe/ad5VzM9YruF9x+xx5UtHXbYFgxrOg6v0LbooH/dEi3lHh8yZqoBLX/4QE6X6tBNXVJDNCBx1jJcSU2zyyYHSes+XBtmVw6/nGF8z8ypVbUQjmTZErm9Uu2SdheT+YepKmn10P208j+vcX3b0eg==
Received: from BL1PR13CA0212.namprd13.prod.outlook.com (2603:10b6:208:2bf::7)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:02:54 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::9d) by BL1PR13CA0212.outlook.office365.com
 (2603:10b6:208:2bf::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 15:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:02:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 1 Oct
 2025 08:02:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Oct
 2025 08:02:31 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Oct 2025 08:02:25 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<robert.moore@intel.com>, <corbet@lwn.net>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>, <rdunlap@infradead.org>, <ray.huang@amd.com>,
	<gautham.shenoy@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 7/8] cpufreq: CPPC: update policy min/max when toggling auto_select
Date: Wed, 1 Oct 2025 20:31:03 +0530
Message-ID: <20251001150104.1275188-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001150104.1275188-1-sumitg@nvidia.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb7c61f-6e28-419a-e307-08de00fb9902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wENb2GhM8Oae89dKwsQAwh99XX2wzoZI3Nxou9z2wdqG53CDP1BCfTlKs+a3?=
 =?us-ascii?Q?8e2FTPi/3AMBk9r9779xFtqbGubLa6IhggGLDo0uLLdbQljn/nl1mwj/p9p+?=
 =?us-ascii?Q?J1oYiliNJtvQyIYA2Qqu0xbbSUZwbwTHpn8WheaRNjVT3QMipGMZ/VdKVx8h?=
 =?us-ascii?Q?kap/e7mqv7GNfESMt9AIKq4dmE/YUX41YsliyFcKivYuTAnQtC3d4xQ5AAoG?=
 =?us-ascii?Q?VIYG4TmFyvP6HIIEZr+hVj//LCm6mueYwTGKztuwXf3hAUpfoR8pQVQM2RKy?=
 =?us-ascii?Q?txyc4torDSfY3Dxml4V+5WvoJTUOSrtYC2F7kynBvUpFO92NHnyUXDdQpGLu?=
 =?us-ascii?Q?4g/+gIDyNPa89Bbo08Rf0mzhW6IzNIA/fdoeEDlvWu5M/iS9fPA8gNTD3kow?=
 =?us-ascii?Q?fcdJTPVR5gyIz9mo+6gAAf4WSV77ApA9eFP59DU/hypeALb5y1mxNsTbu2JB?=
 =?us-ascii?Q?ZdeNZahc9OW5q3xWBQtFlxh4OWLJohjj9FQQ+dAqUTP9NpxSXux9xcuqNnx7?=
 =?us-ascii?Q?TfzxMxIlb8z9AxZEyXyUDeuAvHq7ehyPEd6br+sO51rEnDTdyn8fKLyU+wn0?=
 =?us-ascii?Q?BpHSgFegEbr43HdVzAmJQMW2U3RXjQDYxAirV4xVy+w7gfJG+xANAnM7OwEI?=
 =?us-ascii?Q?SEaX+7DJdaYL2Uk+20CgjK/L8hnEEMU/wxYp0RTOjxrGZv8YFBXT0olgmL8d?=
 =?us-ascii?Q?pHmqQn5NGI2sOMCxF67N5m6mkWkJP8j1qxsXkc6xHu066PQw0QhW27K/PGks?=
 =?us-ascii?Q?AO/VM07Gi1VlD7RG0ZjGtB3dTSB0VKlRdloUPwId8LeKciikptJ3AtLfFOxH?=
 =?us-ascii?Q?S3xA+g/NS70Pp9MXGjX2n6VywhJ/Z+DVB6Oykd0Gd/ncP6DjBVzD9eiZZ4wv?=
 =?us-ascii?Q?JYHDYx0az0D+kn9AZj3w/uGK7tR75ZYdAsCeeSWN8uWGb8r7E/V5T/0zWm3I?=
 =?us-ascii?Q?YjNoMom5CnE40Rvgj6iGdbLd1K9tMjRm1njT5Y2/LdBO2XKJhWvtCkTfq8n2?=
 =?us-ascii?Q?JBcenFTztIlw3ZQoSCJ3hRo+EZQU3GT3PAidmIg58AT+bmCzIm+ceMV2KSAr?=
 =?us-ascii?Q?joKpXu4oB3CYxBo8HFZHiTJeewsqXP2XSPp9TB75NR9pkPge1SaUahEWM/2Z?=
 =?us-ascii?Q?FLazy4rPwvF+wYtC8Ohrpt9YLie1vJ3GcBwzK2N5THO1XhpX+ChqsvIqw3fI?=
 =?us-ascii?Q?cmcQ4VXkFcGu3M7f5rx/eLbTm7r51rfE7NiFg1HZnI9OJTgnexIntbcvKYH1?=
 =?us-ascii?Q?vtWn4fDYL2co8zMGxV4/URiQRA0X1JnlnIPB8FVtPQsZENgaxusS+N5Ado5R?=
 =?us-ascii?Q?Q1e5kmVGsFgkw2gOAPm63ecYTh7S0VIoojif04BJ80R3nlQ5Snt9Xl1dPflM?=
 =?us-ascii?Q?asnSj4uU4tH5v8jxFEeC7fZ7o+nEPaLUkjMiq4p/nY5elP4HNKJgab2rLuCS?=
 =?us-ascii?Q?pkf8VfqcapyObAcF8F8aa24aC3nGCH5sIBe0vzwvw12gLNo4L4/sLABBoKk0?=
 =?us-ascii?Q?VXB5Qn03xqQ2KU8IRuMNuOmMSM+Iup86kKKEqY5Te9guvYuus/RrYT0PqLDQ?=
 =?us-ascii?Q?XwrXEXcMz6gJ/cp24EP0itPhDfij79+lUWnJXEDk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:02:53.5118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb7c61f-6e28-419a-e307-08de00fb9902
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

When CPPC autonomous selection (auto_select) is enabled or disabled,
the policy min/max frequency limits should be updated appropriately to
reflect the new operating mode.

Currently, toggling auto_select only changes the hardware register but
doesn't update the cpufreq policy constraints, which can lead to
inconsistent behavior between the hardware state and the policy limits
visible to userspace and other kernel components.

When auto_select is enabled, preserve the current min/max performance
values to maintain user-configured limits. When disabled, the hardware
operates in a default mode where the OS directly controls performance,
so update the policy limits accordingly.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 65 ++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9946adfeeee4..c888733ce5da 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -639,6 +639,26 @@ static int cppc_cpufreq_set_mperf_limit(struct cpufreq_policy *policy, u64 val,
 #define cppc_cpufreq_set_max_perf(policy, val, update_reg, update_policy) \
 	cppc_cpufreq_set_mperf_limit(policy, val, update_reg, update_policy, false)
 
+static int cppc_cpufreq_update_autosel_val(struct cpufreq_policy *policy, bool auto_sel)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	pr_debug("cpu%d, auto_sel curr:%u, new:%d\n", cpu, cpu_data->perf_caps.auto_sel, auto_sel);
+
+	guard(mutex)(&cppc_cpufreq_update_autosel_config_lock);
+
+	ret = cppc_set_auto_sel(cpu, auto_sel);
+	if (ret) {
+		pr_warn("Failed to set auto_sel=%d for CPU%d (%d)\n", auto_sel, cpu, ret);
+		return ret;
+	}
+	cpu_data->perf_caps.auto_sel = auto_sel;
+
+	return 0;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -902,8 +922,47 @@ static ssize_t show_auto_select(struct cpufreq_policy *policy, char *buf)
 	return sysfs_emit(buf, "%d\n", val);
 }
 
-static ssize_t store_auto_select(struct cpufreq_policy *policy,
-				 const char *buf, size_t count)
+/**
+ * cppc_cpufreq_update_auto_select - Update autonomous selection config for policy->cpu
+ * @policy: cpufreq policy
+ * @enable: enable/disable autonomous selection
+ */
+static int cppc_cpufreq_update_auto_select(struct cpufreq_policy *policy, bool enable)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	u64 min_perf = caps->lowest_nonlinear_perf;
+	u64 max_perf = caps->nominal_perf;
+	int ret;
+
+	if (enable) {
+		if (cpu_data->perf_ctrls.min_perf)
+			min_perf = cpu_data->perf_ctrls.min_perf;
+		if (cpu_data->perf_ctrls.max_perf)
+			max_perf = cpu_data->perf_ctrls.max_perf;
+	}
+
+	/*
+	 * Set min/max performance registers and update policy constraints.
+	 * When enabling: update both registers and policy.
+	 * When disabling: update policy only.
+	 */
+	ret = cppc_cpufreq_set_min_perf(policy, min_perf, enable, true);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_set_max_perf(policy, max_perf, enable, true);
+	if (ret)
+		return ret;
+
+	ret = cppc_cpufreq_update_autosel_val(policy, enable);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t store_auto_select(struct cpufreq_policy *policy, const char *buf, size_t count)
 {
 	bool val;
 	int ret;
@@ -912,7 +971,7 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_sel(policy->cpu, val);
+	ret = cppc_cpufreq_update_auto_select(policy, val);
 	if (ret)
 		return ret;
 
-- 
2.34.1


