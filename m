Return-Path: <linux-acpi+bounces-21502-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DyKEHEpq2luaQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21502-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:22:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B8227041
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03DF2300DCD7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896C41C30F;
	Fri,  6 Mar 2026 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l8FHSI9l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD1371CE9;
	Fri,  6 Mar 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824940; cv=fail; b=YvVp+3XM3mRqKjLKK5px9nGtufKD8lGG71gTJbimOk1UPNDZ0f0cZumuBxxlIJDIFPUh9jhp4HP9Fg5wRyLWau7m4pQLha/Yuu46SINVA+tXWp8xKMpNURn8OOHwKis6aJQRfDfZ7+pYQojjC7CfmnMjjs332wNPlPf1Z5OnIMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824940; c=relaxed/simple;
	bh=D/HepSzZ++eZJItVySsvVlTM1s0RtzxUj//4iP/+7XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAXh+OptR1IdMy+WhPX6u5kk1/POZ+nHhR7Fa0qrQdcVbRMdrIOJnYbkgPETqE4/e2cd5iQ+QhWFb/Pft/ysXQrAmwA2U3dmqk256LdFnLkJpTUe4B2i5Oo9ttqDWWJl8XS6nIdvpBFgNu0Av7cy35H5ZXjH66ou2hGNIquO+F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8FHSI9l; arc=fail smtp.client-ip=52.101.46.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9iEgxgPzmBs8i1V+34ulAkAmYrxLXFPsl5lWOsEDr6yjydYu7titDovrsbe7ljb2AqsGljw0WLzw6cX+T5wRyJq+jDUMn1XIqrIueoEymIy4TZqw9SU/S6orEJ10t/pnUfuFBPw2F3fzKG1KohaE/e4cedGDkfvG8YaCnGwaQryP/LIt/skjnGnu/+04Owpz2sqo8oZmd8f9u9C5Xfbu9NZA22jhccNEmjn1GcLGWjwXXnI3DvaMKl9/eS4aqTTECNnVdq+Bbgk/pcs7tepd52Sz4IF5gfRBPmSTdQ7hjswViernBdEQVhX3Wy1S7fuPM71mdaJJCF/hc65+sifrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/HepSzZ++eZJItVySsvVlTM1s0RtzxUj//4iP/+7XE=;
 b=VSvlq8r1XpFKBiIgObSEVxVSg3RdrZMAAQ37MZLaj4JL/kpxd+58sCqgWdk6Om+It+Qu+cEIimEJosm8O761qvsytFc4D98Hl7JyXxYh3tjJvv+BbcBVh95xDeIR8zpNpvErPa5gwAtiqUt5oLWTr0+Df001zBALP/Iq1KricXhaWDJ+0+IFjWVtpwI67LTBQV10VaGBKjlPkgatABeM0cY0okHfc3TcU2XFubZYA/whEt+/xLmIQBNii8C7ZDkSQ5iCeIdctnLv/jQSlyEPstq1SJuSdbe6sgVvyK0nnHJkljxFaHVDE/hwM0RBKgAg4hHReIJq2sAdrjJATWpqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/HepSzZ++eZJItVySsvVlTM1s0RtzxUj//4iP/+7XE=;
 b=l8FHSI9l7s66OPa/4s3zWtuy3uzQa6ao0pc+/TO1d0iB3npUJCpgROTP1AgF0yNgUV3GHTajQ4tB9kxDpLac0bduZCAexPlrOhcxZ3X2/h7Mr0tA0pM+n2SsErj+APwcOXgMDPIbphU/FyEHcacY2a+0puPnHGbo9yGtJCUGMmLB3n4ZYURxpIFwTt25oghAECPsTV6e9UUr3ha+ph4bqGIrNHgRIGnqU0kb3YqiXYP1zdk0vMYlTCg3XKVTAaiiErM4AizSknZvljrsMEw+igJ73TeNehWPt/qmNgOeSSyaknnallFjAukyIxSNLxNBWBNiIc354TLuKLQmKojKzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 19:22:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 19:22:11 +0000
