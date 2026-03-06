Return-Path: <linux-acpi+bounces-21499-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP27LiP8qmmcZAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21499-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 17:09:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A2224933
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 17:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E076B3008442
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359473EBF09;
	Fri,  6 Mar 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+wl+bQS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1023921F3;
	Fri,  6 Mar 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812616; cv=fail; b=uS5+v4bfo2HCNdbzMUVMdGbTBNqep4bzT0M33fFPCJiDAbod5TA/i3wWQep0tqvB8tqAkkQF00SyxfylwhYyhhUW9AdE+KNECc4bYVq25qIBzPF9s+kM7KtpQ5EKViheOkL/krFDq8zLi8iGHWcoBg+j0iaS5pw2zKBzYB4ZgdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812616; c=relaxed/simple;
	bh=IzDvkn81JMeQfH9QaQct3S7dz+c8HRpPKsAqX2OhD3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZQboK2IkCjpv6oA1CLoDfaC/BVhZOIt/YxCFV2jpcW4T0P9ms+4m4lbuaZpvL2xiM+tmX2nPnO4CR0XOSNgFD3NOrDwQ+shsk5CjiGd5/EDh3I/PuZTA79L3DmsPs4NYESQPXNa2EJKjahlgLnKNP+oAUb2Y/iOhTPQTSjJZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+wl+bQS; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lro3XalsWhfs/z0tGMFUSIDsBuMyRO7yKQJg9irAuKrLZQGjFP1kYwoTAwJpb7Om32sXenXmOQHGryzZbuRcmYeZAmSD0bC2tY768miJDGvwWiLbc5g7yvEE2klOxW8lNT80GUc5e2RYDhtKFs8kgIW+Rszoiv8r/CWQhxCe01s4G8Q8SfdIUHtzZXePwqEcdSfbebBD03/+DWi7LC6u15vHD483+yT8Y4+OLqIoquwuThFZEcaSoMOQrimDEwyvyejH8QO25RlUlYKaxNAyIyok3hrhy7jw6fNlfu4n4pDiTxjsIb52SoUU4Q/BvfjB+4T0glzRRV4wIDt9ooOQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8NOQ4aHIt/lrXrPYb1jc2KTi3H+1ga+V+AS0WrJTqg=;
 b=GbksRuA3CdTg3PrP3lqoDzzWWruz9BCTVqePLhtUA20s6+4ftaGCpwalFzW2LWa+JnIuJPqql8PQnV4ckcmUSHM566YbmftOaUHWTd7x3OqQa0ycRNHSw6AbQ6oCeoNgGFjpoXap1zRtAlUNhEOsCI+3UGg1zNeyS03cRRLp0cxQfTaA97E0hOR6dqA3pIuSxNsDMGlK5Z4skYGSJYhA8TQlHnuQMNwrPfRHVKH5r4CD9ZxD/octijBmqb12HEL2NyIvr7Du5haZX6BPOOnB0mOL+ijOuq9i2xpd6lBksJAEb2rBt6ZrLK6X6Te4VTRyowlXiWRi02h6yPG2xZI1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8NOQ4aHIt/lrXrPYb1jc2KTi3H+1ga+V+AS0WrJTqg=;
 b=D+wl+bQS7TEsRHXFViDQMpTkbmONHURm3A6F3kVq5L+XRRv5XnynW9U0H+X6GmcWhFVEcAtW9Nyzc+E8cQVkCeIKH2MHgAFtUtv4M6o7T8LfhshvP76pDhtLAFkqXBeFP5uxO9T+Hbcek/XbHbWxbcFeM14BvS1DYggFIfa2w2FbWlO8v1bqGjdJilrJ06o0nDD+OxN59s3oV6iE6qWxru94XndogVhfg/ZWW9c51xTksjIFRW0p6UM3y34kquzDnpQUKF/K50Owxv/LTEuVcXZ3EJVGc5rR1bNVOrQ+XMNx+Kd7MZ22/L8eQRoCx50zEs4siC2EFcLIp2P1GEshHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:56:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:56:47 +0000
