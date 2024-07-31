Return-Path: <linux-acpi+bounces-7166-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB755942EDA
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 14:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5796FB20CB3
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E81AED59;
	Wed, 31 Jul 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KkZnLKGK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3831AD410;
	Wed, 31 Jul 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429807; cv=fail; b=CWM1+reUIs7R7OY6xMpMmZCVLQR2d25cQKQBFPr8ElfsZXmKwcPlJxfAzLjM8++iBJR3KxgYLisCVmM+MRznuiYVv2A4Es2Cu39mAGKd1hc/BMo1P0YQcUCTeoimxSKAXtKSt3RTqbD9cyzvddnMxXcLVJNpSFt1QDY05RKFhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429807; c=relaxed/simple;
	bh=yq86WrrST53zF8HRFZExqneJn58+Pima0WJGVc2Axq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AulTTabpjTD0UjY+0fj0pL+nxmwBVxxgbzd7tIA/8ZZuuzWm82uZFWzIQezr5YXXI6gfFxEw/czkMm5XZ27rWzWbqhdp/ow7Sv/3HgNhcf/IDpvmib6RS+/0IwN6BL9bCF572qZGi2eXojg2/1md/Vkggy/0dnk5IZqpDtzoTkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KkZnLKGK; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5EE6Xcux0SDfnVYcZIm7c5AbtlI3q4xVrVbagJJImRFBGtcr6QXiGspPdJRxt1zlXEvfO8iFaup0z4NMJFVZVvtimeOmqx5c7Sk+jvWvW8KZ05wmv4hv+KCm1y0FDWXXgNOsVQr0p4OXt94G6+qg74Zp4H5Ec40Y9mYo5/P5kbsZBptfvpd6dc5VOjb3B3AUs3hvXsOX0wAq3lauEi4R4RlunDBlB6vSCaZikIt7/Fj8noec02LYmUFYP+BmfsEkKN3kgF2wryymptAMfcDaFNrkKLuJiAsyUErO9YYjA2PL3eIfwkNDFMBEKWKXjPKYH8ki8OjP3XsbS4xmwGPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6ryd+DGr0FoL65Dl3cJdwvkkNF5AHTtTkJ3ohHE5TQ=;
 b=aL1DP2cp21cyf8NZAWrGzQ4R309cqwjT9F624+97zQHGY0a8tudfZh8c3s1IMhnNSy+F9jcb7+F1nflaUFTjbJXHAcIQ3SgJKGaU6IgZQ9uY5yZ1MRDtQvRcWf6Gk4h+JIDKc24QeR3Qf2PuTmOuzuR3EGqrOg25dOjtFkPkfjfS7hK+URwupVoCgnrrvra8W1dwtw1rdb3fabrmyGuolDacsf7RuxSOXp/5CWIHm8mpsKNvtSw0QvgqHcK0eOvqKtX4NhnYHUHyNea9Qo154Xvf9n2cBYEn0fIAEdAaX++RMOgK2BLkVbojFrHJmUKCK4faob/nyjavgD6KHWCJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6ryd+DGr0FoL65Dl3cJdwvkkNF5AHTtTkJ3ohHE5TQ=;
 b=KkZnLKGKBzW73oPX+yTC7vBqYCQDt5RdyxnZHY81Wgz+eQjX3Eg0r1FgEqgZx7fLXGn2p8csBZuri9OTXgKKH56yyWGadAbvv3gqUxx+zB1DqJ4PYuvsBWcttrtb7trVjJoB2pHYdTVUKWNshsCJ7Dda0H6y8afY/rZQLsdoLtzhGgJ63J3OCQowr7rH/ounro/CuH3/v8i0sYwMdbFg3elIG/v9vAqyMti2XmcRjbUvVMZh5Gxcyr6HTBuPHPUJMOAIhAZpCCFr1E0umo4oxKXMLnEI/JvEIbjsXV4a9x060TTfztxy2Hqkm2KiaEPoefwK5oSlVxZ5et5uorch1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 12:43:20 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 12:43:20 +0000
Date: Wed, 31 Jul 2024 15:43:09 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 13/17] mlxsw: core_thermal:  Use the .should_bind()
 thermal zone callback
