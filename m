Return-Path: <linux-acpi+bounces-7107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F150A93EFD3
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F92838F6
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484713A3FF;
	Mon, 29 Jul 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yqmS2yCV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E5163;
	Mon, 29 Jul 2024 08:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241441; cv=none; b=o5dBR6CoRBBnWFjGFvFvwbZvpL+49rq/LA/uqbolJsk+KgwoHhPE+82yviaCMWvLMv9xc0zUJXm6gjGnJ0eiCZ5j5f41BDSybYNustXtiIdQq197effLCYIcn3sS3WWzDmtwjz55DoNhiS1KKwQko3616u0JOaE0EyT55cQVvjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241441; c=relaxed/simple;
	bh=7X5xnHFefvuElntNGSqCpczzz7wiyzBF3tNMyaeA8D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2Rngvs3MqvGivVShc10+Zw9a9JndPSCKG374aWLOyMrv91cwTuwXK7/XHHY/aghm1S9Ae4M1XfnAeI2HBdVG4QMd5tDMg6KORtnej07CSDWuOvHc3PAQ5d+nRr3jsajQjB2Yyt6eMoGEUHYwAonaOGmgPMwSdoJeFl3evRJ40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yqmS2yCV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mrWuVJBqtXXYWh1tuazQKatQsFaPa3sBlAWQOq6z7vg=; b=yqmS2yCVLIM4Y3ahJwyIQfrNtz
	iANxgSSpa79Sv7aC63NctW+C/c9m6w/86Tkzv0dz9T8ggCEJXpJ4grVsVI8u7s9BzfYNxVW6NwCQP
	gfPiQmsbV+CI0ARm3JQyH18FjVroQuszf9Tpwfx3IRQYrf/su4r7Mnr7JlnrMhps26ZK/Wip/3be3
	V0UiIRG3JbGg9510ifzaTTHPjp7HPMoKDDBeXZZzpyhNmkldkcfrzmfP7eJHA39kMTXn/pplsvIgk
	BLyUiVj0wy0ziQ4N82lJd91IOiYvP2aIQ5KWq37rcc8SdWQgv/+e4+Imj3d2tJjvfjm5K1umRSZTd
	KCyJWggw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40970)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYLfC-0003Ok-17;
	Mon, 29 Jul 2024 09:23:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYLfE-0004AV-FT; Mon, 29 Jul 2024 09:23:28 +0100
Date: Mon, 29 Jul 2024 09:23:28 +0100
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
Message-ID: <ZqdRgDkK1PzoI2Pf@shell.armlinux.org.uk>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
 <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706-device_for_each_child_node-available-v1-6-8a3f7615e41c@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 06, 2024 at 05:23:38PM +0200, Javier Carrasco wrote:
> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> The child nodes within mvpp2_probe are not accessed outside the lopps,

"lopps" ?

> and the socped version of the macro can be used to automatically

"socped" ?

> decrement the refcount on early exits.
> 
> Use `device_for_each_child_node()` and its scoped variant to indicate
> device's direct child nodes.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 9adf4301c9b1..97f1faab6f28 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -7417,8 +7417,6 @@ static int mvpp2_get_sram(struct platform_device *pdev,
>  
>  static int mvpp2_probe(struct platform_device *pdev)
>  {
> -	struct fwnode_handle *fwnode = pdev->dev.fwnode;
> -	struct fwnode_handle *port_fwnode;
>  	struct mvpp2 *priv;
>  	struct resource *res;
>  	void __iomem *base;
> @@ -7591,7 +7589,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Map DTS-active ports. Should be done before FIFO mvpp2_init */
> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>  		if (!fwnode_property_read_u32(port_fwnode, "port-id", &i))
>  			priv->port_map |= BIT(i);
>  	}
> @@ -7614,7 +7612,7 @@ static int mvpp2_probe(struct platform_device *pdev)
>  		goto err_axi_clk;
>  
>  	/* Initialize ports */
> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>  		err = mvpp2_port_probe(pdev, port_fwnode, priv);
>  		if (err < 0)
>  			goto err_port_probe;
> @@ -7653,10 +7651,8 @@ static int mvpp2_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_port_probe:
> -	fwnode_handle_put(port_fwnode);
> -
>  	i = 0;
> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
> +	device_for_each_child_node_scoped(&pdev->dev, port_fwnode) {
>  		if (priv->port_list[i])
>  			mvpp2_port_remove(priv->port_list[i]);
>  		i++;
> @@ -7677,13 +7673,12 @@ static int mvpp2_probe(struct platform_device *pdev)
>  static void mvpp2_remove(struct platform_device *pdev)
>  {
>  	struct mvpp2 *priv = platform_get_drvdata(pdev);
> -	struct fwnode_handle *fwnode = pdev->dev.fwnode;
>  	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
>  	struct fwnode_handle *port_fwnode;
>  
>  	mvpp2_dbgfs_cleanup(priv);
>  
> -	fwnode_for_each_available_child_node(fwnode, port_fwnode) {
> +	device_for_each_child_node(&pdev->dev, port_fwnode) {
>  		if (priv->port_list[i]) {
>  			mutex_destroy(&priv->port_list[i]->gather_stats_lock);
>  			mvpp2_port_remove(priv->port_list[i]);

This loop is just silly. There is no need to iterate the child nodes.
port_fwnode is not used, and the loop boils down to:

	for (i = 0; i < priv->port_count; i++) {
		mutex_destroy(&priv->port_list[i]->gather_stats_lock);
		mvpp2_port_remove(priv->port_list[i]);
	}

Not only is walking the child nodes not necessary, but checking whether
the pointer is NULL is also unnecessary. mvpp2_port_probe() populates
the array using:

        priv->port_list[priv->port_count++] = port;

and "port" can not be NULL here, so we're guaranteed that all port_list
entries for 0..priv->port_count will be non-NULL, and the driver makes
this assumption in multiple places.

In fact, I'd say that using fwnode_for_each_available_child_node() or
device_for_each_child_node() is buggy here if the availability of the
children change - it could leave ports not cleaned up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

