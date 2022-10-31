Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3399D614073
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Oct 2022 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJaWJr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Oct 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJaWJq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Oct 2022 18:09:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E060D46;
        Mon, 31 Oct 2022 15:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhGyxe3DTCrQVk2Mcwy8UF43XvP+NniW5WxGbjNkpv8XYzFwnrV8ggA8JjZ6mNJgFuJulWgMWB0c+WsDhAGIBb1eAI29CFw6OKVyyH0LCVCOcXOvQU5cKHNPlk0qh65fz7/DDtYuXuh2dbrJf/N1MrJACTx/pAMk+RcQn98BfZZojk1AgwwzOwUbalmbOpUqSTFrKvx+dd5lGHWrTzUVsA9LKNihbe7eBkYZjWUzzf15OUWQ/UdMxNtUqWXNRRKRY+NC0JuWrsBF/yel4EX+c5m2y/bL+ZJNTCGDtnZtTjZcVu1glU/BkgGz+yzf60fMy7cmvZBO3V2zgOMaTPooCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT86JFAb8XC/7CrvMG4BHyAjJTifmqEMiI05ddilb1U=;
 b=aVPJxHcFkWsBUFmtNGcJv+ZT+QnPshzKbzNWM57GV4tNMdrbhpHUtmC1JP1QBp35dOM/9hJa6cJLFERnuDkK6Mt00yrGCeMp+kwhida5HR2KeKa/NmVjwLiBzn9j4wRCWOV5KoCgVFCeLNrIKp600uB5li5AHLFGkooNhf+Sfuft+hzIhkz6IVFjcmOmAeuhlCv4OIGqu9gYE6esEnSJMa4M6JrU1MtHkiP8Z2F/yqsnfK/C6bYw4zD0OtZpuuVGjM/Em0+4cXW2WdkZdvztK4twBx4ImnaeCjHwy2OPaY5/H0+SVfEtKI3m6ThRAvGtOFJbEYiHfxT3GRaQWondSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT86JFAb8XC/7CrvMG4BHyAjJTifmqEMiI05ddilb1U=;
 b=oJQxUDje5IWO0Gl/2VNdncS3p8uovsQTijI6NESnwH41unVrWad9cBOR5VZHiN+snMr7qqFFHkOrRfJ8duSU6usqzPoS6JuC1V0G3o1+38Mi4G9kArtiS5EqEi28cGyumhQQFpd0IT0B/SVElGipyl/tCYJEUVBODDpkdioRTwMXQmIp7/h84k8kp3mQJtFXcWGYeo+dC1PkpsLWdK4Ye3e6tiYdt4aaAaU5/tDT+kptO/koXtMq/gV+WTtFEmFHqitleBUAANxx4fQbP/DUx981NTNycNUHTdJvg/dqWg+a58LTYxV0FyJYVS9dPQaZqWw+PtkgxWvTuwj2H2Q+OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 22:09:43 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 22:09:43 +0000
