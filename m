Return-Path: <linux-acpi+bounces-19717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B1CD074E
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C1A3005FF8
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB032E128;
	Fri, 19 Dec 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhLxLCLE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552B326948;
	Fri, 19 Dec 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157074; cv=none; b=sme49AgK9mMbus4ySaLHhYNU9zWkO+Ht5vm9meFWkHbs5Nc9NjtexDEvtmusjfxJU7bpUgTmo/VOmmp+6wsWw9sGMKHr5Zta/dJMEGOjRsOCg+FrOGMptR8ZeiDWF4NiLudunE8kZ8rXQQE1tFOqHrgtAJ2x+OqZdFg1hpf6HEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157074; c=relaxed/simple;
	bh=uEmF4ZGcdZ0ETfse+LG0MT7WeqOViGYpnFBSh7GX0Co=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=C0AcJiqUHeDT0/k3NC4fvds0MM4SbhCzEueZjPI0pPR3pP0xr0FpQpTH3NQE5quZjj1Rk5s+O9wew0wnYfnwxKMNAl2pu7BcZAO3yVU2sRkFXBJ8+OAQSTsDpB7AXUSOZIKJcDXjke0CoWaeYCeiKdcuIukBNd1Fsn153VOYdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhLxLCLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C15C113D0;
	Fri, 19 Dec 2025 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766157073;
	bh=uEmF4ZGcdZ0ETfse+LG0MT7WeqOViGYpnFBSh7GX0Co=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=fhLxLCLEbm58lSTKVB+n/EEBspiw9HXB1hrccwsl5ZUC+/hOF6CZ9wo2G14U4mgxc
	 9rEtE/NVqim47GGjr7HgzHxrKEtKL9Svu/J7MvK6et4bh7tcsqtF5uT657SEdBHwVn
	 bNhYOSCjvV7n4i8hxIIFpceV2odvlWNJFDjC1AqbldjklxLQHXdnKvWVFSwSfef3fK
	 7txJ7Y/HCcnAWR2wKWNZM4XwlJ6IZlb57rSNjpQwKzgv0rPuWUhfMJqSrjTSOsW2wu
	 fksfDgODs6JK21b3xfmQFA6Yp6T9wEP26/PChuZABsqAhES4zPfykHqrsQgCG04BgI
	 gNhwabZuhbE+A==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Dec 2025 16:11:08 +0100
Message-Id: <DF2AFGGXTTFI.1AXC4N182UUYD@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/1] software node: Also support referencing
 non-constant software nodes
Cc: "Mehdi Djait" <mehdi.djait@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Charles Keepax" <ckeepax@opensource.cirrus.com>,
 <linux-acpi@vger.kernel.org>, "Kenneth Crudup" <kenny@panix.com>,
 <linux-media@vger.kernel.org>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
To: <johannes.goede@oss.qualcomm.com>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
 <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
 <7d04ba37-b505-4207-95c3-b0ffb0736ea4@oss.qualcomm.com>
In-Reply-To: <7d04ba37-b505-4207-95c3-b0ffb0736ea4@oss.qualcomm.com>

On Fri Dec 19, 2025 at 4:05 PM CET, johannes.goede wrote:
> Since this fixes a 6.19 regression: Can someone please submit
> a pull-request with "[GIT FIXES for v6.19]" pull-request to
> Hans + Mauro with this patch?

This code is maintained throught the driver-core tree and fixes for the cur=
rent
release cycle ending up in this tree will be sent to Linus directly for the=
 next
appropriate -rc.

Is there any specific reason for this request?

