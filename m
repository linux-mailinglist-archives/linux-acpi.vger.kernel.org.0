Return-Path: <linux-acpi+bounces-3476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7030854B7B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0202841F4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95A958211;
	Wed, 14 Feb 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EcmqPMnw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC25A107;
	Wed, 14 Feb 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921273; cv=fail; b=dafIFnI29hLqKFUI0otJO9YaQnPxjCkZjhkf9qAOBLdZnF3ZGudbcOdeLu16kze9f1YSTmKagpi8w1OsXY/W5EedQxFb+JZbBI+N+cLQD+eJBUoQKFR2XM1n5KjRMUJuug+JReZCsJw/sH6/3dXDCBQyfUHkPrD3TfK1CM7qY3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921273; c=relaxed/simple;
	bh=bRxhiip1+NQPcCJ/wUuXHDLmFVpdUSfQrcZIYWKBWIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NJdsiDlG9Hhbq43cB09g/xjGHmR1PxUh5aHFnbfltJt3sWSpnWnakFu2agfFsnd26FWL4x+wrAWPJpB+W7o9i18MrEHJwC5w+nM9TDD1Cf86KZomSmduE0MVgFGPPmbCys/uWJ1iuQ/wHWVjda/YdMdH1+nVqTRbInuc2yIc2HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EcmqPMnw; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ9V8Jfdd6R9XxPrGUDJ692m1XyNbSa2CTJJKfFsX5qybTVzMP2IWPncG5u3FK/jbquDpDxGeR/NL/31lgD95ypbkZkmLcRPxiq+x9zW0UIYR5tcu9itJyrgye7Ht4f+WfByguEfdCgTub0e4POb9gnLmVH5yfLloAqT5H9oOJ5iD/4z4Nb/Dy7PGAbtUl925C2uoMMQJr2gJ/mvG8TPzuX53Doe9JwMspqJPtvWkK+L+Ud90ljNgbSqvsso2fTSP105pw1qoRJaj5+KImURAoyctX8Kc3In6a3w9nF9cO84vDHQuZlbQiDdlDbWR656hE6/JIBb8x1RGs2r15QgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyKo4DUpHgcpmMX7uTLzVGmquX1s0x+exi3uije/HkQ=;
 b=ip0iBx0+gz4T1pklNzcBLrGK5fSjv7e4qI27Z0GcM2v2FLJUN7pRxolEijGkjb1VzXVHvMs/ULdYHwmnaNz7WvPEfNE2R69Se7IzBPUL6/sbi+TF6ooWfOMYWNchREO5u5tGZ+SfXg7ovcForwlRKKTrobMMbFeauwM3lnDSk2Ch6NYXJb34flqYJ1Edhy4HTyTLkxE81dpMuHAXOLg8c/6V/qgoY4Lg5Un/lOqjhidQCtEyQ60pGkH7I3dZvE8UiFFf8VvZNT2WtAxRf8P3BehPkpwBfp4B6JqRMTUIcpyp4VdVlBtZOqxP6ZzHZ9LQOxdksgM7sSBKSzcGQD4r8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyKo4DUpHgcpmMX7uTLzVGmquX1s0x+exi3uije/HkQ=;
 b=EcmqPMnwDd1KWCYaVB2/GxzD2jYg7830zTb0iyYf5nUBIXgeVCEuQWro32LKp6NCxNcw3oOpOPh8FFzYSAGyN8iiWL5P78VePBMeCPekrllAygLPzVjvrFLLz71l3SKmotHoGmYnZCQDF0G+xQwwE3VcNs0+8RhTRagIrQWcous=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 14:34:29 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Wed, 14 Feb 2024
 14:34:29 +0000
