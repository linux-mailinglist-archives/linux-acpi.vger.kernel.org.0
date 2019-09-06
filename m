Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFAEAC188
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 22:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfIFUkQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 16:40:16 -0400
Received: from canardo.mork.no ([148.122.252.1]:52117 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbfIFUkQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 16:40:16 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x86Kdid0024499
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 6 Sep 2019 22:39:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1567802386; bh=+LVxMZTDoXthUdCoqKn6C5OPG83oXn+cHvwFObYBYKM=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=MBehWhclsr1soqNz+TsPn3VjZ987WpdMBccUdzscdZpfscGa0Uv92s68kf53JGH3j
         VbWAWdH4rOSbQiYl4FSpT3BBKv0Ojbi3ZplyI+ny0VbF3HxmHxBlekpE26exwm7044
         r1ctHidD/WDuz+0vcX2ABO1jjRdx0iH8r/y+YVn8=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i6L1E-0005h9-0b; Fri, 06 Sep 2019 22:39:44 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <stern@rowland.harvard.edu>, <oliver@neukum.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Organization: m
References: <43fa8b0a974d426faccf5e6d486af18a@AUSX13MPS307.AMER.DELL.COM>
        <Pine.LNX.4.44L0.1909061412350.1627-100000@iolanthe.rowland.org>
        <a9999ed336ba4f2a8cb93c57f0b3d2f4@AUSX13MPS307.AMER.DELL.COM>
        <87mufhqjdb.fsf@miraculix.mork.no>
        <d8cdacc63ddd4da4a88d3712b2b53d32@AUSX13MPS307.AMER.DELL.COM>
Date:   Fri, 06 Sep 2019 22:39:43 +0200
In-Reply-To: <d8cdacc63ddd4da4a88d3712b2b53d32@AUSX13MPS307.AMER.DELL.COM>
        (Charles Hyde's message of "Fri, 6 Sep 2019 20:20:13 +0000")
Message-ID: <87ftl9qhv4.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.2 at canardo
X-Virus-Status: Clean
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<Charles.Hyde@dellteam.com> writes:

>> > What better suggestion do folks have, instead of using
>> USB_REQ_SET_ADDRESS?
>>=20
>> The spec is clear: wIndex is supposed to be 'NCM Communications Interfac=
e'.
>> That's how you address a specific NCM function (a USB device can have mo=
re
>> than one...), and that's what you'll see in all the other interface spec=
ific class
>> requests in this driver.  You don't have to look hard to find examples.
>>=20
>>=20
>> Bj=C3=B8rn
>
>
> I have presented what works, with the v3 patch series.

Sure. It will work iff your NCM function has a control interface
numbered 5.  Most NCM functions do not.

> Mind you, the code I have provided sends the exact same USB message as
>  I traced with Wireshark on my Windows system.

Snooping on communcation with one specific device is not a good way to
figure out dynamic content. wIndex cannot be a constant.  It depends on
the device configuration.

>If you can provide good working code that replicates what I have
>provided, I would be thrilled.

There is working control request code a few lines up in the driver.  I
didn't think it was too much to ask that you looked it up.  But I can
copy an example here too:


static int cdc_ncm_init(struct usbnet *dev)
{
	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
	u8 iface_no =3D ctx->control->cur_altsetting->desc.bInterfaceNumber;
	int err;

	err =3D usbnet_read_cmd(dev, USB_CDC_GET_NTB_PARAMETERS,
			      USB_TYPE_CLASS | USB_DIR_IN
			      |USB_RECIP_INTERFACE,
			      0, iface_no, &ctx->ncm_parm,
			      sizeof(ctx->ncm_parm));
,,

You'll obviously have to replace USB_CDC_GET_NTB_PARAMETERS with
USB_CDC_GET_NET_ADDRESS, &ctx->ncm_parm with buf, and
sizeof(ctx->ncm_parm) with ETH_ALEN.


Bj=C3=B8rn
