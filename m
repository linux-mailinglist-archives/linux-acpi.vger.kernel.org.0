Return-Path: <linux-acpi+bounces-20047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048DD02766
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 12:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B442C3012DC7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE40469224;
	Thu,  8 Jan 2026 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/XHoJA8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F908469212;
	Thu,  8 Jan 2026 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871498; cv=fail; b=f4i3W1uN2deLkT6SsnFua7HoxpaSbh8NWSigj2Rpu52EO4ghrpZxQro+RqKanbhK0wtFdxxCrvMgVCsafosLOpwXeulBLt1f8LD4OZCKdE12jyTXU6SjcZO8RmdCQCmt00b9LW9ogXUQXOr1M1fB+nSuOpaUD0jUIZcnxSywPqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871498; c=relaxed/simple;
	bh=Npcdrr/XKwBJ9kXDzj045matKgupAJJDPCXqwmdsTbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fuFlBrkapjl1uJ9dHUeHS92Z6SA7Y6ETDSW6Wp+wJsrgvBpyg6qgRfpZdLRZ+VBzD2i+tN/fNvhaqUNAjYq1vkl9GN+azlqI+xzUf/yOeQhZCiNHD06ebZESFCfFirEtfjYXwfChDn/+CeIsrPuaA/dRwbCRL4tqUDKMKePCits=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/XHoJA8; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPrPQqCplXFOireegq4Kf9uYnWfema9OXTruqWbS53HxSFQWXqjwkkaLAEWcRjObcDW4nNOZ8oYS5IqwCRIxD9+cXGZAd6ITTMsA+cJ5H5pzd370eJEBBYX/TP6dSUtc5NmXuMs405vFAu0tloWjaXZiHkJPYYVPkDcJETVbUZ6bBUr/XldDlpw7xNYqcpitfKXVMoAPAecMKx2wRidbQv0PTiDk4FY/91iXoZIcfaswX58yhCzqOwtIuKxzL9rQuBkpz5e7uFdEynoYVYbKm9Tg1sdxCO7CamWzF2MTwkEu+tw4W8sYPKJXsPj6DZxRkVbUC/cdgLW/hIkUHgGyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfkMydWwaW7LjADanHV2U+PfdteQII8BzzJpaH7QRZU=;
 b=c0fCXDxJMB7oymEG32W26ciJx/sdUu0yNHbL9jhV0WQ2oMK98JxfA0tuveV7zSsU2Mj0pMBCj9goKIvwHphdacDOlj3y9vlRqaukCgmNPnW7cDN+FNWO/bTyFrj8kF2uxuqaNW+zHwAvt0BJFBS1ONAknmUZXXSw/Aas2BV40GsnJhYxwO7R/NHnr7dZZS90FCT+q/rWs7T2+uW9wOCbTkkEFZ7kgwH0xtn5TdvxjCUvjFYNdKaN2qOextex98D0LwbY57BSaupJU2Q3pBz/IQ94uwfI6M91cg2HmZb07FdXc10ZHIu460sD9LABUPN6zAWj3cJr0h5N/R+j5R0XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfkMydWwaW7LjADanHV2U+PfdteQII8BzzJpaH7QRZU=;
 b=B/XHoJA8OseVaR/5FKl0edbUMRgwfrr6yB+l0Ss26m/v1T8m7dI2dhcdKxAF0++blMJyAsLLOZ9nors2iojX/qCO7NWAsTaVbnANUaELcQM1ClHW8L9slbBa+2eiMNTzsuAcipY0RgPpZXzJGjKGwiK4Vu88EDWjYj7JmvaBaqrW4aqxQC10tz/v7t7FECgVAtDcNEqjhWPxGKmfadQ9mLwr9jD8eFslpf9nwNbcbj+FVABN9EaH/3MDp4hH0QBVf+h340WoRpYPjRTifnjy2qJlIAkiWAZ3qL+LKAQ8pksdpG4zkGZCGmS82wGBo15zr3kPcRi4qJsHI1T+KOuotQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 11:24:50 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 11:24:50 +0000
