Return-Path: <linux-acpi+bounces-10625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD291A10C32
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC07118881C5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10CD1B87C6;
	Tue, 14 Jan 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w4AnXFKd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1313BAEE;
	Tue, 14 Jan 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871858; cv=fail; b=qVB9DmbPnj4Sszi/9oog7x4TSBYMPcCdnC2tcyG1bntC/Fywq4O57rTKvfP5nnNpD7W4DTNWc1toXKKOgO9CRXXhpC7J6TqFtpi3Xw3jcm2pHDi3XPLuCes5bQWil6vCZHVEykM5kd5tHqjW7NUvzbj6rFWqoJF55nMn2zr50WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871858; c=relaxed/simple;
	bh=CxmpDer6TQVUbLSxRe2x93WCIsGSQn554GsoO7SvGOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZlYk+qzOjHMaHvtRysTD5MEHightIWKjPHZ9QBnQO3sDS+5ZVQhTXWtO1h0fUhcC33SzBVmm3Uvvd4NeMz2e5b8eGSSn+MjsnwTSIcaB9FoMJUST2Lex8va2nw9xT/ADZjq97wWg6QI/ytLSRA1Mawu9MnWho5SyX1ILbBQb6vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w4AnXFKd; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo+lEqwp3gsfyLBQKvpgTAciisJEn8buiDh50SdbLHLKKpJakSMhBMEZXeH1RCaxZnJqF/kxcwyWn8LW7liyBsMBkbpZXo6G2mqtm5pXywqmnWbet4bOvEgF3A1zvIiQB4Dv9Pte09fZ8sYqViV13Ndgf82amtv7RzBnug4vPoV0SoMpuzhQtavrvL53N3/XWly0Xsuoiz/NFe1R6zCBhEd6s3iDoHUMGVDuS4Y2Fsf9c8I6u6wIAPbQflVdYCu3D/4HqPoJALpF0y2+MFEuOhLZZBy4TKq8xMmRFvUq4Fbovq3IaQSbSSndN3L5Xq0MnAr1nUJ66yyBsXELVWw3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsckR61HwhLqfNvY6ynsHy+S3Kttlk/P1LTW5Ljxdc4=;
 b=c+M4FJ9qL0yT+1iDXd9OVywznWV0m8gNXertpVWix0TYAAc2YLEKvFP/YgQeBf14YBX5ekrsa2he92ZPfwkVNoO9u0ihE8yGb9QnRC5lj75liGwDEF/0N9HQ+BgHuqw3AJtjsXZHpCagGqm3KE2R0X97aYU/e9onE+OstzJxShHCIZYD05RL2+X6vIM65A6dvOijMIUqbzMEnI3abs/NqgMu1KIYCJZkWimAwgAzBFO14i6AWokDN1RrMA9ibb5aRNdqWeVTPSVgtGYvVcacirggSQvCRpaenDziW3ODzPlASSNYXv+sxlbRKhwf0fHmb2eAcS9ElrszOemOwqjFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsckR61HwhLqfNvY6ynsHy+S3Kttlk/P1LTW5Ljxdc4=;
 b=w4AnXFKdlcvXgBjzvsgRFGrH7yN1o1W56iAI8YfHVmcNx2qde67DeOukS4Qjj/TbKcxV4lpfKYqpgACvRyh1WMOIgAtgH9hIwddt6Mmt+LolAFMAoDnDa4g+zkau198RDTHDv6xNdRIZLCo2tXHlsShwsNF6nQnBkUiKyOSzGdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:24:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 16:24:12 +0000
