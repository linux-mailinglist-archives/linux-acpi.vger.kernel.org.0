Return-Path: <linux-acpi+bounces-4395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F611881491
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A39F1F2360E
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Mar 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFA524AA;
	Wed, 20 Mar 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrLABlI0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE592524B7
	for <linux-acpi@vger.kernel.org>; Wed, 20 Mar 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948451; cv=fail; b=B/aTp/xvUr5tTKmwjYInLCd48+BkkT9VRRRsPxROvpSZSv6lvEg13cd+yYReMEL8oWl38vZo3qHmp/+FDXpCPYltMYrDZTncocOwXLUX21+zlUS+6w1uPJ4UT/MbChpx6s/ap7LNr6cWfMT9qUQMoPdeLEys4rn0xnMEso9nIrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948451; c=relaxed/simple;
	bh=k88w2q+YDcSSBx2Cm3YlSbZnzn0PA68Rm684+7CcxxM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfE9DQbra0yRXJZeUSxflaDcqHhYwq0D6PdG72PlEKDZOSSerOag4KBeusbBhBrFIbWLg9wFGvRkfjsa10wvB+QMSVvbM00t0p5lK47AIAmAdWkIz14QypMUPp8V8cEex/Nxgn5YhiZ2UK/UkTwWzIJ/y0tmPlVUGhEHlax0HHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrLABlI0; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710948449; x=1742484449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=k88w2q+YDcSSBx2Cm3YlSbZnzn0PA68Rm684+7CcxxM=;
  b=QrLABlI0j2rycy7+/Hrv/leHaiOKwcIM3MUr3EmiVsknk0f5e6ODLo4f
   DgM+YueIIym7HdR25bRd2+jJg2GOVOeBNKcH4FwBvlPMZg9IVqeFZXKXV
   8H+ixV7Z48ASuliTHSZpApCle4W+jeoSFXWFS41Kbz91pFZqdwPrX+GE9
   TmiC4C3PS1WKRjBQiLxCud27p3n3lmj4NLJduoWVRFFj7HFzVpTR2Kgol
   /DbJreDkNQLgVDboJ3JVRJhUgTl/01RxfbmqWqqVslk1oWjZUrhh0ktqb
   5yLefyMetr+ozIKrVmVKl1PoGUAtV3gIUCCZymlckftcLXWt8CSUut92i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16420225"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="16420225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="51628585"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 08:27:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:27:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:27:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:27:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0DaTa6qGqoEfvr90g1dntxuMEd9ZeowMOANedoLrZpltbsQKFvJ0fbNrb3PeOQNEFMK7TZisygQKTsNyfaFEcKu9CQfajl3KjpNuVWrogjdFE3jH5uWRwAWeuM3KTs64F9vTPDR1v40thdL37PvzodimgGbwsqqhanbK3DuvscdAjBP/f2CexDnMCQnGyDB333BdEuMt+HmZBI0j5tpGat9gB2DX8JLBdGjzr78jMC1ewGE/se++6Fax/1ImGQKmgAIEMlUfY1Xig391SHMEjwdKGGX0wQhlBE53wTOvTByKvkXetnG2zOelH33zDwjUvyAxVzO524wle4C3DOflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k88w2q+YDcSSBx2Cm3YlSbZnzn0PA68Rm684+7CcxxM=;
 b=fpEGk45iFsYriq8DgLu5G/UxXKD8n/y6qFA43Jr0CnoWSMbAM5iZKFaK2fmibVL9fxz2aqiF5zwXqTmtPOL+Ex/w2FpG/YmVL8emnnyn9iTpvVYDnp4ub5MtDxAZOYzJcisAVsS2e2aliqit4rFDf53jva3ElCOVpzk1F7CiXP4RSin/ZaLTge7hc9YE2FHut9ek5yG4afXS58THdrwHLBbr87P6g9M8hMOs2M+A9MiReKCDvBTFcQJsCRU25TPg9lm8HMSr2qGZIVGspMMcqY++wvEnGoyHHy9neGzJLuCbgHP9J5JKjr2YJkaAba87aTwq8dZ/7OsOZmJHnunZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB7376.namprd11.prod.outlook.com (2603:10b6:8:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 15:27:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 15:27:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Li RongQing <lirongqing@baidu.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "bp@alien8.de" <bp@alien8.de>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] acpi/ghes: load balance timers
