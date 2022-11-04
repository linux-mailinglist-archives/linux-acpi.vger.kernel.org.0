Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C461A3ED
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Nov 2022 23:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKDWL1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Nov 2022 18:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKDWL0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Nov 2022 18:11:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572BD24BFE
        for <linux-acpi@vger.kernel.org>; Fri,  4 Nov 2022 15:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX+r5Pl4Uhwnjz4CO5Z6NB0LfYm1p4PJe7DSBvtIriI23RBiUpsXHPJJZfuBIa3FcvPKt8T9aRi5YSNq56dxouKTm9pdMqdy0b3aMugconrmxvfbyTdm4JrDTQAbkXwfTAKZ4iTT2bL+m9pF31GXZOYGFOIhEuUJxHWNWITXOuO2a9zvolMKUXHtJEoeL2qQbPlgXnlyWvy47Lye7Zb6gLoM+pVzY39sKhGyIZsIj5Z5+0vYwdtxTOkPjpusW+K1Fia5D1iu9efXavrSrFQZt3ZxL4yVsp4QHavyUcnd2VnGh6gLhl0b1LpLlaOpUIm91NH0b7VJ3BkyFfsJybgrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwBa3BLVf0Me2/LYbWUPlZWJFF2M3zI/+d71mGqYwS8=;
 b=eIZ+hm94lyBUKVSOxq+e1QowTfBJi2/g7Z/Dra05OJMJR7OflZXazLOwVmX5D/ekZB9H7czSOHquN9q+cuAq37qvdbSXObbJmgzFUZWoN47WO7jC+N9CwlBzE6We/Lco8qZ2eqLBTh2H/3tV/omwWBt+QvPyoGMOyKl3SmvX7yw6pIkooMTeO8ofWLxB9goiz/UpnAP1P4F8Roz3l5fXZkswoasTMBm+uDeGky6uM8Fz9vYwn51tuS/m3YAtaQdyW2C3Q9xUOscdQqeOVuEBkyS1cS9/XoY62fkdkv2mnEVSJV+CNLeLaDcgcOrrQqrQtV907n1qN1x1qD2FKht36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwBa3BLVf0Me2/LYbWUPlZWJFF2M3zI/+d71mGqYwS8=;
 b=jj7bLsB4HElGqxPcDTf06EeO8iJnk3NRVmm/uO6f9JevRDQ/3TSGycLtA631OjpiSqi4+orcmdQGUyJFkrTlA8ehrK+R4tPk5Zd5cwiCz+pWhcbZbOXQEB7WBKWqfR0v+rdW1NHXlKNtq/RjP9rtIN7GIP2ytJk1kFNUpcwZMGiczr4X6UdF1vz9B7N+MwM24MTpQ8x6D6PMtNoN9U+LHA4HYCaTGMIVXizz0PZTSmImUT5O70p5XVtA/P6RNdUoar1KKNaPf1dZjYwOorZ3U66RZ34LFba5VJThdnPoGodygspEPwWmrJZytUOG2lT+g5koTs1T1bONlTSYdcWnlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 22:11:23 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::fe89:eaf7:714f:d8a4%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 22:11:22 +0000
Date:   Fri, 4 Nov 2022 17:11:18 -0500
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI: video: Add backlight=native DMI quirk for Dell
 G15 5515
Message-ID: <Y2WOBoMDYddx1fkS@lenny>
References: <20221104212108.73537-1-hdegoede@redhat.com>
 <20221104212108.73537-4-hdegoede@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104212108.73537-4-hdegoede@redhat.com>
