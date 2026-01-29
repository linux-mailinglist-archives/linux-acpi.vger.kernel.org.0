Return-Path: <linux-acpi+bounces-20757-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH0RN1w7e2mNCgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20757-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:50:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE76AF1F8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A27F63010208
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E95381713;
	Thu, 29 Jan 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkyX/q7i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7B3816F1;
	Thu, 29 Jan 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683758; cv=fail; b=OMP2NruyUM3YKtD+4qaPHLvnuFzEGRUFpya8XCHSVg4j0hDZqJD9IWihMG80oQ0WPxBFdHRdUFKUWEjLqngF98hV44UnNLIvQ0e7ZDUHQQtf84+cIAIWuUsmkHAKfPkop0TkxIxvmSi82MALuo0IqdHmzFPJRzCkIaw6uJV+i3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683758; c=relaxed/simple;
	bh=skuzeqXs5Ff0ejgNqpDRXQOwwpgnG+ZnS6j5ZvkMyw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcOT4gAFdUbpVtu1T5IJQfUJ3/ln+7yE8wlX/MWJo8rn1jDBUz/0GmegGnGDU7dG4ELnvURcF6eRKtXkSRF12Vl7up0dPtmUfovd0Zwz0H4Tsd71DfbCtTdlVq+zCX1ppKfeUYyGGkGVq2iTxj8ipBSTxTETxnh2Jx4NC59hlxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkyX/q7i; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWQPrR6o4g6EH5yUVxvWbn+lZpEyQmOd/2XzlXCWykTOBKHdlDPepVFmXZzr/xmqJ38lEORaG2NX0PCUxbnWWsL0GK/vPZU1w39Jkjg8jVum84V34cqEz4RwuKJT7QDkg1VHZ0D8f+QECISPYMDatMR8IwRFvXymc8jFFPE8WMSnLsm3L3TMFeuY2txEKb0j4C2VVT4N0cGfq0v3LnBRIBEtuH+xwpZ+sxVCyGG5RvDKArGqKi3eStvB7uF//4dUWULmMH13o+bBiiBBmWbnDP9ABEpslic2dGGBNUpHksiAAXBD9ejvss1TTqZAJRZY2t3c0rKub1xvWcyCQl1BWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ3AhDOi3DSsY+gQWYBS+xoFrxiguKVgGbR7WCb4OJk=;
 b=iL1ZC+Nli0fVDTVy60Y2BSVPvx8NYh18oBzNZamTbAvODyc/6klcxGEygQNP5POkE6mRxRVJJaAss3aLA/0nFXg4nVbdLcWpTdM6N/IgosG+kZTopFIj9E/jKxGx6u5VYGUlHIR4070lev6E9KMRBY+X2M20YgpmcOX0flUzgurh6viH419ZdVb39XgUF98MRcy2van33LNMbRbNLpIRkgpih2pLcPYEg9IBx5fByvCGIHSOvi28g2p8sr00ZmAeu5GyC5dQN1GwClrv2fESgTl9kaqkk5S7FaIWK5/X0zWQdpUXcTpLLjYfgC1PAdnd1HD/vPO97GP6Nmwv4Uiv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ3AhDOi3DSsY+gQWYBS+xoFrxiguKVgGbR7WCb4OJk=;
 b=CkyX/q7iud9qIBdxGPqteYusLPTQG8Qd/k3lOzlTZacwe5yXNC/80RWQiOSeWcN7KUEHVOP2wNxg1+rm6mYsQ42rYuGv4XRjw3ZTgLKFwmv2L47jL9lQGXUEk+LRGIB05ZntQ/WXyD4HBrDTuxgvUQMKhx6o2uyP1NA7/s0pHBPxuYBZZPEyTSrMcsyI07cwd45vdZmoz7wzo9UARAfTjP+HEeKh0g1zjR7fMVhPL6+ROI1xSwxiS4ggDMTE2SOXfnNyBZWtn0MWltCwv591yE82DXCmfqMpXZtjlkiBqwldRngPA9QucbHVB26X4ft42PDkX2tMjFofUu52sVr3qQ==
