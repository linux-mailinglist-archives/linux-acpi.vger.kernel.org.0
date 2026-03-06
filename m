Return-Path: <linux-acpi+bounces-21494-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMyFK4TRqmn3XQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21494-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:07:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 112092215F2
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA64314D4BC
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2782E8B81;
	Fri,  6 Mar 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkIWJqbb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519F2192F4;
	Fri,  6 Mar 2026 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802130; cv=fail; b=Q5sJM1GpJy6VdZxwgklINlmgo5UrRonUBWoVzeLcZOqqBLRj1m4P6WPLnQMzrgvFjoXsKcsQoVk1mAdMHeoqnNgpo4xq/De7VMCI3U5028+d6oos3hRppWcqLVwlHrIFMotkKhmMOpzBe0WNRY6nqeH9w1DnMcHXZgejiOxjggI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802130; c=relaxed/simple;
	bh=Jo6NERm4YekZ0at3LT6OJCsFOxaizRt7qMiALM8l4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDL4inL76Emk+EsxA68Bgpn7/R7LC/lVjXSOTqs0IjNAgCajEARYhi3Rgpgl3nPZNTzk/G4KvFH5bwSBEqv59ayZQXPZHQeln2Q3oeoDU8KCRclSHaJKZW/ICA/mGap690l+nmD/UBztJms/LKCfq+80mjIzqHmfjtrSH5tl9k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkIWJqbb; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvd7kANsCzX1WvU6tlS/iZe8RouVFEsX2nOKfKftgrUqtVr8Qf5F9huBfDICi/c17LATUL51JjwGHRZ1eVw2iW7VtqZdti7x8A72kDyqIEYmFrZYdCyIm98I0cvEEChFCbQpZgCcWQoc5GPRHHvWa2vSAJjjT+FwvbvDN8mePbagNqIHGKuwpViIKIEyBKqrf1rKV10aN+zzLJAUYHUA43EH8GpuvoP+Fjx2Rb0ZdlzvUBL79eQp6c8o9Fgw15UVTLgItTFDvTBDYXwocYHGGU2Dh6FtnXTrTyLgFhSzWfZkbuERz7eAr8NFmnwDlzRTKblelFSBqndeF6jjNml0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/E9tyt762ldiw0wb4KgaU3fiTZuMkIwb67C9/j27v00=;
 b=whVoiKaXZAW7geix24WGROO2TuosJwacd94RL2WHIgEsUS2pYG5oTEEaln0gLYI6f1zJOjpBNig3Zt9j3Av62sLpso8Zkj5ZxHwS8BWekeuvq4Rhmx9pX6jYUQFo+EitMg4BzQoHI3ueW39knQh5OBSGGeI6OTgHIG4S1j/FHljYR89zY5/6yhJpRi1/gQzggWo5g0XxSyOIirkN827cP8X5jIAMazwzdgbeywBHUkoRMzbuCe/zUXafVJX50VR6Jh9zqywaNrxtltDPW5bhafEfpn9m/bNQVDbTQ0urJmANzIpHKRw0Y2RX4AqsoGOFE3GZED7A3fuDdGqE8WDCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/E9tyt762ldiw0wb4KgaU3fiTZuMkIwb67C9/j27v00=;
 b=dkIWJqbbvGgZE2lDYLptFF9y3MdvDzoYzAbK6wBMCZqaMBzaIVu9WYh92Lpl19PIzvA1E29el2Tk1XYfxyGdLViPFZDTDls1yXjlEb9gFTNdw33AChcnHliWIFdnv5ePX/9RVFfjIFkZWsdGzaM6BSGuwDyb5V+tpVSnxXX+B7LRaCNObzUDeavs48Zxj+6/UJ2X0sCoATd43MdjZ39vjhuZ2k4iVuIarPJv4ptQ3yplsdLgHTCUIBYYfeu9h1TyqMMShgCqUuCiAQKiU9vOm3wS3N2n5bsuxTNtMY1dJEBvFDxLE+1sw2pY91y0WPA+CoJMgPF6+4OgCGWkpPCPlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 13:02:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 13:02:03 +0000
