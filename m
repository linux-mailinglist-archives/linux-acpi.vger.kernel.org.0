Return-Path: <linux-acpi+bounces-18293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEAC15B2C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B28421B03
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6E33032B;
	Tue, 28 Oct 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAP0UaJh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1949217F31
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667448; cv=fail; b=Xzs5iMMApICdWOjOD/lV8RYxeBxC1DDvSSNAhAn6qdIGiOiJzDhem/KvNcDWqdpx+gKkmmvWplUODTXPnffJtMiNG3SuhEdKzzBTKpAgzeY2u2wdU6u6UHNxJesXR8b2p8plTvxpFBsCVU0S4rzv2A4+9NaVTCikvRFacgroozc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667448; c=relaxed/simple;
	bh=Hqb2/vT8BAyhd92nX/TC/WRjuFY9ElV0BQVeod6GVhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bcsp+yJbjKE01m9i+EC/fv21cgNUukeyT3ktUXxXgP86Yjg3hCMWxDH/0+sHmtnteFwuR9AdI4Mtxk85RcBBBgd+Ut1/YaykM1SCACsfn/y5nyZX4mBHODWxdtoMHkow6O40x9e90U8/ICLyscP6gbkN7/IPQNnAbIwtFVvKXdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAP0UaJh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761667446; x=1793203446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hqb2/vT8BAyhd92nX/TC/WRjuFY9ElV0BQVeod6GVhU=;
  b=dAP0UaJhZr77wq33OkdO++R6WiAdMLI7Mqq79V6+y94POAhk/b2ybp8X
   zhX4JqqE/yoaN+RMr3JlIlDIaIv3pBPu9XuPKi2O3Er+Z/5axhoNPkTzL
   d8As27Lxw0i9unIj+SdWzj72Jn+9J0me8kwvgsIfQr3sVUrWpemPDkEim
   IVYlrz3HqKepArj0GmyGXDmP+fR5QkM1FXmKCSHH8CKG2gSkZWrVkJfXZ
   n3c1wQyCDW4MrS+x1qDuw7ROUkIgf27ojFc7jdKbKEGrlRat07P2E9b+W
   JU73o22SCcj0FeIu0sJARxTGEK3QaQJIIaruz3DyY83K0SlCBW7FNzbqB
   A==;
X-CSE-ConnectionGUID: rn9gZP7UTpunfHLb01SABQ==
X-CSE-MsgGUID: um2z+D/5SiKtQyGLuWV/OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63921938"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63921938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:04:04 -0700
X-CSE-ConnectionGUID: K44aZrqOTxGYTNv5uduQow==
X-CSE-MsgGUID: 1deCMjtnRLmsTkOo3Rc4Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185721302"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:04:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 09:04:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 09:04:03 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 09:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHJR6HBpMa+PpZSFUY3T8XNcmlr22a1Gvncn+VQeXyIbEfEioMe7pwDP9Npz93TNPK4XojqOLYGZdgmdveN11APFlMEFKed1/hXdKOPvNXmZDIx+G2Y/439d+xdw4RAtefaBlMk+shD4dPh6SeuRu5RE6dFudnApERuIVif4vx1YKUbmkj4quu1KYKNkiXDJ/P00GNzoOKYGcNzIeh3biry1dr9tqJ8TZGLyzKi+Af+h8ye5HrmVK8hfJfqKRieEVkdSvT34fgD+SgBs0Ix9T8uRLlM8uY/V+q6FVrARlF17ew5//gYs4TlEIE8eCEYc6LOCzjL8TFdAM4DvqovCLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqb2/vT8BAyhd92nX/TC/WRjuFY9ElV0BQVeod6GVhU=;
 b=E24pw8Nks9GrnDVNGKE8Ipq4FDK5ywfrd1WYy6+/Z8PX3aFQuVdZijji4wT84XG+iKwwJWP56xaIcLrUzIvrB0pWHPbGgSQ9bQ1ohkQibd4tij8bbbxDBOpwksfBA//ft8TN1JXXx07reBR9cbdDZn+trwD8XUmFlY3ec2bBQ0dCNKJRpWtM7PYpWWn/oKS30uAA13MdEnav+sO7JKkYRctdJRJqRo58/QVTxLOl+3cPQVCVtdv3fGByVqsjVIE+2xTLyPTTr+ADnsfTbGK6UYE1tYY2VkoXyEk8yo4BaKgw2DCrn5GhmVjveuTjhC8++VUm1XfZzi/SwKONoAr19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 16:04:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:04:01 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Topic: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Index: AQHcQ4qG/lhvXCfAMkO59n+hCDB6oLTOlUuAgAhv6oCAALrE0A==
