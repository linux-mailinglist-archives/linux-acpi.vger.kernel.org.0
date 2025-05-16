Return-Path: <linux-acpi+bounces-13760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559BEABA4C8
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393593BF74F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 20:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C227FD70;
	Fri, 16 May 2025 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mhc9yiu/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04342AA3
	for <linux-acpi@vger.kernel.org>; Fri, 16 May 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747428066; cv=fail; b=W4M9X5SFfD2fzZ+Lwkv8AHxj7vtO9ZVCwkYmen1MahhzSQhVkYC1AwoYGCXpnc3IL3tgr16WTrfv6l/OdHHQrDecf0pvcJ6vtq2cNaBc7uwVsoMmEd8e7VX73BOVU5N965jr+Sv4B9LADepJWEenokxj0CAsLYvJnyQGWOMKhv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747428066; c=relaxed/simple;
	bh=3nTDoJ/m1DxQ46So7jMfcxgQ28Tg/zyFGEvcoWbVTr4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1H51yhjR24gFhBVHK+CFnNlRUbwmviUyvuR50V1Bkf067KWlzVzW8paOVr6+SJl9RoeWjjxHR6uFSF5+Q3hyu2Q2D+qRd9hrT/k7IXGsWtmhV/YJpM5bYMg4k9Bhdm/NIXLgT0XZgfFE57Gfxd68imM+CavR3LuUTHhw49xpn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mhc9yiu/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747428064; x=1778964064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3nTDoJ/m1DxQ46So7jMfcxgQ28Tg/zyFGEvcoWbVTr4=;
  b=Mhc9yiu/paDfxwET1Z4lyWuHJQ91Poc1MPzL5UJ+Bey5zlC5oiZtr/sB
   kFDLHc+VBn6PN/ngWjhcqaECB47lGB4TJZEShck6rdrNsl6EknC2GCLfv
   JJX7S1tGK3bfon59lxunfe6nXPxybPK8S6rqGYOqknlXszBFPnnRBcXjx
   mmSunn675KZIRQwu0FLZIqGWoymv+fp1xcs7KrSmcvvubzAXNmk5Ipzdv
   FNmm/MYG19ghcHeSMM0uePj6Tq8AeI9z/9o6iubIq068gk112e6MZJWPB
   QXItArrUOYZxwmG2Zkt5/ya8/x01sjAzK2JrvNaNnD9eUuO2KfaftZOLJ
   w==;
X-CSE-ConnectionGUID: V88yaPMHR1SwobKccY4Uuw==
X-CSE-MsgGUID: 8RGsbkVJSJ+pe84Uv+gRCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="52037369"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="52037369"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:41:03 -0700
X-CSE-ConnectionGUID: 9dZFlaKQTeu+lpmybUPJwQ==
X-CSE-MsgGUID: /Rdrs4goRUubeMtKNocxHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139813043"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 13:41:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 13:41:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 13:41:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 13:41:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3x8gZIsaOrLHY6owovcUs9Hfz92Wxzr1kHvriTx9waafk2KnbxgcjAGY6pWWVJnxQRZQtRfmtguDEyFk6xMYPKbdQz5DRBKOuuuA9PnaCidRD9/ngdJ8B2jbzPDif+i+/4bZSf237A6HiI1sOV6bcBeWMFivCe6RndvrFwzgRCLueK0eGddog8W8MjPhzV+eAu5gamISWf3DJw1hRThfN2yG3COaMvNa0KOZlD2t8bfU9CKat7+LOEkPBVz7K6QGhovL6YLPTKTblxxHE5rTbWM86/S2m5gV4bTj5eExB21l4ZXM9xG/JMa7jCNLrsyi7wYfO8x04Fvlo5kKD6Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPjDb3UYSHE1zXLOH5HCZsBTgSZrfJTHzGFtUl5ntiE=;
 b=GbW2mZEQMGrZjTiLYx/0rO3FwWM286DYn322qvHaR3IZ3O+ZdbhQxs8nvtrWEOXTBc/dvj+A8gYw0sRd19cC106qoOY7Zq9k24hWFTiV4YH7A7ShFyWUg5Ebu7BP2WwpGtO790Y0eH/S2ahXecY20IitVAjVK4vY0YkUEdDbJEyOMwVHPDTechLyHuUYd2fXBcNsB6pToLzjY4UUgZdCO+lAMjn9VDUdcyguB5dx8eyaOIOQh/cIwGzUSiKDS4Ta6vlI060kXEVgIPEMRW/5QLGj/74kMfZs4hdL/j+30S+vjR/Y23nWddL4flweMMQMt9xLFSINZIdaOuaYAtau5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH3PPF5A672BE95.namprd11.prod.outlook.com (2603:10b6:518:1::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 20:41:01 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 20:41:01 +0000
Message-ID: <79044d87-3bc1-4b39-a711-8313dfce4a5e@intel.com>
Date: Fri, 16 May 2025 22:40:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3]: ACPICA: actbl1.h: Add support for the new ACPI
 Table: DTPR