Message-ID: <29f8eafe-733a-484f-a99e-e40bc665a682@amd.com>
Date: Tue, 14 Jan 2025 10:24:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] ACPI: platform_profile: Add documentation
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250114153726.11802-1-kuurtb@gmail.com>
 <20250114153726.11802-19-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250114153726.11802-19-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0021.namprd18.prod.outlook.com
 (2603:10b6:806:f3::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 47578c8a-470f-49d5-60df-08dd34b7e14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0VPRlFQTEk0bHVuTXJSL2c0d3VCMkMxM3AwbklROWozOXI4YUM4WWZHb2M1?=
 =?utf-8?B?RytWQTZhT2dtUmFCS3V6UitOSU9seG01VTZlOGRHTmFzS1ZkZGRBZkZOdVY4?=
 =?utf-8?B?K0xKSjVZRzd3ZHVNVTZGSitLdXJhd3VZT3VaWHFtbDlVSTArQXlRdG8yZWM0?=
 =?utf-8?B?b3Juc1RFRTVDZitySStMMXZiZlZ3aHNFYlVhL0lwS0xjZU1nWDRzYkszc0lp?=
 =?utf-8?B?dm1CS082NzZ4NTFuTEVaK0ZlcjFVdldLUHdWbnp2ZzVydTlXQU5USDdEM1E3?=
 =?utf-8?B?TlpreVRwV1ZpQnR0ckJBODZ2MHh5T1Z3RXVjWjJGdmZlbmk3YjFFZU1McE9a?=
 =?utf-8?B?S1BaaGkvSmJpVk9idENaME9ralVXb2VVdU9EVi9CdWNsNUd0em9hYzRXWTVu?=
 =?utf-8?B?TWJMRlhUSkNGUWZCR3g4THdaNEErOXd1WTRsTUM0MWRLTTdCSG1EMkVHbHlV?=
 =?utf-8?B?Qi9ydTU4SXhTWUpvaFF3UFJXNmJZQndkcFdZZGp4Zi9DNWlQdGFnb1NwTWlo?=
 =?utf-8?B?L2lQcEJ2YjQvYmVVQVFCMjdibUoxWmNWVnc3KytYd2d0Zi9Jbk5vcHhtQVhR?=
 =?utf-8?B?TWV0eFJYUG9tRGhmRWY5em5USFJ6cW1NMW9QejZ4VGl2VGJVMFhsbTY1Rlg0?=
 =?utf-8?B?c3UvK2xuelhoMHBzcXUwQm4zT2dmWGxrbjA0RkhmblBMWTVkc0ZqdWhZTG9V?=
 =?utf-8?B?aFU0WDcxVmFGT2VYdDUyaEsvRHAranNCMGdtMHE0bTYwcWRuWGZ1WjB0aDNr?=
 =?utf-8?B?SlI0K2tkck5jSVNGUnZrNEVXVGNwOTMxRFhCMGI5RlQ3Rld2T0praElmTFdm?=
 =?utf-8?B?VDhYWk9aeWRTYjhNN0pkcVpTQXFaMzhuZWNTWTkwSFZNcVdCMEZJNjYyQnpz?=
 =?utf-8?B?WHY0NEVvR3BXa1A3QVRNWEhYdmpnRTlSeDhyek1PUjFUQjNPWjhvSnlHK2F6?=
 =?utf-8?B?WE1NbldZTldDdlRQU2FRUjc5UjVvWUI3Tk9MWkFnTVFuSitCWDU3Y1cwdG9W?=
 =?utf-8?B?bENXTnVsUUxwUkpBUXQvbjNIMkVWYWduazVrMnpwUUJzM1NhbHFrY2RPYlFv?=
 =?utf-8?B?N3lXejZlNzlWTndkcXdqK2c5SG1MUHlnNUxaVlZRZnkzdW9IdFVmcUljRUMz?=
 =?utf-8?B?bVNKeXF5Wld5Nnl4a2pvdGxBZmI1dWFwMmhXUTBHYmxZcFQxT3EzTlE5d1NU?=
 =?utf-8?B?a1l6ZnF6amdsczAyZ00vTDBXekFZLzM4UDcvd1BsTmYxeXdLN1g0S1J1ZStv?=
 =?utf-8?B?cGdoUlJvZmJpQzVTcXhROWNYYVJ3VVdJQ0F4THRsWWZFb0hneitmaFB3c3RM?=
 =?utf-8?B?YXE2RGJ2VVhQcjJjZU83NTJSR3NLK3ZHblBkMXNtTm0rRGRYRUpMajhZU0ha?=
 =?utf-8?B?WC96bW94WlNNYmNkZERXUG9pdkVJSGwybkRXWSszclpwdkdnNnd1SG0rRjds?=
 =?utf-8?B?TGRIWXV1RzFxWHFlcjVMM0c3SFdwd3BPR3hOQ21rWXhUTnJjOGZXWWZ4MHlR?=
 =?utf-8?B?V3JNcnZpRWQ2bHhOM3JiRHVOeFVMT0xINVAyVnJGNDRaUWo4OHpjcVgyTFQw?=
 =?utf-8?B?L2hHWUU2ZUF4bTJzUm11ZUp1L3FmcjhEQ2pjeGMyc0srTytYdlcxeFF0cFlB?=
 =?utf-8?B?d0UvbDdQK2pjRXl1WnVQZTlYSWNvR0pJd1JlaXIrc0R2ZGcrQkNuN0svZlZL?=
 =?utf-8?B?TXB1MUdJR20zYWRPVDJMZldDVFlGWWlBZjdxQVgzcEEvZjhDNEh1ajlWM0Ns?=
 =?utf-8?B?M01GcEJDWDgyUVAvS0FaZTJGUXVFYnRibWFST3lNS2M4d01uQUxUbXM5Q1lV?=
 =?utf-8?B?MGFpVHlna3NLdmVwWVZaS0UrQ1JKSFNkN1RydHI1cXhYbmJPQldOSVNITWVm?=
 =?utf-8?Q?9V0N2mgjU6zKT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFhmWjFhR0FaZlZzdjZJZGlVeGdXb2dXcHdXUTVUbmhjeG1PNzVaZERZS3ZO?=
 =?utf-8?B?a2MwY2pPTHh1eFVBMzNGSlMyYTFhWCtnMEpHTTFWNVo3UHJRbkFqYjN6RFJR?=
 =?utf-8?B?Z0pqcktvMjVXTm10VmFFRFNrVThqbExhWm5RMDk1UW5zRUdYR2Z0eHA2Y3A1?=
 =?utf-8?B?L3kyRkJ1QzdPRDdFME84YVIrb3RuYjRKa0pxcFNKY1Q3NGJJQWFRVmR5UTVv?=
 =?utf-8?B?OEI4Ry95YTlJRWtUZU9iK1oxTHdWaHIrWUJ6R1dYbGhLS2tjQmFoU1pwL3pK?=
 =?utf-8?B?SjA0cTdYYnJ6YUV0UTlQdkJEMDNGSHZMaTExK2hldUZFSTJnc1NVZ1NDM2Fx?=
 =?utf-8?B?MXFsR2lONTlNeXBQWHF6T21Jc1NXL040KzB1WU1lVzdzRWxvcmtLZ05BWWVk?=
 =?utf-8?B?NzB5ZkdqNUF6S2VYSHQ0T1hFTVgzTitYTFZkd1VMU0phZ2k5dEFCVTl4OUkv?=
 =?utf-8?B?L1R4MnFLVWplQVkyaHdsaEJNRFIyekpYM1JjT3d6cUhEOEFHbjZpSWtKUUdC?=
 =?utf-8?B?R1VDSXVBRUxhRlp0WTdYYzBQYVJOTC9XdjhLZkhiN1RDejFhNWFNdHVWZmdV?=
 =?utf-8?B?ZXVXYmVOSmwycDJVNGp2K0I0SExFNXB2ZDVnNE1DeXJ1Zmo0RFNSQ0pYOWYw?=
 =?utf-8?B?U0F5dU9vKzZlOHp0bXpVZy9MVCtwZEdGTERYNkJsem0xazFHbXczK1lEbEZU?=
 =?utf-8?B?cnhtUHZVMk5XRjBRRUlSTUNQRThlVGd2ZjhBektUR0VHL2pGYVRZNHptcmJY?=
 =?utf-8?B?a2J1NlFjekI2MVhPd0RPSGU0VGFYelNOZDduQTZpb2ZEVmtlNU42Skp0QnRL?=
 =?utf-8?B?amFvcm1PdzIzbWp4bjVWM0VVdkNqYk5qR0UrT3VlNmFMeUhtMjBoaFhjWXND?=
 =?utf-8?B?aWJDRS8zLy9acEx0bHZkZ05RMEo3d1hlRXVkNHdoM2I3SkN1cGpEOWdzajZj?=
 =?utf-8?B?NGpOaCt1NHZaeUlleVFscHNMK0tNWE43ajFoc2JSUzR4bFI3NXVSYVp2cnJr?=
 =?utf-8?B?MHZvTFBVbTIzZXBKWnF0Wk9hT2xmWnhaemw3cVRvRy84VmIzOUNLY2k5QWJo?=
 =?utf-8?B?WUV6UCtmcVVNMUpod292cVpvSE84VTllOG9LT0FTYWFIV3kwdGpIV0RXNFBT?=
 =?utf-8?B?NVl3aldPZzI4MHJJYlQrOTgwVUphUnRwY1Z4bXpUeFRVU2Q0MisvSHVzcUtt?=
 =?utf-8?B?K3pMV1JsN3BUQm1McCtUSTNrME40YmdXTFN2akZNenZvdlplcXFUb2Rxa0sr?=
 =?utf-8?B?WHRsMW9QM1JuSDdObDRKQmpEUXpFdlVtak05d0I1RnVUeTJsVjA2dzZ4Ylkz?=
 =?utf-8?B?R3ZIM3VNNlpxUk1UUEZXczJmcnBOK0pJRjhSOFV6VlczaytXVmZLdld5WDgx?=
 =?utf-8?B?YmFFR1FkUGZjcUdzY2JSYlgyWm56ME5tKzVtZ0RvU1VTWlFTYi9Sc0F2eS8w?=
 =?utf-8?B?L215NTdKZGllelBLOTZVdXVGK2UvTjlzVWRMeUZzUk1hRGVHeWZxVk9UaGxu?=
 =?utf-8?B?cUJiWU0vQnYyRzdSZDFsdXdJcUZKZlh3aE44WUtNRjA2RzM1eldzejNVL3Fp?=
 =?utf-8?B?YVFEMGVXejQzbUtJbTNrR3MyMkVPYThjTktpSVV3ZGJFRXh1Nm91YUxIaHh2?=
 =?utf-8?B?djlzcTVZZk1rU1pidUVENEFhVEs1U0dVam5rTUlOQWpCTlNxRksxWW1GL2Nu?=
 =?utf-8?B?aHRtMzlGUURhMW8xL0RCWTRQSDBscU12UHdROHV1OVJONGtsaE1JTE9wazEx?=
 =?utf-8?B?dm1ENXFtbFpiT3VNZXQ5WEVua1l6UTc2Z01nK2VJTUlTa1dlaUUwckFmK0px?=
 =?utf-8?B?L3NFWVVqcURiQkxEWkNvcUM1d3BDV041R05TVHlPOE9lQ3puZHB4cmg2dEs5?=
 =?utf-8?B?ZkE3bzIwcXlHTlZzSi9QZG1NZjBtaDdJaThLODNwNnNaYVY3SVpqUjRSN0M1?=
 =?utf-8?B?bDkyRldhSDR6c0tieGtqTjNsMm1FemFhaXZlSlF3MjJLczFhVTBWYXFCUE53?=
 =?utf-8?B?bmVVRzNPenJZZENQYWNLY2VnNk1RRXd1RlpyVkUzcmxPMEFQa0NHazZpV1o2?=
 =?utf-8?B?OHU2dmVzOGorMlF2NjJnUm5lQjFQdk41ZUxKTEZRNTVwVVErMGMwU0tBVUsx?=
 =?utf-8?Q?M/qPVG/nBgVSPKOu/HrHWNGIq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47578c8a-470f-49d5-60df-08dd34b7e14c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:24:12.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfVih5qGRovQlNRoDeGu49UalkXkUu6629iIQce8o+D51EqBge5ISNx3tTJXxDYW+o0NUHlO1EwlKJ2kO2Le5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On 1/14/2025 09:37, Kurt Borja wrote:
> Add kerneldoc and sysfs class documentation.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
>   drivers/acpi/platform_profile.c               | 33 ++++++++++++++
>   include/linux/platform_profile.h              | 24 ++++++++++
>   3 files changed, 101 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
> new file mode 100644
> index 000000000000..b5a3600080bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -0,0 +1,44 @@
> +What:		/sys/class/platform-profile/platform-profile-X/name
> +Date:		January 2025
> +Description:	Name of the class device given by the driver.
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/choices
> +Date:		January 2025
> +Description:	This file contains a space-separated list of profiles supported for this device.
> +
> +		Drivers must use the following standard profile-names:
> +
> +		====================	========================================
> +		low-power		Low power consumption
> +		cool			Cooler operation
> +		quiet			Quieter operation
> +		balanced		Balance between low power consumption
> +					and performance
> +		balanced-performance	Balance between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance		High performance operation
> +		custom			Driver defined custom profile
> +		====================	========================================
> +
> +		RO
> +
> +What:		/sys/class/platform-profile/platform-profile-X/profile
> +Date:		January 2025
> +Description:	Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		platform_profile_choices changes the profile to the new value.
> +
> +		This file can be monitored for changes by polling for POLLPRI,
> +		POLLPRI will be signaled on any changes, independent of those
> +		changes coming from a userspace write; or coming from another
> +		source such as e.g. a hotkey triggered profile change handled
> +		either directly by the embedded-controller or fully handled
> +		inside the kernel.
> +
> +		This file may also emit the string 'custom' to indicate
> +		that the driver is using a driver defined custom profile.
> +
> +		RW
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index c44989801f8e..9caddac695b8 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -426,6 +426,10 @@ static const struct attribute_group platform_profile_group = {
>   	.is_visible = profile_class_is_visible,
>   };
>   
> +/**
> + * platform_profile_notify - Notify class device and legacy sysfs interface
> + * @dev: The class device
> + */
>   void platform_profile_notify(struct device *dev)
>   {
>   	scoped_cond_guard(mutex_intr, return, &profile_lock) {
> @@ -435,6 +439,11 @@ void platform_profile_notify(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
>   
> +/**
> + * platform_profile_cycle - Cycles profiles available on all registered class devices
> + *
> + * Return: 0 on success, -errno on failure
> + */
>   int platform_profile_cycle(void)
>   {
>   	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
> @@ -478,6 +487,15 @@ int platform_profile_cycle(void)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>   
> +/**
> + * platform_profile_register - Creates and registers a platform profile class device
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>   struct device *platform_profile_register(struct device *dev, const char *name,
>   					 void *drvdata,
>   					 const struct platform_profile_ops *ops)
> @@ -544,6 +562,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>   
> +/**
> + * platform_profile_remove - Unregisters a platform profile class device
> + * @dev: Class device
> + *
> + * Return: 0
> + */
>   int platform_profile_remove(struct device *dev)
>   {
>   	struct platform_profile_handler *pprof = to_pprof_handler(dev);
> @@ -569,6 +593,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
>   	platform_profile_remove(*ppdev);
>   }
>   
> +/**
> + * devm_platform_profile_register - Device managed version of platform_profile_register
> + * @dev: Parent device
> + * @name: Name of the class device
> + * @drvdata: Driver data that will be attached to the class device
> + * @ops: Platform profile's mandatory operations
> + *
> + * Return: pointer to the new class device on success, ERR_PTR on failure
> + */
>   struct device *devm_platform_profile_register(struct device *dev, const char *name,
>   					      void *drvdata,
>   					      const struct platform_profile_ops *ops)
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index eea1daf85616..eb4dc85dc18c 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,6 +28,30 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };
>   
> +/**
> + * struct platform_profile_ops - platform profile operations
> + * @probe:	Callback to setup choices available to the new class device.
> + *		Parameters are:
> + *		@drvdata: drvdata pointer passed to platform_profile_register.
> + *		@choices: Empty choices bitmap which the driver has to manually
> + *			  setup, by using set_bit() in bits corresponding to
> + *			  platform_profile_option values. These values will only
> + *			  be enforced when a new profile is selected from
> + *			  user-space.
> + * @profile_get: Callback that will be called when showing the current platform
> + *		 profile.
> + *		 Parameters are:
> + *		 @dev: Class device.
> + *		 @profile: Pointer to the profile which will be read from
> + *			   user-space. Selected choices are not enforced when
> + *			   modifying this value.
> + * @profile_set: Callback that will be called when storing the new platform
> + *		 profile.
> + *		 Parameters are:
> + *		 @dev: Class device.
> + *		 @profile: New platform profile to be set. Guaranteed to be a
> + *			   value selected in the @probe callback.
> + */
>   struct platform_profile_ops {
>   	int (*probe)(void *drvdata, unsigned long *choices);
>   	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);


