Return-Path: <linux-acpi+bounces-21463-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANgDOFsXqmnFKgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21463-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:52:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2D219875
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 894B9302143A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2E86341;
	Thu,  5 Mar 2026 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJtISiFj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451E35F5FC;
	Thu,  5 Mar 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754777; cv=fail; b=tpo8lC3U4Li5eBdBlDGrdJBU+kmMeSc2fQQYSZYZyw9IntQY2eeIVdHkCbTvnviK9Z5E8+mw4DSHOJ42YwkqFyTZkYhLnvwY6AMGZLnc9uD5OnRBKhVsmG22zMhFjYuQ9VsHgJxO2nGg1diAGwz1OeRChwmUoJfhAoE4J42rrQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754777; c=relaxed/simple;
	bh=5vmKOeKYSVrwlqtFAka48W+unvHZ+UdTtaCe85Z4fUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jrpbojy0CjYv0AVh3Ze3en8xsP0sJEeFo26N6q+HUU76qew3l/ig/7MRT73EZn412PsrQ6OwDDATeK5eX573sAhfAozbnYLQktgGUM5e3djFjSrrjtcuu7zdkwXU0ncS8QcqUVQkAa1i7u2lrOQZgmX4942TYvY4ZfRe4Tstz8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJtISiFj; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odFBOsKK0z0aR5aAGo3C/XtP9NqOw0AZDtT00Lgif/OgKfIWxxSf3qo6pFeYGsLZLYRkV2o2rQEWq8Y+6HGs9I5dTcGIFEEAGDZPsODN6pH4moB/LOYoSyM0z0a2qNnaPW1M4xBinhlfUyYtigMYup5rLUsU5DB85h79UJHzjeyj/PoMqC5QJ4hJbQrW9yqRbJMGVgqs3hZXEdaJafw3P621gkeobvO67vwvl/0GVA+v/BiUam3vJ2Cn0dniRVzdhtVrNfARvTHMM2ks/D247ItvsI2gQjVt/gqmUVqZkAINfzwDeE4Z4/9SzJy6wSPodmw2ZCv8M/rihSjkGrXAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vmKOeKYSVrwlqtFAka48W+unvHZ+UdTtaCe85Z4fUw=;
 b=sN8pU/tWWNvuTTnIRYKzA2Y2CwwwN4NZjrW6e++glzCaDNdykRgZ9+8KT0dxKSARinc2O+xEFfkvLsFkx1sU8YdC0RB9VrDtX8xKPkEiFxXuYdXa0CGTCNkCFXUVXr12LD0mpC1az7OQxlWQu8joEnUBf3ZmWHerqsgvJdiIBYP/jJCAInjvgsbxK39GckE3z3ZBPfySmN3HUiczMyOQJbRZT/iQEH9FTqE9ti0DxUa4kOYW4hrh/Xx49psRaIcW+IbxII/XGvHlR6AlxSBKqeJ3j9jS2mv8JJmuYzqlLRTHpixtIwengyBhe/pgx8Vt93NZAnp7S1bV9fARKWyHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vmKOeKYSVrwlqtFAka48W+unvHZ+UdTtaCe85Z4fUw=;
 b=aJtISiFjQvlhTTvWvzuHzuAyXM6qiIfH15fXsXEsM8bs6gNjSyUswrNYcD+EXQrOHheHxQqpUbD9Ghs2M3gaSaU6Y1G3I+RgZjZb0+Qt2AeALCrCzwJWqwOXm+Qwj0ZIcEoiSE/Vp+58N2UTfdJNxET+RzT5zyjiTSncUhFoBiEid3sMMPhH6sQuGNCreBPMtI0cClyDkjYMAXck/2u/RCXhVB3OQBpkEcRittbZ7WSGhjjJ1atcOEFckXpHkAV4qQ4xr7iK98GkJ100Q1iC+YfKzb1Vj3NCze8lDNLo3pnl4RSTxfDdCdhXhl8EAycOtar3kJC7nnehsnaxrwgZCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Thu, 5 Mar
 2026 23:52:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 23:52:53 +0000
