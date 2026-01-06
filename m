Return-Path: <linux-acpi+bounces-19977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC4CF8B4D
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 15:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59DB3049181
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B9328B7D;
	Tue,  6 Jan 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avjslJF3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF2328B77;
	Tue,  6 Jan 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708099; cv=none; b=JLK08VV23Lh6aXwGMze57bONaL7LrQ0ECColM6VT64jvKgvrIyHF33CiLVW+aXrmaUzRqPprOy+ZhETD+ZMRoXFDSQOlPA39WTqL+8EMPHMIb5CJjwqGiXpgjAal0lwf942IT6LoktvjM6F943Y2SWSGh2Vet1AR1H7yIAOxe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708099; c=relaxed/simple;
	bh=OvpDkt/YezJTEVegATYIotWGqrpU2c8HXbtaQTVPUHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=S0nZ7uSwDq2qjoUHJ00b4XSvcxEuqQyu8oab25yt/yuAC/9OYIGfNyQyXc7T04ooRiwH1tyNb2Vhg6wNQg0Xb5kdrumem2Aci2sPEuPG6z3v3MJxMKHT8kWLgKUikLhkqcIH1clJPfyiUIpk9/eUzgsTkc8P4FXrmjI8Tr1XlXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avjslJF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469BBC16AAE;
	Tue,  6 Jan 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767708098;
	bh=OvpDkt/YezJTEVegATYIotWGqrpU2c8HXbtaQTVPUHM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=avjslJF3WKk+3C3kuOety/ACLEcYO/tEMb2kifij1NbRIpkU9avNyYug/BAiJufTl
	 1omgEzkMBJCPqYsWVhK+FsaFQu9BNpr936XDyjDqer7zK+doeJ+tTbNsIM79a2oi3j
	 AjuTfwRcAMhi6SDH1rZDygvUlVEhYNKHilGaclo3aO5hwzATW0cFWoK/FBGmnRUk23
	 HqJdNV9WQvZmz11TY/sUr/BFm0WsrLEQcvEOc1F4iU3WIv6mPogVyNeP3w/27bym7l
	 FvgdDkIL9DWH41ez/F0b41i+QCm3tKMb2authoMhNf3KP8itekIIvO9dplc9ZzDkWZ
	 weeRoenx4kfzw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 15:01:34 +0100
Message-Id: <DFHK7ZS7H7LJ.1POCUDPSLC3CP@kernel.org>
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
Cc: "Linux ACPI" <linux-acpi@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Bjorn Helgaas" <helgaas@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Hans de Goede"
 <hansg@kernel.org>, "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>, "Zhang Rui"
 <rui.zhang@intel.com>, "Armin Wolf" <w_armin@gmx.de>, "Ilpo Jarvinen"
 <ilpo.jarvinen@linux.intel.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Randy Dunlap" <rdunlap@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <2396510.ElGaqSPkdT@rafael.j.wysocki>
In-Reply-To: <2396510.ElGaqSPkdT@rafael.j.wysocki>

On Tue Jan 6, 2026 at 1:27 PM CET, Rafael J. Wysocki wrote:
> +This means that it really should never be necessary to bind a driver dir=
ectly to
> +an ACPI device node because there is a "proper" device object representi=
ng the
> +corresponding piece of hardware that can be bound to by a "proper" drive=
r using
> +the given ACPI device node as the device's ACPI companion.  Thus, in pri=
nciple,
> +there is no reason to use ACPI drivers and if they all were replaced wit=
h other
> +driver types (for example, platform drivers), some code could be dropped=
 and
> +some complexity would go away.

I think it would be good to explicitly encourage people to convert existing
drivers (maybe even list some of those) and rephrase the last sentence to l=
ist
what exact infrastructure, complexity, etc. can go away once that happened.

I think this would make it more likely to receive some contributions toward=
s
this goal.

