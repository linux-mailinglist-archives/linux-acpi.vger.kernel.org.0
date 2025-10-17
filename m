Return-Path: <linux-acpi+bounces-17880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDABEAFA3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D5674442C
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 16:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69362EB87F;
	Fri, 17 Oct 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="XtnTFvdq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023106.outbound.protection.outlook.com [40.107.201.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AF2EB854;
	Fri, 17 Oct 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720061; cv=fail; b=tA1uxJz1kskmbrBffmc3PqId28gvlEd4vK7bt/NVBYA/K7Epu2+IBuiwG5xj/vncRCLUGbhqhOZZt6bJh5hWCoNPqSDG0RMy2HvaIfO+t/bP4AIgSHxJWdjdee7gBMauSqS6iUSX/PSnPLpM8pym2MbSDuissaR1K+nW74aFtwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720061; c=relaxed/simple;
	bh=CHHtoRNagzc7Nd2YAwsG6M/c66nZ61NY8Wc8O3upAO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SH9LZCtDayPQsHJxgpKqT1l9MBUItioqJlzI8Oe1Ch/QicH0ZCBXMRB/1XKzNAbg73ei741SX7GPyvqnIgBJXOouXwIyFVyd2iy2BCuGE1t8Gj/bybZg1TyOxgHaOXyF7a9sA4Q+4aXbTw99nD9Pjt0TUXc7zUiPUnBrqxvL5Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=XtnTFvdq reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irZpLyxnxhUYF1DnVldN4DI2OZGUESVo2lGFTjSe75X30XXgJt6GFeVcY5QT/0Z/dTco8RjHvhGQwJdvZn4fvOggbFylYAWVqRY2/0v4Rfga4hF1pF2Myk/sr3l2bjOxsVxDz6fLh43ZGqBeLpz9iwNxlD90CKGq7zot5NOt2aZzyqfYwuOZWLu4wX/m3RAJdrAT3vTKF6dtM7l5N7S3wR2QuweE3UHUYyZcDPvnv1gIF0OJMS+8h8opwRgycxAN8N17tu3LW5gvZDYruAKnVySuCVksiE+2twSic8U3/iwCa8qgqSftS3tmaBTl+4EEPHHUw3d9s3M9mxjyBSnNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTERCNaqibytxngxT4AiNF6bSDSnpkQEkFB5ZQ/CZaU=;
 b=CAhtOlGjeNbogixobr4kW/whqq1XQSPGq0/XMbZYY2sazxHN/ozxkdMrJcGr5ZtSDKuroxFlrC8UuNMI/5y3fqv4DNiIbB1smNkoRHA2pzdKf7Zicu+Tj/vSMXCO14uHzOQ3E4CHCkisbqztg3rqXRJZmNLZs4rOTYzMmk++KZHlUco816BPS9qG7u5Iao979c8NezpZk1HHQWr3kHinuRiAAvZzRfBC4506N3MvmoDBueq0aXQqbWimPwfEVnf7q9WSQJRGuJs8hTAiqUwRqLM6s8/EvlWyd2Xf7bmw82/EnIBJoH7rUm3A35cio4MEP316/Ve7R2f3vCz6CcGfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTERCNaqibytxngxT4AiNF6bSDSnpkQEkFB5ZQ/CZaU=;
 b=XtnTFvdqYdOmTL+RykxHjeXraHx73FdW4Eja9q1bweJPQFbvVgbJnZLTxdwDiZSCih8S48c3+tmCo2ugI6HHWb1Xl0792aZ2dWno4kPSio6+etQBJxair66FVVlIJn/JWnCZb+wvJ+LmBFH682/kKLD7ykyNnZUxbCHrHB2VTAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB8621.prod.exchangelabs.com (2603:10b6:806:375::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 16:54:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:54:16 +0000
Message-ID: <acedb8e8-3d85-4580-8dc8-52a6643de29f@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:54:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mailbox: pcc: Mark Tx as complete in PCC IRQ handler
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-4-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:930:cf::16) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB8621:EE_
X-MS-Office365-Filtering-Correlation-Id: e90c5352-4c06-4557-b17f-08de0d9dceca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFlZMnZIVnVvblBjZnNHMjBxaFVXQXZWa3h5RjhwT0JibmtCYkpSY3NFeVR6?=
 =?utf-8?B?cXovRWlyUkpmQTNNaWdLaTd0Uml5dHB3VjV6Ukl0SW94NUsyTUJNNktLTXpa?=
 =?utf-8?B?c2o3Q3NKSTU1Tnd1VWtGdFhYSldEalY1NlgwdjZ1RUQvdEV6V0x4b0dVQTFq?=
 =?utf-8?B?bjBJbVZjdGNMVW5sa3RocGVITmt2YjFMem5rTHRleG1SRHRiOUJpVkFpblZy?=
 =?utf-8?B?MkZvZXJNb0RMRGs5dDdyS2VCM0poVGtuTkYveXFQZE1FNE1uVzhUNi9XUUg0?=
 =?utf-8?B?VithMVhXOWZQMzdodTNBenVocGdaM3lVSWxVR0svUUkwQ3daMk5FNzh6Uk0x?=
 =?utf-8?B?YVNWd0syUmRtdDQzbktPVWZYTWk4RStidWROUVpkT3Jmd3R0RU1zNHM0WnhS?=
 =?utf-8?B?MXhuVlhJSll3UHB5OWtYbjVRdmlYckRPelB1b2Z1aWZUWDF5ek52T1RlQVRF?=
 =?utf-8?B?bVB3UzE2WGx4RjlJMEs5T1lSOHdyMm16dHdKZ25YTW54SnU2L1p1V0pBbXdu?=
 =?utf-8?B?WlZaSUlTa25qWVBDRHNtSE9UcGdKWDRjdnRobFBHdTFwK3UyVTlWVE84cHdo?=
 =?utf-8?B?QzYveU55QWM5eUpyeTJjZHNJVitUZkpoR3ZQcnVKM0pmUUI1YmhCLy9GTVhR?=
 =?utf-8?B?eEIwSDE3SG5XMmJpbTlucXVocU5rVkN3dDdoeGNsK1E3QnhsZExHQmgwSU9u?=
 =?utf-8?B?S2VUd01EM1hwUkMrVUg0SFpsenJTc1lYaVZFSHRWOTgrK3RCWjc5TmxNQ0Yx?=
 =?utf-8?B?VkFNUlJZbkx4dWJWUWNvU3dpdi81S0JzOGVCbk1JVGNkSGg3dndsZUFXN3B0?=
 =?utf-8?B?b3VQeHN2WVI5bng4N2FkdE1EbGFuc1BCOTlhMW84aDRtSFh6SEh4WkVXcUZK?=
 =?utf-8?B?Z3FBVmcyY3NYeE9hYlBGRzNVNzJUa09xOUpKQVljNnJ0V0cwWXdyNGllelow?=
 =?utf-8?B?OHNSUkFVTTFLYXV6U1dXZjNZVk4wWGtRb3ZmdGZod2NuU0FsbXloSFVTcUFG?=
 =?utf-8?B?czdkRm5YamQwZkZ1SjJLdnh4Rk5LRXpjWURJeVZzQW5nRzFHQzJ0SGN1MUJs?=
 =?utf-8?B?QmhKVHFwM1lNR1kvYThoL3JIT2ptWWZFdzN4Wlh0d3RwZkRMemxyRURydmR0?=
 =?utf-8?B?TEhkTkxXUzBPSDFSN1B6RzFNUUQzWTlKd3lockVEc0JMdWJFQ1FQMkJWT3c3?=
 =?utf-8?B?R1ZZMllycVIydWoxdnczOFpmM0JtTEhQVjVqVFRLU2p3UlpaK3pYVHJKYUVy?=
 =?utf-8?B?QkduN01SbXRib2dTREdDTUQwSTltNzVsNHQraFE3U2txVUlHL3R6bGJ3SHYz?=
 =?utf-8?B?WUlUSGNUWnE2UEFSdys0UHkyTyszYm5WZCttUVpyeVJjZS9yNFVqMjZydEdL?=
 =?utf-8?B?d09sb0VhSnlEOElkczZiT3JOUnBncURBNUZqM0lmUCtGYVpwQ2JjSktxMC9F?=
 =?utf-8?B?NWF2d1ExZzdLMDlOa1RSZE55UG93elcxT1o4TzRwUnlDMFBrWm45aGFmcExx?=
 =?utf-8?B?eXhMRDJxUjd0SFNJc1ZZVVdkeTU1U3I0VURhOGlZQkxwcExvNWcxU09CVkpY?=
 =?utf-8?B?clZWb2tLN0Z1cXoxK09mdURJM1Rzc1hhQ0JYTmVQOGduZjZWbzlSQ2htTUFr?=
 =?utf-8?B?OHNBaWhkWllNK3BlWlVkaEtDNWc5dEJueDY2WWtyK1NvMlRSZW9QWEhVbEV4?=
 =?utf-8?B?L3hmSk83N3pJS2NFVnlVTzJtN25YU0theVhDaE84QzA3SHdzSzBaV1lRWnN2?=
 =?utf-8?B?c1ZaTzRTNW1jZ05nTWVGWmM0enNSZGZ5bU1sU0NKVXBxK1ZaS2tmeWJLR0tJ?=
 =?utf-8?B?ZnVld3oweXAvSU5Da3RMZGZTSEVSeE9oZnZzbVVkUjhnYVNNTzRkbERkZ1NV?=
 =?utf-8?B?ME14bU5KbzhUcXFIb2s5R2V4WHJSaGxFNG9HS0N0K3dRNTJOeDN2bXhySnd3?=
 =?utf-8?Q?uVOEDLvGI7zPfHLLeRYMH8KaUaICtnmE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lidFRFL1lJOUtSV3h5SkZLeGZSL0lTM2FmQlN3NG5jYlFlYUlSeWVZbyts?=
 =?utf-8?B?NHdEZmZhaDZrbUdoZG1wTkprVkEvVTluSXVCQlM0bVZqQUlnUGIweXJUZ3hp?=
 =?utf-8?B?WXRES1dBMmI1TTJEYWtMNDhsL2J2WGdYVHI1Snh3OUI1bEticDNFOVFPNHpW?=
 =?utf-8?B?UGdpWkZRS2ZWSi9zZGRYM3F2dS9mZE9yb1N1OFlIMENrMUdSRTJzZy9hNFVj?=
 =?utf-8?B?SmorVENmY2tSYTFhcmNNM09VbDFvUjc3WWZJbStpdkwzVHlBY3VVOGF6UU4v?=
 =?utf-8?B?bWhpK1F1VE82VVZWRmJlRVJhdHJKSWNJSEhPWjJpOFZUQ080aUI2WDNRVS92?=
 =?utf-8?B?TXFuTmpZWHhnekFJeFVla0NBWmt5RjBzeEpxcDFINVJlRHJDVlhjNFA4bktQ?=
 =?utf-8?B?SSt1MFA4WmVQczZlN1ZCUUY3OHJtVEpxem4raDlNWDY2Zm96UWg5V3dkZ1FE?=
 =?utf-8?B?MzF0cDVwTG94L3BaQUdzQ3ZkZVdZR0hEZjJnWkJoVWZEVEwxZGsvT01tZ3pW?=
 =?utf-8?B?d1BCWjVRZXVmMW05dmJ6NlA0STZ0c2RvWWY5K1F0MTk2RW5USVFvY09QSEg2?=
 =?utf-8?B?OUt0WWRjZWNvUGJHUzBsSHQzRS95Vm1FZVdiYk5hWGxTZ1Y4TlIyYnp2SFVF?=
 =?utf-8?B?akJzdjMwa0xvdm1pSFV6QUp6ZlorZUFNb05nRm45KzZrenphK1VjSkpmZkpK?=
 =?utf-8?B?cXY3MHRENFFDSXI2emZLYXZRekVUOHBLekVIb0d6a1doTnpKS2dEUDV6K2dr?=
 =?utf-8?B?bENRR0FkekhBbWtrL0lydjZHZW5NbFdLSlU2N1ZpUXlEeFFqZ0lMWTNrb1VY?=
 =?utf-8?B?Y2ZRZDRIZEVyVnJqdmlrRW1CV1RKa2VuMjFJQkpoMmR6NGF4cmNyMlR0OVB6?=
 =?utf-8?B?Y0QzTXRDRmQrcXBMQVYwZVhINDFsd0hyeFNib1dxMEV3T3N5SEEwUWd3a3U1?=
 =?utf-8?B?Q0tOYmtXQ0lBL1EwRVJoWWtvbE4zWUppSlhzNGFBcGx5NWgrVmtWMnpRdTZQ?=
 =?utf-8?B?M082VkVNREl6bjUzRHk0VFExL3VDRXppRGU3MmpteU01RlUxbmZzMDR2ckhz?=
 =?utf-8?B?bWRVNzdqMWR0NDN4Zi82Q1VEMmU2OW9WWngzYVlXVi9icm1WdG1rdFhHM0RM?=
 =?utf-8?B?ZVBMNGs4Y0RMekc3MG4ySFVoREMwV0pXV1FxbzZseTFma2oxaTEzSGovR1Q2?=
 =?utf-8?B?RGZlUDdrMzIxRUJnOEJobEliRGRYUm00OThibnN5dTUvbEtiUHNid2ZsSHBu?=
 =?utf-8?B?SlB1d3E3VjRKSlJkMURlWkYyTVowQXFSeW5vTDhRSVpObzdHd3EvZmdrR0Ey?=
 =?utf-8?B?NEJPdStWK1VwbThQWXBjSlBuYTUwUWR0a1Jvb2JsRXNrVFVmUHpsTXN2cW1p?=
 =?utf-8?B?YVV6OEdJM2k5RmducXh2d0JRK2s1d3d3TnlZYzRsek5pUDdPTVRTMWJFb0Vl?=
 =?utf-8?B?aHltT2NJanBDeHpnMXJCQnp1SlZoVldpUGRGNnArS295S3hUUUFWeDM1SDNi?=
 =?utf-8?B?dzBRY1hYWXhLdnJXMVRUbVJKdFMrdWxjQlBkb0QvOVZVQXltWGE4SGI0cDJC?=
 =?utf-8?B?dlliU1R4djl4OWZla2YyZWpZd1lsS1hFdHh3Q29qQjRLb2c1Tm41U1FveFNz?=
 =?utf-8?B?UklsdzRPbm1YWHZSMFpVNjBvYU1iNjJqd3lhT0ozWDNsd09WSXVzYkpVNjk5?=
 =?utf-8?B?YUJXeHBTUVEwQnF4azdxZHJYTGxHbVNGSmhmWHA1MkhYVG9JMXJsR1BUdkdZ?=
 =?utf-8?B?MjNWRVpEMG5MQm9rOS9CQVU4RzBSa2JTaGtETmJZMm5yWXhqdFJJS01TLy9n?=
 =?utf-8?B?dkp2Qk1BeElvakloc0lpN0JHOSs2SHdjQlNZcVhvYVlURzNyUXNXWkFmVFk5?=
 =?utf-8?B?YWMrUk9GSzRvaHFNOUtWY3k1Z1A1cmpCYWpFWjRvblM3ckx2U3ovS3JGRUYv?=
 =?utf-8?B?Sit2Y3dmOTM5a2Fmcm05OVRKZzlJQzdiNnlEWFBHRklIYlh1a3FJemhaLy9S?=
 =?utf-8?B?eW5iZ2NoRDNhQ09pZjhtVnR0Z1hEMzJoL05ialpBOWFQdWRYYW4rdVlaY21m?=
 =?utf-8?B?OTV4RXV6djhNYUpYMWE1aTgvYUFPZGVwejFBSGdWbFIvR1pNZmRoWGpXekw3?=
 =?utf-8?B?YkUvbnhhdVY0L3JTV1NWNmlJejRiNWVXMFhrNElFNjhBdGk4UmpyRE5CblZs?=
 =?utf-8?B?M3FVRWpDVS96dU84ZXdPWTIrVnEraXcyaGhtbEsxaldXTmFVS1h5bWxRc3Zq?=
 =?utf-8?Q?Kcj3/sNvMRyXBP/1RDlKLe98tDeUUhoUPekQAWxeSw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90c5352-4c06-4557-b17f-08de0d9dceca
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:54:16.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2ZWUqr6ldUtniJ+yvYzNZLYw2ZCl1fbkTmOjIh8tpi8MOyp2el+cbUyTK73AGXNe1OA5XzM4WSFmGn3c8LYg0QuXBLVfkC9LDN74svcO3rH4nT7owv/tqdgYBTb3uzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8621

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> The PCC IRQ handler clears channel-in-use and notifies clients with
> mbox_chan_received_data(), but it does not explicitly mark the
> transmit as complete. In IRQ completion mode this could leave Tx complete
> waiters hanging or lead to generic timeouts in the mailbox core.
>
> Invoke mbox_chan_txdone() in the IRQ path once the platform has
> acknowledged the transfer so the core can wake any waiters and update
> state accordingly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 327e022973db..33bd2d05704b 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -341,6 +341,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 */
>   	pchan->chan_in_use = false;
>   	mbox_chan_received_data(chan, NULL);
> +	mbox_chan_txdone(chan, 0);
>   
>   	pcc_chan_acknowledge(pchan);
>   
>

