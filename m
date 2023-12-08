Return-Path: <linux-acpi+bounces-2251-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EC80AFA4
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 23:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F47CB20BB7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2753659B64;
	Fri,  8 Dec 2023 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tXrm6M7U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00071718;
	Fri,  8 Dec 2023 14:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSBMWwV1cPaM9JnB0eydI69Xkh/dRAV+yzvoCSp5Xu2HRh65eNSfEzRRIwVV2NrMBt73i+cKuB6uE64kbJMmHxQE9MlEBgL/8mYzrHhH9QUTrBzSdtcvmtsdWQXSpim54SbpOSjGj64/r0HkNmbUALA9o4uGrD9T70mohC+LCfTVF0JzjwQxc+WxpYh9sMpxKFIi2nxPqXgw4vg64bE4MSTJcrgddEyaezl1bzLYBOVhAv5oENG9uDCoHV3l3wz2oSgBHDIpNKQL8JnrM7GyezYFj+G2/SWNl/NFT/Gbyy+w5GwwQ6Qgf5NqjHq8+dh8hsJyWJPr7TX6yNE2RdKkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR5IBX39onhAK1qV0h+JUg+wi9mriCO4GHDCiQUvjak=;
 b=dvsulBQOMTtFTiTg3OqJyEUdqLKQXEcb2qzdUpyIdYbfnnL2zbPUHMIkVniMV136uREXsfXm1RibW9OiUxobp5nqWXKW6PuStVmloRtQwbfiy+pj0uXTQvHtq/x270sMPhX2dKR8bSWkGC4qb04bV+qlvDVJ54jGO+FoRoj4oRF85UldLXN46sc4VE++/DWuYc6gYKNvR/Nj1a1NKeSICXbEQjrrxXfzj1w7fia1vawWscjg2tWgg/rTvLAmxMiz9uCF4tMX650MafRXDZ6pw0w0nDXXzdmTahNVxLzImOOmPMXHppmiSKP/O4irb6VuBFSfmtNtcX49NUQjsROYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR5IBX39onhAK1qV0h+JUg+wi9mriCO4GHDCiQUvjak=;
 b=tXrm6M7UX5HhJVv3IkImIEq6m7qHEyc1GuG2nt1lz2okNVtbiZz/7HXvWtRPFFiIHSovcmtJtGMv2QQydjvELpydEj39MEnGdN8QLe98IUKtz0DvwmwOwQd7s4kYjdbnXHRQB9e/2tarNFSTJaggDKLwri42pd2k2Zcdmo2KUao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 22:27:40 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:27:40 +0000
Message-ID: <d40c1ab0-6edf-4c1a-a7d3-d28504ccf7f4@amd.com>
Date: Fri, 8 Dec 2023 16:27:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
 <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
 <359bacbf-94d9-47b8-915f-dbf321cf0a9e@amd.com>
 <65735a0e595e_269bd2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <4b239b40-7a40-4261-8472-1bda0cbb5fa9@amd.com>
