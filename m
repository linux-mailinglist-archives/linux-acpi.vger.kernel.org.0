Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B964632D
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLGVVg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 16:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiLGVVf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 16:21:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9881DA4
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 13:21:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvc5k1MlUOHmHrzaDcFdcmh7zLSlfcNJWBOgd8nz6Pj7QIuy2droeFi3st4FLV2/ITOdYsEJYwqese0699RIU73pQeRx+vlsoU4Tl9X7YiOPbY+6HzgdAoJ02fXmwio+mA+zVfxhdMtxu7RrMB3gsvxMMHuKxlj8wdgqhyumQwm0f3tmY8yBWsLbEijIzUgvlwJOOdXJTw4KSE3vRdColozdjslJwkpqw/iZtdxWzYWySI24iosEKWNb9Wq/9BRVdQ0jwzYwVBvzVxs6gerGpndrN+7lfQ76aQti5RELrN61lu4h6xDWqMRvAAET4WpsVa038rCSZYoRfUI3MdrkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDoI+iUsR4L9adC0lkPva1NmclqAkbvG/03ahgnz5JY=;
 b=LDLbg+ygWsxjpSdlhNgYkWZ9BW2zCe4jHdWWWaMfvbX8UEfW6vgX+l8f7W7Gd2sdHUkTfu4meooA0LmVYG1CgqX/RW2Zmy16pzrCdEt6IRQqQDu6b1oRN7NRbzZAP4huD09XnO+a6bFKAZhO6GuO1zwYv2uMx4eC1uFShbJQWCdVh56eKowejW2BAiu1DOnaC3EuOr4ZCF/uV3B9RimFHxhFHi/FNfKF/Yf8ar5knKt4g5OaipR2iXlQ1ikm0lujgFCO4tdUTQFc7B6U5IryrNfVBJa6TZ1//t+kICmdiofYsvTPpvOiL+tqFt63lUHuWmxiHuw3ghsuSWYAY0/uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDoI+iUsR4L9adC0lkPva1NmclqAkbvG/03ahgnz5JY=;
 b=zHi7qoDwGR8qQpYHdnhCXgZ8CAWW7eY0zu0aElTQqlf8rLwuD+GQmkOezRIMWQd47W7oKWr6f3116ORj0305sealFTCkyR1Fc6BzF8qknVrEYCu+ivZxY74mNs2uoV8cZB/iu5pGyiw2YJq0Z3EzFK/MZKSidwQtBReSwjo3as0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 21:21:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.010; Wed, 7 Dec 2022
 21:21:29 +0000
