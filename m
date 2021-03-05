Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD232EEBD
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCEPYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 10:24:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCEPYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 10:24:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125FF0lm022707;
        Fri, 5 Mar 2021 15:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ceFLbjYzyX8vnoTvSi/6L7jQcb8taQ89mhVYkdF6/D4=;
 b=EoHa6wLaH/H8xT0VpulHyEUtLkXDYdVPKbhfsjHU/siHuq5qcMEGb8dJbkegTSbH3IVm
 DIixUqPaFUECssqrvhl910zoJWQNBORqthxPzkJldADEZF9VbGY9BJzlye1l990ZwD2M
 sm3FAKEhluyucdJwPT4HUFTywMVV7G9QNuPP66s8MpWYLwTRW3qLtDkCPJt+MkZIJ1Zz
 YHzAD2yBRygcYP3GFxsc35f5vnM/dF68oJS2q7pMMExv1ilqUq6YGNO+8m2FXWxU4U8t
 HuEMmRIUEuIgXg7TsZE/i8SSja6NxE4CYYKR2TKWFtsnApjYHdblpA/IzOzCtMg2Q8dI jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36yeqnas96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 15:24:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125FFCiM055365;
        Fri, 5 Mar 2021 15:24:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3030.oracle.com with ESMTP id 36yyntc36w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 15:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SajJ7KrNfXMr0BDSCAQ3n4GP2wqujm35Pk+JyjEwg2qcYxsCVyaRKQKpLMnR15IG+3OxCMyQIGUN+SoPUbDLPrPxSwJgGmtlDxzS+mxYAZbR6mpOFO63j9taPKgoKEr5zRyUOeckUvzLO8ovbvYrSiASS5Akn5j2VKrLtGiDmnxWMwrEWgVJMP995uwzL/WQbP6WUDAeAIiOUeHQSXqzxsYzN/z2Q6MSadaGqMxF4Wprqa0dYiRoY8F76aanObGCTuF+8g9X4WawpU/YArQuaqgR9Ffb7QeFvzTFF+BD6jMQ9OUuCHMZV3/VNxQKCQ7Hazm/At4crpMdmKLD4vdxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceFLbjYzyX8vnoTvSi/6L7jQcb8taQ89mhVYkdF6/D4=;
 b=F6VoKyZNIM5X1hemCZIxjpVqoc1WRpYi9TNKRaEVnYU/q1U2JF1fge9CHcaAWjbzbU8B140fRU2tVBNIL7zbvtdxzujwV3UKZPIPl5xv59HEhRgv7bsxBF0ePksplQKU5L9l4MC4EuxC3wZLuNwLhFUfKczO0RQyyb7BTC63TrVyACuIEVIJDgwryqxXaVYil+0cvQ/i0trpiX0nwUk4YYE2SOQh0jziJb76EDfp7Z49FORwdos9RImkxT4DnLNAul+fCyGwDloCWzyUKfBqffZzgLwwp6BMiyp9UfeevLJP1dD70vp+tRiQQ1yCywrYdzebV0Jb2+280U5ziV7+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceFLbjYzyX8vnoTvSi/6L7jQcb8taQ89mhVYkdF6/D4=;
 b=IJrPedMRAbVe53iM6fnsRcZJSMDnlqj+Kxn7xo+Fvv/insGFb4pN29AagHqDUqyor5BKzxZJceQ0cbGPW7eVddYT7HPbQF2KKJKfe0MHG3ZFcGgbFHJcazkceOvzAb0LPdM/HhYyEG33Qbro3+aRmP7n2ILeb3o3ILdnhR8CrcU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 5 Mar
 2021 15:24:19 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 15:24:19 +0000
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
 <CAJZ5v0j8udd0R6A1wwpNvZL5Dr1pRcdiZr2if5y50o7OkHOMqg@mail.gmail.com>
 <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <805b73d7-d604-3765-9c23-3a2af5571351@oracle.com>