Date:   Mon, 31 Oct 2022 17:09:40 -0500
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Message-ID: <Y2BHpKxWitLSMFER@lenny>
References: <20221031212556.401618-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031212556.401618-1-hdegoede@redhat.com>
X-ClientProxiedBy: SN1PR12CA0105.namprd12.prod.outlook.com
 (2603:10b6:802:21::40) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 036fbce7-80b5-444c-4132-08dabb8c9d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnmFQkBDs9/+J2Y72IylcO6tUfX3CxSkt1VWnyHpPUILUuEfOx+B+dOQuvqN+UVA1DNHBnkVZsno7w/2J5SWdgj0XV5Lw7DXI9wXwTvDs2+0buw306mxHg0TS25rVcEyQT6sjRhLA7JqI7HhSq0bMB+b/XZdjM/oy8gcM8Nh8fvCsOlQ9YYk60K+V7orv/f5gzbnCMureAGvSATi5oEyne2amtWTtKHIs6usQhwclL/5jU9wcyPTL3YlmC40lHaiVWR3v5eNfXTIJn9SfGBzIe8PKoySJcBHEQJ40wc4vJW98J9j6qn3k1Udfpry9CeXOuWZ5ppg+5mDQE3khSzQ/TsnVY7+5uAw412fod3k2X0C7vShYQgwnlGjWIqISG/VL977xXX3j7+XxPD0foU4kwttP+5iRZo/Qtwby+ofCKSIxhCpJBxgZb+oM/L+9VzHof2zPQ/JNPOpCImmz3CQ8rrc/T+uUAUbPCad9sLlq25g7c2OI83gOE6vWRWj0YbaIilxrpAyFjvx4u359AvFFVH9IgsdIPRrlBh1/VK3C2a0nubZZnLQgg0+714+IQx1WA5we8uArPhJ1bxpbnFjdUioLLpmmi3wtLKl3zUfmPI9yM6iedWzNjO18QyZ3Vo61AsW+pk79HNCvlzjREBP+sT0YZ6Ac7xiwLsBC6tBIXpaL2Rsq9Rd/Z9Fsfooh88E/LF9LjbtQh9667EhcMK74A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(66899015)(83380400001)(6486002)(2906002)(38100700002)(33716001)(6512007)(9686003)(26005)(186003)(8676002)(86362001)(4326008)(66946007)(66476007)(8936002)(316002)(6506007)(5660300002)(41300700001)(66556008)(6916009)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/jqtsstcPVOdY2jFssctFELHhEIvtsCVU6iAVPsYNIDYrCAhsHp4teki3cD?=
 =?us-ascii?Q?YiJL1mi9g+pcUazLNecjlEqIE9FJet9s7VHK6x1ICiffV1+pGW0wtmoQmeiO?=
 =?us-ascii?Q?2aeitzXqQYesRQJh7IOpuNUmKFevdWhcHYUz3ZjixMJGBKaQSeKzLqeYLkU+?=
 =?us-ascii?Q?t4pYtK7f50q1wTEcHLyFAAACbXyOZTCt1no1TIxGZAh6qdopBLbiRnoHttVf?=
 =?us-ascii?Q?RC7KGrlXWf23QU864cTObDD2Rt3OLOSYCw5BvY2IeRl6NTfEggH4DVyN6zdu?=
 =?us-ascii?Q?Ca2Rr+SltwfDWPFW2YQtF+ilvlk5xVjBsXYc2zzZNvR5FM8rxnYxahvrwJ2G?=
 =?us-ascii?Q?329WDjT69SqjBUBs89XxqKHkzsgATPAxkdlu9y+lbhA4yXCbW6MUNPnj+gNt?=
 =?us-ascii?Q?q1XEOZuke8sQQXwINstsidgB2UWLSBaGuP1+FN1Yw2tTjdJpkUs94QlNOHJO?=
 =?us-ascii?Q?AP2VeW2BI57NHlwDGs41CuwBgAll6O/ZQsKcZzLYXvRs22VEa5fk4wovlFw4?=
 =?us-ascii?Q?jJvO6R5jCUI+Mq7QhCZK2LeBVUlrFvC1bOOglMPKyAKX+TSRZ84KZXEKMsvp?=
 =?us-ascii?Q?LZ/zR6ZHpg0iwqZIi5yBR7pbqAhz5U7wij9H5CLicN61DpbeDlEPh2aaJRpa?=
 =?us-ascii?Q?3U7Qf1/e20svoFdh8JcWElF2C7clS0v8UKlAKvyk21ZFl1grn6tiDifjmimx?=
 =?us-ascii?Q?pN6BbroOyw+5Mer1Wgz5WEiqEYqx5nfVsL0woAy638zyat1pJtbVPq6ulHUz?=
 =?us-ascii?Q?+Bpvrc43Pz9iLx1Orkeagw70y3VtsvTjqV3U9y7YxALRqY0CweQt3xDW2Wkz?=
 =?us-ascii?Q?7H/6mNgKY1wovZBxVWtlQNbDuIo0RjHzhghT2WKFPVDF3QJtjHc7DG7Swp54?=
 =?us-ascii?Q?ybtIPiaXLUXDfn68iD6Xgy0RFHA2kbGK1tydmwMEpMeoP4oIZhrz/gCEmUSK?=
 =?us-ascii?Q?8ltiWFDEN7zxLgv4B2LIvsaVbp4NUkk1zwdrJ4CuoBM29B5FGLLT3X+cA2QA?=
 =?us-ascii?Q?FQOnZqEM3/pQuOxXZ2Lh1/jsFsXn7cTgvEz7Fdk4oyJ6vFbrp9wlbw6ZQXW3?=
 =?us-ascii?Q?DEIA+90XbESgPAAzimckrvEoEBGN9tLBGy2Hozx7zRfKv3xQ3bnfqG3FSEZV?=
 =?us-ascii?Q?Yca6MvhxfuqxyUqMMeNpFazOA4Fx7mafmwFgHrHLeN+JTXuHdHvpBgimELeb?=
 =?us-ascii?Q?j7+BIVQp1tL/GaPT32e3NLsMGlZo7Ocoxny86jElBfykSJ5YD22k04/1eYin?=
 =?us-ascii?Q?fW7bHWOf3rdwygiIBB0vdiKujLMfBaLyosKr2qJLORJ9/5cNZnKtE1RBcd7t?=
 =?us-ascii?Q?L1/vICKKCe5PFmcAa72dIDukmtO0AIcAAL3uBzD0hQqRQDx5QU1f9TeaVwR6?=
 =?us-ascii?Q?BaBimnyBCs6ib6+fz7mDJ2eqA9KuuzzFYmWV9pxAilYGRoqVOq3bMLF+mT6m?=
 =?us-ascii?Q?rPgKp1yjXnrrUDVCKJeI9OII7d+oxEBkJtso3XAA+CGQfSzzba0xO6omFS4/?=
 =?us-ascii?Q?YP2Oei9iPpPE7vqmoU4EkBKQ6DBMehpD38ROfU3Knf6+Gax+VPJrfmk0PnGI?=
 =?us-ascii?Q?vBnbZzYgMoVLew0AE6SUM8gdxtQd6QY4ICAFmx9u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036fbce7-80b5-444c-4132-08dabb8c9d44
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 22:09:43.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlKwfL9wAk5GOLWOyXiSo7bVyKfNQplfP+MkyMhhmysOstv5a6RLUvyslDt/WonBR6/DhIh1Tpr8Q8ucb5ghYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks, Hans:

