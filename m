Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAC70BF61
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjEVNN2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjEVNN1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 09:13:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E5CD;
        Mon, 22 May 2023 06:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECbVe3hQTJ4hQ8XW5FhOq80jl/1G8hvGBMFKEnA0YfjzuXt+PFALclxnR91rNV+093tLa8t1MBE2zDBemM6oefDJnr/+Spora4u6xYS12o1jIlryHYmMTaHdeX20zOrdCK9Qs6XG6WyNGplErcuYjYfF+qVZdskr7OT8z3g6RBTB1RVojcgduilIxsXhxOHWAoDWGtOOx4dw32MKy7OpicaiCD6fVmn2ar1t8XqIs6l8KrX8oJJ5YQRkcWhxtX+ejgNps8BsXvLloyWiMIuezqqHmpVxjBOHo96fSvrBHhG8lZcO9ZuhmnOWLxJjuwAvlXh/Xovi/ULcBpOeCn0agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePMFRFZ/3hF0rP9giI1XS00t8Ll50bVu+G16TpUkBrI=;
 b=B3j9Vkm4RYadTRyADjqKsD834t1Pfzw6V+NjdTMYwYLmgtEwraa0k7FGbxupy85l5X+e15EdE5hc5lJonjUknr8eNAW1aNBPAtP2+zPuMEmc1pqSRa1OZZujY1shXZz/UJOwofRfw+CAMQRC4xEX8Ckl2SLx0FzaAe5JnoJBz9niqwRSM8Todc1lmHEO4At+yZaeilMEt8K/vU/nwzKFnZcQDJR579LWp7NeChGR0YgLRREdGyzyAwygEHPvIs7/lCXZJQhi6MktTH5VHu6P47Z9D1RtgMvovysMkuNH26I/WxK4Q2jEYng+yJVEPxqjtnQtx4Yr+rnWqDy1r0e3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePMFRFZ/3hF0rP9giI1XS00t8Ll50bVu+G16TpUkBrI=;
 b=g057ZPIhkXZuQ4ZFEQgC4ur+963dlaL8YeJ534JTJIdhGHQS6BjqXTagWI6SLwABzFk6MZn+4j2WHGBq5FxJyukWcs75KKA15Qy7F1P4NFAkQUk0jouOFx5zTo/ZsEF0yAYZT12jXOYIHTIzbiCBDSSuIosCMJ6YlSL2azJHS4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8643.namprd12.prod.outlook.com (2603:10b6:806:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:13:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 13:13:13 +0000
Message-ID: <ba0d326f-cace-3b39-00a5-4307a78045e3@amd.com>
Date:   Mon, 22 May 2023 08:13:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: ACPI: what should Linux do for "call-order-swap" quirk from
 firmware?
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ratchanan Srirattanamet <peathot@hotmail.com>
Cc:     linux-pm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <DM6PR19MB2780634FE9D96D6FB72712B2BC429@DM6PR19MB2780.namprd19.prod.outlook.com>
 <CAJZ5v0j5hFbVh05wP5t49_j2kSkW9XY3WaqtrOb6YA9NJYHKcQ@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j5hFbVh05wP5t49_j2kSkW9XY3WaqtrOb6YA9NJYHKcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:806:22::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: b266eea5-ed19-47b7-6e28-08db5ac64c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9c3rw47EIygh2FXAj0S0osPb5FLfuQouX2yQY26NkoI81+VC9QPIX/DTzf+zwSKtljICZZMXKruZ7Qm88lVUBlNyzI3AVe503eCdKJ7s3M5EgA7F6Y2q2KCwZjym/OJGbuxP6HKkLGw+zR4Q8briP/qsjDxU4iZw7znQ53wm/eQCAL4yyJINBbU7g8u50Mgi2/zvWWMqsFGSr4CG9rf0TPtttThbyPBOKfik0fbZO9DIBQcSvwaI00RaMHXqX736QEDIZY3kg/Ibm/GySw27PMiVCSSLa6iTQR4Z4GjqrMtXUfgiepk4XwVAGTyYx91OeuHFM/z1BUgGJl1QFv9s0zAy0yS6+VGUTOPupCZQHKN4nEb0MGRlCVYi92YP/RLU4Zb0QImT+1KV/3YOh5a+9CPAhKrRjY+I7a0ilw4CtoXyHlv2x0c6TJgpr1FtaaDl34AVAtwBgmB8YBejkVMFOu/b5CPE6t7ZZ0SAOA9oDWNuiURYg+qTE8vqDzE1LlwvSMuNyK6YgInxtuCLahCI4hfv3RanQ0E7RJc3PXMIVY3/MnbmUW3+kXr+eZZznMQ6tD+nbOB9iGSScIu1al7ESsXJeKNdtqLsPTNcCZNpjwe2WdyYrbxLaUOugu7HcbtnPuEGBXXfJ/RFYSgUrT1Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(31686004)(2906002)(110136005)(478600001)(5660300002)(44832011)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(36756003)(4326008)(966005)(45080400002)(6486002)(83380400001)(53546011)(6512007)(6506007)(38100700002)(86362001)(2616005)(31696002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRrYUdTekJBeXNHayswc0xsNVJzOC9JNlUzbVMyK2dQUSszc0ZVRU9DcDBN?=
 =?utf-8?B?ZGVwU3hiMDRFYXJPYkh5c1ErQjlrS21QVDFSRGo2Ni9OdkNaRkY3TGFTcGxj?=
 =?utf-8?B?L284a0phQko1WUxOaGZFb0V2K0pXdVQzdjIxWWxiYVN6MTVxZ3dXTjZXUi9w?=
 =?utf-8?B?VUt4WEJ0WFEvU1BxeHBtWTZ6enhCNkhUYjhOWVNQMGlyVlZua1VlY3lQNXk2?=
 =?utf-8?B?aEZCSWhmVHlISXNyVUsya251RlFZdFZXcDI0Wlp3UngzWjh6TXllNmtISFc3?=
 =?utf-8?B?MXkrYzZGUHF0bi9tYmJjNkdmUUNmUUg4V1JGUDAxSkpMVGxrYndSK25xV1pr?=
 =?utf-8?B?bWJHRFd1aW1ZL0hDNVRTNkhkdkc1RGxOTzNnWmp4Vi9yMThKb01Ua2tpY3NZ?=
 =?utf-8?B?d2VlL3FwZnYra2drcjNvN1Uwb0lLSDlWUFBJZGM5Tk5oVXlKbHVoYWJhN2Nk?=
 =?utf-8?B?UEVvZDBnUWZFamJRVUFzWWFmWWdxMGlWR2hRbmlrQXJ6UlpnbmZnS3pPc1Nt?=
 =?utf-8?B?ZUJNNlVkcEZlWEI3cTc2VGRFWnlTb0ZIMTBOb01GZC9Td3J0L044TUhmSE9r?=
 =?utf-8?B?L3FkY1BqbitlaW9aZEt5RThtUm92Um1mdXE2MWNxS25uNzF3Tjg5MU4wQVJK?=
 =?utf-8?B?dzhtRGMrbjlja1RFSXZZbzM1REk1Sy84VUFSUTJDTzBJNmtabWVoVFprQVhS?=
 =?utf-8?B?VlhIRlVnb1ZNTVZ5WTJiTiszMzlmL3VObkhMdDlHMnBpVHI4dVhwL2FodTlx?=
 =?utf-8?B?OEozL3BNRTZRcjJDQjBjMDN6TDRsTDNkaGNjcGFobDI3UjJoaGZ6R2dpdk01?=
 =?utf-8?B?dEYyazVQb2QxUVVjeHFPWGJwM1k5ekp6M09EODVqT0xRb0dJWVFLZ0ZwZGI2?=
 =?utf-8?B?U01yLzVVMXVqcm1VR2Zlb2lZY0YySjhncHVpcS9pU01wWVoxUEdEUTRXdkdK?=
 =?utf-8?B?aktyVDZHSlh6VFJ6TlBxSVhZRUxucHFWd3pleERMQ2x2MU5RMm5UcWc3aTdi?=
 =?utf-8?B?Zk1vUUI3a2NmdDQ3VWVSVXdiRmV4cllhMUR2ZWFjRW5LZzNxS0xEbkdFZlJv?=
 =?utf-8?B?MkVERWdQL3RnMmJoMG8zdUxJdjFab0ErUThUVFdVdHpqOVEvWVJBVDNRNkk3?=
 =?utf-8?B?aTEyNi9hVkY0YTd6RnNXeWJEZUlFV1Q3VFdLOC9ZejdjWjF4bEZRckI5ZjY5?=
 =?utf-8?B?TnB3bHBwQnlmUUdwVDF1RUxMc3pNN3VZcGdiZ0ZmL3c0VGtZK2NUUWVUbzll?=
 =?utf-8?B?cUlGV2hnRDVUbUpPMVQveTBpVkpFNlVWVWZRcC9uMlEwQVlZcEd2b0VNMkFE?=
 =?utf-8?B?N2NOTnl0UlRwdTEzSDdoU3BXbzV5N1RiaE81ZG1pajV6WWVOem1ZRW82bURZ?=
 =?utf-8?B?aCt1Y3ExaUlxQURkcWpmYXY4UE54SG5Ta0JLd1ZqS0RyTFpQbEZMZWhJYkwv?=
 =?utf-8?B?TjI5U0tYdjNTTzE0WlhxTDdnTmd2bFpoTkZYaE42U2w3NFJyTEhJOUhUSEZ3?=
 =?utf-8?B?WXQ1YXlsYUJBTmRJUHBwWG9XdHZHN3dmbDN2ZU5XSUZxNWpkcGU4dWZUNHJF?=
 =?utf-8?B?cGRaN2tmaE1MMmdsSmRTMllkbDFEY3lTSm05enlnRnJ4NGFvaGZUem9mNE9H?=
 =?utf-8?B?aE5NbjVYMG9hVnF2a3pvU3RHbVVQMXFEd0tudjhoeGN0N3QvNjhuM3UrYzIx?=
 =?utf-8?B?djVZcjgvcEF3SG5EWC82dkYvNllkcFg0RXF4eUh3L2FGWXFKQU9WYzJaVlph?=
 =?utf-8?B?eEV1bkZ1M0EvRXJjenRSMDRSaHpVaGNrQld1YVZNWUMyemw5c0NKa1F4b1Jx?=
 =?utf-8?B?em9wZDZZUlRRRWdMcUxxRzk5anFaV1M4bHRQUEE1dk1venlWUGNBZmVER2l0?=
 =?utf-8?B?aW01d01NcmIyTkpFcXpDekxwZTg2TlRlRWJoa3g2N2JNcEtxdndudWlMbm1K?=
 =?utf-8?B?UkZic0lySGtzY3doWUtsTWJqVGxQM3NFSm9uN1BnZEZlK0F0RnhJdlo1Zk5U?=
 =?utf-8?B?UUV6TGdkMlZrZFZiNEltYTVmN3FnSlhwS1l0UXl2MDlISVpRdkRJR1JYL2d3?=
 =?utf-8?B?SUk5Z3dQTlZIRHZpbXRadkY2TVZVcEtQcVcrYUdwcHlUcG9qV3A4YkVldlRI?=
 =?utf-8?B?VC9CZHlkVzVCMTcxRjRyNlNHOTV6UEtWVGJ5OHlQWTVzVGxEMEM5czB1ME1N?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b266eea5-ed19-47b7-6e28-08db5ac64c3e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:13:13.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNCSGAUwxdDxkMr2Jq3HG4GrUn4tMxxKA3YOSLy0H6akFDxGkKebB8FoOWysI3ekAiOOh5OMokR+M2Q4ef64gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8643
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/22/23 04:44, Rafael J. Wysocki wrote:
> +Mario and linux-acpi
> 
> On Sun, May 21, 2023 at 9:26 PM Ratchanan Srirattanamet
> <peathot@hotmail.com> wrote:
>>
>> Hello,
>>
>> I'm trying to debug an issue where Nouveau is unable to runtime-resume
>> an Nvidia GTX 1650 Ti in an AMD-based laptop [1]. As part of this, I've
>> traced ACPI calls for the same device on Windows. And it seems like this
>> device has a weird quirk, which I call it "call-order-swap" for a lack
>> of better words, when it transitions from D3cold to D0.
>>
>> So, a bit of context: Lenovo Legion 5-15ARH05 [2] is a laptop sporting
>> AMD Ryzen 7 4800H with Radeon Graphics + Nvidia GTX 1650 Ti. This
>> device's PCI-E topology to the GPU is:
>>
>> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Renoir
>> PCIe GPP Bridge [1022:1633]
>>           +- 01:00.0 VGA compatible controller [0300]: NVIDIA Corporation
>> TU117M [GeForce GTX 1650 Ti Mobile] [10de:1f95] (rev a1)
>>
>> And for ACPI perspective (according to my interpretation), a power
>> resource \_SB.PCI0.GPP0 seems to represent the PCI bridge, having
>> \_SB.PCI0.GPP0.PG00 as a power resource, and \_SB.PCI0.GPP0.PEGP seems
>> to represent the GPU itself, which doesn't seem to have its own power
>> resource. All ACPI table dumps and infos can be found in the issue on
>> Freedesktop GitLab [1].
>>
>> Now, if I understand the specs correctly, when transitioning the GPU &
>> the bridge back from D3cold to D0, the kernel should start up the bridge
>> before the GPU itself. From the ACPI perspective, I should see calls for
>> .PG00._ON() (power resource for the bridge) before .PEGP.PS0().
>>
>> However, on Windows [3], instead it seems like .PEGP.PS0() is called
>> before .PG00._ON(), for some reason. This is weird, because if
>> .PG00._ON() has not been called yet, .PEGP.PS0() should be even valid to
>> call. Now, I have no idea on what part of the Windows system is supposed
>> to call those ACPI functions, but my feeling is that it must be either
>> Nvidia or AMD driver that does this kind of quirks.

I don't think it could be an AMD driver in this case for Windows as the 
PCIe root port uses "inbox" drivers.

>>
>> As for what Linux does... well it seems like when Linux resumes the PCI
>> bridge, it calls only .PG00._ON(), skipping .PEGP.PS0() on the ground
>> that the downstream devices must have been reset when that happens. I'm
>> not sure that's the right thing to happen either, but at least it makes
>> more sense. Nvidia's proprietary driver seems to disable runtime D3
>> support inside it completely on this device, so I think Nvidia must have
>> a quirk for this chipset, as I briefly borrowed my friend's laptop
>> sporting AMD 6000 series CPU and it doesn't disable runtime D3. >>
>> So... I'm not sure what the correct behavior is here. I'm a developer
>> myself, but kernel is not where I'm familiar with. Please advise me on
>> where I should look next.

Yeah if it's working properly on newer hardware it does seem like a good 
argument for a quirk in the Nouveau driver to me when this older 
combination is encountered.

>>
>> Ratchanan.
>>
>> P.S. please make sure to include me in the reply, as I'm not the list's
>> subscriber.
>>
>> [1] https://gitlab.freedesktop.org/drm/nouveau/-/issues/79
>> [2]
>> https://pcsupport.lenovo.com/th/en/products/laptops-and-netbooks/legion-series/legion-5-15arh05/82b5/82b500fqta
>> [3]
>> https://gitlab.freedesktop.org/drm/nouveau/uploads/2659e5cb41a52290ebf18d9906408d62/nvamli1-processed.txt

