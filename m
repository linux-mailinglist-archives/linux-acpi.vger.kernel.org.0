Return-Path: <linux-acpi+bounces-21462-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHErN+QVqmnFKgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21462-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:46:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161821978B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9422D3078EA1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49410369229;
	Thu,  5 Mar 2026 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWPFdqb1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487536920B;
	Thu,  5 Mar 2026 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754126; cv=fail; b=k2vGFj42hbp01ceqCA17ALfolbHjsVJJj+Ae1jL4MZJhouLy2kZAdU/YwAQHgIOU+2MWepNsaDbnmaNz9F2Wo64/SZd1rtFwW3Hit6W5+evyzYVKj6HcXVgE1cCuziMztJQhfUsL+y4XgDvq8dU19Q10xI98gNFi0aG3t5jfB5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754126; c=relaxed/simple;
	bh=4LhD7h9za4VdGznaZ1saIkiVOV/l3LpRak0K0hBBv3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASIkMJHaelnrO/Oq6Gds/RAJNqLyPGHQrZfgZag/PB/X013Rw8fkAXA3bunNYhaSJDHBtc1pXavrcFoHRM75QqqaT5N8r+8AWRq65O1KbnsUrE3nBiioT4T2IdRp9Zq+XQub/xeAWEqG6DudHOhN3JJCz2rMuqy+Tdrx9HEB5Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWPFdqb1; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5C5EPS/YJjcVq/11NaSuv1iP/HhllemT1aee9K9joWf6lv+KLIab55jYUCz40jT1XHecidMXu++QUlGP62bld/bVSIlARjDzGAbxDR/Rwerx8njal614JmfoIEqwB2b/iQeIVZ7L0nicwVkJLS3nbbcbz3jVkMeHl4yeyUKuMtgCfkBkA2jsj+ZDepeafmTevt9djVJDPrWQ4nOKYIg+a8gE0832ZaKP7mOcuJZP9vAuM4KY4bwMJyc7QbkjabUC2diKNjWx8gmHS7dBPb/7eIeVV/DGrGKwwy9gTaSEYdIGaIZrLzigreUIJMv55p97Ooy88ir6NTG0IUJim05+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whjQqNRb+By/48CNSv1PNH+IajT5oROh7oF0ehwZexM=;
 b=lE0qoHdwUbvncFdjT5nv59FiHDXgkrGi8DtRPYb+PYHG4PvzI0VONIADLp+X1D4EhKnw6rYzNZ0b109jj9QxyBzVxsFIVXU2cFFhy2hiNjep27N1ayC16Rby2Zlp+c3DGnVRvVoZXyQKKZdg1GTflcj7YXd99AwZDHrhA9JLmftVXcq9z+ttvRXhXuHUcnm80OC2d/EuDn6yzZh+gqvH7SPfbsYIWD5UbGUHXx45oqBsTDWUS/WSR36W1PhSa0Ieow0jiFFaPFpkHUtUuCtOZsFgM3ippGaq4rWpIWVOuEoc/BaIWBPt+8i1x6S8pScWLqju1xOTFOw2/znbhUk83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whjQqNRb+By/48CNSv1PNH+IajT5oROh7oF0ehwZexM=;
 b=hWPFdqb1V44SLKcobpV0J0vOdjj24gJ8G5MvvY0LbsZnEJKWLbk1gVja2BInVrefghWcK2KVTS8SvhdgpBp9QY1+8iQyFNPIfl3TPwTn5KihqeRrNW4/uDhKTGIZDTMjo7agQJXtDs6zaV9EoV6F4OP30q6XD6uT1swNZKFr1lt/ew+CmWmCDiNY1C5oBl9Det19REASBf5rsl7x0wTRcrjMul6jpEdTaPiEcVmUQPBIYApc4xktyMhd4LZbfTg+07SonucnkaDsXIfJg9PTJBsRs+wQzv9/IZJGtBHKGrK0ttjUowSuSpxg3arP9GGOAebbXEsmYkMlO6oYdH4Pug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Thu, 5 Mar 2026 23:41:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 23:41:59 +0000
