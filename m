Return-Path: <linux-acpi+bounces-14079-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD95ACBDB9
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 01:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637B518911D3
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E81F8690;
	Mon,  2 Jun 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="DHMD8Wk4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4A13C8EA;
	Mon,  2 Jun 2025 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748907716; cv=fail; b=dA0ABtm9Vdxg9APlPsT05Bbk4pcnQG8IpYlllbLzHk1A7OwjeR31adEuF0WtBCkGE06RncK9eB2o2+OLNeIWf8mzIwuP0fxkzBYDKDrQOWNMmAauJz9Osm3qNzno9ldSleT97hWaMrc424EviJPUvRze8XOZwZCfJrXorbGpBKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748907716; c=relaxed/simple;
	bh=eWdX9jMc+a3oOW+gr5Eu1n3m8jPg5b4LgRQMuK2MXtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTfsDDBOhj+JdSxWUtcVGdL52kPpBo7dIBjXFCTvTIRGAgVzks6B4AyI/08F4lu3wLIGIzo6tfNMwswRt1cRSVAkTa4jnsBsLK+0AaA4Kv8EAwzr/gKK4lQvJzKZ10QLzNNcpVf/+uEm6wS32USQjHgvU2xpk2ruJhdUxq/vAu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=DHMD8Wk4; arc=fail smtp.client-ip=40.107.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPleIPGJmf+i6h6AlHwjg5FvOTv2iMgptoui1k1NVwXVAKM+5WIoZ4OHIVQficChEs1KwOE8qcuY/eJhwE45zQw0BNnojd+fMbDSKLi+zi6eQThz20qwBYp9O5pXoCWhxuVHRwvtkbaEbSxa7LVqfe3LOCFk7qb/c3yEvai9JHZPnLEKLwgfS3X8XCm2+qiQ2VcGLhBq4nsQJT5TiSoMekwv3qq3M6F+VoSAw/cdVt4Nws9So0QbNfrxEQR3i4V275w8K4uFViGrHZ9rVh2g/4IvzmzO0Vql0CZ3tgG7ykVO19Dukt0LK4MUoHqvaAxDKRuXszvhqQTnfnraOsOarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vwkTBh4JQ9nF+CaLgkCm3NRKbu/y59WTgzZVmz7mTI=;
 b=FX8LuRTv9Ax5J1iPR6842SjpIZvm+0dqJMykfvPFMKitfzElw2ErfwGwltJXHXowKJL8pgL6I5g23zEfqnOqvwpl7hry3IHkC7+l4dIAbm9ClL9FXMuGlyRC+mW1Jn+3tRLhaVtA090++bOSxOby9wbALvtB3hs+wSUQtUgLRMLNBWztQhuj5gBW4hxlbnEi0Iq/F4dIAIuWsGWNF55FN5v8hJLqgQbRSCPqeMeWdBhcyc2R9NU0Is4pKy1+nvXoogiiDfTuS2kcoNw/etEw8sPxiCcFDOiUYBajww7TI0YnzlKSZb3M47D1nOCDOfpRJTyWjCcCh33P+3QZ6QYhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vwkTBh4JQ9nF+CaLgkCm3NRKbu/y59WTgzZVmz7mTI=;
 b=DHMD8Wk4sLim1k7kGOx3LIAlhafIPa/4w1SJoPv0+Szj9sOQ5vsV/2GIyfAznwm9iz6gtZN/HDSuGcd/ObUFXYqaguvh44YUPgp9nQmP5CDKITzqn0lJFroo1uhw0ZKMjVu47RTy8EYcgVL/w4W/HasnwPiuUihs1gl2TYcyd1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CO1PR01MB7338.prod.exchangelabs.com (2603:10b6:303:155::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Mon, 2 Jun 2025 23:41:48 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 23:41:48 +0000
Date: Mon, 2 Jun 2025 16:41:46 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aD42uvVCULZkUq-m@zaid>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
 <aDuBjopy_nE9A-ph@agluck-desk3>
 <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>
 <aD3ZFyBW4SCyaGI9@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD3ZFyBW4SCyaGI9@agluck-desk3>
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|CO1PR01MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 9926a38e-29e6-4c1e-5d3c-08dda22f0ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nzjCUjBM18HJI7IRcoLFMsjrvG9sz3/4xb8c3pQ+3fIhIUN2tLLdilJQNst?=
 =?us-ascii?Q?X5mues0FXuQrhG2ex9X/mNmKav459ueYwv5hRjnDpQwOpiVt+syLXd6+rJbT?=
 =?us-ascii?Q?33jL+g1s8fz2J4hD0EfiE0PSB65ApgkDM0sqvSi5cq4n8JI3IL/neJyPcvmT?=
 =?us-ascii?Q?bnezAlbZCOnnE9VKkN9sFVzHSLwlmylI9HOWU8Qo1jEeokrDq3Rg91nG9cmP?=
 =?us-ascii?Q?Ham79Z+bvCgPK+PgEppyHnYakw4NpP03FiBPZdh0cdauGEf1Ra+rabtCew09?=
 =?us-ascii?Q?DjlJNQguLRgb8rmCcCHDvhurXpgMuI7KILvWdab0K9qBE5YLjkj7Qoek24R+?=
 =?us-ascii?Q?jE936eh0lVDjzoynOVt/FPbsJ/qMapvSWgxzhL1wokePxys7o5iBXY3XkE2M?=
 =?us-ascii?Q?tISvotSO5jgWxs1UgRpv4pUcPgBBF/dDjwjohl2uWBYrbo7ExSZOvG+XYdy3?=
 =?us-ascii?Q?pHXj34xVIXHoicqq/Vl2kfh6YNQD2w9aIdMGD6EuZyy66DoCIZl1PNcgApKa?=
 =?us-ascii?Q?GKo/kNSROxYo6lU2hyTO+g38D786I8rHBkWfbjm7GOqZ3rMvtRWCkKROU8Te?=
 =?us-ascii?Q?8/klta9KnME+8p29Sj7GVe+UFJCjCS7sAKtKy7WJjMqy58D1G8dz3yegPf7j?=
 =?us-ascii?Q?ZSu+7qB9rj+WFPZuqS/6iGztIT0IbX7U2COjC8mXsfik3cIyf3LkM22fbKqb?=
 =?us-ascii?Q?k0ttJ1T3kouPiGa8L8IW46VTJl/w7ot8ZJDTcqYbfdPxHAP2eRe5NVYJNcCJ?=
 =?us-ascii?Q?Hxbnh80RgId9P9TVFKQqnppj/obRJVx7U1C1hziHNX0ey9pXLc4vPHuCHlXS?=
 =?us-ascii?Q?3o3a3JIlotW9zwzVx6y/zyhAFlQa+3pk2TkS0qXc5iXeaMPxgwxDKGqaq5/A?=
 =?us-ascii?Q?Gve3BwALhv/JPk9C9SV0CbEQILH83N6yhuAdM3tDhhnIIM1oRmwA/SNPisWT?=
 =?us-ascii?Q?8gDbj5CTD+6ZrpHXw1pCnyLoA5UgfsNVv6tl4XUaBjNbmDUF3BtMeU3CBmnG?=
 =?us-ascii?Q?BCOZc3ywUKefZ5VbeQwQaitfV8ObLjhIAzJGkb5MBSNrvAI04UwCCeqsQlwY?=
 =?us-ascii?Q?JW2wqOoPe4Deao6md54+ySI0TDxjVo9ZEZXN3SY2MJc859UTzC+rOpvGiG8L?=
 =?us-ascii?Q?W7sZxjaboGbh/SunoFwZyGH7/gyiihSu8NzrYR/tS7qsW3MMHni2v4thgNRI?=
 =?us-ascii?Q?wl6wI+vbrQh3KRUvJYL+qKzmxcFiVBOceCfkD9BXFNAFXaNTjYke/f/CE0+7?=
 =?us-ascii?Q?9wN+N2rmUcRFFYQ9XmIG2zmoC4itA0D//fqRx7yDoU4uHp6P5Rndnhbwh2ar?=
 =?us-ascii?Q?gwuT9/XImeAxHYxzXPbGomizA3zLdFAN+DJIDBfBcUogflCia5IDQoYUOB2N?=
 =?us-ascii?Q?NlMMxqG9+2ztMTz73xB5J7qgeATBZfzNhfx4YsRHO35Sn4cJR+xs8BVXp76B?=
 =?us-ascii?Q?TNZkkingABE1iHg7Sknx2ShOubMupA9b0kbUoICEMiWSWwUyO0jQLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D06PeucQGiJau2xNg9ZYEZjNsrMlFrOACfB9H+K8WcvxGgcuaxTublmite5Q?=
 =?us-ascii?Q?PUmyPbgZncwZm5WYeASvBJ0GfsCbQpsSASuwyrIsUx/M1w5umoh1UIcbhOOJ?=
 =?us-ascii?Q?5tyg4+JxuzqAQYeZDiOZwDYhovVcKajqEGCX4fVc5WCchSza9XHvOmGCAM5P?=
 =?us-ascii?Q?NcO7NMNq89DvMFoC7bfLzdVHdGVGzsSUnPuhGwhsXo4Yi45de15VAzWUCVGw?=
 =?us-ascii?Q?W3KnhZ2zANlTQCeo7qGZ0vMrwB0g2/zuZblwXSjUkaCsVYukwfPOGk6Sdwn5?=
 =?us-ascii?Q?3SJ7S2qmq08QxX9rb/mFGeUP/DgqHrWeHsCDRbSX8qA+wYpjXUn15CEtjVTY?=
 =?us-ascii?Q?MccdUz2+G68qnERv1gvvz2BcMrL0x+zKZ7dlWBEBV5gPbEWn4dbyPydTbLpv?=
 =?us-ascii?Q?Ah8mA6QBl7A/2aNgz0gDe9GFPn0Wu8FWLm4Ti0atIx9Xlb3XQUUDkOUY3hLw?=
 =?us-ascii?Q?VNz392c1hWknxFHqQjtp2Qo38tS7/BO7s7tAtcYaw88+NcSZkvfn4oJ+y23m?=
 =?us-ascii?Q?V+QGbXJHwXYNPrJ/LtrQutbjertS8wBMES+2adDGMiTJdABI3P662+4xSgeQ?=
 =?us-ascii?Q?0TC602TA9AuSXuFz8CYPW7+TFAGsj9Q9TkgRbCbAh5uk3fOZBHJ5+Qe6+MrQ?=
 =?us-ascii?Q?g9S7dIPZhyG0Nd3TjZm8jtgYbsBBQfJxcq25kDrLP6ZImBQPC1MCXJuv3U/5?=
 =?us-ascii?Q?ZtsxwDCctfIs+arNGBC8+DXz1PsBt8eoJUQ9eRNqYanzVK2NS9NGYbbRvHgS?=
 =?us-ascii?Q?QHXuJyakuNdrLjUafIIQBoitky5Vb/Ox3secFM597miL07LnPTdfBg4fcLC8?=
 =?us-ascii?Q?pf9Zi4+v8ISUzlO5O2V1GxqyhOX88xvhlUxTptPAsE9FhirMjzO+4C+sE/UH?=
 =?us-ascii?Q?F3L9c9ZdSUWd9ms2/ShfQSPVRlwPfuDHTEnaC3IU8Hx/u+dth9HkHNtfQ1nT?=
 =?us-ascii?Q?TJA2vLXZ0Sgc9TgTDawLHlHy6QJz9b4cjgYCXxPGkXDGTy5xApZDFkpp+GNq?=
 =?us-ascii?Q?+GZG1jmW29QApuBmx6kiILYInb5eANJUXqsjFhAUzoIqXi6PLA2oiSev9oJT?=
 =?us-ascii?Q?AtPvAHL3FqVFXhciQq2w5uq8o1k82r5yNbYoHA4vdqJENz8EI72vpSS8t85P?=
 =?us-ascii?Q?OFhP7A0vr2l1ES0v7VleqM+hQCuomzZj75+YFKSeri6zPBrg8DDPVPIzryD4?=
 =?us-ascii?Q?r2BJUmiLLlHu14B7n6JrIF/Lt1DyzPyIrErRER1zlKgW6EWzV3RKEdNltdxM?=
 =?us-ascii?Q?GuuURR5L1/kycu1u2I+2D1Yz97robcjyFPTF9oDsfh95PRXFUp2r71Ia/AhF?=
 =?us-ascii?Q?pgNjOuyIrsrcRrppDo+cUdTLdgOeMUHfHdsaD4XgcCZfI740NOJMbkLlH3AJ?=
 =?us-ascii?Q?T4AVVPfuDq39yKsWCK0rV519FiR6d7a3oiFRdv/9rirTSysV9wF77ZAmzvu/?=
 =?us-ascii?Q?MfmQxjDeIlMmPqH13TOxsVSPZe0H5IBp2EqBEL769THFMWZnlqQLr/y06eYW?=
 =?us-ascii?Q?90Qvc+RYzLfLa6LEkTuIuiCS8twd2TNJDmH5bMXVnNk2KZiOK68zrGxq5Wjk?=
 =?us-ascii?Q?kYuk9jiUvpPc7h/zE51SM2svB8Xp1ShzixCef8Y9dwnx5FsRXkn7csxBlsXA?=
 =?us-ascii?Q?ID/a3fovNa10AeFRETc6gII=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9926a38e-29e6-4c1e-5d3c-08dda22f0ab4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 23:41:48.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqno4q8pYBFKtNHlshXATAK1dQHqz3cLLtm38JI9HU8IPrVaZ37mSCfmnAIEckHauxlsZUrTo4TxalF9jAPDVmgMAW2/kmNp0fcp82zFOe4FQmP1D2Et7q2EjmCguZAF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7338

On Mon, Jun 02, 2025 at 10:02:15AM -0700, Luck, Tony wrote:
> On Sun, Jun 01, 2025 at 12:25:54PM +0200, Borislav Petkov wrote:
> > Some questions inline...
> > 
> > On Sat, May 31, 2025 at 03:24:14PM -0700, Luck, Tony wrote:
> > > EINJ V2 allows the user to perform multiple injections together.
> > > 
> > > The component_idN/component_syndromeN pairs of files direct the
> > > "where" and the "what" of each injection.
> > > 
> > > But the kernel needs to know how many of these pairs to use
> > > for an injection (to fill in a field in the structure passed
> > > to the BIOS).
> > 
> > The kernel could realloc on each write. Or we could allocate the struct to max
> > elems and trim it before passing it down to BIOS.
> 
> The actual structure passed to BIOS is the same each time. Just the
> set_error_type_with_address::einjv2_struct::component_arr_count
> changed to indicate how many errors to inject.  In theory the
> driver could allocate and copy a correctly sized structure, but
> Zaid's code here is simpler, an this is hardly a critical path.
> 
> > > User interface options:
> > > 
> > > 1) User can zero out the component_idN/component_syndromeN pairs
> > > that they don't need and have the kernel count how many injections
> > > are requested by looping to find the zero terminator.
> > > 
> > > 2) Kernel could zero all pairs after an injection to make the user
> > > explicitly set the list of targets each time.
> > > 
> > > 3) User provides the count vis the nr_components file (perhaps
> > > needs a better name?)
> > 
> > Yap, agree that the name is not optimal.
> 
> It can be dropped if we make the user zap previously supplied
> component_idN/component_syndromeN pairs that are no longer
> wanted.
> > 
> > User can inject into each component pairs file and the kernel can put that in
> > the tracking struct. So you have:
> > 
> > # echo 4 > component_id0
> > # echo A5A5A5A5 > component_syndrome0
> > ... set other files and finish with usual
> > # echo 1 > error_inject
> > 
> > <--- here, it goes through each component pair and builds the structure to
> > pass down the BIOS.
> > 
> > And you track valid component pairs by setting the IDs to -1 or something else
> > invalid.
> 
> This is just an improvement on my "option 1" (improved because all-ones
> for the component ID is going to be invalid for sure, while all zeroes
> could be a valid component).
> > 
> > All those component IDs which have remained invalid after the error_inject
> > write happens, get ignored - you gather only those which are valid and inject.
> 
> Or just stop collecting on the first invalid one.
> 
> > And this way you can keep the old values too and gather them again and inject
> > again, over and over again.
> > 
> > Right?
> 
> Yup.
> 
> -Tony

Thank you Tony and Borislav, this is great feedback. I will update the patches
and send out a new revision that uses Tony's UI for the ID and syndrome.

-Zaid

