Return-Path: <linux-acpi+bounces-14457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B9ADFA17
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 02:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC4F1789FD
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 00:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8933BBC9;
	Thu, 19 Jun 2025 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTdZ0MxG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063B12D758;
	Thu, 19 Jun 2025 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292604; cv=fail; b=Z/5Bvs3XGYuB3PWsoU2fkhVHB6GQLeVMhZAFEt/mCvF9afQdbUEJSNtGKcJeSuHPlYwsQjPNfJ7zSyMXwrxZ2Pkxyc9Y2ufYV+jcWmNUnDKFjj7U1ZjDT76ZeE6nclcxzpu0FhYo5wLKSqfxXaoeYUAK74C0zi34bgTn2xTy2Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292604; c=relaxed/simple;
	bh=4y+q0eOoe1cRsvDCx/+I6GW2ar9Z1JjFu1GEN0mzHcM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYtYF5SBQQT2RZmvY2b6iIepQMpRZq7Kh1oicQJir2RzsySsgTf6d7wFghPkCcoPQvEySdxXF2q5e6d27Xygp1+ZB0baZP5NflRcnSP2rocV6otU5z6Fe6aaB4kmOR8N0K67PUGUFdwVWR9lBC93ZXGLPclE1QvVykP9LUFnADs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTdZ0MxG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750292603; x=1781828603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4y+q0eOoe1cRsvDCx/+I6GW2ar9Z1JjFu1GEN0mzHcM=;
  b=NTdZ0MxGJJsLU+1o6N2/G+DZcOxMACWcLophwliENMBssFkf2dT16wN0
   N5YvkB2HnUOlQYaFNMlvFsJSuFALUvmgiWYg3olVScwILer0m4fAMwT6/
   yyw8GJk1lW/8sX8IpxLSSsPVuYOxgSCPOJO4iwsRLk+tNK3B3+B506w6x
   7Zn3lKcKFMkne0tJsdcr6s6mPR0cAs5abMk2v98pNO3YQW9aV4o4IbRAZ
   dM9VI9nxjy0wL7pqgBiS15xT96c7QS2tYk6SjX2neI62ASUHBWl5MGlZn
   5FPAvg1cIbXy9u4XcwB2JfKlhvSrHl8QuwOmBdNKOqYantLijMNckYW6y
   g==;
X-CSE-ConnectionGUID: YAJp4DrjSUSegkpdKGmtxA==
X-CSE-MsgGUID: tFiiVPK0QlWD/Y9Ef7IjoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="77939623"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="77939623"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 17:23:22 -0700
X-CSE-ConnectionGUID: y5sK/oTcTvmEWUh7WpdZXA==
X-CSE-MsgGUID: yqq0McjIRgqG38NFCY90Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="173928169"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 17:23:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 17:23:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 17:23:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 17:23:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLTAWcqfaa7HH73bImRUB00gm8toGt0qg8YiJQ/ETMJ9TTLEn9LevA/+A6XdeLMWGFMekeF7h45WuUXZ5IP6vzOhun/J/H/l058TN0h4EJOXaniwbu7Ncb8elV2ar3OuoZvqZ2b1h2g7Qi3I7pFhRJO7e6zsZPAO9tYPQchO2jo83yTa32ZpTVbwg4UlZj3kpdTgnI47S1Mluon0+2tfkalWhxpcQWv5GLhGM8hMUudN7qN9HWo35ZNV/4qGaIhOedzDuHYB/0izSZrmfQcHogm7r+V2tXb9As3nvKNtL2Oc/+Y7ZUjguhDJ4D2O2aprCs58/pVraga4VaoyQdpPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y+q0eOoe1cRsvDCx/+I6GW2ar9Z1JjFu1GEN0mzHcM=;
 b=w2LHDPCnrxwToFyju6Hhv5tPNl4ZEM6f/rE8Afus9Bg/fDwARP+SqqD6zE5sExqVb1f1cZ3KAZB2DZXHyNnSFDXanVWAh2r1eR5Aq3D1uSKNw62z1KNtKYx7vzbTofaIJ1OSUhQWFUF0dPwCrfKN7dR/bo4X8X6FT4t9xXVovlPLcLwVh7mTX0DG8DhBUkvsROxDHD1aduRRURlBmf55h3IYe0k60VCqwgu8Yt8549IC+LBKjeouvGuiK6Me0XAANSd5twJA7TJxmaRNV/oeVoA8Xj6n8mESVR4Q3syUrmmb4go0zfh0D1fN4ENCpSKLs6WsGUhGJ9YNlgw3YhmULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 00:23:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 00:23:13 +0000
