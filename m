Return-Path: <linux-acpi+bounces-13823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E067ABD23C
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5402D1B610AA
	for <lists+linux-acpi@lfdr.de>; Tue, 20 May 2025 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4BB2641EA;
	Tue, 20 May 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaxVt5Ko"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDC263F2D
	for <linux-acpi@vger.kernel.org>; Tue, 20 May 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730695; cv=fail; b=lAOmq0zeWnR5JnBz9siIUV/xWB3cPJ//EdxTQIEJ61A1+NwYOV2rkjM0S+ghPU9o73y3Ki19gD8vnx3hVFHjfUawPzk1Rlj4CfmMiTTe2ShMzrab7Je4TO5Cqey/1NKY8FK9FjIpFfkGBXLngQmJwxaZkzUcH2YS8594dkMsatU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730695; c=relaxed/simple;
	bh=rPw4Tcnw9Q8Kx/i6pJdXABHIwwfNWKGisJMlFM3R124=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ25orO+v5WPIVJdXfDEAJQyAOmiwYmMBHgnSxiLviuczFoWeaQ2J9PtxIjBJSb6mnKSVxn5lhNfbZPpMm0zSTCWWdDK5p4wrBU1CvHdablAn7CPkbEfqvO5kO+5Pc8r8VP8Hl5ih+2d2b+GiGkMk3H/tNIbEs+PJsv8vGJSzas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DaxVt5Ko; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747730693; x=1779266693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=rPw4Tcnw9Q8Kx/i6pJdXABHIwwfNWKGisJMlFM3R124=;
  b=DaxVt5KoFdXQarajOGiMMWlInF2H4kRPIOgxBjNOFwxYWG8VP3m/KdwI
   j8LZahavuS0A06B2rPpWvvqea9jaIA9HqUbaDWxeYNpoQjaz86Sggo5Bj
   IBoPW4RW/Q/I8b1Dn8CvYvzR9/1GcGGraKvI9l1dFzFYYS3wfS3rEK+Sf
   hH0Xsol10c5/vDGvJ9k2POzBMn5VzGLnd8GNNNgcsNuVASeMb69djh+V+
   95lRBmrBDhyvnvKWdpgywvhBCr8emv6iXtD0mwxiTW2GOzyx9tzf11l5q
   /9nF8LvAYsMt4MZNeuHoKMOGOl/96HxN00X5lLEyVFIDfJyVycPfbiw40
   g==;
X-CSE-ConnectionGUID: ZBvCF898Sqalc44c6mg8Ow==
X-CSE-MsgGUID: e+BRa+5rQTmXeFWgruRRZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60995848"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60995848"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:44:53 -0700
X-CSE-ConnectionGUID: x8jY0kP1SpC8BeMs3NwsJA==
X-CSE-MsgGUID: l1AZ/9jLTjqOxj9CT1FiCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139529669"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:44:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 01:44:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 01:44:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 01:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAaW0O6EDBgEJ6glLeQls5eY1hLoBOWRftxn3mzTuZ0+r1KgotRTyPVB/R6EjfHm9Zyx0IttWFJHbY4XpBUiyh/azHRVn2C68VcwNx/4wgmLqogIt8+3zSs3DLVnkzUNJ0NAXme98ym7cGoE/OwnuuXpIPo8nvx6XEWC5F1aNAiLyIhwYZgUibyid0xBZIDK6dkfJ6rz51k5fPhnWJN10M9JKW9zHFs/q2J96RKxpX6mbctq0rgQzEjRX1Nmw6gurpalHMVWzeRWVXiPTY6dOSIwqFfDcRCbfpUuLamt38AllJTMqn/LWOtxHPDGwvqHpSiJX62y9NuNf5ZMFnEcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVWxasKj9T9ILVzE6UPVmtyIezF5Pdpa3VaL2+bMDpA=;
 b=IEBolj4jVj+fEW1zuRteAr25p7jwpd+owdy/K4HZDkvmM/l7eFkwKaZGZPIWFM8rfxJ4wyRfIkTTBy8E8MUeK8Jpvj4C1Rmla9DOrrFUJKeAbvPBOt3DMa4kUAqKItUNU4q8KIYJTqQIT2KmkFXI4FGTcUKMxl+mwui72ddtYikM0TUOITZ9YMN/iMn98Tn/kiNInO4R0K5lOCDI4o72cH47lishyl+4J6Zrhc+Dtzv9tsu9pGY41650QKA07M/cEaQDRbi2FhgK1A2J15QTA70Pv09W+C4bGQKfId6EwZL3fizIALlef8k+u4A6FYECnOkaXyStI4ljRRLNaft/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 08:44:04 +0000
