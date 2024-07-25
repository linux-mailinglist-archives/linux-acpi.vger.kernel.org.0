Return-Path: <linux-acpi+bounces-7055-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD593C71A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 18:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0821F21B15
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB9D19DF57;
	Thu, 25 Jul 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiyTau5p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBD19D880;
	Thu, 25 Jul 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924886; cv=none; b=QU4EffwhtTScWWq7m1Xjx9D9dmst5TgqROllRbMGYQhKPpILFQ//c33VMmO+9OP54GJLYbXUPkn77assfK1t56jvlS9VkxsoGegu80UO9ESy608i4G2W1MWPLgC770udyNR641oSXI6tLogLTsf79cixXvvDzODIQtStVBnMCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924886; c=relaxed/simple;
	bh=L7Fg0m1ebyP2PV/ivJTC9Xfja1OP5JV3H02XKfasc1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OT38r9u3oLT5a3UzkHVlrwiFmko5Hsp3ATEgZh8cZqwdPP3TdeRZDg9Z6Y/9AG5878dSPdFOXrpHeGCUC/RDrqZrhUtbAmKkgcypMmMPSvUnajjojIkcWlwkFrFf/ByMKMPXVod/hl1SIsIilKnFozhWm4tDN24Y0awjsKigkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiyTau5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D6BC116B1;
	Thu, 25 Jul 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721924886;
	bh=L7Fg0m1ebyP2PV/ivJTC9Xfja1OP5JV3H02XKfasc1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LiyTau5pMzmxs6bD/CxOOKH86UKrbpTZF1Nel2qo8HJGlIjkwJvQ04jQU/2tFFc5/
	 IKTI/sBNYtMfyhkhKfjrElrm+/3UskwyACdIARCu+QdpMy8oCjygLhG+ODfpvxIgAu
	 jTO1M/YjC5MBLNLoeMt7TOcDL/WThyditsFXNKVInnnogFYqh6AVHqt+2H62h4AjJL
	 VIR1oU5gfMLcL/Jxqu3jfVtdb+4cccoqgCwrLg65O8ZyVOz2X5fm0WuLzxQjgspCqg
	 n2HMqS9VX4MoXuShAZlCIFbCCr6elsxEJiHi3IGYOSrLWyzDRlX+8JaxDPceea5P56
	 /GQO5hzX4G95w==
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, 
 netdev@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
In-Reply-To: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
References: <20240721-device_for_each_child_node-available-v2-0-f33748fd8b2d@gmail.com>
Subject: Re: (subset) [PATCH v2 0/6] use device_for_each_child_node() to
 access device child nodes
Message-Id: <172192488125.1053789.17350723750885690064.b4-ty@kernel.org>
Date: Thu, 25 Jul 2024 17:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Sun, 21 Jul 2024 17:19:00 +0200, Javier Carrasco wrote:
> This series aims to clarify the use cases of:
> 
> - device_for_each_child_node[_scoped]()
> - fwnode_for_each_available_child_node[_scoped]()
> 
> to access firmware nodes.
> 
> [...]

Applied, thanks!

[3/6] leds: bd2606mvv: fix device child node usage in bd2606mvv_probe()
      commit: 75d2a77327c4917bb66163eea0374bb749428e9c
[4/6] leds: is31fl319x: use device_for_each_child_node_scoped() to access child nodes
      commit: 0f5a3feb60aba5d74f0b655cdff9c35aca03e81b
[5/6] leds: pca995x: use device_for_each_child_node() to access device child nodes
      (no commit info)

--
Lee Jones [李琼斯]