Date: Thu, 5 Mar 2026 19:41:58 -0400
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
Message-ID: <20260305234158.GB1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanygWWZLA1htDdQ@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: c80bbce9-692d-4662-f467-08de7b10cb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	GRkjcwTGX3nEmlnzU9mDPQIwPVpsK5iic/eeb6UC9FdhY4BwltDNSEMXwFHPEet/iXu5ZR4+ZkZX4V/wGFbBIOZP7UFtacCynxPxoJALLKDQztt4Adf1IwAs73Iok7VxIeH5cUjqJreKzedv2ymegVy8qQYmjB8mDBie+QO/C7J+c6MektmW9rk8cMOa2vgo1CkFsMXIYdMOIZ3TZ7gO136SvWhvjLiaf2vKHttZkVZQAHT0hHQBot65rIniIHDrFlL4Ijtn0V9xRBl4u+lqMnbINjC2L1zg+lZieARiPrvwdGz9AOqIrAFzm2l65UICBxT/VgsIAPFtV33FFvsfj81wjBRKq1xZFyA3TiE0AayUHaeF1y5zygRaEK+CWIUK7+cjgjxnYRASu6IHhrna2wG8Or4bgTsRvUY1UUsXPMhmBtkHdXDsUMIA/usK8yN/J98itd51AqvE0cNhXuuC7n6mkq29SPRN2mFkSTwK556rNAMDGul2NPE1hE7m5Fsi4eKwNxV9D+0Bje3UsSDm3M1UUbr7F+xzRu3VhE8xOaFXJDLl6pIvj3zEN0J9gP0704GV1SdyNje82KndxRjpwt1DRipIizuZjz05Y7cTUOzhy/fYh2SbqOI9AdpjPfgCqbD8HK0XzNLhP+oPRkCQxrySdde+x208PpMuI0l2MFMxvu5Pet2zHthJHcuozGGlmLRyDs1zLbKJSbIw0Vjd1YVkrOVVtJjvmgYvUZLGaR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lI45jSG510VPWJVzeBQfYj12nUdeOAroLiGt9YF3a7oHH4LY31JhRmgJ8HE8?=
 =?us-ascii?Q?5Bs23IZ2ERAibh4hGXq7a3NFlaIQVY4pHDl7GMEaGPcgtLWIXJYZgNLDQPjE?=
 =?us-ascii?Q?Ge2B8HJjGcckq3TYyfueUnO4dUgTJR7T2Er6A7S3NOFniSXfdgnxxuFR4trT?=
 =?us-ascii?Q?ul9Zs4DnmGn+9xEUGq/GUCDn4fB8aGHH0ZgMnIu0uUFv8VW5jYq9LBPH48ib?=
 =?us-ascii?Q?aB5z7tZ/zbuz+J25w/5/Yr+Hv+iY+iaddYOOR7leeZhpg2856wWcaoIVXNr6?=
 =?us-ascii?Q?6j2JnsXRfHNEzKVZ9mwPn1xtkXC5mkoolWWsMuaeHHw/8jsvxXJwcrHJ3HOW?=
 =?us-ascii?Q?WrcnTTYFndfK5T1O6/cGeAerXjg0iMeDUBC9uWO5bpK4KBCPUQ+RVjFqKF8m?=
 =?us-ascii?Q?ACVpXzAl2wgbekcIKcCxL/ejSbtX1JA5xPoO2yM+Eihw+G+fMt8+6Eu1GgKl?=
 =?us-ascii?Q?iqUzl4OUFc20h6rUa79roHaiR1ZmzxEf9r/tu8NfTXUl6x5CRXB1yoYOyKKT?=
 =?us-ascii?Q?DeAMxgGTeQrEyhTIM3MU2/gxRWs/Y78YNk8OuSHlGYNocM9RbgQ3KIiEH985?=
 =?us-ascii?Q?wF7x7aFhzzXBZoxztcIUGpA40OTaEJl7dTyp2FnhpV/d0H8pOm9T4YcpnMfS?=
 =?us-ascii?Q?ELB/W8ssVLqlvIMy+LKdNAXi0EUBxVBQEf3soQ1yAPvx7mRm9bXi+fs3i7T1?=
 =?us-ascii?Q?3lah0wISis5iUgNNvQteREUbDcMOqAz+RAsDR90N+CFpSdCbHKKGubBwFTaR?=
 =?us-ascii?Q?xhbqfTsj/zomyrWWwfYbTG7hs56CG7/aAXxQ0MSpp9uVOp++pI2M+Z/n6DDf?=
 =?us-ascii?Q?ZumPzc8BHBHZIxAqJttGyHMx0db7JKK6tRXTZ4D3ywsQhuiUv0zrQGgsoPoh?=
 =?us-ascii?Q?iyWmDiAxHOl3xY0qTh0i6TIW42mJjAHQ8VMKUZ7koICdq8mT4aUFaLljQ+NE?=
 =?us-ascii?Q?kODi8UEd4y1FIZgNDwlHZgS5xOq135hqxhtFXuaERYkpdFJXY+qxYTh2EQOY?=
 =?us-ascii?Q?z9D/aDLh7iIrpQIAaEvizKJBPbxEqmPlOw3jdkqJ/MYt0eiaGBmIg8yfPYUc?=
 =?us-ascii?Q?O6wjXOM/rUIF19UUzOUFkBVwOBXWdtDgTkOSmv3b0swBYQC2/seA15R9jhFV?=
 =?us-ascii?Q?aJcQun81mkWbIJSbUE29gemqXpzDzY7ENnEDHaRCtaCCiWLmcazLglIfgLca?=
 =?us-ascii?Q?v8ZpCuEQWNABCHecRbor6/2q8enXiistFsiBxlTxA3x58B7rtfFAAg8R41Q+?=
 =?us-ascii?Q?Wqd84Un1bwH+m4YmUDjezZ8tJjgfEimD272R0ZTbnCxAyLrxwPTCUXBUPXgs?=
 =?us-ascii?Q?2GVBye88TbX60InhEZVUbxNpKaC1YizNAEXQ/35tIHz9p8tBiexeIYzglTbf?=
 =?us-ascii?Q?HrV6Zxskap05uG7QbU9rH/FRnEJJvgIbesZ5K6wAOL4fdzUoNoYzeW9F8+xE?=
 =?us-ascii?Q?8O4iZ7yv/FoYNHqDyZBUxUgmv3L8dKhnsbNn4g5VRPAPsgdRHDQxXf07Tpx6?=
 =?us-ascii?Q?xQpbk1L+yfVCoDw4uryvLgmc+0ScVvE7+r/Vsu+SpCBatMrjtmr60iDEMvAY?=
 =?us-ascii?Q?aLsvD4nTkwdqwadi+L1grMbrVsN5zvwM+Ya27XkA9RzcXBWtpVeFliMQFZzT?=
 =?us-ascii?Q?5CB3k8cL4hvjvgUJ0DSP8pCDoBjVckYLXbhw/8f3T5T6SHYJSuyR9St9nNEr?=
 =?us-ascii?Q?KgF/xZfNgJJkX6PDRrNLFspxrLpqHQqUlGYMMMaGl9W6BNKMU7C2ea6LK1Vh?=
 =?us-ascii?Q?OYphLOQN6Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80bbce9-692d-4662-f467-08de7b10cb4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:41:59.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJf0A3DjmcuS33WmwqSTZ8xEY9cTqnxDFuaVy/7/k9jdpaebqF7fI/at2DLuJauD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
X-Rspamd-Queue-Id: 6161821978B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21462-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:15:45PM -0800, Nicolin Chen wrote:

> You mean in arm_smmu_cmdq_issue_cmdlist() that issued the timed
> out ATC command?

Yes, it was my off hand thought.

> So my test case was to trigger a device fault followed by an ATC
> command. But, I found that the ATC command submission returned 0
> while only the ISR received:
>     CMDQ error (cons 0x03000003): ATC invalidate timeout
>     arm_smmu_debugfs_atc_write: ATC_INV ret=0
> 
> It seems difficult to insert a CMDQ_OP_CFGI_STE in the submission
> thread?

I didn't look, but I thought the CMDQ stops on the ATC invalidation,
flags the error and the ISR NOP's the failing CMDQ entry and restarts
it to resume the thread? Is that something else?

If so you could insert the STE flush instead of a NOP

Otherwise the arm_smmu_cmdq_issue_cmdlist() can just push another CMD
to the queue and sync, it is obviously in a context that can do that.

Jason

