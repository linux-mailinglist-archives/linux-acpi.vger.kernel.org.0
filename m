Return-Path: <linux-acpi+bounces-19562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA5CBA015
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Dec 2025 00:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 462B23009C3D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Dec 2025 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BAA2BD582;
	Fri, 12 Dec 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EACMYVuI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EC239E60;
	Fri, 12 Dec 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765580489; cv=fail; b=I1VlX1nJJnJJV/0gPkwMkm3YitQLDac2FR6Vjk1jA1OtV7x6dIzb0sDz9wxcOvHq6Qt3jkpPXEjAZax9G1yVm9JkG+kvH5tdjYhx0sqXYNshid2ReYxoaga/7aJNvSI6FPY3KS3/VZnJggOu9X+dAPjgD8FUUDFT6TokZSwYKdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765580489; c=relaxed/simple;
	bh=O/v7TguGg1CNBMhUek8QQ+zIrUM2LfgkRxKgk7JLE6Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NcWjS5ouYH/8NGTlhVZ9XH4msoeR2I1N6JdncBhOMEfwvywNgEBjKE+YJHaXW7ycg1jTJRJc6OHUnUmB2b+JXrIqcE4rC74wn2vSFM5ptlAWAl/xHPM8zF5lrCjEtGycwaR3hjrnDDkK1AV16wYCHOHFcVaaZ2eOs5wTIErB4us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EACMYVuI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765580487; x=1797116487;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O/v7TguGg1CNBMhUek8QQ+zIrUM2LfgkRxKgk7JLE6Q=;
  b=EACMYVuIDEKATAnnIxBTxLz1c++JOKKoRxrEyrKRcH7sOfpaKGpi15el
   v5vAylurWXyVh1cSDq3ZaH4iYboq0s/e2ohkSPPm66LD08xOLwIWSfP8r
   o5DEvhRGDmV950RuNTDn3obdwAWfFJW+t48g1YEUONeLuIrCcuL+cOEjz
   FvzFOBxT1SirBTH1Mg/uwvy6B6vaS8qMNWXHJzkV9VXBwzecE7jOoqbla
   LzL2epmLsEIlBAo4wEHX18k7BCisLVx6Ag7zdDRQhwyC8ilAO6Ack03XU
   m0QdpCdG2fAvP8EQSCt8edX2Ygg8WmL0ggqKhMqIriEa0uz3UZ1FGcRlT
   g==;
X-CSE-ConnectionGUID: UIQQ6z1hT/KtQ+cvbouw9A==
X-CSE-MsgGUID: C/8WvwCpThy+nhTkMyuTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="70171007"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="70171007"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 15:01:27 -0800
X-CSE-ConnectionGUID: 4d3+lyEMQt+zEy1dSiD2QQ==
X-CSE-MsgGUID: OF5OMyoCRxKsW7uOJalJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="196815062"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 15:01:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 15:01:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 15:01:25 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 15:01:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfXinSU131nlkAzYTJI5ZYj3sw4CgZ+Bfp95JlPZK+nSEAlPLJzWTwhX17/NPsQYXU9P4y4ndOVhECzlAdRqR8TusiRHdaSw6rDgSETVfAqHgSpTat+H/HFJyUHVXXm0X+iX69Wgh5Z20QVlWaP6VFGX0e+9unoOzZw/b7RYEdfIXVdNYkwoSMzSFQhnJZBTgVN5hJ8+4tddpchtbJvKgdDFjrE3fpRA1AKc8pSaiRPcQaKLNhNT3Nrg04mY6hRlRuByYS/Ihue97Xi0KH4gye5zFkm1neeLr1dCE2feGYKsSQTFNGBQIZS3C1xPWxy6QrdQrtpzvHe8R1aqrfNYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO89hGiBfS1tf5E3+5KaxcW3c+tBIBwNloHh9c/ybXE=;
 b=I4PweapU8C3rihUcHiWD7nPbnfwozSCU/yOLh2cov/wAI4QWNHn4d1D2AJYX6geFk5j4Gc4WyOomNxp0Z6LuB96eReyerMDLUrxA7WzZEgQKws0cKngj2IHh4L9efD+2oAWb1LnmaurjmXvB4x9lIx1ni+eD2xbXvUFuDcbRvrqqXaQnYaNHm+P0GNTDU6yydtA1ENEGcmXek999xafNVvxMbpRCEdHJsONqFFihhO6OPw+YotnmHuxL/Sn3OH8W6KZBQcGWJHQaDxzjtkIVcPhbrZEyuAiyYcrSDHfvjE/nCIfbckZS7EXqUZluRqKx/yfn9K5mtUQPbEb/YUajiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ0PR11MB5184.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 23:01:21 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 23:01:21 +0000
