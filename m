Return-Path: <linux-acpi+bounces-2249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E180ADF6
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8D02815A2
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105105787B;
	Fri,  8 Dec 2023 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cn2YTHxb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD371738;
	Fri,  8 Dec 2023 12:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyrLj+tKq44UbhdyI1JLmgwJtTEsRxrgHhyEc3B4GPAOmewXSs35PbCE7qSU2GBZpglTDRYKDpCTWmp7yAwpZsZzulcPIzpzQeEIGsjPxxo+5lqPUP96pZalncx8DIdfAwYjPpDSQS4Q/4wR9fASdk4qN4eHL1Ut4IHLOYqqlKuW6lm5HkFLQIkCYIy3I70E88L2oJgi9rjXCvbLAw2w8NbMIJ3/AJ4rvRhvPjgloCijsnpAKuGJp+KnGgQ5mQWaoRjEYccUpA7hD+vZ/6G1MiUVIwUPWOLjzF6WiJw9t2D/YDnEbKre4eGSwKOfV4kWKL3G7dlHibEgiG4Ox5bqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjPHhdWHLuMQ4Toh+ePcnGOfw4eX6u272oDw/OXEQco=;
 b=TpaPvrOEYATacY9NcrSFy+O/BhwF5ZzbaUFcNFUoiIusPbvx7UBURHe0S5ajeumTOtEFZNrersGg31tf6O/hAb9mbcRwvAeLtR7sEvrvHxYOFbCKW2ba5Dvlv0a2rFYltin6iPwT4vyU6bYWmJQXtFxEmU7pLXbhVmWNRhdDfU4P2TljuoQ14+0/1UYEHVhXpuhF6xJU2TeT9pSlJ4bjme4tDbHCi1Twgo3zO1uz5UggdAELU2LXdfIX3hfGz8D6Yok/9gG08sbH+E3fiGydoCCLzwC19R2uHfk3itld8AEHI+aPzCs/DSuZl0SyZImcEbFHaqgHDGVu+5KhHpR/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjPHhdWHLuMQ4Toh+ePcnGOfw4eX6u272oDw/OXEQco=;
 b=cn2YTHxbCcdK6F2JCMcOWJ1RCHz1cEhswjdp4f2giS1ctcnxZQcfez47PyJit5rPb3zcWu0rGIvsK7Ycr0uA5I8R5iApK4rKFR9GBAYpmOFkaL+FVibMgjiDqBeLYMbST0JK14JZaCQNXw1XSu9B/22xj2B0cl6XsyevymBlKAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 20:35:35 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 20:35:35 +0000
