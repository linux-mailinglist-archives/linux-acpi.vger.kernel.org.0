Return-Path: <linux-acpi+bounces-12577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD719A771D6
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 02:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7381F1668D4
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBE2B9B4;
	Tue,  1 Apr 2025 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VauNtvIr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4382110;
	Tue,  1 Apr 2025 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467120; cv=fail; b=Dbo2KwDbO1i3y0CVuT9YRT/aFFeiQkq4q/z00LoMrTnP4dzxXxeuCykHGB6R7tXHJeuJ+9JWroKf+vEwXriprjPZ0g909LtTlxUB+dpeZkzhgUN3Hn20638zeeNIeg65tKrew98nTA9oSayjK/izAVMUqsW6CKSl15NHiM53cig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467120; c=relaxed/simple;
	bh=pWi9bcYBmNnjPV8z/7JiBTONccM4f7mWNDEw4Bg1Utc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPhD/sKegHMqv0WIECJOYTqRjDlbTBPumY6JPL9HEqZBYASGLRetg6G6KClTv9VMVsva2Uk2LuNh4Hc8eaBhmk5mvuuMINsA5LWJAyoQYSy3zlrvDQgIwVT/0DCi4FuX2rHPO2sBnOV7yCjD91+7eSldLNxL+almjHzOCjSEmzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VauNtvIr; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743467119; x=1775003119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pWi9bcYBmNnjPV8z/7JiBTONccM4f7mWNDEw4Bg1Utc=;
  b=VauNtvIrVuFu1ze537I5fReq+Wxeip0dwIDmzMDJWVdPvYdZZmSjQCdg
   i0fstWBP2p0upnMBXu0cGNbFkf+fj7BPatKSoKweFZBnd7tvsqvFzAjpj
   s9yzTC9ZcoC1fVlpioZgV3yw/pOb8H79fiyMXwWj/s0WUPMjcvCgoN2TF
   a3JNQNBzPmr43b5xupauk7Ly9jRW662m3CDe3OeGj5SLue00XwEJ0BZ6s
   TUvtNI8xZwBiBiewhURVaj0e5gt+AgaY98H+1xmPGL7BB+C7GbJpa9aSY
   ld2eBTaN+J6jR4Pnib2wddR/gT89h9W7bJnjJ7eR5m2lBzsuKaHacuAkY
   g==;
X-CSE-ConnectionGUID: FTTw+o97RAKFTdzJzzaM/Q==
X-CSE-MsgGUID: NSp+RA8GQJmeHcTNC3zKFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="67248377"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="67248377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 17:25:18 -0700
X-CSE-ConnectionGUID: BegOe26pRhCMynxAVLcA4g==
X-CSE-MsgGUID: KEkZAuAITgOMXRvHyckhWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="126201031"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 17:25:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 17:25:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 17:25:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 17:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u355fv8VTSy4QUjV/24osnNr7DgQs7BOmBE9mEH0LsmJBo2A4zxxYozvgcfM6VuTQNwXrT8FF4GVhVm2yBOiRm2+63YdbQ1eUmHHpgG7mB//tmFi12ymHoPqRngRViexm8eMlZYM9+EVeaQ01g8jDOMuLEILUUMFBkY6aCgIpbN8F2GoYHcSe5Zd/peJbBrBO8RPYsck1p6JX12CcHLwmDw3Px3E1dMxG16xwHA5TnLojyC+qZUmrVEQTW1jooCYViDOplypj6PvycJT948NyeDek0SolsY+VAIGPzavBTD5RKHTO7VgeU//5/CV5llhl5Z9ofk3T6063nbT4vStdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWi9bcYBmNnjPV8z/7JiBTONccM4f7mWNDEw4Bg1Utc=;
 b=l/PxzvhZhAeZi/zAbew+XTa2qWMNGbpf6mzf2y9pnPWXT+CE0ZqqrQzUJ59yQd/C13tx/HGh9MYpUHUjT9VgyUIztYXYfnOd/Y82Q+3wayxbWZJCx0JeruAaR87a5YAgpCXUMkeiheF0ivF4RUDZDydfBItp0XQbyHPDc77VmbVhVZd/3RfYY6IWX7mhXDVGryMa1y+ugknW8q7lvocW2IRcS8QK/40IuXIi36h8K2IQ7g+gltyhh0ckHoOcL6A8KQDMWM/6DrU8vWGXMHsN/y2Oigt1OT8DvASLqdKkCBC91eb7nTNoeUl1a/jmgG4j4L1QX8XLPpKR44AHznHs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 00:25:02 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 00:25:02 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "ggherdovich@suse.cz" <ggherdovich@suse.cz>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Topic: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Index: AQHbn+4UZ+9FL9Dg6U2jNOmvmyjByLOM35CwgABLc4CAAM4iAA==