Date: Fri, 12 Dec 2025 17:04:02 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [RFT][PATCH v1 6/6] ACPI: NFIT: core: Convert the driver to a
 platform one
Message-ID: <693c9f628c7fc_c04a91001f@iweiny-mobl.notmuch>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
 <2028345.PYKUYFuaPT@rafael.j.wysocki>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2028345.PYKUYFuaPT@rafael.j.wysocki>
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ0PR11MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d98bffb-2d1e-4165-8b1a-08de39d25cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jahqZy61kON+vXlCUjMkf3rBnAd27rWDATyR0Z6DGsAcc1j6zVSfwbfgCFZR?=
 =?us-ascii?Q?0EnuWsBKe+c0h/oiuQl1K4yhfzoZHhXGGx0fumooYFb1ZctxgeDIZzPiDtJ5?=
 =?us-ascii?Q?SL3+u2tudNM7f07v1H/HnR+M5sRggh3shpWx/1zvjMFG60qAfZz21bSjJUil?=
 =?us-ascii?Q?WNrpsQfuxuREQxg1MeDSG3TG8x6Fe+JZiGuue/kjMY5FtnL4Uqu17V5JMWnT?=
 =?us-ascii?Q?cLxOgP4KpVFGBacSBkVtYls04Or+ph6dwKN9MtA41aGLl9KkV0f3j2YbOd1M?=
 =?us-ascii?Q?Gkc0PkpPHBfJEtwSr6cPAmVr+ua0Q4c141CGp9qLeLyZ+mrIyGnf8TsN7ltT?=
 =?us-ascii?Q?nej4kUADFqfO2/Dl7LwCP82GDH9G3lRmWkwmliU48qEk3Hiul6bFZO1O6RQe?=
 =?us-ascii?Q?SWK0m59DL5VsoaHHs+fcp3oS0u21+HgskjaEuqiLSsvS14dXg+ekHQPq85Mk?=
 =?us-ascii?Q?4lXY8wTL5f5MsRyWpUzCpw1pRwKWdoScINcIM30gh5wx98hJXXwWxc1NTmHL?=
 =?us-ascii?Q?Rex6sNL7EGCMoiYWCDSKer/f078L2JSpN8cuD5LnwByMswqGsvOfG/eIEhHa?=
 =?us-ascii?Q?fQn1IuNGgs8/K8TJ6AYpTfIa6m4zwHihpGzaQ7uf5ABoiBh7yQVji26nE2Pd?=
 =?us-ascii?Q?X4o7ZoaJ3cMUd/4W85voeU/ouN/j+c/X6l/GmhG+rgv62QpdxDVwi/EEfj+A?=
 =?us-ascii?Q?THCF3rejdV65btLbRiSK+KV0L5Tb6gAvKA9OMGpbufARLRud0al8fGFJAsls?=
 =?us-ascii?Q?7/yINXCwfHKCYSjZj+42nBoDifMvRt9S68ZREfiEkOPWXI7Z2Eaw8Tp45JAH?=
 =?us-ascii?Q?kYDvREBm2LdfbggfoqGVOwYqKPiOurIc6NNmwNb5GU3TGxQqdj1uwhVMUnDA?=
 =?us-ascii?Q?ZUzfh6SiPaiLh2jIGUSjLxwUbdin7lMkua8OudqFcHvgYTrkNMHGJQ4bgn9C?=
 =?us-ascii?Q?oH7WAGkICihRa7mXauBe+MbBsv0oYhJGmk7ATdf4iOz0uzHxc5HVutajIbkk?=
 =?us-ascii?Q?gF2fmq5OhTRdidvM11z9nzMBdYUMNvLWwVMyVrBUITU9pI+NpAEhCWkFpzda?=
 =?us-ascii?Q?RxT35h96yxie1yAfoP0AN0k0KBVajESiQ7bWQJGudv5Q4r2NIP3xzB0JV9Ep?=
 =?us-ascii?Q?d9iFW9wx69QgUd9D77eHLAdWX6ICtq8/V+lbff/688Q8PGXH/IPy5vT00t7o?=
 =?us-ascii?Q?NQ7byHXhIJtoB0Kq4DCeByvgrk1veO4hYgeF0MtCpUP3e8IZTQTQEoleim3c?=
 =?us-ascii?Q?9iE1j4IVMIsPsVNH8XbrkIEa6OyZaslHoYLNhjf+9n+D3VRAVpghEysE5oyh?=
 =?us-ascii?Q?CDAeLhBs/j/uAnaiTHBUrw8lBeWiQgFYad8tp1euCJpLIM1bXWkxgtETK7mK?=
 =?us-ascii?Q?b8XY3hgdAm4o9TmPqxYggyVNO/mKp7lbcg6jY+9nWup9f9bmWc6ZUUTXr+rO?=
 =?us-ascii?Q?3hfdUjPkEDr8yWh61S6hWsd4RcPpzq+7b+MyStxMNzF/QpBGcwrllQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EN/UEEp2U5VDynjZYZfFAo56YUKV7j4kbE/Z7fHEhrk+xjsRZU45rJ+3fOSO?=
 =?us-ascii?Q?SBjK/jhMwM2OmaMej97rAtPX0q5C7YRgAhTE7DlOD4o7rlJJdwhGg2zEukir?=
 =?us-ascii?Q?1u0pYPkRFMBslzBep9uE0gEI2RLcfIUg2cQpbxokcEG741VrQwM5pNt/E/Ji?=
 =?us-ascii?Q?OYLY0uX325KFItOsRcNWfoupDD6woYpK+Umn8KWp4ma53TJ62qWhhbUHOx1z?=
 =?us-ascii?Q?R4p+718BykVjFSjdI+UxLkCttjGefjVUWSa9pScRjb9XKxE7k0j80b0RsLKd?=
 =?us-ascii?Q?9qSbi4U7fNNxG6EzD+XQFkAbgPiJ78aJnBpNHBU5StYh0DvOQHhuk8ntGFrh?=
 =?us-ascii?Q?P32nfNABZPu5OYTpN8sKFITkym3Ic7KShfKQ8CfSj7e4zK+fTW7wsFjuBqU9?=
 =?us-ascii?Q?7VYPu7fzQkdmuR34+1LflAfvqeDLe81laj7k6jHgOr6b/EREALtSWQW6McXQ?=
 =?us-ascii?Q?HwKGchEhrH/li2p/G3qFT7a87oDGRX8AakVTx8slzSTCjn+ne1PmBqtu5/eM?=
 =?us-ascii?Q?6VWLrZgiSAf3JDVSXyKFodPi2d2vGlMy5qSuuEaiYutZAgd96aRr2KNbxOsj?=
 =?us-ascii?Q?8ybDLLqPZ/54ADtZqCQCuNw4/cn9sif5xJdbkYHilLO4D7rMW3zeK6OYbNiL?=
 =?us-ascii?Q?1x0dqwfVTS+6PIBADqkavoHJGbtLCYW9u9qgEJwVTpQCvlhdpXhlJBU8THpH?=
 =?us-ascii?Q?704RdBSU4dN/BUq324Okd6AaB3lLajTITPxUDHcQMetpsCgbiPGdqxY2Aako?=
 =?us-ascii?Q?sHte9SzxFCrtxU/ohDSPAkn2B5LYwaKKW7IFHbTNgbrGhOXtLdWbKUESdPoX?=
 =?us-ascii?Q?i8yXaiYTXdvOJpFCtzB76h9gygdwAC9ClwlCtB25ujN9YMVGp37PkBYiNqzs?=
 =?us-ascii?Q?oRTMVwaupTOxdYPSv8r0W5MEeOCYRMkQarSxIEr2YN74MTrFc/cXPWFKZK6h?=
 =?us-ascii?Q?44rsMRiItVIYO7yHz6/JA9ZAQZOaM4j7jdU3lSs1gXV+XQFQ+NL98ywddcUp?=
 =?us-ascii?Q?Oo82FtYbTJZrmEgLzQu7dsOjj/ZWsYvG0zpkPXH1Nv05yK9dWEBoFM3p/7Xh?=
 =?us-ascii?Q?CR3oE/SjbhNazkYLZevwACVkhR9qV9dcui4EFNZdxGyCZYbzIoUwZBd+ote+?=
 =?us-ascii?Q?vWmDpgFPVKtPel/IB9aN4liavdYxRiQiE50u8mcUUPAJgcqBNH6uo8eZsIHt?=
 =?us-ascii?Q?LwTvSMoXAkOmH6ZufPBrUIUgLsl+xPbbuLlI7yorP/CpU9JZYwmsEzU3Hy6M?=
 =?us-ascii?Q?W0ay+rfQpTYT5fkXuLu7l5Ylvy/9NJPWPD28tHyoAMUGy8HjRy/Fz3ym2cbp?=
 =?us-ascii?Q?6RzAMfHQDzP6NYf1giBE+/oJ9V5xyBpVHxkYdwcBNyXiChHsCK3Kv69XFYNa?=
 =?us-ascii?Q?UfZJYgudKEZ+ACULVrc/frqqUFGsNiuDO1PlCjOErTV6ZPZqjPFvel/m6yK2?=
 =?us-ascii?Q?8peW8BGuDgA/lGby9mfRJBG2t1UPT1xL76jnQK28vyTLCKPVuPhxD9nOi72Q?=
 =?us-ascii?Q?XBQIdzIm5rfkucuTgz8f7XBdBbR6jNy9gYxuZtHux1qdSHoEczarJpfEm9RM?=
 =?us-ascii?Q?w+XKms/L5+UezWhwWy7UeiFBv2F/kfPPc3omJm8D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d98bffb-2d1e-4165-8b1a-08de39d25cd1
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 23:01:20.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbq/I7+/TucVJ+dtJ8JusRUNpo8yd6dcBKq7RxKY6gbGhSty+anhWprQe4fIHPuKhHjxE5FmJeYcnXxJ9yWxgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5184
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> While binding drivers directly to struct acpi_device objects allows
> basic functionality to be provided, at least in the majority of cases,
> there are some problems with it, related to general consistency, sysfs
> layout, power management operation ordering, and code cleanliness.
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI NFIT core driver to a platform one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.

