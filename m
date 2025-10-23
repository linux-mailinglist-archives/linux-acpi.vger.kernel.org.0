Return-Path: <linux-acpi+bounces-18158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C48E4C0243D
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9433A5CBE
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9336F244665;
	Thu, 23 Oct 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCtZkHbe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88364D8CE;
	Thu, 23 Oct 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234980; cv=fail; b=q4+LL4IkPWCJvHGWxvJ5jwUgesalpASn+/Sd7skaxOD1Td0SObpNTPL4sCNKaZ/VNLq9Pvq5x8Sh9aCIV5YK+yDGkGBI05L22gkeEmS88DgJRp3Q3sPORBbtdNqWsejuP0KSm6MEhExl77L/VjffqQOw6RvWmgxp3y+/+p+ADfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234980; c=relaxed/simple;
	bh=2fwIma9HGs719/z1cRQNFg4MRggpcp7AiHJAN9AtDQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7cmr1p+hn+6H00bGPjKXUHJTvqut7GZ/fcvHhDZrNFgFfIG2iSIDnKBoDIAkAafs4O7R++PIL4Fu8oJHZhwbe2cHh/cALxSdHgvlPSykOHeX+DZ6EGET9fnwG4pqsRvvxZ3ffmkinMqt8iZWBeV2EtInVfbURwY2to3M6VhkcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCtZkHbe; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761234979; x=1792770979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2fwIma9HGs719/z1cRQNFg4MRggpcp7AiHJAN9AtDQg=;
  b=HCtZkHbeQK5KLfm6xGx60S9OLNx9U3/hu9lHK3w8Jx4/YqGyCyZaw6Qi
   Mv+il0ayKTcUDFUSMT+WHLqL5Dx7h7FVCGwYK3uafL5BwzozXn24QZbDq
   qa9KN5BJ+baLBZdXXL3YSNBmcE6RgfiDOcrtL+h9nb2tAI6x5URef+G6v
   zFVIXLhAFnY5v0qm/P3e9AffIjwbj5kS6eVyqSS3JGDKXMK23e8W/UdlE
   gZX4mSwLnnVjSNgYaiUSUNi/WXy8N6IOUjgyPjoohrlJymlBujM45t7XV
   FQYjDmczkoFwv2WcYkfVY27eXV6/ZZrv6FLH/6h0jqy1mQdQfcfoW63a0
   g==;
X-CSE-ConnectionGUID: bJ8bqxB8SF+WDdj+oMxrSA==
X-CSE-MsgGUID: mwG/9eEpSq2zCNWnRCGsjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66023978"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="66023978"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:56:18 -0700
X-CSE-ConnectionGUID: TMq67bFBRK6UFgtVHr0oJQ==
X-CSE-MsgGUID: HKebI8OsT9WepWe5IQO5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="188253428"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:56:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:56:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 08:56:16 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIN7pf7so0SQa1pydBiJYGf2lovxVCnMH6XdWxmdPMnM5HieUYT1dydi1BFyY8pynhh1W89nO8NCfsClZT5Zbd9CdR6C/+2RNOrZEuYfsTssEz6f5OgV14Acp3BOr7l1AlVbPB4cEFNJu8LKTsFkL9Q5vJTrP74oO2wdwlmtRKT7Q/tXJEPfUNX7Ti/tG2WD7WVPtJ4aLw76fp80JsssblUsBpb+r4HcQQiZJ3zieJ4QVS6Km8+fsRGqTyhvEKrmb4wI1ynr051yv50LNqwzrNoB8wINkm/bA4Gqwu4HjwaKqhu+YcPY5rwU3wfF24O/jLW1u09Td2knzZt6rbrtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fwIma9HGs719/z1cRQNFg4MRggpcp7AiHJAN9AtDQg=;
 b=ceZApzTjc5DcbSBUE7Myb98Ms+y2Ffeya9iB+rWbyazHpdwhVChZsd0VRbf+aney+vFDALWXOPqQ8AGc0kTmOXsC5ojDkoSsxjviZZkW6s8GtxwDP+H/hZxgHFRX71gW/w58UtO4fNI1Dcd/GQGm8poSQG6dW+ulDNu4t1hMlD0I/8DJadWOzdW9egzoqf/7RCUXnfqTbMDAUNudKfVxU1G6yMjTBTo+RJZikVkW148w1Mkxo6GfqEiCgW1Sk25MuYnGLf+bkGEOPlTAoI4An3SHN2S7ijzFqHCKUQKaMaPttHqkQHDlXlJIQyqQ5IaxqD6LZ/TI1gqfudlA4C+VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:56:13 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:56:13 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] ACPI: MRRM: Check revision of MRRM table
