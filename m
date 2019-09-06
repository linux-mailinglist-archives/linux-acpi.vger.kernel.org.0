Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439E5AB48B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389743AbfIFJDV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Sep 2019 05:03:21 -0400
Received: from canardo.mork.no ([148.122.252.1]:46045 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732629AbfIFJDV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Sep 2019 05:03:21 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:2c6:ea50:dc9c:cbff:fe10:7b5a])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x8692whS016408
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 6 Sep 2019 11:02:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1567760580; bh=xZBEn2ft+wibAoI3k1K3RXJpJ2auCi0atCSt766wtBk=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=giIJe10iL+vlFe2vuBviurpKrXK/OMKbzM30mWx2duCTEhp5TDfM5iuNjrSH9hZz2
         oanQGGMtoDFE3NDEUWhgl9j1GMR+xGo6/RWwqSqiPm/8671k+/LYggR4lqRJEd/JCU
         JO8CTdr9MGryO08SjCdFQ4/d9Iomr5YvtxQ1x0ZI=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i6A8q-00038G-UR; Fri, 06 Sep 2019 11:02:52 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <oliver@neukum.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <Mario.Limonciello@dell.com>, <chip.programmer@gmail.com>,
        <nic_swsd@realtek.com>, <linux-usb@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/3] net: cdc_ncm: add get/set ethernet address functions
Organization: m
References: <1567717318990.49322@Dellteam.com>
Date:   Fri, 06 Sep 2019 11:02:52 +0200
In-Reply-To: <1567717318990.49322@Dellteam.com> (Charles Hyde's message of
        "Thu, 5 Sep 2019 21:01:59 +0000")
Message-ID: <87zhjhssoz.fsf@miraculix.mork.no>
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

> +static int cdc_ncm_get_ethernet_address(struct usbnet *dev,
> +					struct cdc_ncm_ctx *ctx)


Is this function called anywhere?  Shouldn't it replace the
usbnet_get_ethernet_addr() call in cdc_ncm_bind_common()?

But do note that cdc_ncm_bind_common() is shared with cdc_mbim and
huawei_cdc_ncm, and that NCM specific code therefore must be
conditional.

That's why the usbnet_get_ethernet_addr() call is currently wrapped in
'if (ctx->ether_desc) {}'.  You should definitely not try to do
USB_CDC_GET_NET_ADDRESS or USB_CDC_SET_NET_ADDRESS on MBIM.  I don't
know about the Huawei firmwares.  But I believe it's best to be careful
and avoid these requests there too. Unless you have a number of
different Huawei devices with assorted firmware revisions for testing.
CDC NCM compliance is obviously not a requirement for their vendor
specific dialect.

> +{
> +	int ret;
> +	char *buf;
> +
> +	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

usbnet_read_cmd() will kmalloc() yet another buffer, so this is
completely pointless.  Just use the stack for the 6 byte buffer.

Or let it write directly to dev->net->dev_addr, since you will fall back
to usbnet_get_ethernet_addr() anyway if the request fails.

> +	ret =3D usbnet_read_cmd(dev, USB_CDC_GET_NET_ADDRESS,
> +			      USB_DIR_IN | USB_TYPE_CLASS
> +			      | USB_RECIP_INTERFACE, 0,
> +			      USB_REQ_SET_ADDRESS, buf, ETH_ALEN);

Where did that USB_REQ_SET_ADDRESS come from? Did you just look up an
arbutrary macro that happened to match your device config?  How do you
expect this to work with a generic NCM device?  Or even your own device,
when the next firmware revision moves the function to a different
interface?

It's nice to have USB_CDC_GET_NET_ADDRESS and USB_CDC_GET_NET_ADDRESS
implemented, but there are a large number of NCM devices.  You should
probably test the code with one or two other than your own.

Note that few, if any, NCM devices are spec compliant.  You should
expect at least one of them to do something really stupid when the see
this optional and unexpected request.  I think it would be wise to avoid
sending unsupported requests more than once to a device.

> +	if (ret =3D=3D ETH_ALEN) {
> +		memcpy(dev->net->dev_addr, buf, ETH_ALEN);
> +		ret =3D 0;	/* success */
> +	} else {
> +		ret =3D usbnet_get_ethernet_addr(dev,
> +					       ctx->ether_desc->iMACAddress);
> +	}
> +	kfree(buf);
> +	return ret;

If you passed dev->net->dev_addr above, then this could be simplified to

        if (ret =3D=3D ETH_ALEN)
            return 0;
        return usbnet_get_ethernet_addr(dev,..);

> +
> +/* Provide method to push MAC address to the USB device's ethernet contr=
oller.
> + * If the device does not support CDC_SET_ADDRESS, there is no harm and =
we
> + * proceed as before.
> + */
> +static int cdc_ncm_set_ethernet_address(struct usbnet *dev,
> +					struct sockaddr *addr)
> +{
> +	int ret;
> +	char *buf;
> +
> +	buf =3D kmalloc(ETH_ALEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy(buf, addr->sa_data, ETH_ALEN);
> +	ret =3D usbnet_write_cmd(dev, USB_CDC_SET_NET_ADDRESS,
> +			       USB_DIR_OUT | USB_TYPE_CLASS
> +			       | USB_RECIP_INTERFACE, 0,
> +			       USB_REQ_SET_ADDRESS, buf, ETH_ALEN);


Same comments as above.



Bj=C3=B8rn
