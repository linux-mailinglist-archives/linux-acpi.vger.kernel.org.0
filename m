Return-Path: <linux-acpi+bounces-12939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945CEA83E30
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E215916C6D9
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3820C486;
	Thu, 10 Apr 2025 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjR3WPGI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2020C471;
	Thu, 10 Apr 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276362; cv=none; b=GvVYb9aUoru0N2DlYer42lZ/BKGl52Kywlt6BjIdFLhJD5hA+vIc6nzJtci9nc4OWxPtA22Q8iHX8Dmyx8ad7sPV83+bb/TeVF/pooWNrbUw26pJwdMhJXtwYWm9Zm+9qsLOzU/Wazt6yi057W2dDMTq70rqmqjCOysoPD1PWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276362; c=relaxed/simple;
	bh=tnQ5awqGoh+LT3f7BlATG0XmmrwP46na2dkB3wG7XD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m4u7FMh7eVBo07yFR/2Qo5W+O9uqeT7+mUl8ukTt5uXM0kryU4hp/lMvhwNhlZAUW9eICb1dnHQX76Oe66N10rcdVbdqZ/OXGSEoNTA+osdR0lnxbH1nSilVhDqMkyojmdPV2DNCWA6ezqTD7XU99Y0fQAmqYILwiAbswE+/ms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjR3WPGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C13C4CEDD;
	Thu, 10 Apr 2025 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744276359;
	bh=tnQ5awqGoh+LT3f7BlATG0XmmrwP46na2dkB3wG7XD8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WjR3WPGIQVwwjQNBadceQTL8QQ6HAykIWJ7WP/b4KEgLK96+l+C4C3RIGFv9fIlEY
	 tB2i5D4I/xaPEqYXsw4JPlNtb6xSztDmoCBVWAnyAOwEPe7Ik68QRRHciWaUYeotcG
	 lLN6xQ2VRPLTuzW7vvTLNY9ouyGcjm3ShYM+ubgZqH6kitudTHIs0xQLxWc0TQBf46
	 TTIxFxMdX2NMPaWZmTM402Bo6slKqNVE5Ay08Tkmmo4OO+6UspZ3fHn7Dyv7lydKyD
	 G2tb5W6Mmrt8B4nxyzxXJ7CUW+4j7VbC1w7qMyhMz32OJa725yOovzEYRIAiCegEf3
	 wEEKYhzZtI+Dg==
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Markus Elfring <elfring@users.sourceforge.net>, 
 Jakob Riepler <jakob+lkml@paranoidlabs.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] leds: Introduce and use
 fwnode_get_child_node_count()
Message-Id: <174427635578.1663653.5515524063188895904.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:12:35 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Mon, 10 Mar 2025 16:54:50 +0200, Andy Shevchenko wrote:
> This series was inspired during review of "Support ROHM BD79124 ADC" [1].
> The three conversion patches are the examples of the new API in use.
> 
> Since the first two examples of LEDS, in case of posotove response it may
> be routed via that tree and immutable branch/tag shared with others, e.g.,
> IIO which Matti's series is targeting and might be dependent on. The USB
> patch can be applied later separately, up to the respective maintainers.
> 
> [...]

Applied, thanks!

[1/4] device property: Split fwnode_get_child_node_count()
      commit: 1490cbb9dbfd0eabfe45f9b674097aea7e6760fc
[2/4] leds: pwm-multicolor: Use fwnode_get_child_node_count()
      commit: 4623cc4e9a5f1b7ad7e6599dfc2a5a4d9d4f5d72
[3/4] leds: ncp5623: Use fwnode_get_child_node_count()
      commit: 53762bb44b0659e79a3e3177372e823ec4afcc8a
[4/4] usb: typec: tcpm: Use fwnode_get_child_node_count()
      commit: 08ca89e98620c08d68b7e7aed6c9294698e214e1

--
Lee Jones [李琼斯]


