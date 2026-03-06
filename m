Return-Path: <linux-acpi+bounces-21506-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KFhMUUvq2n6aQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21506-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:47:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4451D227323
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39B6E303100A
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748342EEBD;
	Fri,  6 Mar 2026 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNodDgfM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94991339A4;
	Fri,  6 Mar 2026 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826432; cv=fail; b=ZW4M8Chb0NGXPlBGohCsxUYYv2HaTY1lPQ/oIjJTGMNVi9r1O6gMmbD1tHKRxkame7GZSbldI/q8OuNswfJ7sHYxX5YVT7YDAU8pRML78B/Cblwxga8Uc4/Go20P2sz2dKNHrwOU55WgO2JcZ56W3cTX/6tDjw0RYqdZ9g00w9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826432; c=relaxed/simple;
	bh=ZjiyzKxlk1Im9E/BZFrzkl6TyqWIHnhFPJGiO32Hbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=naoqo4KnGmr1cKmSY6K7FqGouvHFIj36z6jw0fM3o2rugwSeTWelid7TkNgjOq0HqF/FVvd0h0MRyCv2m9SAsym4d3qIz0huqcDvUzEv0grT3+EY6438VHLkSK01YhxEss5nJ3jT5G513B6E+iGkzV3f5PBezP2O7yQQV8p72Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNodDgfM; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwFgPnNOB4BkIlrZVbbwgdLaH5t+UHLXQ9wjsyY8/gkY+YlSomVtBafb/1AQhEqP5HAX5lUG+JgNQxH4Ogvk3RnQ6OgvSEfaMIyeu00E5XlPZ1fvIWrvdM2ZJWvIwaDiYiE4UZbB5tiKbbhuLcIF2IcBObWOf8R/AMwzFTK6LpsavxsGvZqv5OXowebzpZmJvOz2XPJvnXkrsZuwD7q3mjib3d/x9xmmXRIOuG1sEz8Vakd42LgUrs/jIP04imQ2zpIM56scPrCRRHp5umwRF2zFaTBNlMCYsM9wuF2cyb407ErL9q+ZAv84fejr6Z12diZlBS6akZ48UTHU2E+3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAOKyXShYjh9nBkYylKWHu1KXaBbTK/7OaOjCLQk9Q0=;
 b=onGjsj0/bMCYL3K+kZDLWELg3MYbO7oEqisjUOSvqYbEREfy/KRT4ftzU7yhEG+0EdO4598M7xBQLdO6t0eqTejIBQS7T7QzTu9A/qLMld4QmAYvRfuG7+jfrpqsa7P3h5b7WZZ2VcvvE4aa9k+29u8m89zsL3uTjN2RY3+8VwqC9Q1wz38l84PDWY1iTt13KM+aWEs+LI00eY3K9vlu9WZUqdH2Duh+Lh+EV/nqlSDezY6urtAmpEwOM06k/XT35KKWqCmP/in6yXn+1xLNnsesu0asXZZhlCOPKexMzNHwiUJfz19UnNQT8p402Qku+y9e2GdPQGDFR1BLwikPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAOKyXShYjh9nBkYylKWHu1KXaBbTK/7OaOjCLQk9Q0=;
 b=JNodDgfMWheqBCgOHVm1Fa2Q1WwMG1TF2HCZohPNUYxIy6EbfKUIYVxERQl3GYnlqcin2VRDNFKAsU+g7fZH7xfmbvuVncqslygpHb4t6rlQsmEQTcig732412eF1l33xdZ0v0xf9gCgMl98G6MyPOtV+zwT2kC20wYmrt4yMpk2PUgdh6hbUhVlwkluPM4G9+Qyi37K8e6wuX0FMHhHqH4JJXuX3otgGcqWn0M/YYIQCZEMUQ4VjpLHaHsZE6RyXQdINI3FxnpQN67zGyaqj5w42Bd+LhJaOJ6FoQUCq3xxFphbOR0EkJ74WPlK7IxG37uI0eFM25u4tXVZEEEHBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 19:47:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 19:47:08 +0000