Received: from IA1PR11MB7755.namprd11.prod.outlook.com
 ([fe80::8a57:c694:2dfa:e041]) by IA1PR11MB7755.namprd11.prod.outlook.com
 ([fe80::8a57:c694:2dfa:e041%4]) with mapi id 15.20.8722.027; Tue, 20 May 2025
 08:44:04 +0000
From: "Camacho Romero, Michal" <michal.camacho.romero@intel.com>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert"
	<robert.moore@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Mowka,
 Mateusz" <mateusz.mowka@intel.com>, "Fedko, Artem" <artem.fedko@intel.com>,
	"Pawlicki, AdamX" <adamx.pawlicki@intel.com>, "Michalak, BartlomiejX"
	<bartlomiejx.michalak@intel.com>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: RE: [PATCH 1/3]: ACPICA: actbl1.h: Add support for the new ACPI
 Table: DTPR
Thread-Topic: [PATCH 1/3]: ACPICA: actbl1.h: Add support for the new ACPI
 Table: DTPR
Thread-Index: AdvGPIYqz9qwl9J9R/+ZxFrnOqSl+wAZkv2AALAbPfA=
Date: Tue, 20 May 2025 08:44:04 +0000
Message-ID: <IA1PR11MB7755AC8F910ECADEDE2E44A1AF9FA@IA1PR11MB7755.namprd11.prod.outlook.com>
References: <IA1PR11MB77556710DD26474B9B857408AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
 <79044d87-3bc1-4b39-a711-8313dfce4a5e@intel.com>
