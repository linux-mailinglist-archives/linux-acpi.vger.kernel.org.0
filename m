Return-Path: <linux-acpi+bounces-18621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C53C3F4A3
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 11:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED47188B2F2
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD62F746F;
	Fri,  7 Nov 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="alNAL/7p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7A3016E8;
	Fri,  7 Nov 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509651; cv=fail; b=AqyMUxP4ue7P9TGqzeWS8Bl3zezCDGNnEG0WEZAOxxkmVe6vU7wQbFD17klnoLgbG12WnBt2RYS+b41Cd5UezagenACrSkVqYvAew0//6HcCThJu5Mndu2Qluh9oOsfinJuVYlzr3noQuDWS+zkO+vIGfig00hZ82Mragn/1TYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509651; c=relaxed/simple;
	bh=Cu8HqoPh0lLsy0VRrPhRoiGmEltqATAkc0dW+b0Mnys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qh6rhfvWu7ltySl2Hh1hc0dvTcM/zuwkhLj6yB9IpA5dp9p6p9/bUECst8yxnukLYzpLEAH7u55GVSC8HleTn1i7PxYbglMsrDXnSKWc4dLBPexDUPR9T0APFkxTilqD7WctwGUZ82Rh8pmXVNNzr836xYP9Wcctu3cWK7B/b8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=alNAL/7p; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwwUs7LG7jamBqpAdbfJOqq82fe8HAwmo83D/e1TS34PEbTMDE/2PKWwSbH1jJVgDNuDyWZLrLrynHXcErTct50xVERN3pmr7bE+LEFvFK67jxbx/s2mgRD9SfHo6zTAyCXefwQGNA0WpXoDbN8u/X2LLyERVo/s2eLdX9v3MxKxy8tMisl6ytdVjdxiGhvAxtgEnxAqt/A4PWwa1fmG31UDf7UgT1XHoDqQk8REqd3TqeT18pGE8bzpt8C2tzzfRKYefK89bOva/rXHAbGDt5PjCGNh0lvOS8o9fTJfmjVewNmD1KlqTMgAMI1/K1TBDsS8mLmD02UMFZPZeAMR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGj75tNPlwuSSfm+hx5EKcfQdIW/thgUwgJ6nEGzT/Q=;
 b=dBu/EidW2SKxqVAmmmEbL5AVadFF1DEDtcTr2SLU9IszIfe7eLncLOW0RaN53Nyh+01eoA4qcfjCRVp/9nl6qog9E4vdc0wx5+c3x4r5Ntld0INiVAmDY58iJgHn1cXFcmXl+HOIxUTH3dZfchwMWeXbzxPx0lrzj84oZuJhRrGLX/G78qEjJn5HblJ0vPk5fUvg1miDOB255oSyAxuR9sRMM26Qb9f7UTgqPjQZY60hTTmT2DPhCDpGLAHSF6bqNUopdtpm3Ool6rs0wE7KHzWNa+of0ya98gDGqKTBRzUeK6k9LO+ycX/YOA8KqgrgvN+n7Dba+kNKMLlmZHDKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGj75tNPlwuSSfm+hx5EKcfQdIW/thgUwgJ6nEGzT/Q=;
 b=alNAL/7pW6dGkWJ/kEDihPJqpXyb7q5ynnKhWAK49RuS6DFdlBpomNbM4Lv8rlHb8ihCR6G0R5LQ1QBybDib5xypI9e3ZumMRfxCf8KMt5BUqyFx5FEPEDxuwRPH1HLcurF9ej7rBpGAqqV+tbeaHr6huSbt3Vz9i3TJvgMVGrK5Zeq3Olx9Cy2P5HxaGzqbHgIkIow1cZW3MjDs2ei1nuv7s1abkF3+Brc18ZLyoK5nfh0F/q61ugDCm97eUORnfPOc4HASocm9NaE/jkOmHVU91+wDPyMthFsQz1oFF+CjuwzBBRJLWrhKALpIE0qJKb65Iipc50fiR2oU0x3ctw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 10:00:42 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 10:00:42 +0000
