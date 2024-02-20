Return-Path: <linux-acpi+bounces-3732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A72A85C555
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 20:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E68D285D4F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34614A4C0;
	Tue, 20 Feb 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z3pdkwwk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB6D6A8D5;
	Tue, 20 Feb 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459184; cv=fail; b=UVSGlJG0aimitXpBDfo1aVSyO0EXM5CNlhvB8KwHfr91o/w2COaKdFz3n5qsTiRf4BhJxgz5lfRyr2eDc9EXF8opawjVxwgNckWu7FWzoD2LS4peyvRCHwwB/zo0tdaZ6uMW9nq5rvmJ745cG3IyLCuOPgewHBK1LTJSO4jbeIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459184; c=relaxed/simple;
	bh=4EVyCc0e1NpZHcZCl/bMcoo1UfkEQP7kYvLAmNYWr7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q5bl0dZFZbEX3mWkQipXTa8ttUFblSWtnSs5GnKi+rjxyrDs7q3nz6TUEPSXnHInmMZeU+tfjMg9S8hSYIUBl2YEebTPXt5BTI0KF5PerFmvLhJyG96CusNi/iXFrPpTSNMZuj34Tr/w4B8mjHwDLfIA7gy96c9PuA1fgo1+JaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z3pdkwwk; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVZta+OKXAOO45lvfjK0vTDX68vGueDrMyki5xbOxlUzxI/2a1FAbndR2X4Pl4BNmJi5PKwKVkTtU8jGsc3fEiuRj87LRTz2r21sCDIbFWAo/HiHykSMPuLfBHzaxdTlic0Pwj/dz58vqDCFMZsr5K0rkZcEf7f+csNjlJAX6adfMY204SleXEvchYZUKwbwjru8UgXSRFkM19S41SnWliBo+Pmr7FiQbV8dJI/I6yFwi2uajfwLTlncdkosXXtNmmd0jt601Q2NMuPEYI/3MNgtFKOEYl6Fa2C3RRuY/W1TKngenC5CjgYcXzlC4bOOZgS1nSygKy1NHc2JbtBHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncTmK02Km4ONof07aBS/kMxnMQ+20nxWmiVpgCyAM6Q=;
 b=LPszi1W3avjjsGyIr7kYZwf1RYrP/1koylBPhPpXg/SlEAz2WGDGNeStLdAJuic0mq3Aa9+JIjc/e7weRFMhA8ZkWBDXbX5dyDiYkn7YIj6J6kSM5L6vAV1LwZ2EK4OJ1TzD3kMuOMPg0DDZoH945Ec6NgBcuqHfEzBXvVngqYr9WImkw/TjPwfi7aWV0bnBJP6sDcDgVR62yLLsJw2erq5k7wbJd4FQUJcNZCS9sZFm6BkywQi+V1pUJLJbvLMeFEqx+xF7x6zW4TiBTEoM4cHiISU2wgAC8AqRJWFlwiFagfZ9gaNO8beEGUCL3yxUA2oqqLZS1wZQqcAuOCPi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncTmK02Km4ONof07aBS/kMxnMQ+20nxWmiVpgCyAM6Q=;
 b=Z3pdkwwkkt/p9VcNkv9Dl5S2BRcVUCJ+wlKD6NH6F2eHA8QUSjJqXtmeQ58ZuMMiE7WVDUkz548/I6HK01i/aHD8d/n5VxEbfBEVDyU5hexfxvuXFOAEFVxvxDA/5Sjd5NAi3HazwJejIRerKFNpn2E6IjfoksJip/aEU8wR/7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Tue, 20 Feb
 2024 19:59:39 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::d493:7200:e0ae:1458%7]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 19:59:39 +0000
