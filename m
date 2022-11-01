Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2858614DC7
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Nov 2022 16:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKAPGi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Nov 2022 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKAPGW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Nov 2022 11:06:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C31DDE0;
        Tue,  1 Nov 2022 08:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVWJd2dFIxESflZAXdWgyxZycMqx2fBywsG6yzW7iVhF8Pv8TuJ9SN5cxXmd7v+v/01shs9KLE2+MT5KUN+OaQUr8o165Jv8aK/stxONdhsGxbqO95KtX0OMP2p8a2YQOpJV/7qU3hvqJ0vfyt4YUEV9WJRIbghIlxpZdhcYHr9vELqIjxr/i/f2WY4WeAhNFh0xal0ifRVFPxhppBCjFIBJDSur73AdWIfi+JXFV/hRsUM0H5AgO1GhNtLBcia7gYnyVQrHDi0i/ErFkyOy2MTLD2cL95o06tdvB7xY+0hbWki91tC8ROkIMhswRX/aPDqbb19Cx29uC0wru1d3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=405zU9TH+cm34mEi+QC6XXsabnJztGk0A3IZMbDa/gc=;
 b=Wg2W/TKRCgUUGS7cYx2qmuCmYvpCMmMSufmYf4HhDtoOnWx+X2q4rTmFwpdvNvth1OpTT5qZk584dlgRyNY7XD8YXwaWVukiJlfpurlUdGK0cP6B1+J9U9ivlxrroCyF8UMpjRSh+oOf72xwmWNoXnH1XqL7vTJhAmF1MI+KS8ns0XgV0racVvowMILfe4kAUQ0P4LusdUUfWYDKb55+Ho66ztjx550EI0DyIqaM5LtF+wms72yBSIS1tkeoK+/kD0IxF1PWKeXbaygQLAnzqRWKkM98gNC4oXwFAacguaxlSPbTdiJR/z6bkUk6oO15ks7YxH0ad6xSlFdEDhXHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=405zU9TH+cm34mEi+QC6XXsabnJztGk0A3IZMbDa/gc=;
 b=jXMIGh0jQWDe7sz/qoJlXBttciZrvBSLQnPDLCIfI3DY1mSMMPO3hhQc35CD1i/kqNLEr24aNzw1ofb6EmRwZwWekYl5gAmJ2r945TUXwBIRdqr9Js/lTSoO0DKl+6h995WV7rccTrp3DOhoujiS2kHAAqtbbgiW7yG1/ZK1Tb0dgDh/6UIcuOCdHcWWLK7z5U9zwukNC9Zru7HA7oePmiTcyw3ZB4lRwOi9HYLFvxvztAx1XCYIRILVG3eZpTIgkZ9L3wlG5WlIqVtMi6R5wis9B1q3xWJDXY2sC9eS8I5LEdn305ySQZEFd88A2QjgyiIsblR8kAzHB+0aC79bpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) by
 DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.21; Tue, 1 Nov 2022 14:59:30 +0000
