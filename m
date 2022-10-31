Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA99614096
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Oct 2022 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJaWVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Oct 2022 18:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaWVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Oct 2022 18:21:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1914D0D;
        Mon, 31 Oct 2022 15:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMHiW+mx5dxi0wXNlQVfLPqTF3qZtxTgfyg3Qkex4lQ+mglVTu1EkinSJCusOyoSQzfLbJQJ+Whld04F28xHYKgROaRFokCWf1QdTn1LN8Cm+PGA7E/V9uHShCEFP6uv/GHCEztGjFjuHhpMlqQj7LtD4dr+uEcuk70l+tHbDkNFcpbxRCDcyh3wjnQFVIwGBnYsbflYePi/EPiwg8HQV+WYGUCY57B9iQ+9JpwL61ClT8c3X/Sh5XKCMUvG8FbEk6hjBQVH35Je4k6Jl+CA1IkirpoAMH3DXbMKV9aE9RnEuYv1LTw1q8Ux2/AzyNU8kzBrH9y6uSRQLPORUWVQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVkM8Ly2/sjUdpU5VJj0Q6SrVCqtIHTsbftGzuDRQTU=;
 b=FQezX+ikGNtcXcsmYynh7V1IYMn4HtzusQWsQB6G5vrgEpsIaV7N9I3GB+qLkDP/vEwmZSdFqRQkmvPmJh6K5RJJ4VNTYLcZ+/FMtjpDJQg+T+Sn3qzQpypCiil3A/MD/egiVI7CeOLkJKoNIS3RN3GJfcE/8tUNpZBkbU0LSl/sc/bLoNZGxQyV+M66UgK9IsvE26vzwtaADKpsHy60fctIVA5Q/M/E4swRk+5c8y7s1osekiifYrEDu134IwrAt9fC340mMgz8GsVoBXXTg2/CLup4INvoRWocVSCoypKh/vry5Y7MZkB9oaoZwtyCZ4hCm6/qtc2AY2QfIqsnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVkM8Ly2/sjUdpU5VJj0Q6SrVCqtIHTsbftGzuDRQTU=;
 b=q9S4VHtRV77Yn9sr7/IBlsGS48KhX1cYqLHUllekGhllOhLWV5bhPsQoFwcUXSaypjyNYdMNiGBL9DP6pQgG6tebuj73JiIxJ/+PrgZQ1fmD43IVxuZf1I9lpN5bgtHgC9qF/xWhQfduvWiSRuexi9ysf/vAC9fjzi4ZEJTmpCCd4oFTE5PjxeUH3J05zbApSmKdGdPRBINeNavao9nK56pc4nG+qOQ9YIp/S4eKZCDcCi2UK4C95OnIYQsok3OUf/MQbZeg3kNG/pI/BDw566zD2FmzNg44RUUj99ZyPrMJDhc67tasPJEDrW/KunGh8LBnVYoIvyBVrflw8tQ7Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Mon, 31 Oct 2022 22:21:00 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 22:21:00 +0000
