Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9721032A4BF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Mar 2021 16:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbhCBLNf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Mar 2021 06:13:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46552 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbhCBBWY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 20:22:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1221Krhl043880;
        Tue, 2 Mar 2021 01:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4WToiToDYmFCBhzKiH2QynmKkoQW4ghWpFW0pHAY0ec=;
 b=Ldg3L9tJkIIIuxKTpkml61fhFTcpGstJ06lk+5DajCHrCf+5xiQr8xnUu50jUSrL4HEm
 h17T9bKjznwCsTCM4hQpzJ/U9QEkiAr4JZGAz7/Z/4LvcnrQz+hukfk/WQ0tnbIULdSD
 vdpMk/yT9E+QRQV1xoIk43lpvmoL32uytctQbe/LoKn2q4DOBsegABNz9JrpUR3Qu1MJ
 iwZVf1iDGtWkIkx9GrOMYgJqGyu/T1bOhuWzr6loFwga9hcPuFmkLxynU5Fnbh4rnYSg
 LkcmEaFyw5h3nE+1d/RHkcyQ0rcyHRPM72DO60kvWpUs/NBVmPibyOijnkQqcMlt7Q7z +A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36ydgr5vac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 01:20:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1221KUkM160140;
        Tue, 2 Mar 2021 01:20:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 36yyurayef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 01:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV9MuYO9sj8bzk0KbcmYDyxvvJwtlArPDGU6gk0BSZ3rxkyRb23E+Ezrit5XkkSvwrCASaAA8b88NDB9xSqa4cDUoVnY8RUjQurtuKyyL3m1tJkj8IihKKZfWX4F8wLoPDfc24deHbKAbOoXrJYTLCoXEAm6BrFx+iqLiLd3ZIiWfz/vT2V+V6qyjT5INT8/ok0EOmLGspKzF5eesdjU0fQ0Ep3uyDwKn89ukYJx6LB+qLnyJnfNj3hnXz/Y6u4Fs6faIt1iKqFsUCyG8cqDg7o5ATjF7a8NE3R/TywIJ+hwaQkOoCDoWSfNyYqWk8gk41Ne7oNveICLaSU/hXLHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WToiToDYmFCBhzKiH2QynmKkoQW4ghWpFW0pHAY0ec=;
 b=XSNvWKMEqKIHbJ7cKuafKlpUwdbieC/nnAK2kWy3cIL9poNcAxGxJYstw0WolcqUEaVlTAgeZucDlsXRPwJXWqPJVYtqSIprjOIVUyzUqB5FBHFUnnpm/bX9uj+oxqLL2/yYD2mKoU+EjCbwMhnHsp7ngYCFmAA4eiKxWNPZRV4XELm0TD3/l39EyN6P9zl0+Zwqsxr0YpcIqoabXabLJJwyMgljm8AjYXwZQwkn0Eyk1L+aCratmQvCkZsamwzdoyg4AKCWOPfMnkaqHUkGtek+lZx75qCnY72cl/AORKrhH2vvANwifE0Ux5/slRfuuba/lhzpSeClCbkYVGVLIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WToiToDYmFCBhzKiH2QynmKkoQW4ghWpFW0pHAY0ec=;
 b=mMGgItmZJcf59DGYwHC2P+ynpk1ElRBsj5sQ3ppovP1r/ajzkCgm6IwtLbN/2wkFGbWJWxiDDEvL1sOW+UI1akpFQfv/kj9Yy5aBqZxu8gf8LlhbzBpa8vfmoRogaj8wKtPLoa4KzRsyMFsXbG4wwLFG4Tez0asKQyl3urCXVFg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB2985.namprd10.prod.outlook.com (2603:10b6:5:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 2 Mar
 2021 01:20:50 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 01:20:50 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
From:   George Kennedy <george.kennedy@oracle.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org
References: <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
 <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
 <20210226111730.GL1854360@linux.ibm.com>
 <e9e2f1a3-80f2-1b3e-6ffd-8004fe41c485@oracle.com>
 <YDvcH7IY8hV4u2Zh@linux.ibm.com>
 <083c2bfd-12dd-f3c3-5004-fb1e3fb6493c@oracle.com>
Organization: Oracle Corporation
Message-ID: <a8864397-83e8-61f7-4b9a-33716eca6cf8@oracle.com>
Date:   Mon, 1 Mar 2021 20:20:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <083c2bfd-12dd-f3c3-5004-fb1e3fb6493c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: CY4PR06CA0071.namprd06.prod.outlook.com
 (2603:10b6:903:13d::33) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.26.147.230) by CY4PR06CA0071.namprd06.prod.outlook.com (2603:10b6:903:13d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 01:20:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67987aa4-181a-4449-816d-08d8dd196a1e
X-MS-TrafficTypeDiagnostic: DM6PR10MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB29856374DFB988BD2CF42F8FE6999@DM6PR10MB2985.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXTz5xiEwlEGkETTANgnCC8WMXEPI59gzjrfzji82Tx//SF4Y7cvjyR+4Y0fMUwrDijgBdniQaU+/SKU+jN5esQlvlyNDRYdIKhPJLzwGxNVwzntwqTqE2a9Xofb2cLd1mTlHEIYBmKa2fluZYYlAjXb9DHzh6H3G30nGtJestj6btTvwyhbiO+S0Oy72bIUoN2FzaOzYDkR0S50KsPrGelw+xNo9P2cBIM1eMubGU2nenGLtF3vy3+yRVf8K3VSSpbAB/2I9Odi6Sxng4IWq9yH1xrEWZLXu11BXYwVSBhdrgMNTOKPJjER8i4EF5fgswkCWht/qERluD2/GwpY/H7wJfsgHyFK7gWklJBHdN5oM4BzNiXOHjTfM8cqpnjBQbC0PSHq4J1bRGAAs7xkr1kFYB1FJrZGr1LFUEysuNkVdDAiKyLmH+rPJgXuV7BQk+tDC8ym5CseR+zkdgDxEjGApNnwKweVnAvRLM+qUfjVjpeH7JVGQvTA59KTvCNhssctJErmVwgfviDSr00pLHKVPDbSF+ABAvywrdBA1gvxhuJpJqm2STqX32pUHRlIgb17mBOJyv0aQ2crmIXbKVIPVNTmzN89mx7yCelrUzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(31686004)(8936002)(66476007)(36756003)(66946007)(86362001)(4326008)(66556008)(7416002)(5660300002)(186003)(16526019)(26005)(2906002)(16576012)(8676002)(2616005)(316002)(36916002)(31696002)(6916009)(956004)(44832011)(6486002)(54906003)(478600001)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUQvN0kzU2xpMkF1azN6TlZQc3FzTGptU3VmY1U3NFZSZnBpMVFXcVp5S21M?=
 =?utf-8?B?ZUVIZlhMcGpXS1lFaGRIL25KcUtLT05Td0hhdk44cVJGUVErYTR1bUNsL2kv?=
 =?utf-8?B?VzN4cDluOU1EYlRUanBLQ29LMjM0UjArS2hoaE96TWE4dXZodm15Sit1WlFF?=
 =?utf-8?B?TERUcTJGRmlCSkYxbytNL0ZNY0UzMnkwdVNybGtCWHFXY29iUFAyMFBRTk8y?=
 =?utf-8?B?N2c1VUpQazJHMFhMcGdOUk93dFBqSVJwTWdFTTMwQkhqMnRrMndQYnp4SWs1?=
 =?utf-8?B?bmlaY3BWRUtNNWplTVRPd20xL0k3MmoxdXBEN1RUWHZQRTVRRUpuUDNaQk14?=
 =?utf-8?B?eERsdmJHd0p5S2ZJaGV3MDBkS1RrQytZZFE2dUlIVml0aG50Zzg4Tm84Slh0?=
 =?utf-8?B?RC9YWTFRWFg0dVQ2ekVkMjVrWXdqQ2JhTlhKWVozZTlpSGxmVnMvYitkSU5Q?=
 =?utf-8?B?NUlnZEtacEg0TzhWSWR3SVNzdUsvUUJNK2oxZjBtazBOaW1sQkpGdWtOOGIv?=
 =?utf-8?B?cEhLZWxGTlU4SmZZdWZZVWt1K0srWlpXRWhhSk1LdmtTQjEwb0NwcU9JZitE?=
 =?utf-8?B?VFdjc2EzbVRDVlRoYlo1dlhlWW4zcisyQTBXaUlyZHNTNkU3K1ZoY21xOXQ1?=
 =?utf-8?B?Qm1wY09jTGkvMEhDeENiclhaUjM2dzlhS2ZvRGM2OENlcFpNYnpub05UQ3ZY?=
 =?utf-8?B?TTlabEZFTURQZXJWQnN6N21BbWxVS1VOdHRGU21IMVVsV3hZemVqRi85SHlK?=
 =?utf-8?B?bGJpRkQvam1SK2VkbVNnWENVMGMxWVBjVjJlRDRwUURYWEpXblUyeVdXMktz?=
 =?utf-8?B?MWZrRjlXaHIzc2xUSlNTblJzeDRSTUtyaW5oV0tFVWt0L1QrQ2N2NG5uNGY4?=
 =?utf-8?B?S05PN0l2NDdhR21rblErbzNvQjVKem52R1hMRDlxdnBGQ2NyS2F0OFZZQVNs?=
 =?utf-8?B?NXhKYlgxSGtFRW1IQ0FWRko0YkJNeXdEb3RqdlY0V3RMMEF5eGU1bTQ1VVQv?=
 =?utf-8?B?dHpZKzNYMGF6TmlyeUwxNytjdmhBV2plVEpOM1V4akpWRlRHQU02ZEJlRnU3?=
 =?utf-8?B?aXVJNkduZXVMd0lGdkVWaDd0L1IxVjNoaTBQeW94a1Z3TVFIeStTbXhacCtH?=
 =?utf-8?B?Sys0YmZCS1h2V2R1Q1cvcUZTUFBSUUVpSkxGb0Urb2RLTlJBT1VXOWNCNzJO?=
 =?utf-8?B?NFppWWhYRmliOW9DdEU4TGNtUXF6UEdsWGRSNGFQUUNhMTJCWGp6U1J4S3hv?=
 =?utf-8?B?bHBrR1lhZFptNi9aRmdGeGozTEk1cWVVbFdQRU4zWnppZm8yN3hqbC9hV1g0?=
 =?utf-8?B?eUFMcnFxS0tXTUdpc3NwRmJzTitpSVdxc2h3cisrclpvOXlabUdYbnIwTU4v?=
 =?utf-8?B?bUJIVkNkbW8zL01DVmxNcFl5alpFRUYzTjFBNlRzd1RuZVlTTm8vSWdiR01F?=
 =?utf-8?B?Wjg0UmVwZGUrRHBFOTdTbzgvS0F1c2ZsOUlmNEZtcDJGby9KQUhIUjFZUFJE?=
 =?utf-8?B?VUhEY2o4b0VkNlNZSVZCa09jVFFNTExiaXNwOVprWGhwaVVMdzZRdFFRSUJU?=
 =?utf-8?B?cVI1QkFJUzZmVDYwUTROaGdZSldxMFhCMmFVWGFNcWZzcXZWUmRxS1loVDc3?=
 =?utf-8?B?QXMvYkZsYmtpMWtDR3Y5YWlWUlc5K0dXK212SlNDT05Sc2kxM3lmbE5ldmJC?=
 =?utf-8?B?OTZwai8yamlzc1RPWDVYaUV5aW1KNW1udTExTTM5UjBOa3hHdmZPVzZzdExj?=
 =?utf-8?Q?SHi75xSRYrJZiuRB+G/0HEPa1wY86rIOvmP/NFj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67987aa4-181a-4449-816d-08d8dd196a1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 01:20:50.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5dTcPUDXf2niMlPBQHO+jIQoqrtpbDNwXElML40oebn/6EIZJ8/LDVxUQWAVfwf3i21HMUjQ5nCuCm1eOvR+em1Rfvsk9eFQIdIbMKM8ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2985
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020006
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/1/2021 9:29 AM, George Kennedy wrote:
>
>
> On 2/28/2021 1:08 PM, Mike Rapoport wrote:
>> On Fri, Feb 26, 2021 at 11:16:06AM -0500, George Kennedy wrote:
>>> On 2/26/2021 6:17 AM, Mike Rapoport wrote:
>>>> Hi George,
>>>>
>>>> On Thu, Feb 25, 2021 at 08:19:18PM -0500, George Kennedy wrote:
>>>>> Not sure if it's the right thing to do, but added
>>>>> "acpi_tb_find_table_address()" to return the physical address of a 
>>>>> table to
>>>>> use with memblock_reserve().
>>>>>
>>>>> virt_to_phys(table) does not seem to return the physical address 
>>>>> for the
>>>>> iBFT table (it would be nice if struct acpi_table_header also had a
>>>>> "address" element for the physical address of the table).
>>>> virt_to_phys() does not work that early because then it is mapped with
>>>> early_memremap()  which uses different virtual to physical scheme.
>>>>
>>>> I'd say that acpi_tb_find_table_address() makes sense if we'd like to
>>>> reserve ACPI tables outside of drivers/acpi.
>>>>
>>>> But probably we should simply reserve all the tables during
>>>> acpi_table_init() so that any table that firmware put in the normal 
>>>> memory
>>>> will be surely reserved.
>>>>> Ran 10 successful boots with the above without failure.
>>>> That's good news indeed :)
>>> Wondering if we could do something like this instead (trying to keep 
>>> changes
>>> minimal). Just do the memblock_reserve() for all the standard tables.
>> I think something like this should work, but I'm not an ACPI expert 
>> to say
>> if this the best way to reserve the tables.
> Adding ACPI maintainers to the CC list.
>>> diff --git a/drivers/acpi/acpica/tbinstal.c 
>>> b/drivers/acpi/acpica/tbinstal.c
>>> index 0bb15ad..830f82c 100644
>>> --- a/drivers/acpi/acpica/tbinstal.c
>>> +++ b/drivers/acpi/acpica/tbinstal.c
>>> @@ -7,6 +7,7 @@
>>>    *
>>> *****************************************************************************/ 
>>>
>>>
>>> +#include <linux/memblock.h>
>>>   #include <acpi/acpi.h>
>>>   #include "accommon.h"
>>>   #include "actables.h"
>>> @@ -14,6 +15,23 @@
>>>   #define _COMPONENT          ACPI_TABLES
>>>   ACPI_MODULE_NAME("tbinstal")
>>>
>>> +void
>>> +acpi_tb_reserve_standard_table(acpi_physical_address address,
>>> +               struct acpi_table_header *header)
>>> +{
>>> +    struct acpi_table_header local_header;
>>> +
>>> +    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
>>> +        (ACPI_VALIDATE_RSDP_SIG(header->signature))) {
>>> +        return;
>>> +    }
>>> +    /* Standard ACPI table with full common header */
>>> +
>>> +    memcpy(&local_header, header, sizeof(struct acpi_table_header));
>>> +
>>> +    memblock_reserve(address, PAGE_ALIGN(local_header.length));
>>> +}
>>> +
>>>   /******************************************************************************* 
>>>
>>>    *
>>>    * FUNCTION:    acpi_tb_install_table_with_override
>>> @@ -58,6 +76,9 @@
>>>                         new_table_desc->flags,
>>>                         new_table_desc->pointer);
>>>
>>> + acpi_tb_reserve_standard_table(new_table_desc->address,
>>> +                   new_table_desc->pointer);
>>> +
>>>       acpi_tb_print_table_header(new_table_desc->address,
>>>                      new_table_desc->pointer);
>>>
>>> There should be no harm in doing the memblock_reserve() for all the 
>>> standard
>>> tables, right?
>> It should be ok to memblock_reserve() all the tables very early as 
>> long as
>> we don't run out of static entries in memblock.reserved.
>>
>> We just need to make sure the tables are reserved before memblock
>> allocations are possible, so we'd still need to move 
>> acpi_table_init() in
>> x86::setup_arch() before e820__memblock_setup().
>> Not sure how early ACPI is initialized on arm64.
>
> Thanks Mike. Will try to move the memblock_reserves() before 
> e820__memblock_setup().

Hi Mike,

Moved acpi_table_init() in x86::setup_arch() before 
e820__memblock_setup() as you suggested.

Ran 10 boots with the following without error.

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb..3b1dd24 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1047,6 +1047,7 @@ void __init setup_arch(char **cmdline_p)
      cleanup_highmap();

      memblock_set_current_limit(ISA_END_ADDRESS);
+    acpi_boot_table_init();
      e820__memblock_setup();

      /*
@@ -1140,8 +1141,6 @@ void __init setup_arch(char **cmdline_p)
      /*
       * Parse the ACPI tables for possible boot-time SMP configuration.
       */
