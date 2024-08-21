Return-Path: <linux-acpi+bounces-7749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EA95934E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 05:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A9A285B02
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87701547C2;
	Wed, 21 Aug 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvZA2VLq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9802B9B5;
	Wed, 21 Aug 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210456; cv=fail; b=J8v4Y4jRBXIRApAFcl9Xq7fDgjuqLt1YXSqyS6NvrW0+r0iCzHCn7vxstpjSOH59c4VoFRZPyMuPzTU0RT0xtZKkgyCl1ELWPFvn59q48g5lPjAz1r4b1Mya67sYSWpc5+9NgknweqCsI0kRQzVMtVN6Bu41DoII+Ui21/RQnkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210456; c=relaxed/simple;
	bh=OOhpacB3oGxHYnsh80Bxq8X+kLRDc83Krpw8VP1uqHc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rn6FrIgWIwhiIS+DxyXxxgiic8OMniPaC1sLTKm5TysabD9SuogSfssdmpxzgZTOTaY4JeqeCjCSTAKFrtiGuatu+NemtISz8l42PLd4eokTUUCPcoYIbglyTKUPl0+wured6RUvzQzjgvQRnspW0vYyOWhV7dY4S0BR92Uh7eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvZA2VLq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724210455; x=1755746455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OOhpacB3oGxHYnsh80Bxq8X+kLRDc83Krpw8VP1uqHc=;
  b=WvZA2VLqAkh2ZbUfswcCkLQlBoY7G8XWJ9mNvcgqqSEOf0iWHhXMtGHy
   U1CvDC+l7xwlosARk7DdvoT1IseAjksLXD0LEVSDib8aCFIxiATrzI3Ye
   Sl1B5x91oVhaCDXKblV8plu5TwDcG+QPt+AC+j+EQF3VY/DmRUI56gZOz
   ZCT9Rd7MmPscNuPEkh9RTsd0RRqxGfNQngiUT/jkrhweb5+M5KjwvBvCT
   cDWz9S/Ra/gjIhua/v6DozI/mImZAM1/EUVcv4bxSRlOQS2/dHExivKY4
   9DXZaFrctSvQ8V9YPCJJgyX8VUrg3Khai9rGQydEKkdZoESTdtEhG9lr4
   w==;
