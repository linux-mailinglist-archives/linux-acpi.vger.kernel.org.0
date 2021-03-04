Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6732DDA9
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 00:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhCDXO0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 18:14:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhCDXOZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 18:14:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124N9BNp051996;
        Thu, 4 Mar 2021 23:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Sd4TTnDDjxAgk8ZzIcCDx0jRvu71FOqkNzU89oaoTtk=;
 b=g56ozWvUpYzvK7itpiU33556OSGV+lWJf0WxfpO8aN7FftKdaoq1OIS5nPW/kowqVTzH
 lEMW8PRNAOWrbkx9wZEVVGq5fjjSWDkqLVr+2DTbiIz9qQ5DIDsNHxYamlXgsxhDQz/A
 OTafhrgUlM6S+NqmABg4eKrDLEmD6Y3IrOqk1U/qY5HVYbvdwjFEDk9erkAdEuf0l/1B
 d7MQWuLpG8MG3od7YhHeEitcNoWIp0jX923Q06PxD8qvjVWhgNnOkXzSUPVf8tjJbdI9
 ExsdUKf/PLYDhT8AkHxtcPT/v+B8OwGzEkArEyeT1s9SoBOjJB5oj1Um5fRxoRkeK9/5 xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36yeqn8r3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 23:14:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124NAwB1006568;
        Thu, 4 Mar 2021 23:14:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 36yyuvg8uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 23:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4ffSUtWMJXIyQMYrwy8mL9IRSgoskorF1F+CJK125JUgs/Fk5BER1AZ+npi4uzowyNVjwevxVUkqIK/y5x3sefwA2eyoUt+i0trJTDtZWlv+NDLfOmvG3jmczFCubpy3LErRI1TCi2ajFIJIorpoC6sDF/UzqmmvcDb0JjO8l+/ftP2kHSpRdjgfWkBrHeBiOyNQFYd6gHgPUX1JtsNx5IdloHEb2exdoWT05x4zeOGpsBNWJFQT4NhziSRJKpssnHvhQ1SmFQa0jrNYUzErjqo1Iw/KkEzEtNJxFlSKtvrrIEq3QzZZFVoOXr3rQe+D/WQFoR3wPOk2jy7vs/VNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd4TTnDDjxAgk8ZzIcCDx0jRvu71FOqkNzU89oaoTtk=;
 b=bsoBmT1wnrqLKpDQBV19Ar6IJK83nbNc8GveULIKzWhvvF4oYQHHjqrw0t5x9uKWl1zvwKljgVjq9INSd4ezCU8UulCls2liBNP3iSn3uKjFpmQ5WF8R0tdaKLPkN9YgvEVbV61SgY18Rvc4yvM+beA/mXO2iyMvqpPg7LOeaqsWIUd/ImmNNme36sRF7cqxDW5QU1smuft0k9RlKPU2CG22y1/EVZdM/uaO5HmMxhbgGeuNvazU3vDCZcK8KoW6Lv2jykBYnDOTGOF+0em4w0HQyebVaCIWOmV3ixLXym27ovSr1IUXGmfnEk/xKO/bZyUkpAbpTj7yU+maDsz+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd4TTnDDjxAgk8ZzIcCDx0jRvu71FOqkNzU89oaoTtk=;
 b=nnCdACeJV7P451ybjJz5POenHbdpg6TY8BtRPTCxPFY6+krvXLzrkkTe+A2hl8JoVDuQaUboNOsaJMbtpVtW4v86uEJ1vkn7JsKqpnw+bpmytwsvXZWmQx4kP4pDa4/Jzw9CyZcFdzCXYpsae1Ir7hyxpBHpOfkWN+KrSnzOgio=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3274.namprd10.prod.outlook.com (2603:10b6:5:1a1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Thu, 4 Mar
 2021 23:14:18 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3890.032; Thu, 4 Mar 2021
 23:14:18 +0000
Subject: Re: [PATCH 1/1] ACPI: fix acpi table use after free
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Dhaval Giani <dhaval.giani@oracle.com>
References: <1614802160-29362-1-git-send-email-george.kennedy@oracle.com>
 <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <9c3bc1b2-bb8d-194d-6faf-e4d7d346dc9b@oracle.com>
Date:   Thu, 4 Mar 2021 18:14:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <CAJZ5v0j3=82x1hV9SCdinJQPkDXmJd9BFoqvNxNHSb6iS8PHVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.26.147.230]
X-ClientProxiedBy: BY3PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::27) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.26.147.230) by BY3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:39a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 23:14:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 530b9f34-569e-439e-4916-08d8df633c97
X-MS-TrafficTypeDiagnostic: DM6PR10MB3274:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3274FDFBFFE9B0DDC648F6D7E6979@DM6PR10MB3274.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQ/HGwTbYuB8BV754HZukU/YI0JiWa+1AUpy2Z8UsDDMpOq6rcNt49Get5FaXSzohsqwNHX7GXUQD3FwZXJ7WC4O8UYxPPmsZIezqWE5FleJkfG/aM8Q8q6vqloXHCMPABsjyc0wfMJJLoIDk5UW1XEv/XwGmAmb7S9rf/mRzzrVCM0ryCQPsrvdBTkI/lwpxkfwLOlvDIWbnpvEx65VWZdZrDaJVwOyX+PyPP65TTCrH2l9UiOzkoNLlcpy0ktFLIuIG8ILHTxe+i3gN/N+GwjY3Yv8/wK/CNUZno/f7EVvqhap9cgZ17g1Y5mHP0khkB5b38FHZikpEG/ozDtjkpDe9VM2dMjxL1MD5UcD+rHJrQ52wxeJJKurrceZgpH7N9u9l2/HgWoo5l18MRgydabRAXVlX16rVzZ6ebFpBGPPjtzteU4VHCJcQGnHip33IH64b0Y9CywNFkGjB3dJCPLIiZBL5k/+mzx8lLaJ5VtxH133ZgmbA1XtHzvSACCUufkVysivMYlzWrg8GXIry1JBKBKR9CEcOKHQNu3DSiMRArcMHYtmCGT9nodEFq4Q1JNyIXv+T30rsYChAQusagl3YbrZjkTVWyDdtJDn2Zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(346002)(366004)(53546011)(36756003)(36916002)(6486002)(26005)(16576012)(31686004)(5660300002)(54906003)(31696002)(316002)(6916009)(44832011)(66946007)(956004)(16526019)(2906002)(107886003)(66556008)(66476007)(4326008)(2616005)(83380400001)(478600001)(8676002)(8936002)(86362001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NVcxQXNudFI3UkZ5YllOYW0zVFUxSzNtbllsZlVLTWw3WU0zVENKcmJ1S1Iz?=
 =?utf-8?B?Z1BnaWF5czNpQVFTcVNJYXdPOUZBYW9Idms3ZUM5Ykc3enh2REtrN21sVnhj?=
 =?utf-8?B?b1QydHRUSTZCWTM5c0xOeHhEY0g1TUVNSmxWTS9YUWJpZ2puRWhVRzRlSDRp?=
 =?utf-8?B?WGxqc1dhQ3FJM2hEcXdranFHOVdRTWFmTGEwazdEYmh2NEhNd0Z0RUVvekZW?=
 =?utf-8?B?R3BjeGFOTzV3Z2t5Qjl4dXEzQ1hONGtPdGF5ODFkOE1sU2RkTkRIN1dCZTU0?=
 =?utf-8?B?K3pRRVVMSTRwVWFkUjQ2L1B1QnRzODYwbXFIb0ZkV2xxdVU0V0YxS2t6L3FY?=
 =?utf-8?B?aUJUMkJRcVc2WVJQSmZkTG01VCtxazBKU2h4c3d0NERwRVU3YVY4RGVTdEVR?=
 =?utf-8?B?NGFQTlF5SE56Mkg0ZCtRbDNLcHNvZFd2VzBXb3NxOWdsV3Y5cXBuMnlPNllq?=
 =?utf-8?B?Y05GVTU0SnVza1dPMmtocllvY1RNQnh5Q2dTSzI1aXVhTFJJWFYvb2x6dFVT?=
 =?utf-8?B?QzlGMmlOdDNaZmNNMzkzU2oxaDZJMmxJZFNHeG96Mjd1QzdNclNWNFM1bzJU?=
 =?utf-8?B?dDh0d2NWOFN5L2JnOTZxZ0JUbnFrQ0srRUs2OHZnYUpjcEFhT2RhMVdiSTJr?=
 =?utf-8?B?bjQwVGZqVzhiTW9qVE5jeEZySlVPQmNYUWVsOC9IMS9vZ002d3hGSFd3aTdG?=
 =?utf-8?B?c0hzSjZQOHMxaTI5RHhhdk5TaWQvZjEzNkV1RDhwZTRqNy9BdkZ0dlFTVmND?=
 =?utf-8?B?VW5IaVV4ak1RMmMxeGRIYWUwYzlaTEJ4em9ud2FuRkl4b0ZMdjBqd1A1TVJX?=
 =?utf-8?B?MWpqWDUrK3EwWG1hMDYxeGNvVkZ5SHY3WXJXcEZsbFV6YnRkVTJHZHlsS1lS?=
 =?utf-8?B?bTJSRXF2M2c5NWZDekVjbWtoTGFjMmlqdVVRVlNpZjk5cElhK21DaS9YNHdC?=
 =?utf-8?B?NGZKSFVSN0FwaTdkeW81aWcwQnJwZElEMFhZeWorNDRrZUtwejlhR1JCV2w1?=
 =?utf-8?B?YXAwQXIwRC94NDg5aFEwSk5hTDlxMmZabitWNzZQbHRORXRjOUdWdy9iV0h3?=
 =?utf-8?B?elZMUDAxUUtmZkpqSHhRSHBISngreUo5dXJERnhEL2c4UlZQQkkyRGFVMFFD?=
 =?utf-8?B?R1ROTDVkWUNXcUpaMHRpa2VDR2xOT3FFQk11WENFV1lzZFZOMVRaaE5UVndO?=
 =?utf-8?B?UlhhU1VaOVdydFJQYUE5NGdpSTFzcnBnaU8yeXpkWHhpeG5VdTRpTlVZdkZK?=
 =?utf-8?B?bXZaK1ZrWHRJWEZjN0R4UmpCQzRVVGRzWDBaV285ZFY5MG1kU0hFTkJhdWY3?=
 =?utf-8?B?QVBBbG5ybXJnc3JycmxwM0RuM1dvNkpoY1J3QVJ4UnJsMU5nY1JQWkQ2QTRh?=
 =?utf-8?B?czFLYjBUVDZ5dmh1eE5leE1GcnZ3bHdNYUwvTnlCaVkrQnNwd2c2a2xKbnZ4?=
 =?utf-8?B?eDU5NHlITzZwbUM0UUNRejVNYWFWZzJ0aXdITldJVGU3Tkl0UVdBNzluNWsr?=
 =?utf-8?B?KzRZbkN6UlpvaERLUkRQSHdKcUdPYTA0RW9SYUkvZVJTOW9PRy9MMW1malF4?=
 =?utf-8?B?bmJKa1BiUWVmWjVLNFUvQ241OHF2WXVSZ2w5SWI1ZThCK016Mk9OMmFYUHRB?=
 =?utf-8?B?cG1sSWFIQnlPYm9tY1NCd2VDN1A5TDJ3VnU3ZnR1WlhsclEvQ25XM0lndE5p?=
 =?utf-8?B?S2FOek5sZzFVeHF6Y1dvMnhOMFFVUUNFMVNReHVDc04zbG5nRFNoSnlKR0FZ?=
 =?utf-8?Q?tNSbZkAqxxS4uu+lQ789Fa7OnHlaDy+9JOP9TO6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530b9f34-569e-439e-4916-08d8df633c97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 23:14:18.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72+uTeuUgKwX0PZmbEJlzD4oan0g6DMqOj55FyZDOiD3uJjMZefABw5XuEeYUKvAZvGK39jNmci1rXc1ZJBspmNL6Dd/wGtJBcns6FvU/Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3274
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040114
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Rafael,

On 3/4/2021 7:14 AM, Rafael J. Wysocki wrote:
> On Thu, Mar 4, 2021 at 2:22 AM George Kennedy <george.kennedy@oracle.com> wrote:
>> Since commit 7fef431be9c9 ("mm/page_alloc: place pages to tail
>> in __free_pages_core()") the following use after free occurs
>> intermittently when acpi tables are accessed.
>>
>> BUG: KASAN: use-after-free in ibft_init+0x134/0xc49
>> Read of size 4 at addr ffff8880be453004 by task swapper/0/1
>> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc1-7a7fd0d #1
>> Call Trace:
>>   dump_stack+0xf6/0x158
>>   print_address_description.constprop.9+0x41/0x60
>>   kasan_report.cold.14+0x7b/0xd4
>>   __asan_report_load_n_noabort+0xf/0x20
>>   ibft_init+0x134/0xc49
>>   do_one_initcall+0xc4/0x3e0
>>   kernel_init_freeable+0x5af/0x66b
>>   kernel_init+0x16/0x1d0
>>   ret_from_fork+0x22/0x30
>>
>> ACPI tables mapped via kmap() do not have their mapped pages
>> reserved and the pages can be "stolen" by the buddy allocator.
> What do you mean by this?
The ibft table, for example, is mapped in via acpi_map() and kmap(). The 
page for the ibft table is not reserved, so it can end up on the freelist.
>
>> Use memblock_reserve() to reserve all the ACPI table pages.
> How is this going to help?
If the ibft table page is not reserved, it will end up on the freelist 
and potentially be allocated before ibft_init() is called.

I believe this is the call that causes the ibft table page (in this case 
pfn=0xbe453) to end up on the freelist:

memmap_init_range: size=bd49b, nid=0, zone=1, start_pfn=1000, 
zone_end_pfn=100000

[    0.477319]  memmap_init_range+0x33b/0x4e2
[    0.479053]  memmap_init_zone+0x1e0/0x243
[    0.485276]  free_area_init_node+0xa4e/0xac5
[    0.498242]  free_area_init+0xf4a/0x107a
[    0.509958]  zone_sizes_init+0xd9/0x111
[    0.511731]  paging_init+0x4a/0x4c
[    0.512417]  setup_arch+0x14f8/0x1758
[    0.519193]  start_kernel+0x6c/0x46f
[    0.519921]  x86_64_start_reservations+0x37/0x39
[    0.520847]  x86_64_start_kernel+0x7b/0x7e
[    0.521666]  secondary_startup_64_no_verify+0xb0/0xbb

>
>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
>> ---
>>   arch/x86/kernel/setup.c        | 3 +--
>>   drivers/acpi/acpica/tbinstal.c | 4 ++++
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index d883176..97deea3 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1046,6 +1046,7 @@ void __init setup_arch(char **cmdline_p)
>>          cleanup_highmap();
>>
>>          memblock_set_current_limit(ISA_END_ADDRESS);
>> +       acpi_boot_table_init();
> This cannot be moved before the acpi_table_upgrade() invocation AFAICS.
>
> Why exactly do you want to move it?

Want to make sure there are slots for memblock_reserve() to be able to 
reserve the page.
>
>>          e820__memblock_setup();
>>
>>          /*
>> @@ -1139,8 +1140,6 @@ void __init setup_arch(char **cmdline_p)
>>          /*
>>           * Parse the ACPI tables for possible boot-time SMP configuration.
>>           */
>> -       acpi_boot_table_init();
>> -
>>          early_acpi_boot_init();
>>
>>          initmem_init();
>> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
>> index 8d1e5b5..4e32b22 100644
>> --- a/drivers/acpi/acpica/tbinstal.c
>> +++ b/drivers/acpi/acpica/tbinstal.c
>> @@ -8,6 +8,7 @@
>>    *****************************************************************************/
>>
>>   #include <acpi/acpi.h>
>> +#include <linux/memblock.h>
>>   #include "accommon.h"
>>   #include "actables.h"
>>
>> @@ -58,6 +59,9 @@
>>                                        new_table_desc->flags,
>>                                        new_table_desc->pointer);
>>
>> +       memblock_reserve(new_table_desc->address,
>> +                        PAGE_ALIGN(new_table_desc->pointer->length));
>> +
> Why do you want to do this here in the first place?

If there is a better place to do it, I can move the memblock_reserve() 
there. The memblock_reserve() cannot be done from the ibft code - it's 
too late - the ibft table page has already ended up on the freelist by 
the time ibft_init() is called.

>
> Things like that cannot be done in the ACPICA code in general.

Can you recommend a better place to do the memblock_reserve() from?

Thank you,
George

>
>>          acpi_tb_print_table_header(new_table_desc->address,
>>                                     new_table_desc->pointer);
>>
>> --