Date:   Mon, 31 Oct 2022 17:20:57 -0500
From:   Daniel Dadap <ddadap@nvidia.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Message-ID: <Y2BKSVzCON8PZctU@lenny>
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <MN0PR12MB6101C2BD5FAEC45B51B61667E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101C2BD5FAEC45B51B61667E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f44ea0-1728-4e04-8888-08dabb8e30a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FryDoq/DeHTu01FD8blWJxvNEVdBRqxM0tmP2yiI5LQ2hnMM/9byK4J10R8KSvT9BuT9hvWUXUO09FVAVNJAU4ilbeVQv1avkFxrTaWv1JngpHrrG5EhUSQ5gBXvVQwG13wt1NtE/QIzj56NZF81CqE32lqDa7JKlPBDWBtTlRm58+ocoY8uduPh6clYrEht6d85jihebjuKdI8PwLK+jnDg8oUsVhxW7xxJl4IQH14mvM69zLoWEL5Mo2yD2ijMyyMuIu5rLnnVjIOp3MzFbiuAzOmvOyX2Q3fvqeHZcuKeF3SZIXwDcIEKrfB+zXUSfdSTeaiKXTE/cQ2FY4ly5zJjhvvhLaWXWsSVKVBg/q/cFHrdFOLyeQ2K8lKmto8r+54lvSfbRIsODvAUggfqXW8fpb9O7T2F+NpyHtrYRWGh5ff/tnc6gfWb5tt6Vg2maZ8INymY0iERcYAwieyN5WpN2ivHa4lYF+YpIJ2DaA//ynHNPuJtim56YxGmXlv1FT8wNqJz2mgukuzPkMqLC86WdssH2Dw/KPtHNR5n702zoPHsCR7bwfSVBxuApDYH41RB2rOWP5BVqXtvTDVi0iXsT4rXI9W+AxxaZ+McU76j08YYpMUmGzDUl6Njn7Da3pQcgvQuIPBP4Fbm7NFnj8zLHXiHLGANYRxGxaNV3ggBJZVi3tB/No/zDEocOVv+cnuSc2O7CWw80neuwbHTZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(8676002)(66899015)(33716001)(86362001)(2906002)(186003)(66556008)(66476007)(5660300002)(8936002)(41300700001)(83380400001)(66946007)(4326008)(54906003)(6916009)(316002)(6666004)(6512007)(6506007)(478600001)(38100700002)(53546011)(6486002)(26005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Dvl5kSchuadBfqKCcSHJgI7av4jc4x/3Xk8DxLwyx6Nn12bvlALBCeu27W0?=
 =?us-ascii?Q?UOZeRQSduwk4R+mogREJX5s33nhHqztJ0vaDmCUWJDqEPBg8dYMT4h3g+Mme?=
 =?us-ascii?Q?uzv09PA3Gopfm6uENvbfCGWkl12rgVOmQD9WExRdaOZoiGvgLmAE6DdAlgS1?=
 =?us-ascii?Q?mps9kj9+HBiVvZoJ9oaQWWa377bx0RANzgXJyvBuQpi3/7PdbEvFSHcDjGfE?=
 =?us-ascii?Q?e5CpFz0C3fz/qhFyOTk/qEOpDK1fakAR2EcW6XnWzly2qwlX9AJZxMw+MtZk?=
 =?us-ascii?Q?GTj5mbPI011ufeiXLAPTrIVneTN+OV5BHt/da0Anfy1udeMxPATkm3Vxrb/R?=
 =?us-ascii?Q?QtC7oSF6SOr9FqgP8OvBgPOPr9H1tAoESkBvbZ9ktH2M9Es5q3FQtCosXmnW?=
 =?us-ascii?Q?3wEMRrzwt+wxQHXG1JCoy7TUug5d915WeiaKz8TjxRsKLH9qhWyANGD6SfFa?=
 =?us-ascii?Q?Ui247u+aJJpcoC5JMTTO6rtmj8+/RideRWZSMfFwU3LCbDpMVQcbLrfq+wvD?=
 =?us-ascii?Q?rjZe7zapALZbEWAIjl2n2s9W/GK8nZzXIHOUnzaYPhhs/fU0uCTV+cva+nnX?=
 =?us-ascii?Q?Tuff1Y/GLgMskyktcUhZTGwfhC0v/rHLGkVCl9FEgJ5Sbe/9dA+clAQ5YFtr?=
 =?us-ascii?Q?4i1XAmq1Bb/itIh/oug/1MuTeZTTUz8G8NFVXisk7eRLay1Ki5ZFEdV35znW?=
 =?us-ascii?Q?sxKawZ50SYzMdrxfk7G8SezxJJOidG/dCjCL/OmpNT0mpGyVXZp/E94spqLN?=
 =?us-ascii?Q?18mkkroVhX+hbTnH8JGfarxumtBbDV+nTWv/pZdoQ0NO5uki/HmRVGZ+q3Df?=
 =?us-ascii?Q?A5yPftAvph7cWOAkj4WF3qz6rVrWuzJIAoBtVPVrvDE7wjCDdS4FqDt7Vv33?=
 =?us-ascii?Q?rWup1LY3Siqy0+uSx5yuYZM8pj0VLdYiyZuIedVb/gTeHq/VoIAIvJw1XiQn?=
 =?us-ascii?Q?ufV0SrI027EwXHTvp9ZABPUbeb+n1p/MtaDk3DnsRMMTGqFWo3rdyabYTIm1?=
 =?us-ascii?Q?++xFmWLBKbOj6gT0oUvBBQ9FMVmUpEFzHXP9PrxQd/6tE7Dd0ZzoVgQZJ27m?=
 =?us-ascii?Q?sMRQAahBayqzjr4EFVSas2QLE2+NCX1N4Bu0DzQNmGk7zitpbXOzKQy8q1Dk?=
 =?us-ascii?Q?u5zuify3d2a4r66nUif+akgwjOutRWFDil86mGi/GZokbsZ3CX6zia5Ji4ws?=
 =?us-ascii?Q?hJMTlLHxhBumZJEVKUzR08ZpCUYg2favRa4KfMfTpzWVVCL2pZvlqeTbiG/c?=
 =?us-ascii?Q?EI3uFs3F075lv/mf1nH51qXmVnRcdV1u1QVlK15eAIJvbfCKnWp5sAXv/aFd?=
 =?us-ascii?Q?nh0NALC3E0dEhNCrZoOIDzERY8suQ6WdVwxgvSzQeiPBLY14s5B/Iib3PfTM?=
 =?us-ascii?Q?an5RpN3G3rME7xEiFe0TGtQpOKvXfnBi/wD1FNSThoWELtj+vxkBPolAXFIr?=
 =?us-ascii?Q?a/tU8LkBw6CIkJqcimSeieU4b8RH9p4utkrpXzDLVUPeXtDwaql1JKuMcs7+?=
 =?us-ascii?Q?rZbzjBhB59CNkJuZQVvWfsvqM/GooXC5KvgVZkeo1OBIPQoRH0A+usdkRVf0?=
 =?us-ascii?Q?9iI+0xBcZi7a14tG4Zh5HjD0MJds31D3XTHILIix?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f44ea0-1728-4e04-8888-08dabb8e30a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 22:21:00.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okf+gICv21M+1036mCXi0E7TW9857cdiNt3o5zfu3cA+MM3tB47Eyhf+NLwdpZt5G2/Gu1kds6OxwHVcQ2NzeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 31, 2022 at 09:51:55PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Monday, October 31, 2022 16:26
