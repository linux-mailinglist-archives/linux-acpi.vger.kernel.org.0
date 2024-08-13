Return-Path: <linux-acpi+bounces-7550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA79503B5
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 13:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B501C20945
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCD198E61;
	Tue, 13 Aug 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu+W74Lh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC60170A2B;
	Tue, 13 Aug 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548711; cv=fail; b=LYvBHo48PvfUnv8HR09A458J+MQZ+TGIR5I2G3X397z0BTqO/P0InOYkaqn9MqM5pOyDO4/VZbm7B8TSrHcl5j/ecpXFNjfTeLpxGPYVRuyQ9jiCuVMJKjtFAQvWI6sF2+4IIIZTkSrRwuzv3Tu+woE6YEPvGVxF/PfbCbqK5FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548711; c=relaxed/simple;
	bh=slh4G3L2PL3h1xb4/Y0Xf9FVfFZi8pF+ITLmc4Xd2A8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeEs9txE2svlGP3F1HwpwBU0mnBqB0DcyZueo61t1SW3MrHkRST8yV5ES+qzMmwMhk9fz9MTCKAgoOZCaHpiIId8cETG5D0MNV+/izkGTVEwHFjzHgaXrEVbdJH0LUooE322rsaTQJDxKQK3GwGE2VV7/N7j5PjVmFt+kV20bhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu+W74Lh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723548710; x=1755084710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=slh4G3L2PL3h1xb4/Y0Xf9FVfFZi8pF+ITLmc4Xd2A8=;
  b=Hu+W74Lhu+2wCPlGToTXegWQM4VgJ3wPs5Hk2UxsfDRsqyrvZPP6SDy5
   XV25WXrSHffdjxiiol1tsweq3IO5vlDTxRwR8vdcbT86PvxTpGQIwzu5g
   Ij1i5mpJrW1MTcHY2ax1BQb+pBOrsrAQJowoMTYdjxvBvTDX+4hkUHzmr
   54twxxFKcs5YQJUpAWORCQrK8ffW8XjMxuNVSI62ctM7YgEKdcoDPJv8G
   y9d0Qf13xM+3Prgi7j8c+u7TgWWsrVEa3Qgjl8qCcpGzxaSaUQ0bZsOlA
   iGr5DgweSxX1TLDW5mTabqOLHvwt5oFsQACDyUSGiaUTqbR7389NBcL2p
   Q==;
X-CSE-ConnectionGUID: 4Uk9peJRQ+Cty+DOZM+6wQ==
X-CSE-MsgGUID: d3F1IHuZQdKOGsewke4sag==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21873491"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21873491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:31:49 -0700
X-CSE-ConnectionGUID: nkdONMZxTbmxaDs1Pahy6A==
X-CSE-MsgGUID: Abyb95xKS4u5FDVD98F5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59208823"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 04:31:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 04:31:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 04:31:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 04:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhRfoQ74rWc0UdfWRrRESbS01SdLcYuc7fm2Zedaez2JAcOhvHAlumStf2TkX+W7D8eyA73fe0xZLmlkChlSrsFKAKxI8pArrVzTFYAHPbJwszScILVrQphU1xbg56cL5xPum0Vwn6TwwBFaXTJ61WwKlXbCdraRszSHsHcTqDDUhamEARoqcmiJxZ9JHthszEpdZ6q9vGLy6CIc5RnC2sqCTZo0rOzooepKEz0sWrNx0o3OP0F9bhq7A53kFLjBSzBU0i9OCmavo9X+2iXy97Q1iwbSK+6ztxtFlb/6HGO0ENf4jIWfwxCPe1u/BJiiCOO4/SX4dKL+jQlrUKtCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slh4G3L2PL3h1xb4/Y0Xf9FVfFZi8pF+ITLmc4Xd2A8=;
 b=XIs8yru3099MaitIsVuhXxLBygsfYwoTlguJ5a1xP0dpk3KxYsAWTcltCwQALXZ+cg5RXMjIlAXWFfSoR6lgESqINPfr6ExuCmj3qlVOTJXkRn/EOmPXTOcGVoTZeP7Uu1qwOEvcmkRBlCD2aBVCGVXqX6bbrD0PESihpeMJUJzWzE/AwwUHdP6ClknVItVccgC2npUy+f8I4QWaGJT0SdDUOA9yNKrbO5yP4x+/Ub+fRnLCHGoHS3x0U5AHdL/HZDSAPoPYg6GFFhs0tnpcj4rPCDZXeXevZ3Y6msE+vk8Wm2Z1KSFkIxGALIlWx9UgN+tLYI7ujVPluthL+CeQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by CYYPR11MB8305.namprd11.prod.outlook.com (2603:10b6:930:c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Tue, 13 Aug
 2024 11:31:46 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%4]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 11:31:46 +0000
