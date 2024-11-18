Return-Path: <linux-acpi+bounces-9631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7699D0F9A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C048BB2D195
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282E196C67;
	Mon, 18 Nov 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MS4XRzB0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A56194A5A;
	Mon, 18 Nov 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927824; cv=none; b=pPHDYoH5SXhraoPTX12dKUTDVTpDniOk8HNsWgXKZz/q9tsIsVJNOj6pKi8epfTKsXJIi7m6yxl7VKPisvB2nQ9+sx4sSH7sdk2gKuYl66TGMUaDbZ+aKu5MSWHT32sEm7daIa1lspoFaKrtUsIPM5H/oafPVcDSJUiKSaXiXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927824; c=relaxed/simple;
	bh=AOEBOSkZRti3bK8rQa/5CfKZopdyDgU2tBjztmiX0ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXO8K49Zzpd4SeTrcp6WP+9GoghLgBCPgFKNq/qn1bfPGb/J5id2uYXo1kjBuykMe9+RDpdbvpeDWZ7O9eZhcyPnJmyZRvX8k8oK1QnB/uqz7bJqhlcO6s7XhDDvIm5czFbfDGCNlvBt/+tYYVOBTyGuutO1apcn5utO7+KIXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MS4XRzB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32A3C4CED9;
	Mon, 18 Nov 2024 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731927823;
	bh=AOEBOSkZRti3bK8rQa/5CfKZopdyDgU2tBjztmiX0ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MS4XRzB0auiYkwS4Ba17T2nI3g6H62F8KCrCwnJJxMVfDGVlFad/i5aBx3Jdqtjgh
	 d5Jt537gxAoGGZ35oymAMpazp/hYfrEWhm5E6jVmz9dzLsMk7ZYOVHCVgRWlszeipt
	 trDteD+2RNEsrTy5Wu4tSjnKKqQU21UFKMF5etunuwlGxZU1dAe1JVrMIwUh/pyId7
	 XSzJWfaEnXWoh2FEEC/N0WYKZzPfa4pDz+Lda7XZyLksIzj+8f3DF/KbMFd/lmg4wd
	 y9PnTyp4oa5yLsUME8w4WyxNQpdEK7s7WE2c/Ha9Yo+P5VEv7p8iRvOICYyz4J96Ea
	 ZcQjMmD1oUVfw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2958ddf99a7so3687930fac.2;
        Mon, 18 Nov 2024 03:03:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMuCUgW4x3nnZXJLrhmnL+G7WbRff1UFyf32LgpfAV5dRAxeNYwMEpixQHl7rs4qAiLdS8ZnTuGu8=@vger.kernel.org, AJvYcCVeK4ZAg4skU2DpkzInGLFHAAULJjE9ruDVO9lguQXlSJ+a+yNZWUr4phSBoXR66iIvr/1+hDsAdU8FIGBT@vger.kernel.org, AJvYcCWAKQrnnIzTA/pyugbNyKEV1/Jw14k93KIp/BAkxh/gL3cT8Q6z4O6ut9WPedZ0PEbMuECOqSFgWMHE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53hBEMCuhTDFERPByRvXQD1xzm/VDuM8f3eHbaQsNqg/fDTQo
	34AxuWZtUMzW5La6sgMKBqYVkTFpp8gRljOKyK0z5OplCV5gpioAJeg9swtf8Bg0+52cyEOS+0Q
	WHYCBfm1Tj6vXwExdiNmh1L8m+6U=
X-Google-Smtp-Source: AGHT+IG6CtV/1ZJaq2aGg/BqFu90ot62tko56Hij+PNazXnlfm090dz2SI4Uih6KXYZYUAKK9CkdNax5HxUvJze7qH8=
X-Received: by 2002:a05:6870:828a:b0:287:a973:2c66 with SMTP id
 586e51a60fabf-2962dfeea85mr9037037fac.28.1731927822928; Mon, 18 Nov 2024
 03:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
In-Reply-To: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 12:03:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Message-ID: <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, anna-maria@linutronix.de, tglx@linutronix.de, 
	peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 12:11=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Replace msleep() with usleep_range() in acpi_os_sleep().
>
> This has a significant user-visible performance benefit
> on some ACPI flows on some systems.  eg. Kernel resume
> time of a Dell XPS-13-9300 drops from 1943ms to 1127ms (42%).

Sure.

And the argument seems to be that it is better to always use more
resources in a given path (ACPI sleep in this particular case) than to
be somewhat inaccurate which is visible in some cases.

This would mean that hrtimers should always be used everywhere, but they ar=
en't.

While I have nothing against addressing the short sleeps issue where
the msleep() inaccuracy is too large, I don't see why this requires
using a hrtimer with no slack in all cases.

The argument seems to be that the short sleeps case is hard to
distinguish from the other cases, but I'm not sure about this.

Also, something like this might work, but for some reason you don't
want to do it:

if (ms >=3D 12 * MSEC_PER_SEC / HZ) {
        msleep(ms);
} else {
       u64 us =3D ms * USEC_PER_MSEC;

      usleep_range(us, us / 8);
}

> usleep_range(min, min) is used because there is scant
> opportunity for timer coalescing during ACPI flows
> related to system suspend, resume (or initialization).
>
> ie. During these flows usleep_range(min, max) is observed to
> be effectvely be the same as usleep_range(max, max).
>
> Similarly, msleep() for long sleeps is not considered because
> these flows almost never have opportunities to coalesce
> with other activity on jiffie boundaries, leaving no
> measurably benefit to rounding up to jiffie boundaries.
>
> Background:
>
> acpi_os_sleep() supports the ACPI AML Sleep(msec) operator,
> and it must not return before the requested number of msec.
>
> Until Linux-3.13, this contract was sometimes violated by using
> schedule_timeout_interruptible(j), which could return early.
>
> Since Linux-3.13, acpi_os_sleep() uses msleep(),
> which doesn't return early, but is still subject
> to long delays due to the low resolution of the jiffie clock.
>
> Linux-6.12 removed a stray jiffie from msleep: commit 4381b895f544
> ("timers: Remove historical extra jiffie for timeout in msleep()")
> The 4ms savings is material for some durations,
> but msleep is still generally too course. eg msleep(5)
> on a 250HZ system still takes 11.9ms.
>
> System resume performance of a Dell XPS 13 9300:
>
> Linux-6.11:
> msleep HZ 250   2460 ms
>
> Linux-6.12:
> msleep HZ 250   1943 ms
> msleep HZ 1000  1233 ms
> usleep HZ 250   1127 ms
> usleep HZ 1000  1130 ms
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> Signed-off-by: Len Brown <len.brown@intel.com>
> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> ---
>  drivers/acpi/osl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 70af3fbbebe5..daf87e33b8ea 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -607,7 +607,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi,=
 acpi_osd_handler handler)
>
>  void acpi_os_sleep(u64 ms)
>  {
> -       msleep(ms);
> +       u64 us =3D ms * USEC_PER_MSEC;
> +
> +       usleep_range(us, us);
>  }
>
>  void acpi_os_stall(u32 us)
> --
> 2.43.0
>

