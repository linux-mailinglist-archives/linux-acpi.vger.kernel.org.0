Return-Path: <linux-acpi+bounces-21505-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEDNA1suq2n6aQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21505-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:43:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 846002272D7
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 20:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A253029A42
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB742426699;
	Fri,  6 Mar 2026 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjlqkv4Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B2322768;
	Fri,  6 Mar 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826198; cv=fail; b=aSuOdluhgiry9ONS8z9B8d8UoHil5yxT/ZBN891AwvLLNma7JWN114tYP6bfF7KDwH71ak9C3leVJfafCZTiN9/cFU3tU4G8Jh1zVNdzCFjPH0fTx0NE7MKL77Lu7Dv905BllY9fqDdZAS25LWReDJTos/fLlg7/iDnElLgezA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826198; c=relaxed/simple;
	bh=yQ3aBflO6NEbasGglAgQkzcMcjgIs5K3dT7riHVpk/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fBafWj0ibyI5L1PVoz7PuwYOeCvBQ41q26cZx2/S9anh5ybfdXNB/zrw1tdAQUOdF1xpI2DHwF22/ciUSRXZwkoQJPvFqXgOH5LVT0sqUytRGZg9WevKBh4zx1+i+Sbu+cwaXg3DQ9qHqjHmH0n71pylocfkrjmMxV8TIfkj0Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjlqkv4Q; arc=fail smtp.client-ip=52.101.57.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9Iatxa5AgSlYWS3ckQTSsW9eO2vaaOtLuPISxBfCLVoyryS5MgyL8cvaO53PTDmVXt0IkOBdNScigwFbAHBX8swDTS4zdyzlrGxbY+2todcXnm698xYIXc+CJhw2FpVIiueCPXt1VXVznX113AOJ1rMG9ZZXwhEEIJefERgM7CjcZMFEiA0IXNtp0zmhvUQvsAg36nRRr0x4HxYFvkhsfOR4dwqSlUbexrvTu9//CameKcegbPEv8OtM+R0QTr0QSyIEvaIwCzgA47VSQ1oThxPD74WWRFR+pRV/bQXDK3OHu9O76+Q77HwwZO2bdt/cMv76hnsWlfGTnkCvdMfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u0y00V5NYgbi7YNW2P5Ejl5FaRFp4YF5J/OeWyeldM=;
 b=WeX8uWbFNCYmxfmShEeG8Bch9cm0r6/qr3xiwBWMvDAYOcAAT0wLb+X6J7Gsbvnb7rkAD1pSzdL6/d2D/DEf1AQJ9j66NBQPyW5bXodp8Rr4l0/8V13FOntPJG7+iZaXLq1yOBeK8c1GNxA9BAqjParN8uNBWgfZlwG5kC/nYs/eHkC4MgnZTglcooIOtoZ4BI4N9Bfl7Mpul4t7kKoh+p92C8z1ADZLrU2l0VX7lYYimkdhaBnbqlN9Dh3clrNBZi8JgJn74zEXPGMJb1PzMKdI+wuTMupFlvqboDdwk0cfC3zdAWVcjj3cBhuM3RjQNAdkBxCj7FiuBkd2pJ+ClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u0y00V5NYgbi7YNW2P5Ejl5FaRFp4YF5J/OeWyeldM=;
 b=tjlqkv4QpnVM+V6pdBPqyR33Qyw2jWwAcxxNXbzmve8eL+lo+LYD6Q9nFofT+60PLYEBKzxbcVGkvrOPyPwXFJMPr+vlGYCdZLYo8jgS9O3b45LTSLzoOIIq8dYfiSOH7cFqJ4WmtGBLJSQw0WzMbmCLuCmqWzfx9K6ezFMfu4PgomlGR9KbrZcEpfkz7Y4jmuSi/h5lqfA2Cmz2mghWSZzj2NfCseizSDcDDQaH5jrC+OeUJ9cz3jvO69t8yFdLBcTL8wdgWH+zjGC3fpSkX2iPPg0ce5z/t4qfPonNs9+jUYkWs49SQwpdUs5Z1L1r2g3Mqix2QGwzO+jfVxVxpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 19:43:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 19:43:13 +0000