Thread-Topic: [PATCH] acpi/ghes: load balance timers
Thread-Index: AQHaeod8ehRIuExPO0aQzc4QwPGNfLFAv2nw
Date: Wed, 20 Mar 2024 15:27:25 +0000
Message-ID: <SJ1PR11MB6083BD24995E3F281C05AEC2FC332@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240320052724.41099-1-lirongqing@baidu.com>
In-Reply-To: <20240320052724.41099-1-lirongqing@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB7376:EE_
x-ms-office365-filtering-correlation-id: ef04cafc-54ec-410b-423b-08dc48f23f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8SWeULzSw4JAq6fcpn5Pwz3Lxt/vCQ6+k/XmVh0gNbjT9wE4VZTpideRAH1Wv2I++4Yb6oW+vwZaSPLpvft6v6C8c3r2FcQ7aGXMmEGk2ZEUofOJ/quyyL2ycmiTomdagEP4NZAoyM+9jfF3PFA4xw+97HbbxSgApyUSkScjt601uAfLTiIWEU/KEhqsRsZD0yqGnh6k/8UaczQ73Yxcxnh4nrKuuPXzjllgL41Lxk1dEd+41D1Eo8azfPsflWUEMN2hyktR+Slj2VO7Cp/g/hfJhyghZ8XjoaSyIWX3ftWLVU8H2q7SyLAqc/R50EkjQ2BNt5B0xyW9r2IlozvwM1g0nag3fKuki6IDLGLpq4TTjDMWrBXM2J5jlTNyfnexzTUm81FVYiC24M+OsYW2j3/DxCMqObd3gZfqWAVn1ubq9PejDAyaxtXJGweU6IYhhnEZJD1VGeQUfoJpC26P0YMkWDnHfRkH3aiIk++Atak7ZV5FnZDQ+5SfTjH8BxGL64miSpiZ4lVFN5rHNnvKDANQbj9GHaQCo/OwIRTEjHuVg7CICUJOxA1VlQg8ashHBm/mqQJAyn380dTzHHW4iwwcMYDLAue/Yh2cf0mct4hBmr1oDuxM4WrvrQ8lL3sKKrCqRf3Rz0Mxo5q8pgl/llcRy3YmLWNJ3cSNzCdOcy+cKGvmVs7GZnpu/Cugd/hTvmgN3vdVRA6OM2TMnd5wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rfZNpOe/OT3LKoPzVYt+zgVzHkb3VmqeIhSwJue/9KaK93iuhHwpPobZSnG8?=
 =?us-ascii?Q?jXX6n7VrmYe6Y+FrNEdQD4CMNvsesYFFf//k3tSxv3MVZCDNuBLf6Hw9JlLX?=
 =?us-ascii?Q?aLYtyPQ1EE1bEeujSAwCTZ+pfK3PLSwXjL8RUapNuZes9lC0EZDdk5DFioYi?=
 =?us-ascii?Q?B/QEmXOpi2R1jqzLtyQrpGp7v6YRMVHNCppQmiIXHAeE2T4m59E/pWae9dgE?=
 =?us-ascii?Q?dMeAdkwXMg2U7W9CwJMvj6ApDANqqpjP02YYBe+0keirpR9Zdj63TSDv+B3n?=
 =?us-ascii?Q?AixSdiWDVo1wA4mUj4tQwF9OaVk2SsBVVpixR1gfp77nDpfTv8prYXLNItyQ?=
 =?us-ascii?Q?uEJcpG/5tfsD/p/jbHAxzLjeBUCZe02KDyQuqhpqyJPTP9iKzSQSeOeAUNj4?=
 =?us-ascii?Q?yyLzeqRBoE5qFgrTJue5JsfymN7t3B87zUIFwoVn5F8LpTgLgpbrIVVjUOal?=
 =?us-ascii?Q?Gx3AWj58V2FTxZ0+m4b6rQ1SRLekzBKA5SvigSdbm/GCcMe3zMe01yAsL5De?=
 =?us-ascii?Q?p/FsHAj+3JWQhOAxqbtqnNz5RiSuDDM7JlezceOsG4G/fILoKo55dw/1KvCi?=
 =?us-ascii?Q?B/kgPoFHSE2HwzfGbyMHx8m/F3rB+gIOKi1n2M1LHgnrOL6JVcey/il/xwrf?=
 =?us-ascii?Q?kcx42QblPIaTIEzmOrryDy3NP8qXvVpHJ3dOmfV5aYU+2QyxnPuYKUNQnYXL?=
 =?us-ascii?Q?OzKdW5UVqaUWCYzjrMVfJJmuqEpWd1vfsxwRmLca/FhZIPefiAm77wvtk1Ii?=
 =?us-ascii?Q?TqAZkZDaRIgiBCZnjlPVVD1xgPdsHOpMC0OokQ0oql8I/S/IvfOPmkEu3gT+?=
 =?us-ascii?Q?TxzQodcascNs46vhdtFnJLegEN8NRZnBKDnEQ1QDyRkzy6eLRx+HwqljqBcH?=
 =?us-ascii?Q?qVoJOVK6hnvor6QI/q8V+4QdRC3e7G2x/9xviSDUWOo7HdJXlKXXnjuZo4cm?=
 =?us-ascii?Q?cGhbshRYbrzBxl1vLazH4vJQaio9BwU+xkb7IomDz0ppVXSfBIcUK1EkrjGK?=
 =?us-ascii?Q?0Q030bwU84MFL7/Cg+KyGPvZfeX3BOWpQJ5OPgC8F9mrNKgMiav7A+e/qnuB?=
 =?us-ascii?Q?w0BKLv1S+aGGsSmFbk6Y1k2evSgoe+fM1bLqKZL8YfoQl/TWEdis4Vk3stIm?=
 =?us-ascii?Q?mSH8Sv8Iz5uWkSYICo1vWIxAPAt2XpJcmVzyoIJgTkbxUP+AJRKJuQWQmu3n?=
 =?us-ascii?Q?CR2ZvkNu/xQjAgJzKhRoXDO4bKDTia/fKpfFo4/MDG7X28PiLqGtTmtJlY9x?=
 =?us-ascii?Q?IO6reSFYxAVRBlDl+Q+8zk9HAcB/1tknF+meIAvXnn7FY/zCMDXudbX77WkA?=
 =?us-ascii?Q?juNa+u5OPZneK7N9BJtgyTahLdTyym8YEjIpEheLyTCRKGghD1sAuzYclvKt?=
 =?us-ascii?Q?z/DAPHUJnMwIbmfMIheVbI6YHU5R2bvtYi5I7ovFLGky/aHP7W9yZmOjiyju?=
 =?us-ascii?Q?eelIfmNKJjjtUCBVEGtV4SWizIeihhH+pwmKDdgqnqTgNstb+zXVvoryk3N3?=
 =?us-ascii?Q?ElYKcWMEX6gxM+QqiFZKi88lU5R07394SIeiuNYfSADrwzFkVbGuC25hLHtZ?=
 =?us-ascii?Q?C8FX7F7dFLwzanX9ES4axyq/IcoSTnKe2weQDxiQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef04cafc-54ec-410b-423b-08dc48f23f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 15:27:25.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHgearQNIrnmgqZLFkoCXUfebeabT3S+pJPHQjZGcimfudYfd3zkyIeMowNzpCyRfKcBCFsAYWUvrCZY/Jdq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7376
X-OriginatorOrg: intel.com

> Kernel needs to set up a timer for each poll type notification, On
> some system, these are tens of thousands of timers, which expires
> periodically and preempt one CPU which calls ghes_probe at boot stage
>
> so load balance evenly timers to all online cpus, reduce task jitter

Tens of thousands of timers still sounds bad. Spreading the pain across
all CPUs just moves the pain around.

Question: do these all have the same, or similar poll interval?

Could these be both spread out and batched? E.g. have a kernel thread
on each CPU that runs periodically. Assign bunches of these ghes
poll items to each CPU to be handled by the kernel thread?

-Tony