Date: Fri, 6 Mar 2026 11:56:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260306155646.GI1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia>
 <20260305235252.GC1651202@nvidia.com>
 <03461707-783e-403a-86fa-ae7a5107fa30@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03461707-783e-403a-86fa-ae7a5107fa30@arm.com>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecf369e-b61a-42d7-8cbc-08de7b98f8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	+Vu3F5nx778o+oLgjYooQtRAex7NpZB2y3Tjo0aCUljjMd2Z6/GVGLRmYDlgShAmPqr2WPah9BIX4KaS0L2cayr65GRkXOk9oBg4I/cx49+s68BAzqGnj2hMQoL/unvUK3vR2FwmGKenXTNObeLF9+Fe6u2X0TM96K3/Lp+u9+UVuEwYBwXj4+veyaZlyLFNdVCApL5DNFcwdMXMO+R92/lzTt1Y675tmXS6uAvAjB1sCYfTGoNHFB/reLE+4e81xqdKgYXjqfFum32PGwHxkN2rHq62b/D2klXqJwTPYpL+SzxVlD6d16quBBlPk7P491cDFFHjgCKAP7O/rIMU0dyK8Yfmd+Z80IH3SANgSHDEyXa2o75kM7PYxKYM0kTtvPE5IXWZW0EHPg8chPF1Vl2hOfKtfDnwUop8uhIa/pVMptrnzKe8e5aWPA+L6bxKIcdjGjrcxV4MUhL3tluBZFFdIV4OMFK1oICO6ePxOt/dv32ZcXGhSVupbYI3fHhgxwgaxHRxCjtJFMiSM2NkRGZz429LMIJZXAPpbWvUJGi85lgzJ6D2PXT8QphZdbq6aeQIimlUq+a1ZZ9CwJ0Su88XDG/16L+RsNnPhfk+ttMLJNN+Hckr/jzaF6lj1hZ/f8LFcR+SYdARs276lBdW3u4W1eLz0Ivny+//vGCUrUcZIvNqSYzB9/RaOJR+4iaNQ4nB/5OpXXZoXAdHeGjds2S88cBT/BzAq9szQREdXJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pkRAK7WHzjHnMODPD3WOE7/sqaRB2jlM33dL5+ADtrIFnyRLfSHpD2uyGqKf?=
 =?us-ascii?Q?lODz5kefbWQEIB+ix21jCL5PfFmbxCNCL1X811YwU1vf5Np2gUlDlU0ktnYP?=
 =?us-ascii?Q?E++KHX6/z4nbiZyDs77WxKcfYlnylW9uBULGxZooDIoBRlC/zq0zOs9FpOH/?=
 =?us-ascii?Q?1pASr+8ieOy2sNS0VjZ4kBm7dy0Yrejqx/bOeePxY2fXF9/e8zEga2aGXZtu?=
 =?us-ascii?Q?5CY9rVc7VwlUa+vpI0q9hiFb4Q871WERGEfUjPdV+KXOJ/bmYcfSSZQhvIbQ?=
 =?us-ascii?Q?Zx20Rw960geGbjCeysvaoIvgfGgIlTW2MIaoYsG3tGhWKdC0Bx5jvlj0CXmv?=
 =?us-ascii?Q?nLMHq/m1aMtF3VT808yu2Fth9FhxuGCkwTQIxemqpIsGHg1mOKxcDRvy3Gvt?=
 =?us-ascii?Q?mruanbqEge72E5vbPtbNn4I8kyVvLAmSkgK0WRDtWYB5dvY7TI5Vwkto8nT2?=
 =?us-ascii?Q?CexD6mfRQtzfDf98mc2UUUPYTwR0xLiZisCq1yhiF12oTGi1VrVcqu2IBMza?=
 =?us-ascii?Q?nx2ffwcMN6vtKssHzDCm8nmiEKgsJcftLKYS0wXLq4XkQe5HYJEsK5ZgDFWg?=
 =?us-ascii?Q?DYx5nU0lyoPd04KijbJYIXyFVZ8sF8s229pzat3Cta7n5cxsrUoctsKCJOBI?=
 =?us-ascii?Q?JpP9CatluS+l4Jp4Dgfxd37cwp7QDHMKURvm77WDXlkXYWk/uYGazEoqX/Vg?=
 =?us-ascii?Q?P5vKp4a0DQsBK3Qtc7Fs39mbVAvjnhr2kTfqKgNdU7mdY7ZlPFrc4WsmvsMs?=
 =?us-ascii?Q?JxczP4o+3AXvx03t5P+rg5VA/CuccLjA8caPin4dY+O+noeM8XdCyidJPQ/+?=
 =?us-ascii?Q?JEvs0Li2x6bA9tB6VBNIaDG6RQ4UOAAw/ffSp7mDBlmlwSc9+oB2894EOZn5?=
 =?us-ascii?Q?cnjQLm7/arJlwiYpfkEOLMj8gywyK6tMQdgM3gep6k94HMp+5VDr6KhiB+Is?=
 =?us-ascii?Q?pEZI3OVvmBuUh6SZtWsmz+I81ImxkNGhXgu2SiDhXU2Iga1mFxqx7sR4vkvM?=
 =?us-ascii?Q?hQvHg5SX+5XUVnlOSW95wtBju9y80gMCaXRM/GNRPR/uQe9z6OGtjnSFsqAR?=
 =?us-ascii?Q?QS6M3lQ7Ae6eEtCMlPFxHqHm87p6b97kIR2LhNiFWVFwzczfZZ6/sijJfw+T?=
 =?us-ascii?Q?UdmfEtmwxcARwPs3Eu8G7vOI+yzzqou+utZtkKe9vtnBHWT7zxd4+f1bqoy/?=
 =?us-ascii?Q?eK4QEMlTa1ZdvjnAC4dVnvf185dcGz392hsZ64km6HHXVvvYllOJPS+8GiIA?=
 =?us-ascii?Q?IrTwJYB+1FLsHSv9npDdwjJ783aKk8OvebCdM42efLWksNnk31p0eHVPvxHx?=
 =?us-ascii?Q?QE/da48uZ59KAJNdbzvvJS1+T0MhfEuPB/haiI2Ac1oAAJjh53CHUMK4Wyzu?=
 =?us-ascii?Q?uFNJqqbHeHw3NSu5jJZKQYz7p+UIEoYFyi3C6CQH/wnLpO4KGC0q/y2aKAtm?=
 =?us-ascii?Q?QbdCdi1mYQJrzkBLenLIwnKi7YVzoZbo7vS/YClgjLzFZamhggd+t464zxVS?=
 =?us-ascii?Q?W57EW8O4Wx4/8QHL7p4LNFFOBAu7bAaTgORoCCfEcGPVkxnA0s+3gBh8RiCX?=
 =?us-ascii?Q?DGAOTy3siaZ2nFAXWwo/UxZvuRTzxUxArtkyu3Qykg85sIRGyrvOQcv/3xDX?=
 =?us-ascii?Q?0LyTeU95ynWpwWtOQKp8Lhe3+5V9DZb81UfCyoX7Pdn0yfqD2d78CIswh6Aj?=
 =?us-ascii?Q?DYE4Pvz849BM8UAu1UkMkd5+TgxTqC7Or2FzKe6wua3eakz7LAAPuYXjDotP?=
 =?us-ascii?Q?MYbV38bWBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecf369e-b61a-42d7-8cbc-08de7b98f8ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:56:47.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3RsJ0ovT05NMwQpb9wGEyrh9I0RvmtpzhetXLRTU1y0XheTEi3myxdNmfmjnlAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
