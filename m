Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94AD772C13
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjHGRI5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 13:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHGRI4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 13:08:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA2E63;
        Mon,  7 Aug 2023 10:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsF+Pk6gccPv0U8fftILXRu5Lxd5OcIX7DcoA3yFFPe9GfxWU4t9CCPNEuHb0LT/IQ/kq4wShHAlP5emCw6JJGhBATTJfe1iJFjehy0n5q/G8I+w0qmeNT972SuZsM/EM5Kaf+c8/quBPUMK4HLuYSj38R+v+pCD8KrnaX0I9wRQ2J9w7dGR67uQxhwW07cmqTZ0wp6JTqvRvWPWpMvXQrSznYI1PpzkMeZ8MhTH45F8IXiE0StK2bHqoTLWqxOigkLdUnoZw94gQL6VGBam0Mcsdxm9cslBf+4PVcZcLbzZ7YElmsqF1HeQA4+iQLecH7GxrjQ61Z5HJpZK3aN++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBgxWkBGdCpFzsf9QOxFgjylREVWy32svi5YVO0UqNU=;
 b=JnJNAjIdvUBAZxR8STBur0eI9HoFpBEKRzcArnP+f5/oWhf87U507xPey/jDTgPgl9qgIMLI2zd/2Lus0T1oNBTRIZs3vCaQxdHeFCSwNNmOykxfwzvzEWOUk7Hir/z/VKQkCcDAkTKFRz2UbWgTIo01IAEN2f419e9DVhrnotCW2geSlY13Qx6tyobMwIqe7WZjf3DIwNWXJSWOhdtCDpNblZ2lZKYq1Qd0OMgwG0vgODuNXnCDmLusABoA7xNgcBDHrirm5cZ4iTupbhG1Nk7XhQnKWo+HPBn2UQOc9pyDo76LNS369PrayRXKAhf0vRpXBZw7ztR4zMKhkttMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBgxWkBGdCpFzsf9QOxFgjylREVWy32svi5YVO0UqNU=;
 b=Rm0qELlc+XTJQacmAi4feIeSK0IwgN8jimEVQrg1UGGzDxe69O7h0SQA0aGWIuhs2fC4okMAG32Qwp+0rjDsoC3SCEysvZ5qCNAG54ic56AIw8bIv4tK/tI6+9fn3+Z0LY715tCBxKImtN6ORLdi6ZwPD0Sbcvydfe8imFwj3Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 17:08:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 17:08:49 +0000
