Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA841417BB
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jan 2020 14:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgARNjl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Sat, 18 Jan 2020 08:39:41 -0500
Received: from mail-oln040092253076.outbound.protection.outlook.com ([40.92.253.76]:30016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbgARNjk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 18 Jan 2020 08:39:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPYIT59S7HD90OzqGJ2s/XU5+7OCwFOlMuyxfFHO7b9jhH5cNkGEOCv/IsWriLEojrCUgiLS33pi/zhQSvJ18UODE2A+nAQYb7BKjGmINFtu1VOtPpiPqzMKYeuv6zUZoPgbwAfXtm09JAQ2G7DoRRdxF2nlL1YxvKenPIWQGQ9YFCBqi70PBuUpT+mD08MQrnLqGTgDi+UCxjnDOGyfKbll9/vHxEx5YSZA7LNa+1fDfc3YGO5F8PZ3gQ17SklTF11X852QHtGMOLMOnX9xDmS9kYcdKno+GZv0dHva4ekD1A5Ogoak9aTgBPr+OI2/jdVRMhLokSWDtJMQMnUi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICWOMCZIeqdSKrF78kj1x2eroZvRAmTBfsAhkondm44=;
 b=W3BXpO/c0IvOFSWIQPO+DWc7QIW5VryHEaVm6dfI1lpwVx+gJZdJsMbskIu501fqbVapm1xCQjhGBUZQGoQIFpeifArNpNpTgRM+KLaF3kO5RH9WK0nniWg0gZnXGdN7u+DlKgJy8dnvsCmpeshHOQNWGO4tcYJW/FfPrTxIeV2yp8+Wl8Henqfts3ALONq2AIXd1Oap6xLtJliNIrGPyCCMZ4EkV/9D/539Hj17+WmVmce6XsVBv3YEaHSYD/EkwhXnqxGNliYPCyhXcoFwmJ8bKHqM0vTPX2tgJck4aGQjSFqOvgCrImCkCizxpvjqNqiOpeltnUg6f8w5bqS59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT050.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT099.eop-APC01.prod.protection.outlook.com
 (10.152.251.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Sat, 18 Jan
 2020 13:39:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT050.mail.protection.outlook.com (10.152.251.238) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Sat, 18 Jan 2020 13:39:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2644.024; Sat, 18 Jan 2020
 13:39:34 +0000
Received: from nicholas-dell-linux (61.69.143.229) by SYBPR01CA0028.ausprd01.prod.outlook.com (2603:10c6:10:4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Sat, 18 Jan 2020 13:39:27 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Thread-Topic: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Thread-Index: AQHVrtfd0zl4YBZzg0+ke2KUWaAOxqfuFpmAgAEZTQCAABIqAIABaZ8A
Date:   Sat, 18 Jan 2020 13:39:33 +0000
Message-ID: <PSXP216MB043880B31073ABD80E4A158D80300@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043839BFAE70C02DB13DEA4A80310@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200117160502.GA92383@google.com>
In-Reply-To: <20200117160502.GA92383@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0028.ausprd01.prod.outlook.com
 (2603:10c6:10:4::16) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:219E4BF2CED24DC63AAF8EDCE5FA0B2BAFCFEE10D19F55AA7EAAA37DBFA71019;UpperCasedChecksum:354D4A91CAE729787EFD002AF92EE7D0091FB68C1D304A9818D1498BA930333A;SizeAsReceived:7996;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Dm8T9EKwF1o3wLIkOXpCxLPgd4MtS2gy]
x-microsoft-original-message-id: <20200118133920.GA11209@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1b2a7737-003d-4f25-3bae-08d79c1bd7de
x-ms-traffictypediagnostic: SG2APC01HT099:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: As6Cy8kESb8Fq5Rw3TJhF5QmquE7NMTx9qHJEFsShVYvl4l5mfsWxJCP8Fbfrw6k3BB5evME9kIU4lWshZxjNygCwKwzm6J6ssDHkOV02Tijinwx6CcV8v6XBuZO044+Gr9VHOuArgtAMmaAOElnlTdu3zr0/uQxoh/wdhBSEku3d3uDQKGhdeyO5JRu+QXpi1xjz+rC7as6EL6uKr3KzSS1qwe8/5Q8tkmZqDvKT44=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C2078B3EE498941B31859B306E0C340@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2a7737-003d-4f25-3bae-08d79c1bd7de
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2020 13:39:34.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT099
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 17, 2020 at 10:05:02AM -0600, Bjorn Helgaas wrote:
> [+cc Rafael, linux-acpi, start of thread at
> https://lore.kernel.org/lkml/PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/T/#u]
> 
> On Fri, Jan 17, 2020 at 03:00:11PM +0000, Nicholas Johnson wrote:
> > On Thu, Jan 16, 2020 at 11:13:13PM +0100, Thomas Gleixner wrote:
> > > Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au> writes:
> > > 
> > > > Add pci=nobbn kernel parameter.
> > > >
> > > > Override the host bridge bus resource to [bus 00-ff] when specified.
> > > 
> > > Fine, but you completely fail to explain why this is useful and why
> > > someone would utilize this command line parameter.
> >
> > There are motherboards with single PCIe root complex which give 
> > significantly less than [bus 00-ff] via CRS. I own one with [bus 00-7f] 
> > and have seen some with significantly less.
> > 
> > A user who wants to use more busses than the motherboard advertises will 
> > want to use this kernel parameter, for instance if they have a lot of 
> > PCIe switches or Thunderbolt 3 devices.
> 
> I don't think this is a good idea.  "pci=nocrs" was mainly useful to
> work around Linux defects in handling _CRS methods.  I don't think we
> have comparable defects in our handling of _BBN.
What about motherboards with poor implementations, where they have 
possibly not given us all the busses solely becuase they thought nobody 
would need them all? Ideally, Linux would not have to deal with broken 
hardware - but yet, the world is full of poor implementations, hence the 
need for quirks.

> 
> In your example, the BIOS is telling us the bridge leads to [bus
> 00-7f].  We don't know what is at [bus 80-ff].  Maybe that range is
> valid and usable, and maybe it's not.  It could be routed to a
> different host bridge, it could contain devices the BIOS uses for its
> own purposes, it could be completely invalid.
If it is unusable, the system crashes and the user ceases to use the 
option. The option works wonders for me - no issues. This is the same as 
nocrs, which can lead to us using "unusable" memory from hidden devices. 
It is a risk, but there are people happy to live life on the edge, and 
giving them that option can enable those people to do what they want. 
Those who value stability will not use such options.

> 
> If we *did* decide this is a good idea, "nobbn" is a misleading name.
> _BBN evaluates to a single bus number, not a range.  In your example,
> BIOS is supplying _BBN=0 and _CRS that contains [bus 00-7f].  "nobbn"
> suggests that'd we'd ignore _BBN.  But this patch actually ignores the
> bus number range from _CRS, so it has nothing to do with _BBN.
Perhaps pci=nocrsbus - this is up for discussion. I am aware that it 
normally comes from crs but could not come up with a good parameter 
name.

> 
> > This is similar to how we have pci=nocrs to override motherboards with 
> > issues. The bus resource is not overridden by pci=nocrs, even though it 
> > will usually come from the same method. However, I believe it would be 
> > unwise to change pci=nocrs to include bus resource, as detailed in my 
> > original RFC.
> 
> For reference, I think this original RFC was
> https://lore.kernel.org/r/PSXP216MB04385B2C1BB518E5219C30CE80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
> 
> Bjorn

Regards,
Nicholas