Message-ID: <a5dcb306-54cd-438b-b1c5-4f1d80364893@amd.com>
Date: Wed, 14 Feb 2024 08:34:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig
 option
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-2-Benjamin.Cheatham@amd.com>
 <20240214140557.000037b8@Huawei.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240214140557.000037b8@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b64fff5-35ad-4c1a-0967-08dc2d6a0d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	85QwUmXeNhlSleoRTtwpwAJjCZso18xEmgUyPlOnkFFE7MVTeNka0IAVauouHfyYLtRLTrryQaptHRLqcBmEwcEp15Lc3kzd8xtgrEPae+0lKGque9LaZ+ySwiGWTjXZKx9Qte6GIMQ94edPu/sNB0o9jfZvCqLsDsUv050hfcGWN6hPP1UuqbVrdDiHcQb+TlGAQQbJDtJi2RkSjmONJ95gwTk2n68zZFXiQ1OV0Lx66YYfowRESfqKbNaNdzGl1a2lTtE/WFoEN4etVAsqOcxHfPW+eK3IGeRO2ekpUZztLFRdKPuA1aP71PcucNzA97hVmCf2etIGPIJSV4Fj+60y6oHQdtks3PjtqLQgMEDv/dvJAq85P7y4Zi4kQK5febnvL0bqHpdNxRtWKDv0YhI4B8ZTd7cZR8aVo6WE2Q/Ef0JeW4DsRVyhIqoCf4Xs93B9MIAjCDc9wASqQRxCgxPtcNBmqZpaDSaIgbIJSFeOxu00AAnFXij0dDzLEmFioUmS3+N3PzOqvyjgQAO6v9JYXOzWTV0X4OvOSkzjNstoz3UG2ySYIAaHqq/cn/DC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(7416002)(31686004)(2906002)(478600001)(53546011)(6486002)(4326008)(6506007)(66556008)(6512007)(6916009)(8676002)(8936002)(5660300002)(26005)(66946007)(66476007)(36756003)(41300700001)(2616005)(83380400001)(31696002)(38100700002)(6666004)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVowcS9abnNRd0JuVFFONUo0WDJtQ1RablpqbmEvdW5GdU5ROUFML0NCb2pE?=
 =?utf-8?B?SytYeE5JM0xXTW5qS1gwL3pwL1FoVnNYZUxTN0NIVDc1b2N6MXBSYzk0eDd5?=
 =?utf-8?B?V1U2ZXBmQTJ6R0Q0SU1TajhPMkJPRW80ektodlFFQmJuZkphWjNVTnFpMFl4?=
 =?utf-8?B?MXFZT0VLRmlWcmRNbjFEalg2WkhiVHpoaHkwcnVXek1PMFBvZnYxMU1pV1Ix?=
 =?utf-8?B?U0xJb1ZqK1JSNGhKWkdzYjMxNk9mS0ZIQktNMWNoWWtZSFpIQU1PWVJsaUky?=
 =?utf-8?B?NFpmVlJzeGQxMVZ6SDBhQVJPZW1TTUZXaEZiUXlSRDRnZ1h6TmpXa1VrRTlO?=
 =?utf-8?B?WGxDNFJ2b0xjN0Z6OGVNdzRGbmoxYUoxaUVIMW4yQzVTU1hPQStNcjU5TXpv?=
 =?utf-8?B?TEVFaURlWEJVUmRCRHE4L1h5WmpmTDdMQ3BDLzBBMXVkYm1HWG1RWEIrejND?=
 =?utf-8?B?SGQ0TFhTTUFxek4xSytva2hxQ3ZqOE5FSjJYUldpeHR2MTE5YnRzZk9Ia1RB?=
 =?utf-8?B?QnlrbGNYYjFkUzhiSzNiWnJmclk2Y0R3T0U2Z05vbGtyTWsyZm5oQjI3T1pq?=
 =?utf-8?B?V0ZPaXhUM241ZlNTNXhyeE9Tb0ZuSS9aQ3JwNG9ES1NGUUFqdzlLN25waEZK?=
 =?utf-8?B?MG9URmFxeGdTbmVNanZRVEV5R1lTSnhYV08yZncvOFhBbTIyQ1hTWXZ1c0M5?=
 =?utf-8?B?MmV1eFBKTkcrTzRUYm5CLzVCRnRHZnpPajBGSXhrS04vV3g4RCtxdVRHQkI5?=
 =?utf-8?B?b0NwUFQ4VWZ5ZVBmYWk1VitZbGIvVkpnY0F3SEFLa0dyOFp5T0ZhQ20ydFha?=
 =?utf-8?B?RFBIRWwreWwvdkpsYStPNk96WkdON0lLM3g1aThqZXRTTkxDS0pNenNpbHRz?=
 =?utf-8?B?aU9INlEzZUoxL3BneXA5VnRiUldvNXljekcrekJ2a29CaUtPRExsbzR6Umxx?=
 =?utf-8?B?Wjl6c3NCUGhLVlZkTFJ0ZjFhNGNBWjhDVzh5TkZGdjViV0IyZEZDVVJIVHpy?=
 =?utf-8?B?TDlxQzFjbitjcjBmQWNPM0xETTlhbzdmY2ZBamJqUFExakliZkpOVFBZSi96?=
 =?utf-8?B?VDNUNUxoa0NvKzZYRHUranZyK0o3b1ErUTBFT29vRU9ySFozWU5QVWcraUZT?=
 =?utf-8?B?L2FYS2RXaTVKZWY0MmsrQ0dENVdFTlk5WE8rR2hNZWh0VVlQQ3N0M1c3aUtT?=
 =?utf-8?B?L21DSjNHc1JLWVdVeUJ3cFB1dHZCYnZBZmRQRW5sckU0d2xOaXZ5eDFrV3Bs?=
 =?utf-8?B?UzZScS91bWltUFhiUFZSTHM0UFFMa2FBeEpaWTZhVjlrY2dRNmVaUUZTRXVQ?=
 =?utf-8?B?enRqQXQ1ZFFUU0paSVMzY2NtdnJna2ZJQ2gxb2pzajQzc1VpZE9oN3BWWHlv?=
 =?utf-8?B?ZHN4OE1zcDZTU29VdVZEdWp5NGgxT1BpN2JKVFlSaXpkOVRjeG4yWFhJMmJP?=
 =?utf-8?B?U2hrWlNNckJUV3hkSVNHamNDU1hTOWtidXNwS0Y0U0g0ejk2R0tVbTg2ZFpw?=
 =?utf-8?B?d1lOTlgzb3FHWE1xSEF1RUpRSmdYZ0pLdHo3UG9Yb1RCNXF6dnZ4eFRlMTNP?=
 =?utf-8?B?b0hhc1pJcG1CQU4yTE1uYWs5cU1iNGpneXJjRzNhVmZVdU9WM1U0b2k2TnMy?=
 =?utf-8?B?bjl5WTJUSTcreW1aemVvRzNXR1NRb09MdDdtNHlUQVhpR1dWV0Rva21sekdL?=
 =?utf-8?B?d2M5RVBBVWtXR2dpeU1jYVFsMzJCZmJwU0FQZFh3alYzVWpQdU50dVJzT2Fo?=
 =?utf-8?B?MmJGNTF0eCt1eGV4a2xaZmZPR05raHFPUlNtMEVaNmNlOHZtT0lzUU1tTGd5?=
 =?utf-8?B?NHFTNytSOVpQMEFYejJRZU1iNGphREJUVC83TitXY2diNUNTdGhOM1JsNHdO?=
 =?utf-8?B?M1dzM0lYWDFvZzZIem1XLzZSYTNZR2RteHBNUHcwNmVGK1IraDJiUU9HKzNk?=
 =?utf-8?B?ZnA0MTJkR0hUT2t5UnVDcmQxYVpqK0ZsZ2dTTW1yRU9VU2xHZDVPTVN2QnJ2?=
 =?utf-8?B?Sm5BRzN0QjJyOWNBMHhQcGNTVmI3L3NPWmErbkVyMEVKOEhtNHJXMWtpZmlR?=
 =?utf-8?B?TXROSFJncTQwQ3NXTGN6NzJYQ1c1RDg2NWF4bitTa2IzY0RwNWU4ZUFsZmVl?=
 =?utf-8?Q?2AxuLxky35WATpyLZqymix6ly?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b64fff5-35ad-4c1a-0967-08dc2d6a0d25
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:34:29.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/zDGfd1+8hlEW4H/86nSC07RdwTZP94wEwIQFwQhq1rpcER7Fzo7CaKz6ODWIJhAJV0/kGK25sYOJGg3ew30A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496



On 2/14/24 8:05 AM, Jonathan Cameron wrote:
> On Thu, 8 Feb 2024 14:00:39 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
>> core module to access helpers inside the EINJ module, while also giving
>> users the option of disabling CXL EINJ error types at build time.
>>
>> Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.
>>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Hi Ben,
> 
> I'm not a particular fan of Kconfig only patches, so would personally
> have squashed this with patch 3 (or wherever it gets used)
> 
> That would also have had the side effect of making it clear this
> doesn't actually get used (you and Dan have been discussing how
> it should be).
> 
> Jonathan
> 

I agree, I'll fold this in to patch 3.

Thanks,
Ben

> 
>> ---
>>  drivers/cxl/Kconfig | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 67998dbd1d46..95f215a2e5dc 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -157,4 +157,16 @@ config CXL_PMU
>>  	  monitoring units and provide standard perf based interfaces.
>>  
>>  	  If unsure say 'm'.
>> +
>> +config CXL_EINJ
>> +	bool "CXL Error INJection Support"
>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ >= CXL_BUS
>> +	help
>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>> +	  Availability and which errors are supported is dependent on
>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>> +	  EINJ documentation for more information.
>> +
>> +	  If unsure say 'n'
>>  endif
> 

