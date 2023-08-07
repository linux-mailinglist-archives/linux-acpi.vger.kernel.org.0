Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3770C7722ED
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjHGLmw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 07:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjHGLmk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 07:42:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B932709;
        Mon,  7 Aug 2023 04:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORjmxrPg9YCUzLtpCuRblNavNgZVeN1InBqFiOzmvjn8w29OFxRLcGwSf8Wr98HWU4ZlRIN2KG8PF0rdQZIlEayVAfzbid47vmr6TEwFqLWrNH6pDbr50O0RW1GPKzPfXL1KRcOLVeqw95v2O86e+EkylyDjfYIwr2wmLi7+Ovwtax03hqFjKGyEHpq9rU1XA5Lm4sYbmtplbWGuz1aJvY4NY9Qe0ebsep+PvhguwVvGMxHkp0+4B18DQx1bOSZaveOZbeHG4l9YDPS+lMg4EkUHQwSUlqQ+dcdl82rirelGD8uPTM5vDAfXHTfxoxGWt/yukWG/F9y/njVlGxPIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJUiiXf2uIow2qQa7K+aK3Ql8WiLaVoFQanao5VEEtg=;
 b=nhcWbJ1w6eA02VFfHG4940OmNHYqZPv0gSnPzoI1Gi6rlfamfcKzlkns2ugIB3Ka0+Zocc5RE3hIcK8/LurE0arMnZPLhmoVdu64h19a3JkZPFGTTYPgU/7Q3BVGZx5K4J5ThoJVNSBdAoVtU6Zd3aMK4V0ux0SuWYiuGXF2qXzwXmoKnQ6ukRlV0+EXd/Y7/GxRc1hXHW+siON/CZb1tKljaUxHOt4B80H7XiCLWkyUYLutVLYGQmR2rJQCsUO6Uqyc4+zVks2phhDPiHJyHQzV4agChZV+/piomf+co3ryiCZbRSfv4JSUwy/6zqkOJg4/0bAdsDSZaN0EIgbIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJUiiXf2uIow2qQa7K+aK3Ql8WiLaVoFQanao5VEEtg=;
 b=FiZ/KDPSD0IuVSDeiVoYqcQFg1TUV7/mFG54WmN89W//LRqsBC1IbG7DCvOuPUheJBM7Sf9u986iZKI2JD/LnUktx38rVM1hZTrM0QsIfl0Utxzcbon2KTXHA2Tyl7xoku9sPIgV5kPZYD4je0LWID5yS9k+VBEhNuxWt7pPw94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:39:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:39:01 +0000
