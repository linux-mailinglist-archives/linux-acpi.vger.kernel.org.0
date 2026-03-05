Return-Path: <linux-acpi+bounces-21409-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFhQFQBbqWkL6AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21409-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:29:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BBD20FB4A
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 11:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B79C30FCA29
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E621B1BF;
	Thu,  5 Mar 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+bzj84d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B82D8399;
	Thu,  5 Mar 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706329; cv=fail; b=m3qxJjDXXBxPjnXY3YTorSaOFg+6bukvJV1LGYSxnB8Oem7bUmmfI8UJdHuhRo3Y+rt315B00t+JhbkbEpA6kZS2qpRMr6hQ4sTQqofwTf8QuIalx6WZRltAmYjFyYz3c4yMqPdH9qmLSG43hxvUsu2gj/BfGCEWt0MwTAs9OWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706329; c=relaxed/simple;
	bh=VrN7TnW4/1BBGnNQWvTqSfCsduhvsGqP3r7AaenvQQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QUqBfZ6YOTY2ez41HcVlSJoq1UzBXuTzFvqSjKg5970eXw+5nd0VDFWFtFCNXXqAwdBYRB2eiFwGuNoI+59YRDiod468S5lYjP+22ECDf6+vp2p2Rl5OzgB41mH3I69GXcXa2d+4dNbB8Unp5vp1zkDSKz7U1pHxoe0CjGbE1Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+bzj84d; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772706327; x=1804242327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VrN7TnW4/1BBGnNQWvTqSfCsduhvsGqP3r7AaenvQQI=;
  b=Y+bzj84dawRcohPBzm4C2oJ4pg4uZ2M9X7VLd86en19/78K6OmZRMisK
   S0+1xsqUyK73ZSfVxS4TyNIETk1Wynu9DkVwsapAbH/uSZE3fhjoQg5pR
   K212zaweGSdABVGhbqJ3jJ8/VB6GJhsT6B2WXRKjBV0ATIu/bntbin4to
   Ry4IMl7ZXcfaAaZYwHhrcfq5JEUXWgEe8fggK1BWqJcxdkzSz19XjCjZV
   wAoleH+v5EQJqaKIA4krv77GflKf9ysmKZLlcGArHdTsrrmsugskPeTzv
   1E6nRs9CNa1V0vFMdn7KUdZebH/wrqubeyR9AjMYmG0S87xfsJ/8dh0Pr
   A==;
X-CSE-ConnectionGUID: 4ilKvXuaTw6Je/aQhTk64A==
X-CSE-MsgGUID: fhZDTyk2TmmzRqMYQTU2sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73858575"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="73858575"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:25:26 -0800
X-CSE-ConnectionGUID: G2ViaNT0RteOyvf/CzWeoQ==
X-CSE-MsgGUID: hOksVNKSRkSchzcbPQV0KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="222788370"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:25:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:25:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 02:25:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 02:25:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAPY0IOIFCZaup8jP8Coik3jaIGZ9r4vDuQUy8KEus4BD/bYwQ0xdNy4LV13xoauIrx9kxjZp8eGsDYrbAV8Gw+KQUMjL/GJ3OLFJxO+P58/dfgyZklkXmRupG9omuO0OM0HnlKTdsXhC5rQwpj4I+o2XW5CqVR1u2ECJW1ujJ3Nplu0VOwAJ/H1OnpbAyO7Ok/ZiFWr/a4uZv6bCiRFBIegCI+3DNJW3UcVE+2rQxlC1FdCHmFoKjs6h786XBYrnbvcb0DQYzH229iq2dEXTx3qOYx5866Fs1oTutGtgeKrEIdwQlwYbX4Zw6nN9CJJDt4W0d0r/BmRw93Alv8ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrN7TnW4/1BBGnNQWvTqSfCsduhvsGqP3r7AaenvQQI=;
 b=HGqn3nBra4ioyeZkUc7x2P8yR1ScQO18nFmFFLFRFyYb76D1D6kbCQHOqbWrcBeF/E0BqvVi4JOQoq3Y0Lrbtys44jwwv0fIPpKGBbhQLo/cmdM3bFAE4n2TlWRaok4hYPN4tQjYnlFu5nNbnl6cWrJkzXWgdA90Xc2DiXP86PaXC9oYgUb5T64IxvAZ3BclbreIIg+vs+COFm1uh7v0O2QejMPWG1KzFK08FkCygnDVlhsn2VQk/zdfMEqyCAvvCgu3/O5qDgjH6gY9lT//2QKU3uGnPfSLAz31AdfOaI+uvR9PVXrmqxCZpy2cx0U9cQxJ7rNpSBV9hh2oy6ejxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS4PPF2AD6B04BA.namprd11.prod.outlook.com (2603:10b6:f:fc02::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 10:25:22 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:25:22 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>, "Xu, Haifeng"
	<haifeng.xu@shopee.com>, "gourry@gourry.net" <gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thorsten.blum@linux.dev"
	<thorsten.blum@linux.dev>, "wangyuquan1236@phytium.com.cn"
	<wangyuquan1236@phytium.com.cn>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "xueshuai@linux.alibaba.com"
	<xueshuai@linux.alibaba.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAoyAIAABQUAgACFL4CAACVyAA==
