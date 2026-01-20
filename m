Return-Path: <linux-acpi+bounces-20460-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNIEM7y/b2kOMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20460-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:47:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026F48D17
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAAB67A9C2D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364144E046;
	Tue, 20 Jan 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPojXPam"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80144DB9A;
	Tue, 20 Jan 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921046; cv=fail; b=jvuuveZ7wOB+OemUooNrjOSEijTZp4cw+kGBzcvBgOinhn9E6/AJ8HpY30XuBAtNgYCO0kz27OTGVCUS4lm6/M+H/nTJ4Pl64nYcOjEPxFHsI4px/iEYKy/nzK5bYYZ5hKvJ68+FAzZZ/z8pkgwH4vJTfS2WdLcbF/wrDelFVR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921046; c=relaxed/simple;
	bh=ST2H9a5WUdxudq4qWEumwIRiJTKh7duFgVJoOMRXzzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiLxnSYQykeLtvTSrLSJwcU5P8B4UygLRBiZ/OwvBgllzQso8ZBXhQM4xppNrB+DGA8HNucgjRdiNESZ7NJKELG7oRwKaboGSRry1gvgPDBf7/ZSwAU7utYyOMw+OULtUkkxEajlktfM1u3ArTL5wbJc3P852YhWO9OpSHvgg40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPojXPam; arc=fail smtp.client-ip=52.101.46.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqAbB8LR9YxWZnDnuaSE+3/n9df34T1oV7wxFG3Oaz4o2hioR90wUWEUD+5k5N9mt+xS9C/PJFDFmGpgKD/6rHj9bq4+E0GGyVU4fi3Tq8tDc4y0mmCwgpcSjMq0LH9c71MSZFz8nFQjWH4Yo4x2g0IIYI25FcP/QF8CqPrLq4jxTZH62ThbS9q8YKYVrrmcgEsd66HZgzqMSDXrxf2fWEs2b62Ay7s/MgS/g+hxFRHLdqIdJT05JQ6BtJyx61xGgfQPR7s22eAN5BdtzluH2F0M2jWi0m/fyDrKWxtneSFFsyEpTJuDjGCEfVE3EjsuXR7/QnVKfQ4+GQR99AOdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCB4AbAKQmilcvzUzSaUN9mKx+pQw9M2+ftDI+XPhrE=;
 b=mZf+O5m9VPPBOPXhET8odarrJ7CxRc3sdbA2c7jXREsKm+8fUJ7WtCg1+FA71WEQwdKu81d/875zDmrtKXHdy6o1wDJmuNbGT1lWFCtmfJEnMBDEHNfctjcBq0/tTn9SJzq202c2xC/KY95TDN81ZxpKz8clIHL+vBCuX7lZXJFLNNBGLvLOt2LUeYfd4DgLemhkYPxATBN8LLqQlcP2X5xXTG/M2Py87td8SGC0JyVTL3JZt2GNgCh8m+/hdA2NcR/9m4m3sDxZ20Ke4gqCukhKV0YQVT3WntkXlY7PIOCre0cnAMQMeSFydLKy+eporu6v/8RiHkMsI9SmSBpkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCB4AbAKQmilcvzUzSaUN9mKx+pQw9M2+ftDI+XPhrE=;
 b=EPojXPamv2z7LSw07XMPuKslwuiUtZW4Pg3HOJlVvUfvWIuCAv5hIrspa2iq13x8fNJA7s11rGZc78WZ8xBajgprokluXoDdvFF//l5jnmWpVraa+zyef6dL6ajjZ2guXh41Tr09ZEGwKlE3z/OH3usEdtkbCKyBQDSK4oui/wfeBBl02eYQngr4VR4RmpOR5gBov+4sv/G+PbWAA4zeWHfRIWOatQPMJApO8RIJZPcQ2hWmxz0uTxstQZj5usNem9FlXYemy8v4D++deHP73gS1KQvb0yEBvagp7zxA/Gt9j1sbZYbd1YY0XR92/sGZD8GHgrPvpIOKhpvpw0+LLg==
