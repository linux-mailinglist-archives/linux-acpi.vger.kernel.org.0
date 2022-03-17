Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD14DBF98
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 07:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiCQGpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCQGpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 02:45:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAAAD1105
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2022 23:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ8DOxjmMlIiBbLZsz7P3HsUMdS06PGPbZjvCJia7zpGw8T6u0gycnKEBkV1mZstDoFUePjWwq8IiEZmOqqR0MGyTDPo53xsybfmx8LlApkAFIcrtU79OV0mmKIvG35734/6R15c3+pmEH/UtqSD0dEChC04dD6N7ZWUaZAZvpUYDIWU6U2gOZ7EbZVQdxJQwXsiJe4Y+PBnsKeaV35z/bUb4+SdpBzdM1U8OAYlfGvkNpSrHO34l4dLTAlHe+pfFVuSfGHY3SyzUKnzVrrMq1Qbr4mcMtCt996wGcGTqSLabm2SJozssWlIoyiRmXsHxdmU7NiP+rAeB0eu3zGKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caCBpr2p+8lEolimCVMYzwKUAAXRXMUTITkgzeU2IwE=;
 b=RkCdnkkJxffEGaJMW5x7UbeNQ6k5aoK0B7v7wxKVtcRD0ubf4KzI33b1OMZut958edhfjtIUCnFKfFPcYv9fVcjgw/rxEZ09TfUIs/xMy7uAFWehBMrcaVUxQYpPf2it0By0TpJFMSIxKGs6N0f4OTdFFXUqjeOFP38dpCoCzmEWQp1GiVYWLhzpkAe2NBpzQq0R1p7mx+Em+Yo9DEWtbnpqRLXJH4jiV+y7XxLbTG6EGGS3XF1ZCoYj289I5gw9bypoLlLsk5wqI85fm2g56POSU2eD26EgvfiVqXMDlJtsuHZnsDqL5F7GjhmFX+SNetOXiXZfHW7hJzWmpg9e4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caCBpr2p+8lEolimCVMYzwKUAAXRXMUTITkgzeU2IwE=;
 b=JU4p3wLOhfJAos8AZB5ka1NhVy3tugdMKh63FmfZodjHEG/cW5dCCdU287sqFu2ZWYaE5GOBoUSWPIMYNhsES2m0sO3PUbdp4aJnpiUHYNAFB45y/bG9FNm0jWj6D43Js8ZZ5+imh66BF7D7im9lx4T7QbhUKI6Y+s7sf2zqQkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25)
 by MWHPR12MB1935.namprd12.prod.outlook.com (2603:10b6:300:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 06:43:41 +0000
Received: from BN8PR12MB2897.namprd12.prod.outlook.com
 ([fe80::1c6c:f486:2201:9175]) by BN8PR12MB2897.namprd12.prod.outlook.com
 ([fe80::1c6c:f486:2201:9175%2]) with mapi id 15.20.5081.016; Thu, 17 Mar 2022
 06:43:39 +0000
Message-ID: <8cc0ae86-9a58-fb02-46eb-8ae4acb9fbc9@amd.com>
Date:   Thu, 17 Mar 2022 12:13:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ACPI: Fix LAPIC_ADDR_OVR address print
Content-Language: en-US
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20220221044333.19149-1-vasant.hegde@amd.com>
 <CAJZ5v0jkSZjYeNCbsQMj6GGAarnirDi0k0PRtXi3ED++s4_hxg@mail.gmail.com>
 <80024d19-5b56-ebfd-2b74-10175c6d7847@amd.com>
In-Reply-To: <80024d19-5b56-ebfd-2b74-10175c6d7847@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::21) To BN8PR12MB2897.namprd12.prod.outlook.com
 (2603:10b6:408:99::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 136cfe18-96f1-42a5-5677-08da07e1782e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1935:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB193561DDD38D8A442451751387129@MWHPR12MB1935.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3rNkycGaHyH1kTD6FtjmGGTgotcccr9Jd3VRnAZdHnx0dYw/7yxdSZjjfowKUBU4WZjYkLgUvrY9gF0JQTbRA9kAHW4zCmAvDbptute4wjmyr722qs0Vo+BUvURjejbvRFnI3pL3OgYnkGoavJMZwl0ArfA9GngJzwV16FEDHxdDmnZfZn5iJ/K/dvQ/W4X4Ugy40SGQS4vLz84vipoTO2FG2tqUv8l94D19emR2N/T8+t9ccPrJrg+yVX14AD/XUL6W93HKqoLoNoyPEdIhMBKUQ3dDfsojjCwT68UBB8uKV8TvY1GBLfbWYjNDmNd/bSLTt0EnK9FEO0aA1PIyF5ZBwZskXTQxOR+WyJ13vr+FMbG54j3zp46a1FP+dUTMsGFJAhpfeF5tsvqFHs34aVN/286ZtbOD2OIL/yXzXeFKaFAlJQIUURn/PaD5QDa3dhqkoVkUhxK4kErfx2Vu6gao0EWRw2iNNPeqnnv/UV6i+QUkaHWS6EY7org4yRw0XAuFb29OpX+yGFb86D/zqAZ6fTPTUYqJbxTNNWS94Jj022Gr4WUvZg4bFUeFAXjaGeDws4FBwuduw/r6ydvo5OvozyCKPMfcTNKk9PeKVeMZWme8p/lGVvhmBVvf/DQTgJHtjF68asEfeGslJNoXLN017w6AHCPzI0VTWVTo1Fqsa9BuKggDpiLC8tk7Gf7Cv90/mtA64qykPRwRSbHnDcNP4YVi+LA8dLsdkOv9i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2897.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(5660300002)(6666004)(83380400001)(8676002)(44832011)(66556008)(66476007)(66946007)(6486002)(508600001)(2616005)(4326008)(6916009)(54906003)(26005)(6512007)(8936002)(2906002)(6506007)(86362001)(31696002)(316002)(38100700002)(53546011)(36756003)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1lZWWRWNVpnd09iUld1VFNOamNGQjViNEw5cVJGc1Z1a0hlWk9tVmVBWk5Y?=
 =?utf-8?B?aXFzSWRmOFhZQlR3WklMZlJMR3JycFBvY08xSFp3NkRqMWw5S0h6ek9mZXE3?=
 =?utf-8?B?cHY5WFB5emVpVDd2dkpCc3AxZ3VLSFRKbkpiN1pIS1prbU1EQk1RRkxLZjZC?=
 =?utf-8?B?UkNIRndhaWxidEhQb0dqRnEwOVY0c3E4aE4vd1FmdGpPN1Vud1VwaVRBWk5p?=
 =?utf-8?B?N3RaREM0MjZpMHBIS3pKemdNTWxnWWZYcXJtTE9VRE1JbmtnZjgzUEFrSlpy?=
 =?utf-8?B?KzNmQ0l4YVpPUUYzVmk2MjF5bmxueUtOSlpMWSt2MDk5TWN4dklPMWUzSyti?=
 =?utf-8?B?OTd6NVppTEh3OHJ6MklMUGxnSzhuaFI1ZWd2Ry8vOWlXSVRENTBTZFMrZjF1?=
 =?utf-8?B?NVFnMmMyQ09JREdWa2piWnVIc21DMU44VzUra2ZSck9FaE9nbWFlcmFRTFpK?=
 =?utf-8?B?ZDZlMlA3cFBzRlNxMEp0NTJHMXdWNVd0T3FZdGNSM3JFT3crYncwNTdpVHo5?=
 =?utf-8?B?Y3Fzd2ZlRXFFZXhDQkpOVHFKV01WUzBqZFdCbWhoMWV6RXB3ZlR1MjJ0bE1z?=
 =?utf-8?B?NytJaklqYndtSm80aHdDL1REZy9TQXVGY0NHZmZSQllrUUpXRU1KcFJUSTNh?=
 =?utf-8?B?S3ZpRTBNS01GS0ovVzNhVThyWDdTeVhqL1VSS01OTzRzTnJyT0NGOENpYXVn?=
 =?utf-8?B?TVRqdkoybUR5TEcrRE5jOU1RY3FQbXB6aUVteWRHa0ovVjd2a1Q4TmNnNGNQ?=
 =?utf-8?B?eXZudm9qeHhIcnBNRW5ubGRaTXlOTE9WZ2NGSlJoV05wdlJOSFNONlRjU2pq?=
 =?utf-8?B?OXRldks2eWQyWDVjcE03QkhPNjlmTkZTMzZvZDZWV04xZnEybjFYQnVsMW1p?=
 =?utf-8?B?cG5qV2F1YXNheWxYRmJGWklMRktWN2xrR0x1QTR0allPM0Q4dU0wVmVKeTZX?=
 =?utf-8?B?d2s4bEN4aUJJOElWN3pWUE1la0hrRzRMbkliYTNxT2FDSjQ2YmdSK2VVSyti?=
 =?utf-8?B?STFiWXg2Uy9rZkEwT0tqS3k3YklHRWFTcmE2N3RhTmRCYVRPMEJraFEvM2Z1?=
 =?utf-8?B?QzdMWUptVEVoelp0S3h0OHdkYnlnSUd2RUFnN1FzTE9nQWRSdVF3OGZvQ0ZT?=
 =?utf-8?B?UzhIMTVBc1k0eWIzSkNTNE0wYXRLTFd5bFZDOS9ZWGxKdi95SzN1QWFlaHcx?=
 =?utf-8?B?QndBT0ZDanVWeUVlelkrZnJtanJQRnRoQjJPSEd1STBvdlRzcWpkUXovNFRY?=
 =?utf-8?B?Nit2SmV6Q1JRWEVyUGNZb2l2RndramE4d3luTFhmRjZaT1hiZUxSQlZLWmtZ?=
 =?utf-8?B?MXFwcDgrOXh1WTNZYi9IY3lQajNZeFlQdnBwM292aDRMSjFRcjhDQXpIV0JM?=
 =?utf-8?B?OGwvcjRESmszSTdteHdVdGFRa0Ruek1KTUFTK25Xamh4QmxhTml1RlJZZ3lE?=
 =?utf-8?B?ZXJQMUllNFp2VTg5NThOM21NeElhM3NNaGw0QXQ0ZEErbGpYMTBaQS9mUVkr?=
 =?utf-8?B?Vkt6bzR5RlMxejRpbENUUUJEUXlRUmdXaTZtQVE1LzFUajVVMGI0aWFYSE1H?=
 =?utf-8?B?Z2h6UEdPYU5LRGhxb3lJeTcwZVptb1RFWUdxRndFV2lROXR5Zk92UE14dDIz?=
 =?utf-8?B?TDIzNWpRU21UU1hKUUN5amxSM0wzVFcvM3pIeFREZWk2akZxL0I4WWhTdi9r?=
 =?utf-8?B?VS8xa05QYmZ0YTN4UHVKMXNHTnQ2ajc5N245UkNQb2xTNFNyN1ZSV1pYRzlR?=
 =?utf-8?B?TGp1UVdNcEpFK1Azd1hBLytmOHJoWC8ySW5HTHBVTmVydjF2WS9nWjJEMFZm?=
 =?utf-8?B?RkxsNzdyVzl1ZHN1L2pVOWo4NWZtZ0R1L2lKaDUvOTFDMFZacHUrM0o2SlZG?=
 =?utf-8?B?NC85dW9MK3lSajNGempwekpveHRPRCtJTU5FZG4vZ0ovQTMzbGp0UThtTVo0?=
 =?utf-8?Q?xVqRu+V95GgeclKBic2etdQO8XhLBl2x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136cfe18-96f1-42a5-5677-08da07e1782e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:43:39.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OCCdvepfk/r69DYkHYe8uk9/Fob0f6bjX8ad6KOsf2q1xlRd4RxKH9odaUBd+p6kix9cCJh6ez0y+K0MzaOFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1935
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


On 3/2/2022 10:21 AM, Vasant Hegde wrote:
> Rafael,
> 
> 
> On 3/2/2022 12:54 AM, Rafael J. Wysocki wrote:
>> On Mon, Feb 21, 2022 at 5:44 AM Vasant Hegde <vasant.hegde@amd.com> wrote:
>>>
>>> Without fix:
>>>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[(____ptrval____)])
>>>
>>> With fix:
>>>   [    0.005429] ACPI: LAPIC_ADDR_OVR (address[0x800fee00000])
>>>
>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> The meaning of this sign-off is unclear.
>>
>> If this a co-developer sign-off, please use a Co-developed-by tag to
>> clarify that.
> 
> Sorry for that. I missed to add Co-Developed-by tag. Can you please add below
> line before merging -OR- do you want me to resend the patch?

I have sent v2 with updated co-developer tag.

Thanks
-Vasant