Date: Fri, 6 Mar 2026 15:47:07 -0400
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
Message-ID: <20260306194707.GM1651202@nvidia.com>
References: <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
 <aaspAx9NiXmtRg11@Asurada-Nvidia>
 <20260306192211.GK1651202@nvidia.com>
 <aastXbRlJ+SNdush@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aastXbRlJ+SNdush@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:208:178::46) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bec159-113a-4207-ab98-08de7bb9269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	op5vNGS5T1A6aiewlrQcSQBF5ubMmxIGLH3hfs8dqXenrfRLhaJIklZSiUi865vSn6Bvc7q7gNEUIiM1pob6x0njbEC+SkIebJmTdIAIAx5yPBP/x+Lt+uXZDgprLrO1eIh7VpgpRpkOphHdl5S/lFDRv0qEQiYymwXtvWuGtGpz2PM6OVE2S/t9XWyc2Y3bLjW1olOhZFg6sRc12qnrVxwJ2boi5YUpOa+4qVeO39h6m1HkCwigyyYY+ogjMQS4TyNFYl7z2PgQhjTLwfr3lSqqRIW+eQLmF0WmwfYhjA7tMmhNh7Wv11dlBirlECO419RFGqw1QGGpcL0fOutoICGRzXT24P4BWsU+xu65QKSPVHg+W4Aozs9TaV5yqGyOTTf6oUhbOGNmgEQcXie5cnyQeaFep/eJkadVd+bdg/6zZfckwqEtdv4E49+TH5LoUPBZpfXxP9IQ7E187ja23kjsJhdQf/MYHWy7fnK76FOCzy+B9DaOcZmACeUxQf5U4qtx6lSXZ5sL3vlyDx8nIo72MtvP5ACxUum1pg29DOzQ4p65sc2NBFC1zqiP2Xv/CV6kwLY9vpps7AV4bwAsAlQiS/92FUHcDxdLk3/ATMUIrJ0EtgPc7oNAAjTnWCPLuHgYU7kHSAaTUk7a8BZCCK/NN+cAnov1rm3vtPgA4bYK2rt+OqubeImAPMxFzvO7omMRmQSR4f0Mk37mKD/eHsUZu9wpsGYuCFOOZwUAe9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qARfTRHN9t081F62wap/drcJ0a/+NWg7n38pT3+QjS2AOFO/5j82op4JYjx?=
 =?us-ascii?Q?CzNHh0MxvWPBGA454b9iKH7h16tKmGwob+0N/wlCUOE2V0nXyKuhnywjx9NI?=
 =?us-ascii?Q?5ghpgitcfImKDAwVYf/+d0F4dJqqQOiIqXQvA8vs/JsyzJBjt+cTUB0uaIEl?=
 =?us-ascii?Q?qGiyWgkLYU+kg1p5+eoXYeF0QpbTXGJJFpMCPDYS01sYV0U6C8hZmoFwv61A?=
 =?us-ascii?Q?gl4GJmpaqIjFWvjP37FeqQBp+FFzUwHTqbCKRaR1eOid7zLbwxfCZ0I+YLx5?=
 =?us-ascii?Q?n0Us4k2Is2PogqfSUKiyntPzXH+RzHDeOZn8gYi2cCLDoD5JsutlzR78sgfO?=
 =?us-ascii?Q?e7B0zpoHTBoE9gwHAHcG/MCxxJd9RrKRvYMksv1lTCEB9TD00Ye/6e+XvB2k?=
 =?us-ascii?Q?4c3lyGxpOkSra/GZC6RT1P4ilEYRIUa4Na4wI0PIopkG8cVOKLgdFfmVSMGo?=
 =?us-ascii?Q?3RCxbvvQ/YuvUpOdJ2hKextieMvL8zTseYiJ6S+KqJdEjyMPU/0aQsc9dVDu?=
 =?us-ascii?Q?9XNK7UbE6Qxqt6L8NLt1EWQSxJY5hlNmCJM5Zp/el2ZSIZ0U3mdkbaucakNS?=
 =?us-ascii?Q?SYEGXeK7OdYYqCZfkw0ZpurZCVDnN2ll3KLceLuC+yTEGXUtlqWzaeAAwM6w?=
 =?us-ascii?Q?3vWU9zRGBiZUtzu35Xpvmv0SgmtBMY+1eIxCRO9kQT8Pj387eZfcviQaKmys?=
 =?us-ascii?Q?ALAdYegGD//9FrvajH5gRECK+R5JI1u8F/9UlIOcMfIkxaASSPpqsrhQNuiY?=
 =?us-ascii?Q?glmqUCuKErX/YqxSw74tFyBIEJgfjvukP3rp+XvimfajRGF8Y0qnAzrDsWJ3?=
 =?us-ascii?Q?jIGgF3h/cc10r1c9j8VtgempI9lOrqiGdnqiHlMlDgVCMoTCFp+em0D/mTiH?=
 =?us-ascii?Q?9wHwIUJm7N0ZySCVHB+0F8taG3wAGp4B3pP7a01KP5yrr5ZxbSihLT+rgB0y?=
 =?us-ascii?Q?P2RBPzfl65hJRmDGs+aUQYjDANKKrTPnyJtfOL/Pnd3RgRZINzKntIlNGeTD?=
 =?us-ascii?Q?ah/HxkFlmIeLy9AyZX/il3+mCqaLifGuNS/0xhNpFljsDRu9QQmgFYJ1iJko?=
 =?us-ascii?Q?uF++58Vwn5T+qEUARXTmSkNdMuPE6ySwtQE22hA1Z92nFL46KGP8qsEEtB5l?=
 =?us-ascii?Q?cZZ8eXgbuPjAkVrF7XKSWGP9EKtohvu58yE4Q0eqXPqs2KfDv1rCyzh6RTvO?=
 =?us-ascii?Q?Z2WdB2g/q3SLdR9Q+er1em4T1FqVXW3HmQJmV/O+8MXhNAra50VtzNnSwl88?=
 =?us-ascii?Q?36X63uGMuVeCAc4e0Zd1BPgtincFf/UbWbf1cXURJmms/1Sh2jK2xga85WSj?=
 =?us-ascii?Q?iLTwuqkKpp9mcazjY2PAehb290BIsOgLPi8Sh/PlmsBp1LjaB4mJ1z5Ts//p?=
 =?us-ascii?Q?uJA7QggZJxPepvx6d1DIy8Uxdqpnd7GQcST+/gxgcoKoAuaGRD4dxtmku2xT?=
 =?us-ascii?Q?Eg7vQRwRZPePt6+mub94SAJdYXKKhfBojUeMIS0F930+O1Om7vmSY72Q+w5w?=
 =?us-ascii?Q?37OvlG6mJC2Dc1uX9evp5svSzTj+/aa3/iLYWVVRAdhco0Gans0adD6b0YD1?=
 =?us-ascii?Q?T2x0ypkLM6kcbgHP77O+rf47l+kOM2anxVwI26VGbARKrzuyuDmRoK34Rep7?=
 =?us-ascii?Q?6mavTbp8RfE1AbpK7iVspmtg1g8XL047QkmidJf9yzVw1msluIAviBk4yd3j?=
 =?us-ascii?Q?ahuVmq8N3WasdtO90LVB/BxPC2VKKF3b45UBOZX8HN5hF0WOc48AgyDcahRP?=
 =?us-ascii?Q?gXV36sI3iQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bec159-113a-4207-ab98-08de7bb9269d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:47:08.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS79tdkCWc5lg5YDIvmHkZRJsauyCedX0CHUSYqLH0PwwG+u7g9YM4ruQfpPQQuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
