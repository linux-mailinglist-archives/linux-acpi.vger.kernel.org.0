Return-Path: <linux-acpi+bounces-21493-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ISoLrbRqmn3XQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21493-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:08:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2C22160B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 14:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E82D73024A11
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A82E7179;
	Fri,  6 Mar 2026 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mPaF62ty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF272DA757;
	Fri,  6 Mar 2026 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802012; cv=fail; b=I7Vl+pqeHVJlAyjGJAKJp1sdw7Dz6+PT9zrOqmDtpuqbMMMDOnI80lfB8bPFUQ79jZh+dmODra8hRgGsUUb4O5E0xrx5pXBp9OqxxmgNZm4UIgeONhcO15+hqWmEQpS1XIzQ7h0q5WEYM025hyw28RUetiMoM0V9wxNc8fYJOtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802012; c=relaxed/simple;
	bh=P8nMX+L7MpY7ICYB//TUczTRaq0rIhtAHdGpAHcEVKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mj1qASqDsUraaLg9UoCa0ZS2eneuXImeOodkU5UV0xQo5V5Q/m1FjgETz3khrlakLnIksQETfmEI9yu78/D/R/sW45MxIos2FCTLj/HjkMTdmdzry/j2qEb6coInFM44Reb4MBGkZScYxVimdmMp1h3RbQsOgM3ySubu5AbKM6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mPaF62ty; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi/4IOkyJ9Uzg+TpRIvRubyKkGg1GA0dq4ExvMhohZXCqUonyP1uf8k2TGGTyl38u+ljQOe7ONrEJVjqrHl6DU6qq7Ag9UFCH76dY9RvH2BidcLzD2e7bkq+zB72ezUlRG6hnt1SVIu2h1KNd77IiBY3WH7vLhrPsucBF2HHk4PoAjJlYlaZDV6fL0iqRqWEaLHWrGjekv/QtfLx4neQM83ft0uIef3PQU8PxkrC/qPgJCynOpznJoiUDmJ3dvPaSN91XP58oYKGeZ1SRyXvhWw5yhk0W0cZ8byu/AXeB81sGvOqxIVYI6smxO/7zJAoavl09swESGS+XsHHXEA/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8nMX+L7MpY7ICYB//TUczTRaq0rIhtAHdGpAHcEVKE=;
 b=CBKymy4ior8yuuKSNvl2bdoCSx1NAH8TIikVPa6CSrd91xY8sRjP9a1/mC3bZKha99Di7+Ypyuc8zPH7a6UJHPuW0X37vKc4ker6c+y2ChkoDIKjGMMkEiz1oe4Ok4VqMPcc6KzAQlDH/FiEhmbWJX2OanZFUXAifwEoCQVPQHwqe3d0iLzaSmp7T9bKk5qUdrZoZ9vukVWA6qCM8NE6G0EYdPY33ztH2Muxe9XwizSJI0DF/qAUZagdX3BdillDtX3jKXIbZvFUqeLSW+JtvrgSkLh4iW4L3FotLVhQmlPBS2OrrGyskJJXXthbgDjGfVp+yTiOR1KH2K1dSWPQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8nMX+L7MpY7ICYB//TUczTRaq0rIhtAHdGpAHcEVKE=;
 b=mPaF62tyrlkgImYgvXFZX+TRJXL1pPFaF9vQ/ZI8uWQ1YTke6C36EoVUvrUOoGMO8pqsd3h5h0stllbs1dZwGOYRxW/jIhBJ61LcHi/UnLv+N+Jh1EIyzrh+dh4co39puy+70eRcBmHxk4coKUspE4uHVrv3pWMxQ0Sanryk+MV8xEpc1KFA/GglcldN8Y4AMs/hF7q8hSA4IM26RUvRaU6W6sBH9Hf+QuMMG8wv7Y3UMaAHhZQsoBPcqw9U01bGD2T5b4b84oCWcuo5cDgXFUjhR/Tx4nN4tfU7aMrfBX4LUtG7PhBPkR+LMYi+RnR5NwbJp6jIIcRTHNyEdPi5sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 13:00:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 13:00:07 +0000