X-CSE-ConnectionGUID: UKF4Q9B4QLujARknWcyHYQ==
X-CSE-MsgGUID: tvrGbvSHQ7eZM53o2Dl8wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="40006608"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="40006608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 20:20:54 -0700
X-CSE-ConnectionGUID: Uhd8qNysRTy0z1xmtW/xxA==
X-CSE-MsgGUID: Pzz907dER76Y/it8g1ZbAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60973522"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 20:20:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 20:20:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 20:20:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 20:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrcOcib5uSYPqlLHDzkruVcMN02WvGu5rzzTSe1ltItz602LO1D8k5tN2Ug/3Rvedq2Hbtz5wBXVyoZKZZxUIgPL5HVMC3ZlSvNkHKHkP++I6p3Mr0cwDDjuEJeZkOf4VB88873i8K1/t1s6igBARfyMF+hrjWaC6t3lbI6x+nqK4W2XdfJMVWUDIS44/SRx8iEyGJFYAQIrq3//YXDUlAphfKBJXPG9HOTwwE8yaljjdMhNgIWQ9Z+pOhf3/wTUr/f6y/g7rpsbzV1E5Df/mq9eMX+F2SEvm62q8/UKKtTtcwLJB9bE+/lVkv2hSYH6T8cTU5Dz1aWtSxI4Fs5ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOhpacB3oGxHYnsh80Bxq8X+kLRDc83Krpw8VP1uqHc=;
 b=hXD1j9A6ZRL5FLJMA0SM5UyWNhLJFmaInReDA4eeFaYHu1nXykxQ2N80e1fKcMwYfm2IDriXEx4e6uIpGsasaRkZret24OGAifH6/BUzK48twvUI0vwSdQxC/hdhM4d7UEoNkRr7VZBTjxMsY0JnpNc/6ljA2TajmDhWITLzk6egqFCwfH7auLmgnToJIdHs6XPL6dzQyWloYqajGfE4Kb6SADb8aL680NpROWUcaSsQfFbr7C94fZJDSCYQeS+0KF6r2eeFsGBac58raEsBgVOPNj63ZUgfncL8NcCjAqA3Q9pRIwN+ekhDUDOmLXQlYR3OGxUATuwpMQh8xIbhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW6PR11MB8339.namprd11.prod.outlook.com (2603:10b6:303:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 03:20:50 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 03:20:50 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "erik.kaneda@intel.com"
	<erik.kaneda@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>
Subject: Re: [PATCH] acpi/prmt: find block with specific type
Thread-Topic: [PATCH] acpi/prmt: find block with specific type
Thread-Index: AQHa47zv/FjSqarIqkGArXguHN663bIxKsIA
Date: Wed, 21 Aug 2024 03:20:50 +0000
Message-ID: <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
References: <20240801014853.1594699-1-kobak@nvidia.com>
In-Reply-To: <20240801014853.1594699-1-kobak@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW6PR11MB8339:EE_
x-ms-office365-filtering-correlation-id: de119d8a-8509-406c-9181-08dcc19041c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3VxbnlNV28reTVEcGRwQ3g0WHBSRS94dkJheG1FOTVBVk9zaEVBVy9SQXRL?=
 =?utf-8?B?NURPL0dGL3ZmaUVDL1kvNE1vWm5iVGFkMzRQQnh1RTQwS2V4NnM1QWh1Snhs?=
 =?utf-8?B?L2F2MzIvRmRLMDJSOFlDa1dZM0hFRVA4eEhCcXl4WnFXbUw2ckI3R2RIbjZs?=
 =?utf-8?B?RnNIc3VBMkdBK2pPK0VHYVY1WFA4ZE9uTlNyQlR0Q0hvd2MycXc1WmJqTFFT?=
 =?utf-8?B?Nzc1YUFibGNDbnFwbEwxbnVFVUYxWU1hN1ByU2VDbWFWSk5BUmZZa0ltZm4r?=
 =?utf-8?B?dGxSKzJIRTAxOEtvbFBYV2xjcmdBNTI5cXVSQzhZTldDZDlUZ1ZpS1F6RHov?=
 =?utf-8?B?aTZEL0dOZW9BaDMrL0ZxWUJWRzJrTHQvT0JRb3dNa1NxQXFDTHdzL0JkV2Z0?=
 =?utf-8?B?b3lVZ2dTNFRpYnNjVHBDTWNzait2YklKekVBeVFwREhadzhvWEV1QXg5ejBW?=
 =?utf-8?B?SUJjK3plSGVUMVJmbVcybnptd2xHTG1RM1YzWU9HWUxnMDJUYUhySU9WTG15?=
 =?utf-8?B?V2JQN3d0bHZBM2xheS9oMHRNSktRZkV4RkFxSWVzSW1obVlSbDh1b3NHMXds?=
 =?utf-8?B?RitBeGZEZUFFdjM4SkwzZi9zVnpXVmtVRGdtWjYwMWcrYVVYRUl6a2NkV0hO?=
 =?utf-8?B?RjE5VENiSkVEMFh3T1UxUnFVQ3U2LzJxWEtRbGhZck1IVjNwQnJxZitWMlV0?=
 =?utf-8?B?b3FLU3NhVUlzSmNQQ3FwY2tXcXFkYnVxcG5PaFlSaXA3eTd0aFVad0h2VDNy?=
 =?utf-8?B?TFhLSDBpcndqVEljYmZkMkx5QVU0QlFBdE1BZmxpVkoxQW84SkI2UC9GM3Jn?=
 =?utf-8?B?MFRkTUk0SUFXSWtkYlRYbEpJOGdiRi9ySmJERlZYaG9tMXpZNVJDamlBbytX?=
 =?utf-8?B?T2o5eVlFeGlHQU9wKzlBb3BJNXNmcDd4aU1mY3AvcHZRVEM4QW1HdWJ6M09h?=
 =?utf-8?B?OVhSMk9hOUtMeUI5ZjhPZG5xdFh4cXB2bWhGRjZDeHlnVnNEZGc3K1ZvWjhu?=
 =?utf-8?B?bENZd2xwZG5ZczQ1aUZHY0pVQWNXOFNMb1N0WWxkNjhoZHdzaHFCVnJuMW1U?=
 =?utf-8?B?MWp0b0lZSDQvNTMxb3B3NUxtVEczaHd6WTNEQnFpSDhDUStZS1hMWktsM2VU?=
 =?utf-8?B?MktxeUlTUldRVkVlWncweFJ1cG5VRDJxaXFGMEs0R0I1NW8zeHRYdUlLMjJv?=
 =?utf-8?B?VCtGY0ZIQjByS1ZSK1ZQR09kY2puRzBnNjA3VTZWeGIzcGt3bFVPYndxeTRE?=
 =?utf-8?B?b1E0S2N3VmwwcFRjdkFsbkNnUnF6cEt6cTBqSVVpeFJpbzBxS205VmNzUXI5?=
 =?utf-8?B?bysxQVZLbmY5UEx4MURNSUV1Y09scVVZUTBURDNNbnBsUVplY1BleWpJSVoy?=
 =?utf-8?B?LzlhU0ZuNTQzU1ZMOXFZMUxTWkpRY3hBS2R2VTZJYTVpZjBUbXRmaEpNZXV6?=
 =?utf-8?B?ancvSWZOdlBVMXVZTjVNc2FWQ1NhaXFrRkdhcHQydjNUVUxTTEpwd2FsWFQ1?=
 =?utf-8?B?ZVdvQzdLSlVFK2kvNXA4R2V2Rm1tOG9KUHluMDJSbWx0UUh5dzNqWXlpdmwx?=
 =?utf-8?B?NGVXMmk2aDdLckV3a3lVQ21wTG84d3JYSDdKeEVaYUpHN1FRdm9MaEY2eTlS?=
 =?utf-8?B?MHB5RTZNL3BKTit1Mkk2UXNtMVRGblY4cDk4dkhzS2xVRUY4SGFwMlJJOFdJ?=
 =?utf-8?B?U05NUHpnSG9NVlhUNEFDQ1NLNGV1a05Eb05TUG5Rb3JraXBoZEhQMUxpa0pj?=
 =?utf-8?B?MlZPWEdPcC9LSFVrYkhXeWZDaThJTEFLRk5rNG5ITDRCdy9yVTdUNWVFV3NQ?=
 =?utf-8?Q?6PSmX9DlaE2lqwhCwMjgO3pKg9Wz8hfq1PxbQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VksxcjRGMWI3MXFYeGwzK1EyUHJNMGM1MUt6WGNkT2xuRjRsdm8vS3JQQ2JF?=
 =?utf-8?B?SEdnOVgzRCt2TGVFaE9QWEdJMDhHZDVxZXJIU2tqUDlVanNhR1JoZ0tsbXdV?=
 =?utf-8?B?aDVydjZ4Si9yd2pGZXZVUFc1T1VtU2xXRXdRUENLdEVjNkNwK0hjL0tPbkRF?=
 =?utf-8?B?MUxzWitkNmZBaWdubisrVDQ5WUtYa2J6b1ptUXIyZmlvMUtQVUZENG5kTHox?=
 =?utf-8?B?bG5xZzJ4dlVGbnV4Z3VycG5FRVNpZkpWWUF5SzNBbDNGMjJMU1R6L2l6dDlt?=
 =?utf-8?B?S21OWkR0cnA5TEZEOTc3cDIxRC9TcGdNY1lSQmQxQ3dvOUM1emRtSjJFMGNp?=
 =?utf-8?B?QWxuM2RobTgzaFJkeGd1RWlMeUFJek8wSTZlTEg3ZzRtZk05V2MxcG9YSXFH?=
 =?utf-8?B?dXlkNStTOWk1RmxSbUxVeXRXa04xODJjRWNFN294ekZiK2laMGk2TnFaTkZ1?=
 =?utf-8?B?aFZIV0hnRDBmRnZydy84V3F5ODFQL2M4RjA1eVRnL0djVCt2UFZRbityL2N3?=
 =?utf-8?B?d2tncmdMaHA0WUNtd3hSMExORFVjcFFwY1hwRzdtRG11Mm1ycWxPdUd0Y1dp?=
 =?utf-8?B?ZWN3ekRiRnE2VUpsTWdFVSs3Sk9qZ3BxbzBXWUdFNXJTaG9lM21xMTMyanBY?=
 =?utf-8?B?MjZFVDBJT0d4ODlPVDJyakNaNnk1ZjgyVXk2RFZPbkUvNzd6QjQ3MlJPUG8r?=
 =?utf-8?B?eDlxUmtyMnI3R202R3NWQTFOMHBNLzVuUVFNNG9hK1U5c0tDalN4VHVCbk1x?=
 =?utf-8?B?RWdBMnExbUJ2RFV0VnVYaG1oSmw2Zldtcy9nZXVTSWxJSEtJRlAxWE5yK29a?=
 =?utf-8?B?OC90R3NKendvYkxZUkphV3RVTDI0Q3M1bzVsTWluODRzTHg2dFBCVUJockFF?=
 =?utf-8?B?QW1iNEQxc2RUSmptTmY0RnJLcVZxZ0xtZ3Z0M0sxdGtPVC92WnA5VnNKbEtV?=
 =?utf-8?B?UEtaMGFGZ1RYa3AreTRBNlpBV2dvVkFtaS9BZVorYWdYOXhVZU1idWtsRmkr?=
 =?utf-8?B?K3VuQ2VqVWdYSGV2L0lnMko3Z0VSVTJSYTErSFA0OG1Ob0VOenhkUHB5UlNj?=
 =?utf-8?B?L2Q5T01iSUFKa2dmOFBGd2gxOEord2dVakZpMUVsdmJMd0JvdG9qdm5vQzh3?=
 =?utf-8?B?QTU5OEdzMVRnTG80QkJmdmZEa2Z0UHpvSVZZWUZ5aFlBUllTVzhTSGQwOURa?=
 =?utf-8?B?YVlFRldCSkJoWjhML09HL3Z1NDIraW05U01VV1hFcWRzRVJyQnZmRStwSWdT?=
 =?utf-8?B?VFM2SFlRcWNsVEVOWWVYRUVobDVnTzRXdWVYcXpCSnU1QjVGV2hiU1A3VVh1?=
 =?utf-8?B?VjUyWDB4SXJIUUhwV0JlTC9WS3JRaytXbklaR0NubTE0UGFGU3lLSjRralNC?=
 =?utf-8?B?c3Z1YVh2VXlWaHJ2ZEJReSs2ZEhwWnNRdy9SNFdNZ2tOVEhvUEZWVWNXSEhN?=
 =?utf-8?B?Rk1jMWcvcTlkblJCYkhjcFJFUWFPK2R3ZkViOTBGYzJ4MXBJcWJYREpIYnBy?=
 =?utf-8?B?YXlXTnBaL2ozTDE4eVRwb3l2V2YrM290RG1KUUxFVjBnV3hpUWRJVExMcmxm?=
 =?utf-8?B?WVhxcjd4RVYwYzBoOG1GVm14VjdJUTFLUmZMSDRvVjJVUUhGZFVTaXp6QzNr?=
 =?utf-8?B?OFlkNG45YndUL1h0dGRpVEpNRmJObDlWdDY4QTduMEhQaFpyRU8zZDNsVWJh?=
 =?utf-8?B?LzVuYW84c0hQUzlkZFd6d3JMT2hWclU2ei9FVGUvdmFvajNwOU5scWxuRUFN?=
 =?utf-8?B?WjZPVWc2dGxETzJYVEtnRmpVdHB5NXJQN29zUk92SlMvYjdoemIrMTdWZ2g2?=
 =?utf-8?B?VHZvb2pMMlEzOG5wTmNGSjVXaHUvUEJzUitCSmdTa3hHYktJS2VqM3BobllW?=
 =?utf-8?B?cUVEemJwS01YbnVoditLSnhoNTJUSWZqM0FoNm85MXpCSHM3by9sMlljbC9k?=
 =?utf-8?B?UTd1MnpqSEh4VWxqNkNmeFo1bndGcWtSS2xXWExPcms4VFpXQ1BTU3VQMEJM?=
 =?utf-8?B?bjhBQTZ4TTE1ZHRrSGlmTXRoelBRdkQ2eVc1akFLM1NtenBOMkk1RkFIeElM?=
 =?utf-8?B?MTlMNmNUVnNWaXpOL0x4TXBFb3JHblVGZ3h0SmFjZmpqeHZwd0E4dEFxSmpu?=
 =?utf-8?B?TkZjOU5CUzBYdEZmSGZTZTFFSW01TGpWYTJ6QlV2M2VDeHlLaHdkVy80V2Zt?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF5AD18839D57A4EBAA4CB1AD40E38FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de119d8a-8509-406c-9181-08dcc19041c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 03:20:50.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UM6Z7YJRU5NCU31WnKWMQRgiMOLG+7fLCtswe5cxl2SEPZEwqnDkRV+YRbbreMCxXPOsbgKgDNqyfM+C6+iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8339
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDA5OjQ4ICswODAwLCBLb2JhSyB3cm90ZToKPiBQUk1UIG5l
ZWRzIHRvIGZpbmQgdGhlIGNvcnJlY3QgdHlwZSBvZiBibG9jayB0bwo+IHRyYW5zbGF0ZSB0aGUg
UEEtVkEgbWFwcGluZyBmb3IgRUZJIHJ1bnRpbWUgc2VydmljZXMuCj4gCj4gVGhlIGlzc3VlIGFy
aXNlcyBiZWNhdXNlIHRoZSBQUk1UIGlzIGZpbmRpbmcgYSBibG9jayBvZiB0eXBlCj4gRUZJX0NP
TlZFTlRJT05BTF9NRU1PUlksCj4gd2hpY2ggaXMgbm90IGFwcHJvcHJpYXRlIGZvciBydW50aW1l
IHNlcnZpY2VzIGFzIGRlc2NyaWJlZCBpbiBTZWN0aW9uCj4gMi4yLjIgKFJ1bnRpbWUKPiBTZXJ2
aWNlcykgb2YgdGhlIFVFRkkgU3BlY2lmaWNhdGlvbiBbMV0uIFNpbmNlIHRoZSBQUk0gaGFuZGxl
ciBpcyBhCj4gdHlwZSBvZiBydW50aW1lCj4gc2VydmljZSwgdGhpcyBjYXVzZXMgYW4gZXhjZXB0
aW9uIHdoZW4gdGhlIFBSTSBoYW5kbGVyIGlzIGNhbGxlZC4KPiAKVG9vIG1hbnkgY2hhcmFjdGVy
cyBpbiBvbmUgbGluZS4KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMuaHRtbCN0aGUtY2Fub25pY2FsLXBhdGNoLWZvcm1hdAoKCj4gwqDCoMKgIFtGaXJt
d2FyZSBCdWddOiBVbmFibGUgdG8gaGFuZGxlIHBhZ2luZyByZXF1ZXN0IGluIEVGSSBydW50aW1l
Cj4gc2VydmljZQo+IMKgwqDCoCBXQVJOSU5HOiBDUFU6IDIyIFBJRDogNDMzMCBhdCBkcml2ZXJz
L2Zpcm13YXJlL2VmaS9ydW50aW1lLQo+IHdyYXBwZXJzLmM6MzQxIF9fZWZpX3F1ZXVlX3dvcmsr
MHgxMWMvMHgxNzAKPiDCoMKgwqAgQ2FsbCB0cmFjZToKPiDCoMKgwqDCoMKgIF9fZWZpX3F1ZXVl
X3dvcmsrMHgxMWMvMHgxNzAKPiDCoMKgwqDCoMKgIGVmaV9jYWxsX2FjcGlfcHJtX2hhbmRsZXIr
MHg2OC8weGQwCj4gwqDCoMKgwqDCoCBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcisweDE5
OC8weDI1OAo+IMKgwqDCoMKgwqAgYWNwaV9ldl9hZGRyZXNzX3NwYWNlX2Rpc3BhdGNoKzB4MTQ0
LzB4Mzg4Cj4gwqDCoMKgwqDCoCBhY3BpX2V4X2FjY2Vzc19yZWdpb24rMHg5Yy8weDExOAo+IMKg
wqDCoMKgwqAgYWNwaV9leF93cml0ZV9zZXJpYWxfYnVzKzB4YzQvMHgyMTgKPiDCoMKgwqDCoMKg
IGFjcGlfZXhfd3JpdGVfZGF0YV90b19maWVsZCsweDE2OC8weDIxOAo+IMKgwqDCoMKgwqAgYWNw
aV9leF9zdG9yZV9vYmplY3RfdG9fbm9kZSsweDFhOC8weDI1OAo+IMKgwqDCoMKgwqAgYWNwaV9l
eF9zdG9yZSsweGVjLzB4MzMwCj4gwqDCoMKgwqDCoCBhY3BpX2V4X29wY29kZV8xQV8xVF8xUisw
eDE1Yy8weDYxOAo+IMKgwqDCoMKgwqAgYWNwaV9kc19leGVjX2VuZF9vcCsweDI3NC8weDU0OAo+
IMKgwqDCoMKgwqAgYWNwaV9wc19wYXJzZV9sb29wKzB4MTBjLzB4NmI4Cj4gwqDCoMKgwqDCoCBh
Y3BpX3BzX3BhcnNlX2FtbCsweDE0MC8weDNiMAo+IMKgwqDCoMKgwqAgYWNwaV9wc19leGVjdXRl
X21ldGhvZCsweDEyYy8weDJhMAo+IMKgwqDCoMKgwqAgYWNwaV9uc19ldmFsdWF0ZSsweDIxMC8w
eDMxMAo+IMKgwqDCoMKgwqAgYWNwaV9ldmFsdWF0ZV9vYmplY3QrMHgxNzgvMHgzNTgKPiDCoMKg
wqDCoMKgIGFjcGlfcHJvY193cml0ZSsweDFhOC8weDhhMCBbYWNwaV9jYWxsXQo+IMKgwqDCoMKg
wqAgcHJvY19yZWdfd3JpdGUrMHhjYy8weDE1MAo+IMKgwqDCoMKgwqAgdmZzX3dyaXRlKzB4ZDgv
MHgzODAKPiDCoMKgwqDCoMKgIGtzeXNfd3JpdGUrMHg3MC8weDEyMAo+IMKgwqDCoMKgwqAgX19h
cm02NF9zeXNfd3JpdGUrMHgyNC8weDQ4Cj4gwqDCoMKgwqDCoCBpbnZva2Vfc3lzY2FsbC5jb25z
dHByb3AuMCsweDgwLzB4ZjgKPiDCoMKgwqDCoMKgIGRvX2VsMF9zdmMrMHg1MC8weDExMAo+IMKg
wqDCoMKgwqAgZWwwX3N2YysweDQ4LzB4MWQwCj4gwqDCoMKgwqDCoCBlbDB0XzY0X3N5bmNfaGFu
ZGxlcisweDE1Yy8weDE3OAo+IMKgwqDCoMKgwqAgZWwwdF82NF9zeW5jKzB4MWE4LzB4MWIwCj4g
Cj4gRmluZCBhIGJsb2NrIHdpdGggc3BlY2lmaWMgdHlwZSB0byBmaXggdGhpcy4KPiBwcm10IGZp
bmQgYSBibG9jayB3aXRoIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEgZm9yIHBybSBoYW5kbGVy
Lgo+IHBybXQgZmluZCBhIGJsb2NrIHdpdGggRUZJX1JVTlRJTUVfU0VSVklDRVNfQ09ERSBmb3Ig
cHJtIGNvbnRleHQuCj4gQnkgdXNpbmcgdGhlIGNvcnJlY3QgbWVtb3J5IHR5cGVzIGZvciBydW50
aW1lIHNlcnZpY2VzLAo+IHdlIGNhbiBlbnN1cmUgdGhhdCB0aGUgUFJNIGhhbmRsZXIgYW5kCj4g
aXRzIGNvbnRleHQgYXJlIHByb3Blcmx5IG1hcHBlZCBpbiB0aGUgdmlydHVhbCBhZGRyZXNzIHNw
YWNlIGR1cmluZwo+IHJ1bnRpbWUsCj4gcHJldmVudGluZyB0aGUgcGFnaW5nIHJlcXVlc3QgZXJy
b3IuCgpzb21lIGdlbmVyYWwgcnVsZXMgdG8gZm9sbG93IHdoZW4gd3JpdGluZyBhIGNoYW5nZWxv
ZwpodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL21haW50YWluZXItdGlwLmh0bWwgNC4y
LjMuIENoYW5nZWxvZwoKPiAKPiBbMV0KPiBodHRwczovL3VlZmkub3JnL3NpdGVzL2RlZmF1bHQv
ZmlsZXMvcmVzb3VyY2VzL1VFRklfU3BlY18yXzEwX0F1ZzI5LnBkZgo+IAo+IEZpeGVzOiBjZWZj
N2NhNDYyMzUgKCJBQ1BJOiBQUk06IGltcGxlbWVudCBPcGVyYXRpb25SZWdpb24gaGFuZGxlcgo+
IGZvciB0aGUgUGxhdGZvcm1SdE1lY2hhbmlzbSBzdWJ0eXBlIikKPiBTaWduZWQtb2ZmLWJ5OiBL
b2JhSyA8a29iYWtAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogTWF0dGhldyBSLiBPY2hzIDxt
b2Noc0BudmlkaWEuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9hY3BpL3BybXQuYyB8IDQ2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KPiAtLQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2FjcGkvcHJtdC5jIGIvZHJpdmVycy9hY3BpL3BybXQuYwo+IGluZGV4IGM3ODQ1
M2M3NGVmNS4uZTJmMGJkZDgxMDEzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm10LmMK
PiArKysgYi9kcml2ZXJzL2FjcGkvcHJtdC5jCj4gQEAgLTcyLDE3ICs3MiwyMSBAQCBzdHJ1Y3Qg
cHJtX21vZHVsZV9pbmZvIHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBybV9oYW5kbGVyX2lu
Zm8gaGFuZGxlcnNbXQo+IF9fY291bnRlZF9ieShoYW5kbGVyX2NvdW50KTsKPiDCoH07Cj4gwqAK
PiAtc3RhdGljIHU2NCBlZmlfcGFfdmFfbG9va3VwKHU2NCBwYSkKPiArc3RhdGljIHU2NCBlZmlf
cGFfdmFfbG9va3VwKHU2NCBwYSwgdTMyIHR5cGUpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoGVm
aV9tZW1vcnlfZGVzY190ICptZDsKPiDCoMKgwqDCoMKgwqDCoMKgdTY0IHBhX29mZnNldCA9IHBh
ICYgflBBR0VfTUFTSzsKPiDCoMKgwqDCoMKgwqDCoMKgdTY0IHBhZ2UgPSBwYSAmIFBBR0VfTUFT
SzsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9lZmlfbWVtb3J5X2Rlc2MobWQpIHsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1kLT5waHlzX2FkZHIgPCBwYSAm
JiBwYSA8IG1kLT5waHlzX2FkZHIgKwo+IFBBR0VfU0laRSAqIG1kLT5udW1fcGFnZXMpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgobWQtPnR5cGUgPT0gdHlwZSkgJiYKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoChtZC0+cGh5c19h
ZGRyIDwgcGEgJiYgcGEgPCBtZC0+cGh5c19hZGRyICsKPiBQQUdFX1NJWkUgKiBtZC0+bnVtX3Bh
Z2VzKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiBwYV9vZmZzZXQgKyBtZC0+dmlydF9hZGRyICsgcGFnZSAtIG1kLQo+ID5waHlzX2Fk
ZHI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoMKgwqDCoMKgwqDCoMKg
fQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgcHJfZXJyKCJQUk06IEZhaWxlZCB0byBmaW5kIGEgYmxv
Y2sgZm9yIHBhOiAlbHggdHlwZSAldVxuIiwKPiBwYSwgdHlwZSk7Cj4gKwoKSWYgaXQgaXMgYSBw
cl9lcnIsIHdoeSBub3QgZXJyb3Igb3V0PwpvciB3aGF0IGlzIHRoZSBwcm9wZXIgaGFuZGxpbmcg
Zm9yIHN1Y2ggZmFpbHVyZXM/Cgo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDC
oAo+IEBAIC0xNDgsOSArMTUyLDEyIEBAIGFjcGlfcGFyc2VfcHJtdCh1bmlvbiBhY3BpX3N1YnRh
YmxlX2hlYWRlcnMKPiAqaGVhZGVyLCBjb25zdCB1bnNpZ25lZCBsb25nIGVuZCkKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoID0gJnRtLT5oYW5kbGVyc1tjdXJfaGFuZGxlcl07
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGd1aWRfY29weSgmdGgtPmd1
aWQsIChndWlkX3QgKiloYW5kbGVyX2luZm8tCj4gPmhhbmRsZXJfZ3VpZCk7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoLT5oYW5kbGVyX2FkZHIgPSAodm9pZAo+ICopZWZpX3Bh
X3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPmhhbmRsZXJfYWRkcmVzcyk7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHRoLT5zdGF0aWNfZGF0YV9idWZmZXJfYWRkciA9Cj4gZWZpX3Bh
X3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPnN0YXRpY19kYXRhX2J1ZmZlcl9hZGRyZXNzKTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIg
PQo+IGVmaV9wYV92YV9sb29rdXAoaGFuZGxlcl9pbmZvLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRy
ZXNzKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGgtPmhhbmRsZXJfYWRkciA9
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAodm9pZCAq
KWVmaV9wYV92YV9sb29rdXAoaGFuZGxlcl9pbmZvLQo+ID5oYW5kbGVyX2FkZHJlc3MsIEVGSV9S
VU5USU1FX1NFUlZJQ0VTX0NPREUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0
aC0+c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIgPQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPnN0
YXRpY19kYXRhX2J1ZmZlcl9hZGRyZXNzLCBFRklfUlVOVElNRV9TRVJWSUNFU19EQVRBKTsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIg
PQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWZpX3Bh
X3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHJlc3MsIEVG
SV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEpOwo+IMKgwqDCoMKgwqDCoMKgwqB9IHdoaWxlICgrK2N1
cl9oYW5kbGVyIDwgdG0tPmhhbmRsZXJfY291bnQgJiYgKGhhbmRsZXJfaW5mbyA9Cj4gZ2V0X25l
eHRfaGFuZGxlcihoYW5kbGVyX2luZm8pKSk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7Cj4gQEAgLTI1MCw4ICsyNTcsMTYgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4gYWNwaV9wbGF0
Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBoYW5kbGVyID0gZmluZF9wcm1faGFuZGxlcigmYnVmZmVyLT5oYW5k
bGVyX2d1aWQpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlID0gZmlu
ZF9wcm1fbW9kdWxlKCZidWZmZXItPmhhbmRsZXJfZ3VpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmICghaGFuZGxlciB8fCAhbW9kdWxlKQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBpbnZhbGlkX2d1aWQ7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghaGFuZGxlciB8fCAhbW9kdWxlKSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidWZmZXItPnBybV9z
dGF0dXMgPQo+IFBSTV9IQU5ETEVSX0dVSURfTk9UX0ZPVU5EOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlcnJvcjsKCkkgdGhpbmsgaXQgaXMg
b2theSB0byByZXR1cm4gQUVfT0sgZGlyZWN0bHksIHJpZ2h0PwoKdGhhbmtzLApydWkKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKCFoYW5kbGVyLT5oYW5kbGVyX2FkZHIgfHwgIWhhbmRsZXItCj4gPnN0YXRp
Y19kYXRhX2J1ZmZlcl9hZGRyIHx8Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAhaGFuZGxlci0+YWNwaV9wYXJhbV9idWZmZXJfYWRkcikgewo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmZmVyLT5wcm1fc3Rh
dHVzID0gUFJNX0hBTkRMRVJfRVJST1I7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycm9yOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEFDUElfQ09QWV9O
QU1FU0VHKGNvbnRleHQuc2lnbmF0dXJlLCAiUFJNQyIpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY29udGV4dC5yZXZpc2lvbiA9IDB4MDsKPiBAQCAtMjc0LDggKzI4OSwxMCBA
QCBzdGF0aWMgYWNwaV9zdGF0dXMKPiBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIg
ZnVuY3Rpb24sCj4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgUFJNX0NNRF9TVEFSVF9UUkFOU0FDVElP
TjoKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlID0gZmluZF9w
cm1fbW9kdWxlKCZidWZmZXItPmhhbmRsZXJfZ3VpZCk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICghbW9kdWxlKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ290byBpbnZhbGlkX2d1aWQ7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICghbW9kdWxlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBidWZmZXItPnBybV9zdGF0dXMgPQo+IFBSTV9IQU5ETEVSX0dVSURf
Tk9UX0ZPVU5EOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBlcnJvcjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobW9kdWxlLT51cGRhdGFibGUpCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kdWxlLT51
cGRhdGFibGUgPSBmYWxzZTsKPiBAQCAtMjg2LDggKzMwMywxMCBAQCBzdGF0aWMgYWNwaV9zdGF0
dXMKPiBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4gwqDCoMKg
wqDCoMKgwqDCoGNhc2UgUFJNX0NNRF9FTkRfVFJBTlNBQ1RJT046Cj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vZHVsZSA9IGZpbmRfcHJtX21vZHVsZSgmYnVmZmVyLT5o
YW5kbGVyX2d1aWQpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1vZHVs
ZSkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8g
aW52YWxpZF9ndWlkOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1vZHVs
ZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVm
ZmVyLT5wcm1fc3RhdHVzID0KPiBQUk1fSEFORExFUl9HVUlEX05PVF9GT1VORDsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZXJyb3I7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKG1vZHVsZS0+dXBkYXRhYmxlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZmZlci0+cHJtX3N0YXR1cyA9Cj4gVVBEQVRF
X1VOTE9DS19XSVRIT1VUX0xPQ0s7Cj4gQEAgLTMwMSwxMCArMzIwLDcgQEAgc3RhdGljIGFjcGlf
c3RhdHVzCj4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoH0K
PiDCoAo+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBBRV9PSzsKPiAtCj4gLWludmFsaWRfZ3VpZDoK
PiAtwqDCoMKgwqDCoMKgwqBidWZmZXItPnBybV9zdGF0dXMgPSBQUk1fSEFORExFUl9HVUlEX05P
VF9GT1VORDsKPiArZXJyb3I6Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBBRV9PSzsKPiDCoH0K
PiDCoAoK

