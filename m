Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175EC64751E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLHRtg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiLHRte (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 12:49:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCEA56C5
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 09:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbSIMYgrvd1NdPSiw8JQE3E0RDusjcqxEvW2cH/MObj7Nt15i5djHE2tirXX8odol+8sYMUBAdmo+DIdGMOusoQjmZ6oydZuNRyAb8WMcDEFGsEIkEL4myA6NFj5+7JD/BaqpYl9PqgaTtGxWNC9g5Ro20aYas+/53YyQfRbqjb22uywJZxVuP4iNooQhtmBiXZ+h7e3ujIZHzNNOrmeUpEUM3xyK2gvUu0ynU1O6uCN92egyv/wREyFYSFqgIG3kDyJa5hlqSdP4IqZr3iNiS8WV88nURvgj66dDMjjuSPjYOFGvu1Ug7MAXfNaz0Es/S2yqlEEQekJTpuZ+EyDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umgvaKpzOO/RMS9I8BGjci6EqZmSMUV9Mv5xDnU9wF0=;
 b=B9T9Et+QbwY8VvEuOYq8KS09K4X7iE58CrXgqkRh2Og1UnAO4JQL+MAaGana6twNKtIX5F5Yfn/6KOsMhaQUvmTNyGF8fURCbiIT7Qx58DhlwyiMwg8Yi3rYhQ4DxZEPCncqZfEYm6DwXpBeB2q/ZWy9d6jeti3Le3QYZOtnBw0hyanWASem0ZrX7qc4HelZ+jb+LiAJpbu0EmES+f4i+yjZcEpMVfatQl+WYT4bmTSt85w0GLU9/UgNdhesfEM9M6DeYRE9f2qrXTUmAS/rru/K19vOUFlSqBYQ0SbTH0pBiEw9DosFkbZqeVMCGGfi8aUVXMBkb5Fr84HcWIgXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umgvaKpzOO/RMS9I8BGjci6EqZmSMUV9Mv5xDnU9wF0=;
 b=fjnLrCNRVaWUdFgpYkXK9n+1Ur/OVMYkqPgrcXhzAWTkObntRSkOpwnilHwutOVTQ/o9ie/IK+av35e3MGKUD+j19E4NLjuIVPTwcSd+7T5bj+C8snKjVUT0QJx8xUemqM5kIRkutgKlo3oAbDaZqSChBPSHakM0P36fyobgoS9xzCU2yhc5GSCfWBR27nXAHw4H6dbZ3Isqvq7Z0w7x7fEAfX2Xq5VSZextGxdWB5am9NtqmkYZVAuWavpu6aiwJcZo+QNOv29wp2EiHV8kn2CiKrTA3KmgDN1beFehpYmMbmXC5cnEfNXhbZjllUY3w/P+iw7OZtJPuO0MRMBD3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 17:49:32 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 17:49:32 +0000
Date:   Thu, 8 Dec 2022 11:49:29 -0600
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ACPI: video: Allow GPU drivers to report no panels
Message-ID: <Y5IjqZH8ocDkG2hx@ddadap-lakeline.nvidia.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
 <20221208164207.13518-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208164207.13518-2-mario.limonciello@amd.com>
X-ClientProxiedBy: DM6PR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:5:120::46) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 11767295-b327-437c-6ade-08dad9448fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzDLe0bBYfBRQH28A9xEn5FPRqYjyfIBkIGw9lXeqFjmPMHyJUDS3MWDCi+jCPmJnBf7GcLibM3dVD2Rom+o8b7x0M0ISawvbMy1vSCcTS7qE6m3Jt2Csg81qX2urbXJbarnEvqMqzYdEpFuTbsZmcto3ErPnKCsnD3LZaHzw/BI6TDXSe4yyYNy8vlCnLnIW01S1wzucYEJmruYpvz6haBFCDtLB4gkeH3wGJxbAXAkbh0NiuUcd20NCJYykyHWU8BxXFlGsRBPIopaF9owZZ2BcNNfUCBOuaqJswzlF608B/wt8ph6fiheFBH5n8jO9ED/NRXHI53TAJOqud2snRu2FXZWU43eKZt6QcnmuIRGl4TEaovTHqbk/zDvA9kdHhjpPmnl0xt7WJYCYuz8jExMctw5y+LssbKU2Nw1vtB4+sM7MM1rAmdkj3gZyRZnYsie/c6exR6xpB2MOgBxwq4zDoCu7EE9pKKLUcxb2eeAiduAmDVsiukEPUFn06XcrnABxOByux6kVDN0Yt38NJnMFCTMrGaxjtdcFIpR8D3XVB6j1MkTgKYoumwjzqlD6w0CNs2q0p+IaXlVNqSzOZnk2mo9DJK2I+iCxOOyb4KG+UxeYPgGFgE3BMTsUYRiDBtWa32wN9bbvXN+zjoJ2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(8676002)(83380400001)(316002)(186003)(6506007)(38100700002)(4326008)(6916009)(54906003)(6512007)(66476007)(66946007)(66556008)(8936002)(5660300002)(26005)(2906002)(41300700001)(86362001)(6666004)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pb0ubSbm4GWWktqEcGUolT79wRn4yXq8FbxNSxW1zNS0T+dkOqEPttKlCf/7?=
 =?us-ascii?Q?8U+vpCYGgUV/FYAp6tkbq2gJOKpwF4zATWzW3OKiv/HRxnV0+sK+FXXWAwoM?=
 =?us-ascii?Q?QriOHgvb1B9jdqNy2ygG8OoYs/iDYJ+XIxi5sFu3Uko8ogAj2/oGfQG+xp6F?=
 =?us-ascii?Q?zgtElXucXRSmoqOwLTlzhwznemkJ/etpPv1V5Ui+buLRTOsMNLbh6hhFXzzn?=
 =?us-ascii?Q?w8znZId4V5X8XYirM43smjuuiH/bDgw6R688OXbbtaXbeyxToKJQPFYu++yB?=
 =?us-ascii?Q?QyRDSMaz2ZgMFeQyxepzN5NNMyymfYMLOzgwN/cToc6NRjzuAEzeogtbPtdb?=
 =?us-ascii?Q?Uvlf4a+5qJpp0c1UVF5uFsnrQ9r6y3Dwe57aEDp/RY7NnOyRBHsIUUbOydSq?=
 =?us-ascii?Q?vbw5ZgSuoFuNRTEHP5qkLodpfM3NcwOA31BJY8mkqXMKuBvynAp+tMTSBF98?=
 =?us-ascii?Q?f3QmfAswnZYj2Yty0vImidQlIh/w4ek+qbPjh7rF8h96/Wy3QQRBOWWpZ4Yo?=
 =?us-ascii?Q?s/KKbvHhmXnUja1la+k9JSKyQiJ5hsZsy88vDhxiPMG8q1Sh6KyV3SUuieX9?=
 =?us-ascii?Q?8NNqYjTTQUbC2VQyKk/3n7N+BLNSrU+Te1c65k1DCD0xZNDwb9Acw3rJcEG7?=
 =?us-ascii?Q?nqldiL5cbnkJR0hTRce89Dqp0MVGQl7mu1KbPuWjid2v+YXhLodK6zstdXQL?=
 =?us-ascii?Q?g59+Jchtm8a+0vdmk4+xjfYsxG/VDXEsGmWG3mG5gW7RQ4LoSb41sEG7U4V/?=
 =?us-ascii?Q?p0HFIBj0ahFIGh7hyk2dJaKJWax5VSEgRD7X1v0wLovpCPoFUFxU4FQWijJF?=
 =?us-ascii?Q?uCEGCxKRg2xS6RcXeby4udXTT5Hxs+Q2FyUgW9pGm5QY/ogsdg66QJVDUPdc?=
 =?us-ascii?Q?fiYrkqYd/LyDwKXiRrHcmPYTOjrr5anc86YZXVG7IFszHFL4SmOoSsSMRY0B?=
 =?us-ascii?Q?w24J5c1wnVpib8bG4K9uXZx+65x24Z5PhIHMcVAgPLkpFGKLSez3uHKcgKIA?=
 =?us-ascii?Q?csurU52uhh7cMto2zXpt2tCXNLgSo4dby7eNyU5WzxDK4K9+uKqbc6FRN5i1?=
 =?us-ascii?Q?F9YqwIFiPRwbBGO0eVtgPN8tA2aMc3BgCjTWs/eUSZpIKuoMKa8YreeiaOE8?=
 =?us-ascii?Q?oL14aNZR9UewlX7Bs9uqcn7svD8JbvPsGGZlDm1zROcvKJC0I05matwvOEkd?=
 =?us-ascii?Q?2sX8j5kCyI0t9LVFsL062bU2P2SLN1DMTdjMGYFFvuq61D/W32oTWu4P2muB?=
 =?us-ascii?Q?CRyHjTaLGBihJRuQEwR5VUXrs4XnmZcVkHdoIXprnI8Hk8uL9aqbPmsfPpMf?=
 =?us-ascii?Q?E4k2/jaAA/DUNA8+aLw1Ji96ks9K3bc9DDFxcll7r0v8AD5ujETfI6qGU1Co?=
 =?us-ascii?Q?KoZNT3e8K910RW2Ffbw5MvpfwMzBnspRVuA5zilOjEPxlQUTo6iiin6WuND2?=
 =?us-ascii?Q?tF9k9zTSkyYFxe6T2QBzEbbsZZAJJxNd2V+yRNQGLNrsJMDNiog8SP5/25hw?=
 =?us-ascii?Q?L9Y7hco1gaCDQWZm1n7himMafx38UAhOMwPfsH+lbAtZhH/biQ1OFsSIpY+2?=
 =?us-ascii?Q?gSRQBbdilDHZbmRoWH/VdpULni7Sv4UCNGHotPnp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11767295-b327-437c-6ade-08dad9448fb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 17:49:32.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqWVvV4ssGtMepthbkPUcEiwoY6v75YryaVb77guNtEXhFSkYdRDlID9RByaBp/sOvG2A206hU3eq/xyOgQROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 08, 2022 at 10:42:05AM -0600, Mario Limonciello wrote:
