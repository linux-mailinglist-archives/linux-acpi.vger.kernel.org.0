Return-Path: <linux-acpi+bounces-15833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F96B2C300
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FDD56456F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D02338F5B;
	Tue, 19 Aug 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEBOwid6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224192586FE
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605802; cv=none; b=g9VvU/cU+w3zcp6MuEV0cVhSaM0QGj0toN8tG+rfiUigjJOWK5RIJTnJpekn2tSZUNS3a4T9c6v+XMHtqerS7AnRcjILca12zDhU/0x7s8QO2mSlFo/MXjtgLgD6GO8Pyr79pF6hmKrNcI2QVZ1ZeTp9rp5FYBJuY3BTsfiPjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605802; c=relaxed/simple;
	bh=AZ7o1pFXuy79shNbYRISLiW+dg67/yXKYIew3DntoxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NewAcsPi31qz7QzneUVcWRWQB2CF/9d9rNOtREIhRLYwT2FzNb+o8bSu1X1YSWhZwF9xkkQK2VnPplAv6LZiyWYVG/DsBnNaCXZWATP34IodwZye2PCdhjSLAjRViKOVF2quUIt4ErNatB/tbV7h52fVTfuSHCKK6BfpoQJhS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEBOwid6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce509f80dso5149568e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755605799; x=1756210599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mch0lPw3yHrhu7n4ZdwY7/Px5OZohbQnsGNaNJBBPW4=;
        b=qEBOwid60nPDCNFZzmN7fKGDe0pNupuDkmcYgvLrgoWJnrqD6eg+CHg4GVXxdB6gfM
         K/09Kjpb9TKUg7M4DFecmpcA3ywNZm4XCuW3u66nzi7G6QuDT36eHUBDOaNj98BsMz9w
         /W/cWZ2t0OBlTjtjLoKqMJvUWPTUTH3shvpd4jGe7tcpVmti7i7vKbp1PK3uO9WASHgL
         RSGAAE8njAEc2jXwj/0TxTO5q4Dt2qKCZdKzzDyr1JRLiT3Z4NoTFNUHLu328Ii5c7/i
         gL8rnOrbWQil/7lUB0uhuGMUgOHIc319Dhc6Fq51nDQnyS1c2TMNKrSD4vU2MR3PJ46m
         8j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605799; x=1756210599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mch0lPw3yHrhu7n4ZdwY7/Px5OZohbQnsGNaNJBBPW4=;
        b=kaduL1Lr9D9y7kzupgk47liqxGGGzOxI6ioVVZiGM07Int/skGnnRw3fgKk+m8xTYF
         h9d04n+DN1TYMCMJYbx284biceVMk9GQwaZ+foJaNZgW/owvRHEkXzt/uCPz/JNoND9w
         l9cY6UdKN2RiQEkClHfZGRepa+xybHrTlPl+JvesZTabjBSwqWSDg/5rz4B0nxltmxa5
         PVqdXjIf2WYnKhtycwQYfAqEZfVXshsA2T+xcxjX4nThTBa7IcVulaVaF+69BQ83eItU
         s7rKLz5IaYre8s4rURWB98HUklrX1D2HA3qHblIBzArEBjVb9u46k7R/QonNqtPYhEoa
         d02g==
X-Forwarded-Encrypted: i=1; AJvYcCXmntRll9NgGtQglMOI1ti0DoJi9HT8PfbQdgFsCH1/pFKkoZJsHfDmqmPqmBQkM3Ctbr6ISq9BMe3X@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bQ4c0u7Cf1vNEOc+0uyxCZz4azmnWy88+dnqmQr0cJ/GrzZl
	0NBgBCQlEGerXpca3IBE0KKOpRg/8+jpBH3W6to6cuHPfm1lBWjna+y7SU2gYCBxZ/5s+4fWUBf
	e5iA0KhJYnAWh16jNFAgoycuUqWiRsvToZrZcWcWZMQ==
X-Gm-Gg: ASbGnct0tMcEPfpqGbg/NdpY7K7T3TVviIrjfNOtMyrh6+TnplfQUL7d19A0wheOIX3
	VeoWpDL1U0SgbQ8G8NvFsRzgGulq97w/T1WReWAZU4SwW/9nUaF75Tbn3ofKNhJ1eM+QbseqsKl
	XynHW4tddA+1snhtVoqR8lnQEbYkv7SiygXOzft4i6MsBrI7B0Zx5t/Nz7TiQwgWKia2mGxqDz+
	WQsnPIkicbb
X-Google-Smtp-Source: AGHT+IHlQkTdSypEYCk5jHMFsG5gMHOSPP8bqRunKFnkCNT6Avg3FbiQixBffVyonHcFrK3FhreXz91XErM75OILoyc=
X-Received: by 2002:a05:6512:6318:b0:55b:81c4:5f22 with SMTP id
 2adb3069b0e04-55e00852edamr615410e87.47.1755605799241; Tue, 19 Aug 2025
 05:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814183430.3887973-1-superm1@kernel.org>
In-Reply-To: <20250814183430.3887973-1-superm1@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 14:16:28 +0200
X-Gm-Features: Ac12FXwnxcG8BcLpMnqVg15St2VyjeE-JDolWogpEgsUqurEowSU0zWbTKxm_ls
Message-ID: <CACRpkdba9c9FdJoAufRVEKxXRP-kk5QZusiqxmWoY6D-gK9tYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: acpi: Add quirk for ASUS ProArt PX13
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Mika Westerberg <westeri@kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Amit Chaudhari <amitchaudhari@mac.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:34=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:

> The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
> a few moments after entering hardware sleep.  This can be avoided
> by preventing the touchpad from being a wake source.
>
> Add to the wakeup ignore list.
>
> Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
> Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Bartosz is on vacation and this patch series is half-pinctrl so I applied t=
his
and patch 2/2 for pin control fixes.

Yours,
Linus Walleij