Message-ID: <b924de62-861f-45d1-8a35-6b47f27ec5fb@amd.com>
Date:   Mon, 7 Aug 2023 12:08:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, August Wikerfors <git@augustwikerfors.se>
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
 <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
 <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
 <8f0cbe61-99aa-8c45-c29e-69c27ba96d81@redhat.com>
 <561f0807-a78c-4dab-b8ef-a0f0836902d9@amd.com>
 <4fae943f-6e72-3297-cc73-e1087e7a45bd@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4fae943f-6e72-3297-cc73-e1087e7a45bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d9a48e-41f5-4846-dbaa-08db9768f797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2I93vZwQk2XnP5p+SZTu4bXTIy3AKQxorZX07tVcBmLHWKeY4HMi9PdidZKtyXmQ9/trC+l8l+H6/Kgc8XvK4WBTxiZjtWifgdy+ulto4dyR+xOxgQcv7ODjp/EKi0B5wEzKLiPagS5zjrn8E1Pdk3tM6mn3iGlloqdGSgijE1+p8LumYmJvCynkUA9mk5bdu7+qEQ+k89sJOdej46WdyqEiQy2yReeRBRADw1k9WZA8yMeq3nFdHLdzS7MXyIL9ykEyr+vd6XJ/T8VtRu4AHVHuN2KQyMHwCedr3ajt+REpyH2jrKTS76FMCEuFctkVBwFYtZ3OonZGpL7H45U6iGynfa1SmPi1ftp27qXCzDIUoiJ/fPbtb0trHtV+zuZbTEnN+Ht7QhOr+TuR0Gc3g+rwIBeOp+CLwIUmMes4s0+emY7Xp8YnFMWRVDdA6oH1eUvzKEz6yh35ffiEViKkjwXqGH/vQUQUAs+DnXq0BOsSIXdiif6Asz/l7/jDXYHuX4h3jHPtoVBKRGkTvRUHoY9yS4fczC9FaV9bQcS7GEhYmcUWL6G6Nv6E+1zKwf/SUXZpoVbHuqQr94gfquKPPlDpLq3T12RddMNJhYDvkjwq4wx+7bCHSsp/3vfUjmxBk7WYaoHeZt6zoLR4GWszg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(66556008)(4326008)(66946007)(66476007)(2906002)(6486002)(83380400001)(5660300002)(44832011)(41300700001)(8936002)(316002)(8676002)(38100700002)(2616005)(54906003)(110136005)(31686004)(478600001)(36756003)(26005)(53546011)(6506007)(31696002)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pjVDNNemdvT09IOStFMGc0eDYxZkY4VFFMMC9IZUVPZUh1RmRIeWVkWDZJ?=
 =?utf-8?B?M2N5YXBNQ21jWkJoNE1SbUhJYkNBbVZrTGJRWU1sQkhSclJoaWEwM2RNTUh4?=
 =?utf-8?B?Nmluek5FRVpuSThNMENrYVptRmRVbUNSendHSUpwQzdUVmJoaGtHSUhGY0Vu?=
 =?utf-8?B?L1JvdElvMUZVK3Y1MWtra21qQWs5UFJxT0tST2tlbmhCdEMzWWd1YU9zM0Zs?=
 =?utf-8?B?dmg3QUs2aERpODBQZi9tOWt3L3Mxa2RsMmV1RStvWG02WXNwSFNvaVJaa0xy?=
 =?utf-8?B?VGVCNXVpVnBScGRrb24vZ3luSlIrN2I0WEc0aDVNZklCODdlblhaRzhZcHVv?=
 =?utf-8?B?TFAzQkp3UnFUdEZGMnJsUVhEK2ZXMEkwWDViTmVIT0hKaXNUZ3lTeW9tMWpy?=
 =?utf-8?B?UVNWMnBCeUpHaEg1VURZSHpKd2tkdU0xTDY1U2JCV29NTzJtQU94WTh1dTRV?=
 =?utf-8?B?TVV6bWtycHhZREJ0NldScGQwQk96R1h2R1EwdGZJTHZYbVp1ckVSZ3ZReCsz?=
 =?utf-8?B?dlVlcCtpdTFOR1d2SXZQZXloWURONWpWNGZObTJyWUNwT2RDY05SUzhhN3Fv?=
 =?utf-8?B?U21lQ0xDcHFWNUZFYVZBc0tkbXUwYTdrcnFWUkFEMTM1WS9mSWkzb2dIeVdx?=
 =?utf-8?B?RGVZRk5GRS9aclZwdkttZGthWng5U3ljZGoweTcyWkRNSlFoWDExWk50UHVQ?=
 =?utf-8?B?aEV2OUZFNHo4OGtQcXdnS3dJR05uZUVGSWR0ekdmSFAxN2pwZDJtVVJhdVJX?=
 =?utf-8?B?Q3lFTlNpUXVWWmFGS2gvUVdXMSt4dXhUZm9mVXVNNCtINStBYW0rT1pSUHpX?=
 =?utf-8?B?eHpkR2lWajRBQTZqU0hVK1ZIdzJ5YkVENElzQTZFbjVyYURLSWlTTU9rUFJG?=
 =?utf-8?B?Sk9vczdKTTYxZ05jL3RpWE9ZUGZDcFUrc1J3ZXRPKzZ4NTQ5VSs1VTgzbXYr?=
 =?utf-8?B?cHNqczd4ODA2NklHZ0NkendDSFpuSTFDRkRkWHdEWUNGWmYyN0x5OVFkWjdx?=
 =?utf-8?B?TEY3ODVLVlR0QjNqRDV0anJWRnUwTDFrRmR2L2FHbzIzTXE0Ukk1dVFTT1lC?=
 =?utf-8?B?bGF6YXBsa1RDWlEvTjZLS1NSNDhlK2J4dTZOME9MdGRIMnhFK0FTckd5aW84?=
 =?utf-8?B?UlAxNFJrcmoxaUVBQ1ZjN0lDZEF4dDVoeGtzMXA0TlNTMVYwT0RJMkJZMmdP?=
 =?utf-8?B?dW1XWDRoSmMxOGRlRDFCak9QSUJleWtKSWlaOUtVMnU3bDdLVm9WWFVnS2s1?=
 =?utf-8?B?dE55dU04cTVMRXlzRFo4M09RajFqQnI0SWhLU0doeTVPWjUyTlRQd2QrR3pl?=
 =?utf-8?B?NG1iNlFuLzFzcXdaNElGalcxcWxKbVVWeERUaXVBN1oybEdxZ2s4d0FCZUpQ?=
 =?utf-8?B?eDk4My9DeWpMVHpaZkZqc1E1L0R5ZVJDNGQ5dVNYVGdwc2duSWJPQ3pxbWN3?=
 =?utf-8?B?L0owbkYyZlVkVERvK0FJNlZQbTZubWljbTljaWE1TnZrZytQcENncHJ5Y1FF?=
 =?utf-8?B?aXJBT2Y2UmlGbmRrM0tRVElhMnUzME02aWp4akhhTWdvOWptT0pBWGNYZXc1?=
 =?utf-8?B?dUlqL01ZeXpjd2hqcExVZzVvTldkSlJGeUJXSEZIaTQzKy9rV01yOWRuWFFP?=
 =?utf-8?B?ZGhHTldxNnlETFJRVjcrUDdFQ1p5bk56Q2N4SStaaDl5Z0crUHArTEJPUHlO?=
 =?utf-8?B?clpmUUw4cmkxTlVwNkxZdkdjVEdCVU5pOXNFMHlCMUNoNGpvOFVIaGVUdjRo?=
 =?utf-8?B?MnVacUVld1RJMEMwV3pNeXRJOUMxQ3p3eC96WmgxTEZoZGRmWGVLc3FVVXJS?=
 =?utf-8?B?am9VSng0bTB1ZFRXMk5zOTl4WHYvOFFLUDlmSjdpTE04WlduS3BTSVlzWVRU?=
 =?utf-8?B?cm9nVTRtS0pGWTRSRGVIN0NNbVdIR2NsUWh4Vm1RK3V4UXltdTd4M1BPWnNs?=
 =?utf-8?B?NlZYSzVLdld1ZVdNdEhOMThRZ1hKZnNtS01xTUtpYmF2VjcrWFYrOEdKR1Vj?=
 =?utf-8?B?T0VpcDhjM2tHYkFlSlUzRXdNT1hOTjUvK0ZUVkRjRWdySHE2SVQ0RVd4SHM2?=
 =?utf-8?B?bEVSekFweW5xMmNTeUx5bFNROGpBY0g5cDV5THNsOEFudWovMmxKekE1eXZW?=
 =?utf-8?Q?thpkvJ9J9NoHrxU3X6fYsOtr1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d9a48e-41f5-4846-dbaa-08db9768f797
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 17:08:49.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGbUMEa313Swn/6Ddl/ONXWlTJ+4UOaS8Pcmjrl7SaXVJ99+h89MXqOMoockoHt7Q08ldWz0ico0zGj3WFPmJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/7/2023 12:06, Hans de Goede wrote:
> Hi,
> 
> On 8/7/23 13:39, Mario Limonciello wrote:
>>>> We haven't even given a try to fixing it; I think the revert is still hasty.
>>>>
>>>> I don't have a machine that can reproduce this failure, but I did confirm that my keyboard still works with this:
>>>>
>>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>>> index 1dd8d5aebf678..b74d7d8cc8630 100644
>>>> --- a/drivers/acpi/resource.c
>>>> +++ b/drivers/acpi/resource.c
>>>> @@ -19,7 +19,7 @@
>>>>    #include <linux/dmi.h>
>>>>
>>>>    #ifdef CONFIG_X86
>>>> -#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
>>>> +#define valid_IRQ(i) ((i) > 2)
>>>>    static inline bool acpi_iospace_resource_valid(struct resource *res)
>>>>    {
>>>>           /* On X86 IO space is limited to the [0 - 64K] IO port range */
>>>>
>>>> Can we perhaps see if that works instead for some affected people?
>>>
>>> That does not just skip the override stuff, it will make the kernel return irqresource_disabled(res, 1) for the kbd IRQ:
>>>
>>> static inline void irqresource_disabled(struct resource *res, u32 irq)
>>> {
>>>           res->start = irq;
>>>           res->end = irq;
>>>           res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
>>> }
>>>
>>> Now not much code seems to actually check the IORESOURCE_DISABLED | IORESOURCE_UNSET flags, so this might still work but it does not seem like the right thing to do.
>>>
>>
>> Right; so it makes the resource get skipped when PNP is enumerated.
> 
> Which AFAICT means that PNP enumerated i8042-s will not have any IRQ assigned at all and this will not work.
> 
> Regards,
> 
> Hans
> 

Yeah; I did some experimentation with some other machines and confirmed 
this doesn't work reliably on everything.

Your newly proposed direction sounds good to me though.  If you can post 
a new patch for that I'll test on the stuff I have.