Message-ID: <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
Date:   Wed, 7 Dec 2022 15:21:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
References: <20221207193134.763-1-mario.limonciello@amd.com>
 <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a5f34a-fd3d-4dcf-47a2-08dad89901a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5SfrmqgeovkeWpQCfxvUS/KwtyiQFdTAgzgs8cNhGDM1bK3lVmnvKuydd2OFF7js+SgkvGfrvsFaYXR1Fr2hOPHaI8/bqCM13wtUhLyma3yrhs63hw7qN3Jpghe7EV7nnnfoMxcTQKYQfuolmf1lYgjzwttm2v+pxijJQvLIZxlbNLEqnQ46EYFmoaheLraCYSvgj84sLrt7iDNCv1wfkiotGv3JDVqjhDT+FxCJ/D4yDeGuoigeJBclgM3zwtoTcoUujpGZ36meyP+qz4kP9qR2+/Z3/jfl+c9Q3rjZL+Drfzn5pfP4ujhNB3Db/zvf7cpfRlbTKO+gUexr7+WHHqBZOWfgrP+z55uNVEw+otFzzaDrkGQf2hbHkiGAUs1CW/e7QbHnK+pXigr1tDEeMDVx1yHExZgXKEcpTu0YXfb8eYrj11tVK/giQU7Hi9KwSaFwlK80462cxFCK0/ehp3MqZtsuBKz/dDtbx7n0qep39TXnSHSxyAgHYbenV8/qpvBUPQcWdvwaJJ6ewA02pLzmtA6v4F876sni/EOfB8h28FhXurgfeopuXQ/c62jIbSjOI++Itp3rMMVFpiLWuuxiAy1e3AZAhyVKNDEvuSzovzy7AHnFrCrOMP7mlXvKp7HO0dhIQl3LFEjCE1ohqstit5ilqjCTRJPvdMxY6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(66476007)(66556008)(8676002)(5660300002)(4326008)(2906002)(41300700001)(31686004)(8936002)(316002)(110136005)(6512007)(6486002)(478600001)(36756003)(966005)(26005)(6506007)(53546011)(83380400001)(186003)(2616005)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0tKZ2pGY2dKOU1hMHB0ckJoNTZaZnE0K3l2MHBrV3U1NlRib2lVc3NMVG9I?=
 =?utf-8?B?V1VwVmJZTjIyVGdpc0syMWZtQkRCRzhTak9BNVk0Q0w2aXVQSVBLVE0rdlpw?=
 =?utf-8?B?SjkrUzU1S2NyQlRRaHFzWldOZW9KclUrdkJnWE0rUnU1cG51SEJxMGlKRlFE?=
 =?utf-8?B?OGVRT1hJd0h3TnBZdTZyRnoxMkhHZ0VHWW13Wi94blNKVG9RZ3J4c3hzcmF0?=
 =?utf-8?B?ck4rZHlXeG5yRUQxM2RhUWdkOFA0NmpKZDNOTkhNeXZCQWZOWVZpK29aN0Nz?=
 =?utf-8?B?WENzSUsvYW01UHEwMlNHbHhaUG8va0Z2OTdobzdiNHBpZjF0RWZ5cHI0OEwv?=
 =?utf-8?B?Mm9MTU40RTZkVWFTS2VpSUFRWmltejJvNi85SGpYazBNbEJSYm00OUZxMDJJ?=
 =?utf-8?B?M1I2OGdCSWhVbndVYldOdUdPeGYvRmJXTnpLR2N0RlZkNGFIYnQyMjZqZ3gx?=
 =?utf-8?B?eit1TXVmMjQyY3g3UE1OYmJyQ3lnZmJNQjE3c0t5N1QyTzlrY2R2dGFxUU1C?=
 =?utf-8?B?bWRiMmJNUkk5dGFNdFpFdWFPc09DU09pT0ZTamNUaGdNWWl6Qm5ZSkxCRjVj?=
 =?utf-8?B?c3NJT2VrRlR5NWJmTDltMTZEMERjVkpVazNBZnhIVlFlYk5CZnFvZWR5TTYy?=
 =?utf-8?B?TU1abkRBSDdXRmUwbS9oYWdwMWtHdnNXT29JRElaa204S0NYazU4NmtsbE16?=
 =?utf-8?B?T1JmRmdEdEkzZnoyWXZaN1BGTWQ3VmhqVlJsZ3hwb2VWdkpXVkxFUjZKbjZD?=
 =?utf-8?B?anpHekQxOVZiUFBRK3dqNnp1WndxRE9lbk5XT1BySmlqUm5hWEIrZHY1SGJV?=
 =?utf-8?B?U0V1cFRHaGwrVlQwT2RnK0RxUzl4SnIvQUdIU0tvQUVML24ydUNLRDZGRGQr?=
 =?utf-8?B?MVdYeU1DUzd4ODloaTY0MVpzQWt1M3NWYklzNk5aMFlZcDJNbXQrcmRXWERh?=
 =?utf-8?B?Q01SODRRUVZkK3Y0TDhaeEQ1b0U5cGVTd2dhb1R4RUJLSVUxZWI0bFpMdldP?=
 =?utf-8?B?d05xY0dBVTlsOUtycnBnR20xUmxjL2tEOUtMQzVGOWxnVmZjaU9HRWV3a2xi?=
 =?utf-8?B?OG4vZXhzanNKTm9sdVpMZitKQy9QalhYa2UrS0FmekJDaWdTS0RHZ294UG1S?=
 =?utf-8?B?VU85UmZUTGMzZlMrVHRlcEdWRGZTLzBtd1ZaYmY2ZHlXc0lzd25vWnJZR2lv?=
 =?utf-8?B?TXdzZnFzVDZkeVRTZ0tPM1hJUWc2TWJIdW9pNURiV09QWGRWSHpQUFBZVzZQ?=
 =?utf-8?B?WktUa0tOaUJNYnF3TllDWHNPdWtTVjZ4L1JQdm9ETDl1bFZoNURZVzVvWFov?=
 =?utf-8?B?ZEFiTHNxZVpKd3N4TWJGODVuRGo2bDVUMVFEemhZTG9xcUNoektlNjFURE9M?=
 =?utf-8?B?YmU5ZWpXU0pBYTNxNWRzVWdQRmN4RVVLSGtXdnpVQXNUMXd3TVZqdEsxYm0r?=
 =?utf-8?B?Rmc5S3QzTUp3bC9FLy9kM1NmSkJOS3JRbjR3MXB5bU1wYlhwUVd6eVdCNEZC?=
 =?utf-8?B?MG92b1BIZjEwWEM4TXkyTk5GWlhmMUVJOFlUWUNTQUdiSFFwWHR0RFBKd3hI?=
 =?utf-8?B?ZUxnUkl1aDZkUHBPRnJYck5mOVBRQkFtRmlqb2RadTA1MkZDN2NMOTZQbHhk?=
 =?utf-8?B?ZVBqd3c5TUNxV3oxOHRJZkFKNlhOeHBVajdjZmlZQTFYSStFQStScFZSbUtx?=
 =?utf-8?B?WEo4ZmhEVEYxaDBobENOa05rWnhtTmY2NGtYeDRtNWhueHlyV28rS2V0bjMz?=
 =?utf-8?B?M0xTSXhuQkUyK3I5WituMDlvd2pZc3BwTjV4RXZRMTJNZ0dzT1I0a0szNnRn?=
 =?utf-8?B?WDYyaG5CU1BZbldFaFI4YXFuWDlZait1Q2trQllrM1BSN2VtYWxObjFVN3E2?=
 =?utf-8?B?SHY2R1JDRkdGTkdrUnB2cWdiNWZhRFZ3cUxVNHlaMzRDa1FCOW5zZ3doQ2tx?=
 =?utf-8?B?OUZSWStqeFVoMmpDcDc3UjdDa2lVQ0dZSHVYRkN3b1RVWUp2aVdDZXhnNlF2?=
 =?utf-8?B?cGFNQVVsYjdrL0plS0NLZVgxdVNWUThnQlRid1pwbktSdzcyOVR6TExibWI2?=
 =?utf-8?B?clUxTjZjN05LMXI5Yk5WNTUyUFRMU1ZoZks2eVBJNWtqeXlaQnB2TnVKSWNk?=
 =?utf-8?Q?VrQtNUPynzUYmbo2Dst0PHXT6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a5f34a-fd3d-4dcf-47a2-08dad89901a5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 21:21:29.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2mH6QpMqYx9SkKSEVcStK+9RNHcl7tx7+qlMCgF2M+Est1Nnw3eCe82M20KLzdD7Pg1fvygqSKGmMdFTL6FAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/7/2022 15:04, Hans de Goede wrote:
