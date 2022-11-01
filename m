Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A38614D07
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Nov 2022 15:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKAOre (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiKAOrc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 10:47:32 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267A186D9;
        Tue,  1 Nov 2022 07:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEwjuSHt8REuVgKIMzx87GfGDWmKiskBeEoQw9bN0DpKu0dlTDwgmaVqy6cFfQK7AMeyVQLNvJ6V5ReMlw658H7hhp1aNsGTf4aexP20EfgwYxbuzfYpAABQFq/xj/1OclVRBLoxvc8M0yLVUK+pT62Wzw1XC9smIfOx3PqiDFee2zrWZI1pkIZYRIE7oKrwM7YpXDe7y6SNGwc9wp4Aljdkb2eSA00QUUHGOfg7BjaLYIrvkS7GgnYu3mLnkBdptiFXJRi8S1WPx3c/DypAc4tJ47NZixQDDfh83hKFIoZDspr9nvUgtCOHvihCgO4i4z3AXdDhWhAikNPpko7pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5z4exiWTZgkVkHtZFc0EpiuA0MZnapOGDrlZ+wF4ag=;
 b=Omh1TPtAasLzmgtMmwwUTRMk7jmUhjGWM4xEqZGQCtgHU8MGAWi3me8xOcpO80j0vl12u8ocu3ipeo6CItFJeY0wwBZ1igcpLzDp7dsmGP1/vPuJTqomIcs91Kzh1WA+zNrd6imqqK3cH9LWVTs6Q05bhfWMFE5ep0Rmmcw9qvYj/oGXt7TGh6JDfSrXrM8y+8e3rTPpFYWeOLQXRnl18Yh3ZY8yYAoCZV+c/b7Pzo51uKiBmlgWUab09vRe3UqgTDfROpKicD/e7kdBLfx1aywpvOnMW54LzUITJq7BtraW2unID2e/I9MKbZTRWiEUnZidTJQCDL07KwBJlt7g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5z4exiWTZgkVkHtZFc0EpiuA0MZnapOGDrlZ+wF4ag=;
 b=DZ8TgY5ohS26elmJSGNW23fpv2tPK+qiewZCGYcXQ4fuJYBL3IjGHc2zrbfFhwigFwvni6ENuyItlFswvlZ0pMqWmtqzaE5QcSEPYYmLvjbT0zuw1C3SmZ3rIVhZB33u/nVfnVDnLuTJHlQ3pBXl9o08CBhBYZbCoYH/nCw/JWXtY4FSaIXiIhD8CAfQgjO56LTyvoQRujhWKrfZdSFdPmtZCcP/vyHe9urPiQqEkXLuX4Rqi/8FgdgUHQm6ncZlTjQAIJD4oKofthd4fcgSwoChnGTFdB63vN0BuxSF4lbvKLzFC5rh4+uaaIIRwrlTFEqHnGThY6+eTwUfibaDyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 14:47:29 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 14:47:28 +0000
Date:   Tue, 1 Nov 2022 09:47:25 -0500
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Message-ID: <Y2ExfTsBICjJ9IrA@lenny>
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <Y2BHpKxWitLSMFER@lenny>
 <edb8e436-739d-1c91-d697-142681520e8c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb8e436-739d-1c91-d697-142681520e8c@redhat.com>
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d59ac22-430a-432e-2019-08dabc17ffbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMl7jXpPESYAj7B5K37KBWP2pANSy3bHCwVGPoG8M1duF3ySgA80tbLFrpbnf0KxdwqUFOLOW0X6+QlxQZJcpaK91a+jK0yr/jPBIsmuw8uWBc78+dTXMfULkB0q34YMhHVtzLVXMiFwwxSflZMMruK6T0CMpM3ewb4y0hWUHlscoCaJx4S+8CRVllROolewmresSmtHLNLcXkLAbcbqOGBIU08wuXKEn0h9M6GoZf1sooNKFHuUmT1xZDKoTRQFKwEYelXPfqEclyV7Lti7vEOLAzncHK0juNtp1k3iWApkhi3dlnNJvo+znmugAwbPacBTvW/336kJOeXMloKknWRqH/fRRcfb70DON3oi2WvV7dZs5rs0VvxYyyTnD2szh9doGBKjgaWKo+okNIlE1G16nBGxsxncJwQrHCeQndl7b8s1TP1LBr2JcNUp6v+11px8KEFJJzflMxOQMlwn9TR7AC2q05DN6aQkHTrCXAH3romH6qEQUbj4fxy2797+5OWzv1Y6Gze7RJoe637EEMWQLMi43ByFukAvRSLgD6iMevIhdINzN2SJEMDwBJnF3uQ0EpqQmrqc8I1v07G0/EkcSqD0HodiUpAVkF5GIvwcqR03eV7+usF6HT2bIF3bKTLC9T46cdfcvQO05vgaBsrtSAH8OE2wq4kIml5BB3ni9GFUaRB0HWyyaD/w+GO4qASCapc7ApZ0VDfEnUpoqHTa3cKJj5tLEk8gBY/hUYFkGSzDcpqs5/6uQnNMDRFq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(66899015)(478600001)(6486002)(53546011)(33716001)(66476007)(6666004)(54906003)(6916009)(316002)(66556008)(5660300002)(26005)(6506007)(9686003)(6512007)(41300700001)(2906002)(83380400001)(66946007)(86362001)(8676002)(38100700002)(8936002)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NHcxvvlN5JFxI6sraDwBGvpuaVcUFDy15/j6rvLwFRl64yL7xjngk8K4/H7H?=
 =?us-ascii?Q?FkMM3SQNtlk+8hQBJn9XmZRlPBKd+q3Nz3U/5sIqxFYev+Ca2Zm32ce+ZaAI?=
 =?us-ascii?Q?Emn8aroeBJJpcLKqA5oLp2OzYW/pIL+NJqI9ZGgtuiNq5aQJB4+0Ukmhv61H?=
 =?us-ascii?Q?0h4b5BHZeOZGF1mrAYyii6+udgChHkMN5sBgxU3CncCU7isLU1aogak8I5CA?=
 =?us-ascii?Q?Su+OQ1CrlbFqohHNlNe0BkquTLHmgaB0VgJHbx794Q2SVYCU9KaKJ8ZNI8lm?=
 =?us-ascii?Q?UHFJUZQaOX4P+iTUdNBO/Z+3TIefpQHkt63C35RBJYm9PaRMBzx1PLseq8SW?=
 =?us-ascii?Q?rdZ2FPqwg1CMpnGfYGxRRVzHu0mTINE8m3QRgjDCXKvmBq9E3vJM2X9EEUiI?=
 =?us-ascii?Q?4XuW4L9Ss/xghBiiQT11XoitXKPhpO4jHNJJzKeY2aa7pTtPMtXf7ONR0fvB?=
 =?us-ascii?Q?lXwKdIzZATZha0WxoaETY5a3E+sSYQ4ZpylkMU4auNMHTTwJt5xZT5fUOcYx?=
 =?us-ascii?Q?gVZPYjfTvN9VlUHLGCA4z5H798ljS9KVIjL7n/GhW4gDBIV/Q0pNyndbVA/Q?=
 =?us-ascii?Q?DQYev8mLfjHOHu9OEAjDwfu6yvNpI8IgjLhyOMZUxFj/9RhkhYP5EE7xbEH8?=
 =?us-ascii?Q?rY7YsbscoBArpainHwl6vQE2ZjLuGtjYoEG8CozcomAbHyIPQy0w4rxRiAY/?=
 =?us-ascii?Q?RVk0ksfxrZD+1WRJrH51+dZz05tVJQG0SFBaYIjBSqJKM92A1t8zh07RoQbr?=
 =?us-ascii?Q?YOW3YmgsqjAnMU9wOpP8/ugXJe2Wwi7mI37XTM9nc9IdCtjZVVdoS/TAttJn?=
 =?us-ascii?Q?8k+oVT13AjJ0dNn7X30WKbKDRp3htIeY8BEUZMwNy+0ln3dl3ywSJd8THfdk?=
 =?us-ascii?Q?BjpAhBf78whj8SvBUxH9/TPsDi/5qr/1liNtYF3fahnSigTNtZUZjThyBH40?=
 =?us-ascii?Q?+ubxpdi7AW7MWLJ3Qi2L2U2AcjRTvVO4Re4RKI7Y45bWCSyHxJI2ZVf+ufpO?=
 =?us-ascii?Q?gx2L0sfgvW67WPCOsOx5+bAm9XtzIQaMcsLq2H02HAKU3X7nYk2sM24xe28b?=
 =?us-ascii?Q?rKUJKvVkLbOBgBvuFJ8QceKvvjx+VWhtpcRpjCFTlQP907w1m/iHPQju3WBA?=
 =?us-ascii?Q?sQcmjmNJcVmKn2OM6uCQBSzTB0I4rVpa+J46SewXSG+9FZ5HL23hUzGz1xnI?=
 =?us-ascii?Q?+NPSMkqVdcmtG6Pe+LGFDuOQ68BSLLdDt49QIDgCgpA5XcJaF8SEBzn19lm/?=
 =?us-ascii?Q?/lYZvMPVN099FL+i7U4kAJq8xgiO/gQ9Bl80BdM3yHhzoUI/y2N6PIzYu1yR?=
 =?us-ascii?Q?LbwSBqGiuiKEnb9fGe1Z5ZgrXO4WQMxz68h4pN7IHYX4gMGPykblU2NaxCJW?=
 =?us-ascii?Q?VxeFD7Y/x7TCM932Dot3vFLzN4ZChe6r50V34+oIQollRO1ENpTbNBqSsSE0?=
 =?us-ascii?Q?JsQZN75PnEMBEMEl+F++DUnkqx6fjxw1qIzhNW2ngiQLAGQp7nDABggDkOT5?=
 =?us-ascii?Q?dQKrkF6Bikoof50zOkbV/QB1XoEb/LwYxXRh4wKECnnEzYRWmds2qe764iM5?=
 =?us-ascii?Q?XRghTU8PaScqb5fEeshrKg+ps4Zvv/0P1nUSAGRl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d59ac22-430a-432e-2019-08dabc17ffbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 14:47:28.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ9RNMDtKYFQWxaWT0WmlscJz2JQ8jpqSTUc6G+eXttPVU3rF0m6XkZ5fUa3i9/c38LYSWUIT1oz64KHSCFJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 01, 2022 at 10:52:03AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10/31/22 23:09, Daniel Dadap wrote:
> > Thanks, Hans:
> > 
> > On Mon, Oct 31, 2022 at 10:25:56PM +0100, Hans de Goede wrote:
> >> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
> >> by the nvidia-wmi-ec-backlight interface. But the backlight class device
> >> registered by the nvidia-wmi-ec-backlight driver does not actually work.
> >>
> >> The amdgpu_bl0 native GPU backlight class device does actually work,
> >> add a backlight=native DMI quirk for this.
> > 
> > I'm not certain whether you have direct access to the system, but I am
> > curious as to what mode the system is in when it exposes a non-working
> > WMI backlight interface. The expectation is that the WMI EC backlight
> > interface should only be exposed when the system is in dynamic mode
> > (different vendors may call this differeint things in the EFI setup
> > menus), and the native backlight interfaces for the GPUs, be they
> > discrete or integrated, should only be exposed when a mode that keeps
> > only one of the GPUs connected to the panel; i.e., in discrete-only mode
> > the discrete GPU should have a working native backlight interface, and
> > in integrated-only mode, or a hybrid mode which does not allow dynamic
> > mux switching, the integrated GPU should have a working native backlight
> > interface.
> > 
> > For this notebook the AMD GPU would be the integrated one, so if the
> > system is *not* in dynamic switch mode, and the WMI interface is
> > reporting that the backlight should be handled by the EC, then that is
> > certainly a bug in the system, and this would be the correct workaround,
> > when the system is operating in an iGPU-only or non-dynamic hybrid mode.
> > However, if the system is switched to a dynamic mode, then this would
> > break the EC backlight, which should be the corect backlight interface
> > for that case. Another possible system bug would be if the condition
> > described in the change description occurs when the system *is* in a
> > dynamic mode, but is routing backlight control to the iGPU anyway. That
> > would be a messier bug to deal with, since it would also be necessary to
> > determine which backlight interface is functional when the display is
> > switched over to the dGPU.
> > 
> > If it's not too much trouble could you (or the reporter, if you don't
> > have the system) check which backlight interfaces are exposed, and which
> > of those actually work, for each of the different hybrid GPU modes? I am
> > not certain what they would be called on the setup screen, but the
> > possible modes should be:
> > 
> > * Integrated only
> > * Discrete only
> > * Hybrid, without dynamic switching
> > * Hybrid, with dynamic switching
> > 
> > , or a subset thereof. Usually I would expect the minimal subset to be
> > discrete only plus one or both of the hybrid modes. Since we're not sure
> > what these are called on the setup screen it is probably best to simply
> > report the names of the mode as they are listed in the UI.
> 
> Isn't the whole idea behind nvidia-wmi-ec-backlight that the backlight's
> pwm input is connected to the EC (it is sorta in the name) and then always
> is controlled by the EC independent of the mode ?
> 
> At least I was under the impression that that was the whole idea?

