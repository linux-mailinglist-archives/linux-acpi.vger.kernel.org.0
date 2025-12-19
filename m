Return-Path: <linux-acpi+bounces-19721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A6CD0ADE
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 17:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E04C53038171
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336AD350A0F;
	Fri, 19 Dec 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1wla5W2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA18350A07;
	Fri, 19 Dec 2025 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159256; cv=none; b=VQGZZpH9lyAVUPxEQXcI8NZa1WmSwLuJlv779LmPCURBvOl8fu453nwmIhhTbMXsPXrQeUma+vyqlaqVhy+a4iYy5epkJ+Si3l5yBmCsm93NauXZqr+2+CoUTbPBvgrEdMhRiGBrWMcfpG7ppsrQBcOsirme2zHgEOqpn8IHmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159256; c=relaxed/simple;
	bh=hY7V/ckCmkzyRlGJ9pUx9rPpk1r96bmRzZM0U/1jHQA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MfZk7HHgEjHCqd9Hb0Bi43LWoKUUCsb1/3nMjJZjz6Q3vAUJ3h6c4w3iiYm4dMV2og36YwjFR40dhGAz2BocOZxTt7JrwL4S49MAPOoIc53kpZE18xr5DALfVYzuREWiNojEFMcf+GDKa88L91Tf7P6wq3qlRr00/AGs2/QCauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1wla5W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351AFC4CEF1;
	Fri, 19 Dec 2025 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766159255;
	bh=hY7V/ckCmkzyRlGJ9pUx9rPpk1r96bmRzZM0U/1jHQA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=M1wla5W2pkDGp2D7Io0qs9dmvuf0jzuwf2gB7L5Ys3Ce9sHQQoAQ6dkJ/gk/hFwcq
	 ZQB9XjknAQFudYX/lf3+ogI5/zpxhOc6MfDQ3pf4KmXVr4QIeyhqsM+6c3c0ho5sEY
	 PsahWZgmOR+BmKXdEY0tAjcQHgsQp2Mht/q/5O9gqjCV2NWl/aszHI+7YZwzARXzrb
	 Kj+9qGViWeE40zTH87ZQ0ILP/UlikqXVLKKVdKOPrqiiQstAwPVd4rjfqCnsNPdVBQ
	 w/k+upzdIc+cUVh+AcGSoe9XJ04T+rPG+CK6qFBYPiwEtDcUevfLyQCiDLC7umlsIz
	 RhWqLTd4ydUwg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Dec 2025 16:47:30 +0100
Message-Id: <DF2B7AJU1HWM.27NQV4BLY8QWJ@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
 <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
 <7d04ba37-b505-4207-95c3-b0ffb0736ea4@oss.qualcomm.com>
 <DF2AFGGXTTFI.1AXC4N182UUYD@kernel.org>
 <29830128-8b75-4c57-ac55-0158f3688f12@oss.qualcomm.com>
In-Reply-To: <29830128-8b75-4c57-ac55-0158f3688f12@oss.qualcomm.com>

On Fri Dec 19, 2025 at 4:38 PM CET, johannes.goede wrote:
> No reason other then me not paying attention and since this fixes
> an issue related to IPU6 cameras I typed the above on auto-pilot,
> my bad.
>
> You're completely right this should go upstream through driver core
> and my request makes no sense, sorry.

No worries, could have been there is a specific reason. :)