In-Reply-To: <79044d87-3bc1-4b39-a711-8313dfce4a5e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: rafael.j.wysocki@intel.com,robert.moore@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7755:EE_|MW5PR11MB5858:EE_
x-ms-office365-filtering-correlation-id: 5a03e5cc-ca7f-4a77-b9ed-08dd977a79e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UmZCbTN0ZFlGUnl3aENjT1pnRzRpelBlQklha3VFQUNJWUcvQVZrZi9CZGNX?=
 =?utf-8?B?SEtPczFSK1hVcER0TUZWRllsOExWcGN0dFJJYUFVYkt0SFQrZHNtanpubnRR?=
 =?utf-8?B?TXM2dXRmTjE2TWI5eCs1N01Xb00yZ3pTMlFLQzJlVVV1WnJXeVhXajE4K2dH?=
 =?utf-8?B?eFU5YngwU0VaVnk0SUVycGk4b0Ztay9mdHBpQXlTQ1dmV2l4dEFoNndsWmdN?=
 =?utf-8?B?UDF5V3krL0NIbkR5djZTNHdEZlZ2VlFraFc5KzdDSlJyaEhFbUVvQ21rb1ln?=
 =?utf-8?B?SW1FNHc5TVFJYmFuRS84ejBQalVUYW5LS2x5bytDL3kyUSsvQ09MV05Xb2Er?=
 =?utf-8?B?MEcvdU0waGExVmo2enptY0FhY0k5Y1FQMUd2aDhwMmo4bjd6ZTVHMEV5WStK?=
 =?utf-8?B?RDVWVEY4QmpuRU0xVUpiWFBxeE9MUDVaMUlWelhqR2FBUVdCQjgzSnpKVlZt?=
 =?utf-8?B?SzhXOGZzWUtpK081eTB1a2JxdjREZmZ1YmZsaGNHVUYwR3JGSW9oeUlGeFhl?=
 =?utf-8?B?K3VSQjlMcU5xOGl1QkxMeUk4c0hobEF2WTNRdkNmOGIwVmMvbFNUY1dka2Rv?=
 =?utf-8?B?K2gxclY1aTdnTFBJUFBKd293MVpySW1BbmhFYnVRQjJQL29XdlhEckNROWg0?=
 =?utf-8?B?SCtvd1BMNHJVdFdudzRMeG9wOUxXRGlQbHFEdU56SFBZbUZVc2JtZFR3SUFQ?=
 =?utf-8?B?Mm4ybE9CTkNOQU90bytSWklBT1pCenpldnNJMm5BeTRNdXlrOFR5SHJmUHMw?=
 =?utf-8?B?WUdVYVRhQWxsWmFpS01IcEsrL2s5TFNTd09UU05aWmVoTE9Oa2J6QjBieVVi?=
 =?utf-8?B?NmlqZ2N5Uzl6VXRiUC9xc1U1QmUyUy9JUkVtWTkyVDh2S1ZzSk1uZGhYT3FW?=
 =?utf-8?B?TjBkYzBVN2QwcDh6YmowL0E0b0ZWREZmZCtlQ20xOFY3YzN1Sk10M2ZwZ3F6?=
 =?utf-8?B?UkZoeExDMm5MQVdLSUdNUTUzNWp1NE9rWXQrY2pJVUJ3dkJLK0VyVmJrbHhQ?=
 =?utf-8?B?cW0vWlJwa1JpaDh4dnV1czlQZzFxTXFyQVd4MGJheGllaGU0L1FiT1Ftb0RU?=
 =?utf-8?B?cldVWlNoNmJOWjZkejV3Vy9EL1dCdUZSS0hKNHpmaC9wdXk1OVd3NkZOY3h3?=
 =?utf-8?B?d2p1TWx4R0tQbStWYnhFU0Vsd2dXR2t4T3JHZ1JpNmttS1B5RG1vbzVUWmNW?=
 =?utf-8?B?dUUyYno5TGhtUWpUeVpXa0k0MmkrcG1PbUNxZ3p6alNZREdjTmd6OEF4RFMv?=
 =?utf-8?B?VTJYTDdBZEtwc3A4SnhWR0I3N0xYdDV2SmF5b21JVjZCZG51RCtpY0trMFFN?=
 =?utf-8?B?YTlCUGRJVnJuZ3YyejYvbkg5K2U4LzBlcUhUNms4VVMvNm9ZS2ZxQXp6NlpE?=
 =?utf-8?B?VlhER1VHb1pUQVJ5S3dRcW9HeERKdTlBQkxPOGlrZUI5VnJXWEVseEZDMGZi?=
 =?utf-8?B?anhaeXNvSGErK3Z3aEtYRzRBdjUwNS8zTkJLbFZDdnBaS2VBQjgrdWFZWGN3?=
 =?utf-8?B?R0FBckZ4bDIzQVdvTncrNjl1ZVhwQ2dVK3J5OHFFSkRXOFRQUXVtOFlaSW9s?=
 =?utf-8?B?Y0FVY3FGSEpmRk5HWmFpVWpFOFR5dXZlZDdDQnJYbXRqcjJQNVBsTUNQMm84?=
 =?utf-8?B?V0toSFVtT3lZZ0Vzc1YxZUQ5RExzR1NqR3FhWEY2Z3ZKN3dwZDRkLzRjeWJu?=
 =?utf-8?B?S1gvKzB3MU1Ua3loU20rd3BrRGxoTkF6cUFzRm9hVkU3clRXeElRclFObjBk?=
 =?utf-8?B?ZGhaVnJXS3VqenZnUndNN1FZaTBPOHJoSE4xWlplN1dudG9uaHFQZTJ2TnZO?=
 =?utf-8?B?cFFlWkdlVzlCNENrNE5Od05RNTVGU3N6TUNsVGNBTTlKMkdhUzRtaTRlU2ZN?=
 =?utf-8?B?WDJwMmpEYmhMZ3VySU5TcDZDUEtCbk9WREJxTWpubnlqckpDOVBtNWJNQzZw?=
 =?utf-8?Q?eqYPQTNcdlx9k2R1ja+FMKoeEFbsadew?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7755.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zmk0OWxGU00yUkk2b1RnY0ZOa0xJNUZxaStERUFjQi9mcFY2emZmSDFGb0lI?=
 =?utf-8?B?VlJRWjd0ZXBMbHlZK1l1RzVwUnZ4MTZsNnpQR1ZkdElrU3l5Sks5YlBTclVR?=
 =?utf-8?B?Q3cvQlJkL3l4dW55ZE1UeUNqdE9IV0hmekk3dEMraldodjZoVWNQdnlMNlJw?=
 =?utf-8?B?UGpMRzFTbWNkdlgwMU4wcjMrcE5CMDJRaWFsZnRxWjJwL0U0S3JGeko2bEpL?=
 =?utf-8?B?Ky85czN3ZkVhTGxLYzUyMklHbHU5S2pXdTlCRnZWMHJLNGhMUWtaOVl4d3o1?=
 =?utf-8?B?RHhlT25VRkJDYWZRTDEzU2MydzFwWkF2WEtnaFB1ZXNCM21Ld25OMjlmOEVH?=
 =?utf-8?B?ZmhmMWpTOENHL1V2RHZaMllSWnhTVWtMSDVDOGpKc29YbCtrZ25TWWQ3bVZv?=
 =?utf-8?B?YVczSGptcWE4cHl0VGVMRVIxcGlsWVlYY2s3WldtcWUyRWJuM3FFOGgxcVF4?=
 =?utf-8?B?N3dtV0RCRmIyRzZmVlg1T21tb0NjZVdaUEphVnUyS2hQdGlEYll1d1FZSWcy?=
 =?utf-8?B?elFjM1cvT1JhM1Z6RmpjOUJDNTdEbHI3ZzV5cGZVMnlyRkxOQ1pHT2NabFls?=
 =?utf-8?B?bVBYMENvWWdMejRaL1E3eDZWQzM5VUViZy9IZ09Xbm11VzFWQlNmaFhzL1lk?=
 =?utf-8?B?MnF0NHk3cUlnNjlERzJtUnNTWjBVMEthV0VxcnRpVjhnd1IzZmtiLzJVZnRs?=
 =?utf-8?B?anRkdERsbmxjUWNaZlgvTUZ6VUZYcWRybmhwZVFsWmVmTWNSc2RGdXVjRmVJ?=
 =?utf-8?B?YUROMnQyOW9MTUg1MzZBU0ZkbGhOc01RT2pWQTl0S0FkNExnQUNBRExiWkh3?=
 =?utf-8?B?RElVUVduMVZHNTlzSFlMNDFjbVlvR2c5a3VJbWQybFVYcDArVnhzMkFJbTJN?=
 =?utf-8?B?eHBPSVJJN0djN1A5d2c3UmczU2Fna3ZMMWovVlcyOCtXbjBGVURNQkMybThF?=
 =?utf-8?B?OVU0elVYRy9IYUJPZFU1MWRYSGFpblJ4Q21OMWlORHlxb01XNWtlai9ZbVlj?=
 =?utf-8?B?RUc3NXFybU00SVhoN0JWayt6RVlHNjRBeHc3UTFKWVcxeXpwZUtmZStNTmpF?=
 =?utf-8?B?dWRaYVA0ZVdQZHhpV09lTDUxWTVWVkpxV0ZCZWUvUFZDeEhHWENsMzJWZjZs?=
 =?utf-8?B?eThBREZHVUFlWVVQZkZmSi8zUG4yRzl3U085blZkOFRCcWZnbWwyS1g4S3FD?=
 =?utf-8?B?L1VRVjNzWmtCT3dUUEtBRkxRam5YYnUzcDM5K0JlbjQ5SjhOelorUDFtOWpy?=
 =?utf-8?B?WHU0STlhRzNKcUJBZk9MQUNjOXR5Y2NzSXc5bmFZdzdvQW1YY1k3SkJsU00x?=
 =?utf-8?B?YkZHUjhEUVIyeUlwOTFIRGlueFJWc2txdjM2bWVaVDhiTkNLZzhFYzZFL3Zo?=
 =?utf-8?B?MzNsM0ZRMk1zT2J6cjdKc0dhTDBzTHBoRnA5dEg2U1pnUGlGYmFOdVhWa2cw?=
 =?utf-8?B?bk1FZUZLTHpaRWFzQTRpbjF6SllYcVdKVHBmWlAvMEtpcElSWXluYUpJaitK?=
 =?utf-8?B?aEErdHhRUnVENjcwYUVEdzA3RHNPNWNwWG9JSXN4M3grWmpKZjJWMVlsUUhj?=
 =?utf-8?B?c2daR1lMcTV2cnd6TEJFR1JRSGt4aTB1ZmVtV05GZFQ1TDlDLzg0NEw0QS9U?=
 =?utf-8?B?bVo4Y29pTVdkUVIxbXdabFdZRVNiOE5uWmZoUHlNWGlrRXJwS2JXczhtWXVq?=
 =?utf-8?B?VnhPdlI5QkdTYlhkOXM3NXdTR1hDR2w2Nm9WbUNoa0RJY291c25yaFAvYm5s?=
 =?utf-8?B?Y0wyM3hXQjJpNitlUFFFSFFuaWw2ak9BS2hUd05pakdGRDBRMVhMWUxZcVRh?=
 =?utf-8?B?UzVHTXJ3ZTFsMjdkNFVaOFBoUXVUVytsVU44N3FLL1VIMDFGN2JoWGxWVk5T?=
 =?utf-8?B?Z0Fxc01oUWJ1TjZjRFVKNURRSis2ZGFkOVhWWjRkZklhcWFnSDJUb2NESUdK?=
 =?utf-8?B?SmJpSi9HM3pCQ0FBRTljUmdMLytTNFJETENmUUdEUWZXenB6cE9tbkpJQUpV?=
 =?utf-8?B?cklia29YYytLcEQxRmxoc1o3TTIrK1YwWjV4akUwdk1yK2ZjQThiOUg4Y2dv?=
 =?utf-8?B?VGF6dC9jbXZIUU4vdGRyTzVnVWpZQnI4K0U3N3RoVXpvd2o0S2YwNG5TVmdn?=
 =?utf-8?B?b2RzSWpHaU5sSk5IZnU5WTQ0YUxSZzVzSUFFbU5wVitQRWYzNVcxOE41VFNU?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7755.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a03e5cc-ca7f-4a77-b9ed-08dd977a79e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 08:44:04.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVUm3pca/rYjdeYnzulbfSZp+ZCnMlQEBMHVA1/gcxixcYRiCQwlukTwNCgrpjJ9+1+2dp09CcO9htkWvj2cKuirSE/aUu72K1WCZYLiWfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