> Hi All,
> 
> Mario, thank you for working on this.

Sure

<snip>
> 
> Note that the problem of the creating a non functional acpi_video0
> device happened before the overhaul too.
> 
> The difference is that now we have the in kernel GPU drivers
> all call acpi_video_register_backlight() when they detect an
> internal-panel for which they don't provide native-backlight
> control themselves (to avoid the acpi_video0 backlight registering
> before the native backlight gets a chance to register).
> 
> The timeout is only there in case no drivers ever call
> acpi_video_register_backlight(). nomodeset is one case, but
> loosing backlight control in the nomodeset case would be fine
> IMHO. The bigger worry why we have the timeout is because of
> the nvidia binary driver, for devices which use that driver +
> rely on apci_video# for backlight control.
> 
> Back to the issue at hand of the unwanted (non functional)
> apci_video# on various AMD APU using desktops.
> 

Thanks for explaining.

> The native drivers now all calling acpi_video_register_backlight()
> gives us a chance to actually do something about it, so in that
> sense the 6.1 backlight refactor is relevant.
> 
>> To avoid this situation from happening add support for video drivers
>> to notify the ACPI video detection code that no panel was detected.
>>
>> To reduce the risk of regressions on multi-GPU systems:
>> * only use this logic when the system is reported as a desktop enclosure.
>> * in the amdgpu code only report into this for APUs.
> 
> I'm afraid that there still is a potential issue for dual
> GPU machines. The chassistype is not 100% reliable.

