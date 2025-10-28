Return-Path: <linux-acpi+bounces-18271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA18C12EDC
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 06:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F3C1AA4500
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 05:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372D27E076;
	Tue, 28 Oct 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRoETzxj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA427144A
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628836; cv=fail; b=s9QDuEn2glQw3Vqeixyr6wQn0ltG1Hqk3VKUpilUEqT2PwqWxKWBIWaE/5tx4GoXhUhRRUsF5kMDdzwpHJA8+jrx0HLRoJ8JYmLRtrSd8HisqqvEXc50J2CBKVgWCZUuYuSiXA8X+4kctbFCUXNXKmwYFGJrcakmm/AoOBD37Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628836; c=relaxed/simple;
	bh=bV4mvdriRWgvpYi9hCnSXB78YZt/oF7Fpjg2aASki/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRPf699WdTT3qxQqRh5dZ0QwH1OGpx014KVxrtJvfu5UMoNN0dBwzjCaKzATRXpiQ04tOJOX+lquEmuIQaTV0RPRUV2U3zgdgqAFMtvdwRDuDZyklGc+pbUPHr9C/QFnCKoHbiys+PSWN/B7SyBTFeRP6Uxy9DyfNQNpIZ67zg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRoETzxj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761628835; x=1793164835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bV4mvdriRWgvpYi9hCnSXB78YZt/oF7Fpjg2aASki/g=;
  b=BRoETzxjl6Jy31faPZi7GaQQeWdr3zl1kcdKNRsLD4t5cXk/Q68WV23S
   VGLmLpvlmPtoBT+wTwUcRpQ8IRv8SWPYUIa++Qp2ejMPppAwPGUNvTvzl
   xIxati3opBZQUIkQu2YcGj+b3jhAyXQnKzAecaKwbk7PBsBmLUDFWfQtm
   It/U9G+183gQDD2gcJ74/4nqVwaxeojvT6siuAbug99lFRpD81Nt1sX+8
   IPT+3pVJNF19umHNUhtii4bRDUetzEwUHshzDx4I9a0t1dnHwIfgbLtvS
   1R/0siE8FpJmvAFGf21bHrqjYn5fmVjINf0UMGF1BxVDAqdSV+2s3FYWd
   w==;
X-CSE-ConnectionGUID: qDKe6EeGTk63E/urBvoaMQ==
X-CSE-MsgGUID: bJMZ7YtSRNmC9INl4yLdBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66335427"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="66335427"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 22:20:35 -0700
X-CSE-ConnectionGUID: ZaxlRTtOQWKzhWX7R1pXeA==
X-CSE-MsgGUID: BaJr4KXxSE+nVAqnrP+xag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="184947621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 22:20:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 22:20:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 22:20:33 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 22:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIjJWQCLfUD1k43qKIPYcQQ04JjObAYpSt6b3Rm0egtXKzyYMktOYjrFJIVRUwJ0aiZ2wMKnntIOmeGxrJ552QFcypp4ehtnssPUGbePNOIaOBxTIwwfA8XS4SgfPVOU2FbM2hfIK4O98JWjnHed55Xdk2JpIiE/tef/0F0ZZNCKHdfd+k+swwKYSEg2s9w7FsI032mxcqu7X/8J764tBlDIm6v+HXfmbEjnJJHvN5xDdTH1VJzBtD2x1XTunwTqePZqk8VhgFA7xOVPgkQkathWsqRWfTm/xAxu9kmuiTrFug2nbILUtzBc45T0CU4mG39cimTgFqCjOIo2enZAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV4mvdriRWgvpYi9hCnSXB78YZt/oF7Fpjg2aASki/g=;
 b=QBjSfVfaeZcGE39JoyYn+sgsS3y4r+MC980LF3LVJcgtkBZmot8/p1w0yqTk6Lof3VN+TAiLLuiGuGQCUWy/dIMx9cQxLXVyor5D/HsJ/O86EZWrE1YyQVIkxouQla/Au9Xek7pBpkatL+qCDejzhjrJH4wZNCe32sYbEmsu/pn817USXmZj5oq/1tbTUsdynwBvo49m02CpvAWK4PYmYdKiI5UwNLC5pAdEkI3lOe2X6oNj6rK70XkZcsawivkExlsc196GGAk+b7RxuNMVvtsHQU+SDD66LQwxdvZx755QctaVO90rH73/EjG/Zd6hK3T6n8u3Zyj2MZxeExFlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 05:20:31 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 05:20:31 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Zhang, Rui" <rui.zhang@intel.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer deallocation
