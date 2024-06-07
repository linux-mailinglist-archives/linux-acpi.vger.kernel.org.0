Return-Path: <linux-acpi+bounces-6268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34B99009A9
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F371C22E57
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26F1993AE;
	Fri,  7 Jun 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojhec4HR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2A196C6C;
	Fri,  7 Jun 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775724; cv=none; b=uxqdkv9rXnAY4EahKx5NBbKSu+1/IL6ZsBLumXio8IYCftSKfoRNDIr9nmq0EX3VDldOdnPQMYfPfnfd60iIB+Vjdmi7vxzlXKX6ZYuzCzVZeLFI3shTxpftOdO2lPERCu/IyRxmQU+PLC9P74m0IAhmk0QeQnOb7iMxLlWji2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775724; c=relaxed/simple;
	bh=+5SSt91MLmEkhxneIY0OpWc81jVc8hlzIQH9a+p7YNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEFUqUmO6jBNGk+4e/CVseSKfiSib5ZRTmO/buS4yvqwQ55e0kt0SYRWvyvouSPe3nDHNxpFWHOQvmHRHLhOvsg6d6OfH47TgDRgtuSa6NxkdzPI681fw8shh+r/mJUAC5UWQeFSguu5o17x9HmiFAA3Wga7/RAdvlhdVpFrvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojhec4HR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BFBC2BBFC;
	Fri,  7 Jun 2024 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775723;
	bh=+5SSt91MLmEkhxneIY0OpWc81jVc8hlzIQH9a+p7YNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ojhec4HR3E1Gv95pi9zdji5jlhCPiX6Bi5yi4iF73//EsgP/6k2uLWQxOu1XqPpTv
	 z8EbVsPDs76Qw6SiPUuusWCWFrV/QumBZ3+L6HEVH73nZPegZY92yrcWxa62lEIOWu
	 qD4BUThvqx7jgpTyEj1xfNckx2IHE226UMhzuNS+O75ciX7cy2jh+ACoY3OX+d9jt5
	 PHxhMxSr5CXd2Q9Sv3a9dwaEbkhQdPvR4qex7V/WC0+7kFjsZ779DnYGxOi3mV3iGm
	 FsX6GT1xdj86Y+j8v3LAbatiZNRZrFOcXAdlJemN3IkeAKMMNjP8O74QhWh/uzuryi
	 gl5RmwL2RdzNw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b97f09cde3so294027eaf.0;
        Fri, 07 Jun 2024 08:55:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaYgiCd+05sd4BImDNF3mmh7F4q+InXDsWZs9+YPUxhBPmgzowyejJ9xX2SmsUZ4nT+pIf+xeMJ7j/93T7orthatEHQeG6l3vKmrgq
X-Gm-Message-State: AOJu0YzR5JRVLljDvFYTCsGRNOf++mZeyFiBpj8BGbM4E8m3qOjBcwOv
	mEdP9mq9jx9luOxyiL1ThYz4JbZOQL6xGArJweSdc5Kh9DPiZ0HnsmGpythWUiAT6RdrnmHRdNr
	HeLHKoAyvVRStbH6hxlIpjoqySfc=
X-Google-Smtp-Source: AGHT+IGJ/ANh0Gv9TL8hyLAz5Z2PqeGWqW6wCg5RWaW2p+a8mVte0ggd4wehdUnGcgKJd+8PGoPXy3TC6DIg+Ed2TQc=
X-Received: by 2002:a05:6871:3a13:b0:24f:cabc:4fa3 with SMTP id
 586e51a60fabf-25463e7c2cdmr2987780fac.0.1717775723066; Fri, 07 Jun 2024
 08:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hV6ruOVOO7GFP42vFYj70G=q=bhEOOG4vawyih5hiKFg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hV6ruOVOO7GFP42vFYj70G=q=bhEOOG4vawyih5hiKFg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 17:55:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhL_TT15zRUobAM6ayXbQWv=bTDdSu1sDdZd4q0_pjbg@mail.gmail.com>
Message-ID: <CAJZ5v0jhL_TT15zRUobAM6ayXbQWv=bTDdSu1sDdZd4q0_pjbg@mail.gmail.com>
Subject: Re: [CfP] LPC 2024: Power Management and Thermal Control Micro-Conference
To: Linux PM <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi Everyone,
>
> A Power Management and Thermal Control session will be held during the
> LPC this year, as it has been the case for a few years now, and it is
> now open for topic submissions.
>
> The Power Management and Thermal Control microconference is about all
> things related to saving energy and managing heat. Among other things,
> we care about thermal control infrastructure, CPU and device
> power-management mechanisms, energy models, and power capping. In
> particular, we are interested in improving and extending thermal
> control support in the Linux kernel and utilizing energy-saving
> features of modern hardware.
>
> The general goal is to facilitate cross-framework and cross-platform
> discussions that can help improve energy-awareness and thermal control
> in Linux.
>
> If you have a topic to discuss in this session (please note that the
> topics should not be about work that has already been completed, as it
> is the case for the LPC in general), please go to
>
> https://lpc.events/login/?next=3D/event/18/abstracts/%23submit-abstract
>
> and select "Power Management and Thermal Control MC" in the Track field.

The deadline for submitting topics to this track is Sunday, July 7,
2024 (EOD in all time zones).

