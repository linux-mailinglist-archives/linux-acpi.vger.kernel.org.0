Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7364C9CC1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 05:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiCBEwM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Mar 2022 23:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCBEwL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 23:52:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82132B0EA1
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 20:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbipheSYSpb4LmyALkHrRUw+wPbTkoBZr4f3gKKlCZ7tnsDM0jXQcDF/bkjRZiqk84rbPPan5ZAXbaWZJfobqS9bPAEmgIFs00yAUIokGW8uzTAx6B/PYl3jtgv13JZ9lCkLFKrWyGHGn2zP+xtN3yiovPDI+8bKanJb63m2Uz+waEsmHywoA7N01hxfgEgu7s5WjEnMyUL4CdP4AGtKDblad0JItguIEIEg8UOgjtS7vreeQ152D8FuGeC87uoiMOVMpJezyIR1F8/Gg4SZqcSThUOF0vNyQHEFKgD5wSkzB6nmxmOeHT81SHXfabKOtEVrXKyTKvmjPlb2tWskbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/hejnif8NNng0BOLAlGBLkqr75mbcQNRT05s7YI1FU=;
 b=J2IciNKwdZAOq4FlC8V+oVDNZCf1CF6IhLMZ4EqunCptqEWdt3H4uWiUQIB0qUTmPBIDnUfas+ytrFBBaPxpu9rkeScnnG+j+mYZndT60OLI5FDlIpncRnsoa6MRH6i/LB7zqpA1QkvnA96J+rn+Gtrxc9X3/RRaFrsmHEE9jE6RyUn5pWWnhZkSh8U/fAH4sCgfPelkYyX7hodTIG3cP0KoTzC9f1YUeKnWKMyTlvSc5zVHviqujdF1OxFw4YmQHkPQg5ud1J+pVUZWwEbhpGIEWul7IU5EmLeQAyWfHhr8b8aO4xX+tn5BN2PJI7434AyXBSfzJsQeap/71qpAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/hejnif8NNng0BOLAlGBLkqr75mbcQNRT05s7YI1FU=;
 b=wqAKflI4tlQhPRe2ESk56cx8Kbqvcv6t3QenEzBIkxHSFhWgqwAPVEgVTHL/eDlIbkbzB8atatMxvrDxe0vGiwrGHw63V2ZKPfMrlP+kvaHK0+/adVEU141owekdqgSq1+ESiFrSCTaFhYnQRIZzOM7rFpEUa0nIdNpMf8QWsq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by BY5PR12MB3651.namprd12.prod.outlook.com (2603:10b6:a03:1a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 04:51:26 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::1809:eda3:9de9:d3e8]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::1809:eda3:9de9:d3e8%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 04:51:26 +0000
Message-ID: <80024d19-5b56-ebfd-2b74-10175c6d7847@amd.com>
Date:   Wed, 2 Mar 2022 10:21:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ACPI: Fix LAPIC_ADDR_OVR address print
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20220221044333.19149-1-vasant.hegde@amd.com>
 <CAJZ5v0jkSZjYeNCbsQMj6GGAarnirDi0k0PRtXi3ED++s4_hxg@mail.gmail.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CAJZ5v0jkSZjYeNCbsQMj6GGAarnirDi0k0PRtXi3ED++s4_hxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::18) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c15bc33-2eca-4cff-71af-08d9fc084e51
