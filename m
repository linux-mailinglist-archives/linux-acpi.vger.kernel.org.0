Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2174170E762
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbjEWVcq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 17:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjEWVcp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 17:32:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9AFA;
        Tue, 23 May 2023 14:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN7FBFOqKhNKGRKsiAdaCP1QLqYRlegjSdxJQqRHTAnB4c+fja5QB04k+pAX/gzql9QTdI3UO0wugpW9xTRSL5jFN6KV11MHLj7WIPnvD5YfcqmcRN3OtZVWbEIwCySvyTzcExuOC6qRdU2BuFo/v6/o1ouMQreYcGJrJalc8SE2fWakkkDsVtF1531UMlGXyAQs66/vxOqQ/Hc7q4L5wAuRklkGCUFrdJTTjWzOqbBVrb5QTGhYaoJWu1z8io9gON9I1zMd+m3bjgrLl+MtRxr8QNkb7HoE0c6DPNn0KQ5xMtK9D0vHXsWNjuDcITYQIk1PXe1PnpXZnSIsUbWHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BMzOby1gFlEcEntUs9n4xqQBnkvV9+N/lcBbLWpZqM=;
 b=Ol4Uw9bxtnrIYpNWciWzxOvfio86GQFsvHSFUh+f8AleakndQVIhrrnwKS4sS4Psqe/Kr2gErd8F4BnX9sGV0WKQYbl1sfqUd+h1EshbeIPi/rX1u8wx6Sg+saeweDCye9Olwrlxw0iW+vMV/V1q6HLN58utIBTP2lX50Vx2wyK+hQvCJOPDLKYtL6q4s9IXAQuEsC1Knnqv5nkDXjIZzLhfYoLJFKd3gG0bVWr5Wdq+nqLqPEVk5A/RBYQeFd7/+MOefVg7zeRwCdWnObsB3Is6T3gyYMFU1NCcwRfooZ9wVsWzt0qvUwpl01p8bp6p18YqKaXggmKODmTwI3fTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BMzOby1gFlEcEntUs9n4xqQBnkvV9+N/lcBbLWpZqM=;
 b=tsQPxH9vggRS0f0g/WvZIyKN+TNXP1E7E0WtgWVLIAyByL/CTgHa6TIC8SSelMeoX/ygHzxKSi05BDkw1iT/SBIOoHGwt2QtLzfiwooCLrJgtuciFmUdEwavea/nkg0BaNcUMex0tQtO0fTcbdTfeWsn9+K7u0wr9dEJefEuCKFjscbstu/NuaxoirZeoPfVjP/h9BuAutohf0iE7WlYZsxplItrWuOWGCMoSgWyfYBt6y9Q7NFXxlTfUHtEaDUOskpXVtMs9HuNhA4Ojqizgiq809xXrqCcMLxaifMtkgTREZvFb0/mqH4hp0TdwIhGydEByEVW1h0ocdHtqf7CCA==