Message-ID: <4b239b40-7a40-4261-8472-1bda0cbb5fa9@amd.com>
Date: Fri, 8 Dec 2023 14:35:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
Content-Language: en-US
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
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65735a0e595e_269bd2948a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:408:d4::38) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf433ce-7a38-40fb-85e5-08dbf82d3b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CAUH58J2ZFRGN4z15fdoxpldQP1wFOdIkW14D9ZSSR8Xtz+wsuEuX/UZblHHlLnVkeyOGIvLXAXBK8xGPRz00m+DVpKEteg1zoo8u67klVGzhux7T6F/inpBUDhp3raHCDAA4FPXfCmSlxIMDZAbVFtEtLWMBE+Ynh/W0+C6jV655uIUSi9tMF0Qy1p5wADFS3p4Gt2YDhRUCme9UbyiGN7en4CePqxWkaFUmtFqIszDm8y9H+p1ILf1Na+AaZmzkBhDuSSoB7jjyI8smtvt6fXA7X4F0HoJNfOhk0aqDClPJ8kKNWicC8Ik0iBoAgloKnae1sjSiEC7xTVDmJHrb/nW8KfSlyTOID2XmY3Jp3Q4zGkJFOil42jmjxeJN+GItGlv30RpizVtExePNsnG0pTnLTNL6NkTN8HeXkU5x0JXA+1FUbQD8XYV8s8eP74wFR9Llg0YXxCCKtuxrOdso9i+Kg30vVoDgd4MpQILApn8rymoNRTs6kl3VxxQbmbEDBYKSQTpqyaN+s2JhB7Wy+/3s1g2udE4EoqWRxKP1+iBbsMYcbkBC9PJEe5Rm6avkvGvrYWNL7LToYnrgp84A+O6mG7w2ZqpW0/yFWYZcIwb0OOZ5XoD2eD06r6TXvTBb52bLLu6GZIaW5e3BZnk4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31696002)(26005)(7416002)(5660300002)(41300700001)(6506007)(53546011)(38100700002)(6512007)(86362001)(2616005)(31686004)(6666004)(478600001)(8676002)(966005)(6486002)(66946007)(4326008)(66556008)(66476007)(8936002)(316002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXd4WFJJQy9BcDJ4R2pFTm5EaHhRK2tjc2RjaWRvNW9oaUxrdDB0QXBOQno5?=
 =?utf-8?B?UHlRL2xJM2VwMzUzQ09kaC9jTnEwN0c1NUYxMHMrTGlPRyt5WG5VMloxUzlK?=
 =?utf-8?B?Z3BNNTNRbDN2Q2VkSGY0WVhkdGxsY00zT1kxVVpBSkI1RzYzZERJMnQxRFhT?=
 =?utf-8?B?NnFaeTlKZFJhQkZJZlV5bFdDVTlQblZZQ0hlWUI3RllXb3NjdUIvUWxsUFRZ?=
 =?utf-8?B?S1JhMjlObkdCSm5SS21TQldlbjd3eDBCL2ZWOFhLRU1MeW4wM3l4YWtpbnRn?=
 =?utf-8?B?RkpsRmpLVnp1dDU1M2pici93WWJNajczbGxrUXpNQTRGWGVGcExzaXlKVUFT?=
 =?utf-8?B?SEs4QmRFelM3Sm5OamVkcXFpTHRHalFSeGF6WkhML2w4eTNtV0dHb1FZWWNC?=
 =?utf-8?B?U0VKeThUS0VjWWl4V21rOHl3Q2hubjFyRm8ybHZtSStWVWVpV3BqOC9DbnhW?=
 =?utf-8?B?KzJBRUkwb2JpSXVLZVFZU3V1MGlaWWxJU2V6aTlYYXR0L3pBYnBjd3BkNUho?=
 =?utf-8?B?bWVDVGJEeVFHUjEyYlEyYVZvTGpOWFdkU0J1WnVRZDRST3Z6N2NaOU16bW1J?=
 =?utf-8?B?anp0d3UrczRVRW5kZm5vRWYwVFhHYmlCU1grUVg5bUhOZ3BrQllPOS9KMC9U?=
 =?utf-8?B?RWcxQjV4SDc2QVpnRFFYVEJrQ2N3UEE0bUxQNzVuN2NJVzk0NEwxK0s1Yk5J?=
 =?utf-8?B?UXdiOEtzcldtbGFLWmhPdFJyUzlBT3FUVjBKMzVtKzFTMVg1b3dJTExONGEv?=
 =?utf-8?B?c3R4b21PV2dpUnVia1RqcGQ2MDM5dnFKMDJmZlg3OUZ4SFdNWVRUTUhnZGpj?=
 =?utf-8?B?Tm5PNjJHZFRhbW9hZ2NHTXlMYWF4cHJOQ2Q5L0U3WGVpNUV1L1FTa3ZqdE5L?=
 =?utf-8?B?VFJNeE9jTHRQRFlCT0tWUk1RNW9JQkYzc2tUQmFFcUM0a1VRZHVuUS9SMExD?=
 =?utf-8?B?NTJIaGN0VWFtTU5tcE9yQXEwSVJLRzIzVXh1UytpN1hEcXJITlhxMCtCSkp0?=
 =?utf-8?B?NW42V05zT0d2UzlVODkzaWVudWRoaTVKUHVnNnNFcVBBbnhTbGlHU0NjT1VI?=
 =?utf-8?B?U0VSMjQ1YUphbjhYYldaTDdxYVJSc2tYYjdSd3FJeHBNM0dpL1ZtV0pVRk85?=
 =?utf-8?B?SjUva1liTHNCSmlBei9yMFptcVJ4WHdDaHRBQWpvbkRKcTc0NERTTVV4TWdI?=
 =?utf-8?B?U3Brakp5cjFOV3NXZ1IzMHFmWjVXU01YazJoQXBiRDR2OUlhdFJnNUdhQmt1?=
 =?utf-8?B?M0c2bXJXWENSTmdRSTllQ1E3VjBmamlGSWY1OVZuOTFNMlFOR29HTmhSSFEr?=
 =?utf-8?B?T2RpWUhya04xc1d0Rk52UzVGb0FySUd3b3pxL1ltcXFiYUFqOE95N3Y0Rndn?=
 =?utf-8?B?VkpOTnRNMFZJRjcyMm5GdytONzJ0TjJQb1M0WE8yZVBpTE55Tnpma091VWFC?=
 =?utf-8?B?RVJXeHIyUCtjbi9OUDh0NEZjZEtxRVI1UzhhTHRtZm03WUk5R0VmeENMNWFJ?=
 =?utf-8?B?NHZ3V1o0emF2b2c3VGEzYUYvUFlYbFJoL3VlQVdDZmk4SjRFRU5ETHhVNUVZ?=
 =?utf-8?B?dW5NNWFVMXhJZXFPTmVlKy8wajhPTURNQi9FMlAvZThiazd4VEtpeEttbnhR?=
 =?utf-8?B?M2tkTVpWQ3dKTnJCeXlRRXM1RE9MeXU1Z0dhYysrTU9GcW9hY1JIcStNWnVZ?=
 =?utf-8?B?VEY5bnowSWtJbm03REpudkNWNDNYVC9mYmkxaEZrZ3BKc1pLUmt6REZWR1BJ?=
 =?utf-8?B?ZEMxSkZ3b2w2dGR5MmNCbjJmY3ZYT3BkUGVod01vVXdYZnZES3FQSVI5V0hD?=
 =?utf-8?B?WEdJUTRucWVPbUNhZlJ5MHJXZVhxWnNRQnhHSXZJeHF4aXo3ZnFPMWczRjhG?=
 =?utf-8?B?QWRUaGd5ZVVoTEVETDNIbHV3b0I4VmI4QWlOd3BXZ3pWSG9TQXp0d1QyMDVl?=
 =?utf-8?B?TU1jQ1gxNGVqYytTdk1XbndZR01mVjEwY1I3NHVLWm9PbHh2eUVxSnk1cnpn?=
 =?utf-8?B?YXIrYjhpczg1b0RvNEVPZkw3bHltMFNzd2RXSnhDRkhkTzBDaDgrS3FRNVc4?=
 =?utf-8?B?dng0L2twYTZDdkZVMmNsVGE5M0hmTFphaEpuR0FwZnRqeGJnNEg2T29qVmdk?=
 =?utf-8?Q?ebCaJ6A/JtVHImbpNSU7b9e6/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf433ce-7a38-40fb-85e5-08dbf82d3b41
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 20:35:35.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y4Hd1wqaeq6paoIBw5A0Zb4smEITsesxu1gvP4VwBFMHKHI7lYKwdGBpik8BS+/48owN/lrBch7HwcWwGewuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390



On 12/8/23 12:01 PM, Dan Williams wrote:
> Ben Cheatham wrote:
> [..]
>>> This can be simplified. Have something like:
>>>
>>> config CXL_EINJ
>>> 	default CXL_BUS
>>> 	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
>>> 	...
>>>
>>> Then the documentation moves to Kconfig for how to enable this and the
>>> CXL code can directly call into the EINJ module without worry.
>>>
>>> It would of course need stubs like these in a shared header:
>>>
>>> #ifdef CONFIG_CXL_EINJ
>>> int cxl_einj_available_error_type(struct seq_file *m, void *v);
>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
>>> #else
>>> static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
>>> {
>>> 	return -ENXIO;
>>> }
>>>
>>> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
>>> {
>>> 	return -ENXIO;
>>> }
>>> #endif
>>>
>>
>> I had to go back and take a look, but I had a shared header in v5
>> (link:
>> https://lore.kernel.org/linux-cxl/20230926120418.0000575d@Huawei.com/).
>> Jonathan recommended that I instead include cxl.h directly, but that
>> was pretty much a completely different patch set at the time (and the
>> header was under include/linux/). That being said, I agree that a
>> header under drivers/cxl would make much more sense here.
> 
> I agree with Jonathan that there are still cases where it makes sense to
> do the relative include thing, but cxl_pmu is an intimate extenstion of
> the CXL subsystem that just happens to live in a another directory. This
> EINJ support is a handful of functions to communicate between modules
> with no need for EINJ to understand all the gory details in cxl.h.
> 

All right that makes sense. Thanks for the clarification.

> [..]
>>>> +Date:               November, 2023
>>>> +KernelVersion:      v6.8
>>>> +Contact:    linux-cxl@vger.kernel.org
>>>> +Description:
>>>> +            (WO) Writing an integer to this file injects the corresponding
>>>> +            CXL protocol error into dportY (integer to type mapping is
>>>> +            available by reading from einj_types). If the dport was
>>>> +            enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>>>> +            a CXL 2.0 error is injected. This file is only visible if
>>>> +            CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
>>>> +            be able to reach one (or both) of the CXL_ACPI or CXL_PORT
>>>> +            modules to be functional.
>>>
>>> Similar comments about dropping these details that can just be solved in
>>> Kconfig.
>>>
>>> This is next comment is on EINJ ABI, but you can skip it just to
>>> maintain momentum with the status quo. Why require the user to do the
>>> string to integer conversion? Seems like a small matter of programming
>>> to allow:
>>>
>>> echo "CXL.cache Protocol Correctable" > einj_inject
>>>
>>> ...to do the right thing. That probably makes scripts more readable as
>>> well.
>>>
>>
>> That's a good point. I can do that, but I think it may be better to keep the
>> consistency with the EINJ module to simplify things for end users. If you feel
>> that isn't a big enough concern I can go ahead and modify it.
> 
> Oh, definitely keep the old style as well. I was thinking of something
> like:
> 
> echo "CXL.cache Protocol Correctable" > einj_inject
> echo "0x1000" > einj_inject
> 
> ...having the same result. Up to you though, I will still take the
> series if only the integer way works.
> 

Sounds good. If I get the time I'll add in the string version as well.

> [..]
>>>> +	snprintf(dir_name, 31, "dport%d", dport->port_id);
>>>
>>> How about dev_name(dport->dport_dev) rather than the dynamic name?
>>>
>>> The other benefit of this is that the dport_dev names are unique, so you
>>> can move the einj_inject file to:
>>>
>>> /sys/kernel/debug/cxl/$dport_dev/einj_inject
>>>
>>
>> I didn't realize the dport names were also unique. I'll go ahead and do that instead.
> 
> Yeah, you can assume that all devices that share a bus must have unique
> names so that /sys/bus/$bus/devices can list all of them without
> name collisions.

Yeah I was thinking that dev_name(dport->dport_dev) would give a name like dportX for some reason
and realized what that would actually do about 30 mins after I sent out the email :/.

Thanks,
Ben

