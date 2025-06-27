Return-Path: <linux-acpi+bounces-14790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BDAEBF68
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 21:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49E54A1A30
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752571FF7B4;
	Fri, 27 Jun 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igtukmze"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD211F7586;
	Fri, 27 Jun 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051246; cv=fail; b=u8Tu11ywbgaWaUoVl/1JwPUBOOb9FFViiyhPcccRG0iSzUesdq/oOANuFFFl/KaKuMGzr1PrGMlp8Hj8iogOTRVUUkw2ABznFv01bxxzV0hFuIZeDBL5shefABmlk8e0fzdvKClkpZMYKhT10IjBWbP420pnhisRI1Oa+5qiPAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051246; c=relaxed/simple;
	bh=rkyC+mM+renp8PEFKvoFx+iW/JH4k1t9rvYVTqYkmC0=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=AZAX/AJWvzTPBtO/06E9quDXOCzEvbAm5UtruHcip4PWSxaxZo0ILR+3IpbfapsBD+mjuRijdETPQDeOweKrPzATWyv/Sx7XFnqGToiIAOPVBQ0li5HhEB9DB0BsfM7IK7HBCqWRwXkz5XrUFgRGZy5tRBM3BdmoK7EBSZi1hGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igtukmze; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751051245; x=1782587245;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=rkyC+mM+renp8PEFKvoFx+iW/JH4k1t9rvYVTqYkmC0=;
  b=igtukmzelpgsQsrR3fVSIEXypMyZlKwuoegwuq7jPQfqneihKb70d9i5
   a82YXQORNFGgbJyKrg7Jg65QwRNoXkJb0sKcbCYEwpXawfGrfReUbwQv3
   CXx0kWRm4lkIBOvosF2fMqQRUJvxhe6HjvsultffICTSyNrwyVW9Sp6nF
   f6q5+BRjUHbzw9nO8nEMKUTT+UyLR+82v6R6OmlWeUEM8nb6ET3uiNvdr
   bLlMFM7b4+r/mJS9ZL1UYJptgqlh/m6L6KsX18AOotgmXw5ByGMrQFeyi
   0YNxvweF9DvXwRgP8nrYGzRzhxYQqhGBDTZSYH1q0FhtLu4x8HvALpDhJ
   w==;
