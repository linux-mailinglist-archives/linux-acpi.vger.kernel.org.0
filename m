Return-Path: <linux-acpi+bounces-6798-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B856929903
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80F61F2154F
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Jul 2024 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711E35588B;
	Sun,  7 Jul 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueuz1wW9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31A5337F;
	Sun,  7 Jul 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371526; cv=none; b=ePeWggPfkGlxt+4WVSBOZKDUhoHbEXs8bB7u/AUeWcwsIx45Vpb2ueAxuHCsc69tMPiNmxyj67IYbGsQyggCLXxHWwUF9YQCWtwwQ8yTxdn9QhZvqPN561DTj6e3WDD/eBdtGGhiz2t3eCb0DdAjQwbAaKT4hbXld8ZB96zfaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371526; c=relaxed/simple;
	bh=NX5O9Z6ai9tV4k690hOuPXtRQyXWHVC1y49XRiHK52E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhsYUK2g3H9vWsnNKNJMAN7CaKADgKwyy8MyZ7YE3vAi5DadJDYjv1hytYfCEoXWhOG8V3Wk5jaIIxwWRgIHjXGtOB1UvTqrF2pcVA6T8PE1Fc9PYWoe232f8t0C7cVg7nqO6KQCscQmrkH05o28LacBR99AO/A/kK6IXGip4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueuz1wW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8587C3277B;
	Sun,  7 Jul 2024 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371526;
	bh=NX5O9Z6ai9tV4k690hOuPXtRQyXWHVC1y49XRiHK52E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ueuz1wW9S7RI7vFiY1/1jUmwPhDN1lxSyUY01RVcUWl2X+9qlQJWBx2JF/rlF0Btj
	 1kBP+9lIdc7s4sei41pOmglxBauwtGVJGMHtx3EIFHc06MzhJyW0yNilCegzvQ+B/5
	 omb4LBO60Kmbf9Q4tJQPF5ipR+FR5eUsyKz999MJlROy5Szmm2RzmwTZCJNQZgWWlI
	 IWmNb688Fb3xLE64rwMLEYHIj/MxCqMW9LAmr7IgEbf7t1OXV0Erksw1d+Q/59PzUh
	 ajRvGI1t0JFQJYk7u8YnBCj3ayo0Bov+degtlyOjiGOFtOyN83QhGurFUuWFG2lz6Z
	 eainyYcPIG+oA==
Date: Sun, 7 Jul 2024 17:58:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/6] leds: is31fl319x: use
 device_for_each_child_node_scoped() to access child nodes
Message-ID: <20240707175833.34fc4ed5@jic23-huawei>
In-Reply-To: <20240706-device_for_each_child_node-available-v1-4-8a3f7615e41c@gmail.com>
References: <20240706-device_for_each_child_node-available-v1-0-8a3f7615e41c@gmail.com>
	<20240706-device_for_each_child_node-available-v1-4-8a3f7615e41c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jul 2024 17:23:36 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> In this case, the child nodes are not required outside the loop, and
> the scoped version of the macro can be used to remove the repetitive
> `goto put` pattern.
> 
> Use `device_for_each_child_node_scoped_scoped()` to indicate device's
> direct child nodes.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