From: "King, Colin" <colin.king@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>
Subject: RE: [PATCH][next] ACPI: align slab for improved memory performance
Thread-Topic: [PATCH][next] ACPI: align slab for improved memory performance
Thread-Index: AQHa6eFfvxWyREIekUC5nF8jxVinqrIk/2sAgAAApCCAABJdgIAAAXyg
Date: Tue, 13 Aug 2024 11:31:46 +0000
Message-ID: <CY8PR11MB7747089744F68731C92A45188D862@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20240808222138.51-1-colin.king@intel.com>
 <aaf516f8-eb36-4693-a002-a972d6f77b92@molgen.mpg.de>
 <CY8PR11MB77474CEA74FB6A572D9856D28D862@CY8PR11MB7747.namprd11.prod.outlook.com>
 <04c0b62d-03d7-460a-a4e1-ed8b9b094abe@molgen.mpg.de>
In-Reply-To: <04c0b62d-03d7-460a-a4e1-ed8b9b094abe@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|CYYPR11MB8305:EE_
x-ms-office365-filtering-correlation-id: ffaff5b5-995d-4a96-1297-08dcbb8b8396
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VTcwWnU3VzRac0tveGU1N0ttUWdwcGlKNEhEazZ2YW1XNWZQUlZ4OFJGa0ZH?=
 =?utf-8?B?SEhLYVF4bmFFK0E5ekluU3ZlSVpsTVVFWW9nVjZRMUVPeGhTUVFUVFZmWTRH?=
 =?utf-8?B?ZFNnbkI1V3g1VFJNaE81TGlXUmpvRmlVYzRRdGo5RFlCUUYvN1BzbnJsSENp?=
 =?utf-8?B?N1BTL3JwQXdtRncrZndSRFZ5WXNCMHdNK2E2dGhVU0txelJKYUpHRkNHNjk0?=
 =?utf-8?B?VW1FN2dyUnloMElkcWFHYWZHWUVSR2hhZHFuSW9oVWlmSFBmZENEQ25yQktB?=
 =?utf-8?B?bHZURUpIejdGNkFkbksrVUgvdHIrSXQwRXM0TzNkbUo3R3ZrWnFST1lvZkhL?=
 =?utf-8?B?RklmSkNkRFNySExicFhJNEpnbzRpZVpxZXVkTFNYTWZYRHptbUhvM3RmeDNF?=
 =?utf-8?B?ZXUxNmk4VGhmalNmNWxzeDFsRVVGaUF6Yi9uZUhpR3hQZlg5cFROeFhpYkU2?=
 =?utf-8?B?NXlUOVQxZHZNcG4rU01NV2VBaHBVUkdBaDJkUFdXNEtpemdlRitoallGZm1D?=
 =?utf-8?B?Y1doTjl0V2VxbWJIbGNDeFZMYjhnbklKMzZYVU9QQWNFeWJEMXh6eVVIU25q?=
 =?utf-8?B?UytsMkNMbjJKOHpwSXhRK0ZzUVFmVkR1NlY2amtvYkJoT08vbENLSHRNU1J0?=
 =?utf-8?B?WWg1b1J6VWhFK09WM3E5ODdpRkJiRkpYR1lZVitIbnNZcUxQYVJtTk5rdHVL?=
 =?utf-8?B?WE02TlhFa3ZUMU5yY2VYR0xud3pUUVdqNTVROU45R2F0cUZIOWpBNzF3YUNP?=
 =?utf-8?B?U2EzSFkwMko2a1VDUk53Q0dYZTg0Z3M3SGV6THJVUjNyZnpqQXRWcG5WZ1RZ?=
 =?utf-8?B?aE1GU1MxTTRHVjlNWk5ldUR4UkRDM04rM1ZNS3dFQlcxUElDbG1ubjVyQy93?=
 =?utf-8?B?MUlZWXpOVmYvQVREalhjSXVFQkRQdSt5V0FmQjdVT01hMlpBZjZrdVAraEVQ?=
 =?utf-8?B?R3RJYktLVzdsVDVEYTJOajdFbG54WENlWkNtR1dzdzlaaFBCTVluWlFob1Er?=
 =?utf-8?B?cEVlV1h1K0Jid1IvVnRZVEcxTTY5OUpuNFlBMDBqcVhsSUlTcitVbEtzaURi?=
 =?utf-8?B?MURDb2diTjRpVDF4YU9WcURnTDM2aUROK2xiSklWNml3M3RseXJKRlFOV2gz?=
 =?utf-8?B?MVNCMXdHWmlhOHBvRHBEbDYwb0Vkck1BejU0NGdNQjdVR1hNYmhMZ0ZRQXl2?=
 =?utf-8?B?R2pyMDQyd3d4Z1FrdUFDc1E2MU05dEp5SVo5bk05ZXhIMVlGZDE1ZkhYMkc0?=
 =?utf-8?B?Qmp3UXlOTERVYS94NUVrYkliVXNnZjArbmtVdTlIeHNMYkhjWnB5RkdFK3pi?=
 =?utf-8?B?clB5Q1NJbStSNnBFaGIyNmR3N3ZieXFudTN2UzBEQ0lDM2dwMm8zVFRtaVhJ?=
 =?utf-8?B?a3BkbnMxS3YzVUtNOVlrRXBTOHVYWWZ4MDBnVWF1WnZVSUx1SXpQeUV5b3lm?=
 =?utf-8?B?emRXTWdndXpmZ0hmUzk4RnoyR3BlR1VoZVdrVmxsckpwU2ZMcGZhZHlJS0JN?=
 =?utf-8?B?Y2M2TnFBK21tZ29MYWtBcTJZWW8yTEgyY1kvOVJlOUdSOGpHSUEyV2MxU1FN?=
 =?utf-8?B?aDZVUmNsbXkxZGM2elVXWlFhNThGcGtHdjg2aHViVHc0K1h6WDJHRjRVZTJI?=
 =?utf-8?B?NmRJZm43VlZkR0VTNno3YThuOTl6ZHJUYjZReHlQdVQvK2VacHh5WmFUWDlY?=
 =?utf-8?B?SHJ0S0JMaWs2K2pOSUQzZmVQc3cya1BIQnBLa2Rud0tpS21Yc3FyYVlwa0lK?=
 =?utf-8?B?MVdza1ZORUlEdS8rMjZvRGFQRTBmR0dIek42RW1rSTRCS0FsMWVzaExNZ3li?=
 =?utf-8?B?SWc4cHRmU25ValVHaW1TOStnaVBSN1V5aWpTc1V3VFNqMk9oclh2aHZmdXpO?=
 =?utf-8?B?QVRrS2F6YXRtRXh1c1k4a05nOHBzU0F6dGZwU3BuT1pPTVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU15UEppOE9ENEhJVFVHNXd0L1JnSWNaNXQvaldpSUdlWkczNW1YYTdPUWNO?=
 =?utf-8?B?Y2tUaVJwdmhxbWNieFlhK0w0RmZWemlyc3FFdHJLMEpvcVJZZkdSbkF3Ritl?=
 =?utf-8?B?dHBVWUZPYlF0eDFQOFVUYXpKdHRxV0duOGVBcktYdnJYTjMzWGlvQ2I3dHJH?=
 =?utf-8?B?YUhiZ1ZsWFc1ejlUL1pMbVdRNlM4emc4TldBaHgyUkxPWmNEeEd4ZWNacnFo?=
 =?utf-8?B?eFMvdytFdjZxNDBsb1loTlpWbXYvK2NzQW1ISzR1RDdodERhRkxVRFpmZ1Za?=
 =?utf-8?B?cEtDN2czZmRLcUVJUHJoRkY5OEZ1a3VTYitIU0gzL2ZWSDRLcFU3V0NqWXMw?=
 =?utf-8?B?TWs1dWMxMlZkU243NWN4bmRaZWc5TnlaZmNWWXY4S0NEbUFuVnZ6eVV6eE5t?=
 =?utf-8?B?d0VlSWN0WGlrbUEwZElTS0pmd0JVWTByREd2RDEyWVN2TjZXaGFTNWJxVm1Z?=
 =?utf-8?B?enJudFN1Q2tKbGlPUDlwTklhUXB6d2ZzWm9VSVg5eElwUlZmVVFsQzlEeEE3?=
 =?utf-8?B?dVUvWVg0bG1la0dQb0FZZHN4S2pUZE9HWkNxUGg0MEFUTlJtV1JqUVFkbzhl?=
 =?utf-8?B?WUozUC9FSXVJM3Y4WFdiQVRvY3IxZGxWbndPR3RleStvM0UvYmhXNEhRYjUz?=
 =?utf-8?B?RHEvQ2gwL2N0K3ZITG9abVlScWhJUDZOaU9nR0ZOUUUxckpsNjV1S3VUUVRl?=
 =?utf-8?B?TUo1dUpDMGFERHpicW9TTGMxTGExQnM3U1RSRFErVHBjWG1wRXpRaUY5Q3RR?=
 =?utf-8?B?USt6ZlJ3eC9HMGxCQkFZRWR5WTJhM1d4QzQ0R0FFWUFmZEdEa3NMYVhzazJY?=
 =?utf-8?B?aDZhYWl0VTl3MThpZzgwMWFybldsSnJWbzg5eXZpeTdlMlhpQklLSHlOSENs?=
 =?utf-8?B?Q3RmYkowVytGcjkrbVlmcGsxV0F3VmpPakFmbVZOMVBBa053TlkvNDF4Q1Fa?=
 =?utf-8?B?VDdIU210dWxybkl2VFdxejNWQUFaQ2tGWXIvQmFYWmFQS05takxkei9sdXEr?=
 =?utf-8?B?b3c4SzMzRFI2TklkaHlpQzZyS3RranFEdnJDMStLNnlxdXZxRjZoSXhKYmdi?=
 =?utf-8?B?OEQxZ2ZPMnQvUmF6dnRQUUJnL2RyekFHM002OUVORk1UVTFucmRON0JkQnk5?=
 =?utf-8?B?S2NBc0pCL0dWRHdxQkhCaVA3d2lKc3ArK09IczdiWnlvY2twWkp1bWg4aFJi?=
 =?utf-8?B?K2N1d1JiSmk2L1RyMEpNdUFFZ3lZT0ZJejlwNXFBcmlLUFBjaTBuMUFIOTVH?=
 =?utf-8?B?emsrdWZtUzBtbHFSd21tb001VCtiWS9maS9OYlYyMU1CVEVDcG5vUTdFMVVu?=
 =?utf-8?B?RXBpN1NWdlVTSkpxaEpqTjZCS002czJhVlg5UnhyQmVBZ0xPMVFSbGtzMVBq?=
 =?utf-8?B?WHU5Z2Fwd2wzbEg3UlljYTV6dWRMQjh3WTJtNUF5N3l0YU5Kd21kb1haelF0?=
 =?utf-8?B?MElyaUxud2pyZFhYdTcvcTNnQkM5SWhSVzE0eXRqUS9ZSVhQTmx3VVNoNXpF?=
 =?utf-8?B?aDRFYm92RGRvaGxxNm9jekZlbWNiaEtSazVtdldzZlUxbGduUEVvN3N2aml4?=
 =?utf-8?B?UnU2cnl3bUNwcm5GWloxWEtVeUEvZ1dQZ2Z4RjJaTkovNkFjdDlvRlZ1U2JM?=
 =?utf-8?B?WXZ6V1pmTFk5aXZWTVJXV2JTN0VvYnZtb0ozRTlpaCtOWEs2eXlMdnI5Z3NE?=
 =?utf-8?B?MEtkVGpUeUxkbFZLbExRRTlUZk1WSHlVM09QTkQxOTU3VDI4UzQ2cXEwVjg5?=
 =?utf-8?B?OFFrTm5vMU1iSkdtQnV4Z2pWRWI4ZjIxa3JuWFA1QVBnRGgwR0FBVlpYUDZs?=
 =?utf-8?B?N1hHU3BMcmxZdEdTblhqZEIvRUE4MTZKelhOU0Z6eEZGK3laL0RLUFAya3JL?=
 =?utf-8?B?VjNaN0l2Y0RQbHl5eUZTYlNIcEp5Uk10UUxoa2I5aUVNQmhTZUlDbitCb25l?=
 =?utf-8?B?YXZSWXZ2Y0VlY1c2QnIzN1BXK3ZINHQvYTJzTFNTNi9IRnFLb000S0QxcW5n?=
 =?utf-8?B?RUNURFB4aWg3THlUUDhLNjB3UXpDbGxiSEN4OTNJOGNYOWRxclQvMTh1V0Fp?=
 =?utf-8?B?WmNXOXZaTGNVRklvVGw3dlpNRG5kRXlPZnR5dDFrTzlYcUxwNTZrUHNDSjFX?=
 =?utf-8?Q?6oiCLWdaPV9CLi7qi9Ow8aN4l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaff5b5-995d-4a96-1297-08dcbb8b8396
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 11:31:46.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiwULOG5Wqbd60w7FhTBivXEZ9ryTG+/83YBvYl65nebY37xDQ2vboiy4J0HRP4vfL2BX7S+B+F0aHpPf/IDCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8305
X-OriginatorOrg: intel.com