Received: from MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:49:09 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::7b) by MN2PR05CA0045.outlook.office365.com
 (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Thu,
 29 Jan 2026 10:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:49:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 02:48:53 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 02:48:52 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 02:48:46 -0800
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
Subject: [PATCH v7 2/7] ACPI: CPPC: Warn on missing mandatory DESIRED_PERF register
Date: Thu, 29 Jan 2026 16:18:12 +0530
Message-ID: <20260129104817.3752340-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: f5afecf0-c2ef-47a4-0d6f-08de5f2407e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgq6XntsYEYCtNs0jfCCqEYwJ5RBZwT/k4KfX+KfwpV3upFNQ6Fvf3npMQmf?=
 =?us-ascii?Q?OhPHwNrxdksIeAFIO/IMS8wrM4bAx7fpR19Lb2OImMkIWhJap5GOH56Qc39U?=
 =?us-ascii?Q?GIYxP+xClUJpMB3WDgr86mYTaX/RcJ27j9xJxKDCuZPrsvVtd2HP4U70RXiy?=
 =?us-ascii?Q?P7G6/unfyeTBDNcfFY2dJgUvNwKAxn/WaYqxCeX/TvONDIDRMAUhUuO6ZERo?=
 =?us-ascii?Q?1I1L2h6W4jkANm2W+Siatn22gZHRzc4PhW8tqH995hB31tww9gpYDJY7T7l/?=
 =?us-ascii?Q?jPsLHL/hOJbiVunyThy0ll7Q9VDvYUhn6ubdnqKdci2G6qlcP+8JoTYLq5R1?=
 =?us-ascii?Q?yrGigQ4fZ3JuDvO3Gjp/U7ObSV27Erw9xG6ktUsSVmJrN0yXyQbE6+dU0gwJ?=
 =?us-ascii?Q?QvwOXFG/e/bVmoyZd4Iqqp1M68u9rQ0k3ukhTR4NrS2d9KQO1K5eGQawIh8F?=
 =?us-ascii?Q?3gWawp7k7hwYeuSkUyV1ogRorLX1wLGf6xrtuxfsxXkSmxuy1n10XKTZiEW5?=
 =?us-ascii?Q?6QpmdBMI991L2cteWVQt705vVo+gNol+CWTkqGg7wwBN0DySS1+HTbeQMZ7C?=
 =?us-ascii?Q?9EpwxQHfcP00PLEXXfIFylIi0YDlpqInp6SLAZw51/X5EWxZFqzm3LotTpWg?=
 =?us-ascii?Q?56LJ6dpsmNrOtdgwDzt2X9xH/pZp8kBf9ESQ+3X7TOzeOO1UUq46PGbKuRo3?=
 =?us-ascii?Q?h3hivn9ILVLr7ktV+2f4ylVzsaB0f4JVWGLagTa+GJn9dHLKd8Lwc3BJl7Xp?=
 =?us-ascii?Q?G+QDjgwFSc833e4Vi4rHS8r0MZiArtZvdpnEKFgumlvE9hdK4aNl5F26tWYf?=
 =?us-ascii?Q?lZWaJmpT9HCZpDp5O2eOOGivNU07Yfcdtc/Zi7e3bF5Vc/aTJ4aW5K+XsV/4?=
 =?us-ascii?Q?jGZHnYObIi5BEgukbUfIJvBfMwAL1UXKBAQL3OWZh1KJ/k4bdBgwxnuGhi/F?=
 =?us-ascii?Q?u2LKdFcFaxNHfpw6hwKsVOdI+Ij1p7k2vD4QMw4ZDwCTWvJWjIF0pTiV8icN?=
 =?us-ascii?Q?uH8EvW7Pen5xEVVLfLM0IKWqNQGWX1IrqlSktHsewLETP5oklNfDu15Nl3dQ?=
 =?us-ascii?Q?7bY0bjkZF2P2oUDukQbsgKvdh3cX9I89cA4ni3EBVBgaXdIrheCCkECwIFSG?=
 =?us-ascii?Q?r/7H71qgM1MTtjh3ZzH3DadjdCHvJMT3URSZGjqJcSHOnh+QL8CD0ZyNt/7J?=
 =?us-ascii?Q?kg+hTst9BxKCQ+8UgmfnRDkAn2QGljvS8K/WgkpO8UcfHSMYAZJSEYh718WZ?=
 =?us-ascii?Q?UfmJm3wwpRpkBZDBOMKl8egD/TgfT1F41JM8JYGW1bo0BiGDwt6IoYmvszkV?=
 =?us-ascii?Q?egnrvUkapU89rvvf3Fc9khFgx4hj7EwpEkmF8unE2NZc4xRVCxGRcMJJaUz1?=
 =?us-ascii?Q?Dll0wv99aAUQeSQ87KF+QMdZUROf1HAY+l+Ab8ZFbRxR+GsQpzqGHksWHM6M?=
 =?us-ascii?Q?fcOnuppggmmyfp2R3flg4rCi1Mzb6fGECUyxmQXd1rwhznr0k9znKXkvFhu0?=
 =?us-ascii?Q?yNzVgXkOv1roVEMR+2gXMK6Jq02CzgjeGDUaT4qML1+3cb6684LVJPDGzQBc?=
 =?us-ascii?Q?4axcVQbVCLihhfwEkCogiuigLIaE0x2WEHXeAa01/6nF0d7utNgtFyr+9HOC?=
 =?us-ascii?Q?T363b/Ugf9Wf4GV7DbpM2kyDPMm/HXoVoeFBvLNPYUYm29HD/tB/dQtxLkel?=
 =?us-ascii?Q?pP+sqJBURDE6W6r85JUpSDqmEG4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:49:08.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5afecf0-c2ef-47a4-0d6f-08de5f2407e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20757-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[28];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2EE76AF1F8
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