Date: Fri, 6 Mar 2026 15:43:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306194312.GL1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasmWvA-sqi0KJwO@google.com>
X-ClientProxiedBy: MN2PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:160::38) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e104af-a449-45a1-9273-08de7bb89a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	GPTsKL8hkFXFK5vFoHECLPt/DBRCr0jP4l/Ty7HIcMJRt+ytCuwdujERqJQ/vsZE79zoUBIGf/DPS9rMa/v2OBECRCagExM4rzK1DbqUp9zxacRZxcNfoESmYg3xZKqS3WKrZhrJYrpnw0Ge9IKyemnswVTgLRpgWmml6yToTR5Umlos1wLZt1EF0G6ukN5kf2hgsYCBGDJ04zt7x+h7SOV6M/neeHZ7cWgfPkXNLSJXUvTasnwHz+t9a2LV7qkM38VcDB3FzoPw/oA0vfVp9vtr5cOqB+Y17g3sHqyRmip69+jhh3oAROAC8Jj+ZzI25OAR80vVRimQkEKgvHi3dyQaMM2klEG3fegm4nJ0aoga1u1dbVQUKVSnj4MoEHwAlwQpGRFGg4TAMDPCiEmTT+njDXeIGRf9j6cBb+zAiqgiLEcCtY008fu6Lg96+q3hBPmMk8+xJS/kLvM+Us7p5iISngsCAa7+4Mp8gOSkOqcTQ1JwYdIMwhM5V63q+XngRogpQqNf3RM6S4P8cJl7Ts3ZnTZHKasUeGXrLpJ4lJvRWIT15aIDZvC9NyiO8qrIUv6KmkohsAMRFSA1GIKS3B6Z7rP13d5raP/C2HhcFPnh9cEXY/VnCXDAFl/DEXrNDAcWpK5mZdFNHRwzgbDjHCt0trTFArlwbIBS82FY3EhrA6kmCukMhX5uBBxe7XiZyoZbYsdtRaQTq9v97rTCDYcRwsN+Xq1RqXdwd+1Vjq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rgprLKSOygY/bkiZfsb5+w3STGeXMsjSx221BcPUwNQmD/Z+up8h4prfgNeK?=
 =?us-ascii?Q?LbX1vmna/guLZ1e7yK74UrQ93ht0b+uNGzpRqXPtB42fCf+DPQlEidNIrbGg?=
 =?us-ascii?Q?6HgL0BljUj3286l/MoUSm9GHWVkhJ8nxYF2wvrrBRtOp9rw9NsvXHvdrFFtF?=
 =?us-ascii?Q?j3LNNeKMS/CyH28wXPmnCYe6KOs4UqLqDftxMcIeN3u9Zq8OJshpvNxD8c7t?=
 =?us-ascii?Q?o/MgSLnCiySUgs0SQ2lfQtxOtNUnxcINNysmytEvpUwARXlbvUufBYyNwWvf?=
 =?us-ascii?Q?CtB7l7JYktHsvtikPf8jmFhVBcUZoMTAwvhjnvOz8Ghw0V/Y9BZbmTfTm9rN?=
 =?us-ascii?Q?VfHg98Jbwr8pv0FkXj8+ArtsdRjlUEyuiKHSw/XQ6nb2idWUJTZbMLvljY1d?=
 =?us-ascii?Q?xjotTTmcAYG8LmJIYlARic8aXgNUu4fJs1aJ1GsSx/K5deyAmX7VERLewKuc?=
 =?us-ascii?Q?p7mAyZmqWadokGKc26sH4vXRf6xKtsOi5a0VyK/CBOP66asxU0Kw0wm8KTfT?=
 =?us-ascii?Q?F0uoeuEjyerx3fXjVKncp88mFGGbcDIDcd4rh/rBnd2Uvm2fPx7idjW5rjp7?=
 =?us-ascii?Q?TDNJ4EEVr0I2jtuIH45fZQ8XQfLzElYc1G26YQczNN1K2xPAzy39a3win/jp?=
 =?us-ascii?Q?TFH07HVHmJ1F52Qxav4MQ/64tPAZO0XGVA4wPyov3GnVIE3uvNYNGSftSaTw?=
 =?us-ascii?Q?2WI49MHLsfPS0L1nH6fxax8gXhXSyyfWI4Yw26+f8skfv1qqxNKKfYnYWnel?=
 =?us-ascii?Q?9bVuNPk+4+TPM5ytDP4GjqexbnUCkjDRt6pdIVOe0rQSzDKxg9hZjpqYO+oV?=
 =?us-ascii?Q?3zdrPihdHLqkfNQgXks1fLEcJ+Hx615xj1Fqh32+Dksqnj5zUzVbXDBv7kmB?=
 =?us-ascii?Q?INiG/eO0UCTcbOo9Gs/7zy9KpDBNu9HgMLNjmeNY4OsWjha+5hf9/E0/8pks?=
 =?us-ascii?Q?oGJP5b7biWZCrLTRXzIcKWLLu6205mBls0T89lNRfec6IhVJhkaonksNoMti?=
 =?us-ascii?Q?T1GgCJZsP3KjdOLpanW1HciUmqVH056rZrkrG8idI+of9t96sMYIALeySsA9?=
 =?us-ascii?Q?SwRUi0zDy2eau5lp+pxNhImjyt+RkCMjhYmURLlMQAOI9IHYpcgii6fqgynZ?=
 =?us-ascii?Q?dnXurLFEUqNBGVPk9pifQrpO+1s4lTzTlfOANZmbjP5qet/4CgxHReaus4Lz?=
 =?us-ascii?Q?7z9e9p2UVGENUd5uWh1OfY9JDPO2SZqsmb1Snh/rqOUUlAOu+iKzU/njuF8W?=
 =?us-ascii?Q?DfLHcxwQn9dwRoDaQU79M4+Fs4Uga9Z+EVDiXIyhv3LpqD1t5kZZjR4RDEez?=
 =?us-ascii?Q?ZtBDwn5YzrQyUAYypteK/1uFjcwLX3et44GjVIFATtLVjXgQW95r7W/DRtgk?=
 =?us-ascii?Q?rjhAEsNAZSirhRN9Tl0fZeMzMeaQdoq+Jf/owNOqQgvLyXspfMHO2NxqOhzI?=
 =?us-ascii?Q?1zYXTsjcFvrQMZDlrTsNbxBJViFx67HvXpcLzKfk4byBx/W6Txrv0gpd/6Cn?=
 =?us-ascii?Q?Sa/EEmaRB0Cka1IBhO4LFt9zfbvqnp5i5WQt1od74YCe/IpsfCmHgwK5r7iN?=
 =?us-ascii?Q?DOfa5QEFRAHCdlVv/elpDGQCxnwwSYlSPOQR4J5yzOcH6YZhBWLXfF2M1Fog?=
 =?us-ascii?Q?QIEGh/8emLX92kQYEjF56VaKwqydZB2HSA/s6mVoeg9Q4HHlcCExGTZaty/l?=
 =?us-ascii?Q?9GQKaKlcqAGtanaIlbZQqNm7MFcK8kfO+qlo7FUaKcL1J5AGX+DjjjiFaVTy?=
 =?us-ascii?Q?UZdlw+9irA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e104af-a449-45a1-9273-08de7bb89a6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 19:43:13.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkx5uAh+20mkyr1nh1DUhDeLH1T8rMGrIvzw6A7s6Nd8371TbHXB22kCWvTOMb0c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
X-Rspamd-Queue-Id: 846002272D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21505-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
> On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
> > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
> > > invalidation timeout is a generic challenge across all IOMMU
> > > architectures that support PCI ATS. Would it be feasible to implement a
> > > common 'fencing and recovery' mechanism in the IOMMU core so that all
> > > IOMMU drivers could benefit?
> > 
> > I think yes, for parts, but the driver itself has to do something deep
> > inside it's invalidation to allow the flush to complete without
> > exposing the system to memory corruption - meaning it has to block
> > translated requests before completing the flush
> 
> Yes and currently the underlying drivers have software timeouts
> (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
> before the actual ATC invalidation timeout occurs. Do you think maybe
> the timeout needs to be propagated to the caller (flush callback) so the
> memory/IOVA is not allocated to something else?

No, definitely not, that's basically impossible, so many callers just
can't handle such an idea, and you can't ever fully recover from such
a thing.

> Or blocking translated requests for such devices should be enough?

Yes, we have to fence the hardware and then allow the existing SW
stack to continue without any fear of UAF from the broken HW.

Fencing the HW means using the IOMMU to block translated requests.

Jason

