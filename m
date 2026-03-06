Return-Path: <linux-acpi+bounces-21508-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPAlOiUzq2n2agEAu9opvQ
	(envelope-from <linux-acpi+bounces-21508-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:03:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE5A2275F3
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 21:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 712733017030
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875330FF27;
	Fri,  6 Mar 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nec+xc95"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F0302146;
	Fri,  6 Mar 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827410; cv=fail; b=NpdfQxKD8UEtwHG85ebkJ1/FRYWcCPxKyizIRbhQo5Fcajt1xbejCQksBU6pNqGn+GWOWNkCwRRW4Ov0nYHbWVh7lbnvChpCz8PqTu7Z2m13KuvL43tar8uoBj4CMKbPDqB73ATdxOoVyNqgOMgv4vXEzZxYmCCBdZzjuhCls2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827410; c=relaxed/simple;
	bh=ImlVBvEEc4LokNj35NQ9cS+gHqbTNQ/5v580mD3X1LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NL9ktbVGkw251z83FH2cAeGzy2dyDUNFkH77jgDnlvGqwK1CnkAAknBSSAfYsQPAfIXXymQl0RYH6h9SfNRd3APB/vE7wS+AaqL3+8U/7Nj8ld/vPyk3z6rFwD8if+T4GsEzvFj4LSkTFmeAEdXKNhMTwh2oB8SKDepYvND44G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nec+xc95; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVXJDumRpBcYoZxNLMXXzl5QkDxxQv0k824GHmcgK6e2kvZFsEZhePd/lvhAuyxHN6aHpVhbpsfjvO/7vIg7RsVXtq49OdC4StxkORRDoxe8/T6rR/nBWk97SXQB+ZddD+0PRpHVF0VmEE1MQWvV1Zs4WgrtpHUZM7SsAZde/N07Q7ZaueRfZxRfmcHywiM8QzJO1ekZ14VlR0WeZE4QWYt1xfaU+5BRCZQ5hUUYw7nGaFXAFLDZBUAODZxZgnyP3JP1VKHn8r/OjsxtR3Fo+hVGA0peAOqtauwg1EN1/BZoV0V2y3RaSy6RZsiketDywPWJEHbopTzmJSTa9ZLqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMj1ufUCWVXtPeqS3ysRrEQTz1RUsINUQsWJ/TyL2ek=;
 b=xWOgKuH3+MrsXJACbnrK9C3+7lc2DN0b6efAQaQOKH9FYfQM91ndmmH6Bcah74vpW+PqsUkL7/dU/nbhonY1po3JUjibSsH+Asc4PimJyIRqJcUE8wuckPhqWzgRcdJdfggS/Fh+/ZM7foU3o5wSJiQpgr9jmzQwplT7+ekjD/widZZf3mHBcKg6VxOMxM+GOQ69irhnnSs6wEH+2mraQQZUrgF5aPhnFuNYZNvV9x6/A6CQPKKb5q8qFKfo8wkJMG4gn0txjeQ8GHuwc40ICRrFpjvlyeAnQrQPWSU6EFr5yrdS1XvSHsMkse8zZBen1q3yg+XPgwW0qjXF2CD1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMj1ufUCWVXtPeqS3ysRrEQTz1RUsINUQsWJ/TyL2ek=;
 b=Nec+xc95+iahKZGJkZmJ9IgS84ZMICfbVZkr4iiHBObVIoVaNlbjU4JZESFamvlJF7P9I/Fqkk/jqqvzZcYf/GULdNbhzAk5J0zQr0hJXAPAiC2COeDeMbOTE0QiVW4Ygppa7HYzUbSZYQb5wHGX7lMMzbQ6ziwGDSdrf7iqQQkeWpbuz+FIEvRPi6+51QRAPs/n8Wi3klVgzo2lYQa8BYrBTlL41ph33UiJu4ojo6KPpMKxyRYNSV9oJ2Wog9s7D5sp/Sjektx5WUksLBh5FnRI3UUeWwCY6faAlA40l3ojQTQvQ9GC9iqOXsr7HQ2ax+DiewBSwalv2iMpCgEV0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 20:03:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 20:03:22 +0000
Date: Fri, 6 Mar 2026 16:03:21 -0400
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
Message-ID: <20260306200321.GN1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
 <aasv1HYOKuuJyi1k@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasv1HYOKuuJyi1k@google.com>
X-ClientProxiedBy: MN0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9a3e8a-3596-43fd-58a1-08de7bbb6b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	p1WLN4/NSd/Ai6Df0Z7prJkR+zHGIMp6idPhZZRztBC9b5doI57lN0RsQDMBe+iN7lzH0VI0dIjtVE4FCO0PQ16xIpPDBLYCX93GmXrlOjEo/yM62Cw0zl91QDXxHU/mUFTnwe/Z+O2gmLVR61XFF/gWNVKjEfiGbHK6SDvm15IjRMpRKIErdTTUJ2VzTlUudU7wreSbo0jQmah1qqh7jqP2V2v34o978UgcfbxBbjy41uw+3MelDYRydjeUHKOIot9mC2DDr3kZJEqXbe/IS7Cx5By6DyQytP8tWEzzVPSXd3ww7ygY6cAX+s3UqIZ4rVwDVVyQHeRJXGEJIX6ehGIO8NhW3lglpDdDo3CJmzARScCur1Pzpa8ReR/DI8py2TM1yVbdHqvOdIOMhBf66dviBGaJuSqFcJUc0NHlfc22i5j8TNIn5IqX5zq/E7nznbeU5V6OXfGK6OuMG1tzM9L3QL0ayRt1iAMvISMgv5PEilNWguI7ko9XFyzlkyIhp0dIijBH+3efGTovSz02rpXoHKkp39OZtvQlKQJxek7DSG6zPqfemy7r0Ea02LE/hkJiNedpbQ4+DY6iDb9KsHj6mirt3+tLiFb2FEYQ0lcFsOxXukUUAhZv4jS1A61BFIt11azXGdnI4QL0Bc2AkAmMEupkWZhoj0WqDFpaHd+GWKDKiYnE11965iXvRyIsISnhZTKXfhFiFqGbN30phx6TwzL64u+SBWCcKFiZPAQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wd/6pWZTbUCXyTwBOaMXLF1BPub2yUXrUGU2fumYJa/nLMlM/vhbqyx8ZDwv?=
 =?us-ascii?Q?RSphypD6xQQLwlbhMzjJk2SPMeKdz1H+S8CFxvUdIupg3l+UAlb5JrjlYgmh?=
 =?us-ascii?Q?FVmem99Jjmut/oGhdGr5myyJJ/UmRroIUmqYy/zNZPH25MH0BZ4OlmYgK8a3?=
 =?us-ascii?Q?k7ySx0coX9YvknziWnSiq7C5Z5i30yyMFc5MA/mxstXq1Db/+rzw9QgXfxQq?=
 =?us-ascii?Q?mtm60JVGQSvXp15rS3N2qOmxiQQS9sNe3gKxTggSeGtVXHRpqyDEbFqVRcaH?=
 =?us-ascii?Q?ofpsyXTTT3SRtnYeeRYck2W/XPa/l49a5lGmzW0osL2M3crrjWMLr3cVpllX?=
 =?us-ascii?Q?TYja2MbgXRBmh//9BdqdDpEQbm0XCP0yf+vHVC+Pcxz368LMUtmoLGSaT86N?=
 =?us-ascii?Q?dtoYPPgDiUG7ORnYWIlRdQqAY0U0OETgVDJ/ooQuTS/sUKAgbg1YVqPNMx/i?=
 =?us-ascii?Q?fQyEHN8vWRBYUmEhGqKE3T40md1pvZ0ykQd9F2+5vtb8lizA6M/TkicZB1tY?=
 =?us-ascii?Q?A1D5cqCCvdHU0C+Hgh7EtC7hxHL2dik/68+bVYWnu1GrEE8NmpcbGfcNKtJT?=
 =?us-ascii?Q?hgBJjthjQGYXr5liGgwWHLu9N6JHri9UQx4ejMRbCkZROCCGYxy69JkPyXTo?=
 =?us-ascii?Q?nJ9rj2LPVcIDblDxz9QXMtjWssj/f1jDl5veQeexmnLPfgRM/TGU5C0epQi3?=
 =?us-ascii?Q?Z5mEa21hHEqQWoKCy5w8KQ50mcWNAOYfS75XeutnU4GqNSQZg5lUMUIzSWpf?=
 =?us-ascii?Q?aiqk7L2hH8+bG/xT92V4m+eKLyMxTKDva0wyeJxCXJeN7rBNEsT8YId0VIrA?=
 =?us-ascii?Q?/OHq1g7AGNBIvAeskGYscJY5lxd8tlB4NF8aGQeYVS/68Q9X/z34mx988Yw8?=
 =?us-ascii?Q?n1oQY2C/NWSIeAHx4eERHIwzlpXz2CCkSS23GLU34/LQRZr2p7G7Kf447/Vc?=
 =?us-ascii?Q?imRv5bbM4iRpK1cbMS6MGNWHtpYDigYVNfqmMjdlen/Au4Dn8cuLyC0DJjfr?=
 =?us-ascii?Q?WARBbtxPhhBcpIk43kL3SM9QEgfwExaQBR5gwP6OqjtlLsLHY45wSeNZ282r?=
 =?us-ascii?Q?DJXxGyH3QkqPn7OFtSMbYVqEv0QT6lXgrgZKRiqmD1UoQWmm7w2A9tmdXXLK?=
 =?us-ascii?Q?VnYFPSJD3DzjgktNO7o5SA9ga92zJnq+Cj1DoB+71hIYThERW9F+vVL4fFsV?=
 =?us-ascii?Q?5PCodAAeXbZLcmWy89cXkGxOl6XQ+XfoxxKQOBZw2VYyMvhridE2SbmxiylU?=
 =?us-ascii?Q?GtFID9i4BCBX2MLND7o1Ffd8G0yH3YurJqJ0DLwIXNyisxQDZvjWfqJgqAQ3?=
 =?us-ascii?Q?oikDWdBT+3HNwk5Iy46NhcENllUBkc3N2QCVDZHfUmQhm5qM9/VOxpy44CC9?=
 =?us-ascii?Q?40Db8PP5U6qwEwsIqyrA5UWAdL8AxCUsD/gTAjl6hmKCH2N3zMzFtiM38qra?=
 =?us-ascii?Q?H4NY4ZGRzV5NWrgaWUrleRn15wlUhwM6+hqPVyyYfkAivVrI/5U1MhQK0WkK?=
 =?us-ascii?Q?g3WlNc7v6upwF3rDuQSwBeuWNyOQ2H6P4DA9uMZ/7OdhhkpMPqr/c0VqClx8?=
 =?us-ascii?Q?KdU0LxrlePHyewn96W/9WzcUd9++EUlWeVNoLpJjcxxF8MKy8jEmVIwXwmvc?=
 =?us-ascii?Q?hqB0yYTCNpbYaTm9msAifOROILIfG7V2w//0KXmdbMM9pH5usDB/O3TR6Y1T?=
 =?us-ascii?Q?5tuzwFlfCDmtUdb2XG96UpyDJkFs8GC6eJUV8zuX7IP0ZGo89k6v7OaoM0Cw?=
 =?us-ascii?Q?aQPzYJXb1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9a3e8a-3596-43fd-58a1-08de7bbb6b0a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 20:03:22.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiwhyhCXHTcu07g/uGrAKgUdniBpAPOiNQsxHglNbxuVy9ouGwgbYxV1EbpNYtgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
X-Rspamd-Queue-Id: DDE5A2275F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21508-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.951];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 07:59:33PM +0000, Samiullah Khawaja wrote:
> On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
> > > On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
> > > > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
> > > > > invalidation timeout is a generic challenge across all IOMMU
> > > > > architectures that support PCI ATS. Would it be feasible to implement a
> > > > > common 'fencing and recovery' mechanism in the IOMMU core so that all
> > > > > IOMMU drivers could benefit?
> > > >
> > > > I think yes, for parts, but the driver itself has to do something deep
> > > > inside it's invalidation to allow the flush to complete without
> > > > exposing the system to memory corruption - meaning it has to block
> > > > translated requests before completing the flush
> > > 
> > > Yes and currently the underlying drivers have software timeouts
> > > (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
> > > before the actual ATC invalidation timeout occurs. Do you think maybe
> > > the timeout needs to be propagated to the caller (flush callback) so the
> > > memory/IOVA is not allocated to something else?
> > 
> > No, definitely not, that's basically impossible, so many callers just
> > can't handle such an idea, and you can't ever fully recover from such
> > a thing.
> > 
> 
> Agreed.
> > > Or blocking translated requests for such devices should be enough?
> > 
> > Yes, we have to fence the hardware and then allow the existing SW
> > stack to continue without any fear of UAF from the broken HW.
> 
> And this applies to software timeout also I think, since both have same
> end result.

Any situation where the ATC flush doesn't get a positive response from
the HW must fence the HW before continuing to avoid UAF bugs.

Obviously today we just succeed the flush anyhow and hope for the
best, and I think that is a good starting point for VT-d. We need at
least that to build anything more complex on to.

Fencing the device also has to come with a full RAS flow to eventually
unfence it, so I wouldn't do it in isolation.

I would like the unfence to be done with a fresh domain attach (or
re-attach I guess) that just rewrites the context entry with the
correct one.

For VT-d that probably also means it will need all the domain attach
fixing we've talked about as a precondition too.

Jason

