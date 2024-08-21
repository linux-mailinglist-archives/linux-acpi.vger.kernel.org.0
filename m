Return-Path: <linux-acpi+bounces-7750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0895937E
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDF81F22062
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672A15746A;
	Wed, 21 Aug 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hg2HSgI1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180573D8E;
	Wed, 21 Aug 2024 04:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212877; cv=fail; b=AxgJoYcxydpNm//XpLRGYtgIPjQMU8AMF4BQaBtulGtZeItrAus7qbTMoazjzcPHQoIV8JwsU8atR1wx5n27dHR7GHegsWUqOjiihZi9VqYqRQnmeFVVLp8qaj1SK/F8DMM9htrQ2v7jigqUn7kdIh+4yDIlquNHt1vgxlpOUvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212877; c=relaxed/simple;
	bh=aM7pUhu7UfOSibWFRlDf/npZORbUVRyf1X/1PaVZGQw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BXcbgPQ6Pf6uhtrfAXH1YxcdRqgrRQ5hELNR5wLE40/vTTuGFAyaF6H6tdcVY7PNS6S26+sJ4KValIbLiBoJ5UmImfncNFt52YVezeUYyh/TViJ7xRGuGi//bT2SPVQtBVKCyuLzACupkPNDaeTD3WroqeEnbQmJUUaIsuW8Xx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hg2HSgI1; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMrgALsJrXpdXmgDJqLKAukUEdEOHDqLDqpqdd8CoaZpy/VixhL0juhbdlorHv2tAAKCRrVGyVyoSVe07o2Pjp9dxxG2vQOl6e3+etLLkXref3dkD7Bv2U8gaRKMFpmL9Snr5m5e7Q7dlV2sH08RoKukqhiLgPCB3nM4IbfdEZvG48sHnTJYN7or1yBdAOyoSre5VBODIgjtKHg6keRZWSoRGoPLw9ZnGVCZXas8ctWUw2Ye0KoVH8Ke99zKlJTANnR8jP14xmpRnjdSoIhEOAakWBv1x3ksAiG7AHVHRX3pbvmvUasvVIOshaS+6jFuDVw1d3HF987LVs0+FoQPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+bbRZkE+ty0weaAtCy8hjg0yfEk1SQ27sxemGqVqXY=;
 b=UCTP97SJ8KYt3PP/+NYw35n7gBqqEUiMwgzlr/+G+vUklFQR0uoaoAOKOPTNPnTJw5b6o26kkGYjYt3OrxS/zvHnFsmcuA+hHTyjFsFJztok4Oohtx4hyBLS/uZqFo7XH6zTi7iRarjf8xrmbODSFKn4V+Y1GykIoo6g6quAgBFP5gffl7g2wSETlOOW6Q71QQ7mKemsOAkh2N2yr0GQ4o1QayOh2JHKZirJCtGRb7LbEE/K+QhyK72kFsjDgDQJkB61Xbp4MdkB1SPPsZClSdQQD88SfEf31TKxiwbp91x7WAZmT3RICe3yaMbkhsuxjYSRbhti1eD5tB1fehmFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+bbRZkE+ty0weaAtCy8hjg0yfEk1SQ27sxemGqVqXY=;
 b=hg2HSgI1alrKieiaihvoLe4/4vJ45tSJ5mmr2lu7aqeNmTUzqpM9YMvTq2OYoWxn9j9iveNLO7ioM7HgI4KZiKAYwSXASDtGTgtqmeRDJE44Tv873gs+4TkHUtpNLUFunQyJpUA2h9vJUsnNS3rkMTFrR6HABm9+FBVYFRfmcD9zkdHcpbtvLLDeoEXRQ9v1YxZ5RLB5oHLkJRmbUiOIbcND/v6QoP+tk71ibDh9+R5CV9OgZ7yakOE6ujAyX6h23eYRNX1gvI2k0TfchrYPWxiEVx+92qEAkk/efWdIMFERHgC6Sf+z9+jLl7SjfzsvezfTsugFvenoK3X5eXgldg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 04:01:12 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 04:01:12 +0000
