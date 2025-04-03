Return-Path: <linux-acpi+bounces-12667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECDEA79A36
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 04:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BEE3AF5C2
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFBA18A6A8;
	Thu,  3 Apr 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iva8+i7W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302A14386D;
	Thu,  3 Apr 2025 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648842; cv=fail; b=mQ2YYHlPdLEWN9i6G5dW/ivaUcQrtybEiiYq2MCjfGsHH29zAEx0s/acTecWZ3j55x055ivmbDIiIi5GFln3ifmu5ScjesJlfQDZVwfKNS7hT5cf9dH5yKrQeBwwKX4XVAQKETgIedTgIiCRLv6sBujJGSiLKf1k337fXR+x7xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648842; c=relaxed/simple;
	bh=+KN8lMy6U8j0+Z7M1ySM7hz1pfx1M01jcAkJcZYerSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFgmoK7p6nKXYhXztg5LfqNAgwjyKnWPG0pbl8lNntY8nDe2INFVFVnd/nfNnu5HtDc8bqtd9s4rnp16dBCjYTkfwdsPpXArg43F6JA4WBFdc88VjOAoxzyqF6FkSW/aQIyou3ZhLRr3XIlVSTZNxZzh9GvfJmM7dHB5w/o6LLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iva8+i7W; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743648840; x=1775184840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+KN8lMy6U8j0+Z7M1ySM7hz1pfx1M01jcAkJcZYerSA=;
  b=iva8+i7WqlIDGlbrneu/I24eQAgzhGwlQWFPq1S7CwoabtXq1TdIk+Qz
   zNbr9vLPA5Yz9cj38S4c5xy+CFBih+x49f9wrVxQrdkE/R2hziR914rBG
   m0rLNhyZ7h1W+e4wEMe5RO+6J/Lp6R5i9TJnUv+r8ZN+wZElORfKhAdpt
   G7A7OKHUeUjMYJLyl4mtBxWqKqWlGkjdhquE5lllg4gJpiNHpD/MgXZtD
   y0wtS6YB6Dp57IO/z89JaiYgKU/dc1Y0d+1Fu80Gqh3TsvVZB4razPVwO
   BEAIcNJ0w/Ds3MKzTVjiJbtxoHC7VMwuAVaGXRTtICHoXwNbATleEsNFk
   g==;