Date: Wed, 18 Jun 2025 17:23:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Marc Herbert <marc.herbert@linux.intel.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: Miguel Ojeda <ojeda@kernel.org>, <Benjamin.Cheatham@amd.com>,
	<Jonathan.Cameron@huawei.com>, <dakr@kernel.org>, <dan.j.williams@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
	<rafael@kernel.org>, <sudeep.holla@arm.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
Message-ID: <6853586e9d366_1f9e10087@dwillia2-xfh.jf.intel.com.notmuch>
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
 <2025061446-wriggle-modulator-f7f3@gregkh>
 <a3a08e5d-bfea-4569-8d13-ed0a42d81b2a@linux.intel.com>
 <2025061546-exile-baggage-c231@gregkh>
 <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcd3848d-54dd-453e-b0b5-91cb72160645@linux.intel.com>
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: de159a7a-c1ba-4d8f-b7c3-08ddaec77a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/YDSUA8K3oktP5waCfJaitsZ6SM/QkG+jtjvXohvyXZ04ZkbJk7bKwGhbYWr?=
 =?us-ascii?Q?8Lgg359MrZfKVKFQkaaJk27KeLHvNsmZgku79l98t74C45AHbgqDUqzoPidn?=
 =?us-ascii?Q?/xVaNCQ8ynAl0zd/Ke167m0T3U8orOH08tI5rB9nmPCkajqY+4E+ZPO6qQKa?=
 =?us-ascii?Q?EmcdYHPBTY1IAPQS59gICojaTUa1TdLYzJDrEPyD8V0zPeeXDTCDHkW1iUg/?=
 =?us-ascii?Q?luIOb/U+Ng0nRM9qSYjUhAinEjpJzvhS3Q8AKhlCgzz0rCI+8NsnyYDuku1J?=
 =?us-ascii?Q?Pm3ctnW/duDR5fw3LnpUEDxuLz03nJOQSigGibELyupQ6i+IJV2EjsCPTZRO?=
 =?us-ascii?Q?MiyAHQPOAq0QF+0QtGnD5yg4GSOexm8f8IdjBXNR1th9z+jaxd2KEgk2ciRw?=
 =?us-ascii?Q?waw8nlOu5pOK0aNc+eWcbhucFPkcg1tqTPlCqhS7vLhNajoxMqsljLxqUqAf?=
 =?us-ascii?Q?tCLXkGtS5qeK+FEB3xOZG1iMiiEl9AOBTrlRd0m+gmA67skd0PFLbDSvi8PT?=
 =?us-ascii?Q?encPVTUph+cVA7B4pEGmmcOl7CMOZ/SZoUsq3s+ydFtQ1J8D3t7I1jnN/a8z?=
 =?us-ascii?Q?AfH4ugiAEm6IVvmq6UNErbEzgDQbfF2vQY2rF7EvUeetQQWbk11kPSp0LP37?=
 =?us-ascii?Q?YkEzjYHSmoaZiz+vHz3a4lwUo0jW/u5x7tmdvDxGabQ6ZRE5aHocphSFE9q1?=
 =?us-ascii?Q?OqHhMuZz6vLqrFMFnFc+zao80k4+ZYhNXBrelEX1DQ486kcX7wp5dq9KHQtD?=
 =?us-ascii?Q?grM5+1BgoxeEg3XNE/ZVHIZMRuArvguthZGGhL+bRtKCX4IhZdKcHs4qEw10?=
 =?us-ascii?Q?7T0bcR2HUnmnQFRGRnVgJaJrccTV4LqGKv4KKOGCkLXq4qZ9f5MZb9CYcW8v?=
 =?us-ascii?Q?U1e0kQD1msJKS27JQGDx4T8bp76st81H+J7aiTdoL3ZqFyRT25J5IhZlfmiN?=
 =?us-ascii?Q?99rRXR05H+mSNovu5ApvqV5ymNd3CURfI0T5ymr8Kr6o+vfBFEFg2VX3XL/+?=
 =?us-ascii?Q?EE7ZT6ibXaBfzPer1RODyOh6FBqQAgFJBBBnk9aXVnw+Mv6insxKAdYB1SOI?=
 =?us-ascii?Q?MGT0KS1B/Ejn4F94KAiO4l5bzadrBaNGQarOaS557sg8Cvi/DYbA9YUvU8qT?=
 =?us-ascii?Q?TmElror/muoFPH0HsyszrtqlJwRU7ZaLpGGDzbl/AnGDfinCRqMxXJCRqtjg?=
 =?us-ascii?Q?IXRRiMD1clTuKHPFM0qp0+nM5anX1No0asubjyo/TB493E07Tv+pZHJvwktf?=
 =?us-ascii?Q?uMMNrMyyCpIA25CucJoWyczl2xR2FKEPOU/6VjMPsQEFLMRpwaeQ1bDX36iG?=
 =?us-ascii?Q?d52c74ZhObJeh1RrLFy/5wIR7nfxeccnROTQNf//k4Pxj1h30RuO8joWIdSg?=
 =?us-ascii?Q?UmDk/gEP6NHK6CgoZodJUhaGym/B/W/s+ybTWpYM/BJppfFoUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wq6md8t9BcuWpdq862MzUODlddPRGi92PRKdDS1bHnskb19C/iR8BmR8w/SF?=
 =?us-ascii?Q?XnrQXG/dSZ+2OEGA8cdnmLu2syuhTRVF4dp57UuHni4FUzCqIS2RWRx/A8Fp?=
 =?us-ascii?Q?wNwa6HLu1I5N6WgbRehqAYlaWU0AlPCNUN+R3jVB18zIOmPyITHoPDjRtLDG?=
 =?us-ascii?Q?uZYMTHXpqjE9dslVpI1Q7ryceJcO7c3yRt3OM3KsYx90hSFN3eLg6PnJc3ii?=
 =?us-ascii?Q?V/9mzpZB0xbi+R3A7KxdW2Y5Ed87Ewl0fea+1yBzZxITsMr81ynCSkrV+dK9?=
 =?us-ascii?Q?TOQ4t9FdbXCKnCQBxiqAEeKNw7lIyJY8kZQw4GowFkSPIXFr1Kf51P/EEdTV?=
 =?us-ascii?Q?5zTyuiYeSI9ZJqxzufXCMLHet6gF7Vt6ghR8x1KyIhI9J3UkgyAz8+ngBpnQ?=
 =?us-ascii?Q?Oxqn+nOCATEHI0/6VbXLQ30QwmtMxtuQBI7s44ckvNQ45EmdNZ0xjFQSLms0?=
 =?us-ascii?Q?bWXUN8oLR54D6Yc34Fv570YgMbtkcmKb5l/ZmznNa6tYYS2uw10chIItP/+D?=
 =?us-ascii?Q?YIwrw5ZJZ8Q0Pb4pN8FH/GwVIRle4u/P6AUicSBe8V8yXVe8lkS74TT5reeh?=
 =?us-ascii?Q?KDBNaFGsQU3LlghB37/hEBGsWSaNDq0YxXffveG9plUc1QeCVn9kAqdnyBfz?=
 =?us-ascii?Q?KFG2FUUb/orYL8hZnjU63SvnTwJm44fU6I6AMz59hvfiKjOhPvgnf1/M8LXf?=
 =?us-ascii?Q?Ym5jx0hfoE9QC4FGOYv1QeoRilUi9zCKp6sJrYZ7Cab5fAq5Z/KqDiGa/KuQ?=
 =?us-ascii?Q?PoU99LOWyBiKbE7oIykY+fxVXdOVJl17YZqKVRYoGv7yrewv3lUqdp8nbF10?=
 =?us-ascii?Q?uBcglc3F+Ckc+4p3i9sbqITPPM55vN3CcjO1ag0dPz/L5YrjBGZloCxvuJ91?=
 =?us-ascii?Q?nRubi3Ip3nywVMW3Q704CH54Hi88rmLKci4qQqMY28+kvU2eBFD0OKf2Aw11?=
 =?us-ascii?Q?v1dM3skwDkuP07K5YBzRafaJzE2+xxAgH3CVcSZUPLyDzIKT0nA0xk3sQbAA?=
 =?us-ascii?Q?Ma7X6op/8KTiynX0VghGJfni9PIKsWGeQunSlN8ZcBM+yygxA3nZP78VfMia?=
 =?us-ascii?Q?ohSnH3X+56JT49wJLzhp/pq3Lw4tWk5u7qeFodmXXSOPCIsx9KjJCgjnVusO?=
 =?us-ascii?Q?YeKxeNgZHxMAV3M1NWSZC2KjDvJcWFy8qd42rglkEHKnj0R7UObV04ww61Lu?=
 =?us-ascii?Q?ukdp7R0ZRlJgxu5AuuVjgVhUcWAiG2Cn76X3jsIqGPhXQ45lJA9Z6LDnPm1x?=
 =?us-ascii?Q?A8VDkEN91sC6gOMMc1N2KHkZEVRRSeYMbb7vVrDzxy1tP0mr1PPxQ7P8yFXT?=
 =?us-ascii?Q?HRLlrnX9O72uYKD//3USsKmALQMyyDFkJnSE6aFIzEm0+YIpqayMgN2Mh8e5?=
 =?us-ascii?Q?RBNs+nE8Bf8pc/Jt2TG9MhE7TjqmVLhOwZx7QYgU//Z1ZEPsAx3vYI8R/5ia?=
 =?us-ascii?Q?N9QwTzy/B4f8vu//WKFdpogvT+FBTfTkQ+xkqk6LFWyGIGc7d7Yqy9zokn2l?=
 =?us-ascii?Q?6vWjlwo49z1erptJgAVdaET2xetO4YuMwsskEi0Ym41/Zc4UnsCaq06i74CF?=
 =?us-ascii?Q?VzR+gMoirg5mLmZIqyRZMrORetkzQpG8YjdSJKyFRLWRK2wYvWixMtzc3J8H?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de159a7a-c1ba-4d8f-b7c3-08ddaec77a71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 00:23:13.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6KIoIt+v+VzZApaR+B8kI1p8uUiCKiy6oNHpousv+AYfDoWVI2KBmh6QxRJ1YcsNsqdqRP35oapnZV6uWxrd7ROuV4n8ZFyT7DsSvwePb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com

Marc Herbert wrote:
[..]
> In other words, by turning this off unconditionally at the global level,
> the kernel could actually lose (surprise!) some performance.

I expect the answer is that any compiler that does fail to convert this
to defined behavior is not suitable for compiling the kernel.

The issue is not "oh hey, this fixup in this case is tiny", it is
"changing this precedent implicates a large flag day audit". I am
certain this is one of many optimizations that the kernel is willing to
sacrifice.

Otherwise, the massive effort to remove undefined behavior from the
kernel and allow for complier optimzations around that removal is called
the "Rust for Linux" project.