X-CSE-ConnectionGUID: /+Ckpb7NTYW/z6B4RNtHYA==
X-CSE-MsgGUID: 6Aj14bmjSU+Hw8yDqdUzwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70943072"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="70943072"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 12:07:24 -0700
X-CSE-ConnectionGUID: Um1vYVhLRU6y7hhir3mQlg==
X-CSE-MsgGUID: C5Atx2XJRLWyVeaLzNJ3YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="158381818"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 12:07:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 12:07:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 12:07:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.82) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 12:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBkil+jJoyWwsoyObAufoIDtxHIw6/lrG0YA8RfYW+lNnMnu7BG9he0o1gaaN3OTgcX0yiFVNU7E6+oZ0+ctUzcj1p67l51IABL9raRxWM3TrgcAyc8V1vxJvbnhoKA9hI0wS5j3LRaXiIQwa0pEf1h0gTalTlTwr8mpVT6858NyO4y7zabYNlg4blYgutvp0u8Pq+xflzkPeqgUxiKLli7c+4n5R7wxHDsuAI4P46G8WztL6LCndX38xdSYKtmUTzKO6S+4sZCTJ1qbU6GCARR+dwtTIsGPTpz+F5+d0nc3TMb7Qw0DbHdCCKbpiG/gPbsm0GaRDxb5WqYDZT5fGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiXOPTfx/dU/qDZYe45P0pfpOnbheeEzVbe+8qDR+LM=;
 b=wS5QfG22CrcaAyr8RCz4tJ+/X7kWS6WKRE7BYdrix5wZQWO7yc2f8xS/utpUgVJRrqL/5pfssUS4rLzr5sjf67Lb3vLv0GNgBzqp2b89kDJKRN+WaXHXVphSROGwrBKc+/oTi+jcOTJb2eCzBMgibLSLeSF7eIOS0iRnLd2bTqUc2Lp1HaFiN8AUVjCOSVSEIT5zA4927O+g7mxhZvZv9ns2MDKjQwKzZ85WEe8VUowNeSWTS0hJL7Kzu51D1/wh8HNnsQ3qh1IJXa/7Lp/uMxeTSiw+b86GVu/M/JwQqjDiLcD8u6Ff+3ousGo8N0VTD30qME4ktdjQK1hMcmMP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 19:07:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 19:07:21 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 27 Jun 2025 12:07:19 -0700
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Kees Cook <kees@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>
CC: <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <linux-hardening@vger.kernel.org>
Message-ID: <685eebe71a00f_23a2a100c7@dwillia2-mobl4.notmuch>
In-Reply-To: <aF7pF4kej8VQapyR@kspp>
References: <aF7pF4kej8VQapyR@kspp>
Subject: Re: [PATCH v5][for-next/hardening] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0971f5e8-245f-49ac-242c-08ddb5add7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnpNUHowTkx2SzdVSnYvWWs4UmhYMUR6M3pRYlVLNWhlZjllL0FZcFhrSmFU?=
 =?utf-8?B?ZUlCOThuUU9tNVp5NXE5Q3gybEc1V2NneUF6KzI1aHNzRzZwSEJBUWRIaWFW?=
 =?utf-8?B?Zkw1ejR0TzJPTUJGb1F1ZUtieUIxaVRiRlhZZTJHT0h4b0cvajhqdFJqRndC?=
 =?utf-8?B?Wk9jRUQvSGF3QVdadGRyVThtZFJwNFNlaFhEdnRGanZPTWxWYmYzN1FwejM3?=
 =?utf-8?B?cnZiamVZMHZFdVFLOEVWcXU4akRYM2ExNDE1N2FjRncwZmZQM3dwbG43bnVm?=
 =?utf-8?B?OGp1OE1GTHkyekJsTDZneDRveTk5M0k2NVJNekpJYkplVW4wbUhBK3pBUzZu?=
 =?utf-8?B?aEFXUk8xNkNqbW1iaWErbndoYjhLeXhQanJoYVorTzQ3dzJEYmM0eWRCL05N?=
 =?utf-8?B?Zmw1NDVkOWkyL3Z1MTRTZmZmQy9CR2d0dHdIQmRIdk9CTkpxZlpoYW0xbHJI?=
 =?utf-8?B?UGx4Z2owV0NYQy9QRWo0VEhqWUk2QXFJRU1xZ0MwNkViUW5NM0xHbUtuZlJz?=
 =?utf-8?B?eEs2WFR0NFU1QUU1Q0IwVE9lUy9Ra1ZKWDhES1RzUHQrSXlhS1crdTdGYmVW?=
 =?utf-8?B?bXVKc0h3UEliZHhkWUFEbGpndHovQ3JtdkkxT0YvQXl3R2JOOENsUE9Ka1A3?=
 =?utf-8?B?a2hkMFBYQUQ5aWl2OWVGRUdsUndSNlRMSDk1Qks1RTJBQzFNZ2FNM2ZPemh0?=
 =?utf-8?B?QVhRQXdiQXJ6WE9hUUpkUVdkVHJuejE2VHdMTkFKMWRTK3hjdWtVaG4wYkxF?=
 =?utf-8?B?OCtLd1NmNXBQalM0TTNVdHIyVGhNdWVwTC92Nnc4QkEzNEp2OHVUTy9qaFV3?=
 =?utf-8?B?QlFVSWJmb2RmMS9kNTFmQ25MUkZzNjFsTHFlUEhPenIrT2F0eGxibU9RTEdm?=
 =?utf-8?B?NTBMelgrV3Vvb1V1eEUwT2hrcHNYd0tDMVRiWkgxT3VYM2gvaUlkMTcwc2hP?=
 =?utf-8?B?d1hpUFlzVTlvTVlTK3RyUE1JakxvYmNVZWJxaElmMXE2UDlBRUJKMmdnVjV5?=
 =?utf-8?B?bkV0RU5aSGhLN3dOWHAwRlFQaEVPS0hiUW9HSEVPSlo4TkhIanE3UG43VmRN?=
 =?utf-8?B?ZnJDYmdTU0ZBUG9DQU05eE9zbXd4UzQ4VFBpdjNGUjNKbVBvd2ZteWVmZHJD?=
 =?utf-8?B?T2dud1k1LzlkdVhVdEpSSEZaMDlZbTh5ZEhrSmRrbHhNelZqUFpKVm56cWpo?=
 =?utf-8?B?R1Q2RXRWQ2dFaGhwcy81ZThLZ2VOTkUvbnJ1dXRIeWZ1cmN6NjFqRVJITlhG?=
 =?utf-8?B?RnpVT0I1ejNBZ3FPSVJ3NFcxS0lkS2hXcUI2b1V3Y1U2QkRQTjNaR1RDTlY3?=
 =?utf-8?B?azRGS1E1RmpyR1FpVjBwSTY2OW9EZmlENkFqVnllTVdDek0wN28vNDg2QWR4?=
 =?utf-8?B?aGNKdFhuSDNMUW9KcUkyQVFqSFprT3RWOE5pbmlod3gyclpYU3k3RzhiVFVK?=
 =?utf-8?B?Nm9abnllTXpxazdRREQrWHNkTnpzZEUrcHBjQVBoUjFaNVhsYTVaSzRwSy9Y?=
 =?utf-8?B?eXVNZmNyaGZtdllUdEN3NDQrMzkrQThIU294bnN4WjRsSFJrTTFhYVBwTTRW?=
 =?utf-8?B?dGxpOW1kcU5uRjVaRHhZM2w1SEY3UVgzV1NjNkJzMS96dWIzcmFCOHNYNjl6?=
 =?utf-8?B?NVB1VjdUVHc5U1RBS0YvalBkRDJCU0xXeEJtZ3NvT2tGZEsxeXpDR0F0THd0?=
 =?utf-8?B?bnVvdTE3NjF2TDVKYnVPdzVwRFg0U08vSlV4L1E2Qmw5OXBoRXljRzBmUTRW?=
 =?utf-8?B?eXBqNEFoUWxUTW1SdjM4THc5MXNucjFYT1FsTVQyV0JtYkpEd3B2a3VWL3d0?=
 =?utf-8?B?UFNCTDR3MjZjWDhuK1RpMXhWaW9pTVlWKzRGaHNSRkExY05iUk5lSHpjTTY1?=
 =?utf-8?B?cDRBNVBrSXB0ZjNIVjFCZ1RPdWh1Z1pscDZuRmlMT1NWakxuUC9DZVpVTGEx?=
 =?utf-8?Q?DlqZyB5v7kw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRzUjZQNEZqNHVxNFg0YlJsUmtyTGhpKzk3dUxjcXo1VG03d3VVaVJmOURi?=
 =?utf-8?B?b2c1UGlvWXAzcnhTT2tYNjU4NjRqY3RxMTl6c1NURGVLU1dndTArL3NKbzhk?=
 =?utf-8?B?NjM5Nk44dDYxZFVTOWRPVTZkT1JGYU85S1E4NGZCNUlwbGgreXNkb1haY3pY?=
 =?utf-8?B?aHRIU09xOVl0OHRqb25tUU9LRG05Q1dENjhuMm9wLzVqckhhVG1BSVNmSm9I?=
 =?utf-8?B?ZklVODlsUGNlYTBwSjJ4SC95dGcwWmwyY0tlMDRlWkt0YzR4eExTdnFOQUtw?=
 =?utf-8?B?UGdIQjNXKzRCSkRKZVdubEZDTFliaVN6d1JzbWd2eThJYk9IMlZTVUI1S005?=
 =?utf-8?B?MUVJTzVOdDhlK0FZWFMvQUNRZDJ3TG5kU2pNVnFFR0ZrY1NZVTBSS2RDdmtq?=
 =?utf-8?B?dUJuTnVoMkpWWEplMHIxSUlwWDJaTW1KTjlvSWdOcHU1TEhTYm5wa2V6ekNX?=
 =?utf-8?B?N2FrOVgyMmYvcFcvMzlyVWtkWnhTTGg3aDFTcFRGZ2hDQmR6NGtMSkxJWXpO?=
 =?utf-8?B?a1IvTEtuUUhPRXd0KzBsQUE1VWY3Z3ZlYjR5SlQxVHNENUgxcG9ISXRvMmZQ?=
 =?utf-8?B?b2pqaE1CV2ZYYjZLR0tZUlh2ZE14b1RBb1YxSVNicUhKRW5GWjF1c2xEWUR3?=
 =?utf-8?B?a0VSd2lYMVFFSWZzVTIwSXlyVkRmU012aDkyL2dySHQxUUNqdzMrWEJWeGRh?=
 =?utf-8?B?Nmh3NUdWelRIZVdLTG5pbCt5OWtPbVF4bU1aMk9zRFJMcU1ISlNxVlBvVU15?=
 =?utf-8?B?NDRxWjY3bi9ITjAxL2NpclZ6TVQ2cUlaandKKzJkdWMwWWdUWU1oMWpOWjlu?=
 =?utf-8?B?dG9DMUpiSTZQaGJ6Szd5Z0RMK3hld0xma2pBYldGd3RTeHB5K0pMZFl2Z3Zo?=
 =?utf-8?B?ZjdxeWxoUUNxL1RGcTUzWnR0ZGJDcTFFNVljNVhpekNucG1mRnN2cHh6QUZh?=
 =?utf-8?B?UWlJVWdaSDVwTWIyOHVmQk1kL1lqM1hXajhCOVdOMHp5Q29iY1RSMWlnQi9C?=
 =?utf-8?B?SnpEOTNnSGNDd08wKzBiYnhTOElKNXh1SS9QbnVublI0SG40YTNqZGpyV2d6?=
 =?utf-8?B?TjVuai9DU2ZLcnZpRytFcTBBUElDWmY2NUFQeDh3U1NKYVhGRVNNdGpqMUZj?=
 =?utf-8?B?TFhVNGtGdG5QTDZ3TzArTXVoZUZhV2tTd0tFZmYxTmNQOHRGTTI3anRZZ0JK?=
 =?utf-8?B?Vi9qMGMzMVNBcjZJRGFMSkhRN2kxRXlEMzJ0VU1ZVlRVeXlKUDBSTGwrQ3NF?=
 =?utf-8?B?Mkd1YTM4VmRuRldyK0NvVnYza3Q5VTZSaFVUMmIxckdrM0NGVnhQUGU1eE1D?=
 =?utf-8?B?WEtkcXFzdjBJV3RqUWdvdVdEWlBSQytpVE9mZU1oZFBsaFJ1eHduSWdwNG02?=
 =?utf-8?B?SDdUbWlWRHE2MGcyZjlFNFhyUDFreGFIYWt1c3g1ODhKL0p1RjBYUVh5WHhU?=
 =?utf-8?B?YmF0NUtLRVlhMFJuOFJpN2s0RWh4VXIzM2t3L0U5UFRtUlBLcjMxb3dDbCsx?=
 =?utf-8?B?anJRZVhCTjFqWjBERW5QSTdwMFBaL0NOZnNDQVpodVFQQzJxRHFLcm5DVU85?=
 =?utf-8?B?L0UxWEVPemxxOHlPb0JxZGpjV3pKRWdQTUhlYWRXSW41TjFWczJzdzdrZGZk?=
 =?utf-8?B?MzRDdDl4bXowNFJ0MjhqSUI3ZVk3KzZFVjljRi9CcHMwVmVPYzg3Q0lqNmhV?=
 =?utf-8?B?WTBuSUthUlBmNS90NVoxcmk4K3IrTjhUQlVTS2FZQS93QUdmSEV4VHduUTV1?=
 =?utf-8?B?TjB4SDk3YUFUWXFGbXplSzRSTmJkWlFSZTd4ZExDWVNDdXVRUkhuaWtRNytN?=
 =?utf-8?B?UkNRMmloWUdKYnBzYksyejJ3aEpRdnBLM1hkU0VJdmJTdWl2azhIV3RUNFZs?=
 =?utf-8?B?M0FpUVIvRTN5UGN5amJuT0lyWEVQcHRDMkxuRlRQeGRJL1VHakFkTGdrQmZT?=
 =?utf-8?B?U2taSDlKRmZ2NUNXd002L0pkSTBnOVF5UDcxSVFzaCtETUMrSUZEcnVORjdk?=
 =?utf-8?B?R1FhQjh5dklDUGw2QXRqdGlPaVZQeEY0L3ppZEhaamI1ZUZYYWFDZkc2WjdE?=
 =?utf-8?B?b3hQOXhxNFhwVWxQVTBWY2lJUGQrT2ltWXlMR0ZmVXI4LytndjhiTmFEbnl4?=
 =?utf-8?B?OENuYnBhb1o5U0VWQSttbXNyclR4cURpOTgyRlYwMHBSZkNaaFlkRk9RVnUx?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0971f5e8-245f-49ac-242c-08ddb5add7af
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 19:07:21.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkGOt0Gau6YYgfc5hsgNdzQPasQ7Jtune9rKLo+odepgR8pvJ6HHRLAfKpC5m8z6E7WtmpuX1pVCMbCCfcyseQ/mwe+XLtC6T27ioREVPOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix a dozen instances of
> the following type of warning:
> 
> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v5:
>  - Fix union initialization. (Dan)
>  - Leave trailing object indentation unchanged. (Kees)

Looks good, thanks for the fixups!

