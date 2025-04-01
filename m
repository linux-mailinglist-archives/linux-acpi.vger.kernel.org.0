Return-Path: <linux-acpi+bounces-12623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34EA782DD
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90F93AFC58
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 19:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1CC20E334;
	Tue,  1 Apr 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHgheDrc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD612E3360;
	Tue,  1 Apr 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743536676; cv=fail; b=dMygV3E6ukKHqcW+nM4kxkqL6EywBIwIschsZEw05r/x7d7VcwP2XOYyQqq28wqDfbt/9olToyHrIPVly/SS9SfniWoA6PXlCmLJdRuoaBQsBNT/mcno61hGjjpy1zGdHWN01RwoB2gRsAxpn7KuIMeztDqYfrrAbQjBo4uCie4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743536676; c=relaxed/simple;
	bh=oQamUWIyrPql/lJ9CM4shWRFxQlEyDMf9Qk/4W5Zp7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6/qCmZU0POwjvPRheq84+ocl9EVVW0utzVgB+DTDXWidEwCNypSixbvYNhtCvdE+fdo4YuzqEJnrZgH1X+jd1Ypet86A/dT4At8ItjeDfIUmrPZhcZiRjekHhsC7KEvXe4I8fZaafmAR1VHfbZLHUjr3SV4Xcg5Ilf03bQLrtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHgheDrc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743536674; x=1775072674;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oQamUWIyrPql/lJ9CM4shWRFxQlEyDMf9Qk/4W5Zp7s=;
  b=dHgheDrcKjUOsZxrWme4Xu6Js2NxvixHSMplQbky5U31ojvc4NxCTC6X
   WRyhbYa79/ITbdHWJ1atRxG9IOXbM3XDcsaybgkmQrW7HXkXU65kaCNLQ
   xgV+ipPcPG3GKPHE1miMBXDVZbVO5SlkRzhyLcKk6RYyeLvkv5kgIhvB8
   vtJ/xq92gwvg1AMHBIL2aaSJ2IG2CI8t9sQMPsdgvSWBOnAnhqdqXKdJW
   hWK5uzcOp8q4qSC4IAKQvo5K3K3Q0tgQFuRGHO83IAwd+eT8vqZXEz9Ry
   9sxvDf5VfW6ECk4QpSpgu3efRnuMFRtgSgo5M6ODnpEV16g3t2CrxrT0d
   g==;
X-CSE-ConnectionGUID: 23yCni9ETQiDI6mM1XcDTw==
X-CSE-MsgGUID: 6dHuppv7QGOVzFaOwe/bVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="70239201"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="70239201"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 12:44:34 -0700
X-CSE-ConnectionGUID: E5mH9TBXRxSRD++/6H8fww==
X-CSE-MsgGUID: pEL9Rz3QTLKR6FMDsQ7qdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="149659178"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 12:44:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 12:44:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 12:44:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 12:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ha+/YHncpAXTgUk/7pbIV9k2gWhz4cteLd9JSyWzclCxrpzJwA+bWQZOGwRNf21UYSiS21L5uOqbPpZEoZ19gwxJGPeN5iwV3U5ZX/hMxkI8DkeLwttdauZhUS6T3H4N18a/kXGGUjPIVJjJqvV9Jc/ju9RVnTgrT9WDBFW+tcTTtnjAi4+W+LuYWvTwlQ4YB7qTih0LfFbcRu3y1+JB6FsA5ZWsRG7B8cgbt1o7+0y6pHb3AhDKIbeDR5yuVCTBFcMx9RTyYh00aWTFFOtbG4F5+1LJjP+GRdlz0C8hY7LUlF7fMwGCEBohIAD7ub3pwzqLh84Oq4waJR/L+ohRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycF1NgZAuvCDKScxtkbhxNpeR8P+9nnme29cFOGZPyE=;
 b=nhQhTUaXZZj0jvMqSpqJF8VQSinIAD2ObMdiafXMFe1mBfZX/6/ZFCyVdLI8QrkuAXrjV5SH8Zf7j6xEHGYoy1VECcZ6YplNexdV3/M8MsgwjHqFQHepDEepY7Pe4Nk0yfE9eLxweS+0DNpcRbjXXbSSm+9gv7vV+9oag35lECYn/cGqMXX+6BxZJgHgJcxVtK+sm+GXJqZCcea0BTGfKWfx4FoWCQBL8/px4H+UiR5gelsi6X+CVgAKTbBL6nYm4zLoNR3KCyFgWpHCCDl3zpL93k4gtmqNYkxhBxhV5Mt/7HWhhgz7Oy1my4JvkSo5gclR4JcnPxe2m3/xrZry0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Tue, 1 Apr
 2025 19:44:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 19:44:29 +0000