Message-ID: <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
Date: Wed, 21 Aug 2024 12:01:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240801014853.1594699-1-kobak@nvidia.com>
 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::30) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e506a6-e0e4-4f2e-d0b9-08dcc195e53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3ZDeTF1MGdWbFhqWnNNN2VaMnNTUmEwTnFGVWhOWGVwdlRJSzFWVFlaT2sx?=
 =?utf-8?B?WUVuVXRXQlg3cU5ZMkNObFY1cFJDMllndGIwUnBEQ3hoYmxYSUFWY0RLTkxl?=
 =?utf-8?B?YU1XRGN2eTZjRDRnSXZSTmtuUG9ISmUvZ2RmWlV3TVNHTGluTjRjRlQydFRR?=
 =?utf-8?B?QTh5Mm9PUWZ4NFQwVlkvS3dlTk8zdXpLKzlqZnZ0a2MvSlFRUDNSclMreUZB?=
 =?utf-8?B?MW1mdnNZZ1JXa1RjaURqZm42NlY4MTFlVDZPaklNSDNqTW9ucksyU0xQQ3Vq?=
 =?utf-8?B?V3h4NTVGTkJDb3E2aEVmQVRQei9OTDJxZjQ5YWtSdFVFa3Y0bUxUSnlINkgy?=
 =?utf-8?B?WnRpVDdqeHY5aVlTaWRTL0IzWlIwQzQvK1owcGVxVVdWUG13dEZieHpiS2h4?=
 =?utf-8?B?ditzZU1YbjlpNTFma1E3R2UrbFU4N3Q5MExzSXYyZ0xOOGpaYTdRYmJGVHdn?=
 =?utf-8?B?UDJ2M29ldWxCQlBFb0l2QUlXeTl2YVdGNXpxZjNsK3BVekZaOEtIUDRjTVhm?=
 =?utf-8?B?YURpUWJhQVFzbHVUb1pSN1hmYmZnZDdXSEtlMWxDZk5McmljZUR3b0R1dzZl?=
 =?utf-8?B?R0JvSHV4ZTBWV2ZEYncxV2RoRzR6L0lhZ3NJUzkrZnVrMnNHbnNGbG8vWita?=
 =?utf-8?B?R00zbDhOTDZhTEh5eGJnKytBcE9WdmlyakpiNVNVWXF3cHBqY1ljTEEzbXRH?=
 =?utf-8?B?WFZ6eUNiYitQWEVXUTJ0Z0VZM0dCL2l1MDZqVjhTUzJyb2I1bHQxWnhnUlB0?=
 =?utf-8?B?akQwQ0VWd3ljR25zUEpBSWN2aXp4UmJnc1R4a2NhRDNHVFNhaFhjTEpNOG1O?=
 =?utf-8?B?NGYxbmRIZ1NPMmF3YWhtam5MaDJCb1luckFSSlMzVEJlN3ZrTkwyNnZGcmdX?=
 =?utf-8?B?WmM4cHIyVzl1TEVEZWxOeDU1aTZWNkxqd1RMMmhKZnZ6a2hCTTBxUzhKRjRW?=
 =?utf-8?B?US9JRE5GMjlxWW1OaENkd0xtbUFQaE14QWhCWE5wOUJBdTV0MGgzaTFVb3Jw?=
 =?utf-8?B?QjY2ZStma3JPQjBjb2VFeWNqZnA0MEpXMjJIR1NqYmFMUHpKVSs5c3I5dEMx?=
 =?utf-8?B?aVFsejVOV29BS011OUJVSG1KVkdyemdZK29hV1QxUmIvRGhhbXFKdWhyMlVV?=
 =?utf-8?B?dXg1T21qWG55Y2M4MWVVQ0pPRkVTcFBpV2w4VnNxU1h5eExnc2orN1hYc3BC?=
 =?utf-8?B?RVM2N3NJVHFCaGgzZTduODdWUDBqY3Z5WDROK0RCY2xkUmtoYWlPYmFhcEcw?=
 =?utf-8?B?UVNMa0tWRW9QOXFqRnpJdWRvSmZYMnR2MnRQb0dyd0NoOUIwQWxaL1l4UFFz?=
 =?utf-8?B?eHA5K0hEUEhsQU5Vc3FtRXVGS1dkV1hsZFVGNUpvNmlhS3NEQlNQVE1BbEh3?=
 =?utf-8?B?dnVUR25XRDUvWFFHb3pxYmp0b1A1UzMzcDJoY2RLZ1k1YjRGTUhxMlYvYlB5?=
 =?utf-8?B?aFVlUTN0TEY0MlYzWGhJRXE5bG0vdW1zTDZhQmVrMndOUlJIcEpSYzdFdk5T?=
 =?utf-8?B?VWYreWhPVDNzSE9sRUZ2aDQ0REhJOWhnVmoxdE55b3JXNFhTNzlGNGhaeFBK?=
 =?utf-8?B?bk5KdTFJOHhjUWNGYk0rVXZqVFo4S0hEVkd0TmpJWGpGTDlYZ3FaSVhZTnRL?=
 =?utf-8?B?RHJNNjRFZ0RGYmRmNzlsNFpkV0VrOSsxa3ZXOHlJT3hQbllsVXRBVk5KODVV?=
 =?utf-8?B?aE5VcVgzcm1GcjBKNGVEZjlVVHFUdDd2SW9tK3dLNThrc2J6dnZJZzVRWUVw?=
 =?utf-8?B?aTA0TzZEYk1Ub2RTQUQrUDFjZ2JGaTh1VWh5NUMvNUtPaEFXUjkxR2VWQ1gy?=
 =?utf-8?Q?3jkDZh0hDXm48zOFHmUL5M/N+pyTqqBoPtKwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGE0MHhCMUxwbGRkVmRObXlONnBnQlRuZWh3anE4dnBPTHV0MmdaamVuekpH?=
 =?utf-8?B?OTBGamhjMWQ5MjVVbXBDWmwwL0JYRWVSaGFRTnE0WUlWNnpVOVZNMSs0SGVW?=
 =?utf-8?B?L3JrTUJFWkk5czFzN2RST1J2ODRnMzV4UENLUnpVZzdBN1pqZUQ2K2NuWHNw?=
 =?utf-8?B?dVVvNHh3NUg4R3ErTXV2WHBNTlBoQlNCSVVCN1JVc09IZnprQnJjbTZncFZ4?=
 =?utf-8?B?SmhtRnVvR2p2eEhtcW40eVp0YzlLTlNDOHVUVVVlbU45TlROYUozNFptODRN?=
 =?utf-8?B?N2Q1YSswSXNaNm9QU0JnNkl2RHVRVFBaRjRmUmRxTGQ0elZTZWpGRFhlRGtR?=
 =?utf-8?B?cjVZcnN3MTQ3VGRtRXdBTDVwYmU1bGd1YXN1WjRHYUJFNnRUYjdNRWltaHZH?=
 =?utf-8?B?OTZPc0RVcjNvU3lrQzU2MVgrR1o1MTlpNGNkY2hPd2tiNlR1NFgzbEFmNWFj?=
 =?utf-8?B?UHMrME5DV1I4aDVGSFRUeUtJdW90WEdyTnRheWhtck82UmNzMkJGbVhZRXB1?=
 =?utf-8?B?Rm4yUk5KV1BUYUdrWXlqdjM1a0ZUTnl4bkI0YXRObWFzTExaamtPNVgvTkFt?=
 =?utf-8?B?elpiazJvVHRzTEQ2Y1hXOXNueHRtclpsK1ZKRG9RS3NNZ3JzaVR2SkY5ZmRa?=
 =?utf-8?B?cWUzYjk0VEVMM1pHV2hhYVRWS2Z5RFQzYjNaRW9vU0VpNXVVSDVMbEoxM3pB?=
 =?utf-8?B?MUcveFhrVkZ4TWJjcjlEN3pCeG9HaFhGZHZIMWlMVjVVelhrYmVRZHVhVjZU?=
 =?utf-8?B?d3F5cEJUd0w3ZFVwcDlOa2tiNjd6WTFvYWNRYVFxb080NlVHZDVqSmJCSGVB?=
 =?utf-8?B?dGFFb0haNU1XQjcxcEtxSVhlZzc5UFVqV2pWeTBqK2JpQTBhSkVyclBDbEJa?=
 =?utf-8?B?eU16VVkzN1kveDZBeFlFbXRVTXhwUlJRc3JGcFVhbzZxd3BnRFZNTUNRb2lv?=
 =?utf-8?B?TWdBUHZtaEZVN0hjeG9VSmpCWDMxTTUyazlXakNUWCttUVlwQVZEOEhlZ2tJ?=
 =?utf-8?B?dHpKaWtjUWlRd1FzeDNaRFJYaUJvaTE1d2dKY0ZLZnZkU0JLYmxjd0NLSDhw?=
 =?utf-8?B?R2pVNHgvNWFHNnVzcWZuNkIweDZxaUpUaFhDc0IyTnRhQWVlVUR5SlFQVUdm?=
 =?utf-8?B?ak50ZXAycFJlMjhPRmsrbkxCREpzeFJubWZRTzlxUldPRytpbHJQcnBqZWIr?=
 =?utf-8?B?YmR3V2RyUmF3RC9Lc2tCMFp6MEpHU1N0TzUreWN5OWduelhLRTZVeTJxZ2Iz?=
 =?utf-8?B?b292OE1QL2hLbjV1eVU1WGVZMzhnbFJpT3lRcFFES1F1aGZ2RWZISUszbE8r?=
 =?utf-8?B?R0ZORHgrclM5Q201YUNoRDk5dEE1YlNwU3kzanJSSnB5dlpPb0xwRDFNSFpj?=
 =?utf-8?B?NndRaXhTMTFDcjJ4ZzlhdHM0SkIvcHNjVE5rNjV3Y2lTY3lmbmdiVDFtaldn?=
 =?utf-8?B?dWpEbitBUHVVMm9mNDZwU3gxaXl4MWtFZ1QrR2lMZmpDNVdwZDBMd3poaGo3?=
 =?utf-8?B?RTFDOFJ5WTU5a093TVFYUTVhU0pXbTMxSmk4bkN4TGpIS0xqWHlxak1mLzNU?=
 =?utf-8?B?dktaZmxxT2JSVlNGZFhMK2hNSnI2aTIrbkJRd3IyR1ZObVJZTVBvNmVTWWFI?=
 =?utf-8?B?TEZ3VjNSdnU0Qkk2YVRYU01VTTl5QmM1L21uYXhZTm5rZldvZHFONXpzQWYw?=
 =?utf-8?B?bkdodzEyaDVGczQ5K2NxeEJBeHNZZ09YbFpwYTk5ak5adE5OakxIQ1N2QmtP?=
 =?utf-8?B?UlFDZ2hCODVXR2M3UVBHNHAraVdVQUpaNHBwUmJqdm12em41RHBJT0pwQUhP?=
 =?utf-8?B?UjZnaXNWTFdNNlZIenBkeFRzNDFCQis5QTNSZFQxcEZGelZUM0RwaytUNnM4?=
 =?utf-8?B?YmIwUkxPNnVnTGY3WnNtdFcrZW9yb3d2UFM3RWpwQTJmMlBsTGM1YkFHTnBJ?=
 =?utf-8?B?a0NSUkhvWXpCbnFobjZIelVRa3M4R2RqZjBzd1liK2dyUmhiY0xTc3Byd3hS?=
 =?utf-8?B?eFErelpPeVJNcENpb3hJNTdMS1ZRckZvS2E4YzEwKzkyTGYvaGJEV04zZDE4?=
 =?utf-8?B?ckREOVRHNS9rSnVCK0xPdlNYbWhxbGNhQTN3MEJvTlJ4ZnJxNGkwYlFxNEJI?=
 =?utf-8?Q?uQIu/3mPS+BPlwYQ3ee9uI8bp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e506a6-e0e4-4f2e-d0b9-08dcc195e53c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 04:01:12.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrwgK/S/gIhc3TV4up/XQPUQc+GyKw3yxmANcI9VAzu9KF9BqaMD73xAbylI1DfyMDXI0rJ2jTz2BVsg6Et6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339