Date: Fri, 6 Mar 2026 15:22:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306192211.GK1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <aaspAx9NiXmtRg11@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaspAx9NiXmtRg11@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0868.namprd03.prod.outlook.com
 (2603:10b6:408:13d::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 1649f9cb-11f9-4889-a569-08de7bb5aacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	vmRrgfGIJb/ao87a2HbhrJK4N2knjclxRMRBBOOgXlQZVKM8Ne/1/qublzHkaYp1MyqoFxDW+WeXDKSrBlC1nlnBR3ewcHM3RlhpIaAQZOWLjMtKLcuJN0nUhM0ls37Ybh3zlCE/CyFXA24vxsEQVausAtIQDeK1xbVhhlJnUTT9z5Bkg59WAdOkvwHUqx421fYdkR3NqRm/a6t3aFE2m0ZZEU0Y/ztrN9PtjzpzHq2zJ9nV4RMKWUI7dsUs6AcUMH2ZVhENdl1wlqNKPEwI4EOvdpakIwod1vR8QiVeIGP2rA781mIL9uKRgOpTCa5jzyNim9zVIOp4LCVR3NmpoayRWpKvt24nN0yBlQxqMAjDQ9JrgdG/j89AeYjPG+JbmhGA6e9eS/v+7senonCnPzjNHefQ22eDtulTphKcIC0wH2x8yH2gtz0L/5c4XYFrYsdE2PivSKL2VRmx0WdwiH4CPyRCYVjwzwQTLrKESUfZQVhqMtH5YG1PT2ak3S3P+7YXTnyTuIwU7sFyxnGInN9TuqV1NQBSadfZyBr/OLBjTONX9tbI/eA9AYZf8X/bbRWYjlT44uEm3+VfDZu9ymYM/i4zL8xW2tBGYqdcvyKQqYerSgi0G8O+lCKdtHR1UfAnCG1b/zTOT7iGt3fxtu4Blh/vHSoQ7GgN/QOcCFwEQR0k+oqGw82Qrix1LRcBiq3d/UHNZ9mz9lul4i8sQONs5OSJGpNeqrWWYdq20/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fzugug8MVQk95bEMevzD5SuqC4+rdsro7T2kaUl9pnWtVZf/wz4NRmFvH47o?=
 =?us-ascii?Q?zTLRo1NEnPlca+R8wLy7kb4VSbRTChMdNv12zipMxFnr/Cc2d2hV5U60alC9?=
 =?us-ascii?Q?SXMWD27qczJ40Cugv7TqywA0XPd7RSKOLi0oWeDDAdDrsIpxwDcTjmqeEQr1?=
 =?us-ascii?Q?CmYnjU1ZpU8xP7lDZNjR+D2cBBDRwAB0v3OxhvLP9By2IU5uFPuhrClbDNDF?=
 =?us-ascii?Q?XT8qvsdBZRYKLY1jtELH/zNSoGvrpTCgaeoFMlS5Exv6CLl9tdYvLpFYDSCM?=
 =?us-ascii?Q?D1flV7sqSDkcBcCZVs34HmZyIZu0qHEa9+mkV+OZFeW6hH969bfNHzurHFFg?=
 =?us-ascii?Q?08zKSIxeFxLNWXX7+VuIshDn/+rKgqwSov/+cmpZNMUdcZEkD4VOVRw5QxPa?=
 =?us-ascii?Q?70y/nTzDfKhi8UreYWJSnvIOiHquTtbeuIXgyAzFBD5fWrKDh+7fHLl6kumV?=
 =?us-ascii?Q?3hIFIWzW9llO4CIJnlDdyvwy0truP2lStdJT3NgbGNhJxkrfztKIuaSK3MUe?=
 =?us-ascii?Q?cXxjjVQ2JIq+siT+X1qxz0A6fsd/8G1XYmR/Z4hCJ+8b4ladJAxAsExaVq+X?=
 =?us-ascii?Q?69RzrjRM4F6/X4PLU1b/dfC1FELQ+E0HLUe0XT1ql3zYLuS+eWtcNqMgAG+w?=
 =?us-ascii?Q?u7wiXjXywIo3WjmMX4uObf/P+rFBC1IGOU/ny89FIv1+4wLBNoy0uHLVtx0Q?=
 =?us-ascii?Q?ibVPlbsaKV5LKqbbmFRs6upmL1mKxMVTCfi/GQ+Sp4rsZxOX5q+lxMfiAzbq?=
 =?us-ascii?Q?KGWF6s6FLc8aqfUnQyYDckg1kZv1vpSsIYws4O/8y8YPdcoQDBwcLR5/PdWo?=
 =?us-ascii?Q?FNUJuc3snUuupDwDy+SIjfYPGS/Yvv4SvSSVhlfliKL+GOmO6BhTdGpmcH1U?=
 =?us-ascii?Q?F04CRS/UVeDFC/VQHNbWZrQSOCBXKXKMQ/svRQVeQt6d93ApWElRZ/V328cK?=
 =?us-ascii?Q?QA//RFW5fl6IHYc83DXDZguFaGvBUIHIToB4E1GY4zYfdvdTpzLpoc/bEY2s?=
 =?us-ascii?Q?SdbBCett37H3RC3x8iRvcMnEePQfyEivaG/S3gpRoo331+xQxkma46+XVHKn?=
 =?us-ascii?Q?TIpmKoq6k2N3H7m7A4GN3DmEz3AMmv1QqBU2pyTjVdozwvKYQNa6ZCow/J9i?=
 =?us-ascii?Q?xBi3c1/LmRk1MIvmYzazFwJnaJ+8xid7g4oz2mGmkw9QcdgkyEWFSCO3bOB+?=
 =?us-ascii?Q?wA1oTZTkGzesyieu0K6hvUoV4IqUOO1ZMKq5wwWyjU91LLZrkYcfZ3uuyp+X?=
 =?us-ascii?Q?dHybsldEq3tEzIQaTzyE/VajVnb8BdRQ2nKjhgmSXrWLjAH8Kh/2myod18+/?=
 =?us-ascii?Q?Y2od9ojrnm/+csXdQP13Sax1T5jHtaAC6mdVukBV3qBDcaOPmWzqVRlqhzF9?=
 =?us-ascii?Q?pYeqNXHBHD/SsXuyJApOwMAsMIRyHhyuk2ilVEPR/uN38o4WQieSsY5vbH77?=
 =?us-ascii?Q?wFmg91ZHor9zZkuvIauBGAyNcidra05gDt3UUcX/O8ItxGGoo/M+L9EJWqqr?=
 =?us-ascii?Q?7bwYgYiQi3OBr2P286r6Yw2/25eELtoPPFaW+WSdRPJ3sIHWzPUsIZxqCXzU?=
 =?us-ascii?Q?/GOtI1hJbpVCphth2XQq3keeGxDT2s2pLqPxvtrLFEe/RWOh9TNFkSOViSKD?=
 =?us-ascii?Q?uDvKqAtczbSCjzKbTeD0NmPmj2N7u0JPKEOFPjjynA5hhHlwov/zN4r+OhKk?=
 =?us-ascii?Q?oRyQdHBKn6P7E+1fMvNoxaQB+6UXwxmg+TrDXGz5CDVPGRq/Wsen2l72pouk?=
 =?us-ascii?Q?J83klz/Zng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1649f9cb-11f9-4889-a569-08de7bb5aacb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:22:11.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIKg2EdctwT7VG34p3HMxUYBCf4kAl34R5RCYqTNT7uR/QPYiSux3WxEE/XKkDGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
X-Rspamd-Queue-Id: D91B8227041
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21502-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:20:35AM -0800, Nicolin Chen wrote:

> In general, the maximum users count of an INV_TYPE_ATS would be 1.
> So, an unref() would be sufficient to mute it, though it'd require
> the unref() API to support a mismatched users counter, because the
> PCI reset in the WQ would block ATS, which would try to unref the
> removed command once again.

INV_TYPE_ATS_DISABLED could be made to work too..

Jason