X-Rspamd-Queue-Id: 4451D227323
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21506-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:39:09AM -0800, Nicolin Chen wrote:
> On Fri, Mar 06, 2026 at 03:22:11PM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2026 at 11:20:35AM -0800, Nicolin Chen wrote:
> > 
> > > In general, the maximum users count of an INV_TYPE_ATS would be 1.
> > > So, an unref() would be sufficient to mute it, though it'd require
> > > the unref() API to support a mismatched users counter, because the
> > > PCI reset in the WQ would block ATS, which would try to unref the
> > > removed command once again.
> > 
> > INV_TYPE_ATS_DISABLED could be made to work too..
> 
> Overriding the type.. hmm, that's brilliant.
> 
> Rechecking the unref API, I realized that even the "users" in the
> latest version isn't atomic anymore. I recall that we are fine to
> do READ_ONCE/WRITE_ONCE on an int type because invalidation array
> is serialized by the asid mutex, which wouldn't work either in an
> ISR or just in the arm_smmu_master/domain_atc_inv()?

I think doing anything from an ISR is dead at this point, you'll be in
a flush context instead

We can be sloppy with locking here because the goal is to
opportunistically inhibit future ATS invalidations, if one leaks
through because of sloppy locking then it will get handled anyhow.

So you can WRITE_ONCE the type and READ_ONCE from the merge side and
that is close enough. Just document why the race is OK. We also hold a
lock around the ATS invalidation push so maybe it can be fully locked
anyhow?

Jason

