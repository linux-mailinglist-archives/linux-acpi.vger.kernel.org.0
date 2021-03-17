Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610B633FB2A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Mar 2021 23:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCQW3I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Mar 2021 18:29:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36370 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCQW24 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2021 18:28:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HMOhT1003181;
        Wed, 17 Mar 2021 22:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=E6wIIws2Y6gTHE2anFMj6UHlSLjrmb/mNRwInMm9RfY=;
 b=S60XO6gT89Y82As/SCWP+ElskDekcCLMMS9gKlKWAy3Db8d67PVkSgGAuWdSYaCB+Xbo
 nDpHE19WszodyrIhdmtjJwSzDLy1H2QdwDbMN68x/x/NmHiiTlmRM6vdFYtdZCNIBhDF
 Rs7REhm5B39sUSKJCvK57hwTNsxUmItPQUq8xfoELNiMf/gYZ1Q2b3pqiM09oZmHBdVO
 H29DKdJbnVVGLSUx3spLbEdTsXh/INxOpL3w9YPLe3Pn0DRg+ccafMJ0KvupNTUqfrto
 b+EKROSkRCslxsXgYcRhHB6Pk9Ek78S7K9Xx8l+bPHIz2fnJ1cnBhlyUctZ9y2y3ws3y aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37a4ektn23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 22:28:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12HMPqA3056746;
        Wed, 17 Mar 2021 22:28:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by aserp3020.oracle.com with ESMTP id 3797a35awg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 22:28:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzCizPajrqX0W/ULvNmSw0vbVcYJqN+GWnsZER3zQuR+Zz+Z4nvLHQK0dz+1gyf0claT7eG0F84Bh4Cdt98jptZzPX0J30n6szZijAz06LOjNMyRn7k8ooxtmPQ4VSvGQMK6g/C2adydL1N6v83nvLllg5KuwliK5V4MHOIPsY0aSp/QBXdGxoKPsi7wM/opjwrpP6HS0FVEK/mf/JitHYDRLhPcV4viXumhGxgbcfSjKuazFhPWJsLUJMb9K44pUbFXy/a0YlLghEWKo82b1lqLyPGjkJLlkL+DbuQmcUEQa3C8QoFxBDMXbqPVxWJpTzZvlp2E2MP4encY9luarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6wIIws2Y6gTHE2anFMj6UHlSLjrmb/mNRwInMm9RfY=;
 b=AYJLlIt53do/mL8TWdlVO+9AM8L1T89Lug1NnFC2Q9+Ds3eYKQv2Pp/hluemTsZ2lfpUf2zIJnox8i5Lv8wz0b2T09sRWml9FSwkMx9v/TcqzoKq4hu9RdNBIQ+Vt5n8hdkN4YP3WIdn/AvUVZ68/OPWzBh0wnrPKrkJ+5vet+a69B4Qip3+VPUoxfzmrFYcHTvobuP0JXqGZixlWQJ2t/JUPxUAjcWElaEYh1JGtr7as6hM50/Wn3vCJkby2T2Iaa1l9akVii73v1W38Zn/RWST1/j9vlrKBuSYkQA48WGoflORTo62+rVhzGxI7CP8Xh3cegCCS/ySFdwEtqvCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6wIIws2Y6gTHE2anFMj6UHlSLjrmb/mNRwInMm9RfY=;
 b=wNAY7OPufqOmsVbtS7cRbLvkPsbl3jqOGU0ZTmbGcCr6Pxsm9D/FjTFx6tiK7nTd4OtWfnQX2CtihpK9Y9njwFRkBB4UNLJ/0Xq96og4JlEYmVDIUMcnSi3VA+gfYZbs61szZwMvXaMugNZarL4K++KbEzw5ardM7WiOG4imL94=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB5246.namprd10.prod.outlook.com (2603:10b6:5:3aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 22:28:30 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 22:28:30 +0000
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Robert Moore <robert.moore@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@suse.com>
References: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
 <YE5dJ6U3nPWsXY4D@linux.ibm.com>
 <CAJZ5v0g1H6hCVbAAFajhn0AYRMU4GkZOqggOB6LVdgFx_vfwOA@mail.gmail.com>
 <3236337.DtqTXxM43S@kreacher>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <bad1ea33-1a6e-bd4d-b795-fbc51ac6ecca@oracle.com>
Date:   Wed, 17 Mar 2021 18:28:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <3236337.DtqTXxM43S@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: CH0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:610:74::13) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.26.147.230) by CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 22:28:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b47b9004-3d62-4752-0ac0-08d8e993fd7e
X-MS-TrafficTypeDiagnostic: DS7PR10MB5246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB5246ECC2B78188C5D3DBA51DE66A9@DS7PR10MB5246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOKkt5EIekq/czX7bDJIeLvDT48Xt3OQmAWmx6zE/7dRBsB4nKeOClw/0QlvTj2zAv/97Y77AsxYStrzK7UHXblZ0tEcViqPMzJAKrmgLplriatBHDAkOzjljvDVEBkNA1mfaTPdgDqhcY/cx50wouJ4e7KEig1O5YISNdFrVZAuNEu83C7n1ezpmunziHkPMAwuHuWFP5v3K6oOPWwioVQUXaj7jxKyMF/5YN3dj4WENu6uWw7HXKJMNKaygBqrwE8WZL/zjo+CswgVlxOmQvwDhedUbYUc6EVEoSa9jN8FAEOKAkt9HVENXy/2e45RK7FfejzKO0G+Z18IY9RIApQk9ka/ISj+3WvCU+UodU99L55a5Acj0CKJAPySSNxYCKeM3FH3kfmBkmGM7EWUokdVde5uv4xlP9x4ZQxy0bIGdZx4aU0XdV/b6Ux+WZ4bYo5dQqFOUXPuiWuTMKCUa3tMu5iR3/MECepzxI/5FTMBx9rntw7IyraY9Tsgxr6FIhMCum16eWKLl1K+hpCIMjnZUHF0FdKxkdea7unVkK6x7AyDPXHC3l5JxIiEHKgptN7U1t6O70JJ1CLHD9//7ZETzc1J54ePIp/bBKcVD2EH105If9/IYfFwiHS4UDEIBoxcw2606vaH//81D8lHOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(39860400002)(346002)(956004)(110136005)(2906002)(54906003)(2616005)(53546011)(36916002)(86362001)(31696002)(5660300002)(16526019)(6486002)(66556008)(66946007)(66476007)(31686004)(83380400001)(7416002)(186003)(44832011)(4326008)(8936002)(36756003)(26005)(8676002)(316002)(478600001)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WW1iMlBDZHJkVm5nQVNRb3lLeHhuZmtpeDVwTlBhZWozUjlPREJnQU5oZitR?=
 =?utf-8?B?bzlVTWwzTWNKTkFidHRaM3NzRlhmckNxdDZtUjJNZEtMQzVJNkJXU3U0Zno4?=
 =?utf-8?B?WmZrVXRzK0hDWXo4ZktpLzRCS29QbG9xdDRtVXE2RGd0cC9QNGZjbkdoZk5x?=
 =?utf-8?B?d3ZRMi85TFVURk5WRkRHYXNUdTg2RUN0TFdmU2RUN3ZsYTFQbDI0d2RNaXFm?=
 =?utf-8?B?MVJKVE5vNHR6Uk96TjYzeWdmUmh5c1gwQ0hiRCtJOVFNbi9GRlUvM1RoMFFn?=
 =?utf-8?B?MHBXS2h0a3ZJODhUaXBNbzJ0d1d6SUVITkdNQUl0M2UzeTFuY09zL1JKTjdw?=
 =?utf-8?B?WURWK2gwMVA2bzZ2bWIvYXI3bFM4ajlaVitZak5hcFdLd3NEYWU4NnFzeG9H?=
 =?utf-8?B?RXlieWlOQXRLV3JseGxNNTVVRWRsbDlUUlRrbnhHYmtjMDZZOWwvN3QxOHpn?=
 =?utf-8?B?K3NVUkZnWDZTbDArdm1PMVRMakU4QmNRK1N5ZmlhTDllT1MvYXd6aEw3akVs?=
 =?utf-8?B?d25kQTFiRDFMT1RvcGVwZ2t6djArU1FpeGpGYmJGVTFVaWptTlRiZGh0Qzhj?=
 =?utf-8?B?Si92bTFmNGwxeFo2ZlZSTHNlOXR2YS9YdnRKZlk5N2JsUGZZSHd3M2VPZ0lF?=
 =?utf-8?B?Z2x3ZEFoQjRSMTJQd3lxUUdZMXk2bk5SUVRuY2dyR0g4YStMeGJrLzEwRld1?=
 =?utf-8?B?NlpkVEs2ODlMeVU4ZDZCbk55Sll1QnRZWFl0QmUvS2N2RnFZZ0g1QVJCQy9B?=
 =?utf-8?B?OGw4dnB3aFAyeHB3YnhramlJWnAvczllMm1nNVo4SEEwRVF4TWFRaytZN1Y4?=
 =?utf-8?B?N0hRTE9iaFRPVnBKNmRTNDJZV0w5dWxsQlpYbmZ1aGQ4SU9VdmFiRkltZWpn?=
 =?utf-8?B?eTZSMkNNd281VEEzNlQySkZ5c1VhNExCZVFvREpsWHBPZHZyaVMvUjFoYTZT?=
 =?utf-8?B?RzBicXhEaXhvWXlvZmVaSGZxRThteTd2czl5VUhVVmNsYlE4SWs2cE5LdUgv?=
 =?utf-8?B?TCs4S25MRHM2ck05Z2RCUmh1V2t1c09uVjJBSEd4VGx2d0tzNXJaUnJnSU1H?=
 =?utf-8?B?eCt4WlNueHh6aXlHTTVyWmpEUHdEaHd6Y0ZIdmY1aXNiTXV5SGhsMmNtSHQ1?=
 =?utf-8?B?VmR1TzJCR1JVdEN5WlBBSzFCcHd6Y3dVSTNhNE5PeHVXN1R6SE9pOHNveEV5?=
 =?utf-8?B?YlZrRXZHczdMYUE1MHFaTnlFdnBVREJ0d20zcUtBWll2d2ZKK1VCNTNuZyt1?=
 =?utf-8?B?MU5nWmRIWS9FYWY5SkxsQUdkQjVBR3VCTW1JWWhrUSs5UVB4T3JZeGpFcjU4?=
 =?utf-8?B?SEhxZThobGtYNTUweWI2cXFZSFQ4MGNkbkE2R1lkZ2pTQldEM2gyQjZSamh6?=
 =?utf-8?B?RFFvU2o1bStGR1dPU1BNRDR1czhlL0w1cEJ2Z2dTM3dQczN6Q1A5djk2QXo1?=
 =?utf-8?B?bExuR1ZQc3dlZ21hQlJxL3ROb0VpZkM0SUlsZ1VlTS9XRGd6ZGM3eXNJWmhv?=
 =?utf-8?B?UldjWUtCYVpDc0N2RGdDcUNFUk9yRTM3dmxlMFRnMnRzL2lZNEt2N2M3bEVj?=
 =?utf-8?B?VDlNUXhiVVhBeHpDaDdTTFNkU2xQTU83RWlEcWdxUHU3K2dwdVVYRmZBWkVv?=
 =?utf-8?B?ck9jN0doeDRnTjhURUVYYzBDMXdueUw5THRSNUpBNFE1N3NnUm5iK2R3VkxN?=
 =?utf-8?B?dGtEaVhtcldQM0tMcUlnUFBCcUZtdEZJRnFkenRkNmt4MXI5MjhHQzkrMmhw?=
 =?utf-8?Q?zDGFPXqk85IcLSKiYX7ataKe4TV7+Zkf4BFcXSM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47b9004-3d62-4752-0ac0-08d8e993fd7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 22:28:30.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEMlJJZ0lGBlGbAyJdRE+HE3aRYIk+jxXZA+y4wXWQOCkWOIpsAKGjW8AUO1cs2sdsTQBIBJVwjAv+M5uqtMRPV0YDRQvUsLQNhDeTtHYK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5246
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170157
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170157
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 3/17/2021 4:14 PM, Rafael J. Wysocki wrote:
> On Monday, March 15, 2021 5:19:29 PM CET Rafael J. Wysocki wrote:
>> On Sun, Mar 14, 2021 at 8:00 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>> On Thu, Mar 11, 2021 at 04:36:31PM +0100, Rafael J. Wysocki wrote:
>>>> On Wed, Mar 10, 2021 at 8:47 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>> There is some care that should be taken to make sure we get the order
>>>>>> right, but I don't see a fundamental issue here.
>>>> Me neither.
>>>>
>>>>>> If I understand correctly, Rafael's concern is about changing the parts of
>>>>>> ACPICA that should be OS agnostic, so I think we just need another place to
>>>>>> call memblock_reserve() rather than acpi_tb_install_table_with_override().
>>>> Something like this.
>>>>
>>>> There is also the problem that memblock_reserve() needs to be called
>>>> for all of the tables early enough, which will require some reordering
>>>> of the early init code.
>>>>
>>>>>> Since the reservation should be done early in x86::setup_arch() (and
>>>>>> probably in arm64::setup_arch()) we might just have a function that parses
>>>>>> table headers and reserves them, similarly to how we parse the tables
>>>>>> during KASLR setup.
>>>> Right.
>>> I've looked at it a bit more and we do something like the patch below that
>>> nearly duplicates acpi_tb_parse_root_table() which is not very nice.
>> It looks to me that the code need not be duplicated (see below).
>>
>>> Besides, reserving ACPI tables early and then calling acpi_table_init()
>>> (and acpi_tb_parse_root_table() again would mean doing the dance with
>>> early_memremap() twice for no good reason.
>> That'd be simply inefficient which is kind of acceptable to me to start with.
>>
>> And I changing the ACPICA code can be avoided at least initially, it
>> by itself would be a good enough reason.
>>
>>> I believe the most effective way to deal with this would be to have a
>>> function that does parsing, reservation and installs the tables supplied by
>>> the firmware which can be called really early and then another function
>>> that overrides tables if needed a some later point.
>> I agree that this should be the direction to go into.
> So maybe something like the patch below?

Do you want me to try it out in the failing setup?

George
>
> I'm not sure if acpi_boot_table_prepare() gets called early enough, though.
>
> Also this still may not play well with initrd-based table overrides. Erik, do
> you have any insights here?
>
> And ia64 needs to be updated too.
>
> ---
>   arch/x86/kernel/acpi/boot.c |   12 +++++++++---
>   arch/x86/kernel/setup.c     |    3 +++
>   drivers/acpi/tables.c       |   24 +++++++++++++++++++++---
>   include/linux/acpi.h        |    9 +++++++--
>   4 files changed, 40 insertions(+), 8 deletions(-)
>
> Index: linux-pm/arch/x86/kernel/acpi/boot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/acpi/boot.c
> +++ linux-pm/arch/x86/kernel/acpi/boot.c
> @@ -1541,7 +1541,7 @@ static const struct dmi_system_id acpi_d
>    *	...
>    */
>   
> -void __init acpi_boot_table_init(void)
> +void __init acpi_boot_table_prepare(void)
>   {
>   	dmi_check_system(acpi_dmi_table);
>   
> @@ -1554,10 +1554,16 @@ void __init acpi_boot_table_init(void)
>   	/*
>   	 * Initialize the ACPI boot-time table parser.
>   	 */
> -	if (acpi_table_init()) {
> +	if (acpi_table_prepare())
>   		disable_acpi();
> +}
> +
> +void __init acpi_boot_table_init(void)
> +{
> +	if (acpi_disabled)
>   		return;
> -	}
> +
> +	acpi_table_init();
>   
>   	acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>   
> Index: linux-pm/arch/x86/kernel/setup.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/setup.c
> +++ linux-pm/arch/x86/kernel/setup.c
> @@ -1070,6 +1070,9 @@ void __init setup_arch(char **cmdline_p)
>   	/* preallocate 4k for mptable mpc */
>   	e820__memblock_alloc_reserved_mpc_new();
>   
> +	/* Look for ACPI tables and reserve memory occupied by them. */
> +	acpi_boot_table_prepare();
> +
>   #ifdef CONFIG_X86_CHECK_BIOS_CORRUPTION
>   	setup_bios_corruption_check();
>   #endif
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -222,11 +222,13 @@ void __iomem *__acpi_map_table(unsigned
>   void __acpi_unmap_table(void __iomem *map, unsigned long size);
>   int early_acpi_boot_init(void);
>   int acpi_boot_init (void);
> +void acpi_boot_table_prepare (void);
>   void acpi_boot_table_init (void);
>   int acpi_mps_check (void);
>   int acpi_numa_init (void);
>   
> -int acpi_table_init (void);
> +int acpi_table_prepare (void);
> +void acpi_table_init (void);
>   int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>   int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>   			      int entry_id,
> @@ -814,9 +816,12 @@ static inline int acpi_boot_init(void)
>   	return 0;
>   }
>   
> +static inline void acpi_boot_table_prepare(void)
> +{
> +}
> +
>   static inline void acpi_boot_table_init(void)
>   {
> -	return;
>   }
>   
>   static inline int acpi_mps_check(void)
> Index: linux-pm/drivers/acpi/tables.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/tables.c
> +++ linux-pm/drivers/acpi/tables.c
> @@ -788,9 +788,10 @@ acpi_status acpi_os_table_override(struc
>    * result: sdt_entry[] is initialized
>    */
>   
> -int __init acpi_table_init(void)
> +int __init acpi_table_prepare(void)
>   {
>   	acpi_status status;
> +	int i;
>   
>   	if (acpi_verify_table_checksum) {
>   		pr_info("Early table checksum verification enabled\n");
> @@ -803,12 +804,29 @@ int __init acpi_table_init(void)
>   	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
>   	if (ACPI_FAILURE(status))
>   		return -EINVAL;
> -	acpi_table_initrd_scan();
>   
> -	check_multiple_madt();
> +	for (i = 0; i < ACPI_MAX_TABLES; i++) {
> +		struct acpi_table_desc *table_desc = &initial_tables[i];
> +
> +		if (!table_desc->address || !table_desc->length)
> +			break;
> +
> +		pr_info("Reserving %4s table memory at [0x%llx - 0x%llx]\n",
> +			table_desc->signature.ascii, table_desc->address,
> +			table_desc->address + table_desc->length - 1);
> +
> +		memblock_reserve(table_desc->address, table_desc->length);
> +	}
> +
>   	return 0;
>   }
>   
> +void __init acpi_table_init(void)
> +{
> +	acpi_table_initrd_scan();
> +	check_multiple_madt();
> +}
> +
>   static int __init acpi_parse_apic_instance(char *str)
>   {
>   	if (!str)
>
>
>