Received: from PH2PEPF0000384B.namprd17.prod.outlook.com (2603:10b6:518:1::68)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:57:19 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH2PEPF0000384B.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 14:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 14:57:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 06:56:49 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 06:56:41 -0800
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
Subject: [PATCH v6 1/9] cpufreq: CPPC: Add generic helpers for sysfs show/store
Date: Tue, 20 Jan 2026 20:26:15 +0530
Message-ID: <20260120145623.2959636-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 313bc7cf-b594-4e59-905a-08de58343550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLrnM1aCYzVb9izrqWuHMeg+GdMoTXK1/gQKn4go4qfSpqnBVakWN9jrl1Xz?=
 =?us-ascii?Q?Z8lTPm3Hafk1o4a1+DsM3rtkCf6468hpcov7+2ydKMCK+rRkBfVfebjBg1UY?=
 =?us-ascii?Q?l7Gxy0PAILo0xMOxDtuuuLfN+DGYYjGGNFLUOc7VP/cuEFkmQkCz6MPlvb88?=
 =?us-ascii?Q?wko+2FjYgvqkGQxNP8lKQaPXsgFXwUiNFq6aLWuxW1lTzIipK6YVD0sn03eH?=
 =?us-ascii?Q?DqKMUQEU5eny4czn4pbWn8A9Sqjdu0vr29IKVZT3CkhdRaJRjcVZ6N++rzin?=
 =?us-ascii?Q?i2Yh1XsScVFd0Bx47ctjHUkIC+TrTUmMTJNJeesUdRMmz//sNin4tJrlbhpN?=
 =?us-ascii?Q?ky/JtR6It6RF8ECr3yKbtUtB71ke4SIXuqOeJRp+DD+zr0XNbWIYvB1mGvea?=
 =?us-ascii?Q?LxnyDj/o4fGOjzun2ziPdl1Km+GRwMIp9ZhqVBqbOpgKhkv36h5OQnSgKF+F?=
 =?us-ascii?Q?Lla5h9MtAXCIxVdd/2iGcRsZCH6uYc4cnDq6f3QuNaMU74tI1YybfzIZbEJx?=
 =?us-ascii?Q?peoOY+JxiBODv18k64xoGqxq4D4ullGhjbar9tmljtWLmPF7HHMntiHhFK8b?=
 =?us-ascii?Q?J9oh2lnuZo0zoItPpGBMgurVhPdi8ZKVMQTLCMAoHKYneqb7T3O45Uecz5ex?=
 =?us-ascii?Q?Ll84w2Ma9SEmGZi9gSjKlB9M/azBgft/9+y/iLdKxCrgPvimc8laR7Rxx+5z?=
 =?us-ascii?Q?VWfBspK8ysabZXOrZREMyyWuIVq5FDuh89TEI8u6ID3vjbTIBQ8PshYVep8o?=
 =?us-ascii?Q?CLqsZ/iw0E8b5qOWKcHZJZaH1ZhBHaBv+AIdRxbODam7qIs25QxWEKSN5Xmm?=
 =?us-ascii?Q?ocL2Mm1cE3kZ8x0ZFAv2veJB9HwcVnA/zgtVgpoVe9RJsgxb8ljQoHz1C55y?=
 =?us-ascii?Q?hCCSHpU+0vkx2/eWJ0hCYXplM8hrcoYyRgchtEJ9qSD7TtwJDsQ4hMWAjrNi?=
 =?us-ascii?Q?/2YRX4WuFjfwUhtYUhiwvJu4CvuhvaKW4SJ8IavZXXFIXVT0LKfk9V3M2jpf?=
 =?us-ascii?Q?1337Z8AH66fTH9M/EMVdL8W64x/7djppcAweZwDotoQIOaGWUB6mNASGHcz0?=
 =?us-ascii?Q?dpb22FQz3l026guL6jqqeVWOiRDnf2NPj+zoThg2b5nLlPETADyDxZpGX6Th?=
 =?us-ascii?Q?IbMQ85VOY61coDkw/BT+cKNBbEMiTXkO3Kjl87nzP7j9h9i8GEWrjLSw6tET?=
 =?us-ascii?Q?qkfIcdxRh6QTcv/yd63Eo6/Nvr+1j85FgSQmWIEGLQooEfMBGstvJOYU3WuQ?=
 =?us-ascii?Q?aU95IgNyKinnMQWRVus22kbqZAO2ZyZt8MdA/SCyY/63xDxsz5CpdCczyjDb?=
 =?us-ascii?Q?JHTjARAF5JRES9INJWbh3/dep6JMQmvkIfxHllvnYScXRQEpQdUrFLuoU9is?=
 =?us-ascii?Q?J3OqX5xy9Cq8c4wkqIzR8oT4vF/cN5bfGyqGNUMPubYH5ou1NcinXY83Oj3w?=
 =?us-ascii?Q?mEId+KvFsN7aa/Ocg7e2aC4i+olIgkbZ401aBVtegO8aSgywuXpuQP2CD1lN?=
 =?us-ascii?Q?28ZbaDv0oCE/Ybd+9/YDxXitmD4gT5S2cO4mIUEYyYHbkXEQoISw02KCf8KL?=
 =?us-ascii?Q?hqgAy12bcHskO16C4c268YI2Xa80IfYvUtLoDKozj0LS/KFIpbi4IFDFwWNu?=
 =?us-ascii?Q?IjFugx4HUYH6Zax7zkopFFRVxi1pdZJg+XGRyEm73Hx41Y+6ZXWSW652wxEJ?=
 =?us-ascii?Q?qXqz87oYPsaJn9edb4m9OrPjoLE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:57:18.7894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313bc7cf-b594-4e59-905a-08de58343550
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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
	TAGGED_FROM(0.00)[bounces-20460-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,Nvidia.com:dkim];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[28];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7026F48D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add generic helper functions for u64 sysfs attributes that follow the
