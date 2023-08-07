Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB1771908
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjHGEii (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 00:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGEig (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 00:38:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968410F3;
        Sun,  6 Aug 2023 21:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5Rtp6MsmclL065ze9zYV3eBZ5vZd9uNB4jKJQY8Nvs22jPMomZzYzkNO/zuBYj6EYhy5llf7pk+Xhq3SGy86FvdbS3946pWWqmtdZe81IG+ha7VM5TAyhAXJzuRCSPJB6mmoeWA7eX3+12zKid5kyS3+Z/Ez8z5RPeXczvhpxdfZcFd6THz0RQD5ST8kZ/GcjZB+vddShQViFBkJy7saUHZbkSYmrkTNZ/IfQhpL+h4BZOkR3wySmJzN9xZxnyQ0+zy6wIcdFmEebrH4xFI50VPMZgYBkQDTw7iVMZATNDEn+kqd6r0wAFU98YSxMDwVpjGyqtSxY1NyMi4Q0EBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMQZiilamv7Bj4xdL8xKeeZcrze8TaqsPqdSZoWQ6Vc=;
 b=eKXIEdAfEUWKjyHV30Im7P96SPuu6R60sArIY8w7KBh5r8i+KZn02rAuT/zCJuMdZP5WEZMARX5wDH6yHCLVer18+v1LP2DyUjUmTrQ/3aVP+VQRGt2FAWGCHctGIEblKqlQWBWhVnMkOZRCnxKsq4HInEioYAWMwAhGen03MVDRtgzPLC8HoYc634RgRMMAFyIhFpneoNCZm3DoHtBaA8D9e5D7WB745SiiSjikaQVaXJEOkQmPHLKmDgNHYDt+14UOtzjeFLBxXDbvr5N397LBW8BwgPCTGQ7iqKcbX4CRjcUX8yjA5PdF+scynyF1AgfVPMGYJbzx5L9Eezh3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMQZiilamv7Bj4xdL8xKeeZcrze8TaqsPqdSZoWQ6Vc=;
 b=Zfn9tCYs62WV0qDVoZhbqwhKz/i/FXjgI9L53bRmeIMNRE66sl69HX+2nySipPD+As6QO2SGoqQe3vmc/4/g/kN6HF3GXRzbu/3ycSVFlqyyChoLyJB/xuDUSdLr5uZgHI8wTTgicVtd+muS5aJcM3GpPyeX4++u2p2r7rxoHXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Mon, 7 Aug
 2023 04:38:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 04:38:29 +0000
Message-ID: <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
Date:   Sun, 6 Aug 2023 23:38:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, August Wikerfors <git@augustwikerfors.se>
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
 <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7650e902-4f8b-4273-8d8c-08db97002534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2H2W+caBdlq2xHycCsfbAmcHMtp3BqOU5VANeJneRZSga7AwF3At8sOddpVOWBH3FtrcHjhdqBjt3Yj45KQv8VZXF9hdxrx/7CWKC66qxfTn6pVRtf/iQXRmrItsL9iwiO9IqcUcQJb+2c7CBHtD3yQZXoBfqs6EUlpHgPo9zYE2nh/iXBXrKG2yaLggxK2TxzyfCpTAGYOE6/sXng0T7sisQX3nhqst6rHuqvYupJ4qqzzNWWv1emFqG+1eXlQiAMwBJWpME+/cNp7mvodn8Au/rHBsKnSFacPf0GYJX4HCizIlghFfYNXcEyr7QXEbUmSk3mnD+xH5MUmnjo5KiNBc5PApozBUoBsKL/PnhfT45S9Yed5ethmv1K7AW8p4UHJPkAEx7I8rg+7VCJEI0zRjc7oBAu7nFY4xJKW15tVMvRuLNqObC4RgSUEDD+G3B2XKBpmoWeW2JtPyIklq0mPMqpaWu6ccgGUXeBKy8zwvBJvbgkwZt9QPYjwp/+FknkLGR0uG1jEEasD5VmUob9Wyu/XAkjwpCLHr86DMfz4DNoXKzUoawMMhKeYQbk9q2ZeEd5I3hR0zqFF2W8rxQYGSKa+cRddvxLuv08XzCJm++hVjRk6JLRImLk2pXjkM+fHvj76uZk4N8cU5Ycx+XfUfQwC0qUTMiD584RSOCYVwL/JsAKoTywS02628s5r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(1800799003)(186006)(451199021)(8676002)(8936002)(478600001)(36756003)(966005)(31696002)(86362001)(6512007)(6486002)(316002)(31686004)(66899021)(41300700001)(5660300002)(4326008)(66476007)(66946007)(66556008)(44832011)(83380400001)(54906003)(110136005)(2906002)(2616005)(38100700002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVXZnJBMHhtdFA4aW5QYmFiZ2FkYXRtRkNhclIzT1owT09WMHNJZSs2dnk1?=
 =?utf-8?B?Mm1JSkVJSFppVXpiSnJTTnMwQnlTcWlqVE8xYkFjNnliRDljWi81UXNsbnEv?=
 =?utf-8?B?ZlA0MUdmN2w4YWs1QmxIRXdwUGppeFd5b1NBeVcrUUN2SmhaQ1AvWWpTT2J0?=
 =?utf-8?B?OWVITXR0eFlybUVZSGsxVEczTU5NK2psRWhqSy9hZDcvVFh5V0RTQ1o4b3JM?=
 =?utf-8?B?a3hqd1JrTEhwSWdqY1NVbVdSWEtTQzZkd0lSdWhmajZic1R0NXNRZFN0VjZT?=
 =?utf-8?B?bmt3ZlpEKzUxbmFWSFlxVTRoZmdzM01jUkFrdzRRRmVsNnNzQStyeXA5UmVJ?=
 =?utf-8?B?S0pZaWpZQVdSelh2SEZoS2NhSE90VEY3cWU1emVaeEhtcUNXZDlSdk5OY1Rv?=
 =?utf-8?B?WmlzRTBsRFFZS0RscE83TktuNUNlQXVoWnl5eTFPWVZGNVVKNWFmbElGRXNM?=
 =?utf-8?B?NE84bkRUc3ZsaWxtUFhxdWxKdmpSUm0zdVJFSlJQNzdTSHZCbTZZa0FuTC9U?=
 =?utf-8?B?Z3o5L0tmWjd6SmRqdlZxZDR2MFRybWtUTHlBUjI5TUFTS2ZWQ2EvalN6RDhm?=
 =?utf-8?B?eFZIVUpYVVlaTDhWaDk2blEyZHZmR0hZSlhYaDYwc2YxTkNydTBXa0h0dWRD?=
 =?utf-8?B?U1J6ZExwOWh4Z3FrNEZoUzJ1T0JDMndoYk53QlNQWkx2TXpKZHN1L1RVdXh0?=
 =?utf-8?B?MlN0K3drWElXM2d1dXh4akIyS05CV2dONitaR0UyT2NrSCtpVWs5T2ltSzNi?=
 =?utf-8?B?TUF0UlpjM3NCcTlUZnBwSzU1V1NiR3dZMVlwRU5NV1NITUNWN0V2VUxlV25j?=
 =?utf-8?B?cmFkNSt4NTJyaWpIWWJsWjZZdUNDbEtUQ0NIY3FhK0FxSUE4TmNPRys2UW0z?=
 =?utf-8?B?NkIzQkl3MDE3YkpHZEMxZit5OWJGdnFlK0VmSTZha2hHcVp3V2FGZ3orM0hn?=
 =?utf-8?B?N2ZaTWNXSmdrdTF6WW5yaVQyQWc3QTJaUkV0Y1MxZkcwcW92OU5WaHJmL01H?=
 =?utf-8?B?Q2l1ZE9ON1VMZitqckNDS0lrSlFnVEhSMmpURzhYSk1RK1NNdFZXcjBmYkVS?=
 =?utf-8?B?ZmIvc1hJYnd1elY5OVc5R1JORUFYV1JSTm1DYjN4cWg5bDBuY3kwSWQrWWhH?=
 =?utf-8?B?UndFNVNmNWJqeFlUdmd3ZldMUXFjMnlhQzRza2NxSDJXdVZjVkFpVzdMQnNS?=
 =?utf-8?B?WkRTUkMyalN6RVpXdW1vQzkyNG1TWVJHZzhSSGVCa1FzZURqOFNLWjNzTllU?=
 =?utf-8?B?Y1VZbXhzSnl4ajB0UlQ2SmpTYTJyNGh4SGVRWjNoUzhYT0JQNWE2YnNSRHdB?=
 =?utf-8?B?QVdic05TZ1hUTTJLQnN4VGkrVEFFWmtuOGpkTjhYeWdxSmZmcVhxejhkMzdP?=
 =?utf-8?B?cVJOU1YvQVlIMVJXR2pDc2tPNXFsMlZFaFd3YjRWS0JERjBucWx1NW01Qmlp?=
 =?utf-8?B?VkR0eGU0YzZiRkY0WUx3akc4eEF2aWFDbDEvWStKeTJDbGpjRXFldkhQRzJs?=
 =?utf-8?B?dUxUQ3NTU21lb0gyb1IzRHd3SUh1NE9lOTlQU2FxOWxLQW03V2pTNWU0T1l0?=
 =?utf-8?B?YzIvRGJpcjRrazZkUEJOc1JsczVIdU9NZEloTnZvWGJQUkIwMWhwdmpRWXFs?=
 =?utf-8?B?K29YQ29acUk2Q210WUlHV2lYbzBkYnRBckh0QXlvT3ZmMEpRMnBGdStMQlVz?=
 =?utf-8?B?ek1XNEZoemRVM09HdmxiQzk1THV2SGRwRU4vWVcwTnR0S004VHVjaFhKUUQ2?=
 =?utf-8?B?Q2ZMVEJ0b205aTZOZVVrTkFlaW5zaFVteEdUOHAvcm9iU0Fob1ZVdEVxWDNG?=
 =?utf-8?B?OTYydHZjUG4vUUp5UGNDeURLQXZMMmgvamU4cGVkSVBXbnR1RFFHQ1hyVnd2?=
 =?utf-8?B?YU1Lb2hKZ3ViTEY1TktKQk5selZ1VWpiYkFGd3R2d0REUzNMQ2xHZlpDMXZR?=
 =?utf-8?B?QjdNYWx0eDJlUm5kMmkxTEJGYU54dGMzdWJwcjBvU3R5TnQ1WDdxVEFDdEhP?=
 =?utf-8?B?VHhCcS9JUTZ0MloyOTlxMU10SkZvdHBzT0pTRWhheDg2MHp1SlNaTGxrbTBh?=
 =?utf-8?B?RmtYNDBUMFZQaFd4VG5xT0UzVURpZFZtczUxbjFiT054MVI1K2U5VnR3ZFh4?=
 =?utf-8?B?WnU0WHkxaHhnS0V1bDl5N1JBTjgvUWdCUU1mdkdHWUhQVVpEZ0xNdHRHRFdB?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7650e902-4f8b-4273-8d8c-08db97002534
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 04:38:28.8066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fJpvgI6upXX6yQOrg3QD+UAAwUtxsfJw4T4JWnGJHu6gtv6Xy58w7gKIWtKXzaUUdWQDyAI5lh6IInnB7t1Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 8/6/23 13:20, Hans de Goede wrote:
> Hi Mario,
> 
> On 8/6/23 19:13, Mario Limonciello wrote:
>> On 8/6/23 10:14, Hans de Goede wrote:
>>> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
>>> quirks") is causing keyboard problems for quite a log of AMD based
>>> laptop users, leading to many bug reports.
>>>
>>> Revert this change for now, until we can come up with
>>> a better fix for the PS/2 IRQ trigger-type/polarity problems
>>> on some x86 laptops.
>>
>> Reverting it is going to help a bunch of machines but cause regressions for others.  How do you prioritize which to fix when it comes to a regression?
> 
> I understand where you are coming from. But we are dealing with a lot of bug reports from users of recent kernel versions (so not on LTS distros) where things used to work fine. Which is pretty much the definition of a regression.
> 
> OTOH the do not override IRQ on Zen behavior has been with us for a while now, so things which are broken by it have been broken for a while and have only started working since 6.4.7.
> 
> So to me it is clear that we first need to revert to the old state, so that users for which everything was working fine get back to a working system.
> 
> I realize this will unfix some very recently fixed systems, but notice the very recently bit here most users are no in 6.4.7 or .8 yet, so most users will not even have gotten the fixing effect OTOH many users are seeing breakage now.
> 
> So IMHO we should first get back to the known bad state, instead of introducing a new unknown bad state like a9c4a912b7dc did.
> 
> If there are known systems which will need an override with a9c4a912b7dc reverted, then we should probably add those to the override table right away.
> 
> And I think what we also need is a way to specify an IRQ trigger-type override for IRQ 1 on the kernel commandline, so that we can easily ask users to try a different trigger-type without them needing to build a kernel with an updated quirk table.
> 
> As Linus mentioned already, we really need to find a proper fix for this, but for now my main priority is to stop the influx of new Fedora bugzilla and bugzilla.kernel.org bugs caused by a9c4a912b7dc, counting the extra bug links added in this thread it seems we are up to 6 known bug reports for this and that likely is just the tip of the iceberg.
> 
> Regards,
> 
> Hans
> 
> 

We haven't even given a try to fixing it; I think the revert is still hasty.

I don't have a machine that can reproduce this failure, but I did 
confirm that my keyboard still works with this:

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1dd8d5aebf678..b74d7d8cc8630 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -19,7 +19,7 @@
  #include <linux/dmi.h>

  #ifdef CONFIG_X86
-#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
+#define valid_IRQ(i) ((i) > 2)
  static inline bool acpi_iospace_resource_valid(struct resource *res)
  {
         /* On X86 IO space is limited to the [0 - 64K] IO port range */

Can we perhaps see if that works instead for some affected people?

If it does we should be able to throw away the entire quirks table.

> 
>>
>>>
>>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>>    drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 60 insertions(+)
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 1dd8d5aebf67..0800a9d77558 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
>>>        { }
>>>    };
>>>    +static const struct dmi_system_id lenovo_laptop[] = {
>>> +    {
>>> +        .ident = "LENOVO IdeaPad Flex 5 14ALC7",
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
>>> +        },
>>> +    },
>>> +    {
>>> +        .ident = "LENOVO IdeaPad Flex 5 16ALC7",
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
>>> +        },
>>> +    },
>>> +    { }
>>> +};
>>> +
>>> +static const struct dmi_system_id tongfang_gm_rg[] = {
>>> +    {
>>> +        .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>> +        },
>>> +    },
>>> +    { }
>>> +};
>>> +
>>> +static const struct dmi_system_id maingear_laptop[] = {
>>> +    {
>>> +        .ident = "MAINGEAR Vector Pro 2 15",
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
>>> +        }
>>> +    },
>>> +    {
>>> +        .ident = "MAINGEAR Vector Pro 2 17",
>>> +        .matches = {
>>> +            DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
>>> +        },
>>> +    },
>>> +    { }
>>> +};
>>> +
>>>    static const struct dmi_system_id lg_laptop[] = {
>>>        {
>>>            .ident = "LG Electronics 17U70P",
>>> @@ -493,6 +539,10 @@ struct irq_override_cmp {
>>>    static const struct irq_override_cmp override_table[] = {
>>>        { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>        { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>> +    { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>>> +    { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>>> +    { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>> +    { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>>        { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>    };
>>>    @@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>>>                return entry->override;
>>>        }
>>>    +#ifdef CONFIG_X86
>>> +    /*
>>> +     * IRQ override isn't needed on modern AMD Zen systems and
>>> +     * this override breaks active low IRQs on AMD Ryzen 6000 and
>>> +     * newer systems. Skip it.
>>> +     */
>>> +    if (boot_cpu_has(X86_FEATURE_ZEN))
>>> +        return false;
>>> +#endif
>>> +
>>>        return true;
>>>    }
>>>    
>>
> 