Date: Thu, 5 Mar 2026 10:25:22 +0000
Message-ID: <aee45ef3bc5e62814b09db5f605270b3b376fc64.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
	 <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
	 <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
In-Reply-To: <8355402a-e4f0-42b5-854a-ee42f9505612@shopee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS4PPF2AD6B04BA:EE_
x-ms-office365-filtering-correlation-id: 1c325cb5-d634-4f82-38c9-08de7aa18253
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 2+pWLE7Wjs+flpLWA1VRFMiHynvghdeLLaBO/9iNcrnAKzJ9W8olQ6jkfQAGfmOMesQ8AzMeXiqWvYJFqWmqlBXEBj7TckyHa4MunnuCthno72AyjzsJWLCQieEV053bXaNaMjCtNkuun9Y1Wzb9eFwo/sFtgBf/PeKBg4MYN6LAozEPf1S7RWvlw+jkVkhqM+3x6XrdTWdQvM/CXGFwY0TQf97cWwo/Jze8HajWA3LewghDwndvlTvJSg19yCJ6JHhn8AWoS/X9NYsubvnk2ln/eUZEOhWZCbhXfAW3btmI0dvIL57Iw5dopW2Im43nFWTnQFNU57Dj4eTnI2iynfWMnxTP7Pf8Zl3DoWm3jyvF8/6KUJPv1uupUDbP4r8s0tX9s3b8DKvcCxPNR7WG/2r4iM6JiYd6offxjMZoxW23rZXBPn5ISeHNrvdQ89qrK4+TfFWATKx7XiR/vkp+cHb8kl1AoecCHnB/mP6LYwUkjetRXp34S/+5UMi4VYGP4iTGN41+2mEC2MPUJWmFlqENzv51M8pHWQ49s0gWzbRSWRZ0aGn7ucs5QEbWZYp+stRVQ+P3wh4SKWeLBtd+ig2XG9l8TCT+rESUbi8oOmi+gIu0cfkLxVzw2thrkX2M7E86EcLXVAWbuSgagnHHKVQBVm/W9cu8PbuhnR+TsIUYDLbZuLbOsLizB7K7mSqFw0kUSb/vtZ6ZfIoEE/ZlcG+LrjrNaw5X+CL2yz11k0qCOzM9rKRcRUedRdb6neuyK9sruEGxnb0bi0MPgsKjTAHpHTcGNsC8XHWv3awSuIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajFpcDZTL09CeU8zMzF3dE5LTFpPVENoYXR3UFJYS0QweHppZG8vaUV4Ri8w?=
 =?utf-8?B?ZU9uTUQ4Qk5TWkZEamh3RkZQRFNFYmU2TnM1TkNOQVRjcVlBdDc5eXYxck1o?=
 =?utf-8?B?YjNzMWg0ckZMYmtNR3kwSlNkemk1ZW1uN0hkanA5TzgwMG1PTGwxS3dKaDZi?=
 =?utf-8?B?azEvRnBub0F6bXVlQ05nekltUmI3NVB1OEdXRjRuZ2dvVFRPdTB5bEdYNmRz?=
 =?utf-8?B?UGR6WVcrZ2VEdkU4ZkFoRk8zNFl3THJHd1NVNGlIK0hIZjI2Y2xsaWFDdkRq?=
 =?utf-8?B?QlErL2c1MGQrMnk4dE5wZUV6VjJIYm5XMm5rTHhnTktpRVZNOW5SOEhIZ1Yz?=
 =?utf-8?B?Tjh0YXgvWnIzdG16Unkybk9WUXFUZVJXNzYwNWhIb1RJejRtcG16NWRTOGxL?=
 =?utf-8?B?SXE0Zm5SQktaTVFMMm9EVWl5VU5hcENaMnU0RkVjV1pvV1RKR0gwYWx6TzVm?=
 =?utf-8?B?WUlJSTZmdEVQMUpIOWFRRElxdVdoV0tmZ3I3M3ZDTmE5WDFNVTd2dUJHOUVN?=
 =?utf-8?B?K0JpQ1M2dXZ6R2t0WGFEa1FlajZtUEc1b1liSmRtWWNGUDhBYjl3eEU4MU9W?=
 =?utf-8?B?ZEMzVTJSSXlDdDRwdHQ1b3NJUEJwNWpMazhxYjFleHRURXdCSjkrRkJXcWhZ?=
 =?utf-8?B?OUdGOFl1R3FUanczQWpNZjUwakpTb0txVkdHdFAwN1RqUzBuMVczdkRHR3g4?=
 =?utf-8?B?SE9IbTU1MXB0Nk85cTNkUkpXU3lHUUF0aThTSXhrNlF4TXNPdnRaUHFhMjhj?=
 =?utf-8?B?WHoxYXFpUzJtWGl0S0YrMHlSQU5kbm5sQ3hnemV5cTByMGFRR0c4bWpqaUw4?=
 =?utf-8?B?bkFrd3Ezcm9uNzNxeFJvaXFHbzlGWktsOEtjQ3N4clRRYjJWK2oxa1cxdHAw?=
 =?utf-8?B?cmhEZkpvazE4N2hRZHcyM1JHa3kxT1prT0lvZXhrMklQNldxMmY2K28zYkRO?=
 =?utf-8?B?NDhwaE5iMFRoNGg4WG9aeThmeklUeEJnTzNVK2pEQzdDR3htUSswRmJtbHR4?=
 =?utf-8?B?QXArM2FYTys4WFpSSVNyak9xVUJLd0pYaVZtRDFlYTJSQm1wMlhCRzJqQUR2?=
 =?utf-8?B?NUluRmtCUGZYWkVhQkNhQmpoZ1BqR3kwRlViRHdqWWNCWW5vZGpHeFozK1RR?=
 =?utf-8?B?SkV1U0N1UEI5UlJQYlZqblg5R2w4TVdEWWNRQ09JMzdmZVYxV0IrVW90VnBK?=
 =?utf-8?B?a01BZjYxVmNpbndPS0NMNXZWWGJGcGJFZWdpNHo4Zk5Bc0FqT2xPSjVQWmFI?=
 =?utf-8?B?aVFkVUVPMS82Snhsd0VheEhjclhVNmlpUDdXWllxNExvSzErY3hmbnREb1lJ?=
 =?utf-8?B?RktXUjRuaHliMUJOa1hqci9BMGcxcmFYd1NxTEYyMWFSOWFRei9McUVNVnR4?=
 =?utf-8?B?SGZIdEhIdWNQY0Z5dnhoUkpzYVAyYndac2MvUkJQY294R2VMeW5WRmhYb2dM?=
 =?utf-8?B?dEpwSnJuMFVFSkJhenhTNEtZYWdZWUozRHY4Z0hRVXJJTU9xY1A2OVdXU3Ux?=
 =?utf-8?B?bUJHa2JaQ2hCMUx0a0NHK2hXSDh1czkySnpHSzEycGZSbUF5T3Y4RUVteWpB?=
 =?utf-8?B?bHBCSzBTYlp1VllIbnhiQTdCbkRSUmZzZkJVSkFOMWVuNkYzUmhhYjZVdGJ5?=
 =?utf-8?B?YklvOWxLbW1kNWovM2VBY0RtMDhuUUxrNUNKNWpiclN6Wk40YjRPL3BVM3pS?=
 =?utf-8?B?N25HM3NVMHJEZ082MCtxOHdwKzYzbTJCaGVsbCtVci9GYzNkWkxXeUs5bnJU?=
 =?utf-8?B?VEJJNmYrWG5kU3NTdzhudDZSVVhuSGNYOCsvYzlvbTQ3QksyajRCZ3AzYjVH?=
 =?utf-8?B?T2xyNUdOMkpaNXJJNmxSNVk3bDdvdTlIUkVXazRjTVA2MWh3NDc1TlZrUFdU?=
 =?utf-8?B?Q1VzTjQzdU1IdHVGTjJiK3Q4WHlROG5MZ1M0TmxvREx0Z1lzS3dpNzdNQ1Fn?=
 =?utf-8?B?UzkrR3BIMTNyTnVmUnYvVHFlUTRGYjlOUGVNT2REOVVWNm5Qck9qWHBoNXBX?=
 =?utf-8?B?czZwcjJjdWJBcDlES2NQakVXdXZFb0ZaSFRML1R3ajQrTVdFNkRzSms2RlBw?=
 =?utf-8?B?TVEwbUQ4VnRDZWhaK0QvYnZTR2tXOC9DSGV6c01JVnBiUm1LYU1IM0hIUCsr?=
 =?utf-8?B?MjJ0NDJ2dVRTcEFNdUlwampybXpIL2c2SFFTdmg1NkVPbVFkblVCaTIrSzM1?=
 =?utf-8?B?czBScFhDOEUyaGZtN2RabTBnaDZMeGFSejdoWEJycC9UY05BMEhMR1VVcHZp?=
 =?utf-8?B?eEN1RnNCZURzMUxMclRjc2xRa2E5cTVaMlZ2UzJHR0hLMHlwQnhiNXlBbWVH?=
 =?utf-8?B?Z3VvVThYM2hrQjFsNTdLK1d4bEZFTGJ2WFZSTDBDNGZyVmp6QnNHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B5FDF21D710564EB5818E64B1D5B7FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c325cb5-d634-4f82-38c9-08de7aa18253
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 10:25:22.7666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU0viHZT/ceNrRFjhPCPX5n4ITzyfjpwP2uRPp6GF8+hREPKSTButNf2UCZQhO7wOtpXqRVmm9dt1lEq0UbdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2AD6B04BA
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: B4BBD20FB4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21409-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQo+IA0KPiBCeSB0aGUgd2F5LCBJZiBpbnNlcnQgcmVhbCBjeGwgbWVtb3J5IGJ1dCBkaXNhYmxl
IENYTF9BQ1BJLCBob3cgdGhlIGtlcm5lbA0KPiBpbml0aWxhaXplcyB0aGUgY3hsIG1lbW9yeSBh
bmQgYXNzaWducyB0aGUgbnVtYSBub2RlPyBjYW4geW91IHByb3ZpZGUgdGhlDQo+IHJlbGF0ZWQg
a2VybmVsIHNvdWNlIGNvZGU/DQoNClNvcnJ5IEkgYW0gYSBiaXQgY29uZnVzZWQgd2hhdCB5b3Ug
d2FudCB0byBkby4NCg0KSWYgeW91IGhhdmUgYWN0dWFsIENYTCBtZW1vcnkgaW5zdGFsbGVkLCB0
aGF0IG1lYW5zIHlvdSB3YW50IHRvIHVzZSB0aGF0Pw0KDQpCdXQgaWYgeW91IHdhbnQgdG8gdXNl
IENYTCBtZW1vcnksIHlvdSBjYW5ub3QgZGlzYWJsZSBDWExfQUNQSSBJSVVDLg0KDQpJZiB5b3Ug
ZG9uJ3Qgd2FudCB0byB1c2UgQ1hMIG1lbW9yeSBpbiB5b3VyIGRlcGxveW1lbnQgdGhlbiB5b3Ug
Y2FuIGVpdGhlcg0KZGlzYWJsZSBDWEwgbWVtb3J5IGluIHlvdXIgQklPUyBvciwgd2l0aCB0aGlz
IHBhdGNoLCBkaXNhYmxlIENYTF9BQ1BJIGluDQp5b3VyIGtlcm5lbC4NCg0K