Date: Fri, 6 Mar 2026 09:00:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	rafael@kernel.org, lenb@kernel.org, praan@google.com,
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306130006.GF1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
X-ClientProxiedBy: BN1PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:408:e1::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f5426b-5814-4e2a-e23a-08de7b804ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	++ZfiBMaRKdh9NcJ6hdoTIrs4yUWTzYBoUC2AI1UzoGpEzJLVXZ1pFdz5Eba2c0z0e25kWgpVZiNYZoHEKScy+45OF9IUuqDy8gUaxlfRpoS/zwE2Nlv0CLSjgbN7OuhLpmOOvcrMN+5KK72h3Wr6yYiEhcGLVEo88aqAKgNw8B8kmIR43vtJ9Cbwb3GgEWO1URNmAEJ4tEJ4k0EEXNs0DZ4OueWeTxA/9Znfd6h2abl8ByTlx0xYtmdSAILpUOEZvvO3+Uh++SjBajDKOiS6FZN3XOzblIlDTrMHuyX0PQnc4a9YKLi+DFgO0rNraZVzHS/jDFM8+oI7KriQrwolJVZjTg4LG3cwAsfMya4zCsVOIsFHQP6VgETK64oxwYdXlWypUKiOSZrsVInI+objYJe1sYkIKzaCge9S3EZEa9sYtknGYUWHjESc/G2VzZu32WjidpxmnrBc1pq/Njv/Vx9TyLPJi/qpWOUIm60dlJOo/PrqXpgvGB/D+QFSk/dNpDqE3hT53tfZTa/wxuqZTsyCeNXCsNxqeFQKeg0nm5NyqBkrjWk8bWxZlWnPntoK3I26LsEJ3RnLuK7hAk6s2CVHEPC9x/hZbIfUNUhmjr0FnHSTM1FaKrmT/V36P6jopNyhUIDfy83ElpZ3i9cVu4GatLRfqE/MBZZ1aqEtakeVlvQ8wVaBZIJ2ajvZr+Szv7xriVoXjz7FqChlBpRWSj7Y/x9F72Es7o79s6uKP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3lzS3i1DxHUZPNMxrMU5HwGlCeyjnW/QdOM6OJcFBkoA5lTuOI4fdArTstuR?=
 =?us-ascii?Q?4z22N5nLpeY/60fF5T65IY8iHqvq6xu0cQHTwvwP14FQsYsHeicZGinC5tXJ?=
 =?us-ascii?Q?gTnhlFduGNpeZMWErXm3H0OTDUCDBzZEgxcpecrIlgF26IPv23Dkg+NDwf0H?=
 =?us-ascii?Q?JpJKaoK8sttsjwKYATuhM7uL4Urb89LJu0xBWgU2SxA4NAOdG/Cy0+arQ2gH?=
 =?us-ascii?Q?QzluyUuFDwqVXqRzgr3EIebUbw4dg/fpstpnnIqgBQfpCa3BUN9XmRYrjbg4?=
 =?us-ascii?Q?Hk6laBPVtHKu8J49+dlqWSxCWgby//mqjB0n5GIdS3chQUI44x2vnH1XEuKo?=
 =?us-ascii?Q?5VxPitfSxTadNaSQtXrBrlAsBDol9nf3h66rl8HuWkAll2+gJ8P2aQmviRtx?=
 =?us-ascii?Q?Y0ok1Sag1xcNIAb992QSBQbrcKPoQLtWQnAuIUu06O3Oz83KAc8xFWqM2naa?=
 =?us-ascii?Q?PaWzlsrhPKmFo7uEiH6MC5WCPOIVmdpq57ta2vfLaqDiiH6DWImoF4QKjXit?=
 =?us-ascii?Q?aKO8C0S1M5hBJbSI/XDAolvwOUxskMW5yiIaTs8vnaFrunGGeGqoT61Uff2Y?=
 =?us-ascii?Q?DKrjcBYG6gLPSl0kl0gI93DGHjdSKqpXDUnDt+IZYKRcJXrfIRPPYHfJaEgc?=
 =?us-ascii?Q?hWM1WVpPh3Tab2Idw2tTzv0rH+GQHgDbTL8Kw/inwLY3wqsSbJ/xTdc00LVD?=
 =?us-ascii?Q?F0nMM6pVy22Uomny6NB5os+qVTLtbeLfdk4BxlT8kuPcwzfRnHA862/hyreC?=
 =?us-ascii?Q?coJxTNnmvzpZ6Xlkmvw/cfSqJs9KoHRQNUoIZZ+CVxbZFQTJnbR9KqT5IZU/?=
 =?us-ascii?Q?Fp+PKIRFaWxvnXgkE08Ct467pIBXd4+Zt3fOkuuoAuzWnn6RK8Da76HUoL8I?=
 =?us-ascii?Q?jlxDb4R+BYaCNsILaa/sghEPjQDgxNFaSJ74cu1ivdgLTvC86xQKZ20K2AA5?=
 =?us-ascii?Q?8DabPGzS2CLtTxRqUwJjKztsYsORIlT41P+8hkrkrYijilRHDi4Q6IKvauDO?=
 =?us-ascii?Q?pQTJf7IiGyaKcV8fREhelbxmk+3iuifbOPqn9qv0GUYXGf5/RQXidsHrMssO?=
 =?us-ascii?Q?FBOqyye+VjDRFxVwGpUonPRr2/lNXp+PHyiA0nH6qy5+dNDFQNmwDgZm8LVs?=
 =?us-ascii?Q?8QsZjnlmoLDvu28U9RkJGGULUrLXEqMe4wrujT8VdIhJcF6cj/z22SPQkWcU?=
 =?us-ascii?Q?iJDxEn7/AXsYpiHhT+1szOt131T4SboATPLfLrZMKK8NV2+qquoT5nGnuZJq?=
 =?us-ascii?Q?Xuq9Ot4dK1ahk/3J3Sl4vR5+nhgsunhY+PYPv41PNHt+Jw22qIb1ib1n1Hmm?=
 =?us-ascii?Q?mxHfHaRnbVbW7Qmglp4I2fiNChB/n+Ps76tJKtgTtaB4/IxQXhJhl5g5BUbt?=
 =?us-ascii?Q?u46/9zaSB573+XpEez+YseJdtwLfC7IMCZaunMObetcU0Fgoy7RXLtgIFvKT?=
 =?us-ascii?Q?IVa5LBhe7QFeAwRChcpav6//uVZ7jXyoCIEutyC5G75dlDn7zdA5l+iUDe/R?=
 =?us-ascii?Q?rKjeUMDJkAd05mSr/sUVssM07IBr81ZakAU12+5VSr/tKdWV6iA1NGlwKj9Q?=
 =?us-ascii?Q?Kt4evuGKM/aNfre9DjRJ+3ptrCQ7aloTjfh+TLsFAqjdd/iEzXP4EfPJg7BJ?=
 =?us-ascii?Q?+JxbIsjCFovCPmgQlawQJzgBCi9TWjVn+TFBnLrjJYTgLRip7KERtOdUYXvh?=
 =?us-ascii?Q?rnqmhHOKTOGnaHKuwtPjUvwV3BWfSPCjIniYR6dYLAnU3vsUwbwtjqrdYWPh?=
 =?us-ascii?Q?qaVdiN/aeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f5426b-5814-4e2a-e23a-08de7b804ad4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 13:00:07.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZjJ/KFh6+zKhXG7RFrbOLDR0wnlh04wlHgE/ssggWKebbdx6LxwfpSPqji2qDC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510
X-Rspamd-Queue-Id: BCA2C22160B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21493-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
> I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
> invalidation timeout is a generic challenge across all IOMMU
> architectures that support PCI ATS. Would it be feasible to implement a
> common 'fencing and recovery' mechanism in the IOMMU core so that all
> IOMMU drivers could benefit?

I think yes, for parts, but the driver itself has to do something deep
inside it's invalidation to allow the flush to complete without
exposing the system to memory corruption - meaning it has to block
translated requests before completing the flush

I don't see how that can be made too generalized since we are running
this flush stuff in irq and reclaim contexts, it has to be very small
and targtted without memory allocation or sleeping locks.

Jason