Date: Tue, 28 Oct 2025 16:04:01 +0000
Message-ID: <SJ1PR11MB6083F8600D6697A636C765E7FCFDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
 <aPk3URcrjx_KjkJ7@agluck-desk3>
 <LV3PR11MB87685DB538FDC1B2AA8F6BA0F5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB87685DB538FDC1B2AA8F6BA0F5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: def41690-ce0c-4ac7-bd2c-08de163b9c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c2c5WHhoZXhRRWxjTmdFNWZ6bHFRd0l4aXBlei9leml1T0lxTURUQnFBYksv?=
 =?utf-8?B?cW9uNEppSUtMQUExZERoRVVFVStFWlMvTDJKWlBhT0JPRDJ5SW5nUnFVNk0z?=
 =?utf-8?B?b1J5VmFXdU1YTDVFUW0zbUxsNG8rRXFiMmQ4bXY0SFUweUxUSzFsNEJ0VE5T?=
 =?utf-8?B?dUt4QlRQNE5uSGVKMVJnOG1vUG00UTZ3Z0wzckFLd05xMTlHNVNBM3RaSkRi?=
 =?utf-8?B?WVRNQmxFMFZwV3ZvV2R4M2pPZEkzN0JGMUpjSjkxeTVKQnlvV2pGejNWWEJo?=
 =?utf-8?B?L3dmZ2l6UFBkcm5mYzVranVSZ0dSbDVkRUxFK2VMYndjOVBzWFFuaGVhSkly?=
 =?utf-8?B?MUFXNjd2UU11VzdYQ0lHbmVXTUpRRlhvbE5IVmF1WTdvbmxhbnUweXgxbHJr?=
 =?utf-8?B?RVREOFIzZno3czV4aGR4UUhYaTVKcG5lU3I1YjBCSVFJWGVJelQ0MVNQMEFO?=
 =?utf-8?B?alpNeGh1Wk04Q3l5M1ZwQ0ZOVjV3MG9Lc2dWNFAyelIvcHYyanhaZmdWdGIw?=
 =?utf-8?B?blpwWXJRcHc3YTB1QnBMWHlTVDdCVmhFMWQwYjk1MkFlZE5nRStQTHUvZWFB?=
 =?utf-8?B?b2FxZEN4MnVSQWRLQ3hDMEl2d2o0bk5MUkVBeWxOUHFRTDYxTzhHc1dMYTNX?=
 =?utf-8?B?N3VwRHVmYkpGQkgvMDdpbkJ0YmZIS3drTE5ocmN3MDEyZFpxaFQ2ZUlGNHdY?=
 =?utf-8?B?TVRtV0RPaFhIVzJXbDZ2L0JhYVRiYXUzQlVCNnpXSVRySE12Z3lWNlh3T1VS?=
 =?utf-8?B?VDZnREF0WHd2SXNzNXdub05mUjkyL0ZlMVltcXVzNXgzc1lCTzdlQU4relFP?=
 =?utf-8?B?RVdsSkJsWVpjY0gyRjR5K1l5WFdiU2llN1NyM0VVQ3pZeUorT1E3MmFyUlpn?=
 =?utf-8?B?TnBxVXE1Ym1HWmJNaUZIL2xrSVpyU0t4SXpqTEVHckpyVjFyYyt2UkpiU1JH?=
 =?utf-8?B?WHBwV0p0TS8yaEZTV3BkL2pWVGlzbk9wRklzZnliVzlXc05jalVJNG41bjkv?=
 =?utf-8?B?NnlEK1JsRXh6dFlxNGFHdHRPU3FJTng0bGlDWjBMZTVTOE5mNE1pU3p3SFp0?=
 =?utf-8?B?YTVUeXI5TzNUVEwvSk9XN0tncXhiSWR2Ty9KV2IyRFExRmdHcTE4NEdZR05h?=
 =?utf-8?B?T2orMmkyVXpxMGlBMURjbDdLL3pkLzBwZnA4UGFUZnVDQWRUSTgvTXJJdERR?=
 =?utf-8?B?dUFFMWtWZ1JPa1VGa2tyZ1lNMGhINGZmdXdoSmdGNkFIZ0Q5d0MzMUVnM1kz?=
 =?utf-8?B?aW9ycDIwZ3VZZC8ybjVXK01aanlac01PY2NhVU1uVTVlRW5ZNzUveFhVYVFq?=
 =?utf-8?B?bjNsZFdCZ01LMnczOWYwNlI0UkZpTEw5ZGI1QytQak5XK3N2NzV1WC92Q0NK?=
 =?utf-8?B?SHlOZGlrTUc1T3c4VUhlU1UzeXBxU1dWWmRIZFFXTmRnWkhCLzBZWGkrZXdt?=
 =?utf-8?B?TXZFNldMei9oMWtHMVB0VEZYeDM4TkxqUHQ5U1BkK0NhS2FvcXVXZlFpL0Zs?=
 =?utf-8?B?SmxtTHUyWm5UdzR4bGlEcXVwRjhNOWc2SXJNU1dObTBLa3Z1YmtBb3dqK2ww?=
 =?utf-8?B?VERsZTJHTC96bXNvYlZmbjF3YkNLQkZ6dUg5dkNwSmVTN0dxNGVrakNNQWYv?=
 =?utf-8?B?TGhCbFZDZFhNVDMrR3lJRmhZay9iMWVKMUl2S0Y5YVBIbkNtRnRiZTZFN2Vu?=
 =?utf-8?B?TmJpYTg5MUNZOHdPVlNTUkNMdXB6NXV3aEl1Um94Z3d6d0VFOURkMjF3ZExX?=
 =?utf-8?B?N0ZLSVhYaUF2VU8wV3I2eDhjaHF3aGRyN2xycTFjOEpYMkRjS1l6Q0xJRE83?=
 =?utf-8?B?bmROSWxTeHNwT1piWDRyTjd5eGpuQWUxUy8wVVB3eGJycVhPd2FmdnZUVUk1?=
 =?utf-8?B?amJjK3VaUlB0MnJTOEN6VVN3QlVaQVJXYjEwZGZ1azZJQ21LY0hzc0F2dXc4?=
 =?utf-8?B?NHNQM0RvLzRhZXJMZTZ0MWlhMFg0cmhFK3R3S2FKZ1RkejExSjFRczZTREs1?=
 =?utf-8?B?eEJlNDA2WGkyQUFyQ2ZNV0MvSHJONGMxanhEVHBmL3FQdEg5b0dlekpSbnRQ?=
 =?utf-8?Q?tIgAJL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVczWXJvL1RIV2NhMjNQYjJVUW1hbFRSYWlpSTRCdlB2dzBtYUQzVnloaFJk?=
 =?utf-8?B?OWdWeld6RGdVRmR1a0VXMjdRcGVNcWJVa25XNEczZDVSVmFKdU4weTEvNzRU?=
 =?utf-8?B?dHdwTEtRVk5vak8yRnhrd0ZOdTNTYzBYc1lBOGM2R0ZEWTQ5UU1aREN4b3Vi?=
 =?utf-8?B?dnZBRDkxWnRGaTJ2RXYrRG9pUGZkamt1bXhiMklZMllXMXJUTGJja1VseHl1?=
 =?utf-8?B?ZjF4ejk0b2Nnb0htaWVnbm1ZRlJvTkFMWUZXYTlneGtiWnoyR1RhMU9NbjRQ?=
 =?utf-8?B?VGovNkVma0RkaVp0eFlTenJhNGtzSGl1bjdPWGhPNUtUaCtxVnRLemJkNEc3?=
 =?utf-8?B?SFFUUitQZlZUYzFoR0w5VXdMWTl0SVl2TGZpQzNtZEdtS3RpYW9qaUVBL0lX?=
 =?utf-8?B?eXVFTzJqUENnd1N3QzhVUFhUOEpuQnFmbmFrdSszNU5oUzVKeWViNml0cnFD?=
 =?utf-8?B?eEhmWGI5U1lzNGVJMjU1bnNwNjlNL3o2eFc0QVpsbVN1azBlRG0rc3ZFbmpl?=
 =?utf-8?B?end1RUVwdVllczZ3VGc4dFhLYi9PTFJLZlV2b0ZwekZWTTAxWjVDVEx3NkNv?=
 =?utf-8?B?OXJZckpGWitJUjV4V28yRjhpVzZaZkFmem5sNjBOU1RTOEtLSEZoT0NaNW1W?=
 =?utf-8?B?ZldHRmxKQzNvUkkxYzRKaHNvQ2VnWlczSjJ6UEhaazlvaVZETlp2S1JvZ2Jz?=
 =?utf-8?B?NElCVHBJRXVtcWF3blZ0OHNYSWNDK1F1czJUd2xzaWFDajV0Y2pOWmQzNit3?=
 =?utf-8?B?b1IrM0VTNDlZZzdaMU0xL1R5K0lDc1NtQTJvYjJ3K0tNYUdZOG1WL0t4NVhR?=
 =?utf-8?B?aXlzZzVuSmluTnVCTThEUzJQbWJxQzJDaHVpZmhxSkMxSjFjQytYanVxTXVm?=
 =?utf-8?B?SUNOZGlENDV2S0s0WXNFLzg5SGpCeVo0eC9OWEh4MmVYU0I3ZmJnRmlOdVFs?=
 =?utf-8?B?ekpyblpkQ3M1dy9SYXFWbW1ZT09EN2xuVk9JWGh2dTZEL1FtZE1hdXdBd2Fu?=
 =?utf-8?B?RlVaYituTW9xTmlnci9zbmlRS3ZVdzJXSmlxUEJaRE5md25uQmdOS1Y1ZXBP?=
 =?utf-8?B?K2NwQktIWnozcDcrUXVSNGpHYkNGVUFFbVBKdHB4OUV6aHlDOFFYYXU2L043?=
 =?utf-8?B?dEJFSUMyeS85Ky8xY3JxTDRQVkhpOC9nNVM4QUVEbDVVaWxyMWtWSEM3bHU0?=
 =?utf-8?B?QnZHYUtoc216ZFlRQTMydlRSYWRsS0tTZUplVldFT25GbTI3citSbXpZQWVy?=
 =?utf-8?B?dkZVZWxybzYvQ2NqN1IwdVhxdklVUEhxQnI2ZkVaUng1NDY1OHRiYlR1aWNp?=
 =?utf-8?B?K3JCUnFjL0dqcjlJbGp3ZEJVNk5UaW9JWkRhYjRKNFdSQ1o5L0hmSWthQnM1?=
 =?utf-8?B?cHRaSjBGY25pMExYc2xnM0hkVWZtd0RKMCtMRE0yaDBvV1BGMEdBcUZEVVpJ?=
 =?utf-8?B?WDJXN1dyc1VWOGtTYURHbDJ6Q0RTRzR1aW5tV1F0dW1GVy9qZE9MUldyVWtz?=
 =?utf-8?B?Y1RFeWJ0aWtRSzJuSFBwb1VFNFQ5QVB4dlJkSlYzOVBVZ1lwbFBuNjhHU2l6?=
 =?utf-8?B?ekpPMUFqNmhBRzVkQUsrRG5qN0Q1Slk5R3JsbTh1SnpXMWNLTVdmOGNtekRT?=
 =?utf-8?B?U1F5aGNZUGNZUUJ4OHlRWG00VXFMWHdDcmtiMHZQeVNROFNXM0tYYVM5YnRE?=
 =?utf-8?B?b2piRE5xdk1QNXF6a3ZtTTVKd3JheXk1UFZHdzN0aEt0cjNTMURrZ2NYcGpH?=
 =?utf-8?B?dFhnSnMrR01ycGlFQnNUenorVTBwRHZWQXBlMHFkQ0JBeVVKdXRHcmw5NGwz?=
 =?utf-8?B?a0MxQTBCZ3dkeXFhV1VCN3VsMlNqSURMcTc0czJZRGZ5OVpHUm05SEo3SjUw?=
 =?utf-8?B?MUtaNHRhWmJFcGJrME80SzdyTzdiM0hqSHV5RThTWklNMGFURjJma0U5M2U2?=
 =?utf-8?B?R3ErSk1TNEs0TnFBYzBON0ErL0psWFVTbHA0aEhTYW90VWJvRTlEdWwva20y?=
 =?utf-8?B?aXh6V0p0TzF3aTlCRUZXNG5yZ3Nzb2oyWWkrejJ1bUlxZFBOcVpJeFNBK0d4?=
 =?utf-8?B?aHY2QkEvaEk1S2NJMGRDS2VWcFVMRzQzdkJQRDYwWGU4VjF4aXRvZFRwUUJ6?=
 =?utf-8?Q?QbhlKu5pUSaL8KIqTt0YoVdUk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def41690-ce0c-4ac7-bd2c-08de163b9c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 16:04:01.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCzWIy1+xXmz7AwXcp179vw13XMWTNOGICh3Ys8hv4x1X+YWwsBztb3HJeeC+2j7wlU7qqWJHH0tUwO6/Z4BCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com