In-Reply-To: <4b239b40-7a40-4261-8472-1bda0cbb5fa9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: a4119321-ee83-4587-26e1-08dbf83ce2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jgWI0nUk4X7PwMDCUXB87J7vpnb854gzqbyqcid8J5ePf9PDWIF45HpolL4+cwPLj0kpxKJgxNkAeImGXBg4lReqiE1AUIFBMTUuHZSdU02jN9hIFNG1+EFpK1fUxrIS6MduAHKb0z/BM1uZKZPPNPEGIyE9Kw9qniakYGm+uzAbWkZf3Ug7+i17W5ptuks2UKdrbDUR/W9t3Kw2ND3rA4nPCaQwduK8BZD2rrlrX15c7j332shHMxhzWQ+mHY/UI92WMvXgzveXtipom2rMsPoEo4194Y07tXzSXWUV42aM3ySmt/eobmtJVQrQqXLcHnBhWQYSkjIwbJaaaXXiUPebRJr4xDXcs7tXfbE2N0bhc1WALTnTfR5XSLxvzvhmAPEWZCYH8xwvd01iQlgrNnvnQBGpDF4pQVVv7OoAEvD+RSnZ7GF8LOj1QIwnUjzJdFRelUgUjIbSFYLKFDBtWTgfR/EXRtiso6LY4tCUZ4vvtyvPIu5GviQyySJsefPD8WyU2daxPwWhg5EwU8w7dEI93Z+mb5i8Ae+V8vxYonBRcD1+uxR5GUDVeISRh8uuEATTfSZcP/mOVUFzv3gooIV+aIn0cTkMFpuIorfdHDMvsSWK1AlO92OtwV3fYXxTFqYswkEj3KyDMieLJoOEUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2616005)(6506007)(6512007)(26005)(6666004)(83380400001)(41300700001)(5660300002)(8936002)(8676002)(4326008)(966005)(53546011)(478600001)(6486002)(66476007)(66946007)(316002)(2906002)(66556008)(7416002)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJZR2UrMXU4NytueDVIMUd3QjBvZnQwUXo4dks4K0oyYzQ0cHc2cUJtcE1G?=
 =?utf-8?B?WDB1bnhjczB1bDZ2Syt4VklLbmk3VlNNcUh0d2U2RklZU3JOa01rZ1FhV3B6?=
 =?utf-8?B?QjlIYnVmcVhmRTJvVWx1RTQ4Y0pqTWxOZHdTUUg2RUc0QjJuaVFHRXU5eXFP?=
 =?utf-8?B?ajhGU3FibUNPSnkvcUNleUN5Z1czWFBwQnJXdUY2L0I1QTZxUEY0ZnUwaC9R?=
 =?utf-8?B?T1U3S1BUSnRTdkxPRFBRUG9sYnNoaUZHVi85Zk93eFRsdjFpVGR2dU1STDF4?=
 =?utf-8?B?NGRXSXVIYjh0NDFuYzdLYnROWU5VcmhMblI3T09JSHZDaHZLZUlWNzdOYnpI?=
 =?utf-8?B?QzJubVdTa3haTW1jc1A0ZVBlYjJDU1lwUk45WVFESE5QNnJlMkMxeG5YRnAz?=
 =?utf-8?B?NDk0Z2dZbXl4Vm9mdkJZQ3hhb1cxdjNhdG1VOHczMGhCSEl1OUJQYzlFVFVI?=
 =?utf-8?B?WURBWnpkWWFLNHAxZkJWT1FZampqVmg3L0FwQkM5OWJhcVdjMkxiRVdoL2sw?=
 =?utf-8?B?ejJBbHVKTGwzTHo0VXAzc0tiNWdna3c0REg2TXFacHlrOVBxWWh6U0xNQnhk?=
 =?utf-8?B?UThZcTl5TSt5bFhCb0liVGhKaC9jN3ZXbWVRQi9qZWxhZjhGUDVLb0FiZXI2?=
 =?utf-8?B?WlMvN0lZVHgrazMzNUlnMmRZNUN3UmpBcmpHQzF1V2wvSG1icnlNTzFmaGhH?=
 =?utf-8?B?NWdBcGJERnJHOHNHeFoydXNiVXRxV1VORW5EWHpIcVlHLzB3akJsU2pvS3Zu?=
 =?utf-8?B?UGxLNVFpRUJmUWZoWm5TVlQ2NDhrTUpRNFU1cS9tbFV1ZGpuVTR2WnY3R2lo?=
 =?utf-8?B?VGtFME12eHBWQ3duUDVZWWtRMzhiVFd5K1g5NFVMcEQvL0dmRUUwd0YvenVm?=
 =?utf-8?B?Q1p4a3dCd0paMWs3OFVtM21sNGxnQUhZR1JOWDVPZVc5MnBHak4yMzRiTTVh?=
 =?utf-8?B?ODNHemFFb0lyRmJONURmSVNVd2huZzNERzZ4bkdkTWxLTFJabk0raGkrdDB3?=
 =?utf-8?B?OEpBeDFJTyszb0QyR2dDWjVIMTNiamtKRytwWEhwU25Neml2VUZkM1ppdG4x?=
 =?utf-8?B?Q2ZFM3I1NnZxSnZIZTlCMVo2Wi9zV3VZTlBQUllsWVNOUDJtQ1MyYW9sNnh2?=
 =?utf-8?B?MXU1S3IvRVBCTlpyOGY0MXpqQUVnWEw0YStteUpFMC9iQTA0WHRSOVVneUND?=
 =?utf-8?B?WFNCSFVUQmhkSnk4R2JjOFk2S3lHMUVtSVoxdDZ4VkpMZ25uZVpmSFpYYm9D?=
 =?utf-8?B?dFN5UnA2dWNGV2I3SEtGQ2duOXFINmUrQ3Bvb1ErV2NKdTY2L2FBaC84VzVR?=
 =?utf-8?B?NHhHMzJwV1h1RVZVK3pKd1pKQjlmcDg0bTVTWTB3Y1lRZzJPSmd4bmN0ekh3?=
 =?utf-8?B?cE1ucDJhNjM5cG1SOUpxeDhEOGoyM2FJV0gzNDA1Q0ZLbkY5Q1NYVHhsMDRI?=
 =?utf-8?B?bzVxQ3Y3alpLeHlSejV1b0Z2WkhKY2VzWDNjM3E0QklzVjF6WVAxU0FRS2Fm?=
 =?utf-8?B?eWFTMHNqbVR3MjRQVjJJemVwUUlJQjRvVUtjNXNOUE5RNzU3UWNhWU1DM1BC?=
 =?utf-8?B?aWluK1ZQOXVubEpNZmFqTklrNXB0aW4zdGt2ZUZRSFEzS2dCa2N3cmtPcmVy?=
 =?utf-8?B?bzhGR09TVEwyNkJRb3ZxcnJkUVlUR25PK2FCbWVDL2ZWa2tnejU4Yks1a3hD?=
 =?utf-8?B?WGV1eFUvUldZdTk1WFBUYTR1eUI1RytDbVJ0dEl1OGFTSzNGUnhCcTBFanpw?=
 =?utf-8?B?Y1pnNmE0MXJONTlFUGVUMzdENHdQUkl0MmthWndudmFuWkFiOG4zbFVJcGNm?=
 =?utf-8?B?dHlwZlorOExCN292S3N4c1ZSOFRkUVE2clROOU5VeTdJeGFvdVVZNGFoZGFE?=
 =?utf-8?B?RFpuMVRha0h0Vk91RFFkRkVEVkFTS0pVdnNmY2ZBSzlNSFA0bTcvOGJKWmFn?=
 =?utf-8?B?YUlFdXhKdWN0TFp4ME5PSDA5Sjl0SmpHQkVLZS9KeGwvbUw2TVR6UUZjOXdU?=
 =?utf-8?B?RTdwWHNlK3luWGh4ODNCU29UZitKVVIzOHV5OHRWTi9sWVRYbHhZVStSUnNE?=
 =?utf-8?B?WGdZQ3l0WTVDbjM0eGpjT3N4MGVCZEtXSUt6WW1PaXFDZ2ZrN2JXQ2EyTGdo?=
 =?utf-8?Q?18M8d7kvyZt9ZwmRuwo+cPx1c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4119321-ee83-4587-26e1-08dbf83ce2b2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:27:39.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCqWOVqOIQpwUHuzbLNMyn86iT3AqVM/uax2q/RNdAAuyidPlDsPtPafNl2WQijb/qdtwLickwMO97kMcKCgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904



