Return-Path: <linux-acpi+bounces-7311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70937947EEB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 18:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FFA1F22B6E
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912815B97E;
	Mon,  5 Aug 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsjqayGp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF854D8B7;
	Mon,  5 Aug 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873721; cv=none; b=aNmIAi4r3FZgUh9hObGgTUqAg+8aXwO88FmKiSopVl1sZ+gwb5o21pB9pJx3Wj6nJO/lALQVPrHbYh/B854KmeV8QesygjZvlGMFLPNdhrMXZEMKPyCkPNV7zX31p1xLH+PP0aZWVA2k1YfuK8Jcy6ei3NvUv3hMd2tH32glM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873721; c=relaxed/simple;
	bh=Rcje2/xK6I1APIwp9iPWAeW2078we45PDjWIxAELg50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl9Yx8X/tPJJaiHL6xhys5DZh9HB2ynbxsmKQcoCiquCRZxXimhz/YMQKeU0TyqqMqb1CV/4lp5OURgkg2ol+E3DWvh5NikP4hEGaHNjofKzIpa2J/qtyhSd5NS4WhnzOnZUMvQKGIeuF0/gv45bBU4IZu5n154BibCREXXvojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsjqayGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA973C4AF0C;
	Mon,  5 Aug 2024 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722873720;
	bh=Rcje2/xK6I1APIwp9iPWAeW2078we45PDjWIxAELg50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsjqayGpe0FdEbp/55h5nnYMn0r2h7JdXw8ZXfHZt7PFq0rIHnAAepTiZZSl3eYW6
	 zhhcuglwQQCaQAXZEtzkUm6kUGsOVZT4LSN95fFfWnTamCo7hctO+p8nvuu4IzQlMn
	 QzH7/UtJ5iAMT0AqqafumZ6ymQeDJ6UTXqcEL6jpoFM+qwQm/Etn/2hmIAFYnL3MTD
	 ESyC99h2R2/wS8/Y9cvuGLjlkYX/ofg9PSOCxXxwVb2C19lg7qMmZRAaegLtmYutgz
	 Mm0ndD1eO46Y0IRS+OCYF7sm9kfNv4UgXMTDO2v1Md/7yZYEXtYPxOxaxDrXRCrBAR
	 TG2bnumQ7Z7Tw==
Date: Mon, 5 Aug 2024 17:01:53 +0100
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
	netdev@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 2/4] leds: pca995x: use
 device_for_each_child_node() to access device child nodes
Message-ID: <20240805160153.GG1019230@google.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
 <20240805-device_for_each_child_node-available-v3-2-48243a4aa5c0@gmail.com>
 <172287362960.2885491.3573302906275384293.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172287362960.2885491.3573302906275384293.b4-ty@kernel.org>

On Mon, 05 Aug 2024, Lee Jones wrote:

> On Mon, 05 Aug 2024 16:49:45 +0200, Javier Carrasco wrote:
> > The iterated nodes are direct children of the device node, and the
> > `device_for_each_child_node()` macro accounts for child node
> > availability.
> > 
> > `fwnode_for_each_available_child_node()` is meant to access the child
> > nodes of an fwnode, and therefore not direct child nodes of the device
> > node.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [2/4] leds: pca995x: use device_for_each_child_node() to access device child nodes
>       commit: 6eefd65ba6ae29ab801f6461e59c10f93dd496f8

I'm not sure what you rebased onto, but it wasn't LEDs or -next.

Anyway, I fixed-up the conflicts and pushed.

The patch should be in -next by tomorrow.

Please check it to ensure I didn't make any mistakes.

-- 
Lee Jones [李琼斯]

