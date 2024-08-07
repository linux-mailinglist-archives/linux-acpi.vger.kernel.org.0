Return-Path: <linux-acpi+bounces-7395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE1949D41
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21721F21F4C
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7F1D6AA;
	Wed,  7 Aug 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwmqY3xg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E5848E;
	Wed,  7 Aug 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993029; cv=none; b=k0DSkdl3pzlpSLUxJUURNtM0Rk348uzKeFapXNmLNlukmyK9wXA0Pe3rwGwEZP07JxpE3BqxGa85ZdZL4Tj3mY7hBiWJLVpFv9Pnm7bEtB7BYsawjaUC7q86tdlHoMsnVgePDOk9/4AyGTsKcwb+U5NE0ANsn7KLtvcQsLPoFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993029; c=relaxed/simple;
	bh=VEAeKiK6hlF02EdznumwnpyEAnhaUk/4dKPHAU8S8w0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dItxlh6CAL6iPalz72ZuN9vX+Nbjyg54huvAG9BeLht8cnj9vw/xdCiTWqkchlJ4XofDTqL7Q5N84GtpWJfeAaQfil2/AHRkKbnQGakxTyZckYl9Y2aw3vAsXVrTmIlenXwQ0kncAUCsveNIpkrHJO8f2O9flUtao0zdGQwhCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwmqY3xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FB2C32786;
	Wed,  7 Aug 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722993028;
	bh=VEAeKiK6hlF02EdznumwnpyEAnhaUk/4dKPHAU8S8w0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TwmqY3xgc+0TjXESQoAlont+KKERKMwpynWBjE/jIDSYtYIs31wbYVPKNhcBVFz/1
	 Xp3ZJaLaz2VbGVdmis57ZWqTjW/OhSo1CvQ6/hdTFQh6JTtBz4ryzzUSv8f3Wt9e0e
	 tkmNqCl+zIBSYk190xykWWhZhW7VWD1u/0gSupTbUC00+nvbzD0Ny3bXwpD13ksVpL
	 /1+lYzln/v8uyeif/Msgzr8HOh6PAHWjQ/LQcnaP4Bvy+ymhYDDoJcFcb1zduuaURS
	 wcdbbpJJMmzXAvevUghkijm0VccIrlIuQwZ4bvvqkf1bwZ4T1c9Z6Dkd9AhMs/7imo
	 dg8vuiScGTVJw==
Date: Tue, 6 Aug 2024 18:10:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Lee Jones
 <lee@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andreas
 Kemnade <andreas@kemnade.info>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, netdev@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 0/4] use device_for_each_child_node() to access
 device child nodes
Message-ID: <20240806181026.5fe7f777@kernel.org>
In-Reply-To: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 Aug 2024 16:49:43 +0200 Javier Carrasco wrote:
>       net: mvpp2: use port_count to remove ports
>       net: mvpp2: use device_for_each_child_node() to access device child nodes

Please repost these two separately so we can take the whole series 
via networking. As is the series doesn't apply so it's too much
manual twiddling to fit into our tree.