Date: Tue, 1 Apr 2025 00:25:01 +0000
Message-ID: <7a14ea42462a346958954f328933f583dcf9cb52.camel@intel.com>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
	 <20250328143040.9348-2-ggherdovich@suse.cz>
	 <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
	 <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: 28ff6a21-07a0-4794-8659-08dd70b3a49f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGdYdFZZTTE0QjZzVVlXUXR0N1MyL2gveXlsbTRNRXlrU0ZHTDV5aTdERkNV?=
 =?utf-8?B?bWJjMFhDREVEUjdMcHY4cmVkek1kQ3owRm9qV2tlU01uQ0JjVjJNYWZTaHcv?=
 =?utf-8?B?MG00SUx4UStNZnBFb0FpbXZrWVRaZDVLOHZ5OHpKRzFmbzFLd3o3RHhKVk5Y?=
 =?utf-8?B?cWRDWlVLVDIzK1NoaG1PblhHeTI4anJhek9JVVRmTzJaazNjcDZXaU1kcFFG?=
 =?utf-8?B?Vmlpak42dk1IZG04bWZQeldKRHI5Tnl4S3UveXJLNlc5TE1YYWpNNVQ3czRx?=
 =?utf-8?B?OXZ5emNaYVgzZGhIZ3loamQzbWVnNlRORnRrYnhZdHI5TzF2TnArWkhyV1A2?=
 =?utf-8?B?R1ZoYnVLVXJWc1UwTWU3YThGTFhUa3VJNGV0VjFjTVczdmxaNm1kd0N2RFVv?=
 =?utf-8?B?ZmxOVFJIeVpNOXdmYXBWa250QU1LVytrNXJ0dVRWUDhMNm1CZFc0bjNiTDB3?=
 =?utf-8?B?WXJ4RHA3OG5ZazNhbFNFMUhPNXZHeTVUcmVmL2hTM3E2VDNpZDVFcTY4MmEv?=
 =?utf-8?B?Q1RKaERFRHB1WlZKVDBnMHNhR2p6RzNGdkFHRlJvRGxJNDhYMzU1ellqbGxO?=
 =?utf-8?B?UE5zQ0JGcmpDaUlUcXRCWDduVklDdzRDVHZpWjIvRVk4UmJ4cTljdEw0OGF6?=
 =?utf-8?B?b0pCUHJOcmw1R2VneCtzcmxBakR5L0R0S1YyN2dxamtiRXNPR2pxRWZBNmQ1?=
 =?utf-8?B?Zmd2MENDQUFCY3Bzdk5IOTJvZXF4ak1vdmpvTlJSWnR4bjV3KzJxR2RUbVFs?=
 =?utf-8?B?Q0VxRzh5b3dkeXd3UGhpY3NDckFFYXFiSzhKVzl6UXJkbjlBWVltRTlrcUhX?=
 =?utf-8?B?ZUlHSHd5UG5HRWlnemZkeHg3ZmIrN0xJS0trS2pJOEdQZzRKNWJMWm1yMUlT?=
 =?utf-8?B?dnFyR2t1YVlDWGxNMWp0WmV1NFFqYUs4ZC9MZGNqTXJNMjhyT01EbjUwbWM0?=
 =?utf-8?B?R2lmOTVjTmNMSGpxcG0xM2phRGVRZ3lQdlI5WDIxVThJREZPMGM1aVQ3YWc1?=
 =?utf-8?B?L1VsbHA3ZFE0OEdQN3lIRFZrNWIvUnFhUVQzRGhZTDZYY2NQdmlYOVBzZmJ6?=
 =?utf-8?B?VzJiQXB3eFhMYXlCMldKOGZLLzZxNEM5UGZLNm51bXMrZ092NmdCNVY1SVVx?=
 =?utf-8?B?NmRWWWhyazZzRnZTRklwRWFFQ29yZU9vY3l3NE1sKzduMXZEVXJweE04WVB1?=
 =?utf-8?B?MFlFdkw4Q0ovOVlTZEFkRklKd016VFZSMGkxRTEzdmovbjVNc040bzVibU5V?=
 =?utf-8?B?Rk1aZ0dncUxaSVE5RGdBUUdTOFRLN3B4cmtzL1dqTjExZW8ycXUrTXFLbzlE?=
 =?utf-8?B?Q0lwTFBlTlpscGU1K1NPMzlTOUgzK3NEc0ZYbUpEN3VPZEZQeEM1VHZNZkc3?=
 =?utf-8?B?L0MwTXlmeGpEWGdrZjRNYXorci9BcklacUhOcVRkeVI3cXpGb1k5cTVieG1D?=
 =?utf-8?B?U29EN2E1bWZxeXNNUlpmRDZpdmlJQ3M3TDR4WXlJRThoZFBzdDNoR2tnanZa?=
 =?utf-8?B?T051UnQyTWk2ZlhURU1TeDAzRmNPWFZIcWk2dHBzaFZtb0JaZWdYbFBWMmFF?=
 =?utf-8?B?dmRDRFA3cWZIU256UWZNVklKREZOdS9zSWFtMlEwVEVDUHNLYXc5dHNHZkgv?=
 =?utf-8?B?dzB3QXBVVmxsOFFYZkFRYXlGU2ZMVUlvZ3Vnd01udzZ2Q3YrY2huV0thaHJ4?=
 =?utf-8?B?QmhTQkpkZUxMazNTTUNXbFprS0lQSUpQYU5ia2NoMDdOMmRFZmsrNVVYSm15?=
 =?utf-8?B?cDNGMmZrRnpWTXNtMzlwREtvenIrSHcxaGJZZmp5OHJyUjF6QUNUaTh1Tlgv?=
 =?utf-8?B?T2IydUhHdWxDaVlQUmg0WXU5MHRaSzM5Vld0YUlQMWlZbjZpY01iVFkyZUxu?=
 =?utf-8?B?YURsTzFBSGNGSmpnQjNDejF4cVNQVm1IRTdrYXE1L0ppcUl4MjA0aEJKaXNI?=
 =?utf-8?Q?Wmc70wjVN5oiO1co5blBt5H26kZnWRUh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di9SaGtPdGtlTG5xOVYyMHVwa2tIZmtHSHBBVUcweFR1RHdYVTQxMzFUVExW?=
 =?utf-8?B?ZGNjTW9qbWZzR3RFMEt4VWs1cTV5akYyNlhWak9rVWtMY1B6aC9qRkp3MEI1?=
 =?utf-8?B?dU1QcmR3U29SNkNxUUpiT3hKYXRrQVo1Z2VKOFRXK2JXSDVlUDJ1cUVDUHdH?=
 =?utf-8?B?OWJlMkxoTFk4MksvMDBUT25qL0dDK2VYSEpROVJ6eVFWT2EydDNHY2U0YzFw?=
 =?utf-8?B?c05ZQjQ0bXRkZEt6K0FqcW9ldUdMMzgrd2MwbFhXajRZZVVzcW0rSzQ0ejVo?=
 =?utf-8?B?WEhkUkZ3cWtVeDBhcFQvS2JJblBTeUpaRGZTTGJVWUg3NisxOE5qL2FnV295?=
 =?utf-8?B?eVh0RXZZRjcxSzF4bDhuOS9kSC9iK25vRW1lV0E0SE4vQ1hlSndWelloZnlH?=
 =?utf-8?B?VUlhTFI2ejVNZ2NiRFVSclAySVRtcEhyZUg2b1YvbER0MW1WdzFsU1hVdDRQ?=
 =?utf-8?B?d0V4M2I2djVCRXZCbkJJcEUvVGZWNmhxeFkrZDVNNElNVXlxSEszckZNVUlv?=
 =?utf-8?B?d1RyRmx5RnNWbEpIemowV3BkeXRmaVUzaFVBemRzSDJ6QVJLakU3dmlKdThH?=
 =?utf-8?B?ZzNhWUpGdTBzYWlrWCs2aC9pYzNCUEJkWG9JWlNJcGlzeS9YeitoMnlhUFZK?=
 =?utf-8?B?d20yZEdHYlgyc2ZZVmxDTk5KSG1maXRid0RiMlhnaGNRZEtXNTBuSnQ2dE54?=
 =?utf-8?B?ZHkxMEp5Z1QrMnh1WVV5WW9hakhIdUE5S2FGT0RWZ3M3cXpGa2tqVGxISkU0?=
 =?utf-8?B?NmdzNG95dFJOWlhtOTZ6QzdzZU5JTEZHTEZzY2kwTCtSdlhBTFNyRGNLTWV3?=
 =?utf-8?B?WXJwTnd2cHdHbUFZaHNUM3RFYitqeWxHcEx0bGpoM1lUaDN1d0FQTzJEMDhV?=
 =?utf-8?B?R1ZmVlJUeHVpWGV6aU1YQnpNaThIWlBrd0s4aFRFRURjUTFNVFpyNTFSS2k4?=
 =?utf-8?B?OFlEWHdtb1FYdVNnSVJrU2RJU003dU5CQW1SSTBMTkRkelNFU1JsWndZMmln?=
 =?utf-8?B?VzhxS2dVa1VXRHJ0b09JdVhId1gyUytHZlhoWENRTkZuTXdXeDl0NExNMi9Q?=
 =?utf-8?B?bHA4WDdOMGdKSmJHa0luaDFUUDlQdXhvU1ZmZFkwQkoyNlFGQ0x2NmhzMW52?=
 =?utf-8?B?d1hGUEZFWHcrU1pBVEJGSmhNYkxCZEdpWmhNT1d4VVZEWEQzWmF2bXJDYm44?=
 =?utf-8?B?dmVuMmZ6K01FanFxSlQxb1c4blFjQkhuakIvVXhkN000R2lrR0t3SFZaamtC?=
 =?utf-8?B?QnVLb1JEUExHUHhqM2VqeFRiN0I1U0toZmQ4L0t1VVpGMGRXdWg0MTcxK0Zu?=
 =?utf-8?B?UDJSU0RjblhvQWZ0dTlnRllEbDVBRlhXYkJpd1U1bDQyZjBianEzUncxa3lO?=
 =?utf-8?B?OEY0RnRGeStaMzdTaFRDcnpDLzlqRTlGV0NSaFhZUTEySDl0NjJ5SFkvMk9T?=
 =?utf-8?B?L2RJN1kzZ21KZHVNd2ExYnJrbTVMYkJXalY3NXRIVlRoamhJQWNtemdoVTVk?=
 =?utf-8?B?Z2FDSlZLZTRUdHJGcVhITlNMR2FCU0t5UHE2SnlNRTVZOW9HR1BhZVJNQ3o3?=
 =?utf-8?B?NUI3bzRJQXkvYmJ0VGxpcGoyaDI3eFVEc1dla0oxaFZBZnJQcWhqUUFGWHJI?=
 =?utf-8?B?am14L2NpK3VHZk5FSllXeFZQV1kxVTJWWlpiU1FFMmd3QnBodXYrVlBFQmZ6?=
 =?utf-8?B?MWR1c1J5RlY3WFovRWMwcFNHblRJUGFiSFAya1I2d3hOVURva09tUTJiSmtZ?=
 =?utf-8?B?UkswQjZ1VUg1bEE3SmlLQ2RhNFFlanl1NjBJczZXREN1SGhQNi9HR3J3V2Zx?=
 =?utf-8?B?eTliaUNnSkh5QTErUnVETUxzZTBMT1JhbU85bFlVVks1Skd4cXRJTngwM05z?=
 =?utf-8?B?TzZsTkk2NUx5N0FNTU5Pcm1Xa1BvNTVqT0c5TGJSckZ2eGJIMGhEOHZMZnhm?=
 =?utf-8?B?QTNGR1cxcFoweno1SzR5Ukk1cHNkVmhYOVM2NEhPR2EzNVRTc0ZQQ2k3cGVX?=
 =?utf-8?B?MlJmaEZKczdjakVPRlRCVExVK2Z5RjJmSnlYVUhTUjM4UEcrZmZIMW5ieC9i?=
 =?utf-8?B?Wi84TWdPbm5LNDRMTHZSV3BLUDlzOWZZR2hIR0ZHclAzbXVUVERQbEIvdzRY?=
 =?utf-8?B?RFZEcDhzbXUvZFBGLzlQN0k0UFAweWVrQmpvbmYzajg0TjhPcWduRmZ0Q2Zk?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE75F31DC2CD134285C437B341CC3E35@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ff6a21-07a0-4794-8659-08dd70b3a49f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 00:25:01.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bc0jbUdbrNhAV/1fRWeDaUR5dK8FYjt+vS7EnqIbkZaeq0O+JDUSfUVN9eVb5/2RecQRpUMBS699e8jV5iO15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTMxIGF0IDE0OjA3ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBNYXIgMzEsIDIwMjUgYXQgOTozOOKAr0FNIFpoYW5nLCBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IEdpb3Zhbm5pIEdoZXJkb3ZpY2ggPGdnaGVyZG92aWNoQHN1c2Uu
