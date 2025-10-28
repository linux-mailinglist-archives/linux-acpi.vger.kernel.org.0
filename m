Return-Path: <linux-acpi+bounces-18294-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EFC15CC8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84724255DE
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCA2284889;
	Tue, 28 Oct 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtlYM9xx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F78285041
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668247; cv=fail; b=IsBCktGKmJWfFTdzVoPNJQ6s+KFQqWCEDPydbL6JdZ1AcH25/o/NRQISBfQdopJBrhe90cPL4uLGjSW1UsKs5x9eLjZ70CHalyHj9PJx9z5Z2q7V3pIjkvy3B0nd+zdcuJj8AJuA8p4XFLcAuoSFUDIGIpQP3zckNi+aq/dBmxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668247; c=relaxed/simple;
	bh=lxjr5Dfqh+HsIWxl2K+uSN5Xb1p0yuGfm7nyLQtccWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxvBp/0uArXS5NWGx09u300CX5QWxHiSpHOq0AhjHF1Mh+1VnDI+aDpvxXeAMAT2Vq2TdYWMOwWCg+PoOF9yPgYdKJE03QyBIfPXGyfE6mj+cVMv5Pn0ii+tLXE62rOsxS74nH8ZlHF+qcCgq9lKatqt6iz3n8WK/OtLmZMgvyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtlYM9xx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761668245; x=1793204245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lxjr5Dfqh+HsIWxl2K+uSN5Xb1p0yuGfm7nyLQtccWI=;
  b=XtlYM9xxVrVdKgE08PMH8ijGrQUWmk6MhH81nvQaq+8TpA79TbHlnWxd
   eVyb6lDyfxVLRYbhuSIEpiq7+L8G/u8bCwlsAcuPQWm93Bx6BCbRm0LV4
   q2ffbdEnX8BolNjh2UUjaSvtOIif22a+M86TgAE2+FPqQDEVbGKU0GVQb
   kNw0XesZuXOG+DKyGJtvTJuky0+KJtLjCaZsjN/VEFsNIEL+qhdo/Jy/G
   lJwaaSsgT0Qk3srmEkdDNhQ5b88UuDLeS3RN1cK6BZQWy8e5mrWJjOX5h
   sgn8oNbxvEezt9v1nfbEe/Tat28cQ8pSDtS0R09H8nkHw87HZi6WtFuer
   Q==;
X-CSE-ConnectionGUID: ggRRfz+gR3yx0f0SWDllgg==
X-CSE-MsgGUID: cxBkHPjbSsa0OnbCddNepQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67638218"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="67638218"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:17:25 -0700
X-CSE-ConnectionGUID: 4cWV9rFWSGWMze5ykJIAEg==
X-CSE-MsgGUID: WRl6oZE7TpyaPhkBqgndMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185088933"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:17:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 09:17:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 09:17:24 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 09:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyQxrE4ulwF7GgE/gOnW5OzchQhlvYpnIQ0gZjhg7somwgGnS/5PguZJe41reBDSuKvi4DxdCb15PwlzMBa0BqYYwTljbC40r47kufoE3L6+uE8KjG5yDjpfhR/kqUPtuBSNxygwuhR1bZCLGPNOENfWIavvbHhPewjFosJ4hsFHD7S/LBb6zG0oJ2IZcLC2hqqAQx97IcvVJaUYg70InMg5ZDLrsGCSx9qMY0qS7bPks1W4ExUiacfmqYhxPFa47bn8cAk7BOcmUlOyMmqFuoBCrCL188qUwDuAm5pM3Atlgbly71HIc4r6HHOzF/4nA5F7byjTrSknNvthBybETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxjr5Dfqh+HsIWxl2K+uSN5Xb1p0yuGfm7nyLQtccWI=;
 b=lm2rygVhHiOxQU8woD5pk011C5jzD3N/bf1Ufi5KHLLPnvpeyk+wdjnAWnhwTLDfu3QhIcLCFG8XimLPKdMLUX8M3jz4tw2IbzvQd+VvcPbVjYcdEPT3lpu3pqDlUKFqak8hqZlVWC1eCR3uXZNIaBBiULzZ6lI0T7PDDFGAlcIlj4vKkp9UNJBD6KOxTNtq1wkdxWlUkim3mVs9mp3gP80IAaRu+BXTXiIgaCW+le84JK5eGxAY6jYVpzgcKbkHFZcmM1Om7b5l5ou3MdsB1hxIWHsGcMCwmjod3wVIi5v5uA01BGKLHCbC3ciXHhmjcoYTdJXj6LFoZSGol5594A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:17:16 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::154a:b33e:71c0:2308%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:17:16 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Topic: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
