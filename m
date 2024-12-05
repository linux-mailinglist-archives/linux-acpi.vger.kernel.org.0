Return-Path: <linux-acpi+bounces-9963-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9D9E5FE7
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2128A1883E84
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26611B87DA;
	Thu,  5 Dec 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sTKry3Vf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1032192D69;
	Thu,  5 Dec 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433550; cv=fail; b=OVVieCFHsFay11ThxBySz17F2gk/HlMdOlDWP8dgbOeDxAlgyB9rC8rAcIpgdWACvXg9yXhChTvag2UnszexAkp41HfQ9vMdKmW2H5QEjJ8mIQyXTCtfKmhMqOxNRUvo2mrkSjXNvkU1yQoJWo6AyTuz5qe1cNOTxXpsD+pLFcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433550; c=relaxed/simple;
	bh=/IgTeWnF9/eV9kgO+Sv/RAVYg5bYskO8wcY2CliZFcY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nroEPjJC19HClhqmXpSrjoHlid6/pb4ugKTBcogcfQujgn8nsxaiGPMFeliwYxKhVh7SV9Mvvb3a9dPjndgAHWRf1S5MvWGTs0+5e7VhwA3Ej/iAgalximW7pIshEapKJlraMc90+bD3F91P8EDc9rdCAbZ4UpnrdkryD8DEkAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sTKry3Vf; arc=fail smtp.client-ip=40.107.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAyKC2ElbS34fE9AC0Xw3xLTM4/GIEPU+BxuQrutkmXZu4t5QYKDvZK9A2thjUjApyvcZP+SPQdGRZ6VZrSaEymTLxwjhpcBlsDEzGuivHpIfLE3G+iwY6DofbfaIOGuzHIp47DDrllXJllnVPSeT+aNcA88F+KGuxPXLrLFt0wFSVWBSZ8+jsclD/as087yKfkxkZ80+0amgR4vY02+9OT2AuO2lMIxMKZHP5ZChl0jag81b/S3TutcnnTsncxP2qJ9H8t9LHEGbqCTbVN+Doh+Gi7KVS1n9e0tHAmqq41Vvt2USPkFMFEcaOykkDdIucB9Ib727tl4UitU2JAE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHUcyBHeEBt5BYInYGJF/hN9D8Hc3tYYVVKaaIbVYj0=;
 b=EUdTnBhg03e3BGtxunM30ZGA5CEFW0aaJvkuDAaFpCCkB8W/m5Vbo3W52nGqWzEPlpdYO1nMobMwMNRMUm0ssKvZBLHnmkzWjgAFezEVK44pMCDk747ZyP+VDavGy5EOlZx9a81299699o3zLp4vERyH3otVAxs8pjYkV28Gn3sBY9K1KxdH3fdIgnRO8XuCT1DRAlkVxPN7kG09pbUa5GJcf/ovgKhjelnMNU2gHXVNUuc1mpeyJsRk8YzyGmfw+DemAK/5ic7iWLz/n+5iAk4wTbJ7SgSGGaHuzy/b+UpVA4xvIu0Y8VVhfJFzaGEqI7KZTfwA/SpcQzqEh1j6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHUcyBHeEBt5BYInYGJF/hN9D8Hc3tYYVVKaaIbVYj0=;
 b=sTKry3VfPcXpIOStFhZFy0DT/kvipnv7g4cfNSPbZPgtJtV0D16vEmzxlrr0aHIjULBXK6sAhYhdsmfIyNa6bcMypOG6laQeoC+BX+tD1ZF37yiBfnz7+NBSqYJKo7hMx0zLLTKQrPF/HloHkoO8oD123YmY9Cyz4iU/XSSbP9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS0PR01MB8004.prod.exchangelabs.com (2603:10b6:8:145::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Thu, 5 Dec 2024 21:19:05 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:05 +0000
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
Subject: [PATCH v2 0/9] Enable EINJv2 support
Date: Thu,  5 Dec 2024 13:18:45 -0800
Message-Id: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS0PR01MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: bccf9298-0e91-4894-0a9c-08dd15727289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOLMtYoU5mXuW9DhN+ddyE6oGNNlzC/ygNGCxIyDmyEm9SFVlLwlB6Jw1mo/?=
 =?us-ascii?Q?6eWRpMcbokyzFbCbPqC+JmS608NIW9+751rnodqwe9lauBxFc2KReA/db9VS?=
 =?us-ascii?Q?ZBrIAW3HltJToCcwV48aNo0f7sFtSQ6+iRJuUIlgfzPIKfH11N/lSzxczlWN?=
 =?us-ascii?Q?H3qJn9QOxima7t4YXxAGVdqcnSjxij0OeDyIgL9nvFAibrWRweGo+Ku5q1AB?=
 =?us-ascii?Q?CFeVJPuKyd0wN798QNkamu0L+WJvEl9Xqt/fbTXp0Vo+LVCvpdeDGSZRnpBj?=
 =?us-ascii?Q?nf2UvUM/azwEYNO3Pfck5jFVwktelZ4HO3Jjz4ngP4umnFIf/Lojc1x6X55g?=
 =?us-ascii?Q?HQir+HfojYOrzWpy9OMyP9DUPprQzKavLjet+FxlRSqKoO9DcLcI3cmHWfLc?=
 =?us-ascii?Q?VMKo4sHt7MKGm0GbAvRR5j5H6Wr/zjzhXj1KKCK3TDwv37Qkan4oWfrecwu2?=
 =?us-ascii?Q?irGzMPXaZmu5ZNFRf/fJM0NrV84hlfpdiPcOK0TyPDjpImhi0dnpyNVXY/QM?=
 =?us-ascii?Q?kry+tvWe2TrrPcFPTUnHLdHPSlr/FMvGHA4ypJVDrGB8oFzYsolclbEg8p3v?=
 =?us-ascii?Q?gkndnnrOJEfN+3VUXxEz6jovSqsSsZ+mP2yZanXZ57SzaJLKnTv67rzdy0TS?=
 =?us-ascii?Q?C3iF3ddnlgRBTYD+YjNzuhvLfVt3ScfPWaKrs+rMwuqmWrjzJjIMFyNPWnbJ?=
 =?us-ascii?Q?r4S8xaSu1NwghdUAjaUejLs8dtaQI229UF8TjZy1/RErp7P+UPxuueMCbvl0?=
 =?us-ascii?Q?i9zuKWjE13RYtD2n/ylOGbZxRHFNSOmhPEBWYYr6EMlEbifUl122+vrrMHG4?=
 =?us-ascii?Q?yNf35g4aoggnf2rrMzXTLcD1GzecbgsX4AkrxzexUH3e9VBvnZDsPTI861pw?=
 =?us-ascii?Q?y8XBdDRBKj6rIOFSjzF8SrknlBGx36D2w0dCACJHmBJelXyg6Cu3c7K6z2lT?=
 =?us-ascii?Q?xsvHSwQR9zts+0LQfFJXoKfgI4XkK+ofHmM2Gro3gjSfIA/4453OpaVtwt5P?=
 =?us-ascii?Q?pdWlyqBzYTr1oYjn/V1izdI6hh8srpViDYYf0ISH4gquPBJ6GQQac9Iptt9i?=
 =?us-ascii?Q?xkn/J7uTZKZDXv9haO5mPq2kCoe/w5Ve5g9LdU/bQaXNtukxV+84cNrvYasM?=
 =?us-ascii?Q?jGbkA13Fsl1tyGx3fjzc2SPx8ts1JTRLIJqrpGVxmQs6ILPGIfN/jZ0aHwQS?=
 =?us-ascii?Q?k1an2XQdeY/datryVilZ9i22cQDSxIGD4HstzA1q6zl9cfrEaS3wY+vWW2yq?=
 =?us-ascii?Q?QhUXmO8hp7wNkwL9YBU6lsCUklxYdrNre3pjA/GX3ERjn7y3Ql+1IAOl5fdK?=
 =?us-ascii?Q?2gpb80DuDlNn/PTIv+YlrKz5xkYvgzts+zxMrLvKMXRy7X13v61pYHcMhfNX?=
 =?us-ascii?Q?2n5/Mw2FzelEwKQfJKq4/LAxEUWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G82OX35zn/YqIK77u4FbE771XJcSWQmSJheK69OUvLjedNlzhy20+Rw27ims?=
 =?us-ascii?Q?XZbi+Qc6urM/Wpd7Nh4UPF/zJCFvY6Tc2lizn5r1ChvesjTlyFn6EZZ6vqVI?=
 =?us-ascii?Q?Yj37aXAmjEynUOudOY8k4pC4U8LZhDdKsvnJoFp5XgcpX54hZQIJ82cTc5Jd?=
 =?us-ascii?Q?qU0ibgiHJd1rEi0lCykClS7oZJj2po0xJLr+kCUJe3uTZDQhwSXDF7HnLTse?=
 =?us-ascii?Q?R2wqSkP6eqKLVMKjM0R/N8EUXgVia+LhFeJOUjydZj2M1u+JSlQNmx17ZlEj?=
 =?us-ascii?Q?50DEOuzxLDbOE+UKop/7BoxxnpDXRB7xYqwn9pchyDYMi26vHHqGcXFcL+ay?=
 =?us-ascii?Q?/SB7ELqFS6tSve1/INGjNm3uFhyyn5M284FZB0IVd7pohudyKs+RzR6su27v?=
 =?us-ascii?Q?OR3TSjKqn3YnyC1+KZ0RhTDP+hYeiLT+K8pebk12ghLG2ZNaljqsISIQNXTE?=
 =?us-ascii?Q?auHFQY0Df0XIeOYHkHQoAXksMiuXRXDNju68d/+HP2TOY8TRxN/2jr6j8cvk?=
 =?us-ascii?Q?P622/IwnfjENtxIgxMbncsq3G24laQvaaWf8cdsICtuoLymuxkgW3OwMx4x6?=
 =?us-ascii?Q?uOuRNA80J6ghOAaEXNC9loDd8zhHkUy6IkW8AQwDn+qwyyKr6IKUSjubJCry?=
 =?us-ascii?Q?LBk4YSgXHrXmK/Uf+rGBeV+sds+n+NJgqXKJZyM7HpgnzpXZxA5UPIvU6Bk/?=
 =?us-ascii?Q?dlDFLaIwi3CRKOtzyegqG45lt87sS39Qo7CkycKPYk1PTvnsnEOToPYujAoI?=
 =?us-ascii?Q?8Fx80HN4A0NmAsUea1wZoOftHLXluy/Zzi0JmRiBBf3NTRRRgpuBJfOGP96V?=
 =?us-ascii?Q?wzVBjv1l4WcW3fgBblKa6VTD/OsjFc2JzlSMe1b67D2wTyg1JAY4tqxmzOIz?=
 =?us-ascii?Q?n910JWNfTBn5Tn3KEybEz46pbAOnQHvnQVsjs2yx8hJvYJMvII7gK1SyjG+z?=
 =?us-ascii?Q?geA+I2nrYUS3ri2OJgAkwjCUuroWuNwdcl/vPwfpPIvdHavZ1SZ2NXMBT97y?=
 =?us-ascii?Q?jXywL172BHU0eJ7HQ9bfaTLiDthRc8U1vowLkfHAqeOHa2HxtlZVfftt39WE?=
 =?us-ascii?Q?9BUla7lu3lqm7urdV9MwzQPotssBD66CHWMPxRhlblQMyR4CP34fv/3Jc6/K?=
 =?us-ascii?Q?0fKHBAT3k1LavtWYi20frMQLNUeuN/jV+qf773h3lNjfE8LLprz+otKByrQg?=
 =?us-ascii?Q?kscGoDSlhPykmiqTUw2UJjycxh4WycmQEiTSbjoQ9TH5DnHf+5EFyGR1MOpq?=
 =?us-ascii?Q?qbtTerGxZ9ONuDt/uwnPRdoUalZggbGKw9xtgUtVhC7WnCuoPrd1H4FrvaoN?=
 =?us-ascii?Q?pm/BCQO5vDQfTN9ADdamNVIOmn2UEVTRxeaCuxD/loVQ7Nj0ZMSBfYwlR59k?=
 =?us-ascii?Q?DfnxfpdtuS8Q1DeTx9Axy5oKMwKTvqteSz38HXjhLW9y3lke69q9otWPClIs?=
 =?us-ascii?Q?7giv6UCLnK6qSJARgXYxbO4HCY5DGN+0QpXHQlcjU0cNYOMZVlnyHR2ryNH4?=
 =?us-ascii?Q?Arg94PlUOnbKCkaxQ5haeZRCPFofTbRxDK8lBXLEFYYmlAobzAI4ubpINzQl?=
 =?us-ascii?Q?dNPVqtnkZMslE2lRCOOsPnowJy+z+owKKwl5DX9UMU9jDbbG6sTExYIZSCH4?=
 =?us-ascii?Q?33HbbFhdMAGiSmNduj0VFy4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccf9298-0e91-4894-0a9c-08dd15727289
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:05.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJHTZP2hfD/mdLwCBOH9abYDq06rNfAT2GToW9hEyJJNv5o1meqM7ULt59NlNXjVxj1+9HhAWgApzwiSp5m9Nh1I1mnVu6MfyQuNRPJgHRnx1UrbKob2aO/F1DuDiqy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8004

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows the approved
ACPI specs(1)(2) that enables the driver to discover system
capabilities through GET_ERROR_TYPE.

Note: The first two ACPICA patches are to be dropped once merged in
ACPICA project, see pull request(3).

(1) https://bugzilla.tianocore.org/show_bug.cgi?id=4615
(2) https://bugzilla.tianocore.org/attachment.cgi?id=1521
(3) https://github.com/acpica/acpica/pull/977

Note: This revision includes an update on patch 5/9 to avoid
ambiguity between EINJv1 and EINJv2 error types. Also, it includes
an additional patch to fix sparse warnings triggered by test robot.

Zaid Alali (9):
  ACPICA: Update values to hex to follow ACPI specs
  ACPICA: Add EINJv2 get error type action
  ACPI: APEI: EINJ: Fix kernel test robot sparse warning
  ACPI: APEI: EINJ: Remove redundant calls to
    einj_get_available_error_type
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  41 ++-
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 254 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 include/acpi/actbl1.h                         |  25 +-
 5 files changed, 260 insertions(+), 64 deletions(-)

-- 
2.34.1