Y3o+DQo+ID4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDI4LCAyMDI1IDEwOjMxIFBNDQo+ID4gPiBU
bzogUmFmYWVsIEogLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFpoYW5nLCBSdWkNCj4g
PiA+IDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IExlbiBCcm93biA8bGVuYkBrZXJu
ZWwub3JnPjsgR2lvdmFubmkgR2hlcmRvdmljaA0KPiA+ID4gPGdnaGVyZG92aWNoQHN1c2UuY3o+
OyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtQQVRD
SCAyLzJdIEFDUEk6IHByb2Nlc3NvcjogaWRsZTogUmVtb3ZlIG9ic29sZXRlIGNvbW1lbnQNCj4g
PiA+IEltcG9ydGFuY2U6IEhpZ2gNCj4gPiA+IA0KPiA+ID4gU2luY2UgY29tbWl0IDQ5NjEyMWMw
MjEyN2U5YzQ2MGI0MzYyNDRjMzgyNjBiMDQ0Y2M0NWEgKCJBQ1BJOg0KPiA+ID4gcHJvY2Vzc29y
Og0KPiA+ID4gaWRsZTogQWxsb3cgcHJvYmluZyBvbiBwbGF0Zm9ybXMgd2l0aCBvbmUgQUNQSSBD
LXN0YXRlIiksIHRoZQ0KPiA+ID4gY29tbWVudA0KPiA+ID4gZG9lc24ndCByZWZsZWN0IHRoZSBj
b2RlIGFueW1vcmU7IHJlbW92ZSBpdC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogR2lv
dmFubmkgR2hlcmRvdmljaCA8Z2doZXJkb3ZpY2hAc3VzZS5jej4NCj4gPiA+IC0tLQ0KPiA+ID4g
wqBkcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYyB8IDQgLS0tLQ0KPiA+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQo+ID4gPiBiL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3Jf
aWRsZS5jDQo+ID4gPiBpbmRleCBiMTgxZjdmYzIwOTAuLjJhMDc2YzdhODI1YSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiA+ID4gQEAgLTQ4MiwxMCArNDgyLDYgQEAgc3Rh
dGljIGludA0KPiA+ID4gYWNwaV9wcm9jZXNzb3JfZ2V0X2NzdGF0ZV9pbmZvKHN0cnVjdA0KPiA+
ID4gYWNwaV9wcm9jZXNzb3IgKnByKQ0KPiA+ID4gDQo+ID4gPiDCoMKgwqDCoMKgIHByLT5wb3dl
ci5jb3VudCA9IGFjcGlfcHJvY2Vzc29yX3Bvd2VyX3ZlcmlmeShwcik7DQo+ID4gPiANCj4gPiA+
IC3CoMKgwqDCoCAvKg0KPiA+ID4gLcKgwqDCoMKgwqAgKiBpZiBvbmUgc3RhdGUgb2YgdHlwZSBD
MiBvciBDMyBpcyBhdmFpbGFibGUsIG1hcmsgdGhpcw0KPiA+ID4gLcKgwqDCoMKgwqAgKiBDUFUg
YXMgYmVpbmcgImlkbGUgbWFuYWdlYWJsZSINCj4gPiA+IC3CoMKgwqDCoMKgICovDQo+ID4gPiDC
oMKgwqDCoMKgIGZvciAoaSA9IDE7IGkgPCBBQ1BJX1BST0NFU1NPUl9NQVhfUE9XRVI7IGkrKykg
ew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHByLT5wb3dlci5zdGF0ZXNb
aV0udmFsaWQpIHsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwci0+cG93ZXIuY291bnQgPSBpOw0KPiA+ID4gLS0NCj4gPiA+IDIuNDMuMA0KPiA+IA0K
PiA+IEkgdGhpbmsgd2UgY2FuIGNsZWFuIHVwIGEgYml0IG1vcmUuIEhvdyBhYm91dCB0aGUgcGF0
Y2ggYmVsb3c/DQo+ID4gDQo+ID4gRnJvbSAxMTVkM2EwN2ZlYmZmMzJlZWQ0OWY5MzQzZWYxMTFl
N2UxNDUyZjlkIE1vbiBTZXAgMTcgMDA6MDA6MDANCj4gPiAyMDAxDQo+ID4gRnJvbTogIlpoYW5n
LCBSdWkiIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IERhdGU6IE1vbiwgMzEgTWFyIDIwMjUg
MDc6Mjk6NTcgKzAwMDANCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIEFDUEk6IHByb2Nlc3NvcjogaWRs
ZTogU2ltcGxpZnkNCj4gPiDCoGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVfaW5mbygpIGxvZ2lj
DQo+ID4gDQo+ID4gU2luY2UgY29tbWl0IDQ5NjEyMWMwMjEyNyAoIkFDUEk6IHByb2Nlc3Nvcjog
aWRsZTogQWxsb3cgcHJvYmluZyBvbg0KPiA+IHBsYXRmb3JtcyB3aXRoIG9uZSBBQ1BJIEMtc3Rh
dGUiKSwgYWNwaV9pZGxlIGRyaXZlciBjYW4gYmUgcHJvYmVkDQo+ID4gd2l0aA0KPiA+IEMxIG9u
bHkuDQo+ID4gDQo+ID4gT3B0aW1pemUgdGhlIGxvZ2ljIGZvciBzZXR0aW5nIHByLT5wb3dlci5j
b3VudCBhbmQgcHItPmZsYWdzLnBvd2VyIGJ5DQo+ID4gMS4gdW5jb25kaXRpb25hbGx5IHNldCBw
ci0+ZmxhZ3MucG93ZXIgbGV2ZXJhZ2luZyB0aGUgZmFjdCB0aGF0IEMxIGlzDQo+ID4gwqDCoCBh
bHdheXMgdmFsaWQgYWZ0ZXIgYWNwaV9wcm9jZXNzb3JfZ2V0X3Bvd2VyX2luZm9fZGVmYXVsdCgp
Lg0KPiA+IDIuIHVwZGF0ZSBhY3BpX3Byb2Nlc3Nvcl9wb3dlcl92ZXJpZnkoKSB0byByZXR1cm4g
dGhlIGhpZ2hlc3QgdmFsaWQNCj4gPiDCoMKgIEMtc3RhdGUgZGlyZWN0bHkuDQo+ID4gDQo+ID4g
Tm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
WmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9h
Y3BpL3Byb2Nlc3Nvcl9pZGxlLmMgfCAxNSArKy0tLS0tLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiA+IGIvZHJpdmVycy9hY3Bp
L3Byb2Nlc3Nvcl9pZGxlLmMNCj4gPiBpbmRleCA2OTg4OTdiMjlkZTIuLjdjZThjMzgwMjkzNyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2lkbGUuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvYWNwaS9wcm9jZXNzb3JfaWRsZS5jDQo+ID4gQEAgLTQ0Miw3ICs0NDIsNyBAQCBz
dGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX3Bvd2VyX3ZlcmlmeShzdHJ1Y3QNCj4gPiBhY3BpX3By
b2Nlc3NvciAqcHIpDQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxh
cGljX3RpbWVyX2NoZWNrX3N0YXRlKGksIHByLCBjeCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRzY19jaGVja19zdGF0ZShjeC0+dHlwZSk7DQo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgd29ya2luZysrOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHdvcmtpbmcgPSBpOw0KPiANCj4gV2hhdCBpZiBzb21lIHN0YXRlcyBhcmUgc2tpcHBl
ZCBiZWNhdXNlIHRoZXkgYXJlIGludmFsaWQ/wqAgJ3dvcmtpbmcnDQo+IGNhbiBiZSBsZXNzIHRo
YW4gJ2knIHRoZW4gQUZBSUNTLg0KDQp5ZXMsIGJ1dCBwbGVhc2UgcmVmZXIgdG8gbXkgY29tbWVu
dHMgaGVyZSBhbmQgYmVsb3csDQoNCjEuICd3b3JraW5nJyBpcyB1c2VkIGFzIHJldHVybiB2YWx1
ZSBvbmx5IGluDQphY3BpX3Byb2Nlc3Nvcl9wb3dlcl92ZXJpZnkoKS4NCg0KDQo+IA0KPiA+IMKg
wqDCoMKgwqDCoMKgIH0NCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoYnVnZ3lfbGF0ZW5j
eSkgew0KPiA+IEBAIC00NTcsNyArNDU3LDYgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9w
b3dlcl92ZXJpZnkoc3RydWN0DQo+ID4gYWNwaV9wcm9jZXNzb3IgKnByKQ0KPiA+IA0KPiA+IMKg
c3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfY3N0YXRlX2luZm8oc3RydWN0IGFjcGlfcHJv
Y2Vzc29yICpwcikNCj4gPiDCoHsNCj4gPiAtwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgIGludCByZXN1bHQ7DQo+ID4gDQo+ID4gDQo+ID4gQEAgLTQ3Nywx
NyArNDc2LDcgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfY3N0YXRlX2luZm8oc3Ry
dWN0DQo+ID4gYWNwaV9wcm9jZXNzb3IgKnByKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGFjcGlfcHJv
Y2Vzc29yX2dldF9wb3dlcl9pbmZvX2RlZmF1bHQocHIpOw0KPiA+IA0KPiA+IMKgwqDCoMKgwqDC
oMKgIHByLT5wb3dlci5jb3VudCA9IGFjcGlfcHJvY2Vzc29yX3Bvd2VyX3ZlcmlmeShwcik7DQoN
CjIuIGFjcGlfcHJvY2Vzc29yX2dldF9jc3RhdGVfaW5mbygpLCB3aGljaCBpcyB0aGUgb25seSBj
YWxsZXIgb2YNCmFjcGlfcHJvY2Vzc29yX3Bvd2VyX3ZlcmlmeSgpLCB1c2UgdGhpcyByZXR1cm4g
dmFsdWUgdG8gc2V0DQpwci0+cG93ZXIuY291bnQuDQoNCj4gPiAtDQo+ID4gLcKgwqDCoMKgwqDC
oCAvKg0KPiA+IC3CoMKgwqDCoMKgwqDCoCAqIGlmIG9uZSBzdGF0ZSBvZiB0eXBlIEMyIG9yIEMz
IGlzIGF2YWlsYWJsZSwgbWFyayB0aGlzDQo+ID4gLcKgwqDCoMKgwqDCoMKgICogQ1BVIGFzIGJl
aW5nICJpZGxlIG1hbmFnZWFibGUiDQo+ID4gLcKgwqDCoMKgwqDCoMKgICovDQo+ID4gLcKgwqDC
oMKgwqDCoCBmb3IgKGkgPSAxOyBpIDwgQUNQSV9QUk9DRVNTT1JfTUFYX1BPV0VSOyBpKyspIHsN
Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocHItPnBvd2VyLnN0YXRlc1tp
XS52YWxpZCkgew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwci0+cG93ZXIuY291bnQgPSBpOw0KDQozLiB1c2UgYSBsb29wIHRvIG92ZXJyaWRlIHBy
LT5wb3dlci5jb3VudCB3aXRoIHRoZSBpbmRleCBvZiB0aGUgaGlnaGVzdA0KdmFsaWQgc3RhdGUN
Cg0KU28gSSdtIHByb3Bvc2luZyB0byByZXR1cm4gdGhlIGluZGV4IG9mIHRoZSBoaWdoZXN0IHZh
bGlkIHN0YXRlIGRpcmVjdGx5DQppbiBhY3BpX3Byb2Nlc3Nvcl9wb3dlcl92ZXJpZnkoKSBhbmQg
dGhlbiB3ZSBkb24ndCBuZWVkIHRoaXMgbG9vcCBhbnkNCm1vcmUuDQoNCnRoYW5rcywNCnJ1aQ0K
DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByLT5m
bGFncy5wb3dlciA9IDE7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+
IC3CoMKgwqDCoMKgwqAgfQ0KPiA+ICvCoMKgwqDCoMKgwqAgcHItPmZsYWdzLnBvd2VyID0gMTsN
Cj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiDCoH0NCj4gPiAtLQ0KDQo=