Message-ID: <561f0807-a78c-4dab-b8ef-a0f0836902d9@amd.com>
Date:   Mon, 7 Aug 2023 06:39:02 -0500
User-Agent: Mozilla Thunderbird
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
 <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
 <8f0cbe61-99aa-8c45-c29e-69c27ba96d81@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8f0cbe61-99aa-8c45-c29e-69c27ba96d81@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: e199206c-6adc-4d71-bb48-08db973ae551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvP/o26+BMTIXM/2j+NiG0QthCKd3KoPFHPP0aNRxsK9VUDAO8ufkBHLkXaMeBkwmccmTzNGi/zcKbOUjr7tQ0B4hHvbx2vNWvWHRlOiCMzObqf1qH57qVXbnxWOs85XP2pA4XKskU6xDL/5/ivLtmMK+DB30s57WIBbC8s3dkdbqHygJN6FEq36zGheYDCit0rSau7d2RsxdlqM8C1yElm6aGHssPkHkOFt/YBU47l2ESTEZmnYSKIJhR08LLp24gx8Emg5Gkx/7kH3t5RENQ2bBwvoiHWHzaLAfOiUkGgp0AybYZhIeFX1G2mHl0zpzTtkdzAKNwP1Eco5VLAbJLRbgiqEialqb4QSHENwkNZlxDxJ5FS0wTZc+ZPqhYkpME3LDlPq10xpOekyHGH8/67bFntRVLaWWMrlXtCXLk0ZtRxQ4sjy0oN50W0J0OMYX1Ce/F3ZhSX7Flg0jn+DWtI/ynmIB8RZeXdvbDzHEyPdvYJVg61EW0KZ+FDeeWkoOvE1fr7CDcSZB4LU/duLTQHdITZhaC/ZPLv8wN6/CA6Pzi5jK0iP2npLP282kpUu4RnLZ+IrXS8go072iUsdqlIrQSRvH/UgzAmXaa+DloVMlJwSK4qS1aMXrv3eZmbqpXbMFBHMsD1aHKqr9iZx4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(66946007)(6486002)(66556008)(66476007)(31696002)(6506007)(41300700001)(8676002)(8936002)(2906002)(83380400001)(5660300002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZEakpldDZDTUdJSktZd3ZZV3ZMa1B0TWo0aXYrdjJteTd4bGo3VWhnbWhS?=
 =?utf-8?B?eUNCenYvUGF0aWlFUnJ3L0lvM0VGVjdWUXV4cVdTMXFZcDhaUmtueEF1dHA0?=
 =?utf-8?B?NHh4L3lDaktTaVc2SUpyZTErUDJ3dzNuamVUSUd4TFcxb1gra3V4cTJqOEFo?=
 =?utf-8?B?bG4yT01CcmcrVnVuWWxLZmxFR29BOHJOUE1acW5rWUZnWUIyUDFXVDFZdHFz?=
 =?utf-8?B?NHZuTU9mZGE2UWpIbVhZUlphSE5lamprS29UZG8vNzNwc253ajI5cGRkL2Fo?=
 =?utf-8?B?ZHI5SStQcGI1NXRsNXRlRXJNeG04VnhUZjBoV05JTHo5Sk9kMnhydW9ZZWtq?=
 =?utf-8?B?RFNSTitWYVM3STZvQ1dJQUdPVVJWM1VBUEo3WnNTekZsbW4xbndNOU8xM0I0?=
 =?utf-8?B?N0UyWXVyZ25ybWFlSm1ndXZPWDNrcXZ4dlZwaHBBUzA5bHdQVGQwemdOTytU?=
 =?utf-8?B?a1NtYk15ZXM4R3dRa0pCZW95UGR4VG1QV25CemdiTWVINDB2VnA5ODczajhY?=
 =?utf-8?B?ZUphWGVtUi8wMUJjSW5hdDBSOEdoSGdUUVptc05LcmQ4MXRGQ2VWRzRCNk9F?=
 =?utf-8?B?a0M5UTV4OE14RVBTTWhTYzl4cDBOUDFpclZjQjNaZFQ2ZkF1MVVLb3YwK2Mr?=
 =?utf-8?B?cWxLM3BCazdiYTBrQ3BTYUs2bDU0d3RHSHRqbGtFVVgzUXh3d1ZZeVBlV2Jj?=
 =?utf-8?B?VTl4ZlNPb3Z1ZXA4WXpGV2lEM0dlUkF1dk1IUjhJT0lVWmowSW9KZUorcDhO?=
 =?utf-8?B?ZmcrdVk0RkpBNFdYUTNBSlMyNVpMVVlkcjRpM0dtNTJHS2QwUjdnc1pIRFNW?=
 =?utf-8?B?VkUzYzdaK3lueHhLT3RobkZnWE8rRDY5Z0NNZElRbTVudXJnZE12cXBqdEIz?=
 =?utf-8?B?d1BRZ0RmSCtpazJUc01CYytXdDg3R0d0enhxeU94Szc3TndWaWlSTGpzWGJv?=
 =?utf-8?B?ZnFTRnpORVBtQllmV09ndkhHNTJKVmErSXphQUYxRlhUaVJkN2NFd3VBczJ2?=
 =?utf-8?B?K1IvWHJHNGdxeTBpOWlSRzBVc2pyQUdnNXVZc09NMmkzQ01oUDFBQ0h5MFNO?=
 =?utf-8?B?TEtQVGwybmJpYWlsZ0pQK3g4YkRFUWVoVlJtNm82eENmUnc5d3pQcHRqOUxN?=
 =?utf-8?B?b1VDQjZQeTNMZ1MvY3pKdUxKMjZsSGFUY2NnSTNhb2dJNzdGWGR0SVd0VHpw?=
 =?utf-8?B?dEUwQnYxRFBzbXVzelIrUEkzR0dGamM4ZnJTMEVYbytlajNib1pZUVJWYTQy?=
 =?utf-8?B?YXRtZTBaUFRNazU2Tmw1VERDZ2hMcmRCU3hIMEJEODZXeksyWGJxZW1ydWZE?=
 =?utf-8?B?VitrelBLQy8vMUJFY1gwUURKRmE2QTRVdHVmeHpGYWdEaFF0dmZyU2prUTJO?=
 =?utf-8?B?Qk1FbkRBdTQxVjRYNlNzU2lEM2NUbzRsWVRDOEpwY04wbUxvbmdmY21LdC83?=
 =?utf-8?B?R3RKcStRSlFpdzBaZDduTkxpSXk1RFB3TEE4NDZudWwwekVSTVFWejlLVWw1?=
 =?utf-8?B?UE81UExOVG1pYTIrd1pPWGRuVUowaWl1M2lxV3BJYXRkNHpDdkhpbE8zemJN?=
 =?utf-8?B?U1E3UzlUc3YvaW94a3Zma052TTFYMGI4UHhWcEJiVWhvS0lZcmpNaVNWeWgz?=
 =?utf-8?B?Y2YySmlPcjBlcGFjdG44dlhFV2l0THBreTZnVWVDeDlyMFVpaS9JOTdvRmVO?=
 =?utf-8?B?Y0tiNStiVXVhZTM0TU5la0ZCbC9wNEZra2pwQWZxOVBkclZFdzRBbytyd3ZW?=
 =?utf-8?B?ckxLQ3dZOW1KSkkzR2hudVY4aWphU3hMOWtkMWcrSHg5ay95RjdGTk9rclg5?=
 =?utf-8?B?TWh1UlN3a3dTcjVsb1JJUnZuMlRISWx0UnNabmlvL0swU25GYldEcGdnTURm?=
 =?utf-8?B?OGJqS1VHR1ZkS2JxMjVRMFJnNzk1RVpnaTdsY1hGdGJmUVBYcG5MOEg3TUgr?=
 =?utf-8?B?MVhIWHdYNk5nVHNCWXNvUnRhQStsU2ZCeEpVZ1VLQkluQ1haVzllZnlJd25D?=
 =?utf-8?B?UGJ6UVRrUCtORnFzb0IrM2hmemd3RjM0T0JaSm96YkxvMEdZSXlnK3dQUmZz?=
 =?utf-8?B?azZiNGtyOGE1emoyMDJpQWVaYU9GcDdobTRRNFdxTlpFUnAzUkNVLy90NVc5?=
 =?utf-8?B?cUxubW9FamU1cFdpeVl0VTJOdUpQdHlUWGQ2b2JzS3pjT1dxTmYwZHIzeTRY?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e199206c-6adc-4d71-bb48-08db973ae551
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:39:01.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ote+JmPlvvNlKxLLo9Mu/kzIzMSxizbXQC6qsdoiH4+NA/rnfOMGnZzz+2C60j0H7aQ6fkyLgmasCCcOulAJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>> We haven't even given a try to fixing it; I think the revert is still hasty.
>>
>> I don't have a machine that can reproduce this failure, but I did confirm that my keyboard still works with this:
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 1dd8d5aebf678..b74d7d8cc8630 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -19,7 +19,7 @@
>>   #include <linux/dmi.h>
>>
>>   #ifdef CONFIG_X86
>> -#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
>> +#define valid_IRQ(i) ((i) > 2)
>>   static inline bool acpi_iospace_resource_valid(struct resource *res)
>>   {
>>          /* On X86 IO space is limited to the [0 - 64K] IO port range */
>>
>> Can we perhaps see if that works instead for some affected people?
> 
> That does not just skip the override stuff, it will make the kernel return irqresource_disabled(res, 1) for the kbd IRQ:
> 
> static inline void irqresource_disabled(struct resource *res, u32 irq)
> {
>          res->start = irq;
>          res->end = irq;
>          res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
> }
> 
> Now not much code seems to actually check the IORESOURCE_DISABLED | IORESOURCE_UNSET flags, so this might still work but it does not seem like the right thing to do.
> 

Right; so it makes the resource get skipped when PNP is enumerated.

To me it seems that it should match the theme of 'don't reprogram the 
polarity and triggering for the IRQ'.  When the IRQ is set up by i8042 
then it will try to go and get a resource and wouldn't find one.  So 
when the IRQ is set up it should match the values already programmed.

I do wonder if both IRQ 1 and IRQ 12 both would need to be skipped for 
this to work (if people are affected by both i8042 devices).