I'm not sure right off why but when I run the libndctl test with this patch I
get the following panic.

[   17.483472] BUG: kernel NULL pointer dereference, address: 0000000000000008
[   17.484116] #PF: supervisor read access in kernel mode
[   17.484593] #PF: error_code(0x0000) - not-present page
[   17.485056] PGD 9def067 P4D 9def067 PUD 9df3067 PMD 0
[   17.485516] Oops: Oops: 0000 [#1] SMP NOPTI
[   17.485886] CPU: 2 UID: 0 PID: 1191 Comm: libndctl Tainted: G           O        6.18.0ira+ #34 PREEMPT(voluntary)
[   17.486804] Tainted: [O]=OOT_MODULE
[   17.487125] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-18.fc42 08/12/2025
[   17.487749] RIP: 0010:acpi_nfit_ctl+0x40b/0xa00 [nfit]
[   17.488222] Code: 48 48 c7 44 24 28 28 f1 8c a1 48 8b 83 c8 01 00 00 44 89 e7 48 89 44 24 50 e8 01 83 fd ff 48 c7 44 24 40 10 58 8c a1 48 89 c3 <49> 8b 47 08 48 c7 44 24 30 30 f1 8c a1 48 89 44 24 18 e9 24 fd
ff
[   17.491668] RSP: 0018:ffffc9000f11ba28 EFLAGS: 00010286
[   17.492422] RAX: ffffffffa18679f0 RBX: ffffffffa18679f0 RCX: ffffc9000f11bb40
[   17.492903] RDX: 000000000000041e RSI: ffffffffa18cf116 RDI: 0000000000000003
[   17.493408] RBP: ffffc9000f11bb40 R08: 0000000000000008 R09: ffffc9000f11bafc
[   17.493888] R10: ffffc9000f11bae0 R11: 0000000000004019 R12: 0000000000000003
[   17.494396] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   17.494878] FS:  00007f432f5fd7c0(0000) GS:ffff8880f9fdd000(0000) knlGS:0000000000000000
[   17.495436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.495826] CR2: 0000000000000008 CR3: 0000000009e0c005 CR4: 0000000000770ef0
[   17.496324] PKRU: 55555554
[   17.496516] Call Trace:
[   17.496691]  <TASK>
[   17.496844]  ? __kmalloc_noprof+0x410/0x650
[   17.497138]  ? setup_result+0x1b/0xa0 [nfit_test]
[   17.497474]  nfit_ctl_test+0x21a/0x780 [nfit_test]
[   17.497803]  ? preempt_count_add+0x51/0xd0
[   17.498086]  ? up_write+0x13/0x60
[   17.498333]  ? up_write+0x35/0x60
[   17.498565]  ? preempt_count_add+0x51/0xd0
[   17.498846]  ? kernfs_next_descendant_post+0x1b/0xe0
[   17.499196]  nfit_test_probe+0x350/0x4d0 [nfit_test]
[   17.499535]  platform_probe+0x38/0x70
[   17.499791]  really_probe+0xde/0x380
[   17.500039]  ? _raw_spin_unlock_irq+0x18/0x40
[   17.500354]  __driver_probe_device+0xc0/0x150
[   17.500656]  driver_probe_device+0x1f/0xa0                                                                                                                                                                       [   17.500939]  ? __pfx___driver_attach+0x10/0x10
[   17.501263]  __driver_attach+0xc7/0x200
[   17.501529]  bus_for_each_dev+0x63/0xa0
[   17.501794]  bus_add_driver+0x114/0x200
[   17.502059]  driver_register+0x71/0xe0
[   17.502480]  nfit_test_init+0x24e/0xff0 [nfit_test]
[   17.502956]  ? __pfx_nfit_test_init+0x10/0x10 [nfit_test]
[   17.503483]  do_one_initcall+0x42/0x210
[   17.503891]  do_init_module+0x62/0x230
[   17.504296]  init_module_from_file+0xb1/0xe0
[   17.504732]  idempotent_init_module+0xed/0x2d0
[   17.505184]  __x64_sys_finit_module+0x6d/0xe0
[   17.505626]  do_syscall_64+0x62/0x390
[   17.506016]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.506563] RIP: 0033:0x7f432f8920cd
[   17.506946] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 03 4d 0f 00 f7 d8 64 89 01
48
[   17.508548] RSP: 002b:00007fff0a6ccd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   17.509209] RAX: ffffffffffffffda RBX: 000000001f5def50 RCX: 00007f432f8920cd
[   17.509831] RDX: 0000000000000000 RSI: 00007f432f9aa965 RDI: 0000000000000003                                                                                                                                    [   17.510472] RBP: 00007fff0a6cce50 R08: 0000000000000000 R09: 00007fff0a6cce00
[   17.511091] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000020000
[   17.511727] R13: 000000001f5deb60 R14: 00007f432f9aa965 R15: 0000000000000000
[   17.512353]  </TASK>
[   17.512638] Modules linked in: nfit_test(O+) device_dax(O) nd_pmem(O) dax_pmem(O) kmem nd_btt(O) nfit(O) dax_cxl cxl_pci nd_e820(O) cxl_mock_mem(O) cxl_test(O) cxl_mem(O) cxl_pmem(O) cxl_acpi(O) cxl_port(O) cx
l_mock(O) libnvdimm(O) nfit_test_iomap(O) cxl_core(O) fwctl
[   17.514512] CR2: 0000000000000008
[   17.514878] ---[ end trace 0000000000000000 ]---