Message-ID: <be696cb5-7d0d-44f6-970b-e417c2f89a8e@nvidia.com>
Date: Fri, 7 Nov 2025 15:30:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: kernel test robot <lkp@intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, sumitg@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com
References: <20251105113844.4086250-5-sumitg@nvidia.com>
 <202511061802.lIq09jwh-lkp@intel.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <202511061802.lIq09jwh-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d80857-eae7-4e07-9f63-08de1de4831d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTBjdUg3Vk5XQitrWkhrSFA5NzlrVnRBR1paYVhtNnhUWm15TlBLODFoTTRB?=
 =?utf-8?B?dXZ1VXJTMXY3azAwVEVJZXlqYVYvOW1ldkVLSTNEMStlYVVwRjJNL3gwSkdB?=
 =?utf-8?B?SlpFZUpRQlRsVW5aRWxNR0p2V1JhTmRmK0dreGdyRXZUcDAzVDI3YVB0QWNK?=
 =?utf-8?B?L0wzUis4RUVLbG45bUsvZjI2OVJCczhNclhDWjJmREZ4T0JvODlNd2NUdzFx?=
 =?utf-8?B?TkFKZ085a2VlSElTVjd5Z3pHaEpHRUFYUlBUc3pYblNITWcvSTlKQms3Y3Y5?=
 =?utf-8?B?ZWxnamhVVE5acE85VXkvckdnL21RWjhCVStMQ1V4YWdyS2xpQ0RxbFZ5SWVE?=
 =?utf-8?B?emxndld5MHF6OFRTb1lsNEdSUzgwSjhiSk5WTjNqcjIxZjFJcnd3YnlINnht?=
 =?utf-8?B?MHpuNUJVVHIwTHlGeWxPYTlBRXA5NDZpU045K0hzV253Tmx3TnpxZEVJQ2ow?=
 =?utf-8?B?K2ZadkVJeTlnY1JrcDdUVmgrblljWWQ1SGtyRy9Od3A1M3hVTHZvWldnYXJy?=
 =?utf-8?B?bkhNSURzdTE3K085QlhxMkxTZjFjc2tpMDBiS3BxdEdmSWJGN0tQbXBWVldq?=
 =?utf-8?B?bzA0eFFoV1pJdjJMeFhhTExSdk8wQjVydm5QMUhoL21PUDU4cDlQMHBuVklP?=
 =?utf-8?B?d3ZyQVNvOHUrUmNOcm5SRUJKZ1NJeEJiZTg5dUdzaDJxZ1Y2cjdULzd1UlhM?=
 =?utf-8?B?eURwQU9zTE5KcHZtaGxlZEtlN2xUYUVIRTBvd0g5QnJLWTF6N2ovTWhJazBr?=
 =?utf-8?B?NzZNVSsxM202SFhsNW1CRjRLRnRXbmJMYjFxRFRMa0tndlNjeGMvZUFWVDRM?=
 =?utf-8?B?d3ducFpVcHg2SzBZTmQ1RVJBMkhlZk0yTkYzR21RbnZpUkNqSlgxc0dtL2Vj?=
 =?utf-8?B?WGdlOWN2WkMvamF5RUpDdXhJblppYVRIeFNmUUhUWkZpTllTa0FGWmxJQTBs?=
 =?utf-8?B?bGxpRnRzZlI4NVNCcVRjMjBBZlJMM1g2aXAzSVhscnJDM3J1TFhEZlA0bnRo?=
 =?utf-8?B?cmtGZzBJRlJKN0tBUTdTS2RxRHVSMHhsUzB1cU5zckRPN0dKQVlmNjFjWnVJ?=
 =?utf-8?B?TE1BMkZlL3VvUjgyR2hrTzdTYjFnNGdPQ2FJS2NrcFFxRURUYU90aU5FeFZS?=
 =?utf-8?B?Nm5jMlpnUHRxLzlCRUl3Y3VFTkVCc0d1cHc2Z1puV1lteU1ZbExYeU1hMElu?=
 =?utf-8?B?SFFnUDQzY2RoL2EvV2FJdVhrQ1kxM0VMYVlrSS92bnl3NFErRTYydnd4ZjR5?=
 =?utf-8?B?LzA0cFd1K01iMHlGbnprbW4zZGkyMElwbzZMd0E1WnIyL0xnZ0M4Q0ljQ0k3?=
 =?utf-8?B?NXNkMTd1bTBSbERMZHl0QjROdW02di8rQW5zeWwzZ09tcGZIRTl2NE0vNkdS?=
 =?utf-8?B?bFNTYy9SUEtrN0pUeGxyZ3V6TWYrUGljMk16VE51ZExPRTJrQ0N6SW91aUxk?=
 =?utf-8?B?anowTmtxRi9jV1dKNGRSbGY3RkpENGRwRkYvSmhrVnZrSGkxeVlSa2FiTGtw?=
 =?utf-8?B?dzNjbnJWZzYxZ2E2SzkxRHh4U3hIUFFYcDIrbGgxYjhvRUhGR3ZzMzZkU1c3?=
 =?utf-8?B?L1cxNlJVY1RteXlJU01xTzBxeUFYKy9ScVhNdWE4d1VpRytnRGk4M2VvOGEx?=
 =?utf-8?B?dW5iUWgxcGoyVWVxN2pzQys2clFSeGJ5Mlg4UjQzQ2FWUUpESWxDVzA5ZG4z?=
 =?utf-8?B?cWQ4UTNiMVlNL0ZVcHdlUER0TXkzMGhPaWxXVUs0VTVFSitVYWVqZFlYTWc4?=
 =?utf-8?B?YmhHclVvSHZ0aGRLTFBoVTFBSXV3ZUQyTlE0dlNzaHNmclpPeXRWaWJUdkV5?=
 =?utf-8?B?cVpnMXEwaDZZdnNLTHlIKzhKdHN5SmVQUzhFODAzNDIySFNxVTlTTFQ0bzFK?=
 =?utf-8?B?WlNSUDNJNCtMZXZGQmZlSUQyUEs5VzMxTkpuVHArWlpkZm5aMFV1a0RuRjF3?=
 =?utf-8?B?SUNRK1FZaHdBRE1sSG4wNzNqWDltQXM4RXBKUGp2UE1xZHk1clFSN3VJdXpZ?=
 =?utf-8?B?TWRBMGNhM2lrMDN0eFlQTFpDQlpnSzN4TGUrWU1tVXgrYUpoVnozWTl2S2FB?=
 =?utf-8?Q?OA86k+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rklzenc4c2s4bU9zSjg2b2p3NmlZWEFpbnFYSlZiTHdEbjQzbmQxckVFbGtC?=
 =?utf-8?B?VnRxMlBWL3NMRjFhYWRMNWRFUnlTbEFhV0NTS1d3bE83MUkydDFNc2FKVkZT?=
 =?utf-8?B?SHpCRFEwK1hVajFnVGd4b3RXODhNN1ZjcDB3RFJQOWljdFlKaitTNlZ3UnZk?=
 =?utf-8?B?bVRHaWxoVjAxZFVML1N4d2RwTndYSWJEaElWN1NoNzlQdFZoeTJnMGFXRnRu?=
 =?utf-8?B?LzVuOCtBUUtOVk52aklCb2VleE9iSGJwQi9JWEljdUw5R1lrYnZNK2RnYy9F?=
 =?utf-8?B?djJiM1dBbVlEVUdvcnFMZ1pNOC9rTDdDQU15U3FtU2lNa3g2M29YU1g2Y2E4?=
 =?utf-8?B?TUo1ZTQrVjkzK1AvbnBKWEc5d2RUdDNtTlJ1WXV0V0ZXb0ZMR0Z1Z0RtNHJW?=
 =?utf-8?B?RXlORExVY0M5TGFJYUxqYkRVQVBFR1RDc3haUkpXcHJxeHQvZk9XWWM5QytI?=
 =?utf-8?B?RWkxNnJMdGQvUlZ2cEM2UmhVT2ZqK3dJNTBXY2ZLN1Q2a2dEOGNvTkxVeEZa?=
 =?utf-8?B?K1RtSXFRZU94R0lSKzNWV2Q5VXl3a2FwMStycGQ0ZEh5SDFBZVdVcElTKzQv?=
 =?utf-8?B?SVpPNFhMRVUxQVBhRzBIMCthaW1DWDVsWmNmbDhlYjg2SEdlN1ZGTktwOFla?=
 =?utf-8?B?dW9UZWN4SGc5d2NrY05McmhteXVrUGYxS21YRThNTUR6VVhkYmMydUxVdmQv?=
 =?utf-8?B?MGZCeVAxWTBGV3ZhM2tpYXZmYk1CZWQvWUNLWUdKTEUzREtTMDZFejhEMCtR?=
 =?utf-8?B?RDRadnREaUlkRnI3RmE3dEVmZlVicDRVcVRzNzIvL1E4RzE0MTNoL3RsR0h5?=
 =?utf-8?B?Um5TN3JDQVFybFVPYkNPSERNSGtFckExcEtWWHBwTnJ6Q25RTnZYQmJaOVFK?=
 =?utf-8?B?MXkvUGFwUDlqK29GL1NDdEhMdW9JSlgyVk5tc3pPL1NjSzlwbEJJSW0yVWI1?=
 =?utf-8?B?OWtsYXExc2FxWHJmdFFtc2tHZUk2NFRqV3gxVDRHZHN0RldlWnlab2xZOVph?=
 =?utf-8?B?RlFhZXJmSW5rdHhPeGRTaWJXRDB1RUFQOVhjWWExd0RCeitFSm5qalc4Q1Rl?=
 =?utf-8?B?OWY0K1dxdkRMRjFFKzlHNUY3Z1VFMFBaaVFFV016T1N1ZmFLMmlFM3RCNUU5?=
 =?utf-8?B?MHVzVnZGR0NtKzlOUm9jdG5NZGprT0tTTWR6SnBxMElBZEl5WnJnZGtONGNI?=
 =?utf-8?B?NDVrL3I3S2V2cnhkNHVrQUU4STZpSXVQNEFTN1dCYXRvaFpsUHczcTdhTUdr?=
 =?utf-8?B?Y2NBNDR6UEI5TE9XelJsUHNodVJYSTRKMzZSdzRxMHE4V1VyNThXRktZODg5?=
 =?utf-8?B?SUhEWllPZm9ndkNWU0pzcDMybWNsSUp1WGxvODkrakQ2dVJZSnZBbmttbmtw?=
 =?utf-8?B?d0JnRDNKV0JaZ0U3WWlBbGh0K1pkR0FmTDYxbVU5VWI4NHNKZmZuWTVBSjZt?=
 =?utf-8?B?dUdGMDZ0KzMweTRuZytxaDdLU0lVblIxWXJsQU9CWVVKcEg1REUzZEllU0ow?=
 =?utf-8?B?Q1I2dkdIZ1c1ZXhJQURWMmdhV3JzN3l5Zjg1ejVqdUpGZkxCb0hEdnhvcU5T?=
 =?utf-8?B?aVJnalluTlMzbHZQb3ZsZmJsZmpaNXVYQzViU0Z2bHdCQWJvejE1VzhGNzNq?=
 =?utf-8?B?bXlNVFhPMkhpOGxpSm1oKzh0SWJYQSt6bllWbzdYSTNCOGdWZ0J5ZXNDOTlQ?=
 =?utf-8?B?aWtrRVlZcEZ1SzM4YUQvTFZOMHM0aFl0eUFpZ0Q5VnRXMEpJdGo5dnA5OVd0?=
 =?utf-8?B?WThKWTFQUnR1WFc5TGpWWE80dDBMVVB6T2RDaU0vRGc3SHppbjhCY2pSc2tm?=
 =?utf-8?B?ZWlxRm9NUnRFTXg1RVlVOXJHOVBnUXFNNkJxOTBYdlpTdm5wS0ZraDlEa1hN?=
 =?utf-8?B?elUvcFlYOWQ3MGdNWitJbjh1S1J0UG82MGpSb21HcjAyS0FyZHlnMWpBQ0o3?=
 =?utf-8?B?aURwcmcyRm5HRmFBaDFJY21SMi9vMWl5RjVrUVJSMFpPcGJRZ0VRNVJrZ0JH?=
 =?utf-8?B?TnlMNWNoQ1VpRk5qaHA2VmIybkpJUHE5ejFxOEIwdCtsaHd3VVVKblgyMzYz?=
 =?utf-8?B?a3ZHZndHVzBJbThDVzFLSTdjc0dVV2FhMFZVaDcweHhYa1I0VWZLelNvRGd6?=
 =?utf-8?Q?F8K7dqz4os1RAJ6irfun9SIxk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d80857-eae7-4e07-9f63-08de1de4831d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:00:42.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRcxtKUdSq4PMFLltOBpnVixNYU+FQhsLv83I7Ho1bL3mz7FSegKuzgEocDRHJ3nNnHR5/lAsfqojvIOjuEPrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354


