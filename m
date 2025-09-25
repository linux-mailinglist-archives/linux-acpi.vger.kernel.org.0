Return-Path: <linux-acpi+bounces-17319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDDBA123E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 21:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559781B26777
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0FC31B829;
	Thu, 25 Sep 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqpV0y+P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A51DA23;
	Thu, 25 Sep 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758827798; cv=none; b=b59oLQlCiFVITb5nUPZGU1yPAYmfuwLvGAq1sgs1uEl4nk1kfdg94FcYz+3+4Aa25tvSfbY1yyA1Tp5+CdyPZMoRHZwJtrlzni1OVCraISMvJERd3Cs/jq85z5zuufusR4zYu1XbiEdQ1kgdyPm18tozwnhqGNimkf4tUccuwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758827798; c=relaxed/simple;
	bh=r+K4st9QKZHdJzM3ip/Ne+u4Np4HMFMIRhcr81fP8so=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jfdfTS8KX0o1+VJq1DvEjPSKCBRgIFlvIP1/4HLNgdpz4b99A4s3ze4U+5oGDG+Bn0G9dnVNHC5Q26qnw/6m4EsejziDTIFndyk3hah7BNCtUy6LReaKEKfxHrfQLMuwS+oLaewBdxThmj2BI8D1Rpqjq1TRTiZcqNOIpgQ4OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqpV0y+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A58C4CEF0;
	Thu, 25 Sep 2025 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758827798;
	bh=r+K4st9QKZHdJzM3ip/Ne+u4Np4HMFMIRhcr81fP8so=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nqpV0y+PTJTfgqdWWcsTAfEiafK7DaHqrLI+QZ3oGfNOW4pCVcPjUoKEFj9SO1Cag
	 N9TT2qPZfY00NsO+HY0v4Hr/PjHiy8XvWqo2+22lQEqS/XWEUbqCN+l4NIXST0+EdW
	 Cu3T0/ZfwyVaiWdLMlA2nKbjm/T04l20eqCKsc+/51/+R0a+yBarX9HoMw6VKhqe/H
	 yi5dEHLbP9TSB1QvIXEVpOeRAmCwjHd4iTGBDSybSMqOuOvevcmQyOeYm1N7E7CD19
	 VzORlV9PXCAlhQjFl4GHpE/hayaU2Q31x0Aj1PVQWyzHKjxO80gJ5W9VOs0FlOdgBS
	 /FpFui7izU9Ig==
Date: Thu, 25 Sep 2025 13:16:30 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
cc: Paul Walmsley <pjw@kernel.org>, 
    Michael Turquette <mturquette@baylibre.com>, 
    Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, 
    devicetree@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
    Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
    Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, 
    Samuel Holland <samuel.holland@sifive.com>, linux-acpi@vger.kernel.org, 
    Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, 
    Len Brown <lenb@kernel.org>, linux-clk@vger.kernel.org, 
    Rahul Pathak <rpathak@ventanamicro.com>
Subject: Re: [PATCH v10 07/24] mailbox: Add RISC-V SBI message proxy (MPXY)
 based mailbox driver
In-Reply-To: <CAK9=C2Vr4rgj8wfT+Ogow1H-7Lu=6XdWA2Qe++6523P76pMZzQ@mail.gmail.com>
Message-ID: <703b00fa-d02c-1eaf-e4de-ea66da5b8002@kernel.org>
References: <20250818040920.272664-1-apatel@ventanamicro.com> <20250818040920.272664-8-apatel@ventanamicro.com> <405a78ce-de03-382b-cab9-bb086e28505b@kernel.org> <CAK9=C2Vr4rgj8wfT+Ogow1H-7Lu=6XdWA2Qe++6523P76pMZzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Sep 2025, Anup Patel wrote:

> The usage of channel_ids array is limited only to this function
> (mpxy_mbox_populate_channels()) hence we are using scoped
> kcalloc() so that channel_ids will be automatically freed when
> mpxy_mbox_populate_channels() returns.
> (Refer, "__free(kfree)" attribute in the channel_idsm declaration)

Thanks, I missed that part.  Looks fine the way you posted it.


- Paul

