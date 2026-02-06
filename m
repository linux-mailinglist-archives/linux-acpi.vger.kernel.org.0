Return-Path: <linux-acpi+bounces-20882-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id otD4FNT7hWnUIwQAu9opvQ
	(envelope-from <linux-acpi+bounces-20882-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:33:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1CCFF00A
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A69306B797
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EE40F8CC;
	Fri,  6 Feb 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MzbxAIxG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AB407572;
	Fri,  6 Feb 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388076; cv=fail; b=JeKDMNUwwWSUCESCKFkkoOgrlVS+G4b/RQrlAVY77cu4sKK0fHY6K73XLsbMDv5nx4YfHUxWC6fJpLnXoJhLHWMPqs+9Atv3OTtIhVwo/rTqbhUVF13Labwa+L27PazOj9r3SUMZarPy/vFU5CiafB6JAZRwhaD9Kv0PAVFNbAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388076; c=relaxed/simple;
	bh=UOZVT3kfCKuNYuG/IgYxyHiM/MsC8b+LnPDN7lESH58=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=If9wGIYi+Zt6yrE5CP6ogiqJvvsiKGFJmFDj16LZcoYhPw6rWiCWKfpVVndcCj+NXS83bmXZGze5fffQHamrw2gGs/7h35HsTTLUK7GGmf/Dm5Oh62KmpuiNRUhzPrVNcRuXK3QqA91oSk2qd+tn89zFsL5onJoCCm+ILdP+ITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MzbxAIxG; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWr8gpSq97wXwQIRxm6FYaTMl353YpM0OuAtI0kJ91nrppNfyRJRJ0MoiGwl6wT+ZTj++E9C0h/IRrQrI5jgoTxIqDhXHRYh5J5HSfUv0e4Ho329VFjaE2p+BJKFIgiAu3hCrNTVu6juVuXCyW/Rwka77YvN6Zj17+oDRUXt0ijpbqXTGGdeMyefeYY27hBukbQCWxx4rdIguoq8ULJt+TM+JfJmJ6Pz7FrCeWWow7FxMVbB9U3bug9s9vRdMqWYTTqAOPK4sUArGJEc3lmC+0aFp2uuoZhj90sHDrEAD+GmZTEZEHLaCozGPWdKUhbU6yj83w4SGXzOTOhuhEMKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fti94J35i+p9Hf/Qsbei6I//5q/htWJuWg9OJuoHuKs=;
 b=L9EtGkjguWT2DmzVQmd/AxAiZWH2aA7in4hKYxpxv5h/pCcAyuA7zZ4s+/bFxexYokbkfXTKQPhn5qdg4O8PFDyl2H4FwA6ph9dpRTneNj3Rt33e6sOBKf736nDdqD38z1Xx9LRZTVRqbFEqIcAUAnmRw9ANfLbdRsCukaMx041RwhZUG2w2hZT7Rm+5Sl5XlFQqB3gbaFHAoepplSLMN/ixAwD/kyBdvHny+0ONEVD2OqcTutqBJaixX39a2ZAbACqar/ZuNWXjCCXQv7+ZYyoBS2uIawH6IvAJ+ll4mKOzSXdOdzjJecA5kaXeMpJK+yh+YSTReqpo1NhoJbYk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fti94J35i+p9Hf/Qsbei6I//5q/htWJuWg9OJuoHuKs=;
 b=MzbxAIxG2Skwzf6O1UKeY8ww8NHrtY7qJ0anzDUM68/0FdTNvJ6iQryRlpTTcfPxmt2E1h8HyeL70K2OaM2cECPTLUij/lFjD6b04/wBVYfmKE4p2qyMzDbqdR+6XDCDQPUFgY2rVHmMSLFruBPAt2WfIhAR9mDNj1cW4O+n1ilXZu+LY5F1saZ0NptgrOt8TB8M5tFcEfG6ZTyVq90Qx6wU8nkBh5aEKC2BmCLtbofUCSf6Dycre22o/sX7EUVNlJPaPwkHSfMYOccvfwMvaVaSh9XbRtLv7rEGCnPRLTuFqXGilVRUDwaeMzczcBmW+/cN7z66JHsbmQJ+/ZvERA==
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:27:49 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::80) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:27:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:27:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Feb 2026 06:27:35 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 06:27:27 -0800
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
Subject: [PATCH v8 2/7] ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
Date: Fri, 6 Feb 2026 19:56:53 +0530
Message-ID: <20260206142658.72583-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d96f013-965d-4c59-973f-08de658be774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhwnBj5Q8/sTp1OMlMxnMkyqVuIdYi7TIbvlaFnpLJYJ8pFSeTLYgV7Gl/dB?=
 =?us-ascii?Q?KvMYKw/Tt/FXDjN4V3IDETUVGaCX3t9+hX6tB6K3eZk+pxXLOtOccXWs4j69?=
 =?us-ascii?Q?0RIs+GmhPnL9zzx4SqMr7zWCvHQ0aTlT8tKLwIDdwoSnE65ub+AyV8O4qsqx?=
 =?us-ascii?Q?EdKFCdD/F87AGKN+IKJH5kutyIl08xwfgOcRXpnZI0mMi/TtMbbq7bkKStph?=
 =?us-ascii?Q?0MvhCMelmSPpiK0imnEIhGEChkGdHPQCT/CxoVM8pGsluRxQ+XbLGAh1B2sh?=
 =?us-ascii?Q?HLVEYbEUtPycTLtCidxy2tTfDMYM+cPoqiodhSeYIbG4FnFqKOhPZ/14MKj1?=
 =?us-ascii?Q?tNh40broCtt+f8sVqwBPABfWnn4v1zW8XQIXkKsqfpJoaQYRowDzoA3uvMJQ?=
 =?us-ascii?Q?tlZSsxGMk5kZPvK1DVAAiHuqHb9mZV00dc24cZKaqyzwi03ZjL6667Q/5eik?=
 =?us-ascii?Q?ezufv7dE0bKM9NK0oSgk/zN4cuzky3Y/hrMDHVaCamyzofXCC5Yd3ua2JsSM?=
 =?us-ascii?Q?AUilICB2B0jQ9UD1L3cpiKXYHd8w//ofnJMUOmlTmOXVClsauIDcd8npG9py?=
 =?us-ascii?Q?0/dO5mOuJL+hlwuJmPXwbeQ8V4RxE9SFifnAx7S9jtUJ7/c1Wt4EWjmt467l?=
 =?us-ascii?Q?y8gD3rJzyfgNxuw/6DxPwo9LQ16zmjI5+Lq+EQ402hGggAm48vLY6NdLqVqb?=
 =?us-ascii?Q?FvKEfy1gx/O97cVabdrIb83jti0Wum+MbtZpUyU1Fpr6+y4HhfJax6F3DNMT?=
 =?us-ascii?Q?yWTroZDagToFHvt7wwncYjY0OmSBM+Ys+pSj+MegzT0AnJm8Na0fFChWqkEN?=
 =?us-ascii?Q?LIVKKJLUk5664lOo5McSkPcz5/npu+V35xw8nIqjDUZVR8XRv6tQpxBAWhvV?=
 =?us-ascii?Q?gm+golM/8mAXRrE6Be+BnbnjGl15oC0alNaQiTPMwjpOdpZ+sZd0hBbdZOY0?=
 =?us-ascii?Q?JcP5XA6i3to498uSjiNQ29sLi+c6LTicR0bjOzAlLFkpOWGZrwu2tnBBXS/C?=
 =?us-ascii?Q?+XYZbZ8L+QJzRY/c11C37o8+YL2it4VMSnN9kEo0HTefiOwkJxsk6iU8PPDL?=
 =?us-ascii?Q?b43t82DCOaTxyE7x8pO8DtbZ3x3RMhWEZ7jD7M8koaVtukqZiqExRGhGMA76?=
 =?us-ascii?Q?3SVDPL0C3WJNV/yNZr4ZEP1u5kkQMkIRzkpGD8j0imUJnoupNhg/i5fjOgGb?=
 =?us-ascii?Q?BXDmuN7rFNbAfTe6XE7ZRwIFECR8ry/VqZxJZ01YKQypPIDi2oUfdxP5r7xZ?=
 =?us-ascii?Q?sjHxRP5uLm5QmvTjSbPjYw3/cSMn0NJ3GDqWjTV73+L+vjrhvduqgcHZvdAt?=
 =?us-ascii?Q?YSIwD7aZVBvN1ww/ShI1R4NDoSYS7jbHEzl317pl6azQUVa31dawAFrut1XH?=
 =?us-ascii?Q?RDOqzRlY/OSvSyYgzOnblFCKfQk9h47BpGXYYAPf43vFfTIjD2evIFs19ilV?=
 =?us-ascii?Q?OrEfNOCpfWCXaoNrdkd31blNtZCvkjvdbsc7OF30+8sziG2CaOD18WRrgDdf?=
 =?us-ascii?Q?12WwSJXfoNT4yU9eSmzLIQhL0el+G2j8ct4+/kdKbnnglawgGluW3ZPcv4t3?=
 =?us-ascii?Q?sgH3/3BZH89w/SGOv9AgsfFEbiEaVjEWciXoJB4PZCpsmp1K+AGuoZT/B2jy?=
 =?us-ascii?Q?idBJaoa7/tYK+Aa18azb5fgpNMxVG4K6MzRUBBJkeUmhnvBPwvaMWdQgJ5y3?=
 =?us-ascii?Q?zNiyUD7vbvRmttGUMd7NK+2YNy0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	imvH12zZd7GRNsVDaKNIA1+EA4URp2/2KkbgztYUMedNs/craq/2c1Zy5tweqCyjrXUj7b9HpA00D48imKgZ75ewV4lPnHMMfot6dGzVUtP/h7wVAR40+qDuC5sDtM89jL5kBEiBCSjuQ7eoZrt6dN/E0ueUtT9/wA6tITpS3iAWc2jd3XudkV20CkXxjSVjFQyLzpQ1FChcCdjBNiD3Rs/wPnULAV1wdW0ZtHOc1d9qhzFZ1nTa4IGZt2TZsKgiv70Rfx3Vw7k1mjo6mk2cNEgVJm9krpyNWowo6qMSeXg71ESzWmCmctxd5Qbzq/INNbAHEFWV85KjSp/EdgvdigDsZ/+8pZFEkI8u3bIVG/BIghA5YXgjGRUYZAa8z89qw8fCyckxtUUk1F2APViRaazQ8LP6Z6Tk/o/tvVYAAXtw6iS5lVR3zQWAHovwFLM7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:27:48.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d96f013-965d-4c59-973f-08de658be774
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729
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
	TAGGED_FROM(0.00)[bounces-20882-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,arm.com,huawei.com,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,huawei.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9C1CCFF00A
X-Rspamd-Action: no action

Add a warning during CPPC processor probe if the Desired Performance
register is not supported when it should be.

As per 8.4.6.1.2.3 section of ACPI 6.6 specification,
"The Desired Performance Register is optional only when OSPM indicates
support for CPPC2 in the platform-wide _OSC capabilities and the
Autonomous Selection Enable field is encoded as an Integer with a
value of 1."

In other words:
- In CPPC v1, DESIRED_PERF is mandatory
- In CPPC v2, it becomes optional only when AUTO_SEL_ENABLE is supported

This helps detect firmware configuration issues early during boot.

Link: https://lore.kernel.org/lkml/9fa21599-004a-4af8-acc2-190fd0404e35@nvidia.com/
Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index de35aeb07833..0eb1a6d54e88 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -854,6 +854,16 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
 
+	/*
+	 * In CPPC v1, DESIRED_PERF is mandatory. In CPPC v2, it is optional
+	 * only when AUTO_SEL_ENABLE is supported.
+	 */
+	if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
+	    (!osc_sb_cppc2_support_acked ||
+	     !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
+		pr_warn("Desired perf. register is mandatory if CPPC v2 is not supported "
+			"or autonomous selection is disabled\n");
+
 	/*
 	 * Initialize the remaining cpc_regs as unsupported.
 	 * Example: In case FW exposes CPPC v2, the below loop will initialize
-- 
2.34.1


