Return-Path: <linux-acpi+bounces-9522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E49C65C6
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 01:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EEF28584C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AADA50;
	Wed, 13 Nov 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCsuf11z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4F2582;
	Wed, 13 Nov 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456731; cv=fail; b=ty9TDjsUFn+V7GQEns093uBT4/Phv6nwSz7mJehVH2qQGNTRltZ1/uAsjsbN0vGdk+QtkTi/DyasBivQSZ0jcXrSrxS2bY03doodelneG9Q4O1ue1GdN4zHRJusVAWoHQSBzC73062WHHyRCmUUVWcAqrYIxxfids9l/TDHDYno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456731; c=relaxed/simple;
	bh=1XrAEx/vkQZsmlZgSinqjQvk2WBpQK6Azbjqi8ssexY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BcXNs65H1m8EaRBxza3skGReYuw6GI6Zertn6vOF9T+AExNqumRbx/m/p+368Bk4DVBWz13nIbLKgcxpSijipqIZG6Dl9rfOykr008NTIc2ghBK1aBSyinjK16vRLgDGqLn85DX2V3vxi8FDuWOEouWLQF2uzGcDRfdy10j3j1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gCsuf11z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731456730; x=1762992730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1XrAEx/vkQZsmlZgSinqjQvk2WBpQK6Azbjqi8ssexY=;
  b=gCsuf11zs30nDxecYlSGuj/bx1icgKLifIZid4oA3GT1ZqiFINa3z57H
   6h8gjtetZVxFm6rB4d3KDmvSNqioewdWqEOIUg2oqPlMg6vflz2m9EIZ5
   OyzOTtuM5RML9ZNT0CiFF4AJtGdsj9WsoWWXG/F1g0auzDQ1LO84wVsHr
   b+d3Z5uaT0HbzjvWLQnYuL4pTuNXZIU/XBYy6v9RC7HmZ1H1s/91eUU3L
   VW0DbDAfb5yFypAEI5yAsVmUxy4mFBYoUc2WtKFnLFo6w2WpZs1ejiq+f
   /nbRmOciSUTnZMqPkH7VamJugAQmTGUpMJ/5i+IiQNRSrlMuwtXPqtA9J
   w==;