PiBuIFdlZCwgT2N0IDIyLCAyMDI1IGF0IDA5OjMxOjI5UE0gKzAyMDAsIFJhZmFlbCBKLiBXeXNv
Y2tpIHdyb3RlOg0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmICgha29iaikgew0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gY2xlYW51cDsNCj4gPg0KPiA+IFdoeSB0ZXJtaW5hdGUgdGhpcz8gIFdo
eSBub3QgY29udGludWU/DQo+DQo+ID4gSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0IGtvYmplY3RfY3Jl
YXRlX2FuZF9hZGQoKSBtYWRlIGl0cyBvd24gY29weSBvZiB0aGUgIm5hbWUiIHBhcmFtZXRlci4g
IE1heWJlIHRoZSBjb2RlIHNob3VsZCBhdm9pZCB0aGUgYWxsb2MvZnJlZSBieSBtYWtpbmcgIm5h
bWUiIGEgbG9jYWwgdmFyaWFibGU/DQo+ID4NCj4gPiAgICAgY2hhciBuYW1lWzE2XSA9ICJyYW5n
ZVhYWFhYWFhYWFgiOw0KPiA+DQo+ID4gICAgIHNwcmludGYoJm5hbWVbNV0sICIlZCIsIGkpOw0K
Pg0KPiA+IFRlcm1pbmF0aW5nIGhlcmUgKGFuZCBiZWxvdykgd2lsbCBnbyB0byBLYXVzaGxlbmRy
YSdzIGNsZWFudXAgY29kZSB0byByZW1vdmUgYWxsIHRoZSByYW5nZXMuIE1heWJlIHRoaXMgaXMg
YmV0dGVyIHRoYW4gaGF2aW5nIHNvbWUgcmFuZG9tIHN1YnNldCBvZiBmaWxlcyBhcHBlYXIgKGJh
c2VkIG9uIHdoaWNoIGFsbG9jYXRpb25zIHN1Y2NlZWRlZC9mYWlsZWQpPw0KPg0KPiBUb255IGlz
IGV4YWN0bHkgcmlnaHQgaGVyZS4gSSBiZWxpZXZlIHRoZSBjdXJyZW50IGFwcHJvYWNoIGlzIG1v
cmUgYXBwcm9wcmlhdGUNCj4gSGVyZS4NCj4NCj4gUmVnYXJkaW5nIFRvbnkncyBzdWdnZXN0aW9u
IGFib3V0IHRoZSBsb2NhbCBidWZmZXIgLSB0aGF0J3MgYSB2YWxpZCBvcHRpbWl6YXRpb24sDQo+
IGJ1dCBJJ2QgcHJlZmVyIHRvIGtlZXAgdGhlIGN1cnJlbnQgYXBwcm9hY2ggZm9yIGNsYXJpdHku
IFRoZSBrYXNwcmludGYva2ZyZWUNCj4gcGF0dGVybiBpcyBtb3JlIGV4cGxpY2l0IGFib3V0IG1l
bW9yeSBtYW5hZ2VtZW50IGluIGtlcm5lbC4NCg0KV2h5PyAgSSdsbCBub3RlIHRoYXQgdGhlIGNs
ZWFudXAgY29kZSB5b3UgYWRkZWQgdXNlcyBhIGxvY2FsIGJ1ZmZlciAiY2hhciBjbGVhbnVwX25h
bWVbMzJdOyINCnRvIGhvbGQgZmlsZW5hbWVzICh0aG91Z2ggbm93IHRoYXQgSSBsb29rIGJhY2sg
YXQgdGhlIHBhdGNoLCB0aGF0IHN0cmluZyBpc24ndCBhY3R1YWxseSB1c2VkISkNCg0KPg0KPiBU
aGUgY2xlYW51cCBwYXRoIGVuc3VyZXMgd2UgbWFpbnRhaW4gc3lzdGVtIGNvbnNpc3RlbmN5IC0g
ZWl0aGVyIHdlIHN1Y2Nlc3NmdWxseQ0KPiBjcmVhdGUgdGhlIGNvbXBsZXRlIGludGVyZmFjZSwg
b3Igd2UgbGVhdmUgdGhlIHN5c3RlbSBpbiBhIGNsZWFuIHN0YXRlIHdpdGggbm8NCj4gcGFydGlh
bCBhcnRpZmFjdHMuDQo+DQo+IFRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIHJldmlldyENCg0KLVRv
bnkNCg==