Received: from DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396]) by DM6PR12MB2763.namprd12.prod.outlook.com
 ([fe80::bfe:4295:5744:4396%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 14:59:30 +0000
Date:   Tue, 1 Nov 2022 09:59:27 -0500
From:   Daniel Dadap <ddadap@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Message-ID: <Y2E0Tx00rtdoogiz@lenny>
References: <20221031212556.401618-1-hdegoede@redhat.com>
 <Y2BHpKxWitLSMFER@lenny>
 <0cd572ac-fdda-f364-8558-2b6da9a0b901@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd572ac-fdda-f364-8558-2b6da9a0b901@redhat.com>
X-ClientProxiedBy: SN1PR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:802:20::43) To DM6PR12MB2763.namprd12.prod.outlook.com
 (2603:10b6:5:48::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e9fb75-22a5-491f-7d94-08dabc19adbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsS4lbhR9Cjp8KhYNpMc8vXZXh8sOVnjZjeV/5jYTI/XxIlrs9yeLIe/0G3gDNmtJSUAIlRQ81o3EZ1rqi9TAljRYSeHWmUNqHTpYe1cohX2BJtlehaiTkH3H8tHyL75R6bW/xTcZmD0xVhEPNC4+Tdfr7OuoJ8whwYc1vzMd4qiyq6K07qts0Kens8xJFdlpk+9Il6yU+AsFwDM8hozTmiRK6p5wC+JVTN5nMWhyEtozMdBTsbvuiSG48nJTrdl0xUbZblWFKmAKdmlRLobTg1V06PG3nNkZaXSKS2iahYJUX6XEupZ5rXE3bEiaMQY/Kwku16KWkKckEVm3jKXI3Wa7AD1M+ETPtx1WJOee4YvoJbD0JjgljMdR1avdRj7G171eWhWj3ecDYLcoK7Azw7heZLT0LIGorZ/5ROytOeYBiXBzCPvVnb9DjnoG8IHxl9KV3x33Ar8NkG/o8/zVXqsOda2NeKtDOHmvALDe/lhQWfdE+0pliCLzYvZga0I1Pi3qqSJiN/xiqXZpwqSNum7ouMhCPBoY7t3+8aBGmOwZyZ7rUu/M01uNP2PE6LICdMgXdBKsA04vOS6VFy1zL8ubrtyVF1ENTdVrbKw1mtc/CmCAPrLgNM46ibq3DRITA0XLnubg6S9NILpVDJKZcYsRGix2Lf2E6qy1eNBkdls6l1nWXKRZN8/VwoKnTOcdos4W4Tw1PCcNqzl9TCqFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(2906002)(66899015)(6916009)(54906003)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(478600001)(41300700001)(5660300002)(6486002)(8936002)(33716001)(83380400001)(6666004)(186003)(86362001)(6506007)(6512007)(9686003)(53546011)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqqTy/OZhWk6w2e0qfiAswFHPG7oNXTU/UvcibRkJYgTiya7eulW10gchDbp?=
 =?us-ascii?Q?vsONwQ5rtsBLkhI16IfHIObIrxkK+FVTqxytC+V6hQJ4OTvdDgAsV9VvcRoh?=
 =?us-ascii?Q?WK2+I7s9gVq/gcyS3a25e4jyfpzL+YYrsijY40bhfz2/dNm7F8A7yh5SaeGv?=
 =?us-ascii?Q?Ow0GEDA3im2nPRhgigSm7WjtZXCEwbkTuxjEb7xphXf92oanvMnbPvEFPIAX?=
 =?us-ascii?Q?3uHgQ2xTCpLMAlsU1wLNM5UMVV/MmH8nh5j00wZKSTvE+9z2PKFlLGAsTwGS?=
 =?us-ascii?Q?l2Brf0aeikp9r9uhodcp7eIsUXgB31V3uF5ZUL3jZ0vhFuUoIhJbTRzptiVh?=
 =?us-ascii?Q?6AhP7XWbl9XBWgSB7o2y0OOLjpenR/Dov6+GX8DlD8kxw3kYGOpcMIm7TNjt?=
 =?us-ascii?Q?q4hXP6qnnJjg6D3HqZ4HLjbwOYBEg+zPH3fMqz844WoO1IHUYYa2Q1oQ+//z?=
 =?us-ascii?Q?MRpoqWwlKPPWUQsWz7Tjwl18uPKNjV6UzaUZFyUPYe37awaf/nZrYFZdc9IT?=
 =?us-ascii?Q?YcwZeJhvvLmMEKKecjQvIRHm05/f5rXc+ep4ebtqHa6FRJQeQ151xiYFcZdu?=
 =?us-ascii?Q?e1k9o2UUs9uxrncUotgjDD+xlhhNRMU9Gr2uEzqw9ckpcGZg2/XigibUh4pB?=
 =?us-ascii?Q?ZP9paXYNm0O8Pup0a0KaCuHJSWCk83dIDHtZKt2S/0nUXXf1rVfuypUVmmq+?=
 =?us-ascii?Q?4WW+npmyVfhw6yAhinBMmmSMrNh3TsCQjb9GbH8qtc1sWKB7r0ARDGkubjoG?=
 =?us-ascii?Q?SIokbNO0Rlr2zwChWY1SO3u4uuBjrPPV5BaQCXjh1us5rklFZ1A4iMWKVkyp?=
 =?us-ascii?Q?ugPeEIZcYQppW66+ljXubimU/ZFzNINRdjSMYeuwwM3MQLOon/xKbl1TGn6r?=
 =?us-ascii?Q?Tw1wJQTnNPcu/vPqVRyeV1Wix3+91JVocWOi1vFNyL/DfQ63acSwelD8r4YD?=
 =?us-ascii?Q?9OVhUxrNHQYOz7dDAcNHrbdlFwwVUcHXhGwT/zN/pCQ15wvhpGZm+Ovx/6W8?=
 =?us-ascii?Q?SgaE3M4GcoufiB3Pmr/VlLlMwNHlSKt/mqNH6UhiRFW2K/m6NnTazdle/OPb?=
 =?us-ascii?Q?+OzfQQC8j+G8tdGHfrRDPdhofn3baLytmV2BuLf5RExES82WsTjdMYQf9ZFv?=
 =?us-ascii?Q?tbuKAsZUcEeoRNXduZ3fp3wZ4aeEUwQHa9DXGj0YSdNLB7NEt3UOxc+rpfGB?=
 =?us-ascii?Q?VTKscCQgVw5k+iWxK24QArPUUWkbvEu+WKF82DUi15hK3/EuQYjtZwfRejz8?=
 =?us-ascii?Q?zH1xrpQevLPtVGBCp07c3T0ptNmcL2eQV1zWvUP2hmhG0ASHQyBIXlNoRh6i?=
 =?us-ascii?Q?iJ1Q90h9GjIkpe5w7HGEGni3lQAQNb+cQJyTeBOLPdV/nZxQSL9ey7BKwLXN?=
 =?us-ascii?Q?/mZ1hvTjfyonM7J/sqgAPZ5xMIBnUMACk+YOenUH132MvxhoKlIs41r543Fy?=
 =?us-ascii?Q?6MwroBwgO1lMlHh6xNT0aBDgg3dm8zHpKpyHeDZ865o8EtfzSgTIqmqnGnZP?=
 =?us-ascii?Q?j8J92CbLI4j7BmMKNCEFoxQJAs90cCA1c9tkftQbiHeRTFN5pJ5j0iVHPIFB?=
 =?us-ascii?Q?wuwB3fov657PH2fbx0ewPMlnPY9O2WhvKZi4hAos?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e9fb75-22a5-491f-7d94-08dabc19adbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 14:59:30.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sygP9jzXmJLsF7HzmWjy/PbCloFdGcIwXB93xjEU/K56qOXzc4xVJ+RgRvyW1KnNbvShBe6VwJU0JjmZXPum5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 01, 2022 at 03:09:04PM +0100, Hans de Goede wrote:
> Hi Daniel,
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
> I have heard back from the reporter about this and they report that
> there is no option in the BIOS to select the mode. And currently the
> machine is running in Hybrid mode, with it being unclear if this
> supports dynamic switching or not.

Okay. I forgot that there are some dynamic mux systems which only have
the single "Hybrid, with dynamic switching" mode. And of course for
non-dynamic mux systems "Hybrid, without dynamic switching" is the only
possibility, since there's no mux to switch. As I mentioned in my other
message, the quirk you have here is good enough while we don't support
dynamic switching, and even after we do support dynamic switching it
will be fine if this is actually a non-dynamic system which is reporting
itself as a dynamic one.

A dump of the system's ACPI tables would be useful to try to determine
what this system is actually supposed to do. If the reporter is willing
to share a tarball of the files generated by `acpidump -b`, I can look
through the tables to see if there are more clues as to the intended
behavior. In the meantime, I will ask around to see if somebody at NVIDIA
has one of these systems and it is available for some experiments. If not,
I can hack up a test kernel module to help the reporter poke around a bit.
 
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
> 
