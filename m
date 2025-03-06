Return-Path: <linux-acpi+bounces-11911-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DBA55B0E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5328189437F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353F27EC71;
	Thu,  6 Mar 2025 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aCFs9z7m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38527D784;
	Thu,  6 Mar 2025 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304926; cv=fail; b=SSEQzIcKV4DPLmKsqHAO5QBr87ooGd9H/heZx2J6n3evfwPofsvgWo4hJf1grXS56YHsRIfCFBouD1gXQl6NDtnrAOcRG/41jqs4XggYlfftWIYzVAPEOQIVv65aAIyEfzoWu6hsHDNkx0saQaVK/SMl0beyOdE/yT/cpWwwvwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304926; c=relaxed/simple;
	bh=f/tB6hUxSMsb5unol+dDVD3DIC71wy1B/1Zn3kkQxvU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWXW+zXsH5zB7yd+DmWDMvEPTjo526BUL3SSJK04ijjh4+lhbHE7vYoshitPC21PhUW3+mpbG/Gacwl7tjcAwKCcnvkdTswBS42rHi+vLRS/yh6fs9NM7wzorRBNKUqn4JPWS6MZNGjFGVwKQ3pd5McFpDuu84Oeqi62LJLQFPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aCFs9z7m; arc=fail smtp.client-ip=40.107.223.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ8KXoO7JhvAKT6W7arm5itnhPUFQ/YyYj0v6dbWUHP3rP05wb6EBZ5qkUwCxMgKCLFMvPrzo5pPnhmTQ2DANJ6ESmsTBgwQbJW1gOFCNa6lA2OgD5qQ5S7kR8U58NUglA1S4wXqEr+RWZrsC9cdgGiceUwarmT1Wv5RO8Doav/M66gWIw3kwxg/3e6VDRW4Ai7oizBOaFiKlMUpLN9umLaRLT8LlI9L6YIyn/TyGu/TsyKzWIUVGapqBSAJiJCa9clCkzh59KsUemPel4tKxByUpL9NgWoOCnVJ/FXMgQlC/HuJgVcbmPRNkxn4+9bBPMXzgq6l59a05G4q+BbXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGQ69IqEZqvuTeGDSwAZMLdfbW5kVLPxSgZMODWhTt0=;
 b=GHMa4YJI7gsOXU7g1lxQOuFjeHcG81O7hwzUnZKU7B8Rv3Qi6puh9s5IpJcJi3JvDsBkh9jpUUSGN80XTrLbM20Xz2Dqm5a+/HvI56IbOhtkOJTZJZYgcUKGlNwrru/Rs8t68WBBrziAtlCdK/JuAdzPKPAz+hkT+yWaHxUvjLUMYMXfosiDlbg4l9vGk3uwLdC2QQTmwu9733DVZSdNzye4iXtxxr80fk62YwbCwiRWCAhpXq3MOur/T4imHoSBbzwYAENZjRyOcBPF4v7OzSjy+oaEt+8PJY9WriBSjrrH+/C7T/psqOfCNa5J+vC6nj8s2R20J7XyutMSnK4U+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGQ69IqEZqvuTeGDSwAZMLdfbW5kVLPxSgZMODWhTt0=;
 b=aCFs9z7m3D6lUS1mTNE5IxgwXOeHLWhRzHck53HejBPufsFH0UeL0QOBXYega4hINbOH0d1YroMeb3Wx6IGo4hLRS+JC4nf2KsbvXIsGkOX03s86MYndGpr7Ro52jMI/vvuqAzmP+QmAf13wKLLwZp8rMZlE5MN/xRZwql9WNSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:40 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	dan.j.williams@intel.com,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk,
	arnd@arndb.de,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v4 2/9] ACPICA: Add EINJv2 get error type action
