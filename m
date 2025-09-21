Return-Path: <linux-acpi+bounces-17164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A3B8E4D3
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41B084E0485
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DB2144C7;
	Sun, 21 Sep 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpey+Y31"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAF26E71C;
	Sun, 21 Sep 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758485509; cv=none; b=tokOeRKiUa3XVC4tNJysAcL6T0/AoPnBobM5r0gYKv480krS/WqPGTGymAx2wSTNMvIN4zKt3dLsnfSskDCULe0xS0dczgpsETNWbz9T20XhEt/CXQtPv6yRrCnQ8MA3BOGHpbTrrrFeRk2sUuwFcZ8YMlAT+ygwij5BrSslVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758485509; c=relaxed/simple;
	bh=viuT5oZ1HQTylzEhrkFgwAIlziupevcUeuKoZ6Hny28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpX0f0TRz5Tw2cOkCQAJVfizIYMaDAQL9O3s1kdUy46a9AuSR/wYgUH8CbIrWkFEnE8eCyqiOFBc+wuFuXZAf2a5S4qERSPYtmYn11hy9Q0uXeJwU/3jeST3m0AbCIQBG2rPm2QdOHg1zkUTUBP6+yPYv+i8b7CjucRC//Pt5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpey+Y31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48246C4CEE7;
	Sun, 21 Sep 2025 20:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758485509;
	bh=viuT5oZ1HQTylzEhrkFgwAIlziupevcUeuKoZ6Hny28=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tpey+Y31HhGmAfYFGIMUimTVoBThgXGJHVzyu/6AMGTCKr9AO/cfVBCc1CDcN9gU/
	 XYarJXKZNrZB7804iMR+YATVxkbraB0XGSUVsbp2Il05RR0P4Md8jMhMov1oACt7aM
	 d07Tut19WCFH/Q5eU0eJRu+pvEvVx2hCTCGP7qduQ8UtcWS+bupFkx6hC5nQmGpQLG
	 IOwX0vRFcZLxlbWjax1qZLXz8NRLgv0OH222F8vofM9EzfaSEstBHiYpoXFRhX4k4f
	 kl+UmzB4srTUquxlIGC+XRGiQfi27gYFNmPju/nrBMiK3u3jSBZ172FXyZgxMM2hI2
	 QyNGnHdGzA5+Q==
Message-ID: <f40ab4a5-1b17-4022-9539-37e470b7a175@kernel.org>
Date: Sun, 21 Sep 2025 22:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20250920201200.20611-1-hansg@kernel.org>
 <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
 <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 21-Sep-25 9:03 PM, Andy Shevchenko wrote:
> On Sun, Sep 21, 2025 at 9:09 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>> On 9/20/2025 3:12 PM, Hans de Goede wrote:
> 
> ...
> 
>> Looks pretty much identical now to what I sent in my v3 and that Andy
>> had requested we change to make it fatal [1].
>>
>> Where is this bad GPIO value coming from?  It's in the GpioInt()
>> declaration?  If so, should the driver actually be supporting this?
> 
> Since it's in acpi_find_gpio() it's about any GPIO resource type.
> Sorry, it seems I missed this fact. I was under the impression that v4
> was done only for the GpioInt() case. With this being said, the
> GpioIo() should not be fatal (it's already proven by cases in the wild
> that sometimes given values there are unsupported by HW), but
> GpioInt() in my opinion needs a justification to become non-fatal.

GpioInt() debounce setting not succeeding already is non fatal in
the acpi_request_own_gpiod() case, which is used for ACPI events
(_AEI resources) and that exact use-case is why it was made non-fatal,
so no this is not only about GpioIo() resources. See commit
cef0d022f553 ("gpiolib: acpi: Make set-debounce-timeout failures non
fatal")

IOW we need set debounce failures to be non-fatal for both the GpioIo
and GpioInt cases and this fix is correct as is.

It is very likely too late to fix this *regression* for 6.17.0, please
queue this up for merging ASAP so that we can get a fix added to 6.17.1

Regards,

Hans