Thread-Topic: [PATCH] ACPI: MRRM: Check revision of MRRM table
Thread-Index: AQHcQ5TS7dKbeU8BuEi/R4g/wDd/fLTPf/6AgABhywA=
Date: Thu, 23 Oct 2025 15:56:13 +0000
Message-ID: <SJ1PR11MB60835AF413CB53076304AABCFCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20251022204523.10752-1-tony.luck@intel.com>
 <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hhnAq-HJhXU8VTAWKNg0PJkYbeocCKEffYOurZn0U81Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB8178:EE_
x-ms-office365-filtering-correlation-id: 643b5033-d2b0-44ee-6339-08de124cb122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TGZENzQxSm1XdGJrNXNwa1hEOU40eTVlcDFtbTV5aXdjMzF1SEFPenZ3UFBq?=
 =?utf-8?B?RlBEU09SQ1dNbEV6emxySUVsMXBjOFh2Mmd3dUR2TVFKNGJoMlpUUlpzSktz?=
 =?utf-8?B?OEN0V082ZEgrNFhaa0I1a0gxdWhDd0t5UmhLVXo1TWZnckZHSVZrVkc3T3o1?=
 =?utf-8?B?MTdERVIwZnVlajVPaklJV3ZXSHdXbXZoYWtrbnJ6eTJkZVgyS3owaGJBTWFX?=
 =?utf-8?B?MWk5NnpkbTR0VmFVZ1YvVUw1SjI2dFhIbVFQZDYrZEhqaGVMazRRejJIQmNZ?=
 =?utf-8?B?QTRFN3hwQ055dm5lcGRPd3c3SVFoWTQ3UGxDanFZdENUUlZjSy84b1hBRXpu?=
 =?utf-8?B?ME9KdjE4a05SL0g2OVVyYlJsWE13RG9YZkFFT2Q5aDZqMXpUbVM2cXllVTJJ?=
 =?utf-8?B?blJrYU13NEs3RzdyU1JKMUtqdjNUd0pFOTI4NWZnc1Y0SnZlTHAwTVJkZjhr?=
 =?utf-8?B?VnE2eGNtQ2F1TnFsSS9WQk1qaWM1ZXpDbzVHaXJMb1JaU3h6L0ZuWDNrb1RI?=
 =?utf-8?B?Sk82K0JEMElETC9oN25Wb0g2Nk1TQ0owZVNTSHQyRXcxK3AzaVZpeC8xRjRU?=
 =?utf-8?B?azNrdm1wLzY1aE12UG9nN2orekNOM2xHNmo1aURLUVNVRU53RFJIY3NaKzRQ?=
 =?utf-8?B?eGlZVlZTMFQ5dHVQS2pzcm5odUkwc3dyU3NwZEdubTZtMHlHTEtEQzBHTWlj?=
 =?utf-8?B?RFFMLzlZQVlia0pkdi9IVTdpRXpXWTdpRmxBZ25GbC9RaStqRGFISk9XNGZ5?=
 =?utf-8?B?WCtudWdpZXNHY25DMzNvdGxIa0VzWWM3Uk11b1JkWXBlKy9oOVhPUWd1UGNi?=
 =?utf-8?B?WmhGdTJYVzBMT2NBZmROWERSNWtjeTRIcGVlTnZKMFRqbW1rZ3BtdEtDMC83?=
 =?utf-8?B?YVQyWUsrS2xBb1dNSHJmYjM4U2xhVzVlZE5mV01tVGRySWs4cGtrcWRtdmVQ?=
 =?utf-8?B?RlJiWkpJdDdGSXZnd0lVSEY3Y21oajdHT3ZMcmVBVGVPbUgwMFFjZk5keUxB?=
 =?utf-8?B?MllYbzBhY2FoWjUvcm50THdDTWlXbmZNZTJjeTNaOG9vZ3krNmovRDlKM0VS?=
 =?utf-8?B?dDNQakhHWDE4UFdqekNRRUg2LytDMWViaDFBTGxBYTBlNFI1VjhWeG4wKzVx?=
 =?utf-8?B?MExYaEpYMWRnT1REUEhFZ0ZLaUZiUFBFVzI0elh6cEcvdnB5YkVkcnRtTFVY?=
 =?utf-8?B?UDJZMjR0QXV5NXRyVXl1a3ZndndicFY0eUFCdERIeEJaSGhYdkRwMGFURXcy?=
 =?utf-8?B?UVMwSkI3TCtiUk1CQ3lyMjU3enJjSFhPRDl1bTA3VjAyTUxVd2grdDV2Z2tI?=
 =?utf-8?B?R2Q3UHk4ZHEvQm80bE9COVlSL1hmRSswVWtDcGpxQkJsZTZMYTAvVjRid1d5?=
 =?utf-8?B?KzVNdlBDeHpEemVvK0JXL3AreEk0SGJKTVpab3hSczhKMWJZS2kyblM0Ujdm?=
 =?utf-8?B?a05QQlVyWWNMUTlCdW9Idnc0eVpJMmZxVFJ3bXd3Sm9LSHloTFNtMHppN1lW?=
 =?utf-8?B?TW1QL25WUzl3Ylp2SVV0TXBqdzlsLyt6NkZia0N4ZVlyUmxyZjZ5aEVUcmtq?=
 =?utf-8?B?RFpiR21Uc2ZkTXUrZ3JUUkZYMmRJNkVLSE9ublJHcVpoV3ZwamJQV0xCc1A0?=
 =?utf-8?B?MUhESzNReVpKcWdVeEQ0Ty92enQxeWdoSllWSzYxbHRybVNBcXlOWDZob2x6?=
 =?utf-8?B?LzdMR1g5ektUc1NpQzBYRGVOMURsU0Q2eEhyU09ZbllDN0xucURDbGxoTnBo?=
 =?utf-8?B?MllYUU1tRjBFbUhUQWIyOVN4cG1tcDlQa3dlbWRJZnE4ZlNDTkQxM3dyd3A3?=
 =?utf-8?B?SG9INWdmYjl5U1ZyRW52RzI3ZWxnZDN5S2NxTzNVMkJMQU9OYzI3RzUrY2V5?=
 =?utf-8?B?SGtXYWpYc0M4Y1VsdS9jc2xhNk05Rk1KajVSclNYMmpUaHdLYnl2SldSYlEy?=
 =?utf-8?B?ZDA4dzcyUkkxTm5WMFdmc3pKSHpqTkVkczgzYUJHbisyTC9XcDlWeVM3ZWgw?=
 =?utf-8?B?SFFiV3Z1emY5Qjc4SjUzTTNuT1RKb1dlVkhnU0pPT1VoUFpsa25sSlRFZUUv?=
 =?utf-8?Q?X9FPoq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0NkUSs3dFNUZE1TQXVXUzZ6eUMwbjREMXVWajhvU3VmbDdEN0VaTTZaN1VO?=
 =?utf-8?B?ems1cGMvbjBNdHozSVM3QjBoZDI5eVZtSjdEZ1lFNkwwWURieG9vcHhDNkFj?=
 =?utf-8?B?MFcwOHNoR1JUdDhjY2YrR2hLeFR1RGJucEJCY1NkVWdScWp4MEtvN0ZBak5F?=
 =?utf-8?B?STVmL3dsVmpWMkZhclhJOVNaMklkcU02ZTd4SU1mT1E3b2Fpck1CZDdWbndF?=
 =?utf-8?B?WHZGV0RoeTNPZisvSG1nd1h1ZFlLV3JkOGs3Nmh6ZHhaSTJkZjFjSW8xTlJ3?=
 =?utf-8?B?Y2lSUTlJdlIrRGlub2tsczdJOWNESUlKWThjNmFKR2FvK1JrdXhuMW5UMU5N?=
 =?utf-8?B?d3A1MG4rUHJydkNhTTVFUUE4UXRZNnhzZ1hyR0hjbU9mNkhzeERONHM0bEI3?=
 =?utf-8?B?UFNmTnRsWWZqVi8wVUh4bXlJRUNhWEVpaVhiSmlsYnFnK0FBY0FrYXJvS3Jq?=
 =?utf-8?B?MnBCaXUvaFVSRlU0ZGFVRGlUSUVYUDBiRWVvNUhqWGpLeTdwWmowbTFlelFv?=
 =?utf-8?B?dmNyR0Rsck16MmJTR0pHd2hYUjZhKzNoSyt0OTBFNXRKaHNGbkEwRG9BbWsr?=
 =?utf-8?B?anlDQmt1UmZoazVVanRYZGNVOHhtVXFMTWhEYlg4Y1VlL0YwbzVWdlFEQlpq?=
 =?utf-8?B?WHc2S2YvVVptR2RsL2NURFNBVVdxNm1LRTNBOXN5Um94TEpSWFQxa3ZxTzJ5?=
 =?utf-8?B?M0VHNExORDJWME9JUG15cjN3NmxoekRNRFFSd3Y3d0d5MmpaVzIvc29LVjM5?=
 =?utf-8?B?M3RxUlhVSTEyQjdxNFBXQzRCNzdGbHF1Q1g3ZWNmZzcvZUx1OCthNDFmeUhm?=
 =?utf-8?B?WWRxTFhRd3FLa2dPalVSNnZNcE9HTXl0ZFhmTWRNQjUwdGNCNHorcFNGVWNU?=
 =?utf-8?B?Wm5RbnJmSDRFYitacVBlV3dHZFhaVTVWMjhXZ0FEMEVINXhLbUJGdTJzWTh1?=
 =?utf-8?B?WlB2dGxRaGZ0a21Ycy9NVFM1NTk0bE8yWExvK1hEZE5IMklpQlVQMjM2WGJC?=
 =?utf-8?B?czBMMjVRVUsyUllhcHFBME11ZlBXZnZnRkdGSkhrZlF1dnh4Ylg5OWR1ejFp?=
 =?utf-8?B?SDlDMFZ3YUg5b2pBVVVDQndKbmtuYnpvMCtpa3N6UTJBaHVQN09wTUFRNGtl?=
 =?utf-8?B?M2dMSUo2bVRNTGJUV0FvcGZWY1RDWTQ0MEE0b2NnNXdkUVdxOHZrWXhLTDli?=
 =?utf-8?B?YStwQTk0a1kvZ3dHUEN5THJId3hJaFpNV01aUEhGclNjRUJNZE93SGlLSnE1?=
 =?utf-8?B?R0dUM1JCWC9haWR3cW5BUCtZOEppS3k0Y09FYkpmS3VWQlZNN1haYlhiSUJB?=
 =?utf-8?B?NFZyQ2hzME1kT3AvWitRMy93SDVwc1htaEZRS0NqL09nQUlvSUEzSTZaOGYx?=
 =?utf-8?B?TzNmd3VrMEhxMHRScHRGSEJQbllBWW5NTTBCdm51cHVtVkpNTkdhMlpKSExh?=
 =?utf-8?B?UnZwWVJOWHlwT3hZUTlSTElXVUo0VXFOQWdOcEFBOWtKWExoSFlNUy9pOWRm?=
 =?utf-8?B?K25lQi9iREJ4clVTZUhOZ1BJeFo4VGtCM1RxMUJqd0tOTlBydHQzQ0x2Nmg1?=
 =?utf-8?B?OEQ4ZmdnTkhUV2c1V1R4RHkvN1hHeWRSeVNYKzhyOHdiR1dHamNZV25OcTQ2?=
 =?utf-8?B?SytES0xkRXFLb1hPN2hNYzQ0VDJpWHRWdm9hNTNLWHJNMmoyS1pNd0tXaFJ3?=
 =?utf-8?B?NEJoZng4a01ZWnJrbFlBUmFFa1NiOUdkSWU4SGNCbENlc1Njb0RHN21TcjZM?=
 =?utf-8?B?L1BlZkQxbzQ3N0lHNmZiVGVkblZ6MGt1QTJydXM1WXRZU2Z3Y1JFV3lIY0xJ?=
 =?utf-8?B?U3R2SFFSbkJtTHVXUzZqVU1WckpZb0tHRnhaZWNzZ252VzZRZDVsS2lRQVg1?=
 =?utf-8?B?U0FUMlpBaGdPSW5RUG95RE9SemxZUlVKRkRkaC9CUktzOU1NK2ZrVkphVXp3?=
 =?utf-8?B?N0UvMXZaNTFuTllOODhDOWEvY05POUEyY0IweFZsOHhqSXFiS2M4U0h2dEZT?=
 =?utf-8?B?SDd0N1ZVSERuSzJGYUlwaDFLVFBBUWFTV2Z3eFJnMFVDVGQwZ2ZLK2VrSzlx?=
 =?utf-8?B?WWQxNGtHT3cwRVNrU2JQdTJYTkp3cmlBRHRVYzR5SGdncGpyTVZ2bE93QUo0?=
 =?utf-8?Q?jte8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b5033-d2b0-44ee-6339-08de124cb122
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 15:56:13.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3a6pzAgJDIrZ3FHHoxAGzl4v90LHbG5e4cK7dYfRA1MDQoOgk1gzYp8A5X9l/daiPjSSLbxxQuEAvMOBziPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-OriginatorOrg: intel.com