X-Rspamd-Queue-Id: C89A2224933
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21499-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.950];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 03:24:20PM +0000, Robin Murphy wrote:
> On 2026-03-05 11:52 pm, Jason Gunthorpe wrote:
> > On Thu, Mar 05, 2026 at 01:06:21PM -0800, Nicolin Chen wrote:
> > > That sounds like the IOPF implementation. Maybe inventing another
> > > IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
> > > make things cleaner.
> > 
> > I think the routing is quite different, IOPF wants to route an event
> > the domain creator, here you want to route an event to the IOMMU core
> > then the PCIe RAS callbacks.
> > 
> > IDK if there is much to be reused there, especially since IOPF
> > requires a memory allocation and ideally we should not be allocating
> > memory to resolve this critical error condition.
> 
> Yeah, sorry, for a moment there I somehow forgot that we can expect to use
> ATS without PRI, so indeed tying this to IOPF wouldn't be appropriate. And
> given the general difficulty of trying to infer what went wrong and what to
> do from the CMDQ contents alone, I do like your idea of trying to return a
> new kind of sync failure back to arm_smmu_atc_inv_{master,domain}() so that
> we can take any defensive action from there, with all the information to
> hand. We'd just have to ensure that if a large set of ATCI commands needs to
> span multiple batches, every batch must contain its own sync (since if some
> other batch of unrelated commands could get interleaved in the middle and
> issue a sync that then fails due to someone else's ATC timeout, everything's
> likely to get confused and go wrong).

Yeah, that all makes sense to me.

The batching issue is scary, we definately can't allow an ATC
invalidation to be pushed without a SYNC that localizes any failure to
this specific thread, or we can't properly disambiguate the failures
anymore.

My feeling is when the sync "fails", it can bubble up the error and we
can get back to the invalidation list processor which can then see it
failed to process an ATC batch and take an appropriate action.

> The fiddly thing then is that we might also have to be prepared to "handle"
> CMD_SYNC timeout by manually checking for GERRORs, in case the whole
> invalidation is in the context of an dma_unmap within some other device's
> IRQ handler, which happens to be on the same CPU where the GERROR IRQ is now
> pending, but can't be taken until we can complete the inv and return out of
> the current IRQ :/

IIRC didn't the PM patches propose to add this anyhow?

Thanks,
Jason

