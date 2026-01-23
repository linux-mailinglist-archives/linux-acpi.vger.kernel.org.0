Return-Path: <linux-acpi+bounces-20582-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFbrBK9Cc2mWtwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20582-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 10:43:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFEA738F3
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED14E30054D1
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D62363C74;
	Fri, 23 Jan 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npNxvWPQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206982E7161;
	Fri, 23 Jan 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161387; cv=fail; b=gQjhkmVo07slnIsDFBCnAzz2qvpRL4LmA/Vz2IRgV3TVWrMitc+o61cEAacu4KXkAyJthXmosf4ZAAiOQrxPOEw1rZgUlzXuWPn8GCVKLbL72T950ZPWXOP+hM/2GSy71B+yFiq2sayDcQpFadYSEkWzsLu6Qdm9alYjh0ESJD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161387; c=relaxed/simple;
	bh=JiJG1LBtRvKhZpIaOkPEpHgmfgVQeCk771X7kL+C/Zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b4U4zpTd4mK7/6KHMKLm1QB5A7gt9tmRwPH2CcwVWNV/VI+fomXEkw10veRdZLpNZ9veTs8TFX2V7zsYQmnTzsPn27dvkdY7sbr5jFGz2v8Tqthsx9GjcCU70s69egwmzXbTtRoGfXEz4+LsAFr8PSSuAZiRVibUJdCTxWQ9Eg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npNxvWPQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769161378; x=1800697378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JiJG1LBtRvKhZpIaOkPEpHgmfgVQeCk771X7kL+C/Zg=;
  b=npNxvWPQoNwTJn8d8Nh74ImXMvOYQMfQDuEU5QEtlZ6tTbSAzVBpiORV
   MSb1z6OMXtssjlne37b+sGBPh6s8QvV7MvQ5NYikBztd/g7I6Wm0QzrbL
   558F1sdAzCEVkSfYv7RkolHP2Djbg4krJIogGsqhosKPDVYUpnUvkQ644
   iRyWHTvAaKPDdzZjYk+WBCcEn8hzYXg9tM8j6PDJMfkSxhrTMgOGs9rYg
   k/LU83K31uxt0A9lOX4zZj6cnfN5lE4RQYFyXPBiBEzkl5ySMeNc//JNx
   yq6GVd72vVGDDxpw/tn88L3+9RWiaSb7mQLw92Mhgb6yHlLbf8wiG9for
   A==;
X-CSE-ConnectionGUID: UPKp83o1T7SXlvI5obts1Q==
X-CSE-MsgGUID: AR2co5vRR8Gi+yVSI1QXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70502232"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70502232"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 01:42:50 -0800
X-CSE-ConnectionGUID: R3+pfXKoSGK1qnZ7Ey4VAw==
X-CSE-MsgGUID: TtOzlokdTMeqQ1SI3XtboA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207406334"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 01:42:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:42:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 01:42:48 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:42:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCbVIrHlwjD19PUYWxSOKdmMfP5JPpbmhLrejQzNhPH1V8BxaxGnnuM7rPc2cVONm+FGNV/PYoqFYbpJiDAYyF8NXEyBmgdS0fp6AAh8irim4QRJvY/DzYLNOopb+9IMIP1oSAWQRwr/hywY3s+FvI2O9i9eaaIA/7gKEA1XGz64jog1R/DNh9yW9HqpQkVKaNL7SCpDEZOKesWxFRZnSSlTkrXx8aaZ+3uMSY0eTe/L/RtRWqzfg4l4WJy1TIxChLHFcIQp9NzCujOhQqwAKVAY83UZji4zilve5F7p4/Me0awfWelSa6L1YfZiRbTrkMHUoFjesZgApOjQ3KpZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiJG1LBtRvKhZpIaOkPEpHgmfgVQeCk771X7kL+C/Zg=;
 b=h1g7DxEkgphyJUvCg2B606vhxecjxXHpiFH5VdDM7BxHvlny2wmLBtdx2wVgaPpyirq7rfB/B7ndKhFF8HpihQ0Q5KhWIHZUS96J2D+A1b0uVdGAUHGNveLbVo1pO2gMLNpLl6voaTHl0uALrRFqzeq5WZAtOUIwCbsroDLDao96tSqubi8RptHKnbrzQAhmWZmvjAntKzxSpY23zyFOuKw+dAuC9YkeThi7EaKdvR+RO6WE2kANfqmNGyeLTMiEHg1AzcdyX3z3by3+LZfCSX+xYE6PaSXRogQ0CvcSFO+0kEt7pKYgt1ENi4L3qvb+9Gr36CYhRyzhjq22/UrA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by IA3PR11MB9157.namprd11.prod.outlook.com (2603:10b6:208:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 09:42:43 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb%7]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 09:42:40 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Vecera, Ivan"
	<ivecera@redhat.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linusw@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown
	<broonie@kernel.org>, Jan Aleszczyk <jaleszcz@redhat.com>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "Oros, Petr" <poros@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Thread-Topic: [Proposal,Question - refresh] ACPI representation of
 DPLL/Ethernet dependencies (SyncE)