Pj4gQmVmb3JlIHRyeWluZyB0byBwYXJzZSB0aGUgTVJSTSB0YWJsZSwgY2hlY2sgdGhhdCB0aGUg
dGFibGUgcmV2aXNpb24NCj4+IGlzIHRoZSBvbmUgdGhhdCBpcyBleHBlY3RlZC4NCj4NCj4gT0ss
IHNvIHNob3VsZCB0aGVyZSBiZSBhIEZpeGVzOiB0YWc/ICBPciBpcyBpdCBqdXN0IGEgdGlkeS11
cCBvZiB0aGUgY29kZT8NCg0KSSdkIGJlIHN1cnByaXNlZCBpZiB0aGlzIHRhYmxlIGNoYW5nZWQu
IEJ1dCB0aGUgaC93IHRlYW0gdGhhdCBwcm9wb3NlZCB0aGUNCk1SUk0gdGFibGUgbmFnZ2VkIG1l
IHRvIGNoZWNrIHRoZSByZXZpc2lvbiAianVzdCBpbiBjYXNlIi4gV2hpY2ggc2VlbXMNCmxpa2Ug
Z29vZCBwcmFjdGljZS4NCg0KTWlnaHQgYXMgd2VsbCBhZGQgYSBGaXhlcyB0byBnZXQgdGhpcyBi
YWNrIHBvcnRlZCBpbiBjYXNlIHNvbWVvbmUgbG9ja3Mgb250bw0KdjYuMTYgb3IgdjYuMTcuDQoN
CkZpeGVzOiBiOTAyMGJkYjlmNzYgKCJBQ1BJOiBNUlJNOiBNaW5pbWFsIHBhcnNlIG9mIEFDUEkg
TVJSTSB0YWJsZSIpDQoNCldvdWxkIHlvdSBsaWtlIG1lIHRvIHBvc3QgYSBWMiwgb3IgY2FuIHlv
dSBqdXN0IGVkaXQgdGhpcyBpbiBhcyB5b3UgYXBwbHk/DQoNCi1Ub255DQoNCg0KDQoNCg==