> The current logic for the ACPI backlight detection will create
> a backlight device if no native or vendor drivers have created
> 8 seconds after the system has booted if the ACPI tables
> included backlight control methods.
> 
> If the GPU drivers have loaded, they may be able to report whether
> any LCD panels were found.  Allow using this information to factor
> in whether to enable the fallback logic for making an acpi_video0
> backlight device.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2->v3:
>  * Add Hans' R-b
>  * Add missing declaration for non CONFIG_ACPI_VIDEO case
> v1->v2:
>  * Cancel registration for backlight device instead (Hans)
>  * drop desktop check (Dan)
> ---
>  drivers/acpi/acpi_video.c | 11 +++++++++++
>  include/acpi/video.h      |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 32953646caeb..f64fdb029090 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2178,6 +2178,17 @@ static bool should_check_lcd_flag(void)
>  	return false;
>  }
>  
> +/*
> + * At least one graphics driver has reported that no LCD is connected
> + * via the native interface. cancel the registration for fallback acpi_video0.
> + * If another driver still deems this necessary, it can explicitly register it.
> + */
> +void acpi_video_report_nolcd(void)
> +{
> +	cancel_delayed_work(&video_bus_register_backlight_work);
> +}
> +EXPORT_SYMBOL(acpi_video_report_nolcd);
> +

