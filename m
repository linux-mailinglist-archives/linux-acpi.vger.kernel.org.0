Return-Path: <linux-acpi+bounces-20453-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBxVCu6hb2kLCAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20453-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:40:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F940465A6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE68466D6F6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77373D5230;
	Tue, 20 Jan 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdrT4bFX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091743CED9;
	Tue, 20 Jan 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917815; cv=fail; b=nRqFAvtG1dlVIc0Cthx0physPW7R1fxtZDZWah7T99k3k4x6VsoWLn2HsH36VmYwr63iGHWDaeL8md5sDfB9P0hL/zv69icjpxRPKQNVd8ObPry8+DTF1Es8lMrfmRAkWFsHk5558vQIpJU4BDPRDGLno+StU3O63xQNVZ89gFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917815; c=relaxed/simple;
	bh=nYFJ2HaTydIsNJ/Iv6zJNu8Dxl+zFUSzforIrH67tEY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEi1Q1WOEGCTLu6vquw9bXbcfTO1jXlZFhNVWrL+yd7dQ58ie2RcOi+6YVpfVQybJ8fvbPk38oUOIT3QRmAv3kbjejT0F5hNi2J+SAOZsRNIr0PzUDWVcSiX10XvSeRNis7rvVwmmbqn9OxgrpbSkPpcWINp1uT/fSS8kecBNXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdrT4bFX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917814; x=1800453814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nYFJ2HaTydIsNJ/Iv6zJNu8Dxl+zFUSzforIrH67tEY=;
  b=gdrT4bFX6GJXNlKJZO8o7WD1XyhMP5pg0WPd4s6VwQiNQ+OIUuSFrDll
   OwhlQWYhppR3o9hQrPCe0a/oYRzJ1NmxCGFTgGh7KoH1wy8zcgdtaw6jE
   wlpB7VPYdkBLuW4kPSYJ6qBnB+AkCYgeribQqDbTFRR0yHAgU8JzvkuxT
   bbvvkEcClqrksnRh1Whn9fdANVrHdaONZhJYWoGKcC6zbEPUzt69LEEnz
   BQJ8ZFLI6tqLtC/i7uE58psQoSl+ePA8qrgPnE7dwwRZg3/68uAHFrKbv
   8HP2EPTK2+b9eyuciiNZEQdc+R7UFY5xw5iPPk/uYn88uhTPuxTtxp9Th
   Q==;
X-CSE-ConnectionGUID: 0BtS+QkDTvyW+ntE66qudg==
X-CSE-MsgGUID: HdOtZ1ASQ3CBT/ylsuaCrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70030207"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70030207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:03:34 -0800
X-CSE-ConnectionGUID: LjNK6VgVTduwy3xz+3WqCA==
X-CSE-MsgGUID: 5rOFXgW1TWSRBLtM1Tzo+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210277761"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:03:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:03:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 06:03:33 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 06:03:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrIKeB+pFYHjWUgZ7aO+W+mKbOyV3BlcGMlAorWcyTiPpBYsOGtJUfjE+Iu+0LqFoahGVkFHxezS4NriffEFlm/kgMjIu0ba5kGSekvhcHj1Y3dHTFPEqqouaZh0yrjNrsW+siDeW6rtvmPWTdk4CeCth02HiKPZwW8soqykwQ+MNE/ef6OtvA2E0AWdK1wld2/eyVpUQqLoYIhqVlFhDfeBiksfJ5QRI79mvPYobdiTC8M0c66aVklW0nOwqnIe/4f2r4vjU/V14yWR/6a6V0Gbs1o5YE3e6su0v/y/2lyw+c/EcqmwjcXVGAWm3fdVMu8SHq8AvX7zSSivBu+m4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5rEJ2xEpOvqHlG5arIgLRLYbtYJXYx1rRrzkEWAzeA=;
 b=uej/6L8aSA/9cEAHjT2FY8try6k4cqjSevuwlz7COVODYO5s8KUXd/zsx5mEcxsf2PD5k4Eq87O/nn02nYI8xScU7H6fR6yjEGk907rLV8D7u9w6WAp19iHFC/MZ4CulGa89xeiPlUw3FzkZPtlvS7eFXsJFpUtLmY/HRzyQ4/t2qJFw1W89LB/+pltrq5xLy7Ftd5vV54y0Tchilih32C4j7u2TplldWA/NWK7ZGp4Jx00mVOalHkpFar9c85UgBB57lVvCgTyrVZHhmykSXIKR7mkNIAU1OsUwg38jjD8Hm0qk1TgUOUajNR3H+4HlWZ7dt3LVvxRiYglVn4utjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by SJ5PPF0D43D62C4.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:03:30 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 14:03:29 +0000