Date: Fri, 6 Mar 2026 09:02:02 -0400
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
Message-ID: <20260306130202.GG1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aapgyXadT1TEz29u@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0491.namprd03.prod.outlook.com
 (2603:10b6:408:130::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e12220-cbb4-43b1-27e1-08de7b808fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	L+oAxo5tnIfzVWgtQuQZz55VRVw1Xk3O3HJwbD9VnS/1E2DMaIRAfqgXr8sdLH/Qulq1xL/ORLVqs6uULhxX+MK5VPUvezeyJUQRLPde9uf2RNy+fkE/C1jdm9KjagML6MC4hHHN43vxpeeg63kv04jp9U9Z20a7fYBpiYb1GUliI6SHNyPRu6GZMXJzfXI5EDNJG0lQoIA4fWNscNuRwkBPBs9rE+5MVOFMB1XaFgMYa/e6Fg8faevT+w9xcKR3YkrUt5Vh1P7jwui2HUNKg9QuPfrfMvjMS5jxMTdk0iAWfMZGUQIIMcmD14cwiujjNclrT7NHhJ9xc3k1xjOFtczGgosM0iKVO9hPSV1qWoq8M2Z/Ic5Qr+Y7tqVq77cJPp9ddEuCkgyFn9l/mQREd9cwa6gkuBDkpKPbxesI0AWojVpMgVYMGwcMx0R1ucO8fCIOMFlrgIrKr6HFFGg6d1fh8pHYPASYZgYBfah/AEAY/+UjzsDDvs5RQIru646zAO5gqy/b5QlvVvlORp109XcQ7h5CrgI2J6sPxef6z1LwJx9q54nXEJasXZRpZOLP1X7jujxVNoG2LAKHTn0ptVkwQ5wgbgMY0Ce33JuF0dXnD4n60rfTYHhC0RH28/NJ5Rb/Tsxx3Q8zdw0gIcEYUR7VeKEbjslhRlh/ZHEIzXhzP4JKxuiMEtAwdAvBzG0JLH5mHf1LdCynyiWE2/P/q8mgZFuITrVBmmYNc5Lh49M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L35eQZW1Rscm+0gp1IMd/Ba4xlQmUes5VKVodKOskHdy4vNtsdiM9tZAKcTn?=
 =?us-ascii?Q?VgKjAcNwrYs/G4K9yD8cVFYYOKSF3JdpkJo/PzN2zM6zxVbSSk7/NeEbaTYw?=
 =?us-ascii?Q?pZrMLSA1weYsBux7E954CADSeSeLd3nz/buWqEbaqZ1awWWhWKIDbnChsemi?=
 =?us-ascii?Q?xDuD+OCLkAkD2jHtdiBcdEXZc2NcPhfiosjb8lPNEr7RxOP1CbAE1jBPHkBM?=
 =?us-ascii?Q?hvXHfwfaTt6w97BrUQQ4PDCQJ1FPqZdLNJIpVXcLvuTVN6Zev2eTflHeYhV9?=
 =?us-ascii?Q?jYBzVdtvW8b0JaxkBauh4tnjb4paAohXar+3eKyTUP84nzcENuQcZCpvifLH?=
 =?us-ascii?Q?dlZcET+lE2afwncUUGu9lLaECymNjQahU57aWeJSPJESLJwXlX/9AfDDs5ly?=
 =?us-ascii?Q?COv45QcbAQyl5jiws3CWwA9QKrfC80e0WgNMZkma09kSnqF11ZFGLEM2Nz1B?=
 =?us-ascii?Q?WPoPxRf7UJ5cyMWHTmPeMlfkp3FsHgcQ5AusEJxpbpPB/A86WsxnSUH0deEO?=
 =?us-ascii?Q?/jPModZtYzAlLOkbNuXLuckg7ijxAsKk5H86kZpHUenW6hbwz/oScwzNXBkv?=
 =?us-ascii?Q?GzTZXCTalmE6PWxF6X9GcK7He6QHRV6mrhQ57c9ssKH8OhRXiaDSfFQGkQnz?=
 =?us-ascii?Q?xMQMWPqFL6KT31Qhdcw8LqAVT11Q+vbrrEMaAdGghTPRUzdY5TzYAAFXOAbR?=
 =?us-ascii?Q?9TwK+4vQ1WIikMHfmLy4fwclEb68aZrQkSID/OMeL/ZZeQXH3ukDA+jG3yAL?=
 =?us-ascii?Q?vYt7mLur7vqOTziY1mEbiC/zbfKIHYuA8kIYYrzkBVVHQPz2JCQiVOXcwSWT?=
 =?us-ascii?Q?FJT0wyQrHd9NWnd9ZUTUlx1NyTksB7pIjLLUPLsOKAiyGtGtFSRyoqkNFOzl?=
 =?us-ascii?Q?NlSg0YDWvSAirmWdSrqXtHdjEXdCzUcdVI9z+9T4w0vnKyA4CvWQoxiI+9ZH?=
 =?us-ascii?Q?MWsnL/dshDG8D11X3m6cPmaZDSWZj1ah4t9xi4s/8z6A80x7FEiPSqi18SHD?=
 =?us-ascii?Q?iSft68PsewrhSyyA4XY3XICenFhVNi/fBHJq/ywBYZXziFaaFw0uvE7nEKNP?=
 =?us-ascii?Q?hCIBnP3zjy/7jhDGwVETzqgmJeeOGzoyNBY2PM/WnMCZ25I5Vh3R02iwdJaJ?=
 =?us-ascii?Q?qZrMsTi6XHgVOmHYo6YOjKrJ3yFXhT6edvn6Zz/EtrgPvy8JSaQ7fmujmY9H?=
 =?us-ascii?Q?dAE8ieOV97YINpsKgfpZ4nSsaeyF86R3L5huyBCxr+jHLZweumnqYVT9pMUC?=
 =?us-ascii?Q?nPLnCmgBnSSfvw7xbS59nQCcGhMmPee9uhD2tSkTmJ5s8AovTsAgm7vvPh0M?=
 =?us-ascii?Q?tjL5iV1zHjU25fHhMG/Ggcclw5vcdseUhxGa+h7SYj+Qiy5cwpE/RQQH5gNW?=
 =?us-ascii?Q?acNZKeyu153gsKfp5K6oAKnU0KbUTlfeFZGRrR+TrOtW4LppFHmqzD1v/69T?=
 =?us-ascii?Q?l6rEOuYn5XdbmyLTyqsysCNyeOPgjLaafs02WNcPXYC9A3vo6kkdAASgU+vd?=
 =?us-ascii?Q?bwTK7kFC3FODX27M4/VTAHTFXcpkhVqw9gaTALgNDB+MQP0WcAA/fgBZNa5b?=
 =?us-ascii?Q?zIivFyI1RXd9DicjnHx8sCRZxDgn0YOMWBXkdyaB1W9sA3YQmTjWaYJpDH6N?=
 =?us-ascii?Q?QgJoV2tJJwuyXLXQbSP9CazB03KWyF7FcYjjFb8+L3yIgWfwZYPrg5kiBLIX?=
 =?us-ascii?Q?cBFQ1VR9uJG8xd/YW9lJxxwq6yzs2ITg4t/67nlFSptqtRVaQwBJ124g4QyY?=
 =?us-ascii?Q?lQFxCWYQng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e12220-cbb4-43b1-27e1-08de7b808fa1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:02:03.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B32+ocDNBpvfZqu/Jwys0NixYx9+lUACEkPZxwSPwDD9vRisk8fT9YRIMAgsi0hk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
X-Rspamd-Queue-Id: 112092215F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21494-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > 
> > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > are also matched. Actually, at this point that NOP ISR has already
> > > finished.
> > 
> > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > cmdlist code that didn't harm performance. Maybe we could come up with
> > something, but if it works replacing the NOP with flush sounds fairly
> > appealing - though can you do a single WORD edit to the STE that will
> > block translated requests? Zero EATS?
> 
> Yea. I can give that a try.

This also really needs to go after the invalidation changes because it
is feasible to also edit the lockless RCU invalidation list from the
ISR and disable the ATC for the failed device too.

> > Also, will the SMMU start spamming with blocked translation events or
> > something that will need suppression too?
> 
> CD.R=0 can suppress fault records, but we would need to override
> that in every CD of the device.

That's too much to do from ISR, but maybe we can do it from a WQ..

Jason