-    acpi_boot_table_init();
-
      early_acpi_boot_init();

      initmem_init();
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 0bb15ad..7830109 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -7,6 +7,7 @@
   *
*****************************************************************************/

+#include <linux/memblock.h>
  #include <acpi/acpi.h>
  #include "accommon.h"
  #include "actables.h"
@@ -16,6 +17,33 @@

  /*******************************************************************************
   *
+ * FUNCTION:    acpi_tb_reserve_standard_table
+ *
+ * PARAMETERS:  address             - Table physical address
+ *              header              - Table header
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: To avoid an acpi table page from being "stolen" by the 
buddy
+ *              allocator run memblock_reserve() on all the standard 
acpi tables.
+ *
+ 
******************************************************************************/
+void
+acpi_tb_reserve_standard_table(acpi_physical_address address,
+               struct acpi_table_header *header)
+{
+    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
+        (ACPI_VALIDATE_RSDP_SIG(header->signature)))
+        return;
+
+    if (header->length > PAGE_SIZE) /* same check as in acpi_map() */
+        return;
+
+    memblock_reserve(address, PAGE_ALIGN(header->length));
+}
+
+/*******************************************************************************
+ *
   * FUNCTION:    acpi_tb_install_table_with_override
   *
   * PARAMETERS:  new_table_desc          - New table descriptor to install
@@ -58,6 +86,9 @@
                        new_table_desc->flags,
                        new_table_desc->pointer);

+    acpi_tb_reserve_standard_table(new_table_desc->address,
+                   new_table_desc->pointer);
+
      acpi_tb_print_table_header(new_table_desc->address,
                     new_table_desc->pointer);

George

>
> George
>>> Ran 10 boots with the above without failure.
>>>
>>> George
>