X-MS-TrafficTypeDiagnostic: BY5PR12MB3651:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3651AF98AFD23C6E7ABD444987039@BY5PR12MB3651.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4l7NO80zVvnicugkmHT+UghK45oxSdsczTP8CCZYqwZHh1e0Ffbfir0qbfq2N+uBw2gEPxPmVsquuc44zY91ABalUFY8dOnhzRrnnPLXejq+fPPPXHlWz3MaiV7HEZptVm3RRrRJNizQTifR/kOqzuy53rlqwglUgzlQQ5VeEUeyxxg+XWB4Mya5DU1s/b9gj+BKVSwQhJW4dgDb7z2KzevCHfRpLRqcJYwUnfC54z57OrP34XsRS7VUJjv7JUnTdp3j4BGh7C0Krn3YHkJexywuWR3dgRkwH0u8Dz1oyphiwiQnDVy1vG+FA8isuorjdWhPPTrodSRHZlc828IQKnzH/qXv4TQk0bEqq/iszR/Gcl+5Qbb2jmXIWCQSmBEsYA3a5Zm4D6z7VpjSdFA/5PWxlH/5ljgb8V0jxKEthr7eUwVfGWTcbFN24Fbh+vfj9twUJLfjLdaYjaQc5dCNuT602PonK7LBJupoc0pdDXc0tOSc3d+qbRsi/XwX4AuWafP2PvkMqTPTz+57x5KbUfAPXX1hAWALLyw7X2TDe8iOlHd6rN4As+f9IqmJZhvDQAfeFfpNByxAZHTuxfuCOj7gzi//YZ2zWXFtB9sQhkz1vJwD24fjb2c7xULz13/7N9fdltAn0Ola6LgbhyN2loTiWvwgTKXKEe3GG0pwInvGRTjuv5sLESNvAKImvf4yRNL70EsPz9Gw2MHTamCPNurB2HPtjwET/XOV4g4xrhpO7D7mJzvy1a3jhoby+Mg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(6486002)(38100700002)(6506007)(316002)(6916009)(53546011)(54906003)(36756003)(31686004)(508600001)(4744005)(8936002)(2616005)(6512007)(2906002)(6666004)(4326008)(186003)(26005)(44832011)(86362001)(66946007)(31696002)(5660300002)(8676002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzlpOVh0VHJ3VXloWGsxMzB0ZW9aVmlEWXNBN3hrNWgrdVNHdE5ERlh5aWdv?=
 =?utf-8?B?R1lxWi9yUDlIVEhNaUdaVWxKam9SVEFGcXh2akY4VmorejF3eEMrNWdwMlQ5?=
 =?utf-8?B?WlZGUzJsdzdkaEQ2NEVOWXg5anhTSFo4ak5CWVBWeXFMQjlQZ3FiOUdSVm85?=
 =?utf-8?B?cTdkUmdXL2h5MW1VSGYvN2hWb0V1dU5majBFZFNYQ2ZobUZDK0tGc2NVcjdn?=
 =?utf-8?B?WnpxRUhKb2pFQnhmc2VlcVROcWNIa0VBY2xvR0p1RkQ0UWFEYTBMOEF0Q2Ja?=
 =?utf-8?B?Sm9HRzR2eGRUMEpxVStEOHVNNk5IakJSR1F6S0dYWU9EbzVzY1kwbHVTQ0Iv?=
 =?utf-8?B?RjZNcTY0c3V2UEpoYUFYelNjOFR5YTRZMEdFSmdjakFTKzVwaTZ4d1NKQ0pL?=
 =?utf-8?B?VkorbUFUbzdSTkE1VnorQVBZVlZLMkVPQk9QenJvUVgweUVUeFgwOVc1b3pY?=
 =?utf-8?B?UFQ5WHgrM3lyaHhRcUx1QlVkYkR0NXpQQTZ6aDVpMXlLZ2pGaWEyVGx3ZEk2?=
 =?utf-8?B?WmtSVHJyNzZRYk0wZW16K3JQcEI1TXZadXc0d1JJU0lEbndYa3ROQllEbTda?=
 =?utf-8?B?RVFaSjBMaGhpU3ppRzExQWFBblR0eGlhSU50UEJ1TDRwblVOdEVKR1RmZ051?=
 =?utf-8?B?cklZbXVmdjd4NGxZZUs5Snh5b1EvL3hzSGg1Ump4QmJJTEZOUTdiTWV6WlZU?=
 =?utf-8?B?bm1DcS8wRDkxNDdONGpWaG0ra0NOZjVWakw5dWc3Rit4akxZUjRWN0JHMUJ0?=
 =?utf-8?B?MW10T0VjUStUbXc0Z1dKUkhSbjAxSFBud3NMaGZ0ekE2RUtqWFNzc1d2RHFE?=
 =?utf-8?B?WWZMMEJVSEk4ZkYzbzI2Y0k5Z2RxMVk4UHB2b2RSbGVlMlgxV0R1Q25hWHgy?=
 =?utf-8?B?LzhMamJIakNiSE93RUp3dzk1VXhvSXJKMEwwcVhqWm5DYUpaUjBpZTJVelZz?=
 =?utf-8?B?ZlR2MmMvYXFwamJhUTJWTFpXQVBWZXB3dnBHTU9udldIRVBmUCtVaXlyd2Ex?=
 =?utf-8?B?Rlc0K1g0Titrc211RlNOMS9jdE1ycTVFTzI4K2NvbG1naXRwaEhXQXFNb2t2?=
 =?utf-8?B?ZElnbjRSQU9pMHRDYlJ4M2x6bm5CazRDbUwxVUtnMVJDRFhUcWxBaWlqQ0Nu?=
 =?utf-8?B?TWpHdXpkZno5UmlsdlIrQ2hsZ0tINHFSVkIzamdiWFB4MVBjN21VcnAzeXdL?=
 =?utf-8?B?QThLQ0ErQjlmeWlkZCsxcSs1L1NXUkhhQkd4RnBodFp3ckVLOGI1SzZvQVZH?=
 =?utf-8?B?eTVKVHZTOXdqL3VITGJ4c0p6NythYlJ0dTR1TGpwNmJzZVBDeUtyNkhKYlBz?=
 =?utf-8?B?djR5T0tuZll2M0UzWHAwbDgyTHlQQ0JLaXhQKy9tT1VmVVpYWXNqeHBORE8x?=
 =?utf-8?B?enB6enlXMlIzUFdGNzI4NXN2RlNINTJLcElJdlJvMVV1VVR6QkNURnFmTEw3?=
 =?utf-8?B?RTUxekZVb3BpRU0vdXpLSUJuNTNrT0Vhck9ldzZyb3RvK2RJcTNzelJkNkhW?=
 =?utf-8?B?QWwyQTh5ZmhTT3pYMEg5K2pyWUY5TFB4ZmdnbGp0V2NaN0F4T2hqdmErVG1q?=
 =?utf-8?B?UGZFSEFaNmtCZENnODlxTlM0V0x2ZGc3Vm1JdDdOR1Fzallqd05sSVNEOExY?=
 =?utf-8?B?bmprT0N5dXRydG9LamJwMXhCV0tkcGp5ak9PSTMxRTlOaW9oL0pHZ3VON2F4?=
 =?utf-8?B?QUJSaDd4VHNJQlBuK2gxa2h3TWdsNTgzTFVjbjZKWE9HempPOW5HeUFodXE5?=
 =?utf-8?B?M015d25ySC81WnQxYVBUSGZUSEZwbFdQNklqa0hmMjRwSTdTY0w2bktZYUwx?=
 =?utf-8?B?RmxEM1l2aGVDRFk2endjQWh6OUZOd1NVTUxBUkhCejJZTHVaTjZueTBrZDFo?=
 =?utf-8?B?QU1GTHVHQjFoZmtMRWhWRTY3c2QxWU8yemNTVFZPU1pzOUdPTzhhUkN1RHhC?=
 =?utf-8?B?NFMwYVU4QmtNRjQ2V2RoYWZVK3EyblMzZmQxc0NXejYrdERVZ3pGdkkwdHd3?=
 =?utf-8?B?UHBCUndwMi95TkgycUF3cUU3cXI5K0JLUnRFczZYT29tVUxzTDQ4cmpsUGk5?=
 =?utf-8?B?MDYzOHlScnRsZGlUMkRCeERIVlNUZnRjcTNveVFJREMwZm1uZ2d0V3BRcENt?=
 =?utf-8?B?RnNpbW1MeTk5Qzlpd3doYi9WZytaU2p4MkVleXhnVGVTeEE5VnlPZmNCdGFY?=
 =?utf-8?Q?0BRrAV7k/7GewMmtkpJLhYY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c15bc33-2eca-4cff-71af-08d9fc084e51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 04:51:25.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4t6b1x8LHFFKvUjSeqzztzwHDNvvul9yNmuPkGWFNj0iU1krDoS+pE7D9bpZDnwJYUru4mLSYf2KSy+H8MCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3651
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael,


On 3/2/2022 12:54 AM, Rafael J. Wysocki wrote:
> On Mon, Feb 21, 2022 at 5:44 AM Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>> Without fix:
>>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])
>>
>> With fix:
>>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> The meaning of this sign-off is unclear.
> 
> If this a co-developer sign-off, please use a Co-developed-by tag to
> clarify that.

Sorry for that. I missed to add Co-Developed-by tag. Can you please add below
line before merging -OR- do you want me to resend the patch?

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

-Vasant
