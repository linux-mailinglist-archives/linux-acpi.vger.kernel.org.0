Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1FC3479F0
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 14:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhCXNuj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 09:50:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhCXNuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 09:50:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ODmo0T062078;
        Wed, 24 Mar 2021 13:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ew5rMYfIAd8SV6Ve5pweKkfGX6Lpv0bHrLvAL9s6dSc=;
 b=jHlltT1rHwfZzUnAJFBXWhuhM9hqxoCwW8M/IyQAfFpYrrLiC5XaA93GJAHfHC9WEZYW
 LH8KFqovlngDh7NNpUpcKbinNwrAyMfiZWRfS4z27YYDm8fIojy6rI4jZKsWFAsoVQFf
 RI/4IrdE2GQzj+cfhrvBaBfb8egUSuLf8Uxl4Hjgt76FVPa3+61s90Rxe7mLjFpIEjs6
 g0JH5Uy7gAhEcBESiGVpe1FiopepQNtUWMIo7KO64yBoL7Z69KczVT6uqJaL9g1ukgN/
 AtZBekDWUjgU7q0L8bO3ZolUfRqQLbGG+J9abc2XrEdiVyvjLkmSFYzfzvD5Vfx+Y/b1 rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8frat0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 13:49:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ODfIBd073934;
        Wed, 24 Mar 2021 13:49:45 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3030.oracle.com with ESMTP id 37dtmqunqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 13:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLuNaITlnNeqKSDWa+vyXKLr6a0TJhDhuO6bnZZRMLZCg8PYvDp5QpLep7BeYun4Qk0AKzRnN8b+GcfkhLGcHZedJGpN964R8FNMNjSqiHVwZY1Yl9F6yzVlUSZfAlLW+3X8k4mowaK58PomOzr6NTkMcI6Cl7N4jEhWOcrHf5cvQCuzaA8GjI2PedFt+xmPpQWaypAtyqQd1TO+Kp+L04d+xuryWuEhM/VfCm0PPZ3YkaypigrfceuI1ya7gQUdZfoSnmMcRUhAR3Yo5i20gFha3JLf1P7SGtTiNsEmGWLiUpViuofrm2T50Bisc6IDHAPMgxTQ0PnTsPqy/n6xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew5rMYfIAd8SV6Ve5pweKkfGX6Lpv0bHrLvAL9s6dSc=;
 b=DUXKLRufoPHKw4XQ8D4SS/XMi6ofsyYdSOe/BjIyJM6HppROMl/JAD3JYG3JWWtiAyAaEhwGexo3ySmjBESrsE4px841GSN5pX93rt5ilCJ7FLh1/lPwMTvljvMC+zJGHMlpvh2BZiliEEJvUkEwrkVqMSOyCE4Jwe7qrheXgBq99ONjmcpoi0WIOT4VNGEfmmBrY9YhM4XRZsiiOZMue2JNz1tcfmGvuupEXPbDpl5TBdN+3tc0tahmb091bDnbRqckjcRiemSp0ALXGqbP9GeNPR6MJ5JWAiiDbt1KhTeLTPSYUDWPN9SS/ck6WTudaWQdvd5MrH5qXv1zSqGPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew5rMYfIAd8SV6Ve5pweKkfGX6Lpv0bHrLvAL9s6dSc=;
 b=b9u4+tmCI6lRQ8jqZARYdTQE/WUGQ3aIqQjDV6819o2YAtsal1bSSJKLaOdiGaPVFYiNnaPA8R6waR+zZQibZvpt2Onhl5CJF5fy09RhPPAPZJIA0FB330Wdg6Dzur1AXHNvWRfZvKgkR2suTw0uN2nCrQkba4XCupfDknk2uLc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR1001MB2313.namprd10.prod.outlook.com (2603:10b6:4:2c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 13:49:43 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 13:49:43 +0000
Subject: Re: [PATCH] ACPI: tables: x86: Reserve memory occupied by ACPI tables
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        x86 Maintainers <x86@kernel.org>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
 <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher> <YFMAdIVn2hpTHfBq@linux.ibm.com>
 <CAJZ5v0g_y3X2Ps+ipBg702Q_RR3cm4gKBJoPqjazHXaisKGc4g@mail.gmail.com>
 <CAJZ5v0iump7nVKfyu7S23-n=gQFx5d2MKejrnT6yFak7L9V11g@mail.gmail.com>
 <YFWxbzN92XcXNl95@linux.ibm.com> <4650320.31r3eYUQgx@kreacher>
 <YFr3KMhW0ajHzeH4@linux.ibm.com>
 <CAJZ5v0gWWGx8dvtz2pnXcCoxz_Aswo8Yxp=vo-z=jYX1OzC3=Q@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <80dc595a-235e-ff9b-a564-6731186b19f5@oracle.com>
Date:   Wed, 24 Mar 2021 09:49:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAJZ5v0gWWGx8dvtz2pnXcCoxz_Aswo8Yxp=vo-z=jYX1OzC3=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: CH2PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:4e::23) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.26.147.230) by CH2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:4e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 13:49:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f674c124-ae8c-49e3-5299-08d8eecbad49
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2313E31258BB579C2255F71CE6639@DM5PR1001MB2313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2Lcw3MeSCjsDjB0s5607WhkA2sfQFTHEfPAi0p/ZZYWrn5qhhyHHNTZatq+fTctmcDGqQvQ/KSg4w69Q2DuyihkjR4jLVCZdc+pn9e4hXCHxKCIcms6jz5RUe73Df18wuTbmjOpv4DZGEEcOXq/CyBWvOdWiKGJOok00EIYceA6Rj7XS7YTdf2kCAqgqqzev6909mMj+/sylb9xChJ+z3GBxpfW/tJ/JQFhKyUxwe6nYDBja0cLpDNknuHj6Bnvi9KSNq/FKBHztm9NIUscN0pcJNRLMvRsIsjXzNsrhlYow+kBQo4XRcZC8dk2h/NHSSHycmehOQHG6sXJtBSeTColnKz/r3QeJ0IGt7xy+9EW63tBBesE0Fr4g+2ffSGzFZoExQI0bCR+IkxlpSiWU34DySfJM2awwgT0You0b6m6cOInmMWVg8zOIKLw0YJLZpXdxJntCslY6zeMXwTKVtFc3PdC5XW1KQUufhtIaO94xWe4+bggET1vkV16Nvlj1u8k+eZXATd/5hFk8HAeVhASHUJrEsDKqvZ1yylFphicUYZWFYCfvClI2zZkM27Tlf4yRTP93aVPWTQfDUySWW0d/wYQw/f/atHtisebeKomBZH+etihEKTUaQv/OYZY2cTOqQVscjAP+6SftAzGz2eQfoL6CUiVrRP8Pe7WmH5olwK8pDuY6j6ZacGblTb0zHowWeH0V2PAays0Qu+0/4aOAEaBRe4f8IeF4Oelvm4/hX1cZ7touBio1tLQK+7DBz6PUNFSpoa26e6EPl1XSt7Fj8IusDsl5A/HRYgRxHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(186003)(36756003)(6486002)(66556008)(66476007)(83380400001)(478600001)(36916002)(7416002)(16576012)(86362001)(66946007)(316002)(54906003)(966005)(110136005)(5660300002)(31696002)(16526019)(26005)(44832011)(2906002)(2616005)(53546011)(4326008)(38100700001)(31686004)(8676002)(8936002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWNFTFg3YlJXdHpjTUc3cWdhOFBHMEVPU1ZyR1JSNllVcFJCNkhwQWJ0ZHdw?=
 =?utf-8?B?T0ZjY09walE2TTR6dndycHlrMlBpNVRWV3h5VnBpVWJMWlczUXJJVHpvbER4?=
 =?utf-8?B?U1d1dGJscDVuUmlza2Rnc1hsVW8rejM1WVlwNno1TW02L0JJY042M2NjN2N0?=
 =?utf-8?B?TzZyV1V4dm42ZVk2Vll3anJDS2srYVlGOW9WR0lnb0pzSmlVRVEwS0t0ZjI5?=
 =?utf-8?B?cHpxVzlRay91Q3VzMkZXakZSMndEUW1mRVA4VzQ5ZUs1SXN2MEtqK3RHWWR5?=
 =?utf-8?B?dWRoaXlEUkVKZkhsbG1ma2pQN2NIUmU5ZS84eGxxYWJieDFkeWRLYjJWbnZk?=
 =?utf-8?B?SEsxNVpEeDUrRlJDelRzV2RyQzdxOSt4SVFyTlg4WmdmWE1tbVVta3c4bzBr?=
 =?utf-8?B?S2cvakVCYktka0JKbUFRTngyaUdlYytWOElnNHpvanFKaG1Zemp5NkVQb3NG?=
 =?utf-8?B?dTZSUGFYbmxVSnhSVDJzK3JsK2h4Zkg2L2VxUTZhU0wwT1VJbzR5UHRUemly?=
 =?utf-8?B?TXV5T2s1NVRVMHVWWEk4U0E1aW9qdW1RcnIzb3RzUXBKWmlaTlNvK3ZxMUY5?=
 =?utf-8?B?OG4vSStWVitWdkJaUzd4ZHpXWXV5YnBGc0ZiYllIeTNFc0EvQ2lNSDY3ZVFl?=
 =?utf-8?B?dzRxQ2k2K09Lb3NLa1R0UXo4ejA4K3ZxQUppYytjQndPUWxIa0oxbDJJdFpD?=
 =?utf-8?B?VjBsejcrQUkrbmg1YXN6U0sxaUtXNjVzQzR4WkNCOVlDZU5vc2pLMDRBNHpr?=
 =?utf-8?B?eWcvblhPd3BJK1hqcUdjUWp6YVFUeXNBZ0hKTlVnMk1sRU1sWTg3VDJuMFVS?=
 =?utf-8?B?QXFBdUpEZXptM2Y0K29VZnZWRWc1aDZ1N1RIR3dtVmhxZ09YRUVEWkJHdEJY?=
 =?utf-8?B?NnU0S0I4TEdOS3FJeXpDeVAvVEFlOGQvSWw1ZzlwdHc4eVVIT3RnalJaRW1D?=
 =?utf-8?B?MWlEenhLUkM2Y29ObkFPNEgvckFLUEJ3N3ZERjdXaVpCSjNmcW9zUnhSWm1C?=
 =?utf-8?B?d0pTTU5wZGpLSEtBVlBSVTd6RTM3L09lLzdxbktXVmZvcEc5OTREaHpJS3U3?=
 =?utf-8?B?QU80NTJDbnRNdlBaVEQybWhXbXJZcE0rb1cvam9MNEl2TW1McnB2c0NJMnlT?=
 =?utf-8?B?cHZyd0VjcSs1d3gxbzFhdUpOZGFLSnNGWE1UN0V2aXlZdFFOUzZyUlJHRkx5?=
 =?utf-8?B?OERhQzRreWlzdGpXMlc5dEkwUmV1dEkxRzVEVEpna3FMczErT0owZmdJTEJQ?=
 =?utf-8?B?clg2Z016UTNrV1dHYXRGSDV6N0tPRkdGMitFdVFSWGVOY3czL0tDaGZ4bU9T?=
 =?utf-8?B?c0dzekZtK3A4Q2VLems5b2h5UGxCR2tpNHROYml6WXBNNk93anpiZ3ZuSjVp?=
 =?utf-8?B?MGt5RnQ5OHB0bEQzN25rN201MTVEY3Fsd0pJR0xOY1A3Uzk5OEpDbGd0NWM1?=
 =?utf-8?B?STlJVDFDMHNKVTJvanJUeGUveStqK2NGK2JsblhHbDVWM00zd1NjOGxONU5H?=
 =?utf-8?B?OUgyamR6MWFmQXBDWnVCdXBzYzl3eGZ4bkQ1dFBBRXA4M2ZnbVhmdXJ6d0t6?=
 =?utf-8?B?RmxROGlFQzFvT2M3bmwxM3I3d1BOMTdjdFBOc3JRTFI4ZGxEYVZmR0hQM2dR?=
 =?utf-8?B?Wmx0UUlGZWZMSkEwajVOYkhjTWtMVGQySnVHUFB0ODlibVBXMEtpcmVRUHV4?=
 =?utf-8?B?czVDWEpWMDBxSi9EYks4RWM4b2JxVG9aM0F4Tm1yZDN3ZUVPazUrbHlrdG0r?=
 =?utf-8?Q?RpUizBjM8OflzquMZ6Qx7Icwg9iJhjujn1Hz1gZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f674c124-ae8c-49e3-5299-08d8eecbad49
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 13:49:42.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5l0YQp5h9169ujdY0svUiNiqjFNVGwGjqnworG0wT8iPOEg3GiFgZ6gxNzwBumihgehZbLaRQLgS2I18KR0MUsOKoW1UTxGwDoV42ULf3FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2313
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240104
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240105
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/24/2021 9:27 AM, Rafael J. Wysocki wrote:
> On Wed, Mar 24, 2021 at 9:24 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>> On Tue, Mar 23, 2021 at 08:26:52PM +0100, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The following problem has been reported by George Kennedy:
>>>
>>>   Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
>>>   in __free_pages_core()") the following use after free occurs
>>>   intermittently when ACPI tables are accessed.
>>>
>>>   BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
>>>   Read of size 4 at addr ffff8880be453004 by task swapper/0/1
>>>   CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
>>>   Call Trace:
>>>    dump_stack+0xf6/0x158
>>>    print_address_description.constprop.9+0x41/0x60
>>>    kasan_report.cold.14+0x7b/0xd4
>>>    __asan_report_load_n_noabort+0xf/0x20
>>>    ibft_init+0x134/0xc49
>>>    do_one_initcall+0xc4/0x3e0
>>>    kernel_init_freeable+0x5af/0x66b
>>>    kernel_init+0x16/0x1d0
>>>    ret_from_fork+0x22/0x30
>>>
>>>   ACPI tables mapped via kmap() do not have their mapped pages
>>>   reserved and the pages can be "stolen" by the buddy allocator.
>>>
>>> Apparently, on the affected system, the ACPI table in question is
>>> not located in "reserved" memory, like ACPI NVS or ACPI Data, that
>>> will not be used by the buddy allocator, so the memory occupied by
>>> that table has to be explicitly reserved to prevent the buddy
>>> allocator from using it.
>>>
>>> In order to address this problem, rearrange the initialization of the
>>> ACPI tables on x86 to locate the initial tables earlier and reserve
>>> the memory occupied by them.
>>>
>>> The other architectures using ACPI should not be affected by this
>>> change.
>>>
>>> Link: https://lore.kernel.org/linux-acpi/1614802160-29362-1-git-send-email-george.kennedy@oracle.com/
>>> Reported-by: George Kennedy <george.kennedy@oracle.com>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> FWIW:
>> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> Thank you!
>
> George, can you please try this patch on the affected system?

Will do.

George
>
>>> ---
>>>   arch/x86/kernel/acpi/boot.c |   25 ++++++++++++-------------
>>>   arch/x86/kernel/setup.c     |    8 +++-----
>>>   drivers/acpi/tables.c       |   42 +++++++++++++++++++++++++++++++++++++++---
>>>   include/linux/acpi.h        |    9 ++++++++-
>>>   4 files changed, 62 insertions(+), 22 deletions(-)
>>>
>>> Index: linux-pm/arch/x86/kernel/acpi/boot.c
>>> ===================================================================
>>> --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
>>> +++ linux-pm/arch/x86/kernel/acpi/boot.c
>>> @@ -1554,10 +1554,18 @@ void __init acpi_boot_table_init(void)
>>>        /*
>>>         * Initialize the ACPI boot-time table parser.
>>>         */
>>> -     if (acpi_table_init()) {
>>> +     if (acpi_locate_initial_tables())
>>>                disable_acpi();
>>> -             return;
>>> -     }
>>> +     else
>>> +             acpi_reserve_initial_tables();
>>> +}
>>> +
>>> +int __init early_acpi_boot_init(void)
>>> +{
>>> +     if (acpi_disabled)
>>> +             return 1;
>>> +
>>> +     acpi_table_init_complete();
>>>
>>>        acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>>>
>>> @@ -1570,18 +1578,9 @@ void __init acpi_boot_table_init(void)
>>>                } else {
>>>                        printk(KERN_WARNING PREFIX "Disabling ACPI support\n");
>>>                        disable_acpi();
>>> -                     return;
>>> +                     return 1;
>>>                }
>>>        }
>>> -}
>>> -
>>> -int __init early_acpi_boot_init(void)
>>> -{
>>> -     /*
>>> -      * If acpi_disabled, bail out
>>> -      */
>>> -     if (acpi_disabled)
>>> -             return 1;
>>>
>>>        /*
>>>         * Process the Multiple APIC Description Table (MADT), if present
>>> Index: linux-pm/arch/x86/kernel/setup.c
>>> ===================================================================
>>> --- linux-pm.orig/arch/x86/kernel/setup.c
>>> +++ linux-pm/arch/x86/kernel/setup.c
>>> @@ -1045,6 +1045,9 @@ void __init setup_arch(char **cmdline_p)
>>>
>>>        cleanup_highmap();
>>>
>>> +     /* Look for ACPI tables and reserve memory occupied by them. */
>>> +     acpi_boot_table_init();
>>> +
>>>        memblock_set_current_limit(ISA_END_ADDRESS);
>>>        e820__memblock_setup();
>>>
>>> @@ -1136,11 +1139,6 @@ void __init setup_arch(char **cmdline_p)
>>>
>>>        early_platform_quirks();
>>>
>>> -     /*
>>> -      * Parse the ACPI tables for possible boot-time SMP configuration.
>>> -      */
>>> -     acpi_boot_table_init();
>>> -
>>>        early_acpi_boot_init();
>>>
>>>        initmem_init();
>>> Index: linux-pm/include/linux/acpi.h
>>> ===================================================================
>>> --- linux-pm.orig/include/linux/acpi.h
>>> +++ linux-pm/include/linux/acpi.h
>>> @@ -222,10 +222,14 @@ void __iomem *__acpi_map_table(unsigned
>>>   void __acpi_unmap_table(void __iomem *map, unsigned long size);
>>>   int early_acpi_boot_init(void);
>>>   int acpi_boot_init (void);
>>> +void acpi_boot_table_prepare (void);
>>>   void acpi_boot_table_init (void);
>>>   int acpi_mps_check (void);
>>>   int acpi_numa_init (void);
>>>
>>> +int acpi_locate_initial_tables (void);
>>> +void acpi_reserve_initial_tables (void);
>>> +void acpi_table_init_complete (void);
>>>   int acpi_table_init (void);
>>>   int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>>>   int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>>> @@ -814,9 +818,12 @@ static inline int acpi_boot_init(void)
>>>        return 0;
>>>   }
>>>
>>> +static inline void acpi_boot_table_prepare(void)
>>> +{
>>> +}
>>> +
>>>   static inline void acpi_boot_table_init(void)
>>>   {
>>> -     return;
>>>   }
>>>
>>>   static inline int acpi_mps_check(void)
>>> Index: linux-pm/drivers/acpi/tables.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/tables.c
>>> +++ linux-pm/drivers/acpi/tables.c
>>> @@ -780,7 +780,7 @@ acpi_status acpi_os_table_override(struc
>>>   }
>>>
>>>   /*
>>> - * acpi_table_init()
>>> + * acpi_locate_initial_tables()
>>>    *
>>>    * find RSDP, find and checksum SDT/XSDT.
>>>    * checksum all tables, print SDT/XSDT
>>> @@ -788,7 +788,7 @@ acpi_status acpi_os_table_override(struc
>>>    * result: sdt_entry[] is initialized
>>>    */
>>>
>>> -int __init acpi_table_init(void)
>>> +int __init acpi_locate_initial_tables(void)
>>>   {
>>>        acpi_status status;
>>>
>>> @@ -803,9 +803,45 @@ int __init acpi_table_init(void)
>>>        status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
>>>        if (ACPI_FAILURE(status))
>>>                return -EINVAL;
>>> -     acpi_table_initrd_scan();
>>>
>>> +     return 0;
>>> +}
>>> +
>>> +void __init acpi_reserve_initial_tables(void)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = 0; i < ACPI_MAX_TABLES; i++) {
>>> +             struct acpi_table_desc *table_desc = &initial_tables[i];
>>> +             u64 start = table_desc->address;
>>> +             u64 size = table_desc->length;
>>> +
>>> +             if (!start || !size)
>>> +                     break;
>>> +
>>> +             pr_info("Reserving %4s table memory at [mem 0x%llx-0x%llx]\n",
>>> +                     table_desc->signature.ascii, start, start + size - 1);
>>> +
>>> +             memblock_reserve(start, size);
>>> +     }
>>> +}
>>> +
>>> +void __init acpi_table_init_complete(void)
>>> +{
>>> +     acpi_table_initrd_scan();
>>>        check_multiple_madt();
>>> +}
>>> +
>>> +int __init acpi_table_init(void)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = acpi_locate_initial_tables();
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     acpi_table_init_complete();
>>> +
>>>        return 0;
>>>   }
>>>
>>>
>>>
>>>
>> --
>> Sincerely yours,
>> Mike.