Almost, but not quite. The idea is that the PWM is connected to and
controlled by the EC when the system is in a dynamic mux switching mode.
Then, when the display is muxed from one GPU to the other, the backlight
level remains consistent because it's not under control of whichever GPU
it happens to be connected to at the moment. If the system is not in
dynamic mux mode, then there is only ever one GPU connected for the
entire time the system is powered on, so there's no need for the EC to
act as a GPU-agnostic backlight control. Querying the WMI-wrapped ACPI
method labeled WMI_BRIGHTNESS_METHOD_SOURCE by enum wmi_brightness_method
is supposed to tell the EC backlight driver who currently owns backlight
control. The most likely possibilities for the bug here are:

1) WMI_BRIGHTNESS_METHOD_SOURCE returns WMI_BRIGHTNESS_SOURCE_EC in a
   non-dynamic mux mode, instead of returning the correct value of
   WMI_BRIGHTNESS_SOURCE_GPU
2) The system really is in a dynamic mux mode, but backlight control is
   incorrectly routed to the GPU which is muxed to at boot time.

If we're looking at case (1), then the proposed quirk is fine, because
the display will not switch which GPU it is connected to, so whichever
native backlight driver comes online is the correct one. If it's case
(2), then the correct workaround would depend upon what happens when the
mux is switched to the other GPU. If backlight control switches to the
other GPU, then the below quirk should work under the future backlight
subsystem where there's one backlight interface per display connector,
as long as both GPU drivers register their native backlight controllers.
Userspace would have to deal with coordinating the level across switches
and scaling it, if necessary. If switching the mux does end up making
the EC backlight control like it's supposed to (possibly even after
switching back to the original muxed-at-boot GPU), then the below quirk
would break backlight control after the mux is switched.

