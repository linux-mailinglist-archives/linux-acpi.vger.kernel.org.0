Return-Path: <linux-acpi+bounces-7112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4DE93F60D
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713791C21C1C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 13:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD0146584;
	Mon, 29 Jul 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1GSkuUcM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9691DFCF;
	Mon, 29 Jul 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258095; cv=none; b=LGMeNvUqNnjRWDaMICGzivPB+kD60QQD2jCMZZ1UMS8d7C8EaK8D8Zw1VyiKg12Hy2nDAz+OOlX94do2Qm6swrRNAno1QqySj4dfwvbiG/KYVkwhDpbEUV97cHvbQB4tXX1hOuP7qUCHHKSlslCrmMU6NC7+PtXTyVn+JuPkv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258095; c=relaxed/simple;
	bh=lyMQxeeEfari71/LaXTaod34URVqznPpnYytJZ6gTr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfAPWDRQpOVFW2mEdObYXU8jOpLkrhfN49Qrk/CmHpnL3GlMM434p1cdU6Zpz3YPjCP5jg62JMsO3rNHMk1kYuwXjdRkM0c9H76MyS71URzMacDAvXOPlSprLwRWflzfxAO6o/QCxp5uPKkIs/3BPTreUqR1bJ8+FTeQw3h+Q9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1GSkuUcM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dCor073xQJijp8I3RK3+ty7FjGp2GGPrVnPyb5mRIYg=; b=1GSkuUcMy+MnQlrUUZPZiL0Ly1
	wOJOpFW9Dt0n42j9nsc0LVGkc3G+6GPbXxx+ZDe53eeqx673xKGuCnzOrTx4epdFvaYwzMsxkTSRR
	gLtYX28JoCoPRJ87N0XRwsvLOCpF6My7Oj2j7wen56JhKivm+CKuH/au6IXd/PC6kmGAzWZRBSz5r
	ozwMLyEdlI8UkrK5WHK8xSjQRp9/SQvCCUzUGatWht/0O3UNm5r29E2wr3+ccshTiNNn/Ec79Nrfl
	iV9EgtQoX1Tj0DeCd/h9othUdgE6IGfc9O8kKzYQh4O/c4Kcvoqru5wAqHlb2WW2nGzbFeMChzKlR
	f0BFD+Mw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46248)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYPzP-0004Lu-1R;
	Mon, 29 Jul 2024 14:00:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYPzQ-0004L5-68; Mon, 29 Jul 2024 14:00:36 +0100
Date: Mon, 29 Jul 2024 14:00:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 6/6] net: mvpp2: use device_for_each_child_node() to
 access device child nodes
Message-ID: <ZqeSdMMOk+GbVzHj@shell.armlinux.org.uk>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
 <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
 <ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk>
 <aa440f7c-0ccc-443c-8435-50c864edd1c2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa440f7c-0ccc-443c-8435-50c864edd1c2@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 29, 2024 at 11:23:47AM +0200, Javier Carrasco wrote:
> Apart from that, there is a suspicious check towards the end of the same
> function:
> 
>  if (is_acpi_node(port_fwnode))
> 		return;
> 
> At the point it is called in the current implementation, port_fwnode
> could have been cleaned. And after removing the loop, it is simply
> uninitialized. Was that meant to be pdev->dev->fwnode?

If you're referring to the one before the clk_disable_unprepare() calls,
it's only slightly suspicious:

These clocks are setup in a:

        if (dev_of_node(&pdev->dev)) {
		...
	}

block, so they're only setup if we have device tree. So, avoiding it
for ACPI is entirely reasonable. However, we also have software nodes
as well, so the test should be:

	if (!dev_of_node(&pdev->dev))
		return;

to match what the probe function is doing.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