Thread-Index: AQHciuRMXdppmxl7w0K0a+9YJGfBkbVefU4AgAD+2WA=
Date: Fri, 23 Jan 2026 09:42:39 +0000
Message-ID: <LV4PR11MB949103AF447595598F0D06789B94A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <6e4e40b8-b3cb-4892-8d37-d450a02e4c52@redhat.com>
 <CAJZ5v0gL3MzhyS2SOELsgztdakFU984UB+TKaMA13kd+7ssj_Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gL3MzhyS2SOELsgztdakFU984UB+TKaMA13kd+7ssj_Q@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|IA3PR11MB9157:EE_
x-ms-office365-filtering-correlation-id: 7f7e5c6b-ca6d-45b0-bb2b-08de5a63bfd4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|3613699012|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bDVXZjY4d2Z2RC8xeUtnU2pUY2xxQ3U2TGR6UDZvQUVzMHoyMzR2enZFSDk0?=
 =?utf-8?B?WllIWlBsY1pIa1JUdmhqamM2ODBvY0ZPVXJMVU12bmN1QXRsQUJOZ1lqNkJK?=
 =?utf-8?B?TDA3MG9jM0hscm9qSk92czBkeVZSYVNxNjFxOVJISzNzRTRLYXErZEhRMFdG?=
 =?utf-8?B?eCsyMnBlMy9hdGR1d2RtUU9JZmRDWC9HSzFuRkxGVDZTZ0Nvc2tFU1gzVWRG?=
 =?utf-8?B?WVZoS2Vjd0grT0pWTVhNMHo5VlQzU0dEb29wQ0NHNUxTU2p4RG9DNks2Ymx1?=
 =?utf-8?B?S1dJWFJDRStEVkhFaXNEOHJObXRScWErb0VpQVJVSlFCblcrRGNsb3Ryb0Vq?=
 =?utf-8?B?TTQvSitvaWdHUmw3djIxOGxvQUJ4Vk9seGdadFArTUdUV0JRbkdvdjhWYTFI?=
 =?utf-8?B?dmJJT2ZYQkZ5dkVFOUNGNCtWVWlNM2ptc2NmMzNCZnQ0NEQ3dkZ0ZGRHTFpo?=
 =?utf-8?B?a0hadHh1ZlNPVHlOVVFEQ3FqNzNUeFFnYnVYOUF6NXJxSGs4ZVZKaGk0ZFRx?=
 =?utf-8?B?WjV0RERXY3dqazZuZ251Z1ZqYWZFQUFQUVJMdVBQblRZZkNITmgvMi9mWThH?=
 =?utf-8?B?RitzUjVLQ3JwL090MTUveG9XQ3YwUlRELzZDWFNTSHNmTlBjRXoyamQ4K3Ro?=
 =?utf-8?B?djZYL05HWS9LelMrbGNvS1AzS3NPcFZUVU1kd21UWTR6STNMUEhIRUoxT1Zp?=
 =?utf-8?B?RUk1TnA4NmtEUDVoS0hUa3U2Z2dxMmlnelllZk16ZEpFRnoyNVJ3VjVPeHJZ?=
 =?utf-8?B?eFlnMlZuTjFiaDA3U0I0bm5zN1U4TUNmOVVrWEYyeGZpT1hlcFR2aWdIRjRT?=
 =?utf-8?B?YXhCZnk5TXpHcExRaG43eVU2d2ZqZkI3OEdKT1Q1RzF2UmdjNGVLRE1CWVJt?=
 =?utf-8?B?SDlpdTF5bjIrY0VQZWhIa3J2QkY5L0ZEMFZpdjJjMk9kYktybDVWdkZuTEJq?=
 =?utf-8?B?Z1ZrZGlpbDhDOTJlcjVBbytNZ0hyOHM4RnA2UGNWYVRvTENUNFVzUFFDSkxU?=
 =?utf-8?B?WjhONEIySHQ2aEVJaHg3anU2bFNRS3RtblE4Yjc4VVJVOFd4eForUHVXZ0hP?=
 =?utf-8?B?R0lYM1ZBaTBqaU9kQ2FpdW5lK0pNUThnaUQ4WlBOaGVKZ1ZuVlNmQUZPN290?=
 =?utf-8?B?c1QrNXc4S2Y4NnNqWGsrVUd1bXJkbVo4MlVuU1ZYVTE4TDB3N0kyeEx6SkQz?=
 =?utf-8?B?RzVqYm1ZY1p4UUR0Tmh1RXF2Z3owVFVJSFVCRnluMytTLzErbmlGd2hMdVhH?=
 =?utf-8?B?ZWFrZFJqU0hNWXRMQVkybTRReWxONHUrc29QOVYrMzEwbnBDbmFhYk90TDAv?=
 =?utf-8?B?czdTZHN0cTQ5TnN3V29ub3hKL1o0TXpuODdYUzB4LzY4bjdjWE1wRXd2S1N5?=
 =?utf-8?B?OXl1YVBDcVFvZTVsUC9yNXg4U2VzV2t2K3UwMmZTTkFwZmpJS0FwSFhpemRN?=
 =?utf-8?B?ZzNOTndiUmFwUVF2ZTdFTWV1ZkpXMS9QRzBnbW5uMkkydHM2SXpucFFDekVZ?=
 =?utf-8?B?VWRqT2pKNTJCbW5MNmFnKzlnR1Vkb1NIVG04eWVIZmo3Y1RIMGxHUEF4Vkdh?=
 =?utf-8?B?aVc3QVB0MnR5aUIySEVWdjIxaU9sTXlsUEUxVHA2RFZGMWREcmJIcVNCaHI4?=
 =?utf-8?B?Wjg3c1ZpVmJkNUx6U0pGQlVBMk9tMDNsd0daTkh6bkp4THBkM1BseWlsOXdV?=
 =?utf-8?B?ci82VlJsZ0cxbFNUbkNTeDlZY1dkdHloMzFuMWRJTnl1UWpCbXgvUkhhWWdt?=
 =?utf-8?B?Qzh1diswV3R0TUlkNXFYZ2JHVmg2NldlOFpRSk5sR1VSTjdXUC84SUJEWktp?=
 =?utf-8?B?NzdvRHZSZlB3U00veTVraTY0dWJKQVo5eU9sdlVZVU1xeXVZUm1nUXFHUmJW?=
 =?utf-8?B?aWQ2MDRTQ3FRZlQ2SUI2bGlyTnN4RHF5SDdqSWlQdlljcTgrOElWSWZuQi9N?=
 =?utf-8?B?K2lVZ29JTFlSTk13dzJiWGtjZyttSy9ObU84TkZDOUlKK0NNRm84MjVRZ25W?=
 =?utf-8?B?VTF1TFpKc0N2WmQzclBnTWh2VXBzekJKYkh2ZG03YWl2b05GVy9ldGlyM2lJ?=
 =?utf-8?B?TlY0ams2SFpPWmFHS2ZhRDZJeDY0eFpLUy9iMmNoa01yUjlVeDVBQkJrRVhx?=
 =?utf-8?B?elhlZTF4QWZCYWg2a0RXMkV5dXFySnVCWWIzbVpwS2ZuOTl5ZVRoSmM0QmZl?=
 =?utf-8?B?WUhsTHNpRVZDbVZORXlGYldZcEVqOW44KzFGZWduV1J1b2pDMTV0VzBQdTY0?=
 =?utf-8?B?YnY0RURpalhvSUpiLzBSV3YvOC9RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(3613699012)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZOQ3FYOXZ5dUdpQm10MndJY3MrTEtiRWxrTlh6dGZBclp1eGJkY2JqMzZG?=
 =?utf-8?B?QmxkTjAwdlp6Zk1Zc1ArYTg5QjdSM2JTY2xGakNNdk93QWF3QTFoRUNRbHdz?=
 =?utf-8?B?V05zdXBwbGlMNnIrY2NjeE8vMURnYmVKT0xhdGNYUTBUN0xKUFczUTh1dmlO?=
 =?utf-8?B?MkpaeEE2SHdzaC8ySm5uMUNmV2NjMmdnTVZaMW8vTkdINW42RGM3bUVueWJy?=
 =?utf-8?B?akFtV3k0ZUhQRHZwaTFzTHFmRmdNUnd4aDlVdlgydkRWZDdhaTZ2ZTVZbzU4?=
 =?utf-8?B?T0NzNG13ZUxiVFIrUXQ1dUVTb3loa1RXbGRkM0JxK1NtOStNczBjdDlJRUcx?=
 =?utf-8?B?azlmaE9KRUNvZCtqeWN5MStCRUdlaENtUjhHOUxQNUdwVDVpZmRyZlFka2lY?=
 =?utf-8?B?cWNSdkMzQnFraHdzZUNFRU45RjBPVGVCV21rdEhvYTNtOFdDc3hXV0JKN0pW?=
 =?utf-8?B?dFRBYUNYK0swcDVIK29FUnZoRHRpVFQrVjVwM3lWcXhDMThua0dOY25INnI0?=
 =?utf-8?B?WlRKRDREV2F6TmRoS3gyNUhYMkg5REJRd05LOU9tV0c0TW1MQ0MyZlM0cHhT?=
 =?utf-8?B?TDRBT2EweHZpSE9CZkJ0QldCQmNmSlVYMVdMQ1htWDZYUW9jQWtSNVNxWW81?=
 =?utf-8?B?SGt4TEM0eHJGMmtwaWlaTTVhTjQyaUtTdjNSNWQvU2xmeisrMlJudi94Z013?=
 =?utf-8?B?NjNlalNrOVpvZjd4UWZBQnBrRm1kbVFPQWloSDdqTGdCWHNKM2Q1VEpDU2ZE?=
 =?utf-8?B?SllOd1lseURuc1BrNzU0TTM0M2FlSXFWUHQwUXliOXk2TFVuTzQxck11dlBk?=
 =?utf-8?B?anVpVVc0MHYxRWt4SEJLSnUyY2Z4WUpwTXdkeDY4RGFiMlEyWjYvd3lJVmM5?=
 =?utf-8?B?anRxekdCRWJHNkxQaVhPc0Zld1VxVUszclNHeU11eVcyZW5oaEdWT09ZU2dy?=
 =?utf-8?B?cGplc2VRY0M2Z2hEQnF0eG45Mm1Pa2pmbFdwNkdLR1Z2RUNtb1U3cFFMRCtj?=
 =?utf-8?B?UytjMkNGSGtxcUE4SkZvMCs4YTMyTVdZam5lZTZ2Qzg5cjcrOUlQWmY1SEVM?=
 =?utf-8?B?anpxRytkMWlwa216MktvaTRDMU43TTlOK3ZuSTRvRHQwQ2MzYS9hbWpWaDhk?=
 =?utf-8?B?TkUrVUQzbVIxWEFBaUp1RVdSMGhWb0JRN0dVTHRJOEIxcVFiekIxWFVtNjcw?=
 =?utf-8?B?blg4KzFXYVdSQi9ZOGhTQWlDWkJrUFdZbElPZDZnQzlJV3d0RFlmUXdYTWQ3?=
 =?utf-8?B?aE8rVHY3OERGZVhEQVdiVUl4a0ZvL3E4cTBhRHhBSG9EbE1tenR0K2I5Y21T?=
 =?utf-8?B?Ym9ybkk1b2xpbnNNNWhRdVN2VjdXTWpjczc3SVJBQVY3ZFNZTWJEQTVwN2RK?=
 =?utf-8?B?dE43Ly9RQlFBZFQwU2grQ2t3U2ErVlF6VTBLb1JEcW12TU5vWHZucVlZOEtp?=
 =?utf-8?B?Y2JOV0Y0L1VXUWhJNVBpM01mdjhJakVFdDlhQmFBanZFY0FKNjU2cDlkK3Ey?=
 =?utf-8?B?ZFpTWnFTKzhuYkduK1d2WWNzZVYzUUVZNGNqS0tOdHplMUtGRWJ5dlFoY2ZX?=
 =?utf-8?B?N1cvRVo5TUh4dktXVmZUWjZsRzh4Mm1Bd1BOaytPb204dStUSEE0aTZLcXdV?=
 =?utf-8?B?bkpBdGFyZGUzVFkrVHpOOURwOEd4bXYvZW5FcFhPRjVNamhwSWFsZFU2bHVN?=
 =?utf-8?B?dFRuczQzMmNZcGpqS3c1SXA2dE41dktJOElXYjk1cTJvWVkxUExXTUJ6ek4y?=
 =?utf-8?B?WW9UQk1qZ2pSTnNHMllKVVpkOTFJVVBCL2Y0bUI4NmthSW9nS2FobVo0b1No?=
 =?utf-8?B?TE9mMHlRc2tSWFpwMGhNeitxNzBuZWpKM0RLZlNWdUgzdkZ2L3VyZEFzWGVG?=
 =?utf-8?B?bEZTYjhvTkRhdFZmUmtTaFhLWVE4Um9QdWt3djZiOWZiTVN6TCsrbGJkcE40?=
 =?utf-8?B?dEhXT0lPenpaOGJuaFFVWDEwSTBFbWVwdmVMc0Nja3grUzViZmdCWmtuK0JT?=
 =?utf-8?B?TU1BVnhGVHczYjJlbEsrNVJGKzN1WGNVRnJSMzJPN1FhKzdteGEvNTAvU2hv?=
 =?utf-8?B?ZWxMb1dSZm5DSFVFelNmZTg3bU9kVUF5U0ZPV2VaWldCNjZINEQxd0R6ZmR1?=
 =?utf-8?B?VVRvYjJZV05VY2c0Uys4WVFqbjBuUk5BYmlLMU9rRjNiVlM2MGRlSzFVbmFz?=
 =?utf-8?B?MnFzMVFCaEEzRzg2YVZiS0NUVVBOT0tST0tQRHhSNGo5MU80Tk5VbFY5Um1J?=
 =?utf-8?B?NXJBa1p2T0xTdDJ6aXphbFc3bXAvUHRYM3YyWVVtclJLMStubk42NzFFRS9X?=
 =?utf-8?B?VmdtNXpuWTF6T0I0cXVSNmV2UzJEN1BBOHhxcFZXVExKZFdYZkZRUmdoblB1?=
 =?utf-8?Q?3H/IQQK9t9beux60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7e5c6b-ca6d-45b0-bb2b-08de5a63bfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 09:42:39.9298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqwfE2SMgFudLSkDW0mE5XnfJ+WQeL+C0N6e698cP4cYtgAtxu7oV843JNeZn/1I0bMFKG6veFeZBp3S/a7Z0NXe9ZqVh+Z1QfaUKGKed/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9157
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20582-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,LV4PR11MB9491.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8EFEA738F3
X-Rspamd-Action: no action

PkZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj5TZW50OiBUaHVy
c2RheSwgSmFudWFyeSAyMiwgMjAyNiA3OjA0IFBNDQo+DQo+SGksDQo+DQo+T24gV2VkLCBKYW4g
MjEsIDIwMjYgYXQgMzo0M+KAr1BNIEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+IHdy
b3RlOg0KPj4NCj4+IEhpIEFuZHksIFJhZmFlbCBhbmQgb3RoZXJzLA0KPj4NCj4+IChiYXNlZCBv
biB0aGUgcHJldmlvdXMgdGhyZWFkIFsxXSAtIG5vdyBpbnZvbHZpbmcgbW9yZSBwZW9wbGUgZnJv
bQ0KPj4gICBuZXR3b3JraW5nIGFuZCBEUExMKQ0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgdGhlIGlu
c2lnaHRzIG9uIF9DUlMgYW5kIENsb2NrSW5wdXQuDQo+Pg0KPj4gSSB0aGluayB3ZSBoYXZlIGNp
cmNsZWQgdGhlIGlzc3VlIGVub3VnaCB0byBpZGVudGlmeSB0aGUgY29yZQ0KPj4gZGlzY29ubmVj
dDoNCj4+ICogV2hpbGUgdGhlIHBoeXNpY2FsIHNpZ25hbHMgb24gdGhlc2Ugd2lyZXMgYXJlIGlu
ZGVlZCBjbG9ja3MgKDEwTUh6LA0KPj4gICAgZXRjLiksIGZyb20gdGhlIE9TIGRyaXZlciBwZXJz
cGVjdGl2ZSwgdGhpcyBpcyBub3QgYSAiQ2xvY2sgUmVzb3VyY2UiDQo+PiAgICBpc3N1ZS4gVGhl
IE5JQyBkcml2ZXIgZG9lcyBub3QgbmVlZCB0byBnYXRlLCByYXRlLXNldCwgb3IgcG93ZXItDQo+
PiBtYW5hZ2UNCj4+ICAgIHRoZXNlIGNsb2NrcyAod2hpY2ggaXMgd2hhdCBfQ1JTL0Nsb2NrSW5w
dXQgaW1wbGllcykuDQo+PiAqIEluc3RlYWQsIHRoZSBOSUMgZHJpdmVyIHNpbXBseSBuZWVkcyBh
IFRvcG9sb2d5IE1hcC4gSXQgbmVlZHMgdG8ga25vdzoNCj4+ICAgICJNeSBQb3J0IDAgKENvbnN1
bWVyKSBpcyBwaHlzaWNhbGx5IHdpcmVkIHRvIERQTEwgUGluIDMgKFByb3ZpZGVyKS4iDQo+Pg0K
Pj4gVGhlIE5JQyBkcml2ZXIgbmVlZHMgdGhpcyBQaW4gSW5kZXggKDMpIHNwZWNpZmljYWxseSB0
byByZXBvcnQgaXQgdmlhDQo+PiB0aGUgUnROZXRsaW5rLiBUaGlzIGFsbG93cyB0aGUgdXNlcnNw
YWNlIGRhZW1vbiAoZS5nLiwgc3luY2U0bCBvcg0KPj4gbGludXgtcHRwKSB0byBzZWUgdGhlIHJl
bGF0aW9uc2hpcCBhbmQgZGVjaWRlIHRvIGNvbmZpZ3VyZSB0aGUgRFBMTA0KPj4gdmlhIHRoZSBE
UExMIE5ldGxpbmsgQVBJIHRvIGxvY2sgb250byB0aGF0IHNwZWNpZmljIGlucHV0Lg0KPj4NCj4+
IEEgZ2VuZXJpYyBDbG9ja0lucHV0IHJlc291cmNlIGluIF9DUlMgaXMgYW5vbnltb3VzIGFuZCB1
bm9yZGVyZWQuIFRoZQ0KPj4gT1MgYWJzdHJhY3RzIGl0IGludG8gYSBoYW5kbGUsIGJ1dCBpdCBm
YWlscyB0byBjb252ZXkgdGhlIHNwZWNpZmljIHBpbg0KPj4gaW5kZXggcmVxdWlyZWQgZm9yIHRo
aXMgdXNlcnNwYWNlIHJlcG9ydGluZy4NCj4+DQo+PiBTaW5jZSBBQ1BJIGxhY2tzIGEgbmF0aXZl
ICJHcmFwaC9Ub3BvbG9neSIgb2JqZWN0IGZvciBpbnRlci1kZXZpY2UNCj4+IGRlcGVuZGVuY2ll
cyBvZiB0aGlzIG5hdHVyZSwgYW5kIF9DUlMgb2JzY3VyZXMgdGhlIGluZGV4IGluZm9ybWF0aW9u
DQo+PiByZXF1aXJlZCBieSB1c2Vyc3BhY2UsIEkgcHJvcG9zZSB3ZSB0cmVhdCBfRFNEIHByb3Bl
cnRpZXMgYXMgdGhlDQo+PiBkZS1mYWN0byBzdGFuZGFyZCBbMl0gZm9yIG1vZGVsaW5nIFN5bmNF
IHRvcG9sb2d5IGluIEFDUEkuDQo+DQo+SWYgeW91IHdhbnQgdG8gY2FsbCBzb21ldGhpbmcgYSAi
c3RhbmRhcmQiLCBlc3BlY2lhbGx5IGlmIGl0IGludm9sdmVzDQo+QUNQSSwgaXQgaXMgZ2VuZXJh
bGx5IG5vdCBzdWZmaWNpZW50IHRvIHRhbGsgdG8gTGludXgga2VybmVsIHBlb3BsZSBvbmx5DQo+
YWJvdXQgaXQuDQo+DQo+QUNQSSBpcyBhYm91dCBhZ3JlZW1lbnRzIGJldHdlZW4gbXVsdGlwbGUg
cGFydGllcywgaW5jbHVkaW5nIG11bHRpcGxlIE9TDQo+cHJvdmlkZXJzIChMaW51eCBiZWluZyBq
dXN0IG9uZSBvZiB0aGVtKSBhbmQgbXVsdGlwbGUgcGxhdGZvcm0gdmVuZG9ycw0KPihPRU1zKS4N
Cj4NCj5UbyBhIG1pbmltdW0sIHlvdSdkIG5lZWQgY29tbWl0bWVudCBmcm9tIGF0IGxlYXN0IG9u
ZSBwbGF0Zm9ybSB2ZW5kb3IgdG8NCj5zaGlwIHRoZSByZXF1aXNpdGUgX0RTRCBkYXRhIGluIHRo
ZWlyIHBsYXRmb3JtIGZpcm13YXJlLg0KPg0KPj4gVG8gYXZvaWQgdGhlIGNvbmZ1c2lvbiBBbmR5
IG1lbnRpb25lZCByZWdhcmRpbmcgIkNsb2NrIEJpbmRpbmdzIiBpbg0KPj4gQUNQSSwgSSBzdWdn
ZXN0IHdlIGV4cGxpY2l0bHkgZGVmaW5lIGEgc2NoZW1hIHVzaW5nICdkcGxsLScgcHJlZml4ZWQN
Cj4+IHByb3BlcnRpZXMuIFRoaXMgZWZmZWN0aXZlbHkgZGVjb3VwbGVzIGl0IGZyb20gdGhlIENs
b2NrIHN1YnN5c3RlbQ0KPj4gZXhwZWN0YXRpb25zIGFuZCB0cmVhdHMgaXQgcHVyZWx5IGFzIGEg
d2lyaW5nIG1hcC4NCj4+DQo+PiBQcm9wb3NlZCBBQ1BJIFJlcHJlc2VudGF0aW9uIHdpdGggcHJv
cG9zZWQgZG9jdW1lbnRhdGlvbiBbM10NCj4+DQo+PiBJZiB0aGUgQUNQSSBtYWludGFpbmVycyBh
bmQgTmV0ZGV2IG1haW50YWluZXJzIGFncmVlIHRoYXQgdGhpcw0KPg0KPlNvIGxvbmcgYXMgeW91
IGRvbid0IHRyeSB0byB1cGRhdGUgdGhlIGdlbmVyYWwgQUNQSSBzdXBwb3J0IGNvZGUgaW4NCj5k
cml2ZXJzL2FjcGkvIG9yIHRoZSByZWxhdGVkIGhlYWRlciBmaWxlcywgdGhlIG1hdHRlciBpcyBi
ZXlvbmQgdGhlIHJvbGUNCj5vZiB0aGUgIkFDUEkgbWFpbnRhaW5lcnMiLg0KPg0KPlRoYXQgY29k
ZSB0aG91Z2ggaXMgYmFzZWQgb24gdGhlIEFDUEkgc3BlY2lmaWNhdGlvbiBhbmQgdGhlIHJlbGF0
ZWQNCj5zdXBwb3J0IGRvY3VtZW50YXRpb24sIG1vZHVsbyB3aGF0IGlzIGFjdHVhbGx5IHNoaXBw
aW5nIGluIHBsYXRmb3JtDQo+ZmlybXdhcmUgb24gc3lzdGVtcyBpbiB0aGUgZmllbGQsIHNvIGlm
IHlvdSB3YW50IG9yIHBsYW4gdG8gbW9kaWZ5IGl0LA0KPnRoYXQgbmVlZHMgdG8gYmUgYmFzZWQg
b24gc29tZXRoaW5nIGJleW9uZCBrZXJuZWwgZG9jdW1lbnRhdGlvbi4NCj4NCj4+IF9EU0QtYmFz
ZWQgdG9wb2xvZ3kgbWFwIGlzIHRoZSBhY2NlcHRhYmxlICJQcmFnbWF0aWMgU3RhbmRhcmQiIGZv
cg0KPj4gdGhpcyBmZWF0dXJlLCBJIHdpbGwgZG9jdW1lbnQgdGhpcyBzY2hlbWEgaW4gdGhlIGtl
cm5lbCBkb2N1bWVudGF0aW9uDQo+PiBhbmQgcHJvY2VlZCB3aXRoIHRoZSBpbXBsZW1lbnRhdGlv
bi4NCj4NCj5LZXJuZWwgZG9jdW1lbnRhdGlvbiBpcyBnZW5lcmFsbHkgaW5zdWZmaWNpZW50IGZv
ciBkZWZpbmluZyBuZXcgT1MtDQo+ZmlybXdhcmUgaW50ZXJmYWNlcyBiYXNlZCBvbiBBQ1BJIGJl
Y2F1c2UgdGhlcmUgYXJlIHBhcnRpZXMgaW52b2x2ZWQgaW4NCj5BQ1BJIGRldmVsb3BtZW50IGJl
eW9uZCB0aGUga2VybmVsIHRoYXQgbWF5IGJlIGludGVyZXN0ZWQgaW4gdGhlIGdpdmVuDQo+aW50
ZXJmYWNlIGFuZCB0aGV5IG1heSBiZSBhYmxlIHRvIHByb3ZpZGUgdXNlZnVsIGZlZWRiYWNrLg0K
Pg0KPkksIHBlcnNvbmFsbHksIGNhbm5vdCByZWFsbHkgc2F5IGhvdyB1c2VmdWwgdGhlIGludGVy
ZmFjZSB5b3UgYXJlDQo+cHJvcG9zaW5nIHdvdWxkIGJlIGFuZCB3aGF0IGl0IHdvdWxkIGJlIHVz
ZWZ1bCBmb3IuICBFdmVuIGlmIEkgbGlrZWQgaXQsDQo+dGhlcmUgc3RpbGwgd291bGQgYmUgYSBw
cm9ibGVtIG9mIGdldHRpbmcgYXQgbGVhc3Qgb25lIHBsYXRmb3JtIHZlbmRvciBvbg0KPmJvYXJk
Lg0KPg0KDQpIaSBSYWZhZWwsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQoNClllcywg
d2UgYXJlIGhlcmUsIGRvIHlvdSBuZWVkIHNvbWVvbmUvc29tZXdheSBzcGVjaWZpYyB0byBzdGVw
IHVwIGFuZA0KcHJvdmlkZSBzdWNoIHByb29mPw0KVGhlIHBhdGNoIHNlcmllcyBwcm9wb3NlZCBi
eSBJdmFuLCB3aGljaCBpcyBwYXJ0IG9mIHRoaXMgZGlzY3Vzc2lvbiBhbHNvDQpjb250YWlucyBp
bnRlbCBwYXRjaGVzLg0KDQo+PiBUaGlzIHNvbHZlcyB0aGUgaW1tZWRpYXRlIG5lZWQgZm9yIGFu
IHVwY29taW5nIEludGVsIFN5bmNFIGVuYWJsZWQNCj4+IHBsYXRmb3JtIGFuZCBwcm92aWRlcyBh
IGNvbnNpc3RlbnQgYmx1ZXByaW50IGZvciBvdGhlciB2ZW5kb3JzDQo+PiBpbXBsZW1lbnRpbmcg
U3luY0Ugb24gQUNQSS4NCj4NCj5BbmQgd2hhdCBpZiwgc2F5LCBNU0ZUIGNvbWUgdXAgd2l0aCB0
aGVpciBvd24gdmVyc2lvbiBvZiBhbiBpbnRlcmZhY2UNCj5hZGRyZXNzaW5nIHRoZSBzYW1lIHBy
b2JsZW0gc3BhY2UgaW4gdGhlIG1lYW50aW1lIGFuZCBjb252aW5jZSBwbGF0Zm9ybQ0KPnZlbmRv
cnMgdG8gc2hpcCBzdXBwb3J0IGZvciB0aGVpciB2YXJpYW50IGluc3RlYWQgb2YgeW91cnM/DQo+
DQoNCldlIGNhbiBvbmx5IGJlbGlldmUgdGhhdCBzb21lIGV4cGVydC9tYWludGFpbmVyIHdvdWxk
IGNhdGNoIGl0IGR1cmluZyB0aGUNCnJldmlldyBwcm9jZXNzPw0KT3IgZWxzZSB3ZSB3b3VsZCBl
bmQgdXAgaW4gc2l0dWF0aW9uIHdoZXJlIDIgaW50ZXJmYWNlcyBhcmUgc2ltaWxhci4NCg0KVGhh
bmsgeW91IQ0KQXJrYWRpdXN6DQoNCj4+IFsxXQ0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYWNwaS8zYmYyMTRiOS04NjkxLTQ0ZjctYWExMy04MTY5Mjc2YTZjMg0KPj4gYkByZWRo
YXQuY29tLyBbMl0NCj4+IGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2Zpcm13YXJlLWd1aWRlL2Fj
cGkvZHNkL2RhdGEtbm9kZS1yZWZlcmVuY2VzLmgNCj4+IHRtbCBbM10NCj4+IGh0dHBzOi8vZ2lz
dC5naXRodWIuY29tL2l2ZWNlcmEvOTY0YzI1ZjQ3ZjY4OGY0NGVjNzA5ODQ3NDJjZjdmYmQNCg==

