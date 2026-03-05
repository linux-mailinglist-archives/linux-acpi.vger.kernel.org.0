Return-Path: <linux-acpi+bounces-21383-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHdBKLrhqGnzyAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21383-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:51:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AE20A01B
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 301A1301570A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC61DE8BF;
	Thu,  5 Mar 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6mTmSo7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8833688A;
	Thu,  5 Mar 2026 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675491; cv=fail; b=sPAym2AQOq+hGGK1OlObrZwuh5fAD5007IlETgNwjcLhmyvcyzHRDlyKleztKNoQzGOvQOuD6/0MugnsVwCaIMaMlkK+b1dQj//BaPIItDHusUYes1ng8H9p09IiHNbwyswJ1JH/mqaDdnNr1I+d5pTI4ex6/munNQAobOFbjRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675491; c=relaxed/simple;
	bh=d880yhVxeG5kkg0aWPcoyFB4j+wAR8xqvjaPxByNnrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsZK6M58wVcExGvu36OvfANnOLSoGJZ01oKhC8hqUPKuq9B1h6uNcXxEUoSyaUK7IfPK+wmtHZWCsFScXEoy73NECROV6GaiaA3WwI1zBN0VynchgiV7uiyZOv2UowIaZ8FiKIuJzc7xylOTgXEGUdC/vrteLTA0gsVYTI1PZ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6mTmSo7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772675490; x=1804211490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d880yhVxeG5kkg0aWPcoyFB4j+wAR8xqvjaPxByNnrk=;
  b=F6mTmSo75brAj8SZ6xhWKjO5+istpYDoFPyT30wE5ITL/ozIrxsQsOdv
   FXduGy32E9bdidriAdkWVeG1B8p+8sTDuQfX2gvMzh5jpg8X2wQf5SYlR
   YPeBb2SjRmz4frDi4ji1sU34AZCNhd35oWL4PizQ66cY3H7stQpbP0fuN
   NiCM2KNVSQngfQw4M2S7Icgl0y8d6dORsHhEc7A/thJRu+bHmwmSJ8bPF
   TTpe8XgylPzoO9GtxGmpEksmnr4oc+an70YmuHaDcBkqxe7nqMMgT3kOC
   z5+Uy2wn0d9LKBf5jvpHobJGrm3Nh47EKNG88YD4kbeuIaq1TDuHm18RB
   Q==;
X-CSE-ConnectionGUID: sNKjH47OTfWXQpWYklyogQ==
X-CSE-MsgGUID: t+eL9TxaRc276XVN/pxYzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73658069"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="73658069"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:51:29 -0800
X-CSE-ConnectionGUID: +cMvSQMsQuyAcV+tJw0LdA==
X-CSE-MsgGUID: Nb0CARYgQwiH7k7zulfNTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="217768659"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:51:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:51:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 17:51:28 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 17:51:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMl3DuB10j2VxVfc43l4i00ScXO9Y6FLxXItvcvkCnW4Z5noUyH3iLxPWi55AU+iNF78D8WU2wvFg1scaJrn54/Rc0lDxshzTRHE2aW2YXzBW6HPfGZ6t+02q7hlm8ed+pw9tX6De4RtMzYhpQLFPsclnpNNzfVczbaY2rbENZD7lJyVVnzgr0a54ONEMdMC1Tf1xV+YnlaqtnqPHzyK2Q3Z/5zO1RA4g+3toNEegSJqYBE4Ko2AC1t1VKWKNgPMfIJ8/899RZWm/yYhZMI77sacz4DqlszS7+cTGNQ4m3BT/WtfGvdXFLisvl+iMWL8fXurjsXajYUcHTMjKzPZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d880yhVxeG5kkg0aWPcoyFB4j+wAR8xqvjaPxByNnrk=;
 b=jkOgQ8fpnH9Tq8Sd5eXVjwsxXL4Os6bfQKLniS258XmgmsVN33LPF7ddhYmCHmwqGQblYd55xvhNFB2FZFNknswFwpZAVmAR78yuvQheR/UkjSADkaE8DenqQLKWujUaI+BQg84hJeVLO1ckP6iBHTldeJwiJgxflJkArnycFcxK3YzjLt+jKjQkDy+CiCReKjIrleJMh+v6QZsff4CVo/tDoYF7+yxq6amWhlUTu7kvZoewNc8qeuBB7AUofn8zlNrRfZ4Po6MbEOklY1zqJzbZL/x3S9CeYIoVkjzfPTgJFhqtV3+VMl6aYc1gkVyggPF1x98zuFYyIjwHi97Q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Thu, 5 Mar 2026 01:51:20 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 01:51:20 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "gourry@gourry.net"
	<gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "Schofield, Alison"
	<alison.schofield@intel.com>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAoyAIAABQUAgAAEMQCAAARwgIAADEwAgAAGCIA=