X-ClientProxiedBy: DS7PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:8:55::18) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ab9f22-cfef-410e-7fb9-08dabeb181b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2we90OsDp0hDJU9uhc1Nn++DcO+VuYshGz/7KyA15mT/cdXD8A67QePQZsdL5aBxLGTzOFHSZiYeXDCXd5YEMYrRuNCGfZpowrz0YZXXCYnfhQecWPNylvsabEvf17tEbm7gd+pGMZLkPbKkJxT8JELz4/qvaL4C0jbRK9owqBQ6aknoLkuH4PbEMuQYIAkm2XYPcmj86XOXSMa+GpcnTM+Ee7sxZKnhyzvZicIklALWTDPjyYc6lCziRDb4t+7zInNCk/96N0IsxEY93dzMFhw37IHUW/f65coqSVeDl4c6t9FgJPI3z875Z0bmWSWBBR/f+vLDJbxcH4yxhMjPz3cHUCgJ3s8UQtIQBn1vX1rJxTknNkyKV3JA2ftdptG2H+PzF3z6/wg8RB+aSLMlfajbQe1Ob6mNMM9gEsfbos5v7tPKqojBOxyMUKhPwvF5qj51mwUsBCvaEyuJrUaJo7j3Mw4t9GorvWbLsngQpkHfvTphNz/fsfGRWjej0XuwyJ6xGAG2dMTuHirrdG+ulKVY5zjghjII+rrBLNNgu21QHc4EHtZUBNn2GYveWsdpJCPCEWNmKj/GVHR03O9Pr1mZjaSO9rDC4zwcFu8hpjoDXa1Jsed8jY2mT/lDo4v8UO9ksJvCZrhq+rN1OKSaJ4tlHlHJDsUUOzwz5Q/Pv9Vr0mgp01WwbO/mtMb2vMaySZ72uPvXSfoP+xLt47ndGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(2906002)(41300700001)(8936002)(66946007)(8676002)(66556008)(316002)(9686003)(66476007)(6506007)(6512007)(6916009)(54906003)(5660300002)(4326008)(38100700002)(478600001)(86362001)(6486002)(6666004)(83380400001)(33716001)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3bHDcQjOKNv1gniTgNW5op/wrmLV0Hj05MojcY03ADLWexKwbTGd5oRLWQvb?=
 =?us-ascii?Q?rcfYsXwg2imSal0wHTQLrYDUzcqvAdNBQh8DMgEQnG9YYs1w3as971KBi6+m?=
 =?us-ascii?Q?nloGW4Brapejw+3SWgFQh+pS+x43gPRmh+5ua7cm/zJPgcW6jGgYQeIyLL98?=
 =?us-ascii?Q?cEw2IkpEr6auRHEnw4ymlb12DDTuTmB5rLsYHqQsmBkQMmmUFvk+QsFdofzR?=
 =?us-ascii?Q?Yupp5Ti8vIFBUyNi2onnnQbffYHPcIc0H1kh+WMCKm7j8TaBVONBhsNIVmIz?=
 =?us-ascii?Q?CfBtVf6hz9Ef6Wl3gbMWrooDI8X+clWGTJ5UwOSkk4VUJRVIY0qQtq9Wh+sH?=
 =?us-ascii?Q?+zhB0myzVFgRynNmPohZuz13v3pz5KaVIILKI0VB+x0uSpeZROW5rxX+oDdj?=
 =?us-ascii?Q?MJx5IuLwXy4RY0BTvskbhlVC32yeT5GTr5SorzVDItFaqwhi0uZDe9cGAbJJ?=
 =?us-ascii?Q?Mkd+BbNPTRayoRAOpBSIDvBK5feKLQfMYIKQl+/+Aro7xaZ22qtZEv+PCB+D?=
 =?us-ascii?Q?AZ/+rWlg7B128m3Kmojn5npAdfv3jFvd0QuvNhjRUyuQ1jIJgyp878TeTRpm?=
 =?us-ascii?Q?imZIu7Du8NCGpSKAIrDxkuPnKZanmFDOTUl/gZa1XzE/UOQcPf9ex/DUYu5r?=
 =?us-ascii?Q?Gn0P0165bdpL4Wo/+ciPaoq+gTHj0bx+Zo7hmrnbYTF15wxy6A9UM6t/vxFU?=
 =?us-ascii?Q?k1akuJtIPY8IlJdGU7N51y9yabYNa0SfeRMPEbnjQdr8hERo1pPRJLdQIuM8?=
 =?us-ascii?Q?F0w5tS6Th2Pi5tYXR275Rej0gAFZoPmYAsl5hOVZIr8SoO7xfoP4crms6rYD?=
 =?us-ascii?Q?m6qE0tiKahk7N82t9jOSKMN/gFSmR6JwgnUhst/NQJoOnfkNuwCJ2ePUG6aA?=
 =?us-ascii?Q?cCDyg+j8NLej8+G2uBMrWCGwY30s+I1OVGR6ZS1EQ9Oyjy7ucvPlys0xAvvF?=
 =?us-ascii?Q?6+yOAqBPaXJlcB4QVPHQx7WjWQJVTrLTsjwT5PK9Q/nG0kwIaefqz4tJ+P0w?=
 =?us-ascii?Q?vdaRLHbCqMAdBgoSVTKb9wvvj2wMA8z4LExH1jC5vPiKcdqYEmV7/H1+TSV3?=
 =?us-ascii?Q?2JomiQq/ou1wgvka3c/tDu57zgNRUwQdMq0hReBSQRd6FyNQaSRIygfXw8G3?=
 =?us-ascii?Q?VnZHzOKHFvzfLDaxrDOwxOlGBcrWzTgtvBfQ4OfDIkbHCYRAGMSDmpRwmtYD?=
 =?us-ascii?Q?f++jRdjFuNtZ3Dvhz5uVgj79P3mc3gJVgGqnU5cWyTkorsf9hOFlnLwUOZnv?=
 =?us-ascii?Q?jvzZnAoH9bWvKohyeYqOgDQ6m0elN72lTOs6uheIM4Sx7rku/Wbi/lsPLVz6?=
 =?us-ascii?Q?A8toVxZUQ9Zo0CmbSNBxX1u+jonAng4YFnG6U5l4986lssUshhLK4f2OuNdK?=
 =?us-ascii?Q?9TvhU94US+OFFH1/BrL/xSdQ0afc4voenwyr8Fs48v96aANMGpRkFYF8YDPi?=
 =?us-ascii?Q?dtc5SJZDC2gYq4E/YxJfyT4QvjWOzTojYQhy6KldJDrNFPxqv9ykC78sFpsR?=
 =?us-ascii?Q?+TIAu0GmPJqbHPnPegEht7waOunFw8RyA9bkBK/nrJio6PsRIR8Er14vZtOq?=
 =?us-ascii?Q?JTWivao57jz7vIr8Bx9C5o0PR/Mm8b/06M4DP9IL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ab9f22-cfef-410e-7fb9-08dabeb181b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 22:11:22.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVM85JFdpwdKIJbICjyAnHaW4tPFCxzqb6NsFbjq/HwrR3v9lFBNw7Bx+4er7llqDRLRrGaf1CUEWD91QqASwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
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

On Fri, Nov 04, 2022 at 10:21:08PM +0100, Hans de Goede wrote:
> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
> by the nvidia-wmi-ec-backlight interface. But the backlight class device
> registered by the nvidia-wmi-ec-backlight driver does not actually work.
> 
> The amdgpu_bl0 native GPU backlight class device does actually work,
> add a backlight=native DMI quirk for this.
> 
> Cc: Daniel Dadap <ddadap@nvidia.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Daniel Dadap <ddadap@nvidia.com>

> ---
> Changes in v2:
> - Add a comment that this needs to be revisited when dynamic-mux
>   support gets added (suggested by: Daniel Dadap)
> ---
>  drivers/acpi/video_detect.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index c02e960cdbe3..b2a616287638 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -645,6 +645,20 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		},
>  	},
>  
> +	/*
> +	 * Models which have nvidia-ec-wmi support, but should not use it.
> +	 * Note this indicates a likely firmware bug on these models and should
> +	 * be revisited if/when Linux gets support for dynamic mux mode.
> +	 */
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