Message-ID: <d2847bc6-dea7-4eb0-a7b9-cddd1f11d222@amd.com>
Date: Tue, 20 Feb 2024 13:59:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/3] EINJ, Documentation: Update EINJ kernel doc
Content-Language: en-US
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com, rafael@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, dave@stogolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-4-Benjamin.Cheatham@amd.com>
 <l6mrrp7pvnl5arrluiqyekpejzlqftdjqt7b5c6sje7yziqnl6@s2mseu64lx4j>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <l6mrrp7pvnl5arrluiqyekpejzlqftdjqt7b5c6sje7yziqnl6@s2mseu64lx4j>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0334.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::9) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fa9f33-551c-4975-a6b2-08dc324e78ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WrL1LHbIrj4isceKzQl+hFK6XydBZPpVAupr1toIal9JfyN1esErCAvYbReEA3AxsF5a1V/qV32m7qjrToMfzaBCKpm+YZNbPHt/DZQA+Zcz+bCiMDlwSx8GyFBjWuHgfZtJe/oy8NQ+vlWqRFMaJnIDwuBjK83qVlwd0/1eZn0HfRNL0Cg7V6W7h7OfBNgjyNcbkQb4hBMIxyB9t5Dk5+R6Hn9XFve8/Ub8+A9iGp81izf579RV1Y150PCOBSMMrjVV0ie5f/kjn1mwLv1gczyutql9rOHgXbeWSZbUztxl/EsLuozPMXugKYqUvzPHUP+TJtRmbAy0Ow8UmUhEBO8/484jHEkH6Z8ByY87JZbn3b1/DtGRMDlqWW1TN4ljTdWl/tT2jn1HvQ4sbxrrQUKU5ydPM3Ej/QeeblocfCYEzjGPgrcIrgdVMJ3nZajtH/Osv9ej74yFOj8KroaZzgp3443xOV1rwG36+PHBdknKMM/8T4tcyUsRAgFJDnhUY1U33vyfRaPvclB/wsdh9qQrcFqdXdll/NvyDUdOenA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3FiK0YrWlNjMU5DbVc1Vko1dklZMVR4K3piamlFaEZ2VDg1c2U3dS9ZSFFz?=
 =?utf-8?B?ZFNPL2kxUnlhSXBlZEMyaDNEWnBBa1dyN3h4MWdxRnpnYStPZXY5b2tGRHRZ?=
 =?utf-8?B?d0hJdUduNUEzUzI0VG5SQ2RnTFgvdFVoNzFrY1BMMzk5K3FHZ0l0c2JPd0Ur?=
 =?utf-8?B?a0RNUDFzZ1Z6ZUwwdmhxcHlwRURNZjNTcGVHRk1FSDhPNUloYlVoV0FuVnQ2?=
 =?utf-8?B?VDJmenBubHBLTFdEZ3FuenlYNThrczFuUTBHNEQ3OUpZZzhDcWdpS3pZZC95?=
 =?utf-8?B?REQ3UWtLeWNtS2VJQmt4am5vS2Jyd0RydUU1VjFxYVdwWXo0eVUyQkozU2Ev?=
 =?utf-8?B?VUtMK3hHa09SYk9VVTg5MVcwY3pHaVRIRVcyb3NLazFpUWNJWW41UXVxbTdl?=
 =?utf-8?B?NncvT2lHbU9tNVZBTlRHclh6NzNXbXJQSnlSY0F4Y3Nwd1BzVVRRN3B5QlNs?=
 =?utf-8?B?WGlIYXd5OHlTa3JUb0FKVDlRRlZ6ZjVpSmlydWRSRklDeW5WdEFYTE5BczU0?=
 =?utf-8?B?VTIrZVRreDNDeWd3cUNrSmwrSlUrMTNhTFNvU29wczlabklPS3cvTTN0TG1m?=
 =?utf-8?B?M0JlQlBPaTRxemdGci8waVVrUnMrUWc2NDJtZkhUOWE0elcrckJ0R0JTZFMz?=
 =?utf-8?B?M2lURkNvUlQ2N2hTZE9zMkptcDZFdjdESTY1d1M4eWRLUmh3c3B6UWI4NC9O?=
 =?utf-8?B?eExMbjRrdE9QNU0zVUdxaExBbmdOV1hmYnlJMSthc3ZTOHBkYVVJYW1WWVNW?=
 =?utf-8?B?Z2ZWMHpyY213bGhRRWFpdVhLVHFEUDJBeE5OVmxkV1MrbkQzZHpNbS8zK3h1?=
 =?utf-8?B?blZUby9GTkgzNXVwQUpTeUI3OTZxUmNpTVF5eHhhTE1kVG43UE5WMXVIbXJT?=
 =?utf-8?B?YWtjYWVYQVNZT2RuQzh3b3F1YklRQmZnaVZNTmlZZ0Npa3NJM0JvT1RCbmt4?=
 =?utf-8?B?QVBzZnNCWC9oNTNaY2JjVDkzNkRhT0piOU5LUXFkZjF4K2FkeWZJWmxGYzdZ?=
 =?utf-8?B?MXJIcCtSVE1SeEpLaHJ6WkRnQXB3RkxCejVmSEpVa0I1VWVhTlF6R3FGdUgr?=
 =?utf-8?B?NTd6V3pWUUpkL1l5ZllyaWJDNkxObVFEWmJvVkJsTVd1TFJNK0kreG14bWpS?=
 =?utf-8?B?ckN1UXAycERYVGZQNEhGaFFONnV2ZDlMQVVwNVN4ZjdRQTBCVXdFbUtzZDE4?=
 =?utf-8?B?ZGJOd0luSDZrN20xenNXdEhiSUc2Ryt5MXNKS2wyaDRWUkREN3cxZHBhcnRq?=
 =?utf-8?B?R3JIY3ZpdGJtalcxZ3JIK1VyZEdXeVp2TG5ZRDBmK2pZMHFWZWNGeFVOTXpl?=
 =?utf-8?B?d01JSXFpbjB2aGNEMTNERkZnTW9GMFA5UU44RTBGTjJuZXdkY3dXZzRMMFFk?=
 =?utf-8?B?Sm9YQVNTK0RLTU5qbW5EN1pTbENSelVITXJQNHlEUG40TkYrMDlUVVBZaWxM?=
 =?utf-8?B?Z002anUxMjdTTVpDZVdHQjdjNXN2NWg0Q1NYa0paWXNvOCt2SjNncy9lTC9V?=
 =?utf-8?B?S1ZrbjJKUHkvdGFHWXZkR3pYa2x1c00wMEhBclVxRmlEVmFFbnU2WGZTbjRk?=
 =?utf-8?B?L0xYYUlzZzhQMUhyQ3lXWUtJV0RpMFBvM1RicVUwZTZieUJzT2ZqRlBmZngw?=
 =?utf-8?B?cDJiei9XeW54MU5JMlFKTEU2NTVPeEJXRk9jejNJeVI3MDB5UGJoaUZySU1l?=
 =?utf-8?B?UU44YVc0T0tCVzBubEJPS2dDQnhHWGZFUDVGTk52ekVqWDY3VnY1cHdGdWF5?=
 =?utf-8?B?ZVl0cmZzbmdONG0rQjJsNmg1clFGcnlXSFN2a2VlVEQwQkhCMWZCei9hbnhD?=
 =?utf-8?B?QmRqM2gxSUJ0d0R2M3dvSytKdEpQdDlCSCtNUnUyOHRVSjBJb2s1THFaK3F0?=
 =?utf-8?B?OHptZ1pzT3FOTTN0TStmWlFudDM1cnczd1FXWS9WV3ZGOVIrVi9tazNsS3NZ?=
 =?utf-8?B?b3FlZEExa3FqYk8xSU1sUll6Mi9tZHNzZmg3ajU4K1NxSkdCbUJWWUE3UFAw?=
 =?utf-8?B?cmY2ZWd0VmpQeUdraGdaOFIvc1UvaWR2bFQ0N0NWRURNWlU5Q2VrN2RpVWtZ?=
 =?utf-8?B?dU9UbUxjUWw4RzY5RGdqQTdYcitCUTBCSnJKazNPSTA2UzRlQ0NlS3owZFl6?=
 =?utf-8?Q?CNriJvp18mW/mp3HIWrUz69+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fa9f33-551c-4975-a6b2-08dc324e78ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:59:39.5445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCYHfXw9seWfzBkwJthuO17P62eHSBgt/R0THhZ6PoloOhYzgNPqXBwUo48ErvQq/FQ8o9bACUkUgLrQ4djcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