common pattern of calling CPPC get/set APIs:
- cppc_cpufreq_sysfs_show_u64(): reads value and handles -EOPNOTSUPP
- cppc_cpufreq_sysfs_store_u64(): parses input and calls set function

Add CPPC_CPUFREQ_ATTR_RW_U64() macro to generate show/store functions
using these helpers, reducing boilerplate for simple attributes.

Convert auto_act_window and energy_performance_preference_val to use
the new macro.

No functional changes.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 69 ++++++++++++----------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 36e8a75a37f1..c95dcd7719c3 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -863,73 +863,54 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
 	return count;
 }
 
-static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
+static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
+					   int (*get_func)(int, u64 *),
+					   char *buf)
 {
 	u64 val;
-	int ret;
-
-	ret = cppc_get_auto_act_window(policy->cpu, &val);
+	int ret = get_func((int)cpu, &val);
 
-	/* show "<unsupported>" when this register is not supported by cpc */
 	if (ret == -EOPNOTSUPP)
 		return sysfs_emit(buf, "<unsupported>\n");
-
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
-static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
-				     const char *buf, size_t count)
+static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
+					    int (*set_func)(int, u64),
+					    const char *buf, size_t count)
 {
-	u64 usec;
+	u64 val;
 	int ret;
 
-	ret = kstrtou64(buf, 0, &usec);
+	ret = kstrtou64(buf, 0, &val);
 	if (ret)
 		return ret;
 
-	ret = cppc_set_auto_act_window(policy->cpu, usec);
-	if (ret)
-		return ret;
+	ret = set_func((int)cpu, val);
 
-	return count;
+	return ret ? ret : count;
 }
 
-static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
-{
-	u64 val;
-	int ret;
-
-	ret = cppc_get_epp_perf(policy->cpu, &val);
-
-	/* show "<unsupported>" when this register is not supported by cpc */
-	if (ret == -EOPNOTSUPP)
-		return sysfs_emit(buf, "<unsupported>\n");
-
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%llu\n", val);
+#define CPPC_CPUFREQ_ATTR_RW_U64(_name, _get_func, _set_func)		\
+static ssize_t show_##_name(struct cpufreq_policy *policy, char *buf)	\
+{									\
+	return cppc_cpufreq_sysfs_show_u64(policy->cpu, _get_func, buf);\
+}									\
+static ssize_t store_##_name(struct cpufreq_policy *policy,		\
+			     const char *buf, size_t count)		\
+{									\
+	return cppc_cpufreq_sysfs_store_u64(policy->cpu, _set_func,	\
+					    buf, count);		\
 }
 
-static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
-						       const char *buf, size_t count)
-{
-	u64 val;
-	int ret;
+CPPC_CPUFREQ_ATTR_RW_U64(auto_act_window, cppc_get_auto_act_window,
+			 cppc_set_auto_act_window)
 
-	ret = kstrtou64(buf, 0, &val);
-	if (ret)
-		return ret;
-
-	ret = cppc_set_epp(policy->cpu, val);
-	if (ret)
-		return ret;
-
-	return count;
-}
+CPPC_CPUFREQ_ATTR_RW_U64(energy_performance_preference_val,
+			 cppc_get_epp_perf, cppc_set_epp)
 
 cpufreq_freq_attr_ro(freqdomain_cpus);
 cpufreq_freq_attr_rw(auto_select);
-- 
2.34.1