Date:   Fri, 5 Mar 2021 10:24:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <1ae44491-4404-6873-4ee6-6cf58c1ae6fb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: CY1PR07CA0010.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::20) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.26.147.230) by CY1PR07CA0010.namprd07.prod.outlook.com (2a01:111:e400:c60a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 15:24:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fb3d78-a724-47e4-5804-08d8dfeabee9
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB43139D5D53A3B31BE29D5E80E6969@DM6PR10MB4313.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tCmWyIIehvfcsVH45ZeDNlhKl5GswyFv/oN6gnBhlHrBIDSOPnbQ5vzaj314ZAAcfDbLC4IG0Ad4AVKvwvwAUsCjK2X7JSiOyhekp0MWBuVfy0cJlQULhAtvEqU6fkFozdQqpEiJLn0LgHTdLoswVbSLjakkm8L5+oTzwq/w9g0DrCapCPoaTlZXNNXcXFkyWEd7rtPQvpr0bSAORiUwVQmyEWYtHkTG4EABSISLySrMKjcUomWDcvnt+j8zKHzmtkW6KBiTj31mhAfMMZc6178b/ty2ykjUDi15YErVpjAqv/fCQ3qrxPiJrKC1G+qpH+EUJGliDkKgfaCX0YmMiaI0XXNlhk/M1lNSE0vLAkofaZpyifmEJLIRSqLtwHbAKbEch9WURhajMBcLTv1ZGBPxexLVGh+boDTZm6PJL90rSJDYolv4ky+mSujjwVDozEIXlGt1TVZ2ox57+74Ol8g+GIMshtz3pLhgGPu9iOTG43qMs16Xd5WOLIgXAq2xSFO1pxbeVXK7l/QiujjUiFNTkpV1aKt2LgH0ZKhe+1lZv/GaSTswxtI/A3NffiFOHCDE8P604VicyqR34Ipt4LoOAEO6ZJ+OSvknrCBjX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(66556008)(478600001)(16526019)(7416002)(186003)(31696002)(2906002)(83380400001)(8676002)(26005)(6486002)(8936002)(316002)(110136005)(54906003)(66476007)(66946007)(16576012)(36916002)(6666004)(31686004)(4326008)(2616005)(5660300002)(956004)(53546011)(86362001)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RGo2RW1PMEc2RytYemJyaWhQaTdseUFqaTVNbG0wMkpFL213UnUvdDB2OFhP?=
 =?utf-8?B?c1VuNVB2WDdwK09DQ3A5Wkdoak04YkY2VDdod2pVVEdpaE83M2J6VDhGUEx6?=
 =?utf-8?B?Z1BWVWs5Z3YvNUpac0VZNy9hYjNkUVZJNVN1bEhSV3VWSndLajlHMTBpZU42?=
 =?utf-8?B?MXI3SFpKeFpLVW1lTlh5czM3V0N5TDlBelA0ZUpuN3ZvbytSejFzdmdtWVlu?=
 =?utf-8?B?eXFhK2FDS282em1ZaFNxaTNnbE5MTmdtRG5peEJ0MytKZ0kzWlRsc0hRRGND?=
 =?utf-8?B?d1hZT3NVS2VIdjNiOWRWQVNFOEcxRWY0SG1acE4weXB6S2hHOUxoMW11THhx?=
 =?utf-8?B?cnMwMG9XVTBPeU9DclVWNFRQSFdSVzhIL2tmeDRnbnZCeXdFUVRnVitNb1Vi?=
 =?utf-8?B?VlVubXRVWUhJaVZZSUxkSUlsOVZSeTAzS25sbWlhWlZOQzdMUzd5MWJuOFBy?=
 =?utf-8?B?OEk2bk5UMnkzdWQyWXpYME1jVno5NXVzMDkyWjl4c25icVJ6M09YOEErYTBn?=
 =?utf-8?B?S3J6WWk0VG41a0p4Qk5xbDB0dGFMeEdPUXRCMXVzaWxDVDJDdWFwaDFGZlBS?=
 =?utf-8?B?VmhqQUJxbEozOE1RNDlVT25wdTBWL3Fqc0tISmppVTRMVktqMWlnR2E2c2JN?=
 =?utf-8?B?S1FTSEZLOFpQWWpoMTVSQy83dmxVcHVTMkpQUDFTWGpCdFhmSEZVYythWE9k?=
 =?utf-8?B?Wjk3UUp4WUVOYkJZYy9abC9uUUtFY21IRGVnZWdocDZtb2VLRHZUOFlGQ0RH?=
 =?utf-8?B?WjlkN1FuMWRSbEhIaGdrQW9LZUQ1RGFNOURJck9WTVBHSERVSkN6NDJ1Q3E4?=
 =?utf-8?B?VmVabEJkemxZQmhqNFRRekJGMU9Va3Q2RmdWNnRTeVo4UXZXaDUzWllLemk4?=
 =?utf-8?B?QlZiUFJKZTdTcWVlaVg1WDJOZ2pYb09vY2xjdW9veVdCbEpzMUZCMEFDa3Bm?=
 =?utf-8?B?YWlCQ09NQnhzOTFySERVcTJObmpCMzVuMkF3eFdTV2ZtbG9PQ3JORlBmcm83?=
 =?utf-8?B?TmdyODQvUzRoYU9yVldwZ0xUallTUlo5SmhDalJPb0VuQm5pWG54YzhwMnFt?=
 =?utf-8?B?RFhuZXIxa1FQUytyaE1YaE1UbDNnYkYyQmJYQW42eDZGQWdlSllmOEI0UFZ4?=
 =?utf-8?B?YXhDTFZIL0RvRUw3YVFmU2cyNEhLbnVDTFBqR3J4dTZuK0hOamQrNUNUb0k2?=
 =?utf-8?B?NXlzYldRb05GVDIzZC9QNmZZM0lGbmtVOTRGRHphd0owcWpTa2JaVU5UcWdS?=
 =?utf-8?B?U2poVy9VREhsVEZYYldiWGNBdGpWMDVUZ0I1Ym95Tm9HSWJ5MTIxdkRqbG9U?=
 =?utf-8?B?UjFBUytrbUlHTjFtaUk0SlVER2tTczhPZERtUVpneEJwMDl1cHJocEJJbFZH?=
 =?utf-8?B?ZHUzRnpQQTBOTytpdXBmTXBZNkxIRmMrN013Vm80S0JXS3pwcHVlNzJLU2Yw?=
 =?utf-8?B?L2lJdExOT1pWa2JoRllWS0IrcDRaby9oa3JobExzWHZPY1kyRlI5K2FneXhQ?=
 =?utf-8?B?UU1kc2RNTGI0cHZqbjI2Q3V1R0NLR2F3Ynp2eTZsWDM0SHhORHAxV1l6QVJF?=
 =?utf-8?B?eHJCMXVHZ3dPOGVvZUV4dDBZTkxiU0JtcWVhSzY2dzZJMzlFL0pRTURLZVhP?=
 =?utf-8?B?dFg3WGRsQVRaVC9IL1lMTFZGdnR1MlhYWXNYeFZhNm1DUkZ5NW4vWFpEbWhV?=
 =?utf-8?B?RThvQlE4b2lrbWdzQWZtaGt0UW5abHBPcUJmeXlUS0s0d2F6aGpiblQ5cDBN?=
 =?utf-8?Q?vJ0oilq4Tb7NPuZrNkGZxI+Ne6tLAe42voM2orG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fb3d78-a724-47e4-5804-08d8dfeabee9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:24:19.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/9lEWoCQPvXRoK4LlcbfsTBKtrHNvEdOaVHU7kjAqxBXK5yCIvtGNdgpcoxIccivJs98W2yW+2ustWHYUjNttFI6rG4tHTmWHY7b5uYrAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4313
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050078
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9914 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050078
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/5/2021 8:40 AM, David Hildenbrand wrote:
>>> The ibft table, for example, is mapped in via acpi_map() and kmap(). 
>>> The
>>> page for the ibft table is not reserved, so it can end up on the 
>>> freelist.
>>
>> You appear to be saying that it is not sufficient to kmap() a page in
>> order to use it safely.  It is also necessary to reserve it upfront,
>> for example with the help of memblock_reserve().  Is that correct?  If
>> so, is there an alternative way to reserve a page frame?
>
> If the memory is indicated by the BIOS/firmware as valid memory 
> (!reserved) but contains actual tables that have to remain untouched 
> what happens is:
>
> 1) Memblock thinks the memory should be given to the buddy, because it
>    is valid memory and was not reserved by anyone (i.e., the bios, early
>    allocations).
>
> 2) Memblock will expose the pages to the buddy, adding them to the free
>    page list.
>
> 3) Anybody can allocate them, e.g., via alloc_pages().
>
> The root issue is that pages that should not get exposed to the buddy 
> as free pages get exposed to the buddy as free pages. We have to teach 
> memblock that these pages are not actually to be used, but instead, 
> area reserved.
>
>>
>>>>
>>>>> Use memblock_reserve() to reserve all the ACPI table pages.
>>>> How is this going to help?
>>> If the ibft table page is not reserved, it will end up on the freelist
>>> and potentially be allocated before ibft_init() is called.
>>>
>>> I believe this is the call that causes the ibft table page (in this 
>>> case
>>> pfn=0xbe453) to end up on the freelist:
>>>
>>> memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000,
>>> zone_end_pfn=100000
>>
>> David, is commit 7fef431be9c9 related to this and if so, then how?
>>
>
> Memory gets allocated and used in a different order, which seems to 
> have exposed (yet another) latent BUG. The same could be reproduced 
> via zone shuffling with a little luck.

Thank you David for the detailed problem description,
George