Message-ID: <f391a681-3153-4296-851b-a4db3cbc8de1@intel.com>
Date: Tue, 20 Jan 2026 19:33:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <varun.gupta@intel.com>,
	<ville.syrjala@linux.intel.com>, <uma.shankar@intel.com>,
	<karthik.poosa@intel.com>, <matthew.auld@intel.com>, <sk.anirban@intel.com>,
	<raag.jadav@intel.com>
References: <20260114202419.GA831656@bhelgaas>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20260114202419.GA831656@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::11) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|SJ5PPF0D43D62C4:EE_
X-MS-Office365-Filtering-Correlation-Id: adfcdf66-5b54-4c6e-16cf-08de582cb07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjV3RWdaK3p4Q2hINk5ibXUzd0Z4U1BzalFnc3pxVFc2alVaUmRpYi85cThX?=
 =?utf-8?B?L1d4ZTd2UEZrZHlyUmt4Umt0TEFYSE8zTUFCUHNOTTZURk9UMFl3NzNsY1JR?=
 =?utf-8?B?ZUpRejNWL3RsUExqQnZHZGV4aG1rcWNoVFNUNzZTejBHbCtmTzREQkpvZjly?=
 =?utf-8?B?QXpuUE1jYkRNRDVHb294L0lINDJzd2NPY3NWdzJhcUVhM0lCa2N3ZjhCNmc3?=
 =?utf-8?B?SXZRa2dsaXdUVTV4K1l1RGM3R1A0WEVFa2FHNjJUWXhXMU85UlJwaXJaelVl?=
 =?utf-8?B?OTBwdENZYytqclE3N0VEUlJNK0NPWHA0TDZkOVZMYjlxVmtRSmxQMXpsbzZQ?=
 =?utf-8?B?ai9QazVTdUh1dU9HYmlRUjdMTks0bGVrRGhzRXFIY0dNZ2pUMjVJNmVlZWIx?=
 =?utf-8?B?ci9JTHo3b0V2U1lERThiMFZOcSt6ZytJWVAxNzBGSWVpMlJuZkVPeUp5VWE1?=
 =?utf-8?B?aXZYdENsRmliNjh4M0ZKRjZOQlZMbkpCWGg4dVJaV1BFWXR1Y0ZJZE5IU3Zh?=
 =?utf-8?B?T3paNVBja3NDbDMrM1dNVlFPNnlnZFRpWnFQT0lVT2szRllSMUhIVEtwSTE5?=
 =?utf-8?B?RFl1czNXMHhZd2lPdkNGNlNLb3RleVIvUlRVNTJuT1lrUVU4YVZJSTJMdHd1?=
 =?utf-8?B?SXBhWjlGWXlrWTNMV3JFOTJmL2pKTVFaVE1DajljbWY1M3F3aUtobkhiWm9Z?=
 =?utf-8?B?TzYwOE5GdnRDQWVnWjdlZ0ViT2xXZEcraUdSajRmdUpQVzZScE9HZUJtQi9Y?=
 =?utf-8?B?S0xWTVBwYndubG1zM29yRFo0YWoyY043MmJPY2NQckRuODRHSlpJM1FaVDl3?=
 =?utf-8?B?d08yQTZON0Z5TGhScU9NT0VYbDFNTXZRZXcyWW5oZ3krWDloK2ZvdVo1VHVS?=
 =?utf-8?B?ZjhqKzhrQWQwajZRQllnd0dBU0R4K28rRUl1Z2JJTG84d2M3dVhFNXVNVThQ?=
 =?utf-8?B?RGxSK0pCblZ0VFZRRUMvREZkeW5mSEM1dFk3MU5HcE1sZ2YyZG1DYUc4VkFS?=
 =?utf-8?B?WWY0Z0RJMEZpcENIUGYyMGl4S2hObHRZT3lxSTJ0eE9BRHNPdGY1V3FES3Ft?=
 =?utf-8?B?QkpCek4yWWF1aWh4YzZnOTJiSUFlQ2FDN0JNNWRodTN5a2dPSE41UktVaWFE?=
 =?utf-8?B?WXR4WExqNDAwWmdnVm8wdktCSXYrQ1YwU29qeDJwTFZ0VC8yRFVRN29DQklk?=
 =?utf-8?B?a2hSK3RaZi9Jank5bFdSb3VNclAzYWRaRzJUWmJmTi9ZZ29LejR4NGt3OWYv?=
 =?utf-8?B?NHpwL1loNmhmK2w2eXJneHg0cTJTNUxadk5GQkF6R210T3EzOC80UkhESUg1?=
 =?utf-8?B?Sm1tY3RGb0EwdXBvK0VPeTIzYmpmRHFhdkc2YlE3QXB5ZFBJVkZ2UUkyaVkv?=
 =?utf-8?B?UDFQeHBucEFuTy9PUGhPTzBhQU1ocytoNkdGY1ZsMmRsa3dIQ01uUDR3Sm83?=
 =?utf-8?B?clB3emhZRTNObUx3OGh5NGttTlczNnJhOXc5UnVzTU43cXJzMmcyUDlxWUVz?=
 =?utf-8?B?dCtybHhWS0IrQUdMcXpOUFVISStCVytweHV1VHlVdW50azJTdkJaVTF5dS9W?=
 =?utf-8?B?UW1FVmNGN2JLWGRwSVJrU1F4cHZFKzVnVWJUQjVjcXJ5U05KdXVsc3pGVUZh?=
 =?utf-8?B?TERNb2lFNXRjOUFTS21NSFI5Qnh3SHlVYkVjVDZKbnBmakU4aDZrcTRySjZa?=
 =?utf-8?B?Z2lMcTBSTitvdDkzVlp4ZDZQYXdTQXBNeEtMSndydCtWaktLenFnaW1EbHNK?=
 =?utf-8?B?SjVYUDE5ZXh4L1dVV1ZmeDVqZVFJaXpUSThLUnJqaS8rcExGTjVhTVhteDc2?=
 =?utf-8?B?OEZ5WnJFdTVhNFAzQzlTVXhpUzZrOXFPSlpVTVdwMThObjdmeWpvSzVlUWcz?=
 =?utf-8?B?aGFvakhSMDRIcWdPaWwwaEI0WUg4cEFGSnNOcUNBUCtWN3V0RERpS1BndThG?=
 =?utf-8?B?T0Rjdm90Y29jRWY3blp1MW0vRGxNTlFJNDNmaXNFOWF4Q1UraTdmN2xlMmxU?=
 =?utf-8?B?ZHFNazlwTEVZdk5FSlhtQUV0MkNLdk5EclVQNVY4dmt4b29MYlhueE9GUnVZ?=
 =?utf-8?Q?AXcqa5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ZZSVZlRlVMZGlVREIzUS84ZGo5Mno1emQ4bHBpUEkzbVBHYkp1YXRoUk5l?=
 =?utf-8?B?RFFIRDRzWGdURFFEWkJhWXloeG1TaGxiTnhnaUExeTVVY0dEMDNWcnNGckhK?=
 =?utf-8?B?T01tWC9VWDYzYUxlY3JoY0pRK2g1NFFMYWQrOVAzc3pmbTJBSWp6eVV0QXcv?=
 =?utf-8?B?RW1IdFI1enN5S3dFYmZJK2hiQkdnTWpRVGh2YW93QnVKMkhxbFgzSm1oL0xi?=
 =?utf-8?B?VFdocUpTVWdkdUVQYXR3a3FEdTdYYlJISUZoT3V4b2FFdHplRTY4NWZ1ckFx?=
 =?utf-8?B?Q1c5U1BrN1lic3dGYk8ySWdtVWczbWIvT2syWmpwSWVMTE9Hak0xM1p2dHpw?=
 =?utf-8?B?Wmg2NEJkOWNYaXFGd29FNHFjVnBFcjN3ZE81TGNsS3d2dGlvaEdHdmtsWEVG?=
 =?utf-8?B?YTg4MStXNExwZUo3Skl4RmNBSk5CZUsvMkRESU4xRE9WOXl5RU5CWVlOa2p5?=
 =?utf-8?B?akVLTHBhaWNLOHk3WVhUQzMyK1NqYk1ZZE1IaHV1dm9Ydk1FUW1kRXdBRnpt?=
 =?utf-8?B?QStTQkkyREdTb2doMERlbHBPVnZqNjJPSzRHSnVMRW41ZDRpUXg3c2h0c1BY?=
 =?utf-8?B?RjhrZkt0NWthSy9jNEpTRis1THY5SHliWGpJbUZzaVRmbnRlQmdzN1pydndR?=
 =?utf-8?B?ZW9PMGNhQkhIN2Q0bStxTDhHSEYzNG5Oa1pPOERaSyt3aC9hckFjbWlVRzhq?=
 =?utf-8?B?VnZBOGN2WDV6VFN6NmRvU3VqZlZhMURjMFVnOWVmYmtobUNVMWxiNm9zLzYr?=
 =?utf-8?B?V1VMUlZ5bVl4TmFPVXFZcUM1QzVONnB4Z1ZNTGFYSjFUdWpPWmdhcXo3Sldk?=
 =?utf-8?B?ekJNYmI4UEZiVFR4NjdTaEU1QVVHZmNQWGtXV0tSVm1LMG1zT0lUV3pXbktT?=
 =?utf-8?B?N1hPVDZqcWltVHBnMWFwZTgxbTRJUVB6SWx0cUlWcnJob1VYdk9CZmZPeWZm?=
 =?utf-8?B?LzJoWG4yc0orM2RjaFFESTEyZHdvTzIzWTVoSW9ldWgvalFQYkZ2MVpmYnJW?=
 =?utf-8?B?Z21GTktNYXdPcjhlTUhOdUxZNURNQ2djUUF5NEhUSW1VbHI4N3VVR3MyenR3?=
 =?utf-8?B?SDdRbmpxNHZxS0o5Z2dGRTlDMTFVU2hjV0lyaklWSlhqS2I0bVJRL0Q0Z0Fj?=
 =?utf-8?B?R2tHTlBUbGRTT3JTcE9jeDAwTE1xZWJoMTRLYjBMY1pKNUVwU012c3RabmZX?=
 =?utf-8?B?bDkrdmdwbVlld09tWUVmeEJFcXZ4WmhMQ1h2R2c5TUswdlg3S3k1Rk1jZEZZ?=
 =?utf-8?B?SE5JMUNIVUxXcHdkOFk2UXpleDEwdlFxbFBxWkxLVXNOSXBzV1ZlWjJkZXZs?=
 =?utf-8?B?UUFDcGszbmpROURTS1c4dStmRVlMU1ZiZSs3UmFPZ2JjM2xTayt6aU5yQ1hv?=
 =?utf-8?B?Z3EwaGNWUUVjUTgzQ0RpNTVVdDIycVFJYkVXQjZBZTZKdjVCZVgrVy9Jd0hX?=
 =?utf-8?B?MGJvRjZ0dWsrM3d1YkE4LzFrbHd1ZXJMNFBPUFpKUjZnM3VSZms4WHNSY280?=
 =?utf-8?B?Wk4wVGhSRnNNTW9VNjJEMUk4US94bmYvSk5MQk8wTXhnR2d6cG15QTQzeVNu?=
 =?utf-8?B?VVhjeHZGam5lWFpsNmdMU2pjNzNEdk11RG52bWVzb29CS3lSRWdob1VSdFhF?=
 =?utf-8?B?ZzdOZHhDYW9YdWh6YXhvaWRiRC9CcEErS0piWGxrZ3FSdnludnA1VVFwcTVv?=
 =?utf-8?B?ZW5BSWRNa3NGc2NuWlJHVFZtcnBsTThiT3lDcGlXRGlnRnYwOGZLdElxOUZS?=
 =?utf-8?B?NTlud2h0QlBxazB0SFM3emprSmxmVys5cU9JRDMrVnMxZ2N4OHMzUHZZK2lC?=
 =?utf-8?B?RXkwSUNVSEtGWVNVTjllOHZxL1hPRUswdXhPcUFRYVZZWThpdGNHWkRJemxz?=
 =?utf-8?B?QzRHN2I0ajNhZWZHT1ZvZFdBQjlzcHlwbGhFWWJkWktQMmtGZlRtTmNDRS9J?=
 =?utf-8?B?S2o1bTV1c0cvQzk5SWhUM0cvdmRodUVpL0xsaTFLT0NzRjFuZUYzc3pqeHlI?=
 =?utf-8?B?NHR6T2p3MnhnUXhYelREZDR5bnM0NGczNGw0b2owNjNSMXdOc1ZodC9UcGlD?=
 =?utf-8?B?L1U3T3hWVTBxbHNvbGxnT0ZOTExZQSsvWTdidUw4aUJ3dUlHY252dHFUUXMv?=
 =?utf-8?B?djg1SWI0VlRDaFVTWGNYMDU5T1BaQXZwOHJIYnNyK0ZJMDVZeHp6bHd4bThs?=
 =?utf-8?B?Q0YxMFlyV0VpRDBsWm9uSEgwaytrdnFYZWRZLy9Tc0RsSDcwSU1iOE96UFJi?=
 =?utf-8?B?ODgxYzJTN2p0VzNEaDRMUGxUOFcwUWdkYTQ5cWNEQUJJalRHREk2UTZ4SU9K?=
 =?utf-8?B?ZGdwWnRTUE91cUV1VDc1RlVmNStJckZwc1pFOE0vSHNEdisrRW5oQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adfcdf66-5b54-4c6e-16cf-08de582cb07f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:03:29.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX1L3DLkZAx3ylsFW8e1woBETiga2Z+NRm9sV82Vjg8RydlDBwDmzcbietRzaMCRHxw7i25pUgW8u+LU+3NnPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D43D62C4
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20453-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,patchwork.freedesktop.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8F940465A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 15-01-2026 01:54, Bjorn Helgaas wrote:
> On Tue, Jan 13, 2026 at 10:12:02PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM method 0Ah, as per PCI Firmware r3.3, sec 4.6.10,
>> to request auxiliary power required by the device when in D3cold state.
>>
>> Implementation allows only a single device below the Downstream Port to
>> request for Aux Power Limit under a given Root Port/Downstream Port
>> because it does not track and aggregate requests from all child devices
>> below the Downstream Port as required by PCI Firmware r3.3, sec 4.6.10.
>>
>> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> V2(Bjorn/Rafael):
>>    - Call acpi_dsm_check() to find method 0Ah supported
>>    - Return retry interval to caller
>> V3(Kuppuswamy)
>>    - Add NULL check for retry interval
>> V4
>>    - Define enums for aux power request status (Rafael)
>>    - Add Co-developed-by and clean up Signed-off-by (Kappuswamy)
>>   (Bjorn)
>>    - Instead of root pci device pass the pci device of driver, traverse
>>      up the tree and discover _DSM
>>    - Allow only function 0 of device to request aux power
>>    - Allow retry_interval to be NULL
>>    - Refine commit message and function description
>> V5(Rafael)
>>    - Remove function 0 check and allow first caller of the given
>>      downstream port (with _DSM) to requst aux power including
>>      different function
>>    - Squash Patch v5.02 to this patch
>>    - In the logic, to allow single device to req power, use linked list
>>      instead of adding extra variables to acpi device structure
>>    - return positive code for no main power removal to distinguish from
>>      aux power request granted
>> ---
>>   drivers/pci/pci-acpi.c   | 136 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |   9 +++
>>   2 files changed, 145 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 9369377725fa..645d3005ba50 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1418,6 +1418,142 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>>   	ACPI_FREE(obj);
>>   }
>>   
>> +static LIST_HEAD(acpi_aux_pwr_list);
>> +static DEFINE_MUTEX(acpi_aux_pwr_lock);
>> +
>> +struct aux_pwr {
>> +	u32 aux_pwr_limit;		/* aux power limit granted by platform firmware */
>> +	struct device *dev;		/* device to which aux power is granted  */
> Shorten these to fit in 80 columns like the rest of the file.
Sure.
>
>> +	struct acpi_device *adev;	/* root port/downstream port */
>> +	struct list_head list;
>> +};
>> +
>> +enum aux_pwr_req_status {
>> +	AUX_PWR_REQ_DENIED               = 0x0,
>> +	AUX_PWR_REQ_GRANTED              = 0x1,
>> +	AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL  = 0x2,
>> +	AUX_PWR_REQ_RETRY_INTERVAL_MIN   = 0x11,
>> +	AUX_PWR_REQ_RETRY_INTERVAL_MAX   = 0x1F
> Use lower-case hex ("0x1f") like the rest of the file.  Also below.
Ok.
>
>> +};
>> +
>> +/**
>> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3cold
> Shorten or wrap to fit in 80 columns.
Ok
>
>> + * @dev: PCI device instance
>> + * @requested_mw: Requested auxiliary power in milliwatts
>> + * @retry_interval: Retry interval returned by platform to retry auxiliary
>> + *                  power request
>> + *
>> + * Request auxilary power to platform firmware, via Root Port/Switch Downstream
>> + * Port ACPI _DSM Function 0Ah, needed for the PCI device when it is in D3cold.
>> + * Evaluate the _DSM and handle the response accordingly.
> Drop this last sentence; I don't think it tells us anything new.
Ok
>
>> + * For Multi-Function Devices, driver for Function 0 is required to report an
>> + * aggregate power requirement covering all functions contained within the
>> + * device.
>> + *
>> + * Return: 0 Aux power request granted
>> + *	   1 No main power removal
>> + *         errno on failure.
>> + */
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
>> +				      u32 *retry_interval)
>> +{
>> +	union acpi_object in_obj = {
>> +		.integer.type = ACPI_TYPE_INTEGER,
>> +		.integer.value = requested_mw,
>> +	};
>> +
>> +	union acpi_object *out_obj;
>> +	int result;
>> +	struct pci_dev *bdev;
>> +	struct acpi_device *adev;
>> +	acpi_handle handle;
>> +	struct aux_pwr *apwr, *next;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
> We talked about only allowing this for function 0:
> https://lore.kernel.org/all/20250904183046.GA1267851@bhelgaas/

In rev5 there was suggestion from Rafael to remove function 0 check as 
synchronization among drivers will be
tricky. 
https://patchwork.freedesktop.org/patch/681119/?series=145342&rev=5#comment_1255325

>
>> +	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
> I think bdev should start with pci_upstream_bridge(dev) as in the
> other patch because this _DSM is only allowed in Downstream Ports.
Ok
>
>> +		handle = ACPI_HANDLE(&bdev->dev);
>> +		if (handle &&
>> +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
>> +				   1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT))
>> +			break;
>> +	}
>> +
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	adev = ACPI_COMPANION(&bdev->dev);
>> +	if (!adev)
>> +		return -EINVAL;
>> +
>> +	guard(mutex)(&acpi_aux_pwr_lock);
>> +	/* Check if aux power already granted to different device */
>> +	list_for_each_entry_safe(apwr, next, &acpi_aux_pwr_list, list) {
>> +		if (apwr->adev == adev && apwr->dev != &dev->dev) {
>> +			pci_info(to_pci_dev(apwr->dev),
>> +				 "D3cold Aux Power request already granted: %u mW\n",
>> +				 apwr->aux_pwr_limit);
>> +			return -EALREADY;
>> +		}
>> +		if (apwr->adev == adev && apwr->dev == &dev->dev) {
>> +			list_del(&apwr->list);
>> +			kfree(apwr);
>> +			break;
>> +		}
>> +	}
>> +
>> +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
>> +					  &pci_acpi_dsm_guid, 4,
>> +					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>> +					  &in_obj, ACPI_TYPE_INTEGER);
>> +	if (!out_obj)
>> +		return -EINVAL;
>> +
>> +	result = out_obj->integer.value;
>> +	ACPI_FREE(out_obj);
>> +
>> +	if (retry_interval)
>> +		*retry_interval = 0;
>> +
>> +	switch (result) {
>> +	case AUX_PWR_REQ_DENIED:
>> +		pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
>> +			requested_mw);
>> +		return -EINVAL;
>> +	case AUX_PWR_REQ_GRANTED:
>> +		pci_info(bdev, "D3cold Aux Power request granted: %u mW\n",
>> +			 requested_mw);
>> +		apwr = kzalloc(sizeof(*apwr), GFP_KERNEL);
>> +		if (apwr) {
>> +			apwr->aux_pwr_limit = requested_mw;
>> +			apwr->dev = &dev->dev;
>> +			apwr->adev = adev;
>> +			INIT_LIST_HEAD(&apwr->list);
>> +			list_add(&acpi_aux_pwr_list,
>> +				 &apwr->list);
>> +		}
> I think we leak this allocation if the device is removed.  I think the
> list idea is more complicated than aggregating would be.
>
> I think we could:
>
>    - add "aux_power_mw" in struct pci_dev
>
>    - walk the tree below bdev, accumulating aux_power_mw
>      (total_aux_power_mw += dev->aux_power_mw)
>
>    - pass "total_aux_power_mw + requested_mw" to the _DSM
>
>    - if successful, set dev->aux_power_mw = requested_mw