> > To: Rafael J . Wysocki <rafael@kernel.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>; Len Brown
> > <lenb@kernel.org>; linux-acpi@vger.kernel.org; platform-driver-
> > x86@vger.kernel.org; Daniel Dadap <ddadap@nvidia.com>
> > Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
> > 5515
> > 
> > The Dell G15 5515 has the WMI interface (and WMI call returns) expected
> > by the nvidia-wmi-ec-backlight interface. But the backlight class device
> > registered by the nvidia-wmi-ec-backlight driver does not actually work.
> > 
> 
> Is there a way to detect this from nvidia-wmi-ec-backlight?  I would think it's
> cleaner to have that driver return -ENODEV so you end up with just the "working"
> amdgpu_bl0.

That would be ideal, although I'm not certain whether this would work
with the new backlight control type selection model where video.ko
determines what type of backlight interface the system is supposed to
have. I am assuming that the below patch is against a kernel predating
the recent changes that Hans made to rework the backlight subsystem,
because IIUC it shouldn't be possible for both the EC backlight driver
and the iGPU's native one to both be active at the same time. I would
expect that without this patch, there would be no working backlight
interfaces on this system when running a newer kernel, since
__acpi_video_get_backlight_type() would return
acpi_backlight_nvidia_wmi_ec, which means
acpi_video_backlight_use_native() would return false, and the iGPU
native driver should not be registering a brightness handler.
 
> > The amdgpu_bl0 native GPU backlight class device does actually work,
> > add a backlight=native DMI quirk for this.
> > 
> > Cc: Daniel Dadap <ddadap@nvidia.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/video_detect.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> > index 841f6213b4de..88acc09773bb 100644
> > --- a/drivers/acpi/video_detect.c
> > +++ b/drivers/acpi/video_detect.c
> > @@ -645,6 +645,16 @@ static const struct dmi_system_id
> > video_detect_dmi_table[] = {
> >  		},
> >  	},
> > 
> > +	/* Models which have nvidia-ec-wmi support, but should not use it.
> > */
> > +	{
> > +	 .callback = video_detect_force_native,
> > +	 /* Dell G15 5515 */
> > +	 .matches = {
> > +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
> > +		},
> > +	},
> > +
> >  	/*
> >  	 * Desktops which falsely report a backlight and which our heuristics
> >  	 * for this do not catch.
> > --
> > 2.37.3