Thread-Index: AQHcQ4qFb238oYUyRkqTePQ6oSATZLTOlUuAgAhu5WCAAL2ugIAAAn/A
Date: Tue, 28 Oct 2025 16:17:16 +0000
Message-ID: <LV3PR11MB8768493CE39946A6F59EF7AFF5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com>
 <aPk3URcrjx_KjkJ7@agluck-desk3>
 <LV3PR11MB87685DB538FDC1B2AA8F6BA0F5FDA@LV3PR11MB8768.namprd11.prod.outlook.com>
 <SJ1PR11MB6083F8600D6697A636C765E7FCFDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083F8600D6697A636C765E7FCFDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|CH3PR11MB8749:EE_
x-ms-office365-filtering-correlation-id: 5455cee4-e423-450c-213f-08de163d760d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Zms3T1RyZXlORjNGMXVQSUFac0VLL1dyL0Nta3VMOXVpU1Q4cGNHWnRIOTZH?=
 =?utf-8?B?WW1RNTNKeUk3aURPUjFiZnMrcmc2d3EzK3BnWTR0RjIwbkh0RmVkUS9uRmVy?=
 =?utf-8?B?ZTRZMDRkaUlEM29xQ05oMU5zVERMMUpuZEZSa3lGUkloRTJjMUMvRmhubmE4?=
 =?utf-8?B?Q1JpNlBHTG5NOUFhRXU2ekpmLzQwZTllZzdzUng3L21jdDZIaTk4L3ZOUEF0?=
 =?utf-8?B?Vi9wSG9hMkFDMVMzQUptWjlTT1hONDdscEpJcHZ3V3BoSkhFTUY3QnM0MzNl?=
 =?utf-8?B?Q1crbmlDY3JtVlY3NU9rQjd5Ny9lRXgrcExTVWgreUNtaSsrUzlabVR2V3dJ?=
 =?utf-8?B?cXhFVW8wclBlNTBaTXZUbUZ4YzM2YklDT2tjdzd0enBPZ2FlcGhEMHlGb2VW?=
 =?utf-8?B?Y1hJcUpMYitLemFTdVpOTzl5NTFqUWxMWUdBZmZZNmRQNy9HRGVxOUV1MzBS?=
 =?utf-8?B?Z0tncDlOOGV3dXAvazFtbC9MQmp3M2JvNHAzNndvWEhOSW1XSGJwZkNzZFNw?=
 =?utf-8?B?UUpRSmVTdmp0ZHl0eWkydDFSYmxVRVVQT3B5QjFXMEhlVEw0SzlYWHJ1UlJu?=
 =?utf-8?B?QS9ydnprR2ttVzd0QXhKSXhBTzhmQ044UlVibUlBUFhtYUlEcWVYVGNqWVpk?=
 =?utf-8?B?TXBYcGVCdjNRWkxKL2JnOHY4cUxENzQ2MzFzd1FwYVNiUGduVFo0cFRBMkJs?=
 =?utf-8?B?SlNlSVBFeVdEWGlPbG9rRUNRTFFCanVHZnFCd0Y1QnE5NUdVTWcrZ2duaHR3?=
 =?utf-8?B?Sm01QU5lOHhlc0VmQkQxUjljbm9obmxRZVZxZ3VLcFhPZjlGTTlpZFVVM2Zm?=
 =?utf-8?B?Mk9QbEFQajhBeCswUnJBNTRMaURUT1V6WHpuSVRxWFJmOXNvYTlpLzFOeXJR?=
 =?utf-8?B?SWFLQTVnZExYMVJVbEtuZDMzcEM3SGJBc3NDZzJHNlV4Y2UxUkUyWDVQQnE3?=
 =?utf-8?B?WDh1ZG9WWFlPL2NIRldtT2FiZ3l3TFZ3MHAxcWZKZG1SVjhIUEo1TThDL2pD?=
 =?utf-8?B?TkhGVXRKUE9BWE9uUkRWbFJRR3V5eXYyM2JXcmV6eHdiRnMzL3UvNVovdXIv?=
 =?utf-8?B?OE8yT1pSMHM2TEV4NkFDUTZYbnVhWklmSm8rc3A1bkQzUHNXOWN0TDFDdzNU?=
 =?utf-8?B?SzV0b2pjbE1wRlhLMXZ1YlVOeFZ0M1d1WEN5c2UxOVFTSVdKcFVqUCtDcXZD?=
 =?utf-8?B?Yk1lYnhWMDhiZzB3S1haUVRuOWg2M3FycHNUOGh4MnhnV1FvZ3RLZCtMS3dT?=
 =?utf-8?B?cFJ0RmpzcU0wSVBoSGkrRDFjYjc3TDlydDVjQk85dVpnRGtQTXVVYkxQYTdS?=
 =?utf-8?B?ZjJQL0tJUlNlNU52K2JieVlnS2c2bzlFQlpQSWQyVXIyQlV1dEtJamtyY2ZN?=
 =?utf-8?B?eXpZV0VHNXQ4VC9SbDdrMFBQcmFuOEp0MDRrUVY1bFhSTWVEUlV2SHJEM05W?=
 =?utf-8?B?cWZxakdZaGVlb3QweDM1NWxRdWFtdFFXVHplM1BFRDUzVHpPdXVzNU5nemtz?=
 =?utf-8?B?NzRZQkowckJmZnZ0c09FVUpEZ3hkZ3ZqYzdybC8xZ3UzT1BEOWpiUHZDYjNz?=
 =?utf-8?B?RC9kK2s4MnlBTE1vSHhCV1JlZWNIaVJGUTVQR28zU3BGWEhSb2FBN2NBRjdK?=
 =?utf-8?B?ZUdjcDdsRVpjQjg2NllzQkZJTkoyRFJISmxHMkJQbWROVVdEakVLUkpza2lP?=
 =?utf-8?B?aFlvUDhKOWo1WkpPK0hGaFRlQ0hOQ3hOaTJvS0QvSEJJa1M3OTZvQ2VPbGEr?=
 =?utf-8?B?aGNRNDk0WWlzQ3lERm1QSlQ0NFJJSVlWczJiN1Z2UzNlUzdhTlhCdHdsSXFv?=
 =?utf-8?B?QlVtMWl3a24xOXl2MEdXbDQ0c1dlbTdCWW1YNmVsYkZEa2Q2Nm5TM09iSEdz?=
 =?utf-8?B?eHo0VVZDTDlLN0ljWVVDbWNFcjl3SmgzcUtuem5mdWx5cWJDWFpyZy9MVldq?=
 =?utf-8?B?amNqM1hWNG82dWdxOWI1UUVMZWJIMzZtTTBGekh3WVd5OWdzL0lCczB0bE5O?=
 =?utf-8?B?MlRSSjEwdDQxNVcwSzJ3cDFmWlA3TGdtWno3RjRBdzhmRzVBVFp0R2orV3ZQ?=
 =?utf-8?Q?5yfLuF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGdORTlQV2lycjE4d2s5M2grcmlsMmlGVzZJb3VmNHdqSG1SMWxRUUdaeEpT?=
 =?utf-8?B?ckRTdFFHM3ZGenpzY3NHcUsxdGNSb0t1Y0NhejIyOVhXNUFpTXlJd0hBQStK?=
 =?utf-8?B?MzhuVnZObmlnYTNYenFRZDFoUU0zYlI1OXhVbjl3RVl3Rjl3MzNjTTFITGdM?=
 =?utf-8?B?T0psREZVRXh0Um56T2FoNjM4eExtWTAxaDB3emU5N3h1REFrTDdPcERKeGpW?=
 =?utf-8?B?ZHlDSTZjSjg0K0UyaXI2SXdXclNsdjRiUWY3MTZqTitxZkx3UHdFTVExTTR6?=
 =?utf-8?B?VS83Vmx3b1dvbkg2d2ZUdERDdzdYNnhCUEZCZzJOVDZzR2l5ekdrMUlVSm9z?=
 =?utf-8?B?dlVtSVVJMXYvWXdXeDNSUm8wZ3J5a1hkN0J3RzVDd1BGSVF1WTYzTU1tQS9M?=
 =?utf-8?B?WkN3RmxsMTZSRmo5bCt5V0tDcDlZbjh2OHdoLys3K0JBL1BGT1FNRGpUdk1V?=
 =?utf-8?B?dUFrSDVvV1pqTTFaU0xtR3FTM3pDOWVNMWdLTlQ4MzlDc3dVK1JKRUZPZjZV?=
 =?utf-8?B?bGxuWXQxcUduWCt0Y2w1VlBDdlJWbkcreXNKY01kM0pNVHgvSndTaExKbExN?=
 =?utf-8?B?QTlpWGVVMzBqT2dDRld4MkFFSGVWZURlY0V4YmxDRlZCVTZ1TkpyOUNVUmc2?=
 =?utf-8?B?MGtCdUkrTHdSRXNkZFB6L0dyaVpDZ2VUZFYwbU5JMi9Vc2pGMjYwNmZiZU03?=
 =?utf-8?B?LzNyREVFZS9vdXFzcnd1Q3ZnUGpnaXBnaWZnR3ErVmttNWp0M1FXSCtLMnN0?=
 =?utf-8?B?dUZGUVdIQyt0cFM3M3Nsa3d2cVVQUUJGTzJZZzFJRjhPMjdkNUxpQ0xRSysz?=
 =?utf-8?B?Z3QyWkhPWWt1OGVKOTlCdXdyaWJFVkdhN0VxRjBhV2hkU3NvK2tkbENqRlBk?=
 =?utf-8?B?ei9SMkw2TmExQ3BxbUxOWkdCY2VXWU1obmJMVDVZakJpL0JLb3dmU0N1OUE4?=
 =?utf-8?B?MUlmRW9Ud3ovdzhWeVhUTlRlMmc2YU93a08xSmxOb1BkNVQ1MlY4OGVkaVNr?=
 =?utf-8?B?YU13WW14WFFCVnJZYzFnaEpPV054MitFcG1Fb0N0V0ZHR2N2dmllVWxtNklu?=
 =?utf-8?B?M0hIZlRJVmd4SnVOODF5MGh2d0RjejArMUMzeEdNNXFrOHE2N20vZXRib25Q?=
 =?utf-8?B?VmlTcks5aFVXeUFoaytpZU81MUN1bDYyZHpROVF1ZVErWFgyMVpmSWs2dDJL?=
 =?utf-8?B?TkdsaDZFUm4xOFBDdHV0NURML2hiKy9nMjQrY1Zpb3R0bDBOcWRwbUROdE1v?=
 =?utf-8?B?RnlBcUlWL0krSlNvS0JBVnRHYnA4c2l0THNNQVdPY2wyZXd6QTlyc3AvcGN3?=
 =?utf-8?B?ZjRCU1NIaHdYZFhCaTdObVdjSll1N0l1MEtUaHdSSS9NUVIxYzhKMnFPQ21y?=
 =?utf-8?B?anppd1oyZC85bzNlQnp4bHcxZC8yUjJZdGduZ011OVpjb2VLYWE1Unc0YzFQ?=
 =?utf-8?B?TUlhSUpQT3FoV0xDNVZEQTlzaEFzekwyQ1J2ZnJGbTJSUG5EOExkUHB1cWF2?=
 =?utf-8?B?YlFFYWZWZk1lSVVNbUpyNU9nNWozM2tPVjZESEl6dFJQL3JoRCtTWGZPWjVo?=
 =?utf-8?B?SUJLYS92bDV5RUxnMVl2Q0NkOStNbzhFTFdVb2RCRkxIS2MzNVVuamFBQW5V?=
 =?utf-8?B?R3MzZ01hTmtkdFVPVG5nMWVCQTRMUWZpelhCazJaaWZsT084U3Z2clMwS1NO?=
 =?utf-8?B?eHJYaUZYYk1oZWN4SGk0d0U5VmEyTHBCbVlIdy92bWZ5M1BTNUEwR3dBTUxR?=
 =?utf-8?B?NkcxcVVHM2M3dVJwQWhhSWdsUVhiaDJ4bWJ4UzhrWmNjN2VkODEwS2hEb1VD?=
 =?utf-8?B?Y3p4UUxyejYyZEMrd3VyeVhKT1AzNlFCcFIvdkoxQ09tZW5NUGRYN2thbHJV?=
 =?utf-8?B?US95TjM1WUVwWGJtZjFhYXdaL21ncExSQ2QrZURVU2h6RExpUmtoSHRydzdp?=
 =?utf-8?B?QVNJVGQ1dWY2bk1ud2pCbTFYeXFhdFN6QWRTYzFPMXJBN2hpNWNtOVZHcHVC?=
 =?utf-8?B?UWRrZGFGR2UxbUJITkZkbHVocXJtdEVjWTVrZ3lIWE9VNGI4N1BITjZWRyta?=
 =?utf-8?B?Qlk2T2RxUDlpYlM0Y2N6ZVhRR245SGZxVnU3dFhjUnEweldWMjFaWDlTSEpU?=
 =?utf-8?B?Zy8wSzk1SktjeFRRbkc1SFhiSWpkT0dxZThGUU1LUlAwbDlWZ3k4dUhJRmFa?=
 =?utf-8?B?ZFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5455cee4-e423-450c-213f-08de163d760d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 16:17:16.2376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHklYYreQ40MQVh0bnNNo4pxQTTZz4gb9a8+QXkDmSDIL7pwY8GzCRN1pN75cWgA6nfzVFQKJgLsRVfeAHNEs204DRz/3t36lFHog5ie8Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com