Date: Thu, 5 Mar 2026 01:51:20 +0000
Message-ID: <bf78a2ee58e99e1fab9df3b5406f20edf9420415.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
	 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
	 <aajOckpcmQwYydVQ@gourry-fedora-PF4VCD3F>
	 <178a85c1d5a48938bf866a85d34ee2ba87901d10.camel@intel.com>
	 <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
In-Reply-To: <69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7768:EE_
x-ms-office365-filtering-correlation-id: 19b20eae-6afb-4011-6dca-08de7a59b2de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: E0MNlQ265zCYLDue9KcjuRMvROV3YjEa15k/Wey404zr3N9Y3wnqjELbuidSZh5sgLCMfvizkU8kaQ8VtQbcsUmv0cJMzCm0yT788g1JUJZdosWFU++eZCRnmPM4rNXq6EDVmPs7U0YPIFk54IXi9dcyA+6vbTIcvieIOw6PWwsT2ctQDdcJaM/AXh5r//8epecUImlkD8M3kX7um9NMLp1PZKtlHPSvyhKvpCJdM67235s2Wvtt4YtEdq6GOw2P9gomrMsfx48sCk67r1Ek3EOMcFyFsqAPaTt/bEjmW7UA2ufkFvCk2/rObtj0R5c7NiYa2F2fGW2S6TeH3wEPxurl8d8PvGDFMk9i7/rbfkr8wm5HamdwHO5lozf6/MzYUStvvLMUKUp0Dqwe5vSp61M3I4BW6lSbw4Rz87gAz5hhK3I8l0HjiNY0HQ+CipOjopAy/fu12+hstNMufbKAsdPucyMg0BfbzVl17P9ZE7gmi1L9GfZaWTA2DbwDkmC33WwQb0aPQ9xOcnSxLJvgsssvHdq3XKlzoMLDsRkYdUg96Topp2qdJ35vQ7LjZ9kSHRIdKp1hVsYQWcZPJEOc6pBra5GIvhNWcWeLyD9DioBis6ntsuv/jmtIcmnsSfFFEE0c6WnEz/rFRXHg8OM1tJ1F4AuKVDQHfMHmuRrjK7rqXdUSP0iUs7P9P665sX116LU54jbYuEvRsOx533QeO383KacbzyHCGRQ6+itHH0CBGrxvZFy0KTERuTjpcv858yQeiSoFHkRwIiw/UxzX6SjNApNeqiJBsz8hl5K6PYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDBFalFCZ1Y1M3ZxSm1oR0R5OTJuNE4yZHJSdk1Za1NjeTdrSWVrSnRNVDNK?=
 =?utf-8?B?M1ovT1J4QlB2QkNaUGhXbVZ5TU0zVjZmRWhTUGYyOXFIci9LSlZpV1pCSW5L?=
 =?utf-8?B?WitwaDk0b0ZUUGNjekVxU2puTEF1WlMvUkFSUlJyZWN0SjB6QUtpWnRLSVlG?=
 =?utf-8?B?UnJKZkVyVGFsSld2ZHJKbTcvNytMVVBjS09QZlZxdHhqQU5RRUQxUlJsbHFD?=
 =?utf-8?B?S05HT0lHbTVaOFp5ZDZodjdIZUZNTXY4S29oU2h0ZU1lcWxRUDk5TXhsYmxm?=
 =?utf-8?B?SlBMV2RNc2NrcDdXMzhrZXNjcFFaM2tvZVdXdkcxZjkwa1NYTXpFejRYWkJI?=
 =?utf-8?B?bGNYSk9UNFd4Yit1dnZab3NMMXNNU1BvMG10VG81TGNrNXNoTFB4aWlhdlBL?=
 =?utf-8?B?NzJ4SHFQRFFpcnIzaDljNDRQU0RpZEc5VldYMnZrcmp2VUl2MVhVNndmUXI3?=
 =?utf-8?B?ZWF2dWVZYlVOMzJQQVFhRWVuSHVSZHBaQ2ovT1JoN3RDRGFZQi9HVXhzQXFo?=
 =?utf-8?B?UGdPWmp1dk54Qi9hc1R2eVVaVWw2b1FHMi81ZDl4TUQzK0FmTWljZ1ZRM3JN?=
 =?utf-8?B?N3R6azhYZjkwczMrSnVIYWVQYnJZQnhNTldxUTZZbEplRXlKMWF2eHY3UXcr?=
 =?utf-8?B?bkc1U01YRVNiRVo1TXFGL0Roem16dWlDNXFsdzhPeERFTURlbVY3dlY5dWZV?=
 =?utf-8?B?S3g3ME1acG05L0pTQUVLdjcrSUE4c053dlpGT1BNbkpQVUhvMmxuVVRTR3Zh?=
 =?utf-8?B?K2tZMmtFeUM4TkJuZlkzdzFYYVFMUjZtUHhxZ3JJVHUrejBXUnBuc2didjdC?=
 =?utf-8?B?WjBsbk95UFlSMzFpNEFXWmVXT0tGZEh0RFFvcHRLNCtJK2dtUWpPVk5lMU1R?=
 =?utf-8?B?OHlYcmVUOUFrUmI2M1NOSGgzQ2tsLzVFQ3ZCWHhqbXJuVVloYU9XcWsrL25r?=
 =?utf-8?B?VStLZEVEUENSMFJwWWppY1h3WisxZ2Y3a29qVmpMU2xwRFh2bXJLbFdiRDJR?=
 =?utf-8?B?Z3hNcWIxWDdzdEI5bHY4clFwWWxlN0JNNE1wbWhNWFgyd2psbFBtcEdSKzM3?=
 =?utf-8?B?bkhzS2xtbVJZTkNCNERKSzcyRzE1NjdSVWtvUExYa3FBTzFYL2pGY1l2eWpY?=
 =?utf-8?B?b2RCVkFYVFp5VURoYVJjNVRFWVBmandxUU9oaG1Hbk94bUFDSGVlZWhwT0l6?=
 =?utf-8?B?MEtoWjFBaVVsKzJpL2R4Z2hLVm9kRXlBL1RmcjFDcHNaZlhQVGZmamNqRUlq?=
 =?utf-8?B?bVBybHlxRjE5eTU5dGRueWViMlpDTUlKanEyWWV1cFhXYkErZnZQT3FIV3JH?=
 =?utf-8?B?b0NlRjczQVV6S1pRTThRUGcrd1ppakovdlFyNzJyZm9qa3gxVmE4aXh2c1dO?=
 =?utf-8?B?TzFnTnY4SFExNTFOaG16LzQ4TmM2MWJQVGs1UnlKOFhkTjBGMmViUFBNY25L?=
 =?utf-8?B?R0o5MFlnY2xVL2phRlNMZTY0NU1uejVsZTNld3NQSVIyU1RMWno2SU52dG9S?=
 =?utf-8?B?OWkwRkZXRWVjeDlsYjV5SlFzamtxem9vdDI0WTE0K0ZsRjJYQngxdXV3V2oz?=
 =?utf-8?B?VE4rRjA5ODBjdDV6WTFuZ3FkUkVNOHdwZFQzZ1VtcDkvWGhadmx0TE83ZW1v?=
 =?utf-8?B?MGJ4MkRDNkVqMGJYUm5aTERvTHh4dEJwOVFROCtORXVBdFpYckdjS01JNkZH?=
 =?utf-8?B?cnU3TUtWTXlLdkxmVmVEV1NxcDNlRUxUUmhhTW5TbDJuQ0c3d2x2bjJIWGRm?=
 =?utf-8?B?NUJUdFNlUjVrRTlCN09sam9JVkRuZmFHWWZiRWcwcUU5bEhCQ2FhTzV5U01C?=
 =?utf-8?B?Z0szS21hanJUUlBKT0c4MGVIbEpYa05JQ3pNdk1mVUc0RmNWcENMOWE1WEN6?=
 =?utf-8?B?Yjh6LzFaZ2Y2VnpJL1hncUh3WnVpODFDTnU2MVFzaGpjRGxyRWhDSFdrbHQz?=
 =?utf-8?B?a3cxeWR2SmVEWGRsYk0rOGtDZnFyZ1dqV1RZbzF0dzhjcysxR1BNbkR2Lytj?=
 =?utf-8?B?cHFUU2hJMG11NGRCM2ZvNVBDNzBab2FKZ2d2R3EwSlgxU0N3QVJoOHBzOHRw?=
 =?utf-8?B?WnRtTno5V2tKZHd3ZGVmTkVWQ09IeUNINXNHWEVad1o5a01rYldoL1JGZUZJ?=
 =?utf-8?B?NFlBV3FjemxtcmpEWE8vNXdVa0JxYUFLSE8wdHphR05tL1lkOGZ3Mk5aM280?=
 =?utf-8?B?UmtzT2R3RzlEWVdaY1JrOTl5bGRWeFVxV1N0NXNIQlNyMjN3VnZXWUxYMWpw?=
 =?utf-8?B?SC8zREdKSkt1emptRkJqVEJId0RSdXFoMS9GOFYrZVg2eDExRjZ6RlFzODZ5?=
 =?utf-8?B?SHAzdnR2aUNvUVpoOGtnOWRweGJvN3ppei9zQ2FHTFZ4VmdTakMxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7878BAFD1691D43A2ED6677695DF6B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b20eae-6afb-4011-6dca-08de7a59b2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 01:51:20.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL5GqYSexzL1KllX1+3ngAMgP8++7Nqjnm4t78mY3hPjXzUhpEwt+uHJdECemP/aX6vA5WJOJ9VDPNCnJTBC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 075AE20A01B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21383-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE3OjI5IC0wODAwLCBkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20gd3JvdGU6DQo+IEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI2LTAzLTA0IGF0