Date: Thu, 5 Mar 2026 19:52:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
	praan@google.com, kees@kernel.org, baolu.lu@linux.intel.com,
	smostafa@google.com, Alexander.Grest@microsoft.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <20260305235252.GC1651202@nvidia.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aanwTQtMMplXY3du@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:52d::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a154d1-4141-405d-b4b3-08de7b1250e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	RKuyEfSVTDEiJSydCdbJ0seI31jZu191a83D+aZYAUzDdUABHeu0FKtSZFQBkJ8opM2d/qYhZ9RbzQamrBBNhmrhhZTUzftJqanWqUvZ9wfmIEMjpm0gbG8WqIKOR660DWJy9vBki/TWNgdnQqPZW8V7qm+xwIfBJ1/1ecCiQBL3NyKPbxd6kEupxfpqG5F2KmVQFX8EbEgNfnALD+1QD9jWIKfiFZLb8VwrpmkyStE5/Ky0Cd8jsPY0uA5kPQwFj/RSOVAxxO0PGyzW9eBUGrGme3UG22JkTfA9bubpP5/d36wOYaftfYHRoHM6WVK01d8tBKzhdLO+b0NVBSDR/BNNu6ajBKhefpXl9vwDzFV0Xertf5aOqmnT5PmjTnEFUVWHUPeufdr4t36UF3YZhqV0vxRrK14GyMCIDjdySdFqL4gaveSZuV7ak0NYdrTC/tdb/wvtd3kWNwP9cZE3zHkq6OoSqJGzk1wMlGagmyc04jXBKKwyhi0Y6Py9WB/AcNv6XsO35vrHfYOpcD1l6Us84cBXCRhGcwZt9Ttc4oURQ0OYBhGFteZMDbw+N2+OUUMdUtYdLjCaMeYg3dnadvqPUkH0HX/Eq7eAJ2A7zzBch5ZKV4WYKg9X3rbXS2o8SOJZ8zZp5YDOFhYU/9QtU5q5rH5uuUBoRW85I0/6iLpRzBF+QnbVM4tItF5MJydPdGUNmPfBbOH/YIKtw5WEoppxN2WXt8a0LTclNgEZsls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0X0Je9ReKqsAckki6DhngeLJVGHchxdJP4TuWDZGzbkabw5Wh8zgHUkBhF3t?=
 =?us-ascii?Q?cWWCecn1TmkPnaN1VCCN1oRrsDOqjNF2NkVa64fyyTuG9uZyVNX0sDeRJ30q?=
 =?us-ascii?Q?GlxwfviASduMVhKn7Gm2V52pDqpAAgsYYza518DmplPvkkt3D6o8VjDXTjY1?=
 =?us-ascii?Q?AqUWIB8TjxDe8V3Ztc0sGcAU73Lgj1rX6MUqwZxmXnpHVb4lKofWMWVT0+77?=
 =?us-ascii?Q?bVspRutIABXEI/4VSj4Gh0unv03ADEP9thF8kXf937pm1TMtcIMbCzurwHOb?=
 =?us-ascii?Q?GtLsVgwzuooEg47mJb9ijIvumXIFOeHARX1OwdWZGvU5nm067POsM62LQd7g?=
 =?us-ascii?Q?LKusyPU7wkHXqvARWIJyhYh+1uO2IWZoAE2vd2S+XdmcBjyT3kUoOnvoAN+s?=
 =?us-ascii?Q?q+aYq+EU1V2dAHmRWk+Ex2WQlApci14qTloc7VvPNOvX8cmqJOXmx+7E1QHw?=
 =?us-ascii?Q?ydoPlXlsMX9r70ZIlkPIe3YwUViMX26fS0maaAzfbTT0LXVaxCdMgFNBX6kS?=
 =?us-ascii?Q?qBh+aF4xvaCfjxC4aNcuIGaGn/zlbwzDHVeONKnh935MwAqxKC8mgCu5O7Yy?=
 =?us-ascii?Q?OuH+URQxe2xJuIVGZ9J90b4GYlmAt7+KZZRFLHCj8z7k15FWjFc1k1B4R9MG?=
 =?us-ascii?Q?Mjba8M6Xeo+ebCvu80bkFSGHKq1HGRnUzF5nksmeywj5Wq3tUx056P9kzkwI?=
 =?us-ascii?Q?T4ozPD6UC02bvoBdQ7EhiCX0gegT6B6bWpTqH4LANKeTg73nnTTFxOH65p2c?=
 =?us-ascii?Q?B33Qy35TLjXd3YUbDmG35XFeBKNmWNltNKfODLdtxmYiheWYmv5bobMpeEKr?=
 =?us-ascii?Q?HtXSkofRGf09MdswYCfUAnyB0605Z0o+seF/0GQDtovPBqkPAvZgmWu6j6JK?=
 =?us-ascii?Q?K1U1zbexqPkID0u6D6bEi6IDK0uzj/UEOzjGj0wx/7PeLRO0NP8CtmgyxugH?=
 =?us-ascii?Q?MsXoWLuzi7rHT6yB4WHaI2EJW5dcaCNLywTwGC6lm2mAEArdcZUnDb2jisa9?=
 =?us-ascii?Q?cd99ftV78n7UEdyn91Db6d9HGhg17S/Oe+IAm9no0VRrXbwKnTW0jZbxLPZ+?=
 =?us-ascii?Q?OezsLyksOwKmDfcC3M28FWQzmoyS02DZ2blnfQwKr4AQqrwILf7T05FbODa0?=
 =?us-ascii?Q?ltDPkKuR1nYimEw2IkYAnd5zIEXdd1OeyBFUZxd8JFusT7+isCCzU0Q13y9B?=
 =?us-ascii?Q?tlKeobat9rkTD5wc7fGcWLg0k94HJ/FXL/1ze3OCcZz8wng5xqSVQXwIrAmT?=
 =?us-ascii?Q?jZhHeVixBEZYXAxnRhSVCQmZS5fjflNG8VKEIctPlRtJziaYANNLlKStpEUb?=
 =?us-ascii?Q?ACrt3Z0lmlgFeJJGLVGySdo8rBM2KigjeSuI1tCyhatykaR+O8CH4Ru4Ls6d?=
 =?us-ascii?Q?VP3Ywgiif34zs6hubPd4AL+Sthl5OtDyrOQE7GRLQP7O9YWbaUBpI1mfYKOB?=
 =?us-ascii?Q?cl0X7cRGrdGpLoq0eU/WRXelidab3lwoD9WoBCqcWxO5H4HP1b9VkVDREZkC?=
 =?us-ascii?Q?rW55sVQfMUdTQppFR74lzP+quRnHhzCZ+FyaHCzMFPgEr/nOe6ERy5gI9y/G?=
 =?us-ascii?Q?7x6m3PtxcLuZdhoZgDa6y88i9qijqxzbFpvtFji9TCeeUDvf3uQ0S0l8tmJ+?=
 =?us-ascii?Q?DSjIZtdpGAn+uIaV94bSXqLhrcsPt3izbMCpbHettTs2QOHmy1ac0nhvQ5fu?=
 =?us-ascii?Q?ZYA8JNcSbcuVRso+zL2CPJCTU9Lh+oCLbCUPLBb/v+FJZzUE0o2kbpETXeMs?=
 =?us-ascii?Q?+OfMeDj20w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a154d1-4141-405d-b4b3-08de7b1250e9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:52:53.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cahbJhIcH7OCPLAQXzzLk+RYh6wCbXGLKTtpazHcgJyqO+yEyfLWqfEMhBxS7RNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699
X-Rspamd-Queue-Id: 86F2D219875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21463-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:06:21PM -0800, Nicolin Chen wrote:
> That sounds like the IOPF implementation. Maybe inventing another
> IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
> make things cleaner.

I think the routing is quite different, IOPF wants to route an event
the domain creator, here you want to route an event to the IOMMU core
then the PCIe RAS callbacks.

IDK if there is much to be reused there, especially since IOPF
requires a memory allocation and ideally we should not be allocating
memory to resolve this critical error condition.

Jason