Message-ID: <ZqoxXdQRxhfr5cHY@shredder.mtl.com>
References: <1922131.tdWV9SEqCh@rjwysocki.net>
 <9002154.VV5PYv0bhD@rjwysocki.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9002154.VV5PYv0bhD@rjwysocki.net>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 15299b61-69f7-434f-51bc-08dcb15e5bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vEzUOQi4/MFYJAsNefiYMmcNDrbqhZgFrpOd9vFJ0ctb2f0YtqrmtvUQr2Vx?=
 =?us-ascii?Q?i9tReKELyqs5PxpNIWVCcgaw1ilYpIFwxPxYgopyGP3buKgsUVb2tFzeFee+?=
 =?us-ascii?Q?UqiTPU63AXOBWYDM+Z9keArPt36fcUBLNrvcOAgtoN7sBTYaLKg7HATpqh9E?=
 =?us-ascii?Q?UmTsqLhocrzn0XrCACjkIEZ4srMPS7WG0JCuaCfdECeYIhLi7/QofTA5PtTl?=
 =?us-ascii?Q?LyKYVxWvwiGyuHlQsSpL9o4bMxtmKlLBdaDpOw5V4gfHpweXft+Uh5E2G/5B?=
 =?us-ascii?Q?8wRsl0TJ6F52EX7JosrMEjVRk1QIeKg2k/H1Rb36H2Jjga3R8Ofrf9dv3yta?=
 =?us-ascii?Q?fOG3T/xYkudNhudarpKkFsxXSaL6uw011Lp7+RlXSRwf6zX9hDX0qgonlAf1?=
 =?us-ascii?Q?FfLjjNSOyP2zADJPwbF4c1CvBy4/5o1Xf1AKe65XBji6qbzdSDjOEB6QHAaJ?=
 =?us-ascii?Q?5rZE/dyhu1GTFflaAbzwvXPV3bIUMUgiQOaHZFbpOGomNYx3T7Gk18f3s9j8?=
 =?us-ascii?Q?PLhOZp47P0sEi7c/YrlYZvxzS4tQGyzYwY7HcVSIzpbMWpM+hUDDI09lg4ZP?=
 =?us-ascii?Q?zeXRGaWqgOXswe59f2XsJLquyHmaAUOTlNgfs7LoSbrJoU3OzVm4va/f+3rj?=
 =?us-ascii?Q?bhGbXADK2A1J3QVNRMuCVsb2sexsW6lP4aBY9+3Az26HQvxiKOIfVh3PvFO7?=
 =?us-ascii?Q?vJwnMZsTGIFsVM8lqb1wYuIJ22T0dRyWzq2A6hTZtXSw90wP/m0RF/Ftrfva?=
 =?us-ascii?Q?f7QHmYQfBwkC1cOZCXdbVnpUfezxOY3tzuk8y4RX4ItysSBBQiE0AFsbynou?=
 =?us-ascii?Q?iNAnsYHDjwy0oe5+bHYbV474W6qJRiKtwYb8NZVETvIg6GrXPcg5nXmxAuqn?=
 =?us-ascii?Q?UOTBG3taFQSzY881OeKngP3X0Z4C/PTQ2eSMPRrUSm0NJ4SPpXpdURZq9TSr?=
 =?us-ascii?Q?zAhzfmO9zjnkv662HSIuXH+oCfTWapc/KaXt8PQ7a/zYAeimHyl9Fpo19GrV?=
 =?us-ascii?Q?M9qUMjJwd5tLEIF8820u97WRvL/WZtGce01TjtX2Qydaf9VMG17LzJaTOGnZ?=
 =?us-ascii?Q?bwPD4NM89k5xdHR5zn2JDD7Jf7j1tRVgvJBBG8ypzQPwp2rez6nVITpxmH7I?=
 =?us-ascii?Q?IrZkRDgCMXxJexzevEQ1x4mo96uxhLG/PzqJ9ceml0zaWr8GVkdaGLeTFUb1?=
 =?us-ascii?Q?2FkEqrsgcoJQfcoxX2m2SxkBrDjol9OEh+rQNWj47CSgIqOd/keObbK3a874?=
 =?us-ascii?Q?OQsakWDF0xM99gMBWD0uomJwrIT1y3MCorBYK+M+yQiL/W3rSi5EdX+O1+V3?=
 =?us-ascii?Q?uLMY2gKS/SSiHkC6FkB0dm99CtmLmfKNIkr2lvCuWQLVQAdzOAOHBsdxGzhl?=
 =?us-ascii?Q?njo4Wfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTt7A65mLyEVyYD5l2Q/cnHggsdF8CygKnyM13fStG0EMWTx19Fx5R4Q2M1p?=
 =?us-ascii?Q?AKJseNqUKwthKJTms2QoGELSRMxIcLaSxpZXQpv5ylkwdVXHtXBj3CIPagXP?=
 =?us-ascii?Q?kkGRkoOFzB2TRfdnsI14Kpuddc4beFK6i+UlXDd+WCeXmQNcRH15OfyYpOqm?=
 =?us-ascii?Q?I9q3VMUYnHcD6dH2FJv9ulbjmKwhbRwebxZjp00ZZo95wmZmgwNndE+A/ArW?=
 =?us-ascii?Q?9tyC/+zuX7Dyp+gYJ3y+kw8IKW8+EwL7GUS5u4ekVl53qLAx35M3ddqFjJfz?=
 =?us-ascii?Q?+z81ss2iNuetT+0xtEsYFlBEmtMyX65r2Ko38i3TW1O078iO2Bcu6HxgVTSG?=
 =?us-ascii?Q?coFaqMz92EoAnvKXAuAfDP0FdQ2FNedYKXsjTEOe/0CinpHX7ShM968FKh9W?=
 =?us-ascii?Q?Ih8NUnGzeXjrGvUdZT2sT4cKTEhmKqnqYQC9N74uAqFy3Mud+2ikUubFjijp?=
 =?us-ascii?Q?JMzsO4FkEFQOYUef86G1YlpmUYQLAavPfeFXj5jJB3aWy+55285SGEPD4fg7?=
 =?us-ascii?Q?db4p43T3X5MjjkbS87AtUBCpgDI89MRPxBLb9OOGHkMdnWPJxHgzbzwNHg1M?=
 =?us-ascii?Q?tA5ctj7Ol1FcqVIiii2NHSp44ZAh43KH6KKvXJmtq9z5aAEhl+VA7b3pokGi?=
 =?us-ascii?Q?vEwnGnI9Ep2fpF5BG+83svxtfrZrR0raKKxWeNftr1gElNfoNcQCcG+tebz+?=
 =?us-ascii?Q?2ZmseXx32aMGn+m9q8vkG+AiPWHAJzJKtJnAM2VCrdwiXI8+ShPKCL/621CO?=
 =?us-ascii?Q?dA005RMd2dJy4miZVEM/tYFmE+PgFShwptPkmzG/wCUkozOuCzS/zxnTYOco?=
 =?us-ascii?Q?zPFHLfVgktk1LMuZ1lsKtpkFWEBvm72hvcp8RdRNACp0rFS2s3g/0t24NQhq?=
 =?us-ascii?Q?sf5G3PX09wlqN8nTM9xqzxSPdTgYVWWwTw3es6q7pVeElndewR078GqbBSln?=
 =?us-ascii?Q?vrcy2bFTd7raMhLET1Y80+brHSWSYR0I544paLwd1iGG90M7l90HyFomnmnS?=
 =?us-ascii?Q?KrmkXk8M34pzXluMBIPPq1yAo7cgCVxwt+K+eHI1oAO9zxPjtjGrVbt3QWOh?=
 =?us-ascii?Q?ihNAzxCJZzspYFOZW7Eq09h9fmJv7SgoYsqVzO9P4oFQMi6OgTLz8hp6Mh0t?=
 =?us-ascii?Q?IUudbEq12HB9pzd41LRWuT7zo+raQGeNb9YTbNaufOck/OT4jB2kKNdKJk/5?=
 =?us-ascii?Q?86lx67ZhrMDb0zx2jhEf58PULXdN+w7fzowRL61vxeiVzQX3dDW7z2qEOqq9?=
 =?us-ascii?Q?PM5pmrFLaDiUmcIyRtHeUJLLpA3BIr/IJty8gx0zKI0tp//knM+XEhGnxg2L?=
 =?us-ascii?Q?JAA/LCZNHmuDnNN0fdk0hwwNML6ABMO3ksrX/Aqk/5Q34qJy3GtKoGUJeJIN?=
 =?us-ascii?Q?8jrGoNl/nJP7b/BQQCcfylNPG8VDhrqo7KwuVOcF0JJ+GlR1/ZZ8xnDTogc8?=
 =?us-ascii?Q?Fc0mLmARApy2DS6JjYIBx3ehWco+HQ/gBzpOa6t2hwov7rWRnUOxCmNuTccS?=
 =?us-ascii?Q?XX2rPXZDBUDCgDLlqYr1eVqIVrfVJGP2IUK5oC3qACW89oMdjx5Mr5Sow4Vh?=
 =?us-ascii?Q?oyO0zhwPh0mfolN13Rxuj8eMfty7mzv3C/KIgFuH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15299b61-69f7-434f-51bc-08dcb15e5bd3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:43:20.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw+KSp1+YJmZvfYVdUoTgbfQaJW3aE3lq+mR8TNpDnpvPFaW01mCFvmvkAlxljl0VQ390HKLV3NlVhxbqQI8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165