IDE5OjI5IC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXIgMDUs
IDIwMjYgYXQgMTI6MTQ6NTJBTSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+ID4gT24g
V2VkLCAyMDI2LTAzLTA0IGF0IDE4OjU2IC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgYmFzaWNhbGx5IHNheXMgaWYgc3BlY2lmaWNhbGx5IENY
TF9BQ1BJIGlzIGJ1aWx0IG91dCwgdGhlIE5VTUENCj4gPiA+ID4gPiBzdHJ1Y3R1cmUgaXMgZm9y
ZXZlciBsb3N0IC0gZXZlbiB0aG91Z2ggaXQncyBhY2N1cmF0ZWx5IGRlc2NyaWJlZCBieQ0KPiA+
ID4gPiA+IEJJT1MuIMKgDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgbm9ybWFs
IE5VTUEgaW5mbyBkZXNjcmliZWQgaW4gU1JBVCBpcyBzdGlsbCB0aGVyZS4gIEl0IG9ubHkgYXZv
aWRzDQo+ID4gPiA+IGRldGVjdGluZyBDRk1XUywgd2hpY2ggZG9lc24ndCBwcm92aWRlIGFueSBO
VU1BIGluZm8gYWN0dWFsbHkgLS0gdGhhdCdzIHdoeQ0KPiA+ID4gPiBrZXJuZWwgYXNzaWducyBh
ICdmYWtlZCcgTlVNQSBub2RlIGZvciBlYWNoIG9mIHRoZW0uDQo+ID4gPiA+IA0KPiA+ID4gPiBT
byB3ZSBhcmUgbm90IGxvc2luZyBhbnl0aGluZyBBRkFJQ1QuDQo+ID4gPiANCj4gPiA+IFdlbGws
IEknbSBtb3N0bHkgY29uZnVzZWQgd2h5IHRoZXJlIGFyZSBDRURUIGVudHJpZXMgZm9yIGhhcmR3
YXJlIHRoYXQNCj4gPiA+IHByZXN1bWFibHkgaXNuJ3QgZXZlbiB0aGVyZSAtIHVubGVzcyB0aGlz
IHBsYXRmb3JtIGlzIHJlc2VydmluZyBzcGFjZQ0KPiA+ID4gZm9yIGZ1dHVyZSBob3RwbHVnLiDC
oA0KPiA+ID4gDQo+ID4gDQo+ID4gSSB0aGluayB0aGlzIHNob3VsZCBiZSB0aGUgY2FzZS4NCj4g
PiANCj4gPiA+IEp1c3Qgd2FudCB0byBtYWtlIHN1cmUgd2UncmUgbm90IGFkanVzdGluZyBmb3IN
Cj4gPiA+IHN0cmFuZ2UgZmlybXdhcmUgYmVoYXZpb3IuDQo+ID4gDQo+ID4gSG93IHRvIGNoZWNr
IHdoZXRoZXIgaXQgaXMgInN0cmFuZ2UiPw0KPiA+IA0KPiANCj4gU28gdGhlc2UgYXJlIGZpbmUu
IFRoZXNlIGFyZSBDWEwgaG90cGx1ZyB3aW5kb3dzIGFuZCB0aGUgZXhwZWN0YXRpb24gaXMNCj4g
dGhhdCB0aGV5ICptaWdodCogYmUgcG9wdWxhdGVkIGluIHRoZSBmdXR1cmUuIFNSQVQgY2FuIG5v
dCBtYWtlIGNsYWltcw0KPiBhYm91dCBmdXR1cmUgQ1hMIGhvdHBsdWcgKHNlZSBOT1RFKS4gU28g
dGhlIGV4cGVjYXRpb24gZm9yIENYTCBob3RwbHVnDQo+IGlzIHJlc2VydmUgc29tZSBudW1hIG5v
ZGVzIHRoYXQgTGludXggY2FuIGRldGVybWluZSB0aGUgYWZmaW5pdHkgb2YNCj4gZHluYW1pY2Fs
bHkgd2l0aCBITUFUIEdlbmVyaWMgUG9ydCBhbmQgZGV2aWNlIENEQVQgaW5mb3JtYXRpb24uDQo+
IA0KPiBOT1RFOiBTUkFUICpkb2VzKiBtYWtlIGNsYWltcyBhYm91dCB0aGUgYWZmaW5pdHkgb2Yg
ZnV0dXJlICpBQ1BJKg0KPiBIb3RwbHVnLCBidXQgaW4gdGhhdCBjYXNlIHRoZSBwbGF0Zm9ybSBz
dGF0aWNhbGx5IGtub3dzIHNvbWV0aGluZyBhYm91dA0KPiB0aGUgY29uZmlndXJhdGlvbiBvZiBt
ZW1vcnkgdGhhdCBjYW4gcG9zc2libHkgYmUgcGx1Z2dlZCBpbiB0aGUgZnV0dXJlLg0KDQpUaGFu
a3MgZm9yIHRoZSBpbmZvIQ0KDQo+IA0KPiA+ID4gWW91IGFyZSB0YWtpbmcgc29tZXRoaW5nIGF3
YXkgYnkgbmF0dXJlIG9mIGNvbXBpbGluZyBzb21ldGhpbmcgb3V0IGJ5DQo+ID4gPiBkZWZhdWx0
IHRoYXQgd2FzIHByZXZpb3VzbHkgbm90IGNvbXBpbGVkIG91dCBieSBkZWZhdWx0Lg0KPiA+IA0K
PiA+IFllYWgsIGFuZCBpdCBpcyBkdWUgdG8gInRoZXJlJ3MgYSBjb3N0IiBpZiB3ZSBkb24ndCBj
b21waWxlIG91dCBieSBkZWZhdWx0Lg0KPiA+IA0KPiA+IEhvcGUgdGhhdCBqdXN0aWZpZXM/DQo+
IA0KPiBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRoYXQgaWYgeW91IGRpc2FibGUgQ1hMIGhvdHBs
dWcgYnkgc2V0dGluZw0KPiBDT05GSUdfQ1hMX0FDUEk9biB0aGVuIG5vIG5lZWQgdG8gcmVzZXJ2
ZSBudW1hIGlkcy4gSG93ZXZlciwganVzdCBkbw0KPiBzb21ldGhpbmcgbGlrZSB0aGlzIHJhdGhl
ciB0aGFuIGFkZCBpZmRlZnMgdG8gdGhlIGNvZGU6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hY3BpL251bWEvc3JhdC5jIGIvZHJpdmVycy9hY3BpL251bWEvc3JhdC5jDQo+IGluZGV4IGFh
ODdlZTE1ODNhNC4uNjJkNGE4ZGYwYjhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvbnVt
YS9zcmF0LmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL251bWEvc3JhdC5jDQo+IEBAIC02NTQsOCAr
NjU0LDExIEBAIGludCBfX2luaXQgYWNwaV9udW1hX2luaXQodm9pZCkNCj4gIAl9DQo+ICAJbGFz
dF9yZWFsX3B4bSA9IGZha2VfcHhtOw0KPiAgCWZha2VfcHhtKys7DQo+IC0JYWNwaV90YWJsZV9w
YXJzZV9jZWR0KEFDUElfQ0VEVF9UWVBFX0NGTVdTLCBhY3BpX3BhcnNlX2NmbXdzLA0KPiAtCQkJ
ICAgICAgJmZha2VfcHhtKTsNCj4gKw0KPiArCS8qIE5vIG5lZWQgdG8gZXhwYW5kIG51bWEgbm9k
ZXMgaWYgQ1hMIGlzIGRpc2FibGVkICovDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0NYTF9B
Q1BJKSkNCj4gKwkJYWNwaV90YWJsZV9wYXJzZV9jZWR0KEFDUElfQ0VEVF9UWVBFX0NGTVdTLCBh
Y3BpX3BhcnNlX2NmbXdzLA0KPiArCQkJCSAgICAgICZmYWtlX3B4bSk7DQo+ICANCj4gIAlpZiAo
Y250IDwgMCkNCj4gIAkJcmV0dXJuIGNudDsNCj4gDQo+IFRoZSBjYWxsIHRvIGFjcGlfdGFibGVf
cGFyc2VfY2VkdCgpIHdpbGwgZ2V0IHNraXBwZWQgYW5kIHRoZSBjb2RlIGZvcg0KPiBhY3BpX3Bh
cnNlX2NmbXdzKCkgd2lsbCBnZXQgYXV0b21hdGljYWxseSBjb21waWxlZCBvdXQgb2YgdGhlIGZp
bGUuDQoNClllYWggYWdyZWVkIHRoaXMgaXMgc2ltcGxlci4gIFRoYW5rcyBmb3IgdGhlIHN1Z2dl
c3Rpb24uDQoNCkkgd291bGQgbGlrZSB0byBob25vciBHcmVnb3J5J3Mgc3VnZ2VzdGlvbiBhYm91
dCB0aGUgY29tbWVudCBzaW5jZSBpdA0KcHJvdmlkZXMgbW9yZSBpbmZvIGlmIHlvdSBhZ3JlZT8N
Cg0KKEkgYWxzbyBhZGRlZCAiaW1wYWN0cyBjZXJ0YWluIE5VTUEgdXNlcnNwYWNlIEFCSXMiKQ0K
DQovKg0KICogU29tZSBwbGF0Zm9ybXMgcmVwb3J0IENFRFQgQ0ZNV1MgZm9yIGhvdHBsdWcgZGV2
aWNlIHN1cHBvcnQuIFRoZXNlDQogKiB3aW5kb3dzIGFyZSB1bnVzYWJsZSB3aXRob3V0IENYTCBk
cml2ZXJzLCBzbyBkb24ndCByZXNlcnZlIGZha2Ugbm9kZXMNCiAqIGlmIHRoZXkncmUgY29tcGls
ZWQgb3V0IC0gaXQgd2FzdGVzIG1lbW9yeSBvbiBwZXItbm9kZSBzdHJ1Y3R1cmVzIGFuZA0KICog
aW1wYWN0cyBjZXJ0YWluIE5VTUEgdXNlcnNwYWNlIEFCSXMuDQogKi8NCg0KPiANCj4gQXQgdGhl
IHNhbWUgdGltZSBJIGRvdWJ0IHRoaXMgcGF0Y2ggcHJvdmlkZXMgZW5kIHVzZXJzIG11Y2ggdmFs
dWUgaW4NCj4gcHJhY3RpY2UgYXMgbW9zdCBkaXN0cm8ga2VybmVscyBoYXZlIENPTkZJR19DWExf
QUNQSSwgYW5kIHRoZSBmZXcgZW5kDQo+IHVzZXJzIHRoYXQgaGF2ZSBDWEwgYXJlIG5vdCBnb2lu
ZyBibGluayBhdCB0aGUgb3ZlcmhlYWQgdG8gc3VwcG9ydCB0aGUNCj4gZnVsbCBmZWF0dXJlIHNl
dC4NCj4gDQo+IENhbiB5b3Ugbm90IGp1c3QgZGlzYWJsZSBDWEwgc3VwcG9ydCBpbiB0aGUgQklP
UyBmb3IgeW91ciBzeXN0ZW0gYW5kDQo+IGF2b2lkIGNvbXBsaWNhdGluZyB0aGlzIGNvZGUgcGF0
aCBmb3IgYSBzbWFsbCB3aW4/DQoNClN1cmUgSSBjYW4gKEkgbmVlZCB0byBmaWd1cmUgb3V0IGhv
dywgdGhvdWdoKS4gIEJ1dCBJIHRoaW5rIGl0J3Mgc3RpbGwNCnVzZWZ1bCBmb3IgZGV2ZWxvcGVy
cyBiZWNhdXNlIHNvbWUgb2YgdGhlbSB3aWxsIHRlbmQgdG8gb25seSBlbmFibGUgS2NvbmZpZw0K
b3B0aW9ucyB0aGF0IHRoZXkgbmVlZCB0byBzYXZlIGJ1aWxkIHRpbWUuDQoNCkFuZCBzb21ldGlt
ZXMgaXQncyBub3QgcXVpdGUgZWFzeSB0byB0dXJuIG9mZiBDWEwgaW4gdGhlIEJJT1Mgc2luY2Ug
dGhlDQptYWNoaW5lIHdvdWxkIGJlIG1vc3RseSByZW1vdGUuDQoNClNvIEkgdGhpbmsgdGhpcyBw
YXRjaCBpcyBzdGlsbCB3b3J0aHkgdG8gZG8/DQoNCg0K

