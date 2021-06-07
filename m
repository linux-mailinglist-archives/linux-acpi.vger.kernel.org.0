Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE939DC6C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhFGMdX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 08:33:23 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25373 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhFGMdW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 08:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623069090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G6DtMEzsdqAgwAt7pHJBASk8SWvvgUFkfZlmAggMdPw=;
        b=F18GGbsvY37zy7qDPIcAEE1gRfyaGn2AwxYOV5eFEEaBmtGe7yb7wblgx2ymF9FCwm3JdQ
        NfXZz/oQOa123I2LxlWbhL2YkDxBZp1lgyBHd2o1jhWLRrFj2Ir7V0bJJBvBe7mm1BMVFA
        fChSzEPB9xb8YzsdkpclJFdh73xR/B4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16--9vIGfl0PDW1TS_AA4dLTQ-1; Mon, 07 Jun 2021 14:31:29 +0200
X-MC-Unique: -9vIGfl0PDW1TS_AA4dLTQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQAL1qx2HoGAxx2YGWoNzcxrtiP9q6vYeTzRPHbQ0bjXSxfFr5fdc9v016n8zXV6N9uSFGPo8Xv1rpBFjbvohB47zan89nE9r2TEX3uRYkhynq0eAc3XVTe3cSxsiJmAZWkhV4f09xrj/FYh2b4V6RkEv4/xyyZ4PiRtreVeCn7MT6f982T5wMtGNM7hV4mYRooOsOyQO/PmdPwWAjWhUlsd1WMoba6YrzNv05HS/unBoCoqrDNDnGVn8utOlFZYyyrcGVg4RLRXS7oDdKuyLVMqUez4I3B2NRHeJShTWwXj1TqiE+GS8bKrEQv0LhwAdQQdfqZLQbs4mcOYY93ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6DtMEzsdqAgwAt7pHJBASk8SWvvgUFkfZlmAggMdPw=;
 b=oEXLAuiGS+OREDtyj8ZzYPIVFArL8vHBQbSJmM4lHf23dma/2LY9fbw2kvQkiOs4/M68O7NN8Q3N6AG4bLmksjLRElTXN18zVdGXv2znGu3NGZpDxntJUf0T4FWxqM5QtE1/94mZ+mfCjY2K5RgfbwPD54wDr0xnK4ga8puFfCoAtwOVcGvlXYEqfuzOgVOSzT5wMEY3fMJ6CfyauXiGaxpej+Q2pK+U0XYA/aRmwLsypyW4zsizr2iUSh0d4+ytCBEonKRfHLg6I/RGNm224artY6BRPaRpE34aw4ysMdLfTFqQM6RcLj3MDL622DibZtD4ZozEYI6x38QQ57MXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR0402MB3327.eurprd04.prod.outlook.com (2603:10a6:803:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 12:31:26 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::e0f8:e927:79f:232a]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::e0f8:e927:79f:232a%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 12:31:26 +0000
Date:   Mon, 7 Jun 2021 20:31:10 +0800
From:   joeyli <jlee@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, iqgrande@gmail.com
Subject: Re: [PATCH v2 3/5] ACPI: Execute platform _OSC also with query bit
 clear