I'll try and find some time to dig into it but perhaps yall have a quick
idea of what it could be?

Ira

> 
> This change was mostly developed by Michal Wilczynski [1].
> 
> Linu: https://lore.kernel.org/linux-acpi/20231011083334.3987477-6-michal.wilczynski@intel.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/nfit/core.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
>   */
> +#include <linux/platform_device.h>
>  #include <linux/list_sort.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/module.h>
> @@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(s
>  			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
>  		return NULL;
>  
> -	return to_acpi_device(acpi_desc->dev);
> +	return ACPI_COMPANION(acpi_desc->dev);
>  }
>  
>  static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
> @@ -3283,11 +3284,11 @@ static void acpi_nfit_put_table(void *ta
>  
>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct acpi_device *adev = data;
> +	struct device *dev = data;
>  
> -	device_lock(&adev->dev);
> -	__acpi_nfit_notify(&adev->dev, handle, event);
> -	device_unlock(&adev->dev);
> +	device_lock(dev);
> +	__acpi_nfit_notify(dev, handle, event);
> +	device_unlock(dev);
>  }
>  
>  static void acpi_nfit_remove_notify_handler(void *data)
> @@ -3328,18 +3329,19 @@ void acpi_nfit_shutdown(void *data)
>  }
>  EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
>  
> -static int acpi_nfit_add(struct acpi_device *adev)
> +static int acpi_nfit_probe(struct platform_device *pdev)
>  {
>  	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  	struct acpi_nfit_desc *acpi_desc;
> -	struct device *dev = &adev->dev;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	struct acpi_table_header *tbl;
>  	acpi_status status = AE_OK;
>  	acpi_size sz;
>  	int rc = 0;
>  
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -					     acpi_nfit_notify, adev);
> +					     acpi_nfit_notify, dev);
>  	if (rc)
>  		return rc;
>  
> @@ -3369,7 +3371,7 @@ static int acpi_nfit_add(struct acpi_dev
>  	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
>  	if (!acpi_desc)
>  		return -ENOMEM;
> -	acpi_nfit_desc_init(acpi_desc, &adev->dev);
> +	acpi_nfit_desc_init(acpi_desc, dev);
>  
>  	/* Save the acpi header for exporting the revision via sysfs */
>  	acpi_desc->acpi_header = *tbl;
> @@ -3474,11 +3476,11 @@ static const struct acpi_device_id acpi_
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>  
> -static struct acpi_driver acpi_nfit_driver = {
> -	.name = KBUILD_MODNAME,
> -	.ids = acpi_nfit_ids,
> -	.ops = {
> -		.add = acpi_nfit_add,
> +static struct platform_driver acpi_nfit_driver = {
> +	.probe = acpi_nfit_probe,
> +	.driver = {
> +		.name = "acpi-nfit",
> +		.acpi_match_table = acpi_nfit_ids,
>  	},
>  };
>  
> @@ -3516,7 +3518,7 @@ static __init int nfit_init(void)
>  		return -ENOMEM;
>  
>  	nfit_mce_register();
> -	ret = acpi_bus_register_driver(&acpi_nfit_driver);
> +	ret = platform_driver_register(&acpi_nfit_driver);
>  	if (ret) {
>  		nfit_mce_unregister();
>  		destroy_workqueue(nfit_wq);
> @@ -3529,7 +3531,7 @@ static __init int nfit_init(void)
>  static __exit void nfit_exit(void)
>  {
>  	nfit_mce_unregister();
> -	acpi_bus_unregister_driver(&acpi_nfit_driver);
> +	platform_driver_unregister(&acpi_nfit_driver);
>  	destroy_workqueue(nfit_wq);
>  	WARN_ON(!list_empty(&acpi_descs));
>  }
> 
> 
> 