To: "Camacho Romero, Michal" <michal.camacho.romero@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Mowka,
 Mateusz" <mateusz.mowka@intel.com>, "Fedko, Artem" <artem.fedko@intel.com>,
	"Pawlicki, AdamX" <adamx.pawlicki@intel.com>, "Michalak, BartlomiejX"
	<bartlomiejx.michalak@intel.com>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "Moore, Robert" <robert.moore@intel.com>,
	Saket Dumbre <saket.dumbre@intel.com>
References: <IA1PR11MB77556710DD26474B9B857408AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <IA1PR11MB77556710DD26474B9B857408AF93A@IA1PR11MB7755.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::46) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|PH3PPF5A672BE95:EE_
X-MS-Office365-Filtering-Correlation-Id: d86655e6-018e-4168-5508-08dd94b9f7f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUxVK0h3SFJiMWtLSGxYNkd0WlBwYllkS094Ryszc0ZyWGNyRDdWVTcxM3ps?=
 =?utf-8?B?dTcvTy9aOXBJY0VZbjBOVGhHRlovZ3M2MjNjTVJMQWhmOTNmQmRwTkJiSUcv?=
 =?utf-8?B?UHpwdFhleEhoajVzcFFQS2ZYbDEwbGszOWFDNjRjSzdJOXJDYUN3N2o2WjE4?=
 =?utf-8?B?NTFnTWdLWmlzTEdjaUN0OW9JUGFPZllWQk93RVZBTzE3QzM2RW01cTBaLzlr?=
 =?utf-8?B?eGJKdkJoSkRxc1lVaS9KaVA5S1NPVXlQc3pTbnFpWjJ4ZWdmUXN6ejJSam1F?=
 =?utf-8?B?d2ZzWHZtLzlBWXNTOUJWNkZkVkl4SXpRa1JXNkJBUHg5YURpV3JyMUc2Vjhy?=
 =?utf-8?B?MTRROGJOYVRMU0htd1A4WlhNZ050MGRKY0NrbUNMejk5aGVPV2hXNXBMYzg1?=
 =?utf-8?B?THJwd1FGKzJtQ0ppcDJ2bURJQ2hOTnJXck82cTRuOFFqZXlBTmVxREx1bGdH?=
 =?utf-8?B?QWY2Nlp2aElVazh4c3cxdUpzNUEvcHVxcTBYRERCQ2V4Mjl4WGJTbEFmeWM0?=
 =?utf-8?B?bjdIaCtVRzZrc1IzOCtlT0c5NUxXVEJKcC9ibWdOQ3JVSkxrWko1d0dWeUhq?=
 =?utf-8?B?aWZjZ0szYUxFaFVwNnJvOGJVbkRhckF0VVRZNXNaazlBU2RnV2cvSGYxZFZn?=
 =?utf-8?B?by9kaWhzYXNaNDRtdnFCN3FqSXFwNHk2UHRtYjdzSnZ2M2kyZDZ3U0tkUWFI?=
 =?utf-8?B?ejFxdlVmdVFUeHdzUUlWMVRLcHFoeUNZSENkMnhjVllBTi9xZ0N0VE5UUFFq?=
 =?utf-8?B?cHl4YVk2UEVwRWF5RzYyKzd4TDZuQ1hMaTBNKzVnN25aUkozbnJ3U04rL2w5?=
 =?utf-8?B?clJsZHNadGRYRnRlS0NDTS9zUWdmK0lwcXVwMUcvNThKb2crWHd2dHdHdFQw?=
 =?utf-8?B?cUxidmVuZ0RDSzgrTUxuYVAyT0poQlA2NFN0anJPSEpzMzdoL3FCakdwK3d6?=
 =?utf-8?B?Sm4vUUREM01ZeHRBenRhYVNvK1ZrekZKck9yUnRNMzgvbDNZYWNabjBRV2dj?=
 =?utf-8?B?TXJTQ3JPdytMakE0a3d1MmlnMVk3b1pWenI4dVg1TldaaDB0NkZqVlgzeDI2?=
 =?utf-8?B?ZkRCOSswUkVQRWQ3dUlmcTJOdms3QisxNmgzNVNldEg2d2lqYmR5WmF5OVZj?=
 =?utf-8?B?NUErUGdjcmhkbzZLc0xBTGdhT3JOYXFFWGgycVc3VGdnZ3pNYmUvMHh0OHlv?=
 =?utf-8?B?YnlvZGtmdUI3ekVkSW93ZUpnQ3lKWGFxR3NIQy91VlZkWU5VcUY0cnExaWt1?=
 =?utf-8?B?U0tCcHBOMEFFTWxsSFFvSzdramhtVEdVeUsraUQ2Qkpoa2VzeHNBR0pYZHBx?=
 =?utf-8?B?d05DaExidSsrTThDTWl0U3pKVkFHLzk1VUZ6clA0elRmSkI1WXNTUEczOUVi?=
 =?utf-8?B?TXJSZFkraGJEU0RpMm5VeDU3cnV5VFpCWHhxcHI0eXBVcytMY2JYeGoxVVB2?=
 =?utf-8?B?WnhjM2grYkl6bmtpcnVkY3JTcHFIV0dnZWpuQUl2dm1jblFFVkVKeTRsb3dP?=
 =?utf-8?B?Q0xzWFBJbGVNazl0SWVzVWpsQ1d0eFR1TG1WOXlHU1FMZ1VUVEIzSHJQUlI1?=
 =?utf-8?B?anRSRFkwQjJKZmY4M2o2dXp4MEw5aVAvWmkrb1R6YTQ2MTZyd0FRaGEwbmxB?=
 =?utf-8?B?T3JRMm4zQ2UyOG1WWmlYeXFnUkZiYUU2alZTV3hSQVBOSWFmZWtsTGtXMG5t?=
 =?utf-8?B?aWtSVHgrdElXMEJKcUxMZXJsRUJWSG1CVUorMTYyUHpTcW4wTXJmc0x1YURY?=
 =?utf-8?B?MEpEa2xpeGw0cXFGZEZCc1FveUs0UDVpNmpJVjFEU1ZaWlFCem9jUE1yOFNZ?=
 =?utf-8?Q?p/DiQ4MXjSMdpAwyYCRG/YMu9GeryHEDbp+fA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUV1aW9wMTh1TWd4UkJSUzNGK1hsUUd6eFRqdkxFMjJmRW4yOU9WSlVBK3Rr?=
 =?utf-8?B?azZ5Tktha2dGZDNqUzJMQnU2Um9NcGszbGV6YklRUGtQa3F5cm9KN05haG5I?=
 =?utf-8?B?S0JiYnh3dU8yMVZCdUVUZnB0OXFYNlpRQVBlT3NKNU5TTUhYUlE0NHJtdS9j?=
 =?utf-8?B?S2gvblM4MDI4blJMcGl5NWNjbHJ2TStqaHNqa284T1hhOTFxblZQdXBZOWpD?=
 =?utf-8?B?cVZHbjN5RDRHK0pZeVF0dVpJaDB1U3VBbVBLSFlVTlRxdDlEU2lOekVuc3Jr?=
 =?utf-8?B?OXZVNVF3SGFGSndOR1dHdGpZeDRYVElCbll1dEQ5TDAyOVZoZ2xEUHk0UENH?=
 =?utf-8?B?ZkVwWU5LNW9RcFBQUWdndFQvQm1jVWFDUEFuMFhacThCMWR1cHZPQ2Z5ajhR?=
 =?utf-8?B?bEhmaEovZkF1RXU5REtGbFhyL0V6dm1ITzZHYnBjUTlFRjRFY1YwV3ZYWFVi?=
 =?utf-8?B?S0xueEVrQ2xBa1VRYTVpVU9LUE5WMFdWTk5lWWFrNVFaSEdDVUc4eU82azdr?=
 =?utf-8?B?OEdxWVBsODB2R1crU3FPaXE1bXF6dC9BVlRhRmtGZGFGOW9Mc2NJWEE5TWlw?=
 =?utf-8?B?YmFSR21LTTQvT00wZlIrdG9vdlFPSmFjWDc2cERJc1VkbDVTdzltN00yMGFt?=
 =?utf-8?B?K3VOUU5VbXdYcTRkYUgvR3NZcU9jb09iTTUvQXN2Vi9USDhMd0t0QWpVWjQz?=
 =?utf-8?B?WFZPUVZRTDVxb0N3YzJDcEhjMDg4REsrWVhlZllsaEJmTXgyRmF1M2VmMGNN?=
 =?utf-8?B?cUJEYnJrT2lDU3cxMlFab1E4QVZEMEhvbjRFSDJSaXV1enVFb1Z1QUpFL2Ri?=
 =?utf-8?B?VHV2RGlTdFJONjQrMEJtdzhLSFptNUVWV3FsaGlVaHlhRy81Mno3Q0Y5dm84?=
 =?utf-8?B?dkc0bVhXMUdBWDd2NktCR2RGS0FpRnFTaXFrS2FLRjM1bUZ0V1YyN0R4WDI4?=
 =?utf-8?B?Q3dib291RWpFNkdGQTA1Z21BaEV1N1RrNWxTZStBOG9JWXR0NWtXY0JpZEd6?=
 =?utf-8?B?cXhIbVJhM1dYbTdmNXdDUldRSkVKeWZJTXBVeEYrd0p3MUI0dGdZYlJGTVdC?=
 =?utf-8?B?R1pVSXIza1lSMjVTcWUrWlh6YmRFajFOeHQ0cHVPR1dwYU53Q0liZGZhNlJS?=
 =?utf-8?B?WXFWbElEMlJhSTV1YkErL3FuYURQUnFWSzhUUUNJU3ZVSzhmKzJXTU5iYk1s?=
 =?utf-8?B?UG9ETDBrTW51UkJTVjVmS09WY3VPR3ZDRlk5WkkvdXpyQnQ2UWc2MGczOUo2?=
 =?utf-8?B?ZGQxeWgwQk03U0xFeVQ3aW9ZNXJSZWNGZkU3ZXdXcHRtc2Q4VmZlSkxIZzAr?=
 =?utf-8?B?N0VSZjlkQ3ZZakQxa29BV21pYW5JYStSWDExcWJxdTR6aCtBMTMzdmlSMjky?=
 =?utf-8?B?aWRlbUtIZ0QrbU1pVktYZFRvQXdhd3J5NVA2T0J6ZmF1dTFLTnZIbTRYS2pD?=
 =?utf-8?B?NVM3M2dBYkk1eGkwcEtSTkFXMkI4dlJXb3hWYUZGWlB0M09tNXozNDZxRzA0?=
 =?utf-8?B?SS9TekZxMVdpODNYZ2U0R1h1cnFCbVlPWGpHeHUrdktKNHhGQ2tvTWZqT25m?=
 =?utf-8?B?ZXNsd05WK01tUGNxWXE5dmRRRDZZS3NSa2FrZVVpVkE4a0ZnalJSKzgyaVFi?=
 =?utf-8?B?TW1ESUtNNEdud3V4QlZpM3RRTTRKSzM0MHRSNUdVZDhXSkFESi8zVjJHVEs2?=
 =?utf-8?B?VXl2dmoyY2o0VjByUHNNbW5Xa2pJS2QzZWxYbGgwN3p4anpSQ3M2M0E1d1ZX?=
 =?utf-8?B?c2ZCZkMzUTJ6NU5LNFc4QUgydytHZ0pudE53d09lQ2g1aUZTTERGR0MrZXpp?=
 =?utf-8?B?Wm1iRTZXVVEvbHZkak5DdXVvOXEvdlc2Z3RNeWJwQjNRSUxvbjFTcWkrTm9P?=
 =?utf-8?B?Y3IrV0kxUEpBcHl0RU1GVU5HY2thSk5zUVlXd1N4SXgxQnhlTU9aVXRtT2tK?=
 =?utf-8?B?SGtXSE1ZM28rd1NlSXFXUzA4NDRJdmxxcDVKdmlQRFBjNDVxQVN3R1NyYlJU?=
 =?utf-8?B?THVHaUFmS1g4YkNBY3VtbElLMVp2dkw4dG83T2RXV00ydnNoTFpwWkt5S0lw?=
 =?utf-8?B?bUdPSlJiYlgzR2JhVmJaME5ERG1lcWlFNHBXS3ZBc1FTeG9BbGsyUTRubmtK?=
 =?utf-8?B?ZTcrc2JTeTRQcUNJR3dUakQ4NjN2SGY3Sy9kU1ZYZjFnczZYRCtGUVdtYmdO?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d86655e6-018e-4168-5508-08dd94b9f7f6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:41:00.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSxqUxbIdXXdVLLPFzMEPWYSolQkZwfk8vdvrg51VyxPhVYamw79Z28earfVMsHXW3qhUqGtRUiIL0OisqFbsyR4+fMiheMas1oUVHZ/4a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5A672BE95