On Mon, Oct 31, 2022 at 10:25:56PM +0100, Hans de Goede wrote:
> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
> by the nvidia-wmi-ec-backlight interface. But the backlight class device
> registered by the nvidia-wmi-ec-backlight driver does not actually work.
> 
> The amdgpu_bl0 native GPU backlight class device does actually work,
> add a backlight=native DMI quirk for this.

I'm not certain whether you have direct access to the system, but I am
curious as to what mode the system is in when it exposes a non-working
WMI backlight interface. The expectation is that the WMI EC backlight
interface should only be exposed when the system is in dynamic mode
(different vendors may call this differeint things in the EFI setup
menus), and the native backlight interfaces for the GPUs, be they
discrete or integrated, should only be exposed when a mode that keeps
only one of the GPUs connected to the panel; i.e., in discrete-only mode
the discrete GPU should have a working native backlight interface, and
in integrated-only mode, or a hybrid mode which does not allow dynamic
mux switching, the integrated GPU should have a working native backlight
interface.

For this notebook the AMD GPU would be the integrated one, so if the
system is *not* in dynamic switch mode, and the WMI interface is
reporting that the backlight should be handled by the EC, then that is
certainly a bug in the system, and this would be the correct workaround,
when the system is operating in an iGPU-only or non-dynamic hybrid mode.
However, if the system is switched to a dynamic mode, then this would
break the EC backlight, which should be the corect backlight interface
for that case. Another possible system bug would be if the condition
described in the change description occurs when the system *is* in a
dynamic mode, but is routing backlight control to the iGPU anyway. That
would be a messier bug to deal with, since it would also be necessary to
determine which backlight interface is functional when the display is
switched over to the dGPU.

If it's not too much trouble could you (or the reporter, if you don't
have the system) check which backlight interfaces are exposed, and which
of those actually work, for each of the different hybrid GPU modes? I am
not certain what they would be called on the setup screen, but the
possible modes should be:

* Integrated only
* Discrete only
* Hybrid, without dynamic switching
* Hybrid, with dynamic switching

, or a subset thereof. Usually I would expect the minimal subset to be
discrete only plus one or both of the hybrid modes. Since we're not sure
what these are called on the setup screen it is probably best to simply
report the names of the mode as they are listed in the UI.

> Cc: Daniel Dadap <ddadap@nvidia.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 841f6213b4de..88acc09773bb 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -645,6 +645,16 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		},
>  	},
>  
> +	/* Models which have nvidia-ec-wmi support, but should not use it. */
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Dell G15 5515 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
> +		},
> +	},
> +
>  	/*
>  	 * Desktops which falsely report a backlight and which our heuristics
>  	 * for this do not catch.
> -- 
> 2.37.3
> 