On 12/8/23 2:35 PM, Ben Cheatham wrote:
> 
> 
> On 12/8/23 12:01 PM, Dan Williams wrote:
>> Ben Cheatham wrote:
>> [..]
>>>> This can be simplified. Have something like:
>>>>
>>>> config CXL_EINJ
>>>> 	default CXL_BUS
>>>> 	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
>>>> 	...
>>>>
>>>> Then the documentation moves to Kconfig for how to enable this and the
>>>> CXL code can directly call into the EINJ module without worry.
>>>>
>>>> It would of course need stubs like these in a shared header:
>>>>
>>>> #ifdef CONFIG_CXL_EINJ
>>>> int cxl_einj_available_error_type(struct seq_file *m, void *v);
>>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
>>>> #else
>>>> static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
>>>> {
>>>> 	return -ENXIO;
>>>> }
>>>>
>>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
>>>> {
>>>> 	return -ENXIO;
>>>> }
>>>> #endif
>>>>
>>>
>>> I had to go back and take a look, but I had a shared header in v5
>>> (link:
>>> https://lore.kernel.org/linux-cxl/20230926120418.0000575d@Huawei.com/).
>>> Jonathan recommended that I instead include cxl.h directly, but that
>>> was pretty much a completely different patch set at the time (and the
>>> header was under include/linux/). That being said, I agree that a
>>> header under drivers/cxl would make much more sense here.
>>
>> I agree with Jonathan that there are still cases where it makes sense to
>> do the relative include thing, but cxl_pmu is an intimate extenstion of
>> the CXL subsystem that just happens to live in a another directory. This
>> EINJ support is a handful of functions to communicate between modules
>> with no need for EINJ to understand all the gory details in cxl.h.
>>
> 
> All right that makes sense. Thanks for the clarification.
> 

Ok so I took a look at implementing this. I don't think this solution ends up having
the intended behavior. Using a shared header and the Kconfig rules above introduces
a dependency on the EINJ module, which I was trying to avoid by using the callbacks
since I don't think the CXL core should fail to load if the EINJ module fails.
So, unless you have any other suggestions, I'll use the Kconfig rules above but keep
the callbacks (and also change the EINJ module to use IS_REACHABLE(CONFIG_CXL_EINJ) instead
of IS_REACHABLE(CONFIG_CXL_ACPI) || IS_REACHABLE(CONFIG_CXL_PORT)). I may also just
be doing something wrong (most likely due to late Friday brain fog), so let me know if
I got something wrong here.

Thanks,
Ben

>> [..]
>>>>> +Date:               November, 2023
>>>>> +KernelVersion:      v6.8
>>>>> +Contact:    linux-cxl@vger.kernel.org
>>>>> +Description:
>>>>> +            (WO) Writing an integer to this file injects the corresponding
>>>>> +            CXL protocol error into dportY (integer to type mapping is
>>>>> +            available by reading from einj_types). If the dport was
>>>>> +            enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>>>>> +            a CXL 2.0 error is injected. This file is only visible if
>>>>> +            CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
>>>>> +            be able to reach one (or both) of the CXL_ACPI or CXL_PORT
>>>>> +            modules to be functional.
>>>>
>>>> Similar comments about dropping these details that can just be solved in
>>>> Kconfig.
>>>>
>>>> This is next comment is on EINJ ABI, but you can skip it just to
>>>> maintain momentum with the status quo. Why require the user to do the
>>>> string to integer conversion? Seems like a small matter of programming
>>>> to allow:
>>>>
>>>> echo "CXL.cache Protocol Correctable" > einj_inject
>>>>
>>>> ...to do the right thing. That probably makes scripts more readable as
>>>> well.
>>>>
>>>
>>> That's a good point. I can do that, but I think it may be better to keep the
>>> consistency with the EINJ module to simplify things for end users. If you feel
>>> that isn't a big enough concern I can go ahead and modify it.
>>
>> Oh, definitely keep the old style as well. I was thinking of something
>> like:
>>
>> echo "CXL.cache Protocol Correctable" > einj_inject
>> echo "0x1000" > einj_inject
>>
>> ...having the same result. Up to you though, I will still take the
>> series if only the integer way works.
>>
> 
> Sounds good. If I get the time I'll add in the string version as well.
> 
>> [..]
>>>>> +	snprintf(dir_name, 31, "dport%d", dport->port_id);
>>>>
>>>> How about dev_name(dport->dport_dev) rather than the dynamic name?
>>>>
>>>> The other benefit of this is that the dport_dev names are unique, so you
>>>> can move the einj_inject file to:
>>>>
>>>> /sys/kernel/debug/cxl/$dport_dev/einj_inject
>>>>
>>>
>>> I didn't realize the dport names were also unique. I'll go ahead and do that instead.
>>
>> Yeah, you can assume that all devices that share a bus must have unique
>> names so that /sys/bus/$bus/devices can list all of them without
>> name collisions.
> 
> Yeah I was thinking that dev_name(dport->dport_dev) would give a name like dportX for some reason
> and realized what that would actually do about 30 mins after I sent out the email :/.
> 
> Thanks,
> Ben
> 

