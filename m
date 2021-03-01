Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC293280E9
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 15:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhCAOb2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 09:31:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59824 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbhCAObV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 09:31:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121ETFEM129394;
        Mon, 1 Mar 2021 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EDaZMCLt1qQG/K111ETL0PPT/qpJAJSMvHnsV3zyse4=;
 b=uUFZW/W6VkczTOhO1+nPP+1dQ2mIV5PEqzf/itdv99sU3F48yt/I0Mc/2W7Lf81RKKqX
 Tl7m2ZynUg6d6q2u/fL/qLiGJganVkbcf7Hzo6oOvQpWKcqkrAbmJ8OXiLDaAojudOPX
 mCka1vZJRCeV7Q88Qz4Jl9D5dJH96d66iHOLXj8MfSWLZoilRNFmlvPwyaYUWKF8BTmj
 USlykodtYTPsOU+TnpECyFWKisajpvi1Po99w7uUbCkufYB4Wv7r2kwKsjDFXEMmK9aF
 XaGcj9zhyHRU2dutq4VPcWaTxlA4W3gG4NcznD5p+ZFJKyubEYGVuJ0nel3dMZoL/Fpk mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36yeqmv073-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 14:29:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 121EOrGo118017;
        Mon, 1 Mar 2021 14:29:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 37000vkft4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 14:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4cibdcCYEO3qmCS/pO56x9mifvRZ4ljtLtThezoyeVnv0BGWPlll+r1voOP8pUYE0LmfnPWB3F0ggAkRHBlIx5boXkznpjbdMgJeZrDpumAV5ILZLOk3VPE9mLRFXLiMakkmDGTEku7wt/RWaub1kmKmG9Svp69N/OV0QmiezY+QPpqYjzol0A2DOvJst/mcSAqbLB348TW/RcbMyuiHbMON7ZdUc/gduexjWAUSVnVCNq2LjDevNJSvFKq+T+OmlvCjebJEeJnJ3H8C1T82Y9NPCZOjaKDdjcPxNtVpdFgIHdxpcmDh+bQje1PMGZQhKrISgIOFqyvL4ib0OeAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDaZMCLt1qQG/K111ETL0PPT/qpJAJSMvHnsV3zyse4=;
 b=BdYs++D4yB69txwxsFGf41QJKcRbEg8trBMtDTwH8V2xEVY3kawfycjgw/khhgsFU19d4W9KxfCny4209wwyTwGLnn19IIQLjO7sl6x9GKNs9nOeL7yEWbzy00IZQz0GVUGCGT0admm8JxPzI1ggS03gJjadCH84bW0Xkt+7gUE1Ny/njj8nUwZxviDaEllewplgvNNpkOePC63o2lt+0TMTaNarG8gCCDvSxJUkzTffeTiwAGWB1/03F88Ennpsx2/6JbAO5WTtK7zpcBx6sF10o3FkXi7o/ZUiI3IyMLnqD0cSBHesSadX8b/me0Do5HST5jtWkuOQRdQr10UzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDaZMCLt1qQG/K111ETL0PPT/qpJAJSMvHnsV3zyse4=;
 b=HTkCRjd1qWOeR9GMPGA9rDUf1xIB3bSdNA1k+xrytyh3zKrM7WRINfZTX4Y/42tvCODrlVji5Y9plBe7KOfM/W6DkwlJRfC4J9xX1wBqkZlBdcYRGuxSyxhjcNBcO6kC0KcsPyCYcvHp1hg5lAWeg5tBdO7fEdxWOKDgm6NCFAg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3856.namprd10.prod.outlook.com (2603:10b6:208:1b7::12)
 by BL0PR10MB2964.namprd10.prod.outlook.com (2603:10b6:208:79::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Mon, 1 Mar
 2021 14:29:11 +0000
Received: from MN2PR10MB3856.namprd10.prod.outlook.com
 ([fe80::4871:6b79:c2d8:d7bd]) by MN2PR10MB3856.namprd10.prod.outlook.com
 ([fe80::4871:6b79:c2d8:d7bd%7]) with mapi id 15.20.3890.029; Mon, 1 Mar 2021
 14:29:11 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
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
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <083c2bfd-12dd-f3c3-5004-fb1e3fb6493c@oracle.com>
Date:   Mon, 1 Mar 2021 09:29:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <YDvcH7IY8hV4u2Zh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To MN2PR10MB3856.namprd10.prod.outlook.com
 (2603:10b6:208:1b7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.26.147.230) by BYAPR11CA0087.namprd11.prod.outlook.com (2603:10b6:a03:f4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 14:29:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3379632-949a-4e80-1a1a-08d8dcbe61ba
X-MS-TrafficTypeDiagnostic: BL0PR10MB2964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR10MB296428D43066C7AAE5A5EA73E69A9@BL0PR10MB2964.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EduLRtTbNy5XJEsFrhEej6zS6X9Q5C97VxB55VeyqTxmeGIGmJgJqTfFzj+UuIP9saRnCWq+Z5lRYEXD4YSWKYZLt6zgoV/70kDUU9O0sQaKXJNQs8o+hVwRuSk8Z6U37F2QyGwR26cZ1s+rWJIHdjJkf2v0ubbYu3mZTLgbSnJKG/xW+wRFLYdpX65aMOSyVB4CumPKcZZrzsqdiTCKuDCTHCaiT2pYCkaWuNPyct39NCmaF1yi1sGG4HRJNjU085L1M3E8d3+Gejddtap3InVxR7meeYYXSuidYHqG/PVtpdMbYvHgYY0Z87R0RrPSf5uOixU89oQIDcPhdbfT+2FBDHGzio/ay+qlt4xwppmmHCtnEyUIwnZaldcCHu5N/zawM54yAACmlSPLGT3QVoeN13ua13iz3nDqxLfQj9xVq8rm700rzNhDvlQCRIUpv1/zg9ZOJrO9Wcl6GoffcDHxDq78skL/BHfz8LfwNBSOlCxVnYJmgCfe1f5sbZNyM4B3nFqeamz/RhyAZQF6UITIFBhj0fMgKyAHyYrOZabkBOucuEKHuMIPxcsXrkDMC0ccHtZh9b+ZnLzXnMlXHYFgJwcN1+StL33VyaYWyyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3856.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(16526019)(26005)(2616005)(956004)(186003)(44832011)(86362001)(31686004)(6916009)(31696002)(4326008)(7416002)(36756003)(478600001)(54906003)(8676002)(6666004)(16576012)(5660300002)(8936002)(83380400001)(6486002)(66476007)(66556008)(66946007)(316002)(2906002)(36916002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3QrTWsrcDVxV1prYkJtZlp3VU44My9EU1pYTmo0VHRxTnZ4ZGZPcjBzMjFy?=
 =?utf-8?B?QkU0YytmLzhiTHNCMkpTemFtWVdLRlRORE1ZNS94ZEIzMkJEZ3hKdW1pM0Vq?=
 =?utf-8?B?aVhIT2VDWk5OV285TEJxbytvcnZudVlLR28yNjFXa1N4VEhyR09tTy8wWjVN?=
 =?utf-8?B?WjlTOE1DcHRRQ2VldGpNU2RzT3dVbGlldDVCZDQveDhEY3RUS3pHb0tGSnJN?=
 =?utf-8?B?NmtVZlo5bEpraEk0N0hndG5MSkV5a08wTzdLNjV4eEFiOHBxclBBSG1idHRu?=
 =?utf-8?B?Wnp2TitsQkptWDZmUENoclBBSVhtdFBpb3AzaitMREJnYnB2OWszL2RxSXZz?=
 =?utf-8?B?Q1llcmVLa2V6SkpHUjluQ0k3ZFNuV0YrOVRVamV1S1RHS2pNU0VNSzZWUWJ6?=
 =?utf-8?B?WDI0QXh1NjVLL1RuTXdtM0p6aHI3bUxNSjQ3d3pqcEx5WUtWTjZMUzZodDVP?=
 =?utf-8?B?b2R5a2hPaFJzcXpjeEFvVnZhV1k1cHBZYnFVbVhDdkNLeDg1dFk0azN4aUZ3?=
 =?utf-8?B?YzVIWk14cU1kRzNYMEF3Q2ZUajA0ZFZMQldOWFJZbHVXb3VXSGRSbjRXZE9n?=
 =?utf-8?B?dnI3dTljNmNqeXRDU0dPZ1hzWGhNVTJBYzM4SmZUOUhvN2tGTzJMck83bklO?=
 =?utf-8?B?V2hOUUNZUEFkUWFRMkpSdnprZkFzQ1RGOEJoVHhheG9SRk12a0pSSTBwbitQ?=
 =?utf-8?B?VndzZTlvc1htbnVNSTF6T3pONEVQdnk5bUtzN1Q3NVQ3anNrZ3BIT3k2Ymxr?=
 =?utf-8?B?WVZ6YWNpUVIxT24xS2dkVUQ0eUg1QUtpRGJMRkdzNm1sUmdQT1F5d3Jmb3dX?=
 =?utf-8?B?TmovNXRreTJJUG1VT21ydDdYWERRK3RUaTc5cnl6WkttQ0lUOW5oS0FhWHIx?=
 =?utf-8?B?Qk1FZHBRaDE3RFhRZzZPN09XK3VOVUd2MjJTUnNzbGowQ3ZQdVJwTTY4SGNo?=
 =?utf-8?B?eFRRQVhvS09ES21wWEM3NU4vaXovdUYxWTdTU0hzTmV4UHNDQXdxNVZLZmto?=
 =?utf-8?B?QTZRQVJ3Y1B5cDVnRkU1RTdlZHh3TDRJeHk4dWF6ZnFmeTJISWZ0b0pWWWtK?=
 =?utf-8?B?cWtHeGVyblhVMnBlUXRRSnlxUm9wM2kzdE9WNm51bmY3WDZuTHU4R1o3aHlG?=
 =?utf-8?B?SnlDRDRaUVMwU2l4WnpBUzIyaHpjUVFoT1VNeGtyWTVaRDVTdzAyWktVYW1W?=
 =?utf-8?B?N3VIRG8yK1N0UitBYkdqMktteXZHUmJTRlowcElLVGdjZ3JDcWJZZ2FGZFRP?=
 =?utf-8?B?ZVBVTkJKRUdPQ0VHRVc2ZVF6b2FWSWRxRDBad1d2S3ZnZzk1eG0xcHI0S1RY?=
 =?utf-8?B?RGxTSkQ2YmNYdm1pVHlXd0FHLzlHTy85UlV1Vy9KeFhSWlNacXc4MFY3R05H?=
 =?utf-8?B?WHBSQjdGdGR1amhjOVdpQnA4RUdrc0lTSDE2QXVWTkNtZWZlRFh5VWlTMDFV?=
 =?utf-8?B?UjZLaE1GR29EQjdoUVFHRDNpNHlGOHF3QzNDY0Y3ZFpDb0NweFJNWmZrbkl5?=
 =?utf-8?B?R0NuM0xlV095YURrWjQrVkFnTnovUzUzUVhYWHdWMUlPN25ucXZ0RkwvSjdo?=
 =?utf-8?B?KzVubm9WZmsvMXJyOXUwajR6OU5KRUd3eFhpTUxzSFF5VWVvTCt3cmczWko3?=
 =?utf-8?B?NWRVb2V4V1diVTYzZmczTS9paEJwY1BGdU43Z20rSjF1Q2NUOXluT2pFMExh?=
 =?utf-8?B?L0pPUDUyQS9KQitxUDkvU25ia3RCcHBYVk53V0w5azdRdXNtN2RXenZiWVB1?=
 =?utf-8?Q?gKPomAsh4eDnsKsvvyXMCJlqzUc/IiINrDTIE2Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3379632-949a-4e80-1a1a-08d8dcbe61ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3856.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 14:29:11.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRwRSG7YEH1/cZzsaTmqOGojDwvQ+2bUhSjwa3FwEcmgCboviQi7FFPZn8Bf1bBMBlXMQRUHbE8B6qmbe/Sb1l1r1Y/+noLQdQSiqZpXMBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2964
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010122
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2/28/2021 1:08 PM, Mike Rapoport wrote:
> On Fri, Feb 26, 2021 at 11:16:06AM -0500, George Kennedy wrote:
>> On 2/26/2021 6:17 AM, Mike Rapoport wrote:
>>> Hi George,
>>>
>>> On Thu, Feb 25, 2021 at 08:19:18PM -0500, George Kennedy wrote:
>>>> Not sure if it's the right thing to do, but added
>>>> "acpi_tb_find_table_address()" to return the physical address of a table to
>>>> use with memblock_reserve().
>>>>
>>>> virt_to_phys(table) does not seem to return the physical address for the
>>>> iBFT table (it would be nice if struct acpi_table_header also had a
>>>> "address" element for the physical address of the table).
>>> virt_to_phys() does not work that early because then it is mapped with
>>> early_memremap()  which uses different virtual to physical scheme.
>>>
>>> I'd say that acpi_tb_find_table_address() makes sense if we'd like to
>>> reserve ACPI tables outside of drivers/acpi.
>>>
>>> But probably we should simply reserve all the tables during
>>> acpi_table_init() so that any table that firmware put in the normal memory
>>> will be surely reserved.
>>>> Ran 10 successful boots with the above without failure.
>>> That's good news indeed :)
>> Wondering if we could do something like this instead (trying to keep changes
>> minimal). Just do the memblock_reserve() for all the standard tables.
> I think something like this should work, but I'm not an ACPI expert to say
> if this the best way to reserve the tables.
Adding ACPI maintainers to the CC list.
>   
>> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
>> index 0bb15ad..830f82c 100644
>> --- a/drivers/acpi/acpica/tbinstal.c
>> +++ b/drivers/acpi/acpica/tbinstal.c
>> @@ -7,6 +7,7 @@
>>    *
>> *****************************************************************************/
>>
>> +#include <linux/memblock.h>
>>   #include <acpi/acpi.h>
>>   #include "accommon.h"
>>   #include "actables.h"
>> @@ -14,6 +15,23 @@
>>   #define _COMPONENT          ACPI_TABLES
>>   ACPI_MODULE_NAME("tbinstal")
>>
>> +void
>> +acpi_tb_reserve_standard_table(acpi_physical_address address,
>> +               struct acpi_table_header *header)
>> +{
>> +    struct acpi_table_header local_header;
>> +
>> +    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
>> +        (ACPI_VALIDATE_RSDP_SIG(header->signature))) {
>> +        return;
>> +    }
>> +    /* Standard ACPI table with full common header */
>> +
>> +    memcpy(&local_header, header, sizeof(struct acpi_table_header));
>> +
>> +    memblock_reserve(address, PAGE_ALIGN(local_header.length));
>> +}
>> +
>>   /*******************************************************************************
>>    *
>>    * FUNCTION:    acpi_tb_install_table_with_override
>> @@ -58,6 +76,9 @@
>>                         new_table_desc->flags,
>>                         new_table_desc->pointer);
>>
>> +    acpi_tb_reserve_standard_table(new_table_desc->address,
>> +                   new_table_desc->pointer);
>> +
>>       acpi_tb_print_table_header(new_table_desc->address,
>>                      new_table_desc->pointer);
>>
>> There should be no harm in doing the memblock_reserve() for all the standard
>> tables, right?
> It should be ok to memblock_reserve() all the tables very early as long as
> we don't run out of static entries in memblock.reserved.
>
> We just need to make sure the tables are reserved before memblock
> allocations are possible, so we'd still need to move acpi_table_init() in
> x86::setup_arch() before e820__memblock_setup().
> Not sure how early ACPI is initialized on arm64.

Thanks Mike. Will try to move the memblock_reserves() before 
e820__memblock_setup().

George
>   
>> Ran 10 boots with the above without failure.
>>
>> George