SGkgUGF1bCwNCg0KVGVzdGVkIG9uIGEgaTktMTI5MDAgZGVza3RvcCwgQU1JIEEuOTIgQklPUywg
TWljcm8tU3RhciBNUy03RDI1IHN5c3RlbSBib2FyZCwgMzJHQiByYW0sIFBDSS1lIFNTRCBhbmQg
VUVGSSBib290LiBSZXN1bHRzIHdlcmUgYSBkZXJpdmVkIGZyb20gYSBtZWFuIG9mIHRoZSAxMDAg
cnVucy4NCg0KQ29saW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwg
TWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+IA0KU2VudDogVHVlc2RheSwgQXVndXN0IDEz
LCAyMDI0IDEyOjIzIFBNDQpUbzogS2luZywgQ29saW4gPGNvbGluLmtpbmdAaW50ZWwuY29tPg0K
Q2M6IFJhZmFlbCBKIC4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxl
bmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz4NClN1
YmplY3Q6IFJlOiBbUEFUQ0hdW25leHRdIEFDUEk6IGFsaWduIHNsYWIgZm9yIGltcHJvdmVkIG1l
bW9yeSBwZXJmb3JtYW5jZQ0KDQpEZWFyIENvbGluLA0KDQoNCkFtIDEzLjA4LjI0IHVtIDEyOjE3
IHNjaHJpZWIgS2luZywgQ29saW46DQoNCj4gVGhhbmtzIGZvciB0aGUgdGVzdGluZy4gSG93IG1h
bnkgaXRlcmF0aW9ucyBvZiB0aGUgdGVzdCBkaWQgeW91IGRvPw0KDQpUd28gdGltZXMuDQoNCj4g
SSByYW4gbWluZSAxMDAgdGltZXMgd2l0aCBlYWNoIGNvbmZpZyB0byBnZXQgYSByZWxpYWJsZSBz
ZXQgb2YgDQo+IG1lYXN1cmVtZW50cy4NCg0KV2hhdCBzeXN0ZW0gZGlkIHlvdSB0ZXN0IHdpdGg/
IFdlcmUgdGhlIHRpbWVzIHdpdGggdGhlIGFsaWdubWVudCBhbHdheXMgbG93ZXI/DQoNCg0KS2lu
ZCByZWdhcmRzLA0KDQpQYXVsDQo=

