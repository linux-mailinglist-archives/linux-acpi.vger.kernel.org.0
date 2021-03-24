Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B89347CD8
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhCXPnZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 11:43:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58768 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhCXPnP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 11:43:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFYGe5030432;
        Wed, 24 Mar 2021 15:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=67aHvjqsXai1kAMoEIUrSuATRFRzvaOe9ST8fm3XiAQ=;
 b=KRIrN15ddAbX+SvDNYEts2OmAzKJhZqEcof0urxLl9c27fm0XJioJf0O/205aUMwWJRg
 AugpSmXjvcZQ4KhTFMsmTdLRAdUfYW9R7v+KJ+HJG0AI3gsR4VpHTcW5DK22CbQsc27Y
 BF4kmE5TNP5Ob8D+1hPj89NkJK7u9Vg93bKFOzldmyPFXRmRM7djy53LbXMFzZE2ufcQ
 uWRlhJnKiiiv650yTm7jCGMg6K/bTaqYCo3p8OoTkljhSWtBz1CbpNUOGeqcYhoJ4I4o
 5JG+J87RXmma7qJlRABSefjuUNVCzB+H8InwQuYVhX7nRJowy7oM2oV7B37riA2nGKHO 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37d6jbkb71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:42:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OFYs2D156391;
        Wed, 24 Mar 2021 15:42:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3030.oracle.com with ESMTP id 37dtyyyx1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 15:42:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtsQ4uUqi4K5Oxi6UNGM5R/y3ZH1FVuaXgqGGZdNLoUEcUTmgIhHKYcbru8dXPg3nzoIYjIfz7h9B1vZ/HcvnmIZi8AODlLQaNXIgMwqCMLK/1OBICM8zP8tNZXodUrs2mkGPpiip0CyRECmqdPYs3lJ6mN2kRL9/eIrUUWrU5QWbVWopDcU/vFhEPZBzQBqZa7BSnza0Kn28+SlpgR2MYhTfNc5xkUgEVZ8mnKQBqVg0rWZVbSDIC/8lbYbn0UJthpmxi3wWwtPTr/9AXzXMw6mO8yNC7kzJPkpiBwxVf75CjxTr5dj3NplFU9hAzq36ShJLoT7UiqK/zCgWQG8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67aHvjqsXai1kAMoEIUrSuATRFRzvaOe9ST8fm3XiAQ=;
 b=aUL6kzs3J9TwUf2jUMa/t7LKsSTjozG5LeOn+UBMkOyOXPbqz2xBJdm/SEjIvV85n9b8s4KKtw6QGLn+bfB/OWO93LvZ8NvK7hgjYjyByoI3haam8JL/dpvISg1IkamVTbi9aSILCKpZFqy4M31dcaEuYXosF0xrlNJcHNum7lP9TEyybRlI4RK7gVDFx7wbew9703Z48TklaIxN4fLT+MTLkpddIkm5RNvVygKlJiIrtL0WLpIwT7BEOATLEuuuloVmmoxXU+f4vCgUHNmQwXPEMuObCTB0l53do43hAtB7m+j0/V6XQOEJMV2oAKyPfT3g6wvqrbrjrbqlew2jEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67aHvjqsXai1kAMoEIUrSuATRFRzvaOe9ST8fm3XiAQ=;
 b=T8iZaYbz4v9v34KxVFbRPE1vnqRrYl0HjWX2LzFPXtJAD2eFHvi1dlBffCFQBhtRvEIlKp9i69yqF0iir4DdR79QfZPy+p6h6E/y+6riU6v6P88VF1V4SAEQR35Sfv9qZseI5Tb1tm2RMdaq1idLXNLl1f2vhhQwP+vLugLUY1g=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR10MB2027.namprd10.prod.outlook.com (2603:10b6:3:108::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 15:42:49 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 15:42:48 +0000
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
Message-ID: <933519a8-faaf-644c-4368-bc92cfab937f@oracle.com>
Date:   Wed, 24 Mar 2021 11:42:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAJZ5v0gWWGx8dvtz2pnXcCoxz_Aswo8Yxp=vo-z=jYX1OzC3=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: CH2PR14CA0059.namprd14.prod.outlook.com
 (2603:10b6:610:56::39) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.26.147.230) by CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 15:42:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 739b1c75-4534-4669-f8c2-08d8eedb79d5
