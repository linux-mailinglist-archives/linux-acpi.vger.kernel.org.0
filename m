Return-Path: <linux-acpi+bounces-13632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E7AAF1F7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 06:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67AD1BC681A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0DC20299E;
	Thu,  8 May 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/PDqALe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52119DF6A;
	Thu,  8 May 2025 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677357; cv=fail; b=SZr+cCXpUWPNL5EYIgUmLcnbows8J24NsZ/qj9N4WToNKpgQ55ZYz4vGMtuTBcXQZPSV7WlhBnV9fengBQGaCXt90qTaYrOUtea6r/+Sln8JTRzBOaaTWNgZ8VCzi9tAyf44IqvBSISNlfYq0es/36GCM4pV4dWlkLjwynspa3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677357; c=relaxed/simple;
	bh=iF273EbZL0NPj0M1YmtHWyLI5hyTirN7Xah4KnG3pnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OBV1O6JOmB5j749+Sw6fu4/ZOKFiRUgM2jRTzyUnPEWaA4R594qzDDqaWSBJqcatL4BzLIY7ylPHJKqIlHs0L4k6SPuTVSNPEz9QIN8hsXopmb55nBdQTMa9JlSL1Xtq+nHJrnpzVaWoPEZ4tCX6YxVN3BfKbKXpf0mY1zBdanw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/PDqALe; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746677356; x=1778213356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iF273EbZL0NPj0M1YmtHWyLI5hyTirN7Xah4KnG3pnU=;
  b=Q/PDqALe3rG4JwypPqwKYXMCnLLEjSd7BwCp4bQOmVU9bafqVoCb1Vd9
   zIIFQACdQseAA9DpdUD2pqL7i3UyYM4RH6jiGhh4PeqeH/z/U67ibltg9
   xf0gfWlFstB6OWT9b3PSlDohXmNoajNIhyanl+UriB6GfId725lLfVtju
   4iOZf+W59G55HPptN4LbKtjTbPgtFLcbHFch0OWjPthlhgffeU7EQVSnK
   Ew3Cxnyz146KEZP5BSr+VhJGJWUI1wGzrXQorI6VIu6mHIww1c7H2v0aW
   ZCme5SY5nmQmvbbrLRNR8kx4Jcxzteydnag+0ilMbHC9PK/IPsikjnHax
   g==;
X-CSE-ConnectionGUID: 9DlZP/i1SoO8ZeWQ2E5w6w==
X-CSE-MsgGUID: uI2RypLEQQm5aXp7WQ5z+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48591010"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48591010"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 21:09:15 -0700
X-CSE-ConnectionGUID: G5EAW1GeSCKSqj6fy4f8+w==
X-CSE-MsgGUID: xDhSR8ldTsijqRoYZinWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141044619"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 21:09:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 21:09:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 21:09:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 21:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7TdzLFZBAfMy78VK4AgfKRZKXDSu8egiVs/5OSxYVXoNutNKcHJ0winROoFAlB3KidXyvDfx0eFn+Kq6SMWClzxT/OuindnTGluAEEONsWLaHGr/rZFZufJeTPvu8HqduT9gv5PLA0s6FojZb8j1ZdDJ8pgJp7+qErzsDobeSLxoWrfVnplfZnciE7zpX0sSxC9dCnw2u0rY9vPDxpEISZMOp4495Js3jo+x3+IyW9urGEUmxb9wqjTdvA7JYjszbzGGHvJflh3AbQRddz89YbQWf+tfe4fkaMshFYHIDrHo767KjrN90oj/tJuaFhC8soam5XUOcaY8jNnnOYEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PWN+BluTatj1P0iRQ/m8yQrO6vK4PrXEiEZmSyOvvE=;
 b=u8Tpvw/t77z/ZPrrgKtEfg8owiBkfO1Fta7gY7E/p2CfdideiiG33s3uXPy2Tp85c0MUXBOErtzm3Uq37EKNujmO4WVNhs3xpFV99hOukqir6QgKVkiieIeKGshl4aqeHmzXGkhcmWnORY4fKmdUA20s3noJnpSwg77WWmKZ9KxnYOwmNcmG27S8RNhdTNKfn5ZQGOwhDdhVsnN1oJse9wW9DD4gBFLFbTSV7ZW4lqOHd3ECufngUITCdESj6tZpot13DMn3nAg6PuXwazHRc70dGA69FySm2B5HP8MFaboJbVXZl6IM0NtDp+0rUX4+nVjJNRMG93nqWge4WXXOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 04:09:11 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 04:09:11 +0000
Date: Wed, 7 May 2025 21:09:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<rppt@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<akpm@linux-foundation.org>, <rrichter@amd.com>, <bfaccini@nvidia.com>,
	<haibo1.xu@intel.com>, <david@redhat.com>, <chenhuacai@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<chenbaozi@phytium.com.cn>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: introduce
 numa_add_reserved_memblk