Date: Thu,  6 Mar 2025 15:48:03 -0800
Message-Id: <20250306234810.75511-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a0acb1-6a34-4da3-9d50-08dd5d096c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3u1PAJGBM/aFzY10PPT+ujDiNb4qWM3YikxE3BWNGMA/RZ/+O0IBfZjH7OE?=
 =?us-ascii?Q?nEyAuyFLxWwvh1i6FHCEEasOYHaOWLtm9l1VHE2A797ffUuyIHGmvn6L/oW/?=
 =?us-ascii?Q?PXzNk6Un2jNde7EwT7HDXQZ57GkZES3EsY2j2/TM6fH2RxC2M23Ym68pkQtL?=
 =?us-ascii?Q?E5wx/5HYl+3RmvcbBX4sTBU7pLo10huZNmoTT+mru/MVln0f7a7/oGpRXTo0?=
 =?us-ascii?Q?6+bOZFCYSVrO5OCLj1j2iAIZHOZ7RStWAf0hcr2etl7LMG//ANVSbeuKKyvS?=
 =?us-ascii?Q?3oOtSLgPhS7P8FpIAaGVZAFscgqiywdKLiS+pao4hGipOsQrGuW4z5HP3f8L?=
 =?us-ascii?Q?vlFfVMcJMS8/xJJwrjD8osO6Uvyzs2GsGy9Xmj6iCv4/Cj6UY1nk9dqTU65d?=
 =?us-ascii?Q?wLTLWkPED+jpepkAtQuF1W998/ZLUU6RJooGPG/0mlyBMcP83GZt18MFqp8F?=
 =?us-ascii?Q?nMgLYBjbwuWETFs+rzbuamEcqa5Lg8/W3qJ2nq1Wjyk9+sSFhVdFH6ThyBlQ?=
 =?us-ascii?Q?47V/Iwp2lpa7Erd3dr+aY64kyHHeduUMGqqxUaMwR9g9WA4pfL7hDjnzDL2C?=
 =?us-ascii?Q?Tg7+UES8NG7rWAgcVHztCafzLLgY/yEkd2VIPgSzGKzCiLBOewTb5ZgH9sWG?=
 =?us-ascii?Q?NEWRJzDYDvqNIwPbZBAwsOndQgpfgvZw4hVlXo0+A5l8iGqFwoKi8EhVXrBl?=
 =?us-ascii?Q?20QH3gB6PPmEY29YwBl0x4I9Ilda8Bwj6iu2HKAImmzlNUHM8OGLkLXux03h?=
 =?us-ascii?Q?x57zEp33hqXbgR5XPRh5OAjHVdh7MiO4x7TKwZM/0/uWgL8D7rwYZbeq1JHw?=
 =?us-ascii?Q?68oihdZyWRf/eqCdJRj0mLkwZZLz6fIdOjoTg7Z+NXPg14GK7TUMln0BtbA5?=
 =?us-ascii?Q?P0d9T70778U53mXSly/psTJShEs1WHjb5XyZpt3sr0jBpv2vhDS7YDEh7GUj?=
 =?us-ascii?Q?e+l4owzmlpDqoOFSqnHSvwzt0rX3L+QEWCbN/cF83xb1Pe1YgTypjcJxVglU?=
 =?us-ascii?Q?eB95XO8IU+ZcAl+/wRwvChExBj75HKVhGNCbWxrsP3C0Jfa5INIioLE6EKZN?=
 =?us-ascii?Q?6DSA8iCA+4t50JoeAg+JKQDvINliBEF1M5vBYp+nrwDwVhm8aJrXEpunycpx?=
 =?us-ascii?Q?6HbuHEF5JqGNvLW5gIyj1l5gJpAyoK7BjQos9iLXnbFiLiAXoEWeddunOHMc?=
 =?us-ascii?Q?e4NCg1PVbKrn96hHMO6nCu0WFxARdeXW72qp/x7mQJt3GdzGDwFvE6joErBP?=
 =?us-ascii?Q?rOXepeh46dpGaCDKihn3YCobl8URxqj2TAo+EMwEJI7y2AID27GdkuPvElTt?=
 =?us-ascii?Q?8gWSSQid54eGFS45avaLGom0EyrMvFXBuxDFFEm0eFVyL21a1NadG+7+ngSY?=
 =?us-ascii?Q?01lFptP4u7SXUosOSB0jM+ltonP2Kwuwr6p/XT0qMuH5mvpt6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jl3CWsmBk4SkC8MQxnFnKyDu/IZ4Epwl9yNQ8iJeXoPDbhjKqm/8GbuLJmL7?=
 =?us-ascii?Q?dRQyhaI9gkj6KO9zICfH9DH/aqt5qevF+VmlnMr5jPAAeoHsLpW/SLjOusoV?=
 =?us-ascii?Q?blrWIinwK4VOnm0Oi9i6nAyI/I4g4wc10Kb7uWFLsTeQLDVypbdQZXyGkn0i?=
 =?us-ascii?Q?XuVCijf6Ir5odyVcAK8iqnZexq1WUJsiLJT/YWy18n/dSPg/ilrBx3CmuEDI?=
 =?us-ascii?Q?jrmjbA+miLnTqriiZbUAzg8T+QmXlamdL6u+6nRa1luTJfKAS1U0x661hPKS?=
 =?us-ascii?Q?APx8qXJs6uEgBN2GpWzOBc4QK0TfO9dxNndRI5ZUVaDuW9GhzWm8sy0KBJBd?=
 =?us-ascii?Q?zsQWxrqSQHv7vU52CgBJ5PZs0Phk3a8GzodKHqmudyXqLXOQAhW857bos1uE?=
 =?us-ascii?Q?krbVvciBIrF5fW+moPww4APaKrlQevNbjl2ISAfQ+rMK1UIrE0+/1nYpDQL9?=
 =?us-ascii?Q?UGOQ3QHjG0vY6lNvHrBU5cbaeGDIQ5LHpsSjbvyCL/fnUapcUyOeaI79A01H?=
 =?us-ascii?Q?nAmb8C88F0HadVs8oNXhcT5EGVLc90ZBkFH4JMpxENZMDICzMOoWpJQxnbiH?=
 =?us-ascii?Q?1TWdANtQ3wWz+i5b1QINEKe4dxa6FfEZXBwo3gozaSs6CJrLAOK801SSzAau?=
 =?us-ascii?Q?3wy65A2IYtGPVLUMbNUdXeScfwnQduMojZ8RrRWMTrEBTRfZfdVAeqJBYoxX?=
 =?us-ascii?Q?peBZTkOiDuYmyRZUSAnJCB4OGwP0X3Xclu7MLHWh+bMvf7ACz3oN7WAxws1d?=
 =?us-ascii?Q?mxWiYXaUCzpv7wgK9b8HjwVHxfRHo/jBxigr8/+CCXYhEoDyDEogDtAL3sjj?=
 =?us-ascii?Q?8TBI0bkJrUijvM1rdG+caQfFwAEyUXArDeXZxxrHZmsB5QrR6JpuJpwyaEbo?=
 =?us-ascii?Q?lHAvvGMkNGoMLGIKQ7dWvi5ZfUDMAWu+ZK9Upy4EgVnL8NpYmXO69OPaUSKj?=
 =?us-ascii?Q?3QrriSg4ZpekxZUM6HwVNrRjLCCrrb+Eve02Xxomwv8ppiOeLHvpKzY7962K?=
 =?us-ascii?Q?lo81liEcI1+E4ijTNRQsolg7YBca3p9IM6b0+v4mFAhbJXR2ZYVZfas+O2vt?=
 =?us-ascii?Q?4RSwnIS94u6mCoeiVbYpm7vHTXcmiaKcZeF5mlsgVgZsBglTn2hA5b3my067?=
 =?us-ascii?Q?aUXomYrfPbm4lfQ3Axwox+B/oB6aqwRLGuLEG/N5dPoLP02XNfzUCCBjVuaa?=
 =?us-ascii?Q?gNqoNlMFghlwxZ1dgCqhIEPh/2qWyGgT1wIrKQmNa8+X8BYTawSm1HIV1uYf?=
 =?us-ascii?Q?rJQc4W6cryT/tFU4zznPm5OuQ/YuKsTawNgPg2gTFtaCsmPl9YO7bI6V7MWI?=
 =?us-ascii?Q?cPv4S7Kmv5LoBU0YMZ8oggg+x4roXSi52pJivzABy51I7zicsFeVRZFDl+Ej?=
 =?us-ascii?Q?HQcGU6xoXvDLXyH5VAx72YNCJ+vOflv4y8lPho5+kVX2sFpLUd4Bs1j9tryI?=
 =?us-ascii?Q?YIamjou9uHmxqBFs40rIc+xrTmryvtYoeLshYdiQcOs97Q7bKh2MJ2SBHWuJ?=
 =?us-ascii?Q?yPTzJOqUTTnIvRCE1d8TThpXJ4vKHa+m7PMBi7L7p4hLqiuukeCrKXI5BwxJ?=
 =?us-ascii?Q?+gzTnkByUMUiednd9kqfvihRCDna/8qWlQZDCzUiuZVA5RV1RWjLJNdLWeYZ?=
 =?us-ascii?Q?xyd+R6uasC+KmFHzIU04DMQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a0acb1-6a34-4da3-9d50-08dd5d096c29
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:40.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yyc0TCGPb8N/6a4no/VTGthuEIGMa88x2qWcHvdx6aFnF+7H2FPzrQqDPrKs6ksn1xZFCZvmiT1D+IrTqymr33OemC3X4dI480ftkTWpzyCayjkl2dWAw7/wZBQAjSum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521

This commit is not a direct merge, it will come from ACPICA
project, see pull request(3).

(3) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c701c434976c..f52d5cafaf76 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
-	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE =		0x11,
+	ACPI_EINJ_ACTION_RESERVED =		0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
-- 
2.46.0