Thanks for taking a look David!

On 2/20/24 1:02 PM, Davidlohr Bueso wrote:
> On Wed, 14 Feb 2024, Ben Cheatham wrote:
> 
>> Update EINJ kernel document to include how to inject CXL protocol error
>> types, build the kernel to include CXL error types, and give an example
>> injection.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Would vote for folding into 2/3, but otherwise looks good with a minor
> suggestion.
> 

I would, but I think 2/3 is already pretty large and this is more digestible to me. I've also reworked a large portion of
that patch for v13 so it's probably better to keep it smaller.

> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 
>> ---
>> .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
>> index d6b61d22f525..f179adf7b61c 100644
>> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
>> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
>> @@ -181,6 +181,25 @@ You should see something like this in dmesg::
>>   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>>   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>>
>> +CXL error types are supported from ACPI 6.5 onwards. These error types
>                              ^ and target a CXL Port
> 

Will add.

Thanks,
Ben

>> +are not available in the legacy interface at /sys/kernel/debug/apei/einj,
>> +and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
>> +called "einj_type" that is analogous to available_error_type under debug/cxl.
>> +There is also a "einj_inject" file in each $dport_dev directory under debug/cxl
>> +that will inject a given error into the dport represented by $dport_dev.
>> +For example, to inject a CXL.mem protocol correctable error into
>> +$dport_dev=pci0000:0c::
>> +
>> +    # cd /sys/kernel/debug/cxl/
>> +    # cat einj_type                 # See which error can be injected
>> +    0x00008000  CXL.mem Protocol Correctable
>> +    0x00010000  CXL.mem Protocol Uncorrectable non-fatal
>> +    0x00020000  CXL.mem Protocol Uncorrectable fatal
>> +    # cd 0000:e0:01.1               # Navigate to dport to inject into
>> +    # echo 0x8000 > einj_inject     # Inject error
>> +
>> +To use CXL error types, ``CONFIG_CXL_EINJ`` will need to be enabled.
>> +
>> Special notes for injection into SGX enclaves:
>>
>> There may be a separate BIOS setup option to enable SGX injection.
>> -- 
>> 2.34.1
>>