Message-ID: <20210607123110.GE22028@linux-l9pv.suse>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
 <20210129083241.72497-4-mika.westerberg@linux.intel.com>
 <20210203081415.GR2542@lahna.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203081415.GR2542@lahna.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Originating-IP: [124.11.22.254]
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by TY2PR01CA0013.jpnprd01.prod.outlook.com (2603:1096:404:a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Mon, 7 Jun 2021 12:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa11fc26-d598-4ee1-8e86-08d929b02ae4
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3327:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3327D46838142DC4BC9CF5A9A3389@VI1PR0402MB3327.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL/lFst83ffr3m6c7JwiyK6d6Wgl6d0/YuQN1gq6SplTiY4Mhz/CIlwz7539qjvHS+bSlnpOHFiEDvWnotcYf4IC30cQZzmwkPJlJRa5pP7rY/MgEuHy5piFiASWbFmBQB6irbke0KeYNXPHN6uKmRmrEL1ifHesrevrlRYbQcT+zLbgAH73msrwv0fSRrb+R8CCtGSwb/tnUqm2xMLQfZQHKmmfjvbQtE/ilQDesTEgkGNoL7fVAjfTYFx0DPeJvCY17PWB671Y8q1PWHTsZMcL3WHbQqy8CQAAgkeFubig8WUlxdZvLrT1HFsb+Sxbe45vKgRRxAS0rO+nqvUbREtRNP30FdSg66X7LH5RR6FDCt0Kci2u3qgmPWCdIjACclYueTAC69e6MaCX+1u7Gq1OoF36e5K1ekp0TqrKjch2MSOpiOA+17KyZcRH8W7UkDfFbl574czroT5oPiY3BBFxBVgJYqyLFng7jdPg963AIPggpega67LVAvibpcepkOptYXNJyzYftWTb1q3pX73jLkUw713bqgAYhFZpwJnB+AYeuiVT6Z76k9YZrS/Dmuo8fqdgxx62hR+Vy1rIBDNrXyiBEiqWkcX1mGM60gqhVW2Uly3zvWDMfEWK5ZRjlz+i6BY+0ErK29BW5bJbE80pu8u1iZGtwCxzzGYFBnx30gLV82KXbLFVLA/NOvvrCoosj2fExflY9gXZqgV3OCKJlRXujbU5HMpBfv6FSbcnIoN97L1yOIdsfSGne63HelVpcashtJegQWPtcA1O+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(6506007)(7696005)(36756003)(6666004)(26005)(186003)(16526019)(478600001)(86362001)(33656002)(66946007)(8936002)(966005)(83380400001)(1076003)(5660300002)(7416002)(6916009)(66556008)(8886007)(956004)(54906003)(2906002)(4326008)(55016002)(9686003)(316002)(8676002)(38100700002)(66476007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7p0VIAcxISxz7BiIA23UToWudb3gwzyy25XEgp43KU7SyC3LNtVoF3vLFP/w?=
 =?us-ascii?Q?RfkVr1RvKvxL2rVQSPb23BuLBZBoptJpztkvBl2FMxF8nm++gIPQMUvqMroX?=
 =?us-ascii?Q?edr5zWeHSVChjWRXl+BYGYQJmTs2n2UMkWR+YoOUV2mwNjhgyCRV3gBmtHCs?=
 =?us-ascii?Q?gUeQ+k8Edm1w1uJwYmwIWM5iL4x0df4uk+RIx8ogx49sSHx/cc6EDCbak6Rz?=
 =?us-ascii?Q?7Aua86Us+D5eU+sccyKl0MFwzaE/d00cUi+n3XRDIcPSvi0j5LzZ/KEGukho?=
 =?us-ascii?Q?OmdWCCvX5Qe0mMm1iXTMzHEiN4VIO48+a3vuOPDEUVhYyN1zw8a/Kb0Wi9IY?=
 =?us-ascii?Q?LxgIwbC5UTezMmKhR2uedJwNOOdjyH7CqbHJiY3zQf0D6P5fWL0gKLL31Kh5?=
 =?us-ascii?Q?lpAjrtumr2WOOLODp1nxDtbROllwmbDVZDlRwQuATf4ftivo7twZHoi53egi?=
 =?us-ascii?Q?k1U0dckLif5LDCy4q2OWdlsuOvhVh64AZYGs6+iBqcK9t15l2tRcMuoYgjhM?=
 =?us-ascii?Q?jbK53bFEzoXMLXnbVcI29CfSvgfyQpj+1Ot7ejy3cHFnu4MCGoagxCd5YUwH?=
 =?us-ascii?Q?S/pnhEZes4A1GGSQuixEFZz2XYGM4N2PXknANooxarw8jMS2ho+WhxnSTUWB?=
 =?us-ascii?Q?JaMgcu0mhYGgX4qRkMeH55+u3Ds7Edne5BypLQa64ugIXX3IrMoKi/cS03v6?=
 =?us-ascii?Q?i4nmUyx92hmK9EmgjB1PMsqV7YMQCnW4GluK4oANpC2YwFGV5tV2K4j7PXGh?=
 =?us-ascii?Q?f8JPziYjagQbu40KOeTUlGGPy+p4rw5Pq2Yz4wq1CUoj3KXFgk7wxwxrTZYK?=
 =?us-ascii?Q?1IxLE3X0cAaEFOIooE7ZNExDO6v9Xibx7cdUbzfGP7M5zjgNC/Ta9PJxsnR7?=
 =?us-ascii?Q?LHCiRdzEO/bOiCW1XiwyYGoAuYnscQwFMaxAQOnbCK2XvOAwFUmyUG2UNnjJ?=
 =?us-ascii?Q?d4ZEk/FMxbru1v2MIPW1rmJ0eWx5yRxhNVzW64HW0hOkPMebAlkPW87+q4++?=
 =?us-ascii?Q?5sDzvOCH3TOx/HZcgLHhKN84tIs5BVkoJ5AfspqPl6ax0AU9i78Mz3BSmlkO?=
 =?us-ascii?Q?oZIXkmMsjZN1LcGWtDCkVArACwcmqidraHblD61NuTv7wDiuERhXc7T1hKhz?=
 =?us-ascii?Q?o1oLQixIf5FGli9q8zlymmO1thg3I1h5uUazY6MLQFZ+rh7ngkaR1SmtpMQm?=
 =?us-ascii?Q?wT15BA3OM3D4HA6MwkqxoooGLcA8XtsMUqiSdhY+JAQscNXCXqkXLagtgT/g?=
 =?us-ascii?Q?D+E3S09ve2dDQF0iVMV6pvrHxQgn/nhokM+DEATj/NGRBNzD2mOTWbSRgB+d?=
 =?us-ascii?Q?n0oquMlw4MfFRYncGiWC3oRi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa11fc26-d598-4ee1-8e86-08d929b02ae4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:31:26.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw+F3xuy1wediQZzo6t6sMzYexNkuQVQSgBBo6LbsdOev8NPI2TVa/ZSH2Q9dPgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3327
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mika,

There have some machines be found on openSUSE Tumbleweed that this patch
causes that SSDT tables can not be dynamic loaded. The symptom is that
dmesg shows '_CPC not found' because SSDT table did not dynamic load.

[    1.149107] ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)

Looks that the firmware didn't response OSC_SB_CPCV2_SUPPORT after
kernel changed to new behavior. The openSUSE bug is here:

Bug 1185513 - ACPI BIOS Error after upgrade to 5.12.0-1-default 
https://bugzilla.suse.com/show_bug.cgi?id=1185513

Could you please help to give any suggestion?

Thanks a lot!
Joey Lee

On Wed, Feb 03, 2021 at 10:14:15AM +0200, Mika Westerberg wrote:
> Hi Rafael,
> 
> I wonder if you are OK with this patch?
> 
> Thanks!
> 
> On Fri, Jan 29, 2021 at 11:32:39AM +0300, Mika Westerberg wrote:
> > From: Mario Limonciello <mario.limonciello@dell.com>
> > 
> > The platform _OSC can change the hardware state when query bit is not
> > set. According to ACPI spec it is recommended that the OS runs _OSC with
> > query bit set until the platform does not mask any of the capabilities.
> > Then it should run it with query bit clear in order to actually commit
> > the changes. Linux has not been doing this for the reasons that there
> > has not been anything to commit, until now.
> > 
> > The ACPI 6.4 introduced _OSC for USB4 to allow the OS to negotiate
> > native control over USB4 tunneling. The platform might implement this so
> > that it only activates the software connection manager path when the OS
> > calls the _OSC with the query bit clear. Otherwise it may default to the
> > firmware connection manager, for instance.
> > 
> > For this reason modify the _OSC support so that we first execute it with
> > query bit set, then use the returned value as base of the features we
> > want to control and run the _OSC again with query bit clear. This also
> > follows what Windows is doing.
> > 
> > Also rename the function to better match what it does.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/acpi/bus.c | 43 +++++++++++++++++++++++++++++++------------
> >  1 file changed, 31 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 1682f8b454a2..a52cb28c40d8 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -282,9 +282,9 @@ bool osc_pc_lpi_support_confirmed;
> >  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
> >  
> >  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
> > -static void acpi_bus_osc_support(void)
> > +static void acpi_bus_osc_negotiate_platform_control(void)
> >  {
> > -	u32 capbuf[2];
> > +	u32 capbuf[2], *capbuf_ret;
> >  	struct acpi_osc_context context = {
> >  		.uuid_str = sb_uuid_str,
> >  		.rev = 1,
> > @@ -321,17 +321,36 @@ static void acpi_bus_osc_support(void)
> >  		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
> >  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> >  		return;
> > -	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> > -		u32 *capbuf_ret = context.ret.pointer;
> > -		if (context.ret.length > OSC_SUPPORT_DWORD) {
> > -			osc_sb_apei_support_acked =
> > -				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> > -			osc_pc_lpi_support_confirmed =
> > -				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> > -		}
> > +
> > +	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> > +		return;
> > +
> > +	capbuf_ret = context.ret.pointer;
> > +	if (context.ret.length <= OSC_SUPPORT_DWORD) {
> >  		kfree(context.ret.pointer);
> > +		return;
> >  	}
> > -	/* do we need to check other returned cap? Sounds no */
> > +
> > +	/*
> > +	 * Now run _OSC again with query flag clear and with the caps
> > +	 * supported by both the OS and the platform.
> > +	 */
> > +	capbuf[OSC_QUERY_DWORD] = 0;
> > +	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
> > +	kfree(context.ret.pointer);
> > +
> > +	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
> > +		return;
> > +
> > +	capbuf_ret = context.ret.pointer;
> > +	if (context.ret.length > OSC_SUPPORT_DWORD) {
> > +		osc_sb_apei_support_acked =
> > +			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
> > +		osc_pc_lpi_support_confirmed =
> > +			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
> > +	}
> > +
> > +	kfree(context.ret.pointer);
> >  }
> >  
> >  /* --------------------------------------------------------------------------
> > @@ -1168,7 +1187,7 @@ static int __init acpi_bus_init(void)
> >  	 * _OSC method may exist in module level code,
> >  	 * so it must be run after ACPI_FULL_INITIALIZATION
> >  	 */
> > -	acpi_bus_osc_support();
> > +	acpi_bus_osc_negotiate_platform_control();
> >  
> >  	/*
> >  	 * _PDC control method may load dynamic SSDT tables,
> > -- 
> > 2.29.2

