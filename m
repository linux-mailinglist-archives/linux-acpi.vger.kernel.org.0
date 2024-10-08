Return-Path: <linux-acpi+bounces-8621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2F99549C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619DF283B77
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE71E0DDD;
	Tue,  8 Oct 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2yhxPyFO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38E1DED55;
	Tue,  8 Oct 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405544; cv=none; b=Ba3tVoD1DCJdIXTBydt3Xgo1ia+RnTnSCW2ffoQJJuhHNPdZBMOi9iJjbA9/+Tk+QYtchq+Tvaw+XPa05FtFJGijY/GnMwDbTqcgVby5FQartj12eT1TzlEcA9mJshtQ9Hyuw+9smhNtjC0Bzqk6IeU0nmxYMbqE4QcC8DmqSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405544; c=relaxed/simple;
	bh=cXLrnwbGDu54isWKgSKeu/RBK5nb1X4fHzuJBcTmJME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWSBiY5iRW6KI8MJl6Tr/kYXk5r3uh4r6I3FSbIbcOb72TuM093qn1wbmFqw9bvseCeTLv3Hcp7qT6o1fOPCAfNMry5g443ZRMGV4+NGntv1uVqUDlsmDd3H8lm8tObRpUyAb05BOjzyeO1boLB/CsKrZdv9+0LZ49FpCpmkk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2yhxPyFO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ken4YUAxm4Qit6mgswAP4SvlfA9kMoDip02jsaPefVo=; b=2yhxPyFOH2uJQLuuO5NuW4ZMef
	NUBvdJf+JxpLKoRRhnJM5LWfFDbndNakpz9KrjdNmuSdxR5dFdbCfU9w1WRMCsCOTbjHQwlZQIU3I
	vwaq2R0KalDga8BHfnYRCMT80Ws09WgIwYXUq71fGa88WFsGBtwOUu+YkiPnSp/EoiP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syDEP-009OMv-B0; Tue, 08 Oct 2024 18:38:41 +0200
Date: Tue, 8 Oct 2024 18:38:41 +0200
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
Subject: Re: [PATCH net-next 2/3] net: dsa: mv88e6xxx: leds: fix led refcount
 in error path
Message-ID: <5791caf0-05dd-4aa2-932d-626cf9158c4d@lunn.ch>
References: <20241008-mv88e6xxx_leds_fwnode_put-v1-0-cfd7758cd176@gmail.com>
 <20241008-mv88e6xxx_leds_fwnode_put-v1-2-cfd7758cd176@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-mv88e6xxx_leds_fwnode_put-v1-2-cfd7758cd176@gmail.com>

On Tue, Oct 08, 2024 at 06:10:28PM +0200, Javier Carrasco wrote:
> The 'led' fwnode_handle within fwnode_for_each_child_node() must be
> released upon early exits by means of an explicit call to
> fwnode_handle_put(), which in this case is missing.
> 
> Instead of adding the missing call, and considering that this driver was
> recently introduced, use a scoped variant of the loop to automatically
> decrement the child's refcount when it goes out of scope.
> 
> Note that the _avaialable_ version of the loop has been used, as there
> is no apparent reason to walk over unavailable nodes.
> 
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

