Return-Path: <linux-acpi+bounces-16147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530AB3A4FD
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EC0164D81
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB35253951;
	Thu, 28 Aug 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GmiJ7yZ/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFE2528FD;
	Thu, 28 Aug 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396571; cv=none; b=ss8zf9v5GBX2d8AGiRlzsz9OLnwe5/thlgeE1IOYlC6h/M2hJEGvLUtHRoGvT/w5qiZhqUeK+fQAP9il8lBsSyalZHY1xjDtl80woItvoRLk8+RAaU6T8Awom8lnXSrT3Pzk7yeYj9Exe3VuV5ZTMmfcbxVQZ4RzPywon8ydwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396571; c=relaxed/simple;
	bh=MH672HrqcC37a6nhqjgiZVkwGH55q4VBJIdG+qVqXAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBR+n3ezx0aOx4irkUc4UkPlFWcwByVHMO74zCq53PbQ4irEZBkpuVRJ2ESgbu8udrzDaTXAY5ytKm16EeNgJW8lSzmsKXZfB8v56LKUMEmMjILFCCjQGsTOMUigx/5fU+sJwIvj2eMcYANX323+XgdGjjgT5Q7MBi4kH8pZbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GmiJ7yZ/; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 3A35BC6835;
	Thu, 28 Aug 2025 18:56:00 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id B416BC6833;
	Thu, 28 Aug 2025 18:55:59 +0300 (EEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3E4771FEE06;
	Thu, 28 Aug 2025 18:55:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756396559;
	bh=MH672HrqcC37a6nhqjgiZVkwGH55q4VBJIdG+qVqXAk=;
	h=Received:From:Subject:To;
	b=GmiJ7yZ/EPvEaDEosfHswcJEZNbLpL7RS0Rq/8bgZBahmmIm84Pl6ATyhqDMrQbJ2
	 sKVXEU9LLcUr/sMRjy6TCqJCzlM3NzvIOsNx6DinYySQAadvGA6eKYpnL/DynOp9P2
	 z7zJRh6kdgPN3+DzeieE8DicX/mxo6L0AvcbPQzhSSczPcu19S13Vspa+YaA6wJBI1
	 sl3KQ/j52I671gxtWrqQHpjii6bBqgBXVu18JcP3PXyghbHjtzJTvD0XUCS2SpeWqD
	 8MTkL0YMqO0BxiJ7Ydip0ekusKmvO3MAKmiKr5GoOEGqTWJlgWY8DyztM83SWDrDuS
	 icYogeqFx0jdQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3367144d35cso9083551fa.0;
        Thu, 28 Aug 2025 08:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW0iof/eplAJHcMAWkA9rHoJK82Tb3ZnlnuLYVbr0gJ51wrGqqXgP2ngVInw/6bxcViq1h5d3RKfRNw@vger.kernel.org,
 AJvYcCWvtQvrseZCzawFOYshr8BtgQrvm3rsJ0gAVPxFoCyz1/ZmnbHj+MKIef+ji7CmnIFABXe+JLBb6Q9NxA==@vger.kernel.org,
 AJvYcCXt11I7KDXyg0OEOewLmqS1ZL9TZ7b0VaZTahb6v53XpSv1d6gAvMkuREv/ohe4EHwGrU6t6rd16bhg6dUX@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7Ue3ndGLVjcdVMrFr9R479GQyN2s8TACrS33E6N3YTpuKQ4n
	8YZmvZFiUDTDDHk39VuN3JU9JXzJQX3dkK99hJZSNzeEPlgZhWyIzKXoXPvsMYIlBElgKPi509B
	i1ShsWpSPWQG4MTDAt/uwltnav7pL5J0=
X-Google-Smtp-Source: 
 AGHT+IF0/8qbZw54//oOyPFdUICwAMgPaNTjgBh4MCunFoN0vFuDyuXh/SoF1n45GMMMmYzMO8x5fVh2TYOn5vOkoew=
X-Received: by 2002:a05:651c:e10:b0:333:fb34:9b52 with SMTP id
 38308e7fff4ca-33650f6837dmr39581461fa.35.1756396558690; Thu, 28 Aug 2025
 08:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827175842.3697418-1-lkml@antheas.dev>
 <20250828051038.GT476609@black.igk.intel.com>
 <429fdac8-44dd-4cb1-83b8-f0941dcdd388@amd.com>
In-Reply-To: <429fdac8-44dd-4cb1-83b8-f0941dcdd388@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 28 Aug 2025 17:55:45 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEX6GqS-_t=mmG9uWT-J=a4R0mqRDTSDkO1n-4xa-15oA@mail.gmail.com>
X-Gm-Features: Ac12FXydQiGHAv3HF4RpFGmITcLlOMC0lFok20q5dfccs1Y1MEF5U0m8e9_hpfM
Message-ID: 
 <CAGwozwEX6GqS-_t=mmG9uWT-J=a4R0mqRDTSDkO1n-4xa-15oA@mail.gmail.com>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175639655943.2767694.2248705706750981310@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 28 Aug 2025 at 17:21, Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> On 8/28/25 12:10 AM, Mika Westerberg wrote:
> > On Wed, Aug 27, 2025 at 07:58:42PM +0200, Antheas Kapenekakis wrote:
> >> Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> >> touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.
> >>
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >
> > Reviewed-by: Mika Westerberg <westeri@kernel.org>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> However as this is the second year in a row with this exact same issue I
> would also ask if you can please contact the manufacturer to fix it in
> the BIOS for future models so we can hopefully stop accumulating quirks.

Thanks for reminding me. I emailed OneXPlayer to remind them about the
thermal zone issue and will try to bring it up to GPD next time I am
in contact with them. However, it has been close to a year since I had
contact with them. But they say we support the GPD Win 5 (we do not
and it is not released) so it will happen eventually.

I have had this quirk now for around half a year and I am slowly going
through my backlog.

Antheas