Introduced list based handling as in rev5 there was suggestion to avoid 
adding variables in acpi/acpi_power structures.
To handle allocation leak in function acpi_device_release() I will add 
code to scan list and delete the entry.

>> +		return 0;
>> +	case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
>> +		pci_info(bdev, "D3cold Aux Power: Main power won't be removed\n");
>> +		return 2;
> Kernel-doc says we return 1 for this case.
Will fix it.
>
>> +	case AUX_PWR_REQ_RETRY_INTERVAL_MIN ... AUX_PWR_REQ_RETRY_INTERVAL_MAX:
>> +		pci_info(bdev, "D3cold Aux Power request needs retry, interval: %u seconds\n",
>> +			 result & 0xF);
> Lower-case hex.
Ok
>
>> +		if (retry_interval) {
>> +			*retry_interval = result & 0xF;
>> +			return -EAGAIN;
>> +		}
>> +		return -EINVAL;
> I think we should do:
>
>    case AUX_PWR_REQ_RETRY_INTERVAL_MIN ...  AUX_PWR_REQ_RETRY_INTERVAL_MAX:
>      result &= 0xf;
>      pci_info(bdev, "... needs retry", result);
>      if (retry_interval)
>        *retry_interval = result;
>      return -EAGAIN;
>
> I don't think it's useful to return different errors based on whether
> the caller supplied a "retry_interval" pointer.

This is to indicate caller to retry after retry_interval returned by 
ACPI method.
It's up to caller whether to retry or just proceed.

Thanks,
Badal

>
>> +	default:
>> +		pci_err(bdev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>> +			result);
>> +		return -EINVAL;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);