Have you ever seen an A+N machine with unreliable chassis type?

Given Windows HLK certification and knowing that these are to
be based off reference BIOS of laptops, I would be really surprised
if this was wrong on an A+N laptop.

> 
> Lets say we have a machine with the wrong chassis-type with
> an AMD APU + nvidia GPU which relies on acpi_video0 for
> backlight control.
> 
> Then if the LCD is connected to the nvidia GPU only, the
> amdgpu code will call the new acpi_video_report_nolcd()
> function.

+ Dan Dadap

Dan - the context is this series:
https://patchwork.freedesktop.org/series/111745/

Do you know if this is real or just conceptual?

> 
> And then even if the nvidia binary driver is patched
> by nvidia to call the new  acpi_video_register_backlight()
> when it does see a panel, then acpi_video_should_register_backlight()
> will still return false.
> 
> Basically the problem is that we only want to not try
> and register the acpi_video0 backlight on dual GPU
> machines if the output detection on *both* GPUs has not
> found any builtin LCD panel.
> 
> But this series disables acpi_video0 backlight registration
> as soon as *one* of the *two* GPUs has not found an internal
> LCD panel.
> 
> As discussed above, after the backlight refactor,
> GPU(KMS) drivers are expected to call
> acpi_video_register_backlight() when necessary for any
> internal panels connected to the GPU they are driving.
> 
> This mostly fixes the issue of having an acpi_video0 on
> desktop APUs, except that the timeout thingie which was
> added to avoid regressions still causes the acpi_video0
> backlight to get registered.
> 
> Note that this timeout is already configurable through
> the register_backlight_delay module option; and setting
> that option to 0 disables the timeout based fallback
> completely.
> 
> So another fix for this might be to just change the
> default value of register_backlight_delay to 0 for
> kernel 6.2 .  This is a change which I want to make
> eventually anyways; so we might just as well do this
> now to fix the spurious acpi_video0 on desktop APUs
> issue.   And if this does cause issues for nvidia
> binary driver users, they can easily work around this
> by setting the module option.
> 
> Or alternatively we could go with this series,
> reworked so that calling acpi_video_report_nolcd()
> only cancels the timeout.  This way drivers for another
> GPU can still get the acpi_video0 if necessary by
> explicitly calling acpi_video_register_backlight().
> 
> Personally I have a small preference for just changing
> the default of register_backlight_delay to 0, disabling
> the timeout based fallback starting with 6.2 .

How about we do both?  Then you can always restore 
register_backlight_delay without risk of introducing
regression of acpi_video0 coming back to desktop APU's.

> 
> I did not do this for 6.1 because there were already
> many other backlight changes in 6.1, so I wanted to
> have the fallback behavior there as a safeguard
> against things not working as planned.
> 

If you're open to my idea of both since I'm already
touching all this anyway I am fine to roll that change
into another patch for default of 0 too in a v2.