X-OriginatorOrg: intel.com

On 5/16/2025 10:28 AM, Camacho Romero, Michal wrote:
>
> Hello @Moore, Robert <mailto:robert.moore@intel.com>, @Wysocki, Rafael 
> J <mailto:rafael.j.wysocki@intel.com>
>
> According to the latest version of the Intel TXT DMA Protection Ranges 
> specification
>
> (Revision 0.73), there were defined a new the ACPI Table, structure 
> and registers, which will be used to handle TPRs:
>
> *    DTPR ACPI Table
>
> *    TPR Base Register
>
> *    TPR Serialize Request Register
>
> *    TPR Limit Register
>
> *    TPR Instance Structure
>
> *    DMAR TXT Protected Reporting Structure
>
> Link: 
> https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
>
> Signed-off-by: Michal Camacho Romero michal.camacho.romero@intel.com
>
Can you please submit this as a pull request to the upstream ACPICA 
project on GitHub?


> ---
>
> include/acpi/actbl1.h | 86 +++++++++++++++++++++++++++++++++++++++++++
>
> 1 file changed, 86 insertions(+)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>
> index 387fc821703a..14802feb54fd 100644
>
> --- a/include/acpi/actbl1.h
>
> +++ b/include/acpi/actbl1.h
>
> @@ -47,6 +47,7 @@
>
> #define ACPI_SIG_HPET "HPET"           /* High Precision Event Timer 
> table */
>
> #define ACPI_SIG_IBFT           "IBFT"  /* iSCSI Boot Firmware Table */
>
> #define ACPI_SIG_MSCT "MSCT"         /* Maximum System Characteristics 
> Table */
>
> +#define ACPI_SIG_DTPR           "DTPR"  /* TXT DMA Protection Ranges 
> reporting table */
>
>  #define ACPI_SIG_S3PT           "S3PT" /* S3 Performance (sub)Table */
>
> #define ACPI_SIG_PCCS           "PCC" /* PCC Shared Memory Region */
>
> @@ -1953,6 +1954,91 @@ struct acpi_ibft_target {
>
>            u16 reverse_chap_secret_offset;
>
> };
>
> +/*******************************************************************************
>
> + *
>
> + * DTPR - DMA TPR Reporting
>
> + *        Version 1
>
> + *
>
> + * Conforms to "Intel® Trusted Execution Technology (Intel® TXT) DMA 
> Protection
>
> + *              Ranges",
>
> + * Revision 0.73, August 2021
>
> + *
>
> + 
> ******************************************************************************/
>
> +
>
> +struct acpi_table_dtpr {
>
> +          struct acpi_table_header header;
>
> +          u32 flags; // 36
>
> +};
>
> +
>
> +struct acpi_tpr_array {
>
> +          u64 base;
>
> +};
>
> +
>
> +struct acpi_dtpr_instance {
>
> +          u32 flags;
>
> +          u32 tpr_cnt;
>
> +          struct acpi_tpr_array tpr_array[];
>
> +};
>
> +
>
> +/*******************************************************************************
>
> + * TPRn_BASE
>
> + *
>
> + * Specifies the start address of TPRn region. TPR region address and 
> size must
>
> + * be with 1MB resolution. These bits are compared with the result of the
>
> + * TPRn_LIMIT[63:20] * applied to the incoming address, to determine 
> if an
>
> + * access fall within the TPRn defined region.
>
> +*******************************************************************************/
>
> +struct acpi_dtprn_base_reg {
>
> +          u64 reserved0 : 3;
>
> +          u64 rw : 1; // access: 1 == RO, 0 == RW (for TPR must be RW)
>
> +          u64 enable : 1; // 0 == range enabled, 1 == range disabled
>
> +          u64 reserved1 : 15;
>
> +          u64 tpr_base_rw : 44; // Minimal TPRn_Base resolution is 1MB.
>
> +   // Applied to the incoming address, to determine if an
>
> +   // access fall within the TPRn defined region.
>
> +   // Width is determined by a bus width which can be
>
> +   // obtainedvia CPUID function 0x80000008.
>
> +          //u64 unused : 1;
>
> +};
>
> +
>
> +/*******************************************************************************
>
> + * TPRn_LIMIT
>
> + *
>
> + * This register defines an isolated region of memory that can be enabled
>
> + * to prohibit certain system agents from accessing memory. When an agent
>
> + * sends a request upstream, whether snooped or not, a TPR prevents that
>
> + * transaction from changing the state of memory.
>
> +*******************************************************************************/
>
> +
>
> +struct acpi_dtprn_limit_reg {
>
> +          u64 reserved0 : 3;
>
> +          u64 rw : 1; // access: 1 == RO, 0 == RW (for TPR must be RW)
>
> +          u64 enable : 1; // 0 == range enabled, 1 == range disabled
>
> +          u64 reserved1 : 15;
>
> +          u64 tpr_limit_rw : 44; // Minimal TPRn_Limit resolution is 1MB.
>
> +    // These bits define TPR limit address.
>
> +    // Width is determined by a bus width.
>
> +
>
> +          //u64 unused : 1;
>
> +};
>
> +
>
> +/*******************************************************************************
>
> + * SERIALIZE_REQUEST
>
> + *
>
> + * This register is used to request serialization of non-coherent DMA
>
> + * transactions. OS shall  issue it before changing of TPR settings
>
> + * (base / size).
>
> +*******************************************************************************/
>
> +
>
> +struct acpi_tpr_serialize_request {
>
> +          u64 sts : 1; // Status of serialization request (RO)
>
> +                       // 0 == register idle, 1 == serialization in 
> progress
>
> +          u64 ctrl : 1; // Control field to initiate serialization (RW)
>
> +                        // 0 == normal, 1 == initialize serialization
>
> +   // (self-clear to allow multiple serialization requests)
>
> +          u64 unused : 62;
>
> +};
>
> +
>
> /* Reset to default packing */
>
>  #pragma pack()
>
> -- 
>
> 2.43.0
>