I suppose this is all moot at the moment, because we don't actually have
support for dynamic mux switching on Linux, yet. I have a proposal for
that which I've been meaning to send out to dri-devel; I'll try to do
that soon. So in the meantime, this quirk is a "good enough" workaround.
It would be helpful to add a comment to the quirk that we will need to
figure out what the correct way to deal with this system is once dynamic
mux switching support is available.

> I will forward your email to the reporter and ask them to get
> in touch with you and then lets see from there.
> 
> Regards,
> 
> Hans
> 
> 
> 
> > 
> >> Cc: Daniel Dadap <ddadap@nvidia.com>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/acpi/video_detect.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> >> index 841f6213b4de..88acc09773bb 100644
> >> --- a/drivers/acpi/video_detect.c
> >> +++ b/drivers/acpi/video_detect.c
> >> @@ -645,6 +645,16 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
> >>  		},
> >>  	},
> >>  
> >> +	/* Models which have nvidia-ec-wmi support, but should not use it. */
> >> +	{
> >> +	 .callback = video_detect_force_native,
> >> +	 /* Dell G15 5515 */
> >> +	 .matches = {
> >> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> >> +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
> >> +		},
> >> +	},
> >> +
> >>  	/*
> >>  	 * Desktops which falsely report a backlight and which our heuristics
> >>  	 * for this do not catch.
> >> -- 
> >> 2.37.3
> >>
> > 
> 