On Tue, Jul 30, 2024 at 08:34:45PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the mlxsw core_thermal driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> It replaces the .bind() and .unbind() thermal zone callbacks (in 3
> places) which assumed the same trip points ordering in the driver
> and in the thermal core (that may not be true any more in the
> future).  The .bind() callbacks used loops over trip point indices
> to call thermal_zone_bind_cooling_device() for the same cdev (once
> it had been verified) and all of the trip points, but they passed
> different 'upper' and 'lower' values to it for each trip.
> 
> To retain the original functionality, the .should_bind() callbacks
> need to use the same 'upper' and 'lower' values that would be used
> by the corresponding .bind() callbacks when they are about about to

Nit: s/about about/about/

> return 'true'.  To that end, the 'priv' field of each trip is set
> during the thermal zone initialization to point to the corresponding
> 'state' object containing the maximum and minimum cooling states of
> the cooling device.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Please see more comments below, but this patch is going to conflict with
the series at [1] which is currently under review. How do you want to
handle that?

https://lore.kernel.org/netdev/cover.1722345311.git.petrm@nvidia.com/

> ---
> 
> This patch only depends on patch [09/17].
> 
> ---
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  121 +++++----------------
>  1 file changed, 34 insertions(+), 87 deletions(-)
> 
> Index: linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> +++ linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
> @@ -165,52 +165,22 @@ static int mlxsw_get_cooling_device_idx(
>  	return -ENODEV;
>  }
>  
> -static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
> -			      struct thermal_cooling_device *cdev)
> +static bool mlxsw_thermal_should_bind(struct thermal_zone_device *tzdev,
> +				      const struct thermal_trip *trip,
> +				      struct thermal_cooling_device *cdev,
> +				      struct cooling_spec *c)
>  {
>  	struct mlxsw_thermal *thermal = thermal_zone_device_priv(tzdev);
> -	struct device *dev = thermal->bus_info->dev;
> -	int i, err;
> +	const struct mlxsw_cooling_states *state = trip->priv;
>  
>  	/* If the cooling device is one of ours bind it */
>  	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> -		return 0;
> +		return false;
>  
> -	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> -		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
> +	c->upper = state->max_state;
> +	c->lower = state->min_state;
>  
> -		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
> -						       state->max_state,
> -						       state->min_state,
> -						       THERMAL_WEIGHT_DEFAULT);
> -		if (err < 0) {
> -			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
> -			return err;
> -		}
> -	}
> -	return 0;
> -}
> -
> -static int mlxsw_thermal_unbind(struct thermal_zone_device *tzdev,
> -				struct thermal_cooling_device *cdev)
> -{
> -	struct mlxsw_thermal *thermal = thermal_zone_device_priv(tzdev);
> -	struct device *dev = thermal->bus_info->dev;
> -	int i;
> -	int err;
> -
> -	/* If the cooling device is our one unbind it */
> -	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> -		return 0;
> -
> -	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> -		err = thermal_zone_unbind_cooling_device(tzdev, i, cdev);
> -		if (err < 0) {
> -			dev_err(dev, "Failed to unbind cooling device\n");
> -			return err;
> -		}
> -	}
> -	return 0;
> +	return true;
>  }
>  
>  static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
> @@ -239,59 +209,29 @@ static struct thermal_zone_params mlxsw_
>  	.no_hwmon = true,
>  };
>  
> -static struct thermal_zone_device_ops mlxsw_thermal_ops = {
> -	.bind = mlxsw_thermal_bind,
> -	.unbind = mlxsw_thermal_unbind,
> -	.get_temp = mlxsw_thermal_get_temp,
> -};