Message-ID: <aBwuY7Rj3mpr5Pm4@aschofie-mobl2.lan>
References: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SJ0PR11MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ee5472-faa7-463a-7309-08dd8de6168f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aEIgCnNuXDdlZ4jHKJHCNfaemOOoBBCQHFBkv+qC+QqC9HvGOZ+dxk5dYNg+?=
 =?us-ascii?Q?vpd2D/BChjx256dfjJtmIBddgBhzsMZkGiMjBxBvQbSp4KAYYcd3K++XBn9J?=
 =?us-ascii?Q?S+be2cb1CM4K7pWC66n4VZcKMW6xVn07CMXzSZkD/31ToojkmurTUhQWUeLt?=
 =?us-ascii?Q?PoLjMPqox1ZdX1caJxaWzgNkyFRb8lNKSo2PfjYbHmdh8b4Fm8famd/HWJaR?=
 =?us-ascii?Q?XHRCbfJz11xsipUkP//IZOnosA7nOVdS4945DarVOIJsRRQSDigqYVxbCEpn?=
 =?us-ascii?Q?plExxKcnXzzmzBbKnPVYmPkJB2VR9nDYYmDPuhI/BozYZU11PjszVbcvHPbW?=
 =?us-ascii?Q?j/oSsnF3AebhE6Y+rEhCPpBp+1DUwfjCG2vvrq3GpRtQPwD5RoDd/irhlx3P?=
 =?us-ascii?Q?y1xdHsCm0KAVmKZiyryU6iqkbYi0B7890SwEUiT7zMYgeITbp3U0VNi/wmxf?=
 =?us-ascii?Q?SUqzA6YCQaewhHaykzE5EvK7HbCCD2rPmE5OpjBxPxkdK4fotA3bnwpsa0YA?=
 =?us-ascii?Q?jAIXZI8TFIt3AMxX2VsRanSrpRJnfM075UlN/6PTFJxiCxwXIvxwTrA59nSO?=
 =?us-ascii?Q?rWsU65sErK1O1wo+gwr0Kj1cK1kofm7Gp2RSmw/7rBEJjxQ7KJYrNo351Dkl?=
 =?us-ascii?Q?jjO3h5+JZuaPWmKCMmRwDkpzYnDyUlWu/bRVF0tDyDxYvR2eT5wiwJzMu9Cv?=
 =?us-ascii?Q?S93ow5N5fO5SlGUyUFe3YInhN8GGMMoXAQ2CukmbIKaWQrxKPg+vn++8X5GA?=
 =?us-ascii?Q?dqDJo8GaC9dg9VGzTi/Hd1VBEJB8Ec0FtF2nofgmavCJIDw6S+XrCVO8thAA?=
 =?us-ascii?Q?8LGKdvEsfbnHEpKWngFKwUkVpONSg/nw8EHRx4FcTDmZK0gdmoaB6nevXMZa?=
 =?us-ascii?Q?1XbKRU6Garwj7hNBlEvzp+ery8vVciAIMwnjZnVabJvDhu5uqAuuLcwG1IG8?=
 =?us-ascii?Q?OBKIoY7dg0XVYIo9UDEsTKvFXM6jUw8Eu77Ji5eShFhYpqTjLex2j4rj1Kqm?=
 =?us-ascii?Q?HmlyIFujS4/vYUrFY89nBbROCEHQo1URinCmpGbBI7ufu5DCmWK8zQrAU4U+?=
 =?us-ascii?Q?NSbpmi8ZSVW60yKnVxoRBNOqf1Y/R2WMzMf+QYIwuqbYakqA60hc6rqPsn8+?=
 =?us-ascii?Q?GJAlB23Pc27j3nAlH4JhflQ5hdhOJUazpriD/FRL8rs+jk5B3+cYPRIc5Ard?=
 =?us-ascii?Q?9Frf9G95QLCHgG8Qks3G5+1fbPrUFcqBTh9RUPR4cD7G1pHCIOPsQZcmjnN9?=
 =?us-ascii?Q?kcrA+z9RR+TY3EiQ89q0QflXUNhnzFXGvTfnj7cSlrZGqXZCIpcoxL9nu097?=
 =?us-ascii?Q?yES+a5uwR2PTGF+K6je8uTIkNHTlKdita+STBF2QZizzznyGDal+fvkGkd9p?=
 =?us-ascii?Q?UxsWioPcJMgzPtkmhiDRcm6k1674HKnf4MA8/1SjvP7ciQaCfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LW8uZE2ljQa415tpYQreMi7q+1EMOV9uZjPqkEFUUd2ZCNLgbZKZqjpVqDXA?=
 =?us-ascii?Q?labdN0zqkup2+SBREIQKxsSNakwLHArE13p1jL7tMfiD4UTGHvwIrhxamJwB?=
 =?us-ascii?Q?JjwNFa974PIng3dR6Znjq26P32H5NzNFOOI801S5V/i5vqJYoENefU9jms3O?=
 =?us-ascii?Q?oVAr1yfQj40FNhgW0mhJjnqPG1oeCNeuLo3l9+QHf9dEaYRm4K/GSRF69y+V?=
 =?us-ascii?Q?sN6dW1NVlPUBw+PsNuJso9yeZcNwwJsek7D+GIL+xzufpFxAILQBI1GbSZD0?=
 =?us-ascii?Q?rn2tis4KsxmkXdPCd0k3hiBj/oLo+Ex7MxSUafWEL3z+uE6Ocv0uFH0a2eU4?=
 =?us-ascii?Q?R8B4oo8P91BOyCoVmU4qv63eidg+/aXfufsRRLcXZVuK/ElVDpbjKB4GZ7xz?=
 =?us-ascii?Q?+mZtRrYidFvhUH8V9CbRBY+o89YI1uUyoTX9uiyoXZ8GLVknq3eMB5NIBEqP?=
 =?us-ascii?Q?ZwW8P0iUGRlLNBRPbez+6k/RqYX94fx+UVYp88ToMG5z7Rz9WfFKu3ixKOWV?=
 =?us-ascii?Q?EyxM7WAkVLHL/mocMjBZOMncB9VDz83m29JKVpnlwAyd3hwY2ljkjuiBP1l9?=
 =?us-ascii?Q?lzyCGMJA+IBVt/PWk9tjFIOuQ+yABHvB8JZlVrKVieN5ya5j3ipd/+D1D44R?=
 =?us-ascii?Q?n5zE/J1LsJB4skF1ahBSTYGXnNDwArgcvmI5oVMQyhSbXgBjYIiAiEI78yJx?=
 =?us-ascii?Q?ALwcag+KyryklBuCa4iyc+GIycYZlJM72iXIHb6hmu2UOyubbxCNTa2UJdTp?=
 =?us-ascii?Q?KXqZccAi3BgSRlPOXoiRePLobBMoT26dtXa4IjVkqL0+GmzQ+h/QaZBlFV1I?=
 =?us-ascii?Q?HDqAqc3BxX109bur2lW05leL5ilMHvkBjIXW4oYV4P0d1Jv5fg7stpB02XSA?=
 =?us-ascii?Q?mFWoyFg3C8864K6joVot7rh9fUwuE+v4njhPmHvjFoXsU0CoCQ+9rHNCkBS/?=
 =?us-ascii?Q?iQJ75K1y5UHZeaOrEGateyoe7iSASntANmvNtC0ejCHtf2eWozfppqmWBKGM?=
 =?us-ascii?Q?UW3Bqwvr9NrvLANLBtC5cBF9jmrmBXwT8pX6wsLOibQxprypMmVSoY7bO/Rj?=
 =?us-ascii?Q?usa4zOK27KY0QkZJiqGzpbvtLsymKLJcT6vzft2aauYqBzNnrJlDoLOZfmnC?=
 =?us-ascii?Q?iEK2Um7TBBNmquFZK07x1fu5SfGmoy9M4pIC4CkGvGxBoDIjG+djRJJhgI/4?=
 =?us-ascii?Q?ZMdhtaA9NQbTrvaRmRT3VXDxSxyAZ/6dCGHPQ94qlm9u3cTtagBsiKqz6Qdc?=
 =?us-ascii?Q?fQuym1yu1HZxDD8dVlMahtRs6+uoJ0rcL7OCTyaIPFPmca4N96age3+MkdYd?=
 =?us-ascii?Q?GnJvMVQsxJWNkm1SYGvx8AFlBUkIvflmkEsjSrGve9ZZDua24OdMEMMd9BnU?=
 =?us-ascii?Q?XhyHUPSpVg4m0UAQn+hH7WjD+nvGEz7Jo7Aahyj37uReiudG6GHKDrJNlTaZ?=
 =?us-ascii?Q?FIvww3acvmHK2G4Sw/503c3tK71gG1wnEkOIRfGYBCA436wEzXLY58/sLrOx?=
 =?us-ascii?Q?mxAhnf25pVKw2tF7UeF7HavJUmh1s6++zzwsx7IyG9HiSUoQaOA5Yn/fimJt?=
 =?us-ascii?Q?CFLRajME8VyNJGCW6Tucu1CAVmtSLxZFwPvhWaElVsD8F/jm4AmaNYnEmFCV?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ee5472-faa7-463a-7309-08dd8de6168f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 04:09:11.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG1O9H3mVVNNMa8zdjB311v5v0O/weSGA8u36R+cu7qnnqFR4AZKlTZHuGG5BwRflniggZtWPqboDU29T3W/cnssNRXdvt2SSP8MlOm9gbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 10:27:19AM +0800, Yuquan Wang wrote:
> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> 
> Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> ranges directly.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



