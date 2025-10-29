Return-Path: <linux-acpi+bounces-18340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C63C1AAF3
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620B1466FA0
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F433F39E;
	Wed, 29 Oct 2025 13:16:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1E33F361
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743785; cv=none; b=r6Yq/UYNIX2h5738Yc5RaRP5QJtUfBAOWrOJMN5l05bHpSL2I51WtD75ZLPtjKXidHFFoWy7A9T+n9MiDC7rtDo8ZGX7QJqqILF0TZnkfHoBwCK4IDEB+i2tOwuqfFmymtbslOZhT5zVRxMR4pKycKPF4dCeg+HX6Fo7m0Hmabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743785; c=relaxed/simple;
	bh=++TOku7q7JkaasZMWl28vaI/G0/7hPUQddtaccZHTYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRAa74ipdzhzGOvcaD0fizCwW5v3nTEaP/RaT3BjOqJNfVsqV/FU/AYaPXIUeqHMyY5cCnLcIqws3zXuRvsIzOLlcT96z1oVf7tbYzRRGkbydwgreEBw2Wn0PJSj7xLepoutPoaXyOLpLM9ctat2jJ9v9jANHNBSkIQcnKmSzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE623-0001hG-KG; Wed, 29 Oct 2025 14:16:07 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE623-0062zu-0r;
	Wed, 29 Oct 2025 14:16:07 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE623-000000008ef-0mJV;
	Wed, 29 Oct 2025 14:16:07 +0100
Message-ID: <0b8ec641c76b39f6a96863c16e5f758451641849.camel@pengutronix.de>
Subject: Re: [PATCH v3 00/10] reset: rework reset-gpios handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 29 Oct 2025 14:16:07 +0100
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

On Mi, 2025-10-29 at 13:28 +0100, Bartosz Golaszewski wrote:
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
>=20
> In this case using fwnode lookup makes more sense. However, since the
> reset provider is created dynamically, it doesn't have a corresponding
> firmware node (in this case: an OF-node). That leaves us with software
> nodes which currently cannot reference other implementations of the
> fwnode API, only other struct software_node objects. This is a needless
> limitation as it's imaginable that a dynamic auxiliary device (with a
> software node attached) would want to reference a real device with an OF
> node.
>=20
> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.
>=20
> Another user of the software node changes in the future could become the
> shared GPIO modules that's in the works in parallel[1].
>=20
> Merging strategy: the series is logically split into three parts: driver
> core, GPIO and reset respectively. However there are build-time
> dependencies between all three parts so I suggest the reset tree as the
> right one to take it upstream with an immutable branch provided to
> driver core and GPIO.

Should that branch include the reset changes, or only up to patch 6?

regards
Philipp