On 06/11/25 16:00, kernel test robot wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on rafael-pm/bleeding-edge linus/master v6.18-rc4 next-20251106]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Gupta/cpufreq-CPPC-Add-generic-helpers-for-sysfs-show-store/20251105-194715
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20251105113844.4086250-5-sumitg%40nvidia.com
> patch subject: [PATCH v4 4/8] ACPI: CPPC: add APIs and sysfs interface for min/max_perf
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20251106/202511061802.lIq09jwh-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061802.lIq09jwh-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511061802.lIq09jwh-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'policy' not described in 'show_min_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:954 function parameter 'buf' not described in 'show_min_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'policy' not described in 'store_min_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'buf' not described in 'store_min_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:976 function parameter 'count' not described in 'store_min_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'policy' not described in 'show_max_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1003 function parameter 'buf' not described in 'show_max_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'policy' not described in 'store_max_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'buf' not described in 'store_max_perf'
>>> Warning: drivers/cpufreq/cppc_cpufreq.c:1025 function parameter 'count' not described in 'store_max_perf'
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


Thank you for the report.
Below change to comments seem to be fixing this warning.

-------------------------------------------------------
   /**
   * show_min_perf - Show minimum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
   *
   * Reads the MIN_PERF register and converts the performance value to
   * frequency (kHz) for user-space consumption.
@@ -1117,6 +1119,9 @@ static ssize_t show_min_perf(struct cpufreq_policy 
*policy, char *buf)

  /**
   * store_min_perf - Set minimum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ * @count: size of @buf
   *
   * Converts the user-provided frequency (kHz) to a performance value
   * and writes it to the MIN_PERF register.
@@ -1144,6 +1149,8 @@ static ssize_t store_min_perf(struct 
cpufreq_policy *policy, const char *buf, si

  /**
   * show_max_perf - Show maximum performance as frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
   *
   * Reads the MAX_PERF register and converts the performance value to
   * frequency (kHz) for user-space consumption.
@@ -1166,6 +1173,9 @@ static ssize_t show_max_perf(struct cpufreq_policy 
*policy, char *buf)

  /**
   * store_max_perf - Set maximum performance from frequency (kHz)
+ * @policy: cpufreq policy
+ * @buf: buffer to write the frequency value to
+ * @count: size of @buf
-------------------------------------------------------


Thank you,
Sumit Gupta



