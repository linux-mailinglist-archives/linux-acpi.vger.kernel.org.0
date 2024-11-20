Return-Path: <linux-acpi+bounces-9704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB69D4216
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BF5282647
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D015746E;
	Wed, 20 Nov 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0O67tTH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38713B7A3;
	Wed, 20 Nov 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127759; cv=none; b=MIJk4A9rPl52klYN/Gv2LvM21si+brgUhwWmBdcSgnur7yyofvqkl2bJnUaE6J1CPxqznJExLKUvT2I/7hJ5PMz8iveHQFJt9pGf39lCu51Qr4/pzPuBQp9SLZAEdMMP411iHpAXzE72kLe+a82Ivo2o/+dWTBDA1urgTBIY/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127759; c=relaxed/simple;
	bh=LuBOq8XhhEpE1DE3ZQIeaXLfnihjs9R6JpzUgSQFIyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkfgaHmqJxINhzn1LMbd35CwkK/XTRgFQvyGdzZLGT1++UOf0fo+0i2Hyq+Bn8n0wySv0JwCja/bUAUzwd0x97t93hlIda2EoljAbPaym4T9bWph1ni8aVCzdBE9FbixqVeFeRFCk3qdeACvScwEFPMOX+JxFjwVI3uIvgU8dR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0O67tTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95320C4CED0;
	Wed, 20 Nov 2024 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127759;
	bh=LuBOq8XhhEpE1DE3ZQIeaXLfnihjs9R6JpzUgSQFIyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F0O67tTHyxwJ4ckM4th9rE0v08X69TUHcFdEtvr2fnVfoP3rK7ItBuN+P4208VbtI
	 g0QU0QFBq54YU3Wt0jR0fpgJSQ0YF2b9hADG7l8B73wdXXQXd7FmnOKgbMu/BewQFf
	 eJDSP5AVgiq3yx5p2xfWn6FvW9bBol9RHDGPQsCYAOdgChPWTZotJtIqyqnMvXqm1m
	 AF8hnMKtWs/6NURTLqnTNRSRxe6hojneSw7qYLaMr3zKYSUlHFg0hxAmSZP5eb0Zkn
	 wojzPxInuj6rSBCX+DGru0mhvzUYGBqgxMIh3lK7cct4QveiRzIR+rDz4/oM4O7Acq
	 rV3mZ8b5zkeeg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e786167712so81991b6e.3;
        Wed, 20 Nov 2024 10:35:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5/peCntYrkTZadF6HtKMVV+MdsFuSL84ygTNOh9EzCxvynOcTBit+IOxOqpCYaCvf5H6Jrk7TvY6C@vger.kernel.org, AJvYcCWXBhNAiyDGMCD6a+Q0gFYg35PtXaKg/mA+224gfLdIPn7ShWQwXAaPxSBJi2Q4F3Ja9VikCvEmgL/M5bD+@vger.kernel.org, AJvYcCXWwgVLaZGFvfhBs64dvsS0Y6DgVFMMjmvXa2jiOlI0DTrcPCyKy3KQLOk5HI+Ad3cmRhWcJ/Ndo4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5m1dy6RxTvTPgyKGBkP5aJ/0kTibJQQ/5cHFJY7NKcMZoL6C1
	nVdxA2l0jhsyZ9cIk2y/21Ho2fdlZBeEXIP1EYUO/mkI3sVapwNq8Z24GcL4EcsApSLiamPEbIw
	yy8ycfxfUvm4f7bPYpPrmBu3/98o=
X-Google-Smtp-Source: AGHT+IELYcIBEni61ZkBV0bbNZpmm8wQPtK7IhXxAEEWPGkpSQ0+Kt1ZcuPVe0oBXGBavp2XBGQcRfxF0atpovJAJVg=
X-Received: by 2002:a05:6808:3b8:b0:3e7:eda5:6b06 with SMTP id
 5614622812f47-3e7eda581dfmr2636497b6e.35.1732127758925; Wed, 20 Nov 2024
 10:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 20 Nov 2024 13:35:48 -0500
X-Gmail-Original-Message-ID: <CAJvTdKni91yBbCnUvzq1cPdYMNzbckFN4mJjn3ZEthhi=5PzhA@mail.gmail.com>
Message-ID: <CAJvTdKni91yBbCnUvzq1cPdYMNzbckFN4mJjn3ZEthhi=5PzhA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: anna-maria@linutronix.de, tglx@linutronix.de, peterz@infradead.org, 
	frederic@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:03=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:

> if (ms >=3D 12 * MSEC_PER_SEC / HZ) {
>         msleep(ms);
> } else {
>        u64 us =3D ms * USEC_PER_MSEC;
>
>       usleep_range(us, us / 8);
> }

The purpose of delaying a timer via timer slack is to afford the
opportunity to coalesce timers, when the precision wasn't actually
necessary.

I agree that  precision is not necessary here -- we are talking about
acpi_os_sleep(), which has a granularity of 1ms.

So the question becomes how much coalescing do we get for how much delay?

In the suspend/resume flows that sparked this discussion, the answer
is zero --- and so for that case, zero timer slack is justified.

I acknowledge that you refuse to apply my patch.

However, if you are going to add slack, I would like it to be clear
why users tasks, which may invoke HR timers at a dizzying rate, are
subject to a flat 50us timerslack_ns, while the entire ACPI
sub-system, which invokes a single timer, would see a 650usec delay
added for 5,000 usec sleep.
--=20
Len Brown, Intel