Thread-Topic: [PATCH] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer
 deallocation
Thread-Index: AQHcQ4ZdrczNtH3eCkm5da+/+wGWy7TXDc8A
Date: Tue, 28 Oct 2025 05:20:31 +0000
Message-ID: <LV3PR11MB87685549B93BA1AB43BA68A7F5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251006045320.970534-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0g4WPTKuZ0G75jGWFnqtOvy6Q-L43ZuPGHG+KssfEknTQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g4WPTKuZ0G75jGWFnqtOvy6Q-L43ZuPGHG+KssfEknTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|MW5PR11MB5809:EE_
x-ms-office365-filtering-correlation-id: abeb1dd9-e0ac-4fa0-9fa4-08de15e1b6d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OW8yNUVSR2c4cWtEUTVLemhrUjE2VVkrRU5rMHp2QTFMWWtYTHA1ZmVETDJz?=
 =?utf-8?B?MGNCVUlFYWhKTHdxNFA4a0o1MndpbDhXcDhMVHFjajQ0dzZzMm1IVHZUblVw?=
 =?utf-8?B?ZGQ5RmVkRXp5VThtTHBZZEtKTkFhVDFYVDFoNTg3RnZpczd1SG5lRzY5cU4v?=
 =?utf-8?B?WjUzU0RWMVdMS0l4MkFHMDNpbDJicEgrZDNodmZWSjN1cllCbng0U09qWVhZ?=
 =?utf-8?B?aTBvUEgzZUUwODZGLzlhQ3Jjc21ZeXF2ejdnem1PdWIzWDF2d01GNGVWb0hJ?=
 =?utf-8?B?OERsMFpDOUJCVnFuVzRTcmU5SVBFR3JsVkVET1FzdlNRUi8yWUFmSkliZXF2?=
 =?utf-8?B?ZUp0aENtWG5jdzhJZ3NuRGJCL2VKMHBRVTRNOHhvdlJvRGxrUXE2WlhuUEYw?=
 =?utf-8?B?cmVxRVI1cGpWbm5wMHRDLzhWQzdTTzY5eVpyQ3duTjQwdnVqVXgvSXBZU2R5?=
 =?utf-8?B?bG9YR1h1WGVTcFc1cDArbnNGTm44Y0RvSm9ldUg0NG8zUFVaWFRERlBTY1hU?=
 =?utf-8?B?eU9oSmp1SzhVTWNONWRVUnprMXdYeUYyeWtwVG5uOElMTFNIZjloOHA3Q0Fw?=
 =?utf-8?B?d0kxOFhKU2F3YW5vdW1XT0FUZk1uU2duek1HRlhrR29wUUxDLzZNZ3lmTkdl?=
 =?utf-8?B?a3o5eEgrZ0RLd1Jxc3c2WGVGQXdrUmJxNWg4UGRoVE9zYzhzSXlPeHdWUngv?=
 =?utf-8?B?Z1NjWUhNcStaMjkvQTVpWWRPRFlLcFY2Q08rbHR0OCtiTVMzTlFTaWZybWda?=
 =?utf-8?B?dFJSYUxSdmU4SzVqQjN4MUljTUZRcURGbmtEc3VZR3Y5bVg4R2VQR0RxTzRh?=
 =?utf-8?B?YXFETnM4cTB2dHZwclNhdGk5c1I5ZENiR3lkajU1QlIxNFB4ZThWcFN5aE1I?=
 =?utf-8?B?ejg2SFA4L282anI0M3RRUWhrU3gxY1JQUE5nc0RVcjJVOFlsdThYV3VSMjA3?=
 =?utf-8?B?MWZGZFVSMlJmdDhseVRRTWI5dUJBRlJpYXJBZ0dMS3JRUFRHazNrb1hNKzJy?=
 =?utf-8?B?Z0dGRFNUMis1M2J3cE0yeXovdmJ0eTYwT2psUkg1OFluQ1gyZ0xvNXY4cEpU?=
 =?utf-8?B?YUhYcm52d1ByVEpsNHZjdzlwZUc4Ulh3YWtIdUFjV2xZK2ZSYUg0T0NqcGwz?=
 =?utf-8?B?Sm1yN1VSdlFCNWErK0JsNVZZWDhDT1pDbVplOEZ4T3U0MGxzZllVNm8vd0VX?=
 =?utf-8?B?U1pPUEhYRVp6YVY0RzEzSkhNeWdkbnZLRHkvOW5lRzVVR29mWktNZzlmWnhR?=
 =?utf-8?B?VmF5czRoZElJdE1XVWFxQ1U5VGZ1dURnS1BoNHNTTTd1U3hhdUdlWEh3bXNL?=
 =?utf-8?B?UmZrZHVGdE1lbWZsTmxXUUhrc0ZUZkRKQ09rc1RYcDlUaURSUEZVSlhNbk92?=
 =?utf-8?B?RUZ5WG5aaHZMR2ZsWld2NVhxYk85ZmtiZm1LaFVtdGxzN3JSejhTTVFlcDBG?=
 =?utf-8?B?Q0dyWlhVeUFuWEdGdEVnR0JIcE9Tb0lCb1p5ZW1vclJzYlB1QVkwTUZWRzND?=
 =?utf-8?B?cGp5anNhRThjUzZUV1BGWGt4ZWtrTWJQMGlNNFFpTGZENmdOWjBqbUE4bk1y?=
 =?utf-8?B?NEk0SGNmSzRwK205M0I0UFp6Y3VMTHlzcWdBaWx4M0g2ZVJqVG1TWFRKcDNw?=
 =?utf-8?B?UHQ3bDZZMEpKNTNaZDFZVFJXb2kvbFhwbE5JNThGVnQvUmF1c2hlWXFWVEJ5?=
 =?utf-8?B?T1hCakdkSnlFMFdLakczUDBEQTBDUmhqQ1ZNQ21qaFdNRDRBNTJNR0I1RDhG?=
 =?utf-8?B?UEVyS3JkeGhyWUJsU2UxUU4vWWRSSlp2L0VjUEJHTHpRa1VORW9LeE1EUnFZ?=
 =?utf-8?B?cTNJSWtOOXRlT2MzMFp1OC8xaUlhMmZLcCtjc21Mb0xVdkFuUXd2Qmk1UU8z?=
 =?utf-8?B?S0s4NHBXdVlxZnlTUnRRMUdDYnR6NUpvK3I4dWVvby9PclFTQlFOZVFydE1F?=
 =?utf-8?B?TGNmMEZmeFVqaDlOUHlVL0pwcnFCbTVtM2R0d0g0OEpScGZ6MzVwVDYwWjZQ?=
 =?utf-8?B?NmZBKzRucWtMSUwySThGakZVTHpWYXEvb2k1cmlKZDdUejdJby9IcmoyUkZR?=
 =?utf-8?Q?Lr7lRF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xBNzJCUHFlUEF2Wlh4SUZJQmljVC9QODNyQ3BISDRSL0RkbUJwR2NZejhM?=
 =?utf-8?B?TVhrSWJuQUVPemczckpxMmxmbnZGclNPbTNkSWtvRTFuYXdQQVJSY2Njd1V0?=
 =?utf-8?B?Z3RoZWNOa25UdUVtMXVFeW84cXkyMCszbXNwT1dCbDZQdm9pN3dsSjB2WFgw?=
 =?utf-8?B?R20xa3h4L0JlczcvZHpvbFREYWorZ05zc2VSaFQ1UkpLV2xPUVEwNllhQWFM?=
 =?utf-8?B?cXNJU0hXTTlGbkdlekQxMlN4MWN6TFR0MmRJRFc2UkRFa1JXVngzdTlkSHdI?=
 =?utf-8?B?c3B2cGNYWlhuOXV4UVRWR3RvaEhPWmVhWndSalpQYkRsc21CZ0VUT2p0NS9q?=
 =?utf-8?B?MjRoQkRQbGFpUjB1RTJ1NkovSXk4alpIVFN3Tk5TTXlGbzRvb0tIS2ozVzF5?=
 =?utf-8?B?OGpJbjcwRDhOcWcvbXE5bEl5cDJjRzFlZ215MnlBTFVpRWt0SzNGU2RTZkd5?=
 =?utf-8?B?NnFwNDhRQjMrVDB6VjQwQ1lrK2JYYXFXeEkrc1JjbHFIOEh4aUxld000VkR3?=
 =?utf-8?B?K0x3ZEdHa3FsUGo5N0NBOFJsZ0FZcVV0V0tNQ0VmU294aVlaemthRGc0dm9l?=
 =?utf-8?B?UitrWU41d3lLdzV6MTdQZ1hXTFhTR2RkN0lYajJuTEdHQkpVQVE0Y0dLdTNt?=
 =?utf-8?B?YW4zVmVLWmhUYjQvVEphUnRIMDkvVzZUbjNUMDJqNkVnOElWZUhEOUdGY1BE?=
 =?utf-8?B?Z1d1ZzFuQ2tRakxmcmlhSUg4eVNkTjRNanVZUkZpbW93ZmNxMTVhc1Zkc2ow?=
 =?utf-8?B?UFlHbXdiMTNrTWpCU1pXZG5rOEpVTE1WUXpXUGNrM2tnTER1T0JRcy9wMzJR?=
 =?utf-8?B?OUloeWY0ZTVvVG92RWRjMCtGQjB1a2ZFZ1JUd0MyVU5ZMUV0RUxSZTFxMjZH?=
 =?utf-8?B?MC9KNmVtVm1rNmdDQ3lXd2dFMzVCeWlaTXdUR1FXeUJ0aHRvZ2ZYZzMxVTl4?=
 =?utf-8?B?VWU1SkdkL1FrT2pVUkxLMFErZ3lzZ1dPUTlQaTZiNDZkd2pNdW0rY0k0NUxC?=
 =?utf-8?B?MFAwL3dFS244cDNad2VJd1c3MGJhWGVLUTh4WFRBZGM4U1NENnFLZ3lLYnVy?=
 =?utf-8?B?Q3B3Q2diY0d6NjRtQ2o3YjI1ZVM2bktlWkZJL3lydU5TUXA5SmdwNERjazFw?=
 =?utf-8?B?UHV3MW9BaFNKNkwvY2c1cG1pdVlCUVFSVWpGbC92T3kwM0x4a1duTWd5SFk1?=
 =?utf-8?B?dSt6U2tuWVk2Z3A5ais5REF2RnNueUFpY1lLWmIxbko4anMxUFg4ZVEvVU84?=
 =?utf-8?B?azVwWXdxRlhQWkZZMlVTNzEyemdjVDZBL1QzQndvV2VDZmYrWmdPS3JHeE9W?=
 =?utf-8?B?QTRjcU40UCsyZGkvY0RxT2RJcHNHV0NHZXJOTDVsMXdFdXlRY3grMkpFdHV0?=
 =?utf-8?B?WWZSd3MvdWVDL3pBTXRITzFnTzE4czk3UWl2THlVNkpzb1Z4bTN3NmtnYUY0?=
 =?utf-8?B?cGtmS3ZQTmVDSGdUckJJeDFHN2FraWk3RkVDUzhoWGMwTFRFWHBlSDVVUHRQ?=
 =?utf-8?B?bnM5bGxIcG4wU2tsZnFrUzhFOEpIK3N1L0V0RzU3KytKeDhJT09XMzVhaWJH?=
 =?utf-8?B?S2hzM3NsQnJ6OU0yNFhuS29RNHZ5S3pIU1VITGtpSFFLdW9lU01Cc3kxdm9J?=
 =?utf-8?B?OHE4eC9ZV3NrNDZudFM0K1Myd09EeGlsaWlqaitNa2VrblRONWZvNVRFWXJZ?=
 =?utf-8?B?eThOOCtFVS9aVEVNdEs4L1NuN28rQjdVa3NMVmVuTWVWdjJEdjlwNWk3N0M0?=
 =?utf-8?B?b0ZTbzk0OGFSbkVIc3dJMHpzd0lYcWJDVFA1a25OdEJlU051aFE0OGNDbHBk?=
 =?utf-8?B?bjdSclY3Ym1ncjJZb3VrOEQ0bGxZTW5MbmM2a3U3cFM5d1gyendYSHp4a1dM?=
 =?utf-8?B?cjlsU0RiV0wzMFVNTnRwUDZ6MGN1Z3RETm1DSE1uNU14OG90SkpTeE5QRmlC?=
 =?utf-8?B?WlhmaW1odTR6UVpUZElOMExvNEdFeldJbWR6bjN3V2EyT1poWHd1blhFOHlO?=
 =?utf-8?B?SVhnV1N6K0N4Skh6ZGsvSWxsT3N0ZHd4dWZjUDdJM1BLNE1zVXMvVy8xRW8w?=
 =?utf-8?B?UWpReHp1VnI3L0VlU0pYSit2ODBlRXUya1EyWFZUVHRFVXpSQWhlZFZTeStk?=
 =?utf-8?B?dkxKQzRpenNmSDR6M2prNlAybGZIcE9vWHl3dGhkQUNidFJ5VS9vYTQvWGx5?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeb1dd9-e0ac-4fa0-9fa4-08de15e1b6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 05:20:31.2171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljpyYBjndovVGPdHjeHkqVs7K2Ltp3GXy/F+hVYOrON55+WoPgo3u+SVEjp2O7wehINX75E+DKExSEjq0lmj/+QnzAlizoZ/bql0CDaEBFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com

PiBUaGlzIGlzIGp1c3QgYSBjb252ZW50aW9uYWwgdGhpbmcgYmVjYXVzZSBBQ1BJX0ZSRUUoKSBp
biBMaW51eCBpcyBpbXBsZW1lbnRlZCBhcyBrZnJlZSgpLg0KPiANCj4gVGhlcmUgaXMgbm8gY29y
cmVjdG5lc3MgaXNzdWUgaGVyZSwganVzdCB0aGUgY29udmVudGlvbiBpcyBub3QgZm9sbG93ZWQs
IHNvIHBsZWFzZSB1cGRhdGUgdGhlIGNoYW5nZWxvZy4NCg0KWW91J3JlIHJpZ2h0LiBJIGhhdmUg
dXBkYXRlIHRoZSBjaGFuZ2Vsb2cgaW4gVjIgcGF0Y2ggdG8gY2xhcmlmeSB0aGlzIGlzIGFib3V0
IA0KZm9sbG93aW5nIEFDUEkgY29kaW5nIGNvbnZlbnRpb25zIHJhdGhlciB0aGFuIGZpeGluZyBh
IGZ1bmN0aW9uYWwgaXNzdWUuDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrIQ0KDQpLYXVzaGxl
bmRyYQ0K