T24gV2VkLCBPY3QgMjIsIDIwMjUgYXQgMDk6MzE6MjlQTSArMDIwMCwgVG9ueSBMdWNrIHdyb3Rl
Og0KPiBXaHk/ICBJJ2xsIG5vdGUgdGhhdCB0aGUgY2xlYW51cCBjb2RlIHlvdSBhZGRlZCB1c2Vz
IGEgbG9jYWwgYnVmZmVyICJjaGFyIGNsZWFudXBfbmFtZVszMl07Ig0KPiB0byBob2xkIGZpbGVu
YW1lcyAodGhvdWdoIG5vdyB0aGF0IEkgbG9vayBiYWNrIGF0IHRoZSBwYXRjaCwgdGhhdCBzdHJp
bmcgaXNuJ3QgYWN0dWFsbHkgdXNlZCEpDQoNCkdvdCBpdC4gIExvb2tpbmcgYXQgdGhlIGNsZWFu
dXAgY29kZSBhZ2FpbiwgDQpJIHNlZSB0aGUgaW5jb25zaXN0ZW5jeSAtIEknbSB1c2luZyBhIGxv
Y2FsIGJ1ZmZlciB0aGVyZSBidXQga2FzcHJpbnRmKCkgDQppbiB0aGUgbWFpbiBsb29wLg0KDQpJ
IHdpbGwgdXNlIGEgbG9jYWwgYnVmZmVyIGFwcHJvYWNoLg0KICAgIA0KQWxzbyB0aGFua3MgZm9y
IGNhdGNoaW5nIHRoZSB1bnVzZWQgY2xlYW51cF9uYW1lIHZhcmlhYmxlIC0gSSdsbCBmaXggdGhh
dCANCmluIHRoZSBjbGVhbnVwIGxvZ2ljIGFzIHdlbGwuDQoNCkknbGwgc2VuZCBhIHYyIHdpdGgg
dGhlc2UgaW1wcm92ZW1lbnRzLg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQo=