SGVsbG8gQFd5c29ja2ksIFJhZmFlbCBKLCBATW9vcmUsIFJvYmVydCwNCg0KSSd2ZSBjcmVhdGVk
IGEgbmV3IFBSIG9uIHRoZSBBQ1BJQ0EgcmVwb3NpdG9yeSBmcm9tIHRoZSBnaXZlbiBLZXJuZWwg
cGF0Y2g6IGh0dHBzOi8vZ2l0aHViLmNvbS9hY3BpY2EvYWNwaWNhL3B1bGwvMTAyNg0KDQpDb3Vs
ZCB5b3UgcGxlYXNlIHJldmlldyB0aGlzIFBSPw0KDQpSZWdhcmRzLA0KQ2FtYWNobyBSb21lcm8s
IE1pY2hhbA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV3lzb2NraSwgUmFm
YWVsIEogPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPiANClNlbnQ6IEZyaWRheSwgTWF5IDE2
LCAyMDI1IDEwOjQxIFBNDQpUbzogQ2FtYWNobyBSb21lcm8sIE1pY2hhbCA8bWljaGFsLmNhbWFj
aG8ucm9tZXJvQGludGVsLmNvbT4NCkNjOiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgTW93
a2EsIE1hdGV1c3ogPG1hdGV1c3oubW93a2FAaW50ZWwuY29tPjsgRmVka28sIEFydGVtIDxhcnRl
bS5mZWRrb0BpbnRlbC5jb20+OyBQYXdsaWNraSwgQWRhbVggPGFkYW14LnBhd2xpY2tpQGludGVs
LmNvbT47IE1pY2hhbGFrLCBCYXJ0bG9taWVqWCA8YmFydGxvbWllangubWljaGFsYWtAaW50ZWwu
Y29tPjsgYWNwaWNhLWRldmVsQGxpc3RzLmxpbnV4LmRldjsgTW9vcmUsIFJvYmVydCA8cm9iZXJ0
Lm1vb3JlQGludGVsLmNvbT47IER1bWJyZSwgU2FrZXQgPHNha2V0LmR1bWJyZUBpbnRlbC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvM106IEFDUElDQTogYWN0YmwxLmg6IEFkZCBzdXBwb3J0
IGZvciB0aGUgbmV3IEFDUEkgVGFibGU6IERUUFINCg0KT24gNS8xNi8yMDI1IDEwOjI4IEFNLCBD
YW1hY2hvIFJvbWVybywgTWljaGFsIHdyb3RlOg0KPg0KPiBIZWxsbyBATW9vcmUsIFJvYmVydCA8
bWFpbHRvOnJvYmVydC5tb29yZUBpbnRlbC5jb20+LCBAV3lzb2NraSwgUmFmYWVsIA0KPiBKIDxt
YWlsdG86cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+DQo+IEFjY29yZGluZyB0byB0aGUg
bGF0ZXN0IHZlcnNpb24gb2YgdGhlIEludGVsIFRYVCBETUEgUHJvdGVjdGlvbiBSYW5nZXMgDQo+
IHNwZWNpZmljYXRpb24NCj4NCj4gKFJldmlzaW9uIDAuNzMpLCB0aGVyZSB3ZXJlIGRlZmluZWQg
YSBuZXcgdGhlIEFDUEkgVGFibGUsIHN0cnVjdHVyZSANCj4gYW5kIHJlZ2lzdGVycywgd2hpY2gg
d2lsbCBiZSB1c2VkIHRvIGhhbmRsZSBUUFJzOg0KPg0KPiAqIMKgIMKgRFRQUiBBQ1BJIFRhYmxl
DQo+DQo+ICogwqAgwqBUUFIgQmFzZSBSZWdpc3Rlcg0KPg0KPiAqIMKgIMKgVFBSIFNlcmlhbGl6
ZSBSZXF1ZXN0IFJlZ2lzdGVyDQo+DQo+ICogwqAgwqBUUFIgTGltaXQgUmVnaXN0ZXINCj4NCj4g
KiDCoCDCoFRQUiBJbnN0YW5jZSBTdHJ1Y3R1cmUNCj4NCj4gKiDCoCDCoERNQVIgVFhUIFByb3Rl
Y3RlZCBSZXBvcnRpbmcgU3RydWN0dXJlDQo+DQo+IExpbms6IA0KPiBodHRwczovL3VlZmkub3Jn
L3NpdGVzL2RlZmF1bHQvZmlsZXMvcmVzb3VyY2VzLzYzMzkzM19JbnRlbF9UWFRfRE1BX1ByDQo+
IG90ZWN0aW9uX1Jhbmdlc19yZXZfMHA3My5wZGYNCj4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFs
IENhbWFjaG8gUm9tZXJvIG1pY2hhbC5jYW1hY2hvLnJvbWVyb0BpbnRlbC5jb20NCj4NCkNhbiB5
b3UgcGxlYXNlIHN1Ym1pdCB0aGlzIGFzIGEgcHVsbCByZXF1ZXN0IHRvIHRoZSB1cHN0cmVhbSBB
Q1BJQ0EgcHJvamVjdCBvbiBHaXRIdWI/DQoNCg0KPiAtLS0NCj4NCj4gaW5jbHVkZS9hY3BpL2Fj
dGJsMS5oIHwgODYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pg0KPiAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hY3BpL2FjdGJsMS5oIGIvaW5jbHVkZS9hY3BpL2FjdGJsMS5oDQo+DQo+IGluZGV4
IDM4N2ZjODIxNzAzYS4uMTQ4MDJmZWI1NGZkIDEwMDY0NA0KPg0KPiAtLS0gYS9pbmNsdWRlL2Fj
cGkvYWN0YmwxLmgNCj4NCj4gKysrIGIvaW5jbHVkZS9hY3BpL2FjdGJsMS5oDQo+DQo+IEBAIC00
Nyw2ICs0Nyw3IEBADQo+DQo+ICNkZWZpbmUgQUNQSV9TSUdfSFBFVCAiSFBFVCLCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBIaWdoIFByZWNpc2lvbiBFdmVudCBUaW1lciANCj4gdGFibGUgKi8NCj4N
Cj4gI2RlZmluZSBBQ1BJX1NJR19JQkZUwqDCoMKgwqDCoMKgwqDCoMKgwqAgIklCRlQiwqAgLyog
aVNDU0kgQm9vdCBGaXJtd2FyZSBUYWJsZSAqLw0KPg0KPiAjZGVmaW5lIEFDUElfU0lHX01TQ1Qg
Ik1TQ1QiwqDCoMKgwqDCoMKgwqDCoCAvKiBNYXhpbXVtIFN5c3RlbSBDaGFyYWN0ZXJpc3RpY3Mg
DQo+IFRhYmxlICovDQo+DQo+ICsjZGVmaW5lIEFDUElfU0lHX0RUUFLCoMKgwqDCoMKgwqDCoMKg
wqDCoCAiRFRQUiLCoCAvKiBUWFQgRE1BIFByb3RlY3Rpb24gUmFuZ2VzIA0KPiByZXBvcnRpbmcg
dGFibGUgKi8NCj4NCj4gwqAjZGVmaW5lIEFDUElfU0lHX1MzUFTCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiUzNQVCIgLyogUzMgUGVyZm9ybWFuY2UgKHN1YilUYWJsZSAqLw0KPg0KPiAjZGVmaW5lIEFD
UElfU0lHX1BDQ1PCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUENDIiAvKiBQQ0MgU2hhcmVkIE1lbW9y
eSBSZWdpb24gKi8NCj4NCj4gQEAgLTE5NTMsNiArMTk1NCw5MSBAQCBzdHJ1Y3QgYWNwaV9pYmZ0
X3RhcmdldCB7DQo+DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiByZXZlcnNlX2NoYXBfc2Vj
cmV0X29mZnNldDsNCj4NCj4gfTsNCj4NCj4gKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+DQo+
ICsgKg0KPg0KPiArICogRFRQUiAtIERNQSBUUFIgUmVwb3J0aW5nDQo+DQo+ICsgKsKgwqDCoMKg
wqDCoMKgIFZlcnNpb24gMQ0KPg0KPiArICoNCj4NCj4gKyAqIENvbmZvcm1zIHRvICJJbnRlbMKu
IFRydXN0ZWQgRXhlY3V0aW9uIFRlY2hub2xvZ3kgKEludGVswq4gVFhUKSBETUEgDQo+IFByb3Rl
Y3Rpb24NCj4NCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmFuZ2VzIiwNCj4NCj4g
KyAqIFJldmlzaW9uIDAuNzMsIEF1Z3VzdCAyMDIxDQo+DQo+ICsgKg0KPg0KPiArIA0KPiAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKiovDQo+DQo+ICsNCj4NCj4gK3N0cnVjdCBhY3BpX3RhYmxlX2R0cHIg
ew0KPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciBoZWFk
ZXI7DQo+DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIGZsYWdzOyAvLyAzNg0KPg0KPiArfTsN
Cj4NCj4gKw0KPg0KPiArc3RydWN0IGFjcGlfdHByX2FycmF5IHsNCj4NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCB1NjQgYmFzZTsNCj4NCj4gK307DQo+DQo+ICsNCj4NCj4gK3N0cnVjdCBhY3BpX2R0
cHJfaW5zdGFuY2Ugew0KPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiBmbGFnczsNCj4NCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoCB1MzIgdHByX2NudDsNCj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgYWNwaV90cHJfYXJyYXkgdHByX2FycmF5W107DQo+DQo+ICt9Ow0KPg0KPiArDQo+
DQo+ICsvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPg0KPiArICogVFBSbl9CQVNFDQo+DQo+ICsg
Kg0KPg0KPiArICogU3BlY2lmaWVzIHRoZSBzdGFydCBhZGRyZXNzIG9mIFRQUm4gcmVnaW9uLiBU
UFIgcmVnaW9uIGFkZHJlc3MgYW5kIA0KPiBzaXplIG11c3QNCj4NCj4gKyAqIGJlIHdpdGggMU1C
IHJlc29sdXRpb24uIFRoZXNlIGJpdHMgYXJlIGNvbXBhcmVkIHdpdGggdGhlIHJlc3VsdCBvZiB0
aGUNCj4NCj4gKyAqIFRQUm5fTElNSVRbNjM6MjBdICogYXBwbGllZCB0byB0aGUgaW5jb21pbmcg
YWRkcmVzcywgdG8gZGV0ZXJtaW5lIA0KPiBpZiBhbg0KPg0KPiArICogYWNjZXNzIGZhbGwgd2l0
aGluIHRoZSBUUFJuIGRlZmluZWQgcmVnaW9uLg0KPg0KPiArKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8NCj4NCj4gK3N0cnVjdCBhY3BpX2R0cHJuX2Jhc2VfcmVnIHsNCj4NCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCB1NjQgcmVzZXJ2ZWQwIDogMzsNCj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCB1NjQg
cncgOiAxOyAvLyBhY2Nlc3M6IDEgPT0gUk8sIDAgPT0gUlcgKGZvciBUUFIgbXVzdCBiZSBSVykN
Cj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCB1NjQgZW5hYmxlIDogMTsgLy8gMCA9PSByYW5nZSBl
bmFibGVkLCAxID09IHJhbmdlIGRpc2FibGVkDQo+DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgdTY0
IHJlc2VydmVkMSA6IDE1Ow0KPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCB0cHJfYmFzZV9y
dyA6IDQ0OyAvLyBNaW5pbWFsIFRQUm5fQmFzZSByZXNvbHV0aW9uIGlzIDFNQi4NCj4NCj4gKyDC
oCAvLyBBcHBsaWVkIHRvIHRoZSBpbmNvbWluZyBhZGRyZXNzLCB0byBkZXRlcm1pbmUgaWYgYW4N
Cj4NCj4gKyDCoCAvLyBhY2Nlc3MgZmFsbCB3aXRoaW4gdGhlIFRQUm4gZGVmaW5lZCByZWdpb24u
DQo+DQo+ICsgwqAgLy8gV2lkdGggaXMgZGV0ZXJtaW5lZCBieSBhIGJ1cyB3aWR0aCB3aGljaCBj
YW4gYmUNCj4NCj4gKyDCoCAvLyBvYnRhaW5lZHZpYSBDUFVJRCBmdW5jdGlvbiAweDgwMDAwMDA4
Lg0KPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIC8vdTY0IHVudXNlZCA6IDE7DQo+DQo+ICt9Ow0K
Pg0KPiArDQo+DQo+ICsvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPg0KPiArICogVFBSbl9MSU1J
VA0KPg0KPiArICoNCj4NCj4gKyAqIFRoaXMgcmVnaXN0ZXIgZGVmaW5lcyBhbiBpc29sYXRlZCBy
ZWdpb24gb2YgbWVtb3J5IHRoYXQgY2FuIGJlIGVuYWJsZWQNCj4NCj4gKyAqIHRvIHByb2hpYml0
IGNlcnRhaW4gc3lzdGVtIGFnZW50cyBmcm9tIGFjY2Vzc2luZyBtZW1vcnkuIFdoZW4gYW4gYWdl
bnQNCj4NCj4gKyAqIHNlbmRzIGEgcmVxdWVzdCB1cHN0cmVhbSwgd2hldGhlciBzbm9vcGVkIG9y
IG5vdCwgYSBUUFIgcHJldmVudHMgdGhhdA0KPg0KPiArICogdHJhbnNhY3Rpb24gZnJvbSBjaGFu
Z2luZyB0aGUgc3RhdGUgb2YgbWVtb3J5Lg0KPg0KPiArKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8N
Cj4NCj4gKw0KPg0KPiArc3RydWN0IGFjcGlfZHRwcm5fbGltaXRfcmVnIHsNCj4NCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoCB1NjQgcmVzZXJ2ZWQwIDogMzsNCj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oCB1NjQgcncgOiAxOyAvLyBhY2Nlc3M6IDEgPT0gUk8sIDAgPT0gUlcgKGZvciBUUFIgbXVzdCBi
ZSBSVykNCj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCB1NjQgZW5hYmxlIDogMTsgLy8gMCA9PSBy
YW5nZSBlbmFibGVkLCAxID09IHJhbmdlIGRpc2FibGVkDQo+DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgdTY0IHJlc2VydmVkMSA6IDE1Ow0KPg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCB0cHJf
bGltaXRfcncgOiA0NDsgLy8gTWluaW1hbCBUUFJuX0xpbWl0IHJlc29sdXRpb24gaXMgMU1CLg0K
Pg0KPiArIMKgwqAgLy8gVGhlc2UgYml0cyBkZWZpbmUgVFBSIGxpbWl0IGFkZHJlc3MuDQo+DQo+
ICsgwqDCoCAvLyBXaWR0aCBpcyBkZXRlcm1pbmVkIGJ5IGEgYnVzIHdpZHRoLg0KPg0KPiArDQo+
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgLy91NjQgdW51c2VkIDogMTsNCj4NCj4gK307DQo+DQo+
ICsNCj4NCj4gKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+DQo+ICsgKiBTRVJJQUxJWkVfUkVR
VUVTVA0KPg0KPiArICoNCj4NCj4gKyAqIFRoaXMgcmVnaXN0ZXIgaXMgdXNlZCB0byByZXF1ZXN0
IHNlcmlhbGl6YXRpb24gb2Ygbm9uLWNvaGVyZW50IERNQQ0KPg0KPiArICogdHJhbnNhY3Rpb25z
LiBPUyBzaGFsbMKgIGlzc3VlIGl0IGJlZm9yZSBjaGFuZ2luZyBvZiBUUFIgc2V0dGluZ3MNCj4N
Cj4gKyAqIChiYXNlIC8gc2l6ZSkuDQo+DQo+ICsqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KPg0K
PiArDQo+DQo+ICtzdHJ1Y3QgYWNwaV90cHJfc2VyaWFsaXplX3JlcXVlc3Qgew0KPg0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgIHU2NCBzdHMgOiAxOyAvLyBTdGF0dXMgb2Ygc2VyaWFsaXphdGlvbiBy
ZXF1ZXN0IChSTykNCj4NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLy8gMCA9PSByZWdpc3RlciBpZGxlLCAxID09IHNlcmlhbGl6YXRpb24gaW4gDQo+IHBy
b2dyZXNzDQo+DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IGN0cmwgOiAxOyAvLyBDb250cm9s
IGZpZWxkIHRvIGluaXRpYXRlIHNlcmlhbGl6YXRpb24gKFJXKQ0KPg0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8vIDAgPT0gbm9ybWFsLCAxID09IGlu
aXRpYWxpemUgc2VyaWFsaXphdGlvbg0KPg0KPiArIMKgIC8vIChzZWxmLWNsZWFyIHRvIGFsbG93
IG11bHRpcGxlIHNlcmlhbGl6YXRpb24gcmVxdWVzdHMpDQo+DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqAgdTY0IHVudXNlZCA6IDYyOw0KPg0KPiArfTsNCj4NCj4gKw0KPg0KPiAvKiBSZXNldCB0byBk
ZWZhdWx0IHBhY2tpbmcgKi8NCj4NCj4gwqAjcHJhZ21hIHBhY2soKQ0KPg0KPiAtLSANCj4NCj4g
Mi40My4wDQo+DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5v
Lgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAtMjk4IEdkYW5zayB8IFNhZCBSZWpvbm93eSBHZGFu
c2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29zcG9kYXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNh
ZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5NTctMDctNTItMzE2IHwgS2FwaXRhbCB6YWtsYWRv
d3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dpYWRjemEsIHplIHBvc2lhZGEgc3RhdHVzIGR1emVn
byBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVuaXUgdXN0YXd5IHogZG5pYSA4IG1hcmNhIDIwMTMg
ci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1pZXJueW0gb3Bvem5pZW5pb20gdyB0cmFuc2FrY2ph
Y2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9zYyB3cmF6IHogemFsYWN6bmlrYW1pIGplc3QgcHJ6
ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBhZHJlc2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3Jt
YWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBhZGtvd2VnbyBvdHJ6eW1hbmlhIHRlaiB3aWFkb21v
c2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5pZSBuYWRhd2N5IG9yYXogdHJ3YWxlIGplaiB1c3Vu
aWVjaWU7IGpha2lla29sd2llayBwcnplZ2xhZGFuaWUgbHViIHJvenBvd3N6ZWNobmlhbmllIGpl
c3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFp
biBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVh
c2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGllczsgYW55IHJldmlldyBv
ciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuCg==