X-CSE-ConnectionGUID: EJsfRp1WRXGqbO1g0H73PA==
X-CSE-MsgGUID: 2dNUsaqjQLCRvJygF+y/nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41886420"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41886420"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 16:12:09 -0800
X-CSE-ConnectionGUID: kLYOqhLMQd6YA+QDS6MbYA==
X-CSE-MsgGUID: BPqTDql/Tvu0vxdi023+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="87597529"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 16:12:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 16:12:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 16:12:07 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 16:12:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcaFF1fXscXtbk/CmWhIbW898nn3iXa4yFDQWo+FAUG0ETR4j7HRPvYwU4+AcyFycswLg0oYFoFgltRbOmqbP0iONeK9eJ6wZMgMV/FwV/h0DVm4ceRm8tHs9INs3ksmXuVbq1nH5e4xJWfyC1BwhA7pNbMLtBWYv2uTIO0nRtiy6hjRGQ+MsJIYAADRfIpwFZR7BPqUnsehFYvQUath849yDr2r5qtCKDR1BR6LBhP4djL8fM0wFO1mZDeTyKK96lDyp0SWxJVya/9Bnu9wPE1Wq1fXWTXr0XGECqbJjKYWeVU9hyy8kfK9Yh8YyOMsI/L7p/hE+uc+IrYXpeBA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xx4Biop5owohSn/N5yMgRiPEYWr46TieXdDm0Q59LE=;
 b=Wcw+ffNOOgwFiLcK9BPZlTeXKv0bAgOtmyzL/D9blfrS+k8mueRytQhBpgyT1l+5jsz5AIXOxGzfDMxiewjI0t/RmGDVLrQoYwhY51euiR2cwyDIGLXUa8JbSmP/JxM8oE3Ht6hiNzPVKVZNMjYS3Uft+QeeN6ytoWB990wFXAzG70CLT84cdwhniR56FUiqiqjl2URCyg34nc86wfQF67g3QmPlejgUNCrvX2jVd/KpTJu0mYUR3RbrdDeL5Aai8jvz+Eh07sCKiAhLG1xAxu1w5B57NxtQ+uTywheYP+FVdzuLwAqNSnLK98Bdol7mB5o0ZEUAkDwLD3KXSJmDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7803.namprd11.prod.outlook.com (2603:10b6:8:f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 00:12:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 00:12:04 +0000
Date: Tue, 12 Nov 2024 16:12:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <kernel-team@meta.com>,
	<Jonathan.Cameron@huawei.com>, <rrichter@amd.com>, <Terry.Bowman@amd.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <alison.schofield@intel.com>,
	<dave.hansen@linux.intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <david@redhat.com>,
	<osalvador@suse.de>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <rppt@kernel.org>
Subject: Re: [PATCH v6 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <6733eed15679_10bb7294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-4-gourry@gourry.net>
 <6733cba395c30_10bc6294df@dwillia2-xfh.jf.intel.com.notmuch>
 <ZzPpFzdzu-cis114@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZzPpFzdzu-cis114@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f517150-293a-4d39-821c-08dd0377cdf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ie1JigKMj1QAOO0w6wT7mo3Mvff33XhbLuMmdynmquZa4AZzyRzfCXj+8Njv?=
 =?us-ascii?Q?tZytgiwOAWroPW1yBokwPn5Y42walSo17lFcR43cU7LnDoVmB5+LJMnc4cF/?=
 =?us-ascii?Q?F1fIeWGdROga0WbFkGltEUdSKHMixFdkwx4wjzgYyBzpqMUvJRHbi6efQWj6?=
 =?us-ascii?Q?F20d8UrCvsgklGgoKHHoDjKn6Xo4y+scywS1QsanVtzffHkTyPODH5FINeLQ?=
 =?us-ascii?Q?FKayClcuwhjiLQX8CFZ645doUs+WNsOHMeYfBiIwOSsI46hC+jV9aUOrmh4m?=
 =?us-ascii?Q?+3APqJAX8q/6VTPWK1CeA4hI/RIAWle10p8Y/seoFS9/8EGEsmqWUs2G/JqP?=
 =?us-ascii?Q?7CfogkIGu0BbAIZqdWCd8+Mj4Ooc4nxZ8pNWMGbkyiBBt/K+oHkSkVL4pU1S?=
 =?us-ascii?Q?BulPj723Iw8/Jd5nQJl6Sp+e4frPfUEeGGZNIDQ7ldZpqNUVw0IsAtJg81rf?=
 =?us-ascii?Q?zq7sNIGHT2r1MQ5wqL4Kebwb/Mfcn4tpU7+4Jw3CukFzkfUVOsaXB0Ji5ITo?=
 =?us-ascii?Q?U08O4UzxTgpsX5r90KwSNFcCgGNIQY78+hhjVWCc6/8sAVdjfZqtHVKxdZrM?=
 =?us-ascii?Q?xq4TDOPHf4GJYZZOKS1o7GPpP8IeRVtjHsXvYDVc0DuRn2EVqvkiB+j3Qij5?=
 =?us-ascii?Q?Iq1a2D9IsFeBkyb0vatURUZ6JqGOEVyWiNoTwJWHUDLPGjMEEP4tYygWyzjX?=
 =?us-ascii?Q?BxIdyYASlenzsfnTl4PBr6RFfcHlqGizOwvzWECBHit54y/5pBZma2a1YXfN?=
 =?us-ascii?Q?L5X/h/VQQtxIj3LxhzcaY7dmUhBMiM0xKV4C0Rvu34r5+JUMWFNy/nkbFtI7?=
 =?us-ascii?Q?kxf+emnkCBxNPkEnm9xK78oUf/sqyVBDWPT592SNwpuFS0aivXJ1BCr1B/Kr?=
 =?us-ascii?Q?OpVHzA/6fhZStlZPo55UQ8KRX+dxmXRqm7b9tx7t9PHlFLSwCLc+cR6cox6V?=
 =?us-ascii?Q?CHtKB0676E8fSZpneREOkvivFKiKXV1oLKfuXkBjTCmOlAnPHn/uw47LOoS9?=
 =?us-ascii?Q?/ycUo1Raj0+kLai0Hl1Jb9UXdQ9T/cd4cH5OobM50NWAAtcGXJpCZnDuzb3W?=
 =?us-ascii?Q?gIYZqMjGJlPpVsr+frF+E3ze9iGwLTcczK3z04lAm4S7pw5UiJgypJmXWu/e?=
 =?us-ascii?Q?wuM+y2Q9IJ6s5OXMTx3XC52+uhgab0+6/mEM95M6UIWqsGs7Bgkiuh0ksPXh?=
 =?us-ascii?Q?KlllmuvhubawEGc1g4OZFFljEAOZCxVUL1KV//D5Xqf72kQmg4uzuYj60LUI?=
 =?us-ascii?Q?Xaw2xuib60rL+m0CdZIfGQgof/qj7dQGaJKvrJd0YfPKp/SxvlUI9d13axtl?=
 =?us-ascii?Q?lYLW+sN8XcXfMrl6WYQQ+lIN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKUIJbdXYDZ9FZAljSQ6DiDkfijz7yCbzwjlub0PN/lhmqhVdEjQef1TdhHG?=
 =?us-ascii?Q?4s86YIpyd+2vK1ZsYBS3VR0irVp4h731Pw53+qgYy8mc0VOFRYPO/kgcRXt1?=
 =?us-ascii?Q?E2bEVE536pKoxrmGMEgnY7Q5rWJQ17xwWDMY4HNG7bw3TUs/LzBiW9bWvFD0?=
 =?us-ascii?Q?Ts+tKDCvnCnGdYaxZdAfWcZzDjjUcE3P1mUmm66P3pBkB1hlgIz/MwITrmEb?=
 =?us-ascii?Q?5wby71cxMNdcwYclwRk6lO3pIeilmtWSIaw+us+PdCm9fdtN2z5Bk8Na+RGH?=
 =?us-ascii?Q?Dma2WGvhedr92kGiU8ZecxjcaXmlhpF69rX3JpzyQfu09kadhLl11u4D7aJY?=
 =?us-ascii?Q?0CctKbuG8LeQQMLq5Deh2vj7hy1MYXfhpgW/JVUwRKE3cPdb9umoBDnuxrXj?=
 =?us-ascii?Q?NpbxFk0Ho+nx/fVn2iQ1P8zgJbJaQzdTqYPvt+gS8fD3Ch6gTlbnIECiklAo?=
 =?us-ascii?Q?nRGBWPT//BU55DWrGWiBVgR/eC9YQlaB+L6YI35lagq1tq4OKDf4lfguHlR5?=
 =?us-ascii?Q?sldJgk0ZgCRpVE+57mecPxxmGXHTIkMCFOnX+2pw78SwlDwjHq51vWFCaYBH?=
 =?us-ascii?Q?xYr5kkGkni0S2x3LZ8ecbgQ3uyJ+xqbZa+GlIO2KkM7PeEErpgq89KVIip0f?=
 =?us-ascii?Q?CQaQQ+c+7DYjxHZyL6Ipo/etkRryK8BXMGnZWYGz35cWbE2KZ9/15KdAka7W?=
 =?us-ascii?Q?O6VyqkmTVCiPVZ2UcFjbrpK917HZ4u45p3LtfE/3ZZ2cETv9vXsNURkYkf+Q?=
 =?us-ascii?Q?LESAg4RZ1smuVGgpYBRZOvOfqpjl/1cdcQgVk+7fnYzsHdnWzvxdcYIMqPy2?=
 =?us-ascii?Q?rKOztzgOAO+2rivUGJmYP3jIZfd+VtXNBC+SUhLd9oBuBdBxXb5hZ3J26BmB?=
 =?us-ascii?Q?eVBQpmK7bClS/6Vy0XfxtFbzWVKIShlBbDppZpGmr3T2MpJHGHVd8JpvY4Hi?=
 =?us-ascii?Q?SRvtAvzhZSEyQGUl+BwlRGYZkzNb0NFWwyPglxQf31sFpjeWwhBbudqrAemM?=
 =?us-ascii?Q?iwwgmgbGPdHFw+ae3Amksj5WqH2STJh2Kn0UnOV5CsKCy8wqdlUPCk5uMCNU?=
 =?us-ascii?Q?va4WpNALD/BtBbn3p7XAy0KBE4kEu/CqBIyIjlnA8pJmZ89XES9vDMsrnmnT?=
 =?us-ascii?Q?qe69aFjlRtx8phDtLOPVDekqUVP8CC4rCXTQPvtLEI9/qqwwpXgIRpX9hVnx?=
 =?us-ascii?Q?5S5DnXcT7cCwPCj9oFdv/9jpMo54HoOpbNVXMTmEHfx08KDUAmVhCmkr8rkQ?=
 =?us-ascii?Q?81hCYo326n5r54pL4KJXi7Nbd6mHYlqvOVYrFQt2L7SSyGwgvaYAHwaN0Fgn?=
 =?us-ascii?Q?l+RvZl7SAElWGzc+M4TgW9KXyyni5LqWBqKeVcBexUBMucvT+VQjuE4x6/Dc?=
 =?us-ascii?Q?j1TXUxTIKPzmfy9Vm/nsH/HNmNaioORxd4Ibo2qrpdmyniJfFMvT/NOL3TTm?=
 =?us-ascii?Q?SZyktWUJ7fP5MCQfJHS2+X8J45ykDHDSn+oyvVPtRpFAfUf/SkkXB98Tr0Lo?=
 =?us-ascii?Q?bkFzG/IX5it9LbcR4JeLGu4Zgu9WMN1GB7h1ZN+QTZlMiFYcWVb+kDAeyqMV?=
 =?us-ascii?Q?8vFeNRi+VRlMCXmpXdAkeouHsaoJSKE61dEo09msAzaf+Isi1V2+AfqZORa6?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f517150-293a-4d39-821c-08dd0377cdf1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 00:12:04.8897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj2t8XaCWaaZ47a5xlShXuuA0WGJWXfxGnyvdwyjAYcwdC0yrhEN0kP18UTE2sll9EaS2+U4Bo/JwF9h/P/L+FWEJDQ1QEo5ZOo6Kp7Q5Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7803
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Nov 12, 2024 at 01:41:55PM -0800, Dan Williams wrote:
> > Gregory Price wrote:
> > > Capacity is stranded when CFMWS regions are not aligned to block size.
> > > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > > 
> > > Use CFMWS base/size to report memory block size alignment advice.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >  drivers/acpi/numa/srat.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 44f91f2c6c5d..34b6993e7d6c 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/errno.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/memblock.h>
> > > +#include <linux/memory.h>
> > >  #include <linux/numa.h>
> > >  #include <linux/nodemask.h>
> > >  #include <linux/topology.h>
> > > @@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  {
> > >  	struct acpi_cedt_cfmws *cfmws;
> > >  	int *fake_pxm = arg;
> > > -	u64 start, end;
> > > +	u64 start, end, align;
> > >  	int node;
> > >  
> > >  	cfmws = (struct acpi_cedt_cfmws *)header;
> > >  	start = cfmws->base_hpa;
> > >  	end = cfmws->base_hpa + cfmws->window_size;
> > >  
> > > +	/* Align memblock size to CFMW regions if possible */
> > > +	align = 1UL << __ffs(start | end);
> > > +	if (align >= SZ_256M) {
> > > +		if (memory_block_advise_max_size(align) < 0)
> > > +			pr_warn("CFMWS: memblock size advise failed\n");
> > 
> > Oh, this made me go back to look at what happens if CFMWS has multiple
> > alignment suggestions. Should not memory_block_advise_max_size() be
> > considering the max advice?
> > 
> >     if (memory_block_advised_size) {
> >         ...    
> >     } else {
> >             memory_block_advised_size = max(memory_block_advised_size, size);
> >     }
> > 
> > For example, if region0 is an x4 region and region1 is an x1 region then
> > the memory block size should be 1GB, not 256M. I.e. CFMWS alignment
> > follows CXL hardware decoder alignment of "256M * InterleaveWays".
> 
> Max size to minimize capacity loss to due alignment truncation.
> 
> If CFMW-0 is aligned at 1GB and CFMW-1 is aligned at 256MB, if you select 1GB
> then some portion of CFMW-1 will be unmappable.
> 
> so you want min(memory_block_advised_size, size) to ensure the hotplug memblock
> size aligns to the *smallest* CFMW (or any other source) alignment.
> 
> Unless I'm misunderstanding your feedback here.

No, whoops, you didn't misundertand, I just misread
memory_block_advise_max_size(). Makes sense and current code looks good,
you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

> I'm not clear on why the interleave data is relevant here - that just tells us
> how decoders line up with the memory region described in the CFMW.  The window
> still gets chopped up into N memblocks of memory_block_advised_size.

Yes the window still gets chopped, but the alignment is meant to follow
256M * InterleaveWays. The algorithm as you have it will pick that
up. So, no concerns from me from the CXL side.