X-CSE-ConnectionGUID: 4vvU0bnMSdSBHBQyvJe3vA==
X-CSE-MsgGUID: 4MHIfx92Ss2Gtai8AUeL1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="70406574"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="70406574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 19:50:18 -0700
X-CSE-ConnectionGUID: 8jwUR3bRRGaDBg5PKNHtzg==
X-CSE-MsgGUID: PMaVrXWRRyWW7o12GmGh/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131003837"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 19:48:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 19:48:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 19:48:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 19:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/kAXAwizymsa1XJz2punfuvoSQKjXG8pu4HFDe5b/7+6lE1e74cVnTFA0rxjW4/Ven9F1OmXpVF1jy3Wd2KpnzvZBrrXDI6qNsYvuCesQzeub4mhGLWJuXOr3vo7mBKWZ2AbaGCrZIkfyf0vm6n0IaWeDHzLmPlUKA2BghK0h5fNEF6U9EQc8FcqMDzOipGaZ9tTjr4WgttPvF7Whx/kqlYqYvkIldkT9b7X9aoID96Q+VB19s9FxDda5Odz9PzN0u72NIexSFB+IytWzK/VxC+O8JU6fUj9jRx21F128S7dmymdA7HyX05J+37dKhhbhnd2Fp978jFKO9VbupRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KN8lMy6U8j0+Z7M1ySM7hz1pfx1M01jcAkJcZYerSA=;
 b=qCul0lASACW3TEqcnY9+7Vg/G25FULw7yLVQOqVMhdvecRIQTdcJS1TNHTotewPpbaduJUv7sChg/e75gH8Tn40FYreVlcwl0ZG2/hl30T1KjBX+UuDkNQsrsGC6sz9+xqb4twPR8UMiaAK5MModeLYwa9yxqLeu9y3U/1Bu9Xy8ZCYa8R/SOhj8LBh2cVjzpYoND2Bc3Rz1TsSuh/8AQD1sWf0cVmUycPFtLXxnzdLgiztpidKNBZ5n6sDc46/mONeApWMorsLqgR6Ocq3kRh5Bowbiu+THT/LdZFEL8gCNn6nrPWi5Pjfk9tcQQdOWYYC4DdvfoEUJi77FvKnlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5919.namprd11.prod.outlook.com (2603:10b6:a03:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Thu, 3 Apr
 2025 01:11:53 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 01:11:53 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "ggherdovich@suse.cz" <ggherdovich@suse.cz>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Topic: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Index: AQHbn+4UZ+9FL9Dg6U2jNOmvmyjByLOM35CwgABLc4CAAM4iAIAAxhEAgAJrsIA=
Date: Thu, 3 Apr 2025 01:11:53 +0000
Message-ID: <29626e175f3238ae04451477e38bad875794a61c.camel@intel.com>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
	 <20250328143040.9348-2-ggherdovich@suse.cz>
	 <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
	 <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
	 <7a14ea42462a346958954f328933f583dcf9cb52.camel@intel.com>
	 <CAJZ5v0juH2kYx-fyyfoFLBTjg30y59Dwj1wBYXxuHvU2c7X31w@mail.gmail.com>
In-Reply-To: <CAJZ5v0juH2kYx-fyyfoFLBTjg30y59Dwj1wBYXxuHvU2c7X31w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5919:EE_
x-ms-office365-filtering-correlation-id: 31c2eb31-fffb-44e7-bf8b-08dd724c8526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVkvTUVMbVlxUDFaZS9WaU84bC92L2hqTFcrSEpQRml6WmJKei9KUzJJNGRQ?=
 =?utf-8?B?VjhLWkhTVE8ybnhjekJrakxhcmw2SXN0d1hEbEJDMmZyd2dtRS9IZlV2V3RZ?=
 =?utf-8?B?eGVKVXdLSTVrcjBoNExHQ0E1cTIvekVHdHVnZkdBNW9vaDhPQkFBaXQxTExE?=
 =?utf-8?B?ZkE2UkVZTzZxQVBQT0NYQ2lORHdQcHVOb0hrZ3lNaDZIdStUSWozRmloUUZm?=
 =?utf-8?B?bkVwbjlrUkxWcnBDM3ZQTzN6bkNNdUNoZVZVeVJ1ZnJxdVNkT1ZKcXFsZzg4?=
 =?utf-8?B?aWNHTU1pTkMxNkU2Rkw1QzV0NWxXcDkvSUhBVzYyVm5BVWkrTzA0VVVrR1h4?=
 =?utf-8?B?K2pvd1pOMnJVUmszTU5jUzZqSUdFWDllNm5PcmJxaVR5a2hXR0NveldtSEJD?=
 =?utf-8?B?NE1XWUlhTERYZGtDMTlaZUZzZFQ2cHpHK05Ed0RKK0xXWmVJZ29GMXpyTWNx?=
 =?utf-8?B?M3dhREZwTnVURmFtcnJWZ3pGUTBNRCtLM3c5dU91WDZIYXVldm14ZHVvaElY?=
 =?utf-8?B?TFVHbS8yeUsrZEhKY1JFclFyNlRud1dMY1dWSTl2cWVRWDJEc2s4ODcza2tm?=
 =?utf-8?B?WVFFcTV0RGxVcDhUOFpOVlQ2dFlITGdRS09rcFZGQkhieGhKU1hGU3FGVFV5?=
 =?utf-8?B?TW1NVGhDUWhqN3BJWWNMYW1pMTdScWJRR2VJZjFJZkM3UTMrR2RRZmp1aWFU?=
 =?utf-8?B?NTBheERFa1F2UG0zWmJTVE5rby8yTm5UYUJZVDdoQ2JGYk05ZE1JYzBTbkg4?=
 =?utf-8?B?OEhldnZiWkdZSjZ2NDlwRkFMTGxrVGdsU1hmU0JMZ0ZTSjRRbXlQbzVzU1By?=
 =?utf-8?B?UXd4QWJIQ0Zuc0I3ZEpMc3M1Zy9jdVllZzBUYzAzT0phK3U4b0lwWndBcDVS?=
 =?utf-8?B?UmxUYXB2R1E1a1JTMVo5TjZmR2htT2Q5cGR6c0RsSysrbGZFK20zQ3NPOG8w?=
 =?utf-8?B?YTMzSnNLWGxzRkJKTmttd0xTMEJ6aXJ4UmU0MFl6T1liNmM1RC92VHhuM0tx?=
 =?utf-8?B?NXoyZ2o5MzBQMmZVRHB1Q0tzVmx6d1M0V3RDTVpMUVpKcTluUDNJZGFwTkc2?=
 =?utf-8?B?MGdxYU1YWXZEdy9KWjNjbFZYSXJMVWRzMHJWanZTTmxjOE9Va3RLUUV0bUpH?=
 =?utf-8?B?eHc2ZzZpbjlIU3pQYko1K0JHYnphc3oyV0NBQlBqOG52b1Qzbkw3Rk5CWVpk?=
 =?utf-8?B?M1BlR0NWanF3Z2JMcFJJN0ZGWm9XRDF2UWFIZFQyNzQ5TlZremwzZFlwUXZr?=
 =?utf-8?B?R3VSSlZ3M1U2SVZKYjRZajlPQ0UyTnl5bkdTdHlwV0xHaUN4clRhZzNsYkkz?=
 =?utf-8?B?WGQ3UTdnMlArNmNHVUhIMDRJRGwwV3JWRHFIYUNyNno0TE5BV3ZLbmN2b2tE?=
 =?utf-8?B?UXJ3ZTJFbHhwRk5HcGxYMlY5S2dHSVRUdTN3N2tKdEVZZTJxcHpKdFNFTjNv?=
 =?utf-8?B?QWxWRFI5Rjhtc0VPRWYwb0J2TE9CYk16ZFlmYTlwbEN1YU5uS0hMUzdTZzBD?=
 =?utf-8?B?TCtvU2hiVW92azUvaWpycmpUOXlUVEtROXRBa2cyOW5IdERMVHJPVVVBcGFC?=
 =?utf-8?B?cFVRMjI2dnQ4NkpSSHN0RmVoRnJBTEJOdTkzNXhaUko3djVqMENaaHlpbFBw?=
 =?utf-8?B?azJDVEVrbDBKV3JkNDJ1S3JES1BXN0ZhY0FoQjc4Nm1xUnVxWk53VnNLbjBs?=
 =?utf-8?B?cGRwY0JlNGlvTnVNOVZZcXN1ZWU5bTcwdkkwcEdQQTZucFY5aExuNXpJMjhL?=
 =?utf-8?Q?3yC60B8j55gBA4MLE8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c21IZXJIU1Z5TFJmVHlxWFg1L3ZkRGkzZVo4UlJnS3U2TmFSY1lqRlkrTGFq?=
 =?utf-8?B?dmRueGI5eVphMHpjbER1MjZLYkZ2RHZiTURsQU01OXFibHF2dUhzU0tMRWFi?=
 =?utf-8?B?VEVaRkNidVBRNVVSZjF3bzNnei9zU0QvZHJNcDVvODVkTXp2ZGNUbGRVVXdu?=
 =?utf-8?B?aHhVYWt0Qk9XQzhvM0d1M3RTaXFQOTJSWGQxZWhVQkJLMGRiNFpia3Y4MDRs?=
 =?utf-8?B?TnIvZlkvYmVBaGpKWm05RW52UDdhYzBNazJ3NzJjQWFlaUlJYUREZWdac3Zz?=
 =?utf-8?B?L2JlbWh2dEJ2Rm5vdUhmSGNUclo4dUxUaWg1WHcrNW9SLytUMFZBanhZRW8v?=
 =?utf-8?B?cloyaEhKZFlkTjdHcDFqZGQ2Tm90VGw5MGIwQ2Y2QVROeWVhbEp4alU3ZUZh?=
 =?utf-8?B?azNGUldFUjd0L1llTk9vRXY5ZGVRWGdtRFZPT3Q1dEordjhDd0x0Y2ZyUm45?=
 =?utf-8?B?d2pMTzNLMVpodFlBUVFpMFZrZ295dTA2VWhnWk1XZmF1ZHlab2xVNnJ5Ymd5?=
 =?utf-8?B?Um9scXdjWndJUmgrY01pMWdXbCt6L0NqWXZPNEZuLy9FZlpQZG5hL2tWRlhO?=
 =?utf-8?B?UWxNUTZTWGFuWjVTUU13K3kxQlphRjNOWWNhYXBCenNSelZKZTlNUEM1UTlO?=
 =?utf-8?B?ODU5Sk9IMXN4YzdPVC9rZGdqcExJWGo3VGFvOHczdHE1NzdnellzNzZRaUtD?=
 =?utf-8?B?d041U0FoTDhBbWNKdHFvMElJWFJURXNXT2x1VmZkMzhzYVIzcWdVVjllRVlX?=
 =?utf-8?B?alp5aWh1Nnc4cTViRUU2MXR3ZTlHTVVKY0d0dWVZZGoralVBSmgvbVFLOWdG?=
 =?utf-8?B?eVQyWGY2TXd4MVJEbExGRUo4WTZIMi9RRHI1MzlLNFluR2ZRdURmMjUybEky?=
 =?utf-8?B?WDdETTNIYUpBbWdmZXZGVXdRSkxvaGU4SUovVWhwbEV4TU9vbzlSc2Ivb0tC?=
 =?utf-8?B?TFhKZ3haNHVKYlp3aVJ0SlQxZ0w0THphYmhEY01jTjJ4RjZsVHowdDZGVWUz?=
 =?utf-8?B?L3JtZFZRaHV5SXNpMXpkbXRNSXgxb0tVM0tmNkFyVitTa0FvZXVFZnAzaXdl?=
 =?utf-8?B?eGtSeWVlQmVzbjkycElDd3gySjlQNkF0MlFsY3piRUdYbVhETzNOKytYWlgz?=
 =?utf-8?B?a2RJbjkrOFV1NEVFQnUzZnFHRDVxRGQxdlFBZUhOQ2g0KzZGWS9Zd096bDRU?=
 =?utf-8?B?ZkV1MDdrejBEc2xUYjNjSjdpZVNLSmdwUkZsOFgxMHEzVWhuOWdqKy9NMG1U?=
 =?utf-8?B?d2U2SUROM2dYeTZTTXJ0YlZHQnE2MzRTUzFCdytBUEcyYnA2ZDJPOWRBcFJp?=
 =?utf-8?B?T1ZOY2FyemRLYkZqSE9lNnZsZzZRdmx0bnp3VEJMRzQyejZRUTVrMEFQUTdv?=
 =?utf-8?B?cTdrSnJpb1dEZnh4YlkrQjc3T1dOSUhidHNZeG8zZHVFTmtLaWc0UzZKVFNx?=
 =?utf-8?B?ZlhWNE5uQlQ4SE82U0pIMGk3YVZIVnlsVG12anlPNUo1b09HOTVObFN4MGtn?=
 =?utf-8?B?RFBmV3piQXZ1VzNpRzFYbDNuaG9aMVhTeVZSd2l6RjIwYjBrVmtnWkpDVm5L?=
 =?utf-8?B?dTNIdnNLaGljaW1DeEtyRnowWU1YREJJVnA4Mm5MQXlNQU1NWldqdllmSlpu?=
 =?utf-8?B?UlhaaEppWHEyUjdOdytJbUx1Rmh4M1F4UVhYVFFiaVRMQ1Q3OXhOMEwwcnh2?=
 =?utf-8?B?c2xqRnNxQWQwM08vRkovYzUwcWNFY1VFd1p4alZrWU9CeWZuOXA0WVRTUi9a?=
 =?utf-8?B?V1FMUk5iR2hwOWRPN3JvWnRBNVBGR0NRczBoSUx1VmtZYWluL1lKRDJsM1VY?=
 =?utf-8?B?VGRmTDRFTHhSZ1dmdmpSQlFjR0NoZmdqSlU5aml2SENLRnRoeHNVeUhEbmdT?=
 =?utf-8?B?MnRDZlhWb3oySmtGNUIvMEU3R3dNOExTN2FtaEY0MnBZN1hGaENQNjE1V1Zm?=
 =?utf-8?B?YS9QUm5XUkV3Y2NGRUpaZExEMlI0QUxXNFJXclBwbmFYOEdpeGxEUlE2L0Rz?=
 =?utf-8?B?VEcyZEp3ZWVBTFRac2JjNFNLK09TODIvMzI1VTY2cldRNVlHMGtZcmNMT003?=
 =?utf-8?B?VW42RmY0UXRPS21YNlFWand1MzNjcWUrS0lZamNPUTBRYzl2eWZ1TEtmc0tC?=
 =?utf-8?B?cmZ4SENCSFNVaXZrRk9RbE05eitkM0Y3N1pSRDg5eDJFc1ZCK2hicktNR2dl?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C4752F4DC3FC4D860168C3B2C8A161@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c2eb31-fffb-44e7-bf8b-08dd724c8526
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 01:11:53.2836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lcztwEvvYztKb4kC12As1gecwhPQnWHbSELwFyGZG+r8lGsQrJQYZnB+w03luzijGPwxtGkgfl1FIHJMG9VdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5919
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA0LTAxIGF0IDE0OjEzICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gDQo+ID4gU28gSSdtIHByb3Bvc2luZyB0byByZXR1cm4gdGhlIGluZGV4IG9mIHRoZSBo
aWdoZXN0IHZhbGlkIHN0YXRlDQo+ID4gZGlyZWN0bHkNCj4gPiBpbiBhY3BpX3Byb2Nlc3Nvcl9w
b3dlcl92ZXJpZnkoKSBhbmQgdGhlbiB3ZSBkb24ndCBuZWVkIHRoaXMgbG9vcCBhbnkNCj4gPiBt
b3JlLg0KPiANCj4gT0ssIHNvIEknZCBwcmVmZXIgdG8gZmlyc3QgcmVuYW1lIHBvd2VyLmNvdW50
IHRvIHBvd2VyLm1heF9pbmRleA0KPiAod2hpY2ggaXQgcmVhbGx5IGlzKSBhbmQgdGhlbiBtYWtl
IHRoZSBjaGFuZ2VzIHlvdSBoYXZlIHByb3Bvc2VkLg0KDQp3ZWxsLCBpbiBvdGhlciBjYXNlcywg
bGlrZSBpbiBhY3BpX3Byb2Nlc3Nvcl9ldmFsdWF0ZV9jc3QoKSBhbmQgaW4gdGhlDQpfTFBJIGNh
c2UsIHBvd2VyLmNvdW50IGlzIHN0aWxsIHNldCBhbmQgdXNlZCBhcyB0aGUgdG90YWwgbnVtYmVy
IG9mDQpjc3RhdGVzLg0KDQppbiB0aGlzIGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVfaW5mbygp
IGNhc2UsIG1heWJlIHdlIHNob3VsZCBkcm9wIHRoaXMNCmNoYW5nZQ0KLSAgICAgICAgICAgICAg
IHdvcmtpbmcrKzsNCisgICAgICAgICAgICAgICB3b3JraW5nID0gaTsNClNvIHBvd2VyLmNvdW50
IGlzIHN0aWxsIGNvbnNpc3RlbnQgaW4gYWxsIHRoZXNlIGNhc2VzLg0KDQpGb3IgdGhlIGN1cnJl
bnQgZm9yIGxvb3AgdGhhdCBvdmVycmlkZXMgcG93ZXIuY291bnQsIEkgdGhpbmsgd2UgY2FuIGp1
c3QNCmRyb3AgaXQsIGJlY2F1c2Ugbm8gb25lIGNoZWNrcyBwb3dlci5jb3VudCBhZnRlciBpdCwg
d2hpY2ggbWVhbnMgbm8gb25lDQphY3R1YWxseSB1c2VzIHBvd2VyLmNvdW50IGFzIG1heF9pbmRl
eC4NCg0KLXJ1aQ0K