Thanks for removing the desktop check.

It's not entirely clear to me what happens if you try to cancel a
delayed work that was never scheduled. I got as far as determining that
del_timer() in kernel/time/timer.c will probably return 0, but I didn't
really feel like walking through the rest of try_to_grab_pending() to
figure out what happens next. You've probably already tested this with
the default disabled timer, so as long as nothing bad happened there,
this seems fine.

This is probably overly complicated, so if you think it's worth doing, I
would definitely add it later, but I wonder if it might make sense to
pass an acpi_handle to a _BC[LM] method or one of its parents, so that
this could be scoped to a particular device. Looking at the ACPI table
dump from a random multi-GPU laptop, it looks like there are two
instances of _BCL, one under _SB.GP<number>.VGA.LCD for the iGPU, and
the other under _SB.PCI<num>.GPP<num>.PEGP.EDP<num> for the dGPU. The
caller would pass in handles for methods/devices that it will handle,
and then the fallback, if it runs at all, would skip any handles that
were registered with it when it crawls for _BC[LM]. Or the equivalent
inverse logic, or something else like that. I think it's probably fine
to keep the current unscoped design and just assert that any other GPU
drivers that want the ACPI video driver to handle panel backlight should
register it explicitly; if for some reason that ends up not working out,
we could revisit scoping it then.

>  int acpi_video_register(void)
>  {
>  	int ret = 0;
> diff --git a/include/acpi/video.h b/include/acpi/video.h
> index a275c35e5249..a56c8d45e9f8 100644
> --- a/include/acpi/video.h
> +++ b/include/acpi/video.h
> @@ -53,6 +53,7 @@ enum acpi_backlight_type {
>  };
>  
>  #if IS_ENABLED(CONFIG_ACPI_VIDEO)
> +extern void acpi_video_report_nolcd(void);
>  extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
>  extern void acpi_video_register_backlight(void);
> @@ -69,6 +70,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
>  				 struct acpi_video_device_brightness **dev_br,
>  				 int *pmax_level);
>  #else
> +static inline void acpi_video_report_nolcd(void) { return; };
>  static inline int acpi_video_register(void) { return -ENODEV; }
>  static inline void acpi_video_unregister(void) { return; }
>  static inline void acpi_video_register_backlight(void) { return; }
> -- 
> 2.34.1
> 