Message-ID: <a794af2f-beba-45ba-8ce3-4bf5bb0111c9@nvidia.com>
Date: Thu, 8 Jan 2026 16:53:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 thierry.reding@gmail.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260107120318.13130-1-kkartik@nvidia.com>
 <CAJZ5v0gbqXrj+Zq42CWL11-d4uJPb6NcGKrnf+ZQWvBSJGqZxA@mail.gmail.com>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <CAJZ5v0gbqXrj+Zq42CWL11-d4uJPb6NcGKrnf+ZQWvBSJGqZxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: acc5f815-9349-46fa-2868-08de4ea88935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERDUXFNVmpHTVBHVWdLVXpVcE9PZUlXN0tJTmU4dWZqeFNhaEVPYTdoOFZY?=
 =?utf-8?B?Y0NmOXE4QVZzUWs3dUZMVU8wNHVEOWZYN0phR2lLd1RvanlNYnFaMmxxazNh?=
 =?utf-8?B?WW1TUjBjY0lkcDZLTE5mV2JHendwVklFZkJWN0R4S1o2eU1Xeml0WEI3K05X?=
 =?utf-8?B?REdOZUFVVnZUOGtXR0lMRGlDWWVHUXlRMjNPWVNXVTc5MDU5NURzWUJtMXFq?=
 =?utf-8?B?b3d2VDU0aHExU1lVT3lUQXgxbEJic2c1R3c3M0dDTytSV1JEZWNRazhRMzRn?=
 =?utf-8?B?bCtVTFFpNDgrQVZtVHZNT1ZQVlFLNHB2WWFvMGVWOXl2MVhlSGtKaERtSmtx?=
 =?utf-8?B?WENLYXBaVU5yK256NFhRbm1lai9xZjVkNnJGUEJxTFVaeEM1TjJCTkRGNThr?=
 =?utf-8?B?ckR6bmEvc3JNai9uYzFCZ0YxWWF2RmdFK0ZBL2tUZUVOT2N1dmhSOWs3OVNV?=
 =?utf-8?B?OWZVZEVZUjJMaitPL0pmQTgwVHN4eE1URlRkRndPMyt5WW9YRUkyekZaNXkz?=
 =?utf-8?B?Y3hWTEgxdGJWVnRBbEV6cFh2T1dGLy9iQUNxQ1ZyNHZIV0ZsTmd0cW9BME9P?=
 =?utf-8?B?UXlCVW5CdnlBYnpyNHJvNHZDY0E1Z05QYUx5ZFFtb0dYQTZrckhZTzBUMHpN?=
 =?utf-8?B?VWRwekNMLy96SnZkQlpyVmtFZ2dwZWZCWFdubWIxTFo0TUFpY2J6YTZDM2xL?=
 =?utf-8?B?cGFEbnN0SFoyOHlNc245ODc2L3VFeWJZZnIxcGQweFpMTjVuRHhWVjhQU252?=
 =?utf-8?B?MStLeG91dTgzOWpJSkxpU2dRdzNiQUVBNmZPWnY0ck80OXQzaHoyeXlZUDFG?=
 =?utf-8?B?aTRRTzEyRDVvZXZlR0cxMkJqVExLR1ZuZWJRVUYwbVNpRXYxejNLQ0pkem1M?=
 =?utf-8?B?TkU0R0FYRVp0N1JLSllIZ05IcDMrcWZhVTRaNTU0N284YmI2Wm9QZEZZZ05R?=
 =?utf-8?B?aUREZ1RDM0hVbDZDTjMzb2tqZlFyVmFSSTNCelNVUWpsZExoaGZEbW0rUmp2?=
 =?utf-8?B?WWhhT1ZzejVpUXdmKzVTVitZTFJSUzZYWDUwall0UkNHMDNBalJNRU4wZngw?=
 =?utf-8?B?cjk1RW1VeGozM0xOQTM1azFNdXJjQVpLOXozaWVjanpYQ1lHdnRubWdGcCt6?=
 =?utf-8?B?ZUlqK1BCSEdLeFVCeXNteFB1UU1TMk5lZXYzdUw4N01JVjdHVytmM2NYRklS?=
 =?utf-8?B?N1N1MUl4ZjA3T2piK1ArbENJTnlBN1BvbU9DVTRkMVdlRnBONG1rZmdCSlVr?=
 =?utf-8?B?a3dIUFhFTm52biswWU5XclpxWTlqMXAzUWJzSGNLMEQwY0txZ2pqcDNPclBJ?=
 =?utf-8?B?Q2lkbE9qbmRNRHVDdDUvV05mUmhCZUk3YVNseTNQSlRxWlBBM3JkRTVFSVFi?=
 =?utf-8?B?SkFhWktiS0M3d1grMnd2RkVqOWw5bTZCeXN6UWd6cHdaT0ErMjNTaGdoZyt5?=
 =?utf-8?B?TGtNSncvSVN1RGVmTklybHg0TzJyUFVhbk1pNms1M09xTnFjYWQzWS9JN0Rl?=
 =?utf-8?B?QjVTOGh0TldLaG03RTBLdXR3NW9ycUkwOERMVWpQRS9Xa21PSnlCazRONTY2?=
 =?utf-8?B?L09lbVhVLzN3OXE0ME0wZkZTd0x3am1PNXltWFMwekxKaVJYTWxQS056Q3ZM?=
 =?utf-8?B?K0RvZ1pwQlNxcHhoT2NsVjVEck92QmtJQTBsWU5DTEFDVFJJN2ZwWGUwek45?=
 =?utf-8?B?SXdqSk9VRjBNeGRoK0pGU3Q0OVRWTi9NVFFIZUYvZzdPM3NSeFZmTG4yc0Nn?=
 =?utf-8?B?eGQ3d1h1M3Y5bXcybjdaYjJlSkppMFloanRRaVh5TUlVVXdzdkZ2dVhwQWRz?=
 =?utf-8?B?WVZSMHN6UlNUNVd1WkY3VjhsclBYWlFQQ3hSVDBYaisxV3pPR0FsMndXYWpH?=
 =?utf-8?B?blBFSS8rSzdySUZ6MlAwNkY5bWRHS2J4QWFVMUlyYjhFMUIxSnZQZC9qekZK?=
 =?utf-8?Q?sayobJ0yLrhWie+Z/bfst0wE3qmZGHSC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURGVGhmb2RwbmFDWlJMQ3NuQ2NOQkU0K2ViZmZDeHZYL2dIMVdFY1JYblhT?=
 =?utf-8?B?eCtJSjJHekplL3V5ZExiVm5VVzJsNHlBUjFmckx6ZWw3SmgyMHhLRnlBdWlB?=
 =?utf-8?B?Vnd3eTdMRmxMMS84K1NwMkxESFI2U0VyVUJKTDRhVWgvaTQ4Z29SQ2IvRDg0?=
 =?utf-8?B?QlFLc0dQVlNZQ3QrN0JnN0syaDR2aTYzd3JoNFB2dWI0UW1DRTE5S1lpUFdK?=
 =?utf-8?B?cDRWSHZqUE9JbmdLck5LVmFjNUpPYnQ5clJVMXAvZmZUZHMzUk5IS1Y1RHRQ?=
 =?utf-8?B?TW5DSWRMT1VXSXV4T1VFOWIrYmROaEd6NGo3ZGFlaUpzaFFLS1ZDOUNwOVY4?=
 =?utf-8?B?ZzVOcGJsNHFPL3ROOERqMUZ6SUtnVDZtaW9ucmF2NzVaZ3JiMFVyejF6VlF6?=
 =?utf-8?B?Q0R2Vk5mMHNOQWlvdmIrWG5zOTRKNlpFeGJxb2lFS1YyZ0JqUVdRMVFXK001?=
 =?utf-8?B?cUx0YkhGYTlXUlJ2MnpEWHVKZFA4YjFiZDFqL2M5RTRKMHlJa1BBZDZBaVZQ?=
 =?utf-8?B?dytWRjhRclJ3d0Z2WGt5RFFScGdKaDNkREEzT2JEOHY2S3JJdnNKUFo1RXNS?=
 =?utf-8?B?MWJrV1JQbDBMdUh2Z0JrM2FxTlVGbXBRdW9WUktoSU50VXZRMlN1eWF5YW1S?=
 =?utf-8?B?b0I3alRWSVBEdW9yM1Y2ZXdQSXR1UW5ha05RWWgzRXFvazdIMGZpdDU2eVBs?=
 =?utf-8?B?SnhYdEJ2YndWWGIwU3h6bW51aHVzYnRkMytxNlZSVFg2ZXFGcm9jQldLTFNv?=
 =?utf-8?B?K2ZyM1l4YWp1dHI5TUc4dm5SSDhFN1BRNUQ1bk5EMW5VZE5TQUp0WllzY0tD?=
 =?utf-8?B?UHcyeGFDZnplRVd1OEJIcFFuVVppUk5Dd0UyNkZDNVVXMDgxakEza2JuTFp4?=
 =?utf-8?B?UkZRcjZzZXBBdjRoUHA4ZElmcTMyYjYvWms1TzBYaTdCbjMrbG12WmFUSSt6?=
 =?utf-8?B?S2tVWXE5MXpON1QzVEtxYjRkU2dJTGlUUzJTU292emFPd3FGWCtlS0pOYWxm?=
 =?utf-8?B?OTRNY1JTUkhYZE9DczNWbG1XWmcyemthTHVNSzBhK2oxb3FLODZhbU1ZL2x1?=
 =?utf-8?B?Q1gyRDh1Z0xWdWM5MXNvSUt5ZGNXK2ZKZDBxVGRuWVlUWUlTdTcwTHdpc3Zn?=
 =?utf-8?B?cEJaQkxRWFBFaU95ODFFOVdDOTZ1NGhGRGhjOGFYNFF3eStEa25namd0L1RD?=
 =?utf-8?B?MEQzRU52a2dSRW1xZStvME5NVUs4VitSMW05aGk5Y3EwMUl1NzZkbjNXVTVw?=
 =?utf-8?B?VW1FNFZ6SHFPMzFmRi82NU1Oa3FaUkJFR2ZIRFF6NjVyLzcvYm15WmhjYlNm?=
 =?utf-8?B?Q2Z2TWVnMWphYWRGVDZwNXZWTy9QeDJJN0VlUUZPRm1JSnlycUJBYnJtTmFT?=
 =?utf-8?B?bVNpOTVSdU8vMWZlTHU5Nk1na280VUZiRWRUOGhHcmJxdlZMWlNMZEFhb3pZ?=
 =?utf-8?B?SzVyU08ySVUyci9lSmt5bExyUXpzZjRRUnlOY3B6UU43T1ExQW1TVi9DYTZi?=
 =?utf-8?B?bTk2RzB1azk5L3lSZkUycytHTC9qUkw5R3ExT0IwTVdldmNJZkltcElpWk8v?=
 =?utf-8?B?Q0hKdzU1U2RKS0gwdzdLVE5Xc29TcklqM1pXcW1zSWFmWW5EQ1UxSkNIZWw2?=
 =?utf-8?B?Qk5BdXB0QmRUejZoNWlpS2pSREdHYmJRbjNwRXpOVXVLM0N5OTJ4RnJVV0Rx?=
 =?utf-8?B?V3d4K1VBeThUK2tLNVdSMUJqZlVXSCtkc2gzYng5eGRZc0hZUCttMWg1aFhL?=
 =?utf-8?B?cUV2VUM2TmlyYkJjdVRiM0orT3lhOFBXV2lYT0VwTHhJNWJ2ZCttK3A2UWVs?=
 =?utf-8?B?RWRYUTRXc0ptcTZYMGJFWkhKeStLdFlCZnhjcXlYeWRDbUZZVFA0YkxRYlVh?=
 =?utf-8?B?QXZYakYrbUJzVWJUWWFMb2JFbFJ5TmVXdUxsemJoK2NhOU1VZml0MGlJclpN?=
 =?utf-8?B?VEt5TDZzS2hLclJqaXkxZ3I5OEdIeG1RZlEyN29kc1lXTHhOVFA3VVNwUFRK?=
 =?utf-8?B?NlpBSUJNaHZSUUtyWGhva1NFcmozeGpUekZHNjBHcXlWY1VuKytyMHREM0ky?=
 =?utf-8?B?MVJKOHVoSEVTQ3lkSDdQNXl5T0RpOExCNkRRRkxYVHJEbHlncTlvcmFCVS9D?=
 =?utf-8?B?S3MzQ1lxOWNGUS9wajh3V3UvZ0tGQjU3d2ZjYVZuMTRxYlVFUlMyTXAvNXRj?=
 =?utf-8?B?MTNIWm9TcTZERmZoMGlLam0vVTRjY3J3MFBIY2R3MUV1N01BWmR6b3FqdS9q?=
 =?utf-8?B?VXdpQmZ5MGd3OTlkaU84TFVobFNDR3RrWjBOcFQ1MUxZRHpyVHdpME5uY3hG?=
 =?utf-8?B?WHVjS1I2S2Y1dXE3SXJzQUVBU0oyYnpTZ1hUVjZXUkhYYVVLZTdhZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5f815-9349-46fa-2868-08de4ea88935
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 11:24:49.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0iHiE5s1/A3jMCbJ3mRrW+bFdP3wFm7vmb2ViJaa5//j2UixPrXReBYEbs23kXVpM3ZNBqtd1vSOwCKUoLeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862

On 07/01/26 18:24, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jan 7, 2026 at 1:03 PM Kartik Rajput <kkartik@nvidia.com> wrote:
>>
>> When a device is matched via PRP0001, the driver's OF (DT) match table
>> must be used to obtain the device match data. If a driver provides both
>> an acpi_match_table and an of_match_table, the current
>> acpi_device_get_match_data() path consults the driver's acpi_match_table
>> and returns NULL (no ACPI ID matches).
>>
>> Explicitly detect PRP0001 and fetch match data from the driver's
>> of_match_table via acpi_of_device_get_match_data().
>>
>> Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>> ---
>> Changes in v2:
>>          * Fix build errors.
>> ---
>>   drivers/acpi/bus.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 5e110badac7b..6658c4339656 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>>   {
>>          const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>>          const struct acpi_device_id *match;
>> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>>
>> -       if (!acpi_ids)
> 
> You still need to check acpi_ids against NULL or (better) check adev
> against NULL.
> 

Hi Rafael,

Thanks for reviewing the patch.

Yes, it looks like adev should be NULL-checked. acpi_of_device_get_match_data()
also uses the adev reference and passes it to acpi_of_match_device(), which checks
it against NULL.

I will make this change in the next revision.

Thanks,
Kartik