Received: from DM6PR19MB2780.namprd19.prod.outlook.com (2603:10b6:5:13d::26)
 by PH0PR19MB4775.namprd19.prod.outlook.com (2603:10b6:510:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Tue, 23 May
 2023 21:32:42 +0000
Received: from DM6PR19MB2780.namprd19.prod.outlook.com
 ([fe80::c62c:7fe7:679d:6a42]) by DM6PR19MB2780.namprd19.prod.outlook.com
 ([fe80::c62c:7fe7:679d:6a42%4]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 21:32:42 +0000
Message-ID: <DM6PR19MB2780DAE87B67BD49B6159A5ABC409@DM6PR19MB2780.namprd19.prod.outlook.com>
Date:   Wed, 24 May 2023 04:32:34 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: ACPI: what should Linux do for "call-order-swap" quirk from
 firmware?
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <DM6PR19MB2780634FE9D96D6FB72712B2BC429@DM6PR19MB2780.namprd19.prod.outlook.com>
 <CAJZ5v0j5hFbVh05wP5t49_j2kSkW9XY3WaqtrOb6YA9NJYHKcQ@mail.gmail.com>
 <ba0d326f-cace-3b39-00a5-4307a78045e3@amd.com>
From:   Ratchanan Srirattanamet <peathot@hotmail.com>
In-Reply-To: <ba0d326f-cace-3b39-00a5-4307a78045e3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [KQ/SHW7ZH8NPbqeXYFK2fxogguM8demz]
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To DM6PR19MB2780.namprd19.prod.outlook.com
 (2603:10b6:5:13d::26)
X-Microsoft-Original-Message-ID: <f9863bc6-872c-768d-753b-757c59743a3f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB2780:EE_|PH0PR19MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a20bb2-4dd4-480c-2c66-08db5bd53ce3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KascVaf6ymu89dEdlh9OE4K8GoNnhJlvQQrDFo5BpQ/gqPVgK5Zwrg0vhLwjpjhgaRsBkucntaFiXuX4iLgIfD/e2hRl+Z8+NifxmYk8Tv7F7oCJgqVDs7nxvU+rIz9FxCIY0uw3M/NQ8ndVFfKclBZnXwfnOZ94K3u2Pu24NYF+RcJbc6M42BzgvTHb7AgNsB6kGkfaWZsISvrGHXPeVNYIMYfeeZuVv8FAxr6iZuj4oEkRGntqukhVIExHqMvazc9SJJUmWlg0PtTvy2t15MZOujZVM0XmGZCOI5mSZ0TiIMIcxcXQ8oC2l+qMtLyNzHWNmEWOi7XpqiPi7NxpKAPEApIUNHSPKUPFht59QOsKnmehszHaTvNXi6RyQXptjvZIafXPu5iaJN635TSpyO31gvTURPgNMoRfmcM5ffRdfV9x/kz1pOJXEWHCLiEGV8ZikhWHFHuJCjZ+Zhz578Iyvbql/SkEe3gVuJLR7EMCDjiZuCJ+dcEksYVMc86UmR9GjfAD0GkgRcA55/1ggHCofQLQ6kUB40Sq9I1xJlsFZdn/g5JryXyxnqRSS/X9yQS22XwUofd5g78o+If77I+tqdCksxBt1Hsf1MsqxE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJxM0VaaUJBa1Z3MmRGSERram9hbU1MNGFSbUFRSGJLMVZDTUtIMmkxajlm?=
 =?utf-8?B?bis4bGJXNnN3K2h1cndyZzVsRzdSK3h4eXhUTkpTdEVTdFZmYmRYQ2ZDOTRX?=
 =?utf-8?B?Zm5UWW1RTHZQcUV1c3M5YlRuRjJHOC94TFNGMk1mcVZOeFRwVzErOThmVnJJ?=
 =?utf-8?B?MGkwaVJQSXBIUGhLeTJSRUZZYkx2TytCeWhPTkd3a25pWXZWV1lWMXc2REpK?=
 =?utf-8?B?ZXAzOGRWYXNlS1E1eVk3RWVDMVUxbm5FQW1jcmdRbnI3Y0NEOVBLRDNHN2tJ?=
 =?utf-8?B?QW4rOTBFU3E4cmsvOGZNU2dYM2hDWGRaSkVYblg1WFIyaCsrNVdLK0Q3dUpr?=
 =?utf-8?B?TVRNbUJ1NjVHSTFqTWlndnpUM00zd3M4dkhHVkpUOXN5TkNKQWo0RUhncWZ3?=
 =?utf-8?B?dTBYQnc2L01yVHZtVTFteEZpOWVhcTRvZ1JIN3ZDdUUrcmhBZ09SZDJkVkdS?=
 =?utf-8?B?SWpBVHBTdnBGMGViZWhCQ0hZa242TFZqL0dRanBwbnhuU2JlS3JRWC82YTJo?=
 =?utf-8?B?aDZPelphSWhicWJadE1TZVpDY0tBSTkzYUVtSVdQSUp5NVBKVlRXL1pOaTBw?=
 =?utf-8?B?TnNRYUp1S21UL2tYQ2VUamoxc1duQnpYQnpyUFRmTTFiMnlIbHNEVG9hVjVJ?=
 =?utf-8?B?Q1VKSnJwSDBjT1V1UGdtV2JOMG8vTElTODZ4QU45UExlY3A3Qy9aMnFzempW?=
 =?utf-8?B?SFhvTFJSNTNYckRxck9vb25rVllldzF2ZWN2V0JjaWkvS0JUalUwVWMwTWxp?=
 =?utf-8?B?MGhmNEoySnBaSndIWjB3MnZrVGdUazQ0VnFXcVorTGx6emdOUUdZVDFUVitU?=
 =?utf-8?B?TFhIWlNra095WVZuQmFvNTVTeUU5S2lPYTdKMFQwaFE2VGxwSWV3VGs2Ym00?=
 =?utf-8?B?cGw1RVRYc3ZLMGNtQWJDRS9HMUFSbnhNcnI4MWpsZWtuZGpGc3orTE9oUWNI?=
 =?utf-8?B?bGd4N2JvR0x2RXd3cHUybnRUckw3bHFHNHplMDdBUE1GREQvZ0lrbC9GdHNl?=
 =?utf-8?B?VXNmRnN5SFBXM0FNcHBxQitKRTBZRDRJU04xemptTkxacEE0SWtPdzdUck5U?=
 =?utf-8?B?OWRqZTI3TmhrdW1HSzdIbnJPa2J5QnNSYmZKZ1IyQWIyVCs5aW1FVytQRXBI?=
 =?utf-8?B?T2lMdkJzVW1FemxlSWdiNXFRc2tsMFpBOUZ5VDF2WkZkbTkxNU9QNVh2VURF?=
 =?utf-8?B?UWlDaTdCTXIzZkRHYXZWYlZwZ3VGTU96bElwVnNwUXE2YklFZXNOVmQvTFFQ?=
 =?utf-8?B?aTZueTQ1cFpQZEg3ZWt3M0paSU9KME5ncTZJWEE1andvTmhOSFVvVUxzcytK?=
 =?utf-8?B?ZWk1dWVNZ2pZaUJIbnZ6VngwZWJkbWlZejZhSENrOVRVaWJOS2t1TVZaSmNM?=
 =?utf-8?B?TUsrZFNtTW0yWUVqaE1zWnZSM3o0SU02RlMvUUhPcldDWG1ZbUh1ZiswK3l1?=
 =?utf-8?B?MUlLaU1TUkJUUGt3NFNtVkVlaHhxd3QxaVJEYWZ0WG5tMWFOR2w4WkJoMmhT?=
 =?utf-8?B?aTBacXFGcGNyNlRkWjhKdkZtUVZTWkR3UXlWWUJ1b3luelM1eUtLQ1o3VEhY?=
 =?utf-8?B?NWpMdnQvOTBRcjc0dEVLMEF0YzlPS01NZXBxZVpzdXJXZ0s4Sk5pQzhYNGRy?=
 =?utf-8?B?VkZ5RkUrWkh5K0RGeGZ1VWpPUUZQRVE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e7757.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a20bb2-4dd4-480c-2c66-08db5bd53ce3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2780.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:32:41.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4775
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



เมื่อ 22/5/66 เวลา 20:13 Mario Limonciello เขียนว่า:
> On 5/22/23 04:44, Rafael J. Wysocki wrote:
>> +Mario and linux-acpi
>>
>> On Sun, May 21, 2023 at 9:26 PM Ratchanan Srirattanamet
>> <peathot@hotmail.com> wrote:
>>>
>>> Hello,
>>>
>>> I'm trying to debug an issue where Nouveau is unable to runtime-resume
>>> an Nvidia GTX 1650 Ti in an AMD-based laptop [1]. As part of this, I've
>>> traced ACPI calls for the same device on Windows. And it seems like this
>>> device has a weird quirk, which I call it "call-order-swap" for a lack
>>> of better words, when it transitions from D3cold to D0.

Hello,

Turns out, the problem is actually elsewhere and the current method call 
ordering in Linux, while seemingly differs from Windows, doesn't seem to 
actually be a problem.

For reference, the actual problem comes from Nouveau incorrectly 
re-initializing the GPU after it returns from D3cold, which is 
subsequently masked by Nouveau mis-detecting the presence of power 
resource causing it to use a custom DSM, confusing the ACPI code.

Sorry for the earlier email.

Ratchanan

>>> So, a bit of context: Lenovo Legion 5-15ARH05 [2] is a laptop sporting
>>> AMD Ryzen 7 4800H with Radeon Graphics + Nvidia GTX 1650 Ti. This
>>> device's PCI-E topology to the GPU is:
>>>
>>> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
>>> PCIe GPP Bridge [1022:1633]
>>>           +- 01:00.0 VGA compatible controller [0300]: NVIDIA 
>>> Corporation
>>> TU117M [GeForce GTX 1650 Ti Mobile] [10de:1f95] (rev a1)
>>>
>>> And for ACPI perspective (according to my interpretation), a power
>>> resource \_SB.PCI0.GPP0 seems to represent the PCI bridge, having
>>> \_SB.PCI0.GPP0.PG00 as a power resource, and \_SB.PCI0.GPP0.PEGP seems
>>> to represent the GPU itself, which doesn't seem to have its own power
>>> resource. All ACPI table dumps and infos can be found in the issue on
>>> Freedesktop GitLab [1].
>>>
>>> Now, if I understand the specs correctly, when transitioning the GPU &
>>> the bridge back from D3cold to D0, the kernel should start up the bridge
>>> before the GPU itself. From the ACPI perspective, I should see calls for
>>> .PG00._ON() (power resource for the bridge) before .PEGP.PS0().
>>>
>>> However, on Windows [3], instead it seems like .PEGP.PS0() is called
>>> before .PG00._ON(), for some reason. This is weird, because if
>>> .PG00._ON() has not been called yet, .PEGP.PS0() should be even valid to
>>> call. Now, I have no idea on what part of the Windows system is supposed
>>> to call those ACPI functions, but my feeling is that it must be either
>>> Nvidia or AMD driver that does this kind of quirks.
> 
> I don't think it could be an AMD driver in this case for Windows as the 
> PCIe root port uses "inbox" drivers.
> 
>>>
>>> As for what Linux does... well it seems like when Linux resumes the PCI
>>> bridge, it calls only .PG00._ON(), skipping .PEGP.PS0() on the ground
>>> that the downstream devices must have been reset when that happens. I'm
>>> not sure that's the right thing to happen either, but at least it makes
>>> more sense. Nvidia's proprietary driver seems to disable runtime D3
>>> support inside it completely on this device, so I think Nvidia must have
>>> a quirk for this chipset, as I briefly borrowed my friend's laptop
>>> sporting AMD 6000 series CPU and it doesn't disable runtime D3. >>
>>> So... I'm not sure what the correct behavior is here. I'm a developer
>>> myself, but kernel is not where I'm familiar with. Please advise me on
>>> where I should look next.
> 
> Yeah if it's working properly on newer hardware it does seem like a good 
> argument for a quirk in the Nouveau driver to me when this older 
> combination is encountered.
> 
>>>
>>> Ratchanan.
>>>
>>> P.S. please make sure to include me in the reply, as I'm not the list's
>>> subscriber.
>>>
>>> [1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/79
>>> [2]
>>> https://pcsupport.lenovo.com/th/en/products/laptops-and-netbooks/legion-series/legion-5-15arh05/82b5/82b500fqta
>>> [3]
>>> https://gitlab.freedesktop.org/drm/nouveau/uploads/2659e5cb41a52290ebf18d9906408d62/nvamli1-processed.txt
> 