Date: Tue, 1 Apr 2025 12:44:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Oscar Salvador <osalvador@suse.de>, Gregory Price <gourry@gourry.net>
CC: <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
	<kernel-team@meta.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<alison.schofield@intel.com>, <rrichter@amd.com>, <rppt@kernel.org>,
	<bfaccini@nvidia.com>, <haibo1.xu@intel.com>, <dave.jiang@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <67ec421a15fe8_288d294c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250127153405.3379117-1-gourry@gourry.net>
 <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 519f027f-00d6-4e2d-c67a-08dd71559e0b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GqFdF6bLI8kcHXEedRPe4ZVogcIzM6khfg8VC3rrsZZWezjIj6YIVtUW4inG?=
 =?us-ascii?Q?diVTceb/qcLSby+aOZBPaAtztbB8EKO86GifsfuJaDEnQjsax9zuVWwXVXZS?=
 =?us-ascii?Q?NO2rJE6vnUshugooHiEqy/EzxdPZap97SyBeOEjtTHxNqyA5DblS1IuaK6yv?=
 =?us-ascii?Q?1WBMUx+oJo6X9yFk2Fyy8KgPlAo1N95DtpomUqs/wUWFeh4F55A25YccaGtk?=
 =?us-ascii?Q?n3HmiIsVDCVhPs2FZ2+I6tfvMHWPxhf6rqwAyUq2FppOj6g8FR4lq/hcUc/5?=
 =?us-ascii?Q?fg6FjRjJ6aIcZs6pi68NnvDWOXpXPvilZChPIt2IHNFljr9dZawt6W1vecpN?=
 =?us-ascii?Q?OKRD3sC65DWdBn84YHMbR6bgLOY1FSfF+IDnA0nQs3ZkSswr3DK6fMi20YxJ?=
 =?us-ascii?Q?Qs8r3Wc0Dp7ASc+HS11rTdg9i2wsGFNB5r4uBhWhD1cKyn9zujj5GbyfP05V?=
 =?us-ascii?Q?N/m/DtdZWpD5NztVw2Xx7YV+Ip0p7YSmUy4/N7+RBtekNSqnUb5iFaYCjIsW?=
 =?us-ascii?Q?ezq3cbWcj5MMD2hWA7FlmOk1x6JVYKiWvdxO5/pVH0feM6kD9cfr93MrwYSG?=
 =?us-ascii?Q?qr/G7KsAkoupXUHNKzN0whp30+YhmrQF7oVC+g6vKzLHfitEt4UJIqG4VILT?=
 =?us-ascii?Q?sAGF4XJ51itNWJ3avEf5ciSk7b7DItUT7CaamJi1KsNJsaMkyAQN2GAwhtUd?=
 =?us-ascii?Q?G9y3/kV2TmVtrCCJ5tLSNrEbmsYjYpDa5Nph8aL7NL0HRS/+PW5Anj4oteMl?=
 =?us-ascii?Q?f5DkM0qQljf+56904GsevyxonNi6UWYvCU0gk206PrNtuzaHzuQQhT0dtPkq?=
 =?us-ascii?Q?+LQI+NmnCkoj9zSU8WVuJxrfUTeaIxEZsNv+y8u5YmI924Ymk0DmogCMpifQ?=
 =?us-ascii?Q?5ObLT0c+7+p129cf4aIcf0rRggiLAJSW0ukYBRmvgD0pPveunzhOoX11bJaH?=
 =?us-ascii?Q?CEvitNLQqs/bvZGr01Neb46BSUsClgV+RwqvnZBnjNf3+xOd9aBGyWZdEIig?=
 =?us-ascii?Q?6WhnhzHXXGBELFzRjKxXNRyfvUT69QMRBGH5pV/z8+esv0dMQh9hTbXF/9DC?=
 =?us-ascii?Q?YcTjbLX1CwKPq7p/XYqmUeVdzYFoE2VzpnM0TzNYO/JjyijmfAeBYo532uyf?=
 =?us-ascii?Q?ZfIhXPSOl3SY5mu7HEFMkJFV6goLnLI8rgKy+8XeikD4c7zYk1dpOLVoe6ZH?=
 =?us-ascii?Q?iSn1i2d4D0CvwUnxscwLFvRDT8D23yVoLR0b+C0zVWcOm3Q+goyaqUc2+mh9?=
 =?us-ascii?Q?lNGOQsKdVcBwHKdO8zV4NgLAnCfsGYjNHSjBsjws6/nd3aku6Q6oMtwuFkcK?=
 =?us-ascii?Q?bEBfnoigOALzEPGCbafSfdRCi5hlW6LWAldQVYqSU6I4bY+1+9U/pPF68AKf?=
 =?us-ascii?Q?sknPGI16uyUX+7TUm+93TVrWAeBu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNZOqVCZzLxLGU45Nux1TQIcLFndyWf1PlY8OwsM439weeu38OuKEHQfydyk?=
 =?us-ascii?Q?fierbJa36HpaqmVkmr+H3BC6JPDjtugVZrq6pWuFiWUHZZmuu7A/J8/zAcil?=
 =?us-ascii?Q?0dUT1Aklc3M2WND8lKvIVgu7nOz2fn4m0yiVixceUl9raaxbwgjj8mjYZwEI?=
 =?us-ascii?Q?uGEVeB2rIFkLvb6k8F1hLSBzh5WpPCKxRoCXvbMTFEdHc2TOgdN5dbiNwgZt?=
 =?us-ascii?Q?N8hfo7ayWWwyg3cnV8FROl5WqirwUg5z/93lLpfpkpz/MPYjfpu1BMtANxwc?=
 =?us-ascii?Q?G9gYZS60Oavi4Gg+KC1SEL8WTZJRHBI8yXz5Sk3LWeiDJM3Vn+ppHN2FxyZ6?=
 =?us-ascii?Q?ysHhzlY6tm+rOwx8J3YH4M7NbDPwz8FXLnqGPe3+ikZ5xjTHZlKOHSErnsKX?=
 =?us-ascii?Q?N1taIMfhgIHEPtz40NPa4jhBuOkzZxUIy1zHBY544HCS4bx1wbCgCwM2kt3r?=
 =?us-ascii?Q?n2yGO/cJ/FKnjFlgmu9DwJTWgKEr6Sx8xoUAe0LzSpQoEwbg+OCIK8+oHTvh?=
 =?us-ascii?Q?JozALjaSBc2hd5KQAl5PL9BUKWA6dmrq6U1umVSKFpigHlGyp6VEiDoqqIGb?=
 =?us-ascii?Q?f/KvQIqxeYahKN2FebqX6pxgYObRat0Q92exo67nwe7D9myTxk+mMr9zkzK8?=
 =?us-ascii?Q?0C6EkkmfxZmO4bGb5trUsGIsas7ug9pj5VCKk7bt+tgUZE/ftSf27332cnzN?=
 =?us-ascii?Q?QDqamvw8FZExBFS8GiGAchpi7oahjWWbli4GqoQdoKin772uz44jhuDozffA?=
 =?us-ascii?Q?003b8atZtV6LCK3ygg6QVo95hZPXB3pgCbRrgpFyF5P9eEoGiNQMHl4DV7Yq?=
 =?us-ascii?Q?8jBux8nhMEVrN8Ef70akBVUstP5tH3tyiorhnE7LcFY79Lrr6hXBSZVwWQEf?=
 =?us-ascii?Q?h+IEnT2kw0aD6tfSlPA9Jx7JulEgLFU6bA1xOBm1yKaM9sqlUymPw21vYn/b?=
 =?us-ascii?Q?guOouDrYMW2WmLqPuNrZB/Jr1xmtbDrKxMUBNmN/VUAdLxj6jJrpUu9vOawW?=
 =?us-ascii?Q?GNL7XWOwr/EdcZachs+ket3x9144LJOFZDUZ9S7U2V+eyFLgyfMSqZnOLn4v?=
 =?us-ascii?Q?YtycS2g7l0kg2ScvS2HJwyEZ8dmfE5pRQpE0EkpmUXxNLVGYnhNv7EFKmi9D?=
 =?us-ascii?Q?6MOryqROe1xdGr5Te6o8vd3/JjdNu0Q5OBjEchYyoF4qXMn7M8BYQ7f1GKBO?=
 =?us-ascii?Q?9RXV9q33Brd+ePUpAtZbAFm4KuIqiXxAweMPGufvdVN0vZASZy5sasx19tlV?=
 =?us-ascii?Q?abtPs5zIJilYBEoEs9ZReYG//XVLin6pJnmbHacOWepxavPjghxnzi5VB64j?=
 =?us-ascii?Q?HVlrEjhJmCHLHN3V2wGaSPXLQ+/q+rSduO2hqD1EwRvCijN1/UZcMQNC4uOP?=
 =?us-ascii?Q?NWvFzw6s5T6gNIt4A7ZIJhbx37BqBsi40OAEcBdGcj2Gd85OuavR0zcfx6Hn?=
 =?us-ascii?Q?+GvtXTn9p22cgxHd+p7C3AtVXEDjtiHtH61pDa8InwAMsGh4gZgfYHvWnflJ?=
 =?us-ascii?Q?KcCuTttuieeyVVpg6MfROZv2XsU7HPuwqonzM8bNggzYj5OuO2deILm4Lb4h?=
 =?us-ascii?Q?J0n2tTbR/fDGRrKGWrRscPApsIhhZhKIqEn3G1HFuSEjrAEH5zkfhzNgyXLd?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 519f027f-00d6-4e2d-c67a-08dd71559e0b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 19:44:29.6577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZA+2dO4Yzr9qe8yEE7uMNhgefXpc8S8ACx2pz25OJminVJkGMOJWT8asEX3HDHYHSvW2WUKPoEQZSqubM0bF7Gu/tZW4inEROPmcOQwXKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com

Oscar Salvador wrote:
> On Mon, Jan 27, 2025 at 10:34:02AM -0500, Gregory Price wrote:
> > v8: nits and tag pickups
> > 
> > When physical address regions are not aligned to memory block size,
> > the misaligned portion is lost (stranded capacity).
> > 
> > Block size (min/max/selected) is architecture defined. Most architectures
> > tend to use the minimum block size or some simplistic heurist. On x86,
> > memory block size increases up to 2GB, and is otherwise fitted to the
> > alignment of non-hotplug (i.e. not special purpose memory).
> 
> I wonder if something like this could help us in improving the
> ridiculous situation of having 16MB memory-block size on powerpc.

It's only ridiculous due to what it does to /sys/.../memory,
right?

If you permit me a bit of hand-waving, it would be lovely to deprecate
/sys/.../memory in favor of a new (fd based?) ABI for memory-hotplug
policy management and have something like a fuse "compatfs" mounted at
/sys/.../memory/ for maintaining legacy compatibility for userspace that
still depends on twiddling with individual blocks in sysfs.