On 8/21/24 11:20, Zhang, Rui wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, 2024-08-01 at 09:48 +0800, KobaK wrote:
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of type
>> EFI_CONVENTIONAL_MEMORY,
>> which is not appropriate for runtime services as described in Section
>> 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is a
>> type of runtime
>> service, this causes an exception when the PRM handler is called.
>>
> Too many characters in one line.
> https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
will fix this in the description.
>
>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime
>> service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-
>> wrappers.c:341 __efi_queue_work+0x11c/0x170
>>      Call trace:
>>        __efi_queue_work+0x11c/0x170
>>        efi_call_acpi_prm_handler+0x68/0xd0
>>        acpi_platformrt_space_handler+0x198/0x258
>>        acpi_ev_address_space_dispatch+0x144/0x388
>>        acpi_ex_access_region+0x9c/0x118
>>        acpi_ex_write_serial_bus+0xc4/0x218
>>        acpi_ex_write_data_to_field+0x168/0x218
>>        acpi_ex_store_object_to_node+0x1a8/0x258
>>        acpi_ex_store+0xec/0x330
>>        acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>        acpi_ds_exec_end_op+0x274/0x548
>>        acpi_ps_parse_loop+0x10c/0x6b8
>>        acpi_ps_parse_aml+0x140/0x3b0
>>        acpi_ps_execute_method+0x12c/0x2a0
>>        acpi_ns_evaluate+0x210/0x310
>>        acpi_evaluate_object+0x178/0x358
>>        acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>        proc_reg_write+0xcc/0x150
>>        vfs_write+0xd8/0x380
>>        ksys_write+0x70/0x120
>>        __arm64_sys_write+0x24/0x48
>>        invoke_syscall.constprop.0+0x80/0xf8
>>        do_el0_svc+0x50/0x110
>>        el0_svc+0x48/0x1d0
>>        el0t_64_sync_handler+0x15c/0x178
>>        el0t_64_sync+0x1a8/0x1b0
>>
>> Find a block with specific type to fix this.
>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler.
>> prmt find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>> By using the correct memory types for runtime services,
>> we can ensure that the PRM handler and
>> its context are properly mapped in the virtual address space during
>> runtime,
>> preventing the paging request error.
> some general rules to follow when writing a changelog
> https://docs.kernel.org/process/maintainer-tip.html 4.2.3. Changelog
will decorate this.
>
>> [1]
>> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>>
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler
>> for the PlatformRtMechanism subtype")
>> Signed-off-by: KobaK <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>>   drivers/acpi/prmt.c | 46 ++++++++++++++++++++++++++++++-------------
>> --
>>   1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index c78453c74ef5..e2f0bdd81013 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,17 +72,21 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[]
>> __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)
>> +               if ((md->type == type) &&
>> +                       (md->phys_addr < pa && pa < md->phys_addr +
>> PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md-
>>> phys_addr;
>> +               }
>>          }
>>
>> +       pr_err("PRM: Failed to find a block for pa: %lx type %u\n",
>> pa, type);
>> +
> If it is a pr_err, why not error out?
> or what is the proper handling for such failures?
>
>>          return 0;
>>   }
>>
>> @@ -148,9 +152,12 @@ acpi_parse_prmt(union acpi_subtable_headers
>> *header, const unsigned long end)
>>                  th = &tm->handlers[cur_handler];
>>
>>                  guid_copy(&th->guid, (guid_t *)handler_info-
>>> handler_guid);
>> -               th->handler_addr = (void
>> *)efi_pa_va_lookup(handler_info->handler_address);
>> -               th->static_data_buffer_addr =
>> efi_pa_va_lookup(handler_info->static_data_buffer_address);
>> -               th->acpi_param_buffer_addr =
>> efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>> +               th->handler_addr =
>> +                       (void *)efi_pa_va_lookup(handler_info-
>>> handler_address, EFI_RUNTIME_SERVICES_CODE);
>> +               th->static_data_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>> +               th->acpi_param_buffer_addr =
>> +                       efi_pa_va_lookup(handler_info-
>>> acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>>          } while (++cur_handler < tm->handler_count && (handler_info =
>> get_next_handler(handler_info)));
>>
>>          return 0;
>> @@ -250,8 +257,16 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>
>>                  handler = find_prm_handler(&buffer->handler_guid);
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!handler || !module)
>> -                       goto invalid_guid;
>> +               if (!handler || !module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       goto error;
> I think it is okay to return AE_OK directly, right?
>
> thanks,
> rui

I'm also good for this.
I followed the convention in this block.
If change to "return", i will change all "goto error".
How do you think?

>> +               }
>> +
>> +               if (!handler->handler_addr || !handler-
>>> static_data_buffer_addr ||
>> +                       !handler->acpi_param_buffer_addr) {
>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>> +                       goto error;
>> +               }
>>
>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>                  context.revision = 0x0;
>> @@ -274,8 +289,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_START_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       goto error;
>> +               }
>>
>>                  if (module->updatable)
>>                          module->updatable = false;
>> @@ -286,8 +303,10 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>          case PRM_CMD_END_TRANSACTION:
>>
>>                  module = find_prm_module(&buffer->handler_guid);
>> -               if (!module)
>> -                       goto invalid_guid;
>> +               if (!module) {
>> +                       buffer->prm_status =
>> PRM_HANDLER_GUID_NOT_FOUND;
>> +                       goto error;
>> +               }
>>
>>                  if (module->updatable)
>>                          buffer->prm_status =
>> UPDATE_UNLOCK_WITHOUT_LOCK;
>> @@ -301,10 +320,7 @@ static acpi_status
>> acpi_platformrt_space_handler(u32 function,
>>                  break;
>>          }
>>
>> -       return AE_OK;
>> -
>> -invalid_guid:
>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>> +error:
>>          return AE_OK;
>>   }
>>