X-MS-TrafficTypeDiagnostic: DM5PR10MB2027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB202755C433E8E5610680DBBCE6639@DM5PR10MB2027.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYdSUeRTcPcGSGgJ7LQEk4QdAe0yyFsSJNTOMXwb8AIiWbMHKRczdMXjnIR9+oRKyOKfk1bHPmLXre+8ASDd4c+vyerX3iSs6AJpWjZ1sEpOOIaTPnnI7ePQ7PSQKno/Le5/cEMDPYT+z+GizC0xBZV4bQbaiIKcbOGVp4GZuaEa069PF1X1T4rnRLQteN7GxjbI/TQkfv/8V9hXIpSPbEuZOLUmSLMn+T9a3qdngO3lq8EvOVmuCGRRFHYYl2zXL/l7RmAw+AJKlYfaxWpvG0uufrnwiGIjOA3u0ZfkJUXzYhqxvDYmShLDYuS/5U6mU051HMMFIwnrTAhP8dt2Z1xwNBq8JZmxgdpdv1RotC9VF5JHXdtEd+2kPC0ptaYlChbhXl3UR+qS7Y1L9W1sfnxYcF5Yp8BWEuNcHbh+qjAYZLUKrjrNk9OtYcsrsRakHs1/eC72RDJW60EYTVvnpKiOJwspQRLikKayrW3pAyGN8UBxD52KcN3yOfjVGKCpFp1sHEpEaZvJ9uBbbAjTxIWPqwuBElhptnqc3qt6EeZq6IjSPrD3p2gBp99RrdMDKoiM0j1NIxXzLAziucSY+gfE63TSBUrqvFJikANaKDlrUPE3Xw6rfgD0dJHUDcT8vRYiLZxXl71o0lCHbc7X432MXjtbaLuK/1oY31y5Ma6vCAdSwgilcVv/Y80mDDAdV6juZZuM+xNuG7ReBhqobRgzq99pP92pccKzkKL3+V0AMGquIcJWH4E/dBTEdHcVYEBeB6qRN8pKRDJYMCr4hifYzdoU0VnowYXUDXPmcsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(38100700001)(5660300002)(54906003)(66556008)(186003)(44832011)(66476007)(2616005)(66946007)(26005)(16526019)(110136005)(2906002)(83380400001)(36916002)(4326008)(8676002)(36756003)(53546011)(31686004)(316002)(7416002)(31696002)(86362001)(966005)(478600001)(6486002)(16576012)(956004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bStQbjZvQlVFMTVNdXZnenBlbU8yNitKTGxlVkRTNTY4OHdmM09xYVVoWWlu?=
 =?utf-8?B?RFB1RGlRUWhHYjFzNVl4VlpTaTNaNUhadGhxR3lPYmxqOEZOa1hYbTFHWlFi?=
 =?utf-8?B?c0NuY3N1eHRLbnpaZDFaOUpjSUM4bWlBT2taQktOV1huNEdEai8rTWhReFd6?=
 =?utf-8?B?R3k1MG84cDA0cWlXWFFwSU9jZXkvZkF5WTBRM3d6S0ZPRUhkeFk1Vnlhcmdp?=
 =?utf-8?B?dlFBYmFuYXJLNHNVWEZzMVp0TlpqdXQrVW1ERmdnSkxQOE02c3NQUFRTZWky?=
 =?utf-8?B?dFZ3SndzUmQvY3M0M2UycGpGbEVOZit1ZmxwRmJ1K0hiMWhRTnJlT3NhVXY0?=
 =?utf-8?B?SkFsakdsTUVTU25FMjJkeVc0OW5wblpvQkNiYUE5cXV0RVIzK1kzL28rS3dt?=
 =?utf-8?B?QkVlM01iTGp6QURMdkZyT0ZIYlJLL0ZwTlpVM08rTXRFNEhVbnM0RGlBQTZ6?=
 =?utf-8?B?NTlUamdGRC9xRHVmbVFBN25hU2hGc2R5M3ZQZ2dhTks5U1BNZDF1UkQ4VDVV?=
 =?utf-8?B?Y0lJUnBoUUlrVVM2RU1GcWJRbU9qcGY5bVhEUEZPQi9jUFp3QjloZE54Y1V0?=
 =?utf-8?B?WnFqY1NwOGZJRVpMUlRpRlN5S01QYkhSUDZCNnhuMTRLV2lGSGlmSU5pc0h4?=
 =?utf-8?B?RFhRYXMzeXBWVG83NExBVXhmVEVBY2hQbGkvdFhHY0dzOEhYZzFJcFhUOWhw?=
 =?utf-8?B?b29FZ1JKeFRWa3RrcVg2VSsySUZFVThjYXlkcnpuVFNoT0tJK3VFTzEvTjNI?=
 =?utf-8?B?c01BcnNqMmxQdFRwczErMVFsTDl3TXZtVFpDd2tvcnRCSUt4R2ZZdi9WaGdN?=
 =?utf-8?B?Ny9PbDQvU3VIbzF6QlB2N3hOaHdQSml3RXYwbk80UlFHcGxDU2FpcHd3VXkv?=
 =?utf-8?B?cEZRMVNHYXpVdTQwaSszcFZ6YUo3VTE2SFhha2VnUVdXN3hTOGN5R3RDc1FY?=
 =?utf-8?B?US9QSms0cUlHUHhxSGRMVngwTEFZa0E4QStyNWFIWkdKS3U1Y1pxcU15TjJV?=
 =?utf-8?B?OFJJdGxiVnVGYzBZTHgwL2NDbXc3VS9EbUx3ZmhZMExtUllXK1pDZzNJdkYy?=
 =?utf-8?B?QTgvS2d2aTQxWU9iOGlwMFFvWHAwSnVieXowNDgvKzFNRW1yaWtUbUZhbVAz?=
 =?utf-8?B?dThrR2tBZVdPSFFBdGh6eG56TnBEYkJwbXVtMVBDQmlTaFpIcDFTb3c1eFo1?=
 =?utf-8?B?N2xTRnNNWnZUb21FSzlKZGxaQUpBUmcvbFBtV2JWMk1UYlJhU2RIeXovN1ZH?=
 =?utf-8?B?b01JWEZPQmpDSFpXUlArWE1BcXBrN1pQWXQxRTJqdGRtc3RCb20zd3liVUlY?=
 =?utf-8?B?SUh4dXZ0d1hJTVYxMUR4a25FV2d5akZSWi9wYTNGUytrZ1kwcFZhZ1pDVklC?=
 =?utf-8?B?dEVveGVJYmZ2clA3RnBnRFVoamxqN2EyRkpUVVdwaWxIbDdpQVBwMHFHQ29m?=
 =?utf-8?B?cUtPQzVqN3BVOHJlYkZSa3Z2YzhMM1A4Wm5uV2Y3eE14Y1gyVVNhbWc4a3Rn?=
 =?utf-8?B?ZU5kWEFIVVhzcGtJNVFMZDlyK2dOZnFvalVQVGU1NFZ6dGFRQm1Cb0FhMFdE?=
 =?utf-8?B?Q0toaHplaFd2aW5oTmYxclpsNlhwTVZtNkhLOWF6UVdCYXV4b2xlTzR4bFMx?=
 =?utf-8?B?WkNOb3FVYjRJaVhSZ09kSnV2aFZCR2NhWHphd0FISXVxNUZpNWdxOWd0Unlm?=
 =?utf-8?B?ZjR0TURqTmRCTERrb2h4dklOS01QaWtVdFExOFhCVEtuQ3Vhd3Q2bFREUUJt?=
 =?utf-8?Q?QdhsMbLuZy860swpAh+mnZufBHCCQ+68FCDjz4r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739b1c75-4534-4669-f8c2-08d8eedb79d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 15:42:48.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: purc3cmuq0nfIZLgaDVZqAW6XJeacxA2QZAE/Oqf32gyRGjWlTB6ITzLJPDr3b2gwuEMhYAOdDyfB8tIPAKADOz5UK2OxjrcnEtWaZF2KMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB2027
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240116
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

Rafael,

10 for 10 successful reboots with your patch.

First, verified the failure is still there with latest 5.12.0-rc4.

George
P.S. Thanks Mike, Rafael & David

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