Is there a reason to move 'mlxsw_thermal_ops' below?

> -
> -static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
> -				     struct thermal_cooling_device *cdev)
> +static bool mlxsw_thermal_module_should_bind(struct thermal_zone_device *tzdev,
> +					     const struct thermal_trip *trip,
> +					     struct thermal_cooling_device *cdev,
> +					     struct cooling_spec *c)
>  {
>  	struct mlxsw_thermal_module *tz = thermal_zone_device_priv(tzdev);
>  	struct mlxsw_thermal *thermal = tz->parent;
> -	int i, j, err;
> +	const struct mlxsw_cooling_states *state = trip->priv;

Please place it between 'tz' and 'thermal'. Networking code tries to
maintain reverse xmas tree ordering for local variables.

>  
>  	/* If the cooling device is one of ours bind it */
>  	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> -		return 0;
> +		return false;
>  
> -	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> -		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
> +	c->upper = state->max_state;
> +	c->lower = state->min_state;
>  
> -		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
> -						       state->max_state,
> -						       state->min_state,
> -						       THERMAL_WEIGHT_DEFAULT);
> -		if (err < 0)
> -			goto err_thermal_zone_bind_cooling_device;
> -	}
> -	return 0;
> -
> -err_thermal_zone_bind_cooling_device:
> -	for (j = i - 1; j >= 0; j--)
> -		thermal_zone_unbind_cooling_device(tzdev, j, cdev);
> -	return err;
> +	return true;
>  }
>  
> -static int mlxsw_thermal_module_unbind(struct thermal_zone_device *tzdev,
> -				       struct thermal_cooling_device *cdev)
> -{
> -	struct mlxsw_thermal_module *tz = thermal_zone_device_priv(tzdev);
> -	struct mlxsw_thermal *thermal = tz->parent;
> -	int i;
> -	int err;
> -
> -	/* If the cooling device is one of ours unbind it */
> -	if (mlxsw_get_cooling_device_idx(thermal, cdev) < 0)
> -		return 0;
> -
> -	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
> -		err = thermal_zone_unbind_cooling_device(tzdev, i, cdev);
> -		WARN_ON(err);
> -	}
> -	return err;
> -}
> +static struct thermal_zone_device_ops mlxsw_thermal_ops = {
> +	.should_bind = mlxsw_thermal_should_bind,
> +	.get_temp = mlxsw_thermal_get_temp,
> +};
>  
>  static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
>  					 int *p_temp)
> @@ -313,8 +253,7 @@ static int mlxsw_thermal_module_temp_get
>  }
>  
>  static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
> -	.bind		= mlxsw_thermal_module_bind,
> -	.unbind		= mlxsw_thermal_module_unbind,
> +	.should_bind	= mlxsw_thermal_module_should_bind,
>  	.get_temp	= mlxsw_thermal_module_temp_get,
>  };
>  
> @@ -342,8 +281,7 @@ static int mlxsw_thermal_gearbox_temp_ge
>  }
>  
>  static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
> -	.bind		= mlxsw_thermal_module_bind,
> -	.unbind		= mlxsw_thermal_module_unbind,
> +	.should_bind	= mlxsw_thermal_module_should_bind,
>  	.get_temp	= mlxsw_thermal_gearbox_temp_get,
>  };
>  
> @@ -451,6 +389,7 @@ mlxsw_thermal_module_init(struct device
>  			  struct mlxsw_thermal_area *area, u8 module)
>  {
>  	struct mlxsw_thermal_module *module_tz;
> +	int i;
>  
>  	module_tz = &area->tz_module_arr[module];
>  	/* Skip if parent is already set (case of port split). */
> @@ -465,6 +404,8 @@ mlxsw_thermal_module_init(struct device
>  	       sizeof(thermal->trips));
>  	memcpy(module_tz->cooling_states, default_cooling_states,
>  	       sizeof(thermal->cooling_states));
> +	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++)
> +		module_tz->trips[i].priv = &module_tz->cooling_states[i];
>  }
>  
>  static void mlxsw_thermal_module_fini(struct mlxsw_thermal_module *module_tz)
> @@ -579,7 +520,7 @@ mlxsw_thermal_gearboxes_init(struct devi
>  	struct mlxsw_thermal_module *gearbox_tz;
>  	char mgpir_pl[MLXSW_REG_MGPIR_LEN];
>  	u8 gbox_num;
> -	int i;
> +	int i, j;
>  	int err;
>  
>  	mlxsw_reg_mgpir_pack(mgpir_pl, area->slot_index);
> @@ -606,6 +547,9 @@ mlxsw_thermal_gearboxes_init(struct devi
>  		       sizeof(thermal->trips));
>  		memcpy(gearbox_tz->cooling_states, default_cooling_states,
>  		       sizeof(thermal->cooling_states));
> +		for (j = 0; j < MLXSW_THERMAL_NUM_TRIPS; j++)
> +			gearbox_tz->trips[j].priv = &gearbox_tz->cooling_states[j];
> +
>  		gearbox_tz->module = i;
>  		gearbox_tz->parent = thermal;
>  		gearbox_tz->slot_index = area->slot_index;
> @@ -722,6 +666,9 @@ int mlxsw_thermal_init(struct mlxsw_core
>  	thermal->bus_info = bus_info;
>  	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
>  	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
> +	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++)
> +		thermal->trips[i].priv = &thermal->cooling_states[i];
> +
>  	thermal->line_cards[0].slot_index = 0;
>  
>  	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);
> 
> 
> 

