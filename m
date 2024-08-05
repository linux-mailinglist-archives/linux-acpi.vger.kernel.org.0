Return-Path: <linux-acpi+bounces-7310-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F295947EE2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E07628409C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EE154C0E;
	Mon,  5 Aug 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8pjC8J4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024813B2A8;
	Mon,  5 Aug 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873635; cv=none; b=VKL18X1LBTeQ661cc4WxFVZJ0Z4Hk+KnvTQBljodz69gh9XFtUQ5aTCcYPH1Al3aXDlLSY3t6/A/9/B//BcFjpZWx5c6ypbqgT1DxFxUDIx9vRJ9BossnDpbivlSN06bizciR2ya5KoJvpNEJiB1AtjsPe4jaAKCZo0WgW6pPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873635; c=relaxed/simple;
	bh=ahSZrYTp7z3n6Jnf15MfP3NL9/KYAULDq4lAhW8oJUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QqcxybO6tyDz9gjPGRRjq9/B95p+jO38uE8Xb7i+0xbYW3eiz6GLqmW9plDp4D6kbtDS/51oV2404KsmzMe6FmEpoZThBuI/jtKPA0hAzvcPdg5C0YWR24E7ukD4iEeBdDXyIW8zuQF1EZVbaUOCngxGLse6Ntaly7Yeqz7MtyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8pjC8J4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D397BC4AF0C;
	Mon,  5 Aug 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722873634;
	bh=ahSZrYTp7z3n6Jnf15MfP3NL9/KYAULDq4lAhW8oJUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g8pjC8J4eVVPt38Z+WshcUlUDfyHB608zCQiyvwt82QBAz3KcAgKMrCdUhajlaeQL
	 6EzxGViT+NMrHzBtd0jeTVBIzw9c03l9/8JPReUGCt4yqutFDr0q8a4Xl+enTUbm3B
	 nRz48VJWjQwM2vqY5bCKHbybCI49/bkuACkqM/wwQsrZdZHbqZ86T9acGiDCcLslAP
	 J8rwAPk1/iUyEA72h9xpUA1iG+qwoT8w+yrJWGT4CqhdMYXbsvbvuqScAWQ7hmgvmA
	 JLDZQX7wTFRxNRHrL6/A32EctPQyWePGR/PZwzEj6XeUXRuUOArD19NDTKkMKaFIMG
	 py75SON754QFQ==
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
In-Reply-To: <20240805-device_for_each_child_node-available-v3-2-48243a4aa5c0@gmail.com>
References: <20240805-device_for_each_child_node-available-v3-0-48243a4aa5c0@gmail.com>
 <20240805-device_for_each_child_node-available-v3-2-48243a4aa5c0@gmail.com>
Subject: Re: (subset) [PATCH v3 2/4] leds: pca995x: use
 device_for_each_child_node() to access device child nodes
Message-Id: <172287362960.2885491.3573302906275384293.b4-ty@kernel.org>
Date: Mon, 05 Aug 2024 17:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 05 Aug 2024 16:49:45 +0200, Javier Carrasco wrote:
> The iterated nodes are direct children of the device node, and the
> `device_for_each_child_node()` macro accounts for child node
> availability.
> 
> `fwnode_for_each_available_child_node()` is meant to access the child
> nodes of an fwnode, and therefore not direct child nodes of the device
> node.
> 
> [...]

Applied, thanks!

[2/4] leds: pca995x: use device_for_each_child_node() to access device child nodes
      commit: 6eefd65ba6ae29ab801f6461e59c10f93dd496f8

--
Lee Jones [李琼斯]


