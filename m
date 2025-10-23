Return-Path: <linux-acpi+bounces-18136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A2DC005EC
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2144219C7A74
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BF3093B8;
	Thu, 23 Oct 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRqxNR6Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7A30ACF4
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213594; cv=none; b=EyNLHMviWAQyJ38nEEXIybz/rJepFUI9f1RsNJSnZO0OrZ3LpuxWQvGcyUoCH8eFzwGydLoY2zOEUitEpPzIgasXAB6x6xN4MwnMDhDeIxVwYTY1B6biA6MHapSZIb3CrzwrVE8b/XfiLQ0FRASHvylcp8O7eURtmY744J6Owm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213594; c=relaxed/simple;
	bh=8wG6bQmFBVoMS1wCbmmfcfGyx7Yao3Jr++/jNiuVkp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcdLLpQLzBAGfeX8HN6fEZs8AU0cPG1g80R7xE0RnfTsXx5tZnMDmbvT0yXPY7f5MXeVqcBBdwtQRWKEZZtYqSCg8M9j+vlfjuktX/nfAGNJ+KGu0pVXapc0gSr43M3v4vhXoMCxvdAtgRHQWes7UQ1Gfj0jaxbGp/DaIDGWSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRqxNR6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0F7C4CEF7
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761213593;
	bh=8wG6bQmFBVoMS1wCbmmfcfGyx7Yao3Jr++/jNiuVkp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YRqxNR6Ql+pnysU2X06F0a0XgmsOJSs7sLT0bNmnUv6YFM8c1YV1iVBchpNTRAcpA
	 Ddz66uE1ctwCrjoNCawAqqMnt0ZmA+ksq9WVXqdPaH1RiBpkLkJfjNsb+SdyEsXDlo
	 D3S9a+qv3GYodXiCe6T4NKRyTrqB27yfMTkTXz8L11nvBfJfSRtQEg5FQ5Uyn/ubwf
	 ORxzvXIofLIHnVcJYM9wX08ZDbGqjThGQPc/7QPmdXpC01R1iTqwyYLzu4pC48jE3h
	 u2nfXmJ3ixWU0YBj/c/bo3T27nsW46i0J7ce9iWN/nUuwp/9J9fgVi/5hy9fwQD5jR
	 07LCWaKkIM1PA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6536caa5fddso269333eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 02:59:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSg3M4HKFEt1i3nzBw046XtDd0sN8SAe/rVVO9YUmOOhnSPyGRM29FGG7DlyrxuDcDfnvCvdXA1HS+@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqmSu6VZcpnNdp2CWcrvlt3vczr6pJ4WgGZU6jRpGcw/U/ml0
	IRkuzx2bqVHXmZ5/mshWsVl/FMyuGMhc80H/GFoauy34T2HzjoBB6mHu8cbokdAZ0SnGjZRRMxI
	d68xNzvUP+UkUXHu4goFhCRlqaigj6js=
X-Google-Smtp-Source: AGHT+IGNOHxiftdsqRUUBLNuovRr63nj4b2FWcvZ5Wf6kKfZFM8RS7QpLjefBQ2F0i9qGtq1UixrmzYeD86UGSu2Sd8=
X-Received: by 2002:a05:6808:1389:b0:43f:cbed:1ed2 with SMTP id
 5614622812f47-443a2ef4293mr10810299b6e.17.1761213593105; Thu, 23 Oct 2025
 02:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007234149.2769-1-W_Armin@gmx.de> <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
In-Reply-To: <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 11:59:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
X-Gm-Features: AS18NWAyc-O_hzZt7yOab3Amu3oLXozn9Zu1QcvAnGZ6JDNmfS0ajETT8n8etMw
Message-ID: <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] ACPI fan _DSM support
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:41=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 08.10.25 um 01:41 schrieb Armin Wolf:
>
> > Microsoft has designed a _DSM interface for the ACPI fan device [1]
> > that allows the OS to set fan speed trip points. The ACPI firmware
> > will notify the ACPI fan device when said trip points are triggered.
> >
> > Unfortunately some device manufacturers (like HP) blindly assume that
> > the OS will use this _DSM interface and thus only update the fan speed
> > value returned by the _FST control method when sending a notification
> > to the ACPI fan device. This results in stale fan speed values being
> > reported by the ACPI fan driver [2].
> >
> > The first patch performs a simple cleanup in order to reduce the usage
> > of the acpi_device struct. The second patch fixes an issue with some
> > 64-bit ACPI implementations where an invalid value was reported
> > instead of the standard ACPI placeholder value (0xFFFFFFFF). The third
> > patch fixes an unrelated issue inside the hwmon support code while the
> > next two patches add support for the ACPI fan notifications as
> > specified in ACPI 11.2.3. The last patch finally adds support for the
> > Microsoft _DSM interface.
> >
> > All patches where tested with a custom SSDT [3] and the acpi_call [4]
> > kernel module and appear to work just fine.
>
> Any thought on this?

Not yet, but I'm going to get to it today.

> I tested it with a custom SSDT, so i can prove that those patches work.

OK

