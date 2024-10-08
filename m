Return-Path: <linux-acpi+bounces-8622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267BE9954A0
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5817F1C23DE7
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD971E0E05;
	Tue,  8 Oct 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2DQ44bp7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BA1E0DF7;
	Tue,  8 Oct 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405640; cv=none; b=l8pTrRmVEm1gaCXPlgZjbzoySmzBzhr5OYnBHeFYa1aa3sFuPkOuj+wQDtpY1r/ICM5Dc95GgY9gq8b8pOyyiyfrZazATNtLlOVGYHtv01kxxYP9/R9ABzrvAKf/hX2AMtMO18sps9zmUc+FpC4DmXzyKG6PDsZgNV3TlIiSK0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405640; c=relaxed/simple;
	bh=tahjeGOR1Rbp76f0sBahQKgPgEwRlKxvMliVN1RuazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixdaM9aolyGvH+wECs2LLx2IAdJOQFBUdvnaYYFSs8OHq2YRBMPjEZzkyiZV7ZFS1OxpWKuX2lekXwavUZH79+KnRZFqUc1qjHBwFdNgI0NTm+vDRges5je7o0E60W3kM/GIo3aAOp9SAO15L6oV1H54dIDAQtM63QWY3cMxly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2DQ44bp7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mvnXt7hhelUbdZmwS4HXJ3Ys87mx2FXWRRjMG52QDwQ=; b=2DQ44bp73UGEx9UkxOs2UoS/Gt
	TecWF1syckL1CzQve2clKgNN9mhP6abJor+zbaK4DeZa8lFoIria99/vByOHdfl2zjUjMXaF6aq7E
	mO5PhrIakMhtvStYsNLujAoIXzQUPIFS/h6NvgvtMH0bTnV7Uz0x9/rSTJM8lJS1zxtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syDG8-009OOI-CC; Tue, 08 Oct 2024 18:40:28 +0200
Date: Tue, 8 Oct 2024 18:40:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: mv88e6xxx: leds: fix leds refcount
Message-ID: <3efe3c1a-7ce6-4055-a9b1-31a7e23f9417@lunn.ch>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-3-cfd7758cd176@gmail.com>

> -	leds = fwnode_get_named_child_node(p->fwnode, "leds");
> +	struct fwnode_handle *leds __free(fwnode_handle) =
> +		fwnode_get_named_child_node(p->fwnode, "leds");

https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

  Low level cleanup constructs (such as __free()) can be used when
  building APIs and helpers, especially scoped iterators. However,
  direct use of __free() within networking core and drivers is
  discouraged. Similar guidance applies to declaring variables
  mid-function.

    Andrew

---
pw-bot: cr

