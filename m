Return-Path: <linux-acpi+bounces-19416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87BC9F7CD
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0A1F300ACCC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB242305970;
	Wed,  3 Dec 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj9NOlnS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC4303A0A;
	Wed,  3 Dec 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775692; cv=none; b=tCusRKLh/AUF1Khr8JxppZIDCd3EB9tEeS1jvBOpW5gHBTLVdYif8kImyO3b3q9Tkwoyvykpe+7Nyr/AU6I7op/bEHsg3sJPZVp9D/gZdF0K1Bs1NFj2PkpfipCHAXv5D7/C71XkyeFN8ps25/7zEJSsF1Hp7mnL1uGmvjCKZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775692; c=relaxed/simple;
	bh=xQuNfhFozyCxltf4pAZiGpE7Bu40lWow9kWOT6u0ofs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiDVt+GCuUIeZGlBo5Y6LxFPBsOXS1ZXy5Mt5vEOjd7QYBntBFxuZ02oh3qf7PDooRv4MmraTzb/XnsKdbxV+5VVObHIrC/U+AjoVGy6rU4EqLxVzMi1RL+bWhRcB+eR6L8ztpXtdSy9XFKXQNBz2U9cjvXKTuB1OR6xFSkt1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj9NOlnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE72C116B1;
	Wed,  3 Dec 2025 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764775692;
	bh=xQuNfhFozyCxltf4pAZiGpE7Bu40lWow9kWOT6u0ofs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kj9NOlnSS8MDCx+31eN8vGfIAEwERD7Z0kR2UoShvRWSwBAuR2RkYVjYRE5xvJpwz
	 7L4FnxD7bK7c+C2tsS4EycWf509/j8/Knv+752YT5lH4zNZH3NOqkFt5VbHwnh6rnr
	 hOKewjcyPmKrrAOEn3iZgZ6alRumESiKmq5b6pn1gOxOXYWLheQKRCTRv9wuC9Pq50
	 u6YbSErKhJ0220/sqsP5gN0LxGe8tFXmCNI4HVgTZZyyXgm4mESn8HJ8SCIxs58k17
	 2JiwGTAyGx0s784rnjREsjJDqCCVp0FcuhkEVjvtgfRdkB4tLFgLYv8NKyoJ3FWuvU
	 heFfbwlsd1fFA==
Date: Wed, 3 Dec 2025 09:28:10 -0600
From: Rob Herring <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] Thermal control updates for v6.19-rc1
Message-ID: <20251203152810.GA3693099-robh@kernel.org>
References: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>

On Fri, Nov 28, 2025 at 09:35:41PM +0100, Rafael J. Wysocki wrote:
> Hi Linus,
> 
> I am sending this in advance because I am not expecting to make any changes
> to it before next week.
> 
> Please pull from the tag
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  thermal-6.19-rc1
> 
> with top-most commit 63d26c3811421ceeb5b82a85489b88bf545e33c7
> 
>  Merge tag 'thermal-v6.19-rc1' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
> 
> on top of commit 6146a0f1dfae5d37442a9ddcba012add260bceb0
> 
>  Linux 6.18-rc4
> 
> to receive thermal control updates for 6.19-rc1.
> 
> These add Nova Lake processor support to the Intel thermal drivers
> and DPTF code, update thermal control documentation, simplify the ACPI
> DPTF code related to thermal control, add QCS8300 compatible to the
> tsens thermal DT bindings, add DT bindings for NXP i.MX91 thermal
> module and add support for it to the imx91 thermal driver, update
> a few other thermal drivers and fix a format string issue in a thermal
> utility:
> 
>  - Add Nova Lake processor thermal device to the int340x
>    processor_thermal driver, add DLVR support for Nova Lake to it,
>    add Nova Lake support to the ACPI DPTF code, document thermal
>    throttling on Intel platforms, and update workload type hint
>    interface documentation (Srinivas Pandruvada)
> 
>  - Remove int340x thermal scan handler from the ACPI DPTF code
>    because it turned out to be unnecessary (Slawomir Rosek)
> 
>  - Clean up the Intel int340x thermal driver (Kaushlendra Kumar)
> 
>  - Document the RZ/V2H TSU DT bindings (Ovidiu Panait)
> 
>  - Document the Kaanapali Temperature Sensor (Manaf Meethalavalappu
>    Pallikunhi)
> 
>  - Document R-Car Gen4 and RZ/G2 support in driver comment (Marek Vasut)
> 
>  - Convert to DEFINE_SIMPLE_DEV_PM_OPS() in R-Car [Gen3] (Geert
>    Uytterhoeven)
> 
>  - Fix format string bug in thermal-engine (Malaya Kumar Rout)
> 
>  - Make ipq5018 tsens standalone compatible (George Moussalem)
> 
>  - Add the QCS8300 compatible for QCom Tsens (Gaurav Kohli)
> 
>  - Add support for the NXP i.MX91 thermal module, including the DT
>    bindings (Pengfei Li)
> 
> Thanks!
> 
> 
> ---------------
> 
> Gaurav Kohli (1):
>       dt-bindings: thermal: tsens: Add QCS8300 compatible

This patch was corrupted when applied and all the automated DT testing 
broke due to that. It didn't help that it was only applied just before 
US holidays and I didn't notice til Monday.

I've sent a fix for Linus to apply[1].

Rob

[1] https://lore.kernel.org/all/20251203152437.3751325-1-robh@kernel.org/

