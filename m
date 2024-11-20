Return-Path: <linux-acpi+bounces-9706-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B59D4237
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E041628106D
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489716DEB5;
	Wed, 20 Nov 2024 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqOiyanf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4827447;
	Wed, 20 Nov 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128606; cv=none; b=BfoHFH+TeSixbY+uUTB4yvan9wEF1bRQpNHgKtMwJnv3S9E4Ti1THo6jknhTCp1D64M0F2wbHuuY4MAjozLzPlu8TFodwS+fw5a0lJt8sjWMZbgX6Ko3qu+TgmLZdthp+KQXCQz9aFQkgcUC8qvTLlm9p4Rygrv1EhT95v3mveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128606; c=relaxed/simple;
	bh=DAu+U4aBQOxNqMfY+fX1HsSU10UR1gHFvVFlgiio8d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaA2zyjmphoNxYUXBooRHVQvgxYaYCi2IvGg4R0L132Fx9vNz7JNVkkzmYJURxyspBi6nlsji1MDTyfEi7Id7UyvIEp2EGXEg+uyqJbpYAZVxHZfnsWM81CyLmhfY+sWQEwVZVVGHp2CTFQY5RPqsv0deRX+QTrTnGv7GZ4r+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqOiyanf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6634C4AF09;
	Wed, 20 Nov 2024 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732128605;
	bh=DAu+U4aBQOxNqMfY+fX1HsSU10UR1gHFvVFlgiio8d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RqOiyanfLUcVt8Y9ZEvD9A5mw13QEqldqRwm5YPipzGQ2/qCbB5mgzyMAALhWp5u1
	 R+cAjL4SB0xM/H65MN6uJIXdb/wI3l+Y3P/qatqSux9ASgGJ2H0b2naAMhUflkg24z
	 V58nTDduwQNm9vCUe7S8BfYddmueGZwbiHObttV9URTqbwNztZxK4zk5fWK628UxbP
	 96OJ8JMW+xVpFrZHRriwAIrP3cb8FKqLgyP9pbyRpoWfUPXwEI5pQdJAjiSDA/fg5r
	 wdmFmoyS+6rBePeRy+rZwlHPlk6EF2Qja7aJ9Xb0r2/t+c2STjHSy9eGd8iruw6BWF
	 s0FQNPS0tGjJg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-296b0d2271aso91319fac.0;
        Wed, 20 Nov 2024 10:50:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU040mMqQgDqHu60BfbxI8K4InNDTu3lh6q752q0w/skl9Iwerf6EvUIPdCzqAIqT7FfbCixPGbdMYJLyCG@vger.kernel.org, AJvYcCW2L1AnAJYVjcyUl8jM9JgzxqZtuwwYPPMIkpYSq/UMA9Kal7VtPquDHpY4+wkZmAaPemegezpPgLs=@vger.kernel.org, AJvYcCWktIs0WO5UG924aS+0Gy39KtsQm+emdSdHGrdcanESQCXr9m0ca5CuLKseA4CkmKcbYe3d4s05K70J@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+sQ7zhWD+dP2O1GcpDv+T/el5MdzeHGwSEBrr5lOy8zYUM5N
	hPOLNXIy6WwwpgKv9HX7Hw1+0RUuS7Hbm8HNnpYGNyRrFRu4/DtIHxiw9wKBJg4hS2OXRXb9aDb
	7NhWLlGJ+2bFoFVd8iHMjWOuADUw=
X-Google-Smtp-Source: AGHT+IEjeNuA0tpcrzagOHqtGo36tK5dX5VbtxF/7j1lMXMnQlZZ73pP9+Gop4Va7zug4x9iChwV+urmvRQR9I0sc/g=
X-Received: by 2002:a05:6871:d084:b0:27b:55af:ca2b with SMTP id
 586e51a60fabf-296d9b5cd91mr3642408fac.11.1732128605011; Wed, 20 Nov 2024
 10:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com> <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
 <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com> <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
 <e0dd2cb8-eea2-443d-bf23-4d225528d33f@linux.intel.com>
In-Reply-To: <e0dd2cb8-eea2-443d-bf23-4d225528d33f@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Nov 2024 19:49:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
Message-ID: <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 7:38=E2=80=AFPM Arjan van de Ven <arjan@linux.intel=
.com> wrote:
>
> On 11/20/2024 10:03 AM, Rafael J. Wysocki wrote:
> > On Tue, Nov 19, 2024 at 4:08=E2=80=AFPM Arjan van de Ven <arjan@linux.i=
ntel.com> wrote:
> >>
> >> On 11/19/2024 5:42 AM, Rafael J. Wysocki wrote:
> >>> On Mon, Nov 18, 2024 at 3:35=E2=80=AFPM Arjan van de Ven <arjan@linux=
.intel.com> wrote:
> >>>>
> >>>>> And the argument seems to be that it is better to always use more
> >>>>> resources in a given path (ACPI sleep in this particular case) than=
 to
> >>>>> be somewhat inaccurate which is visible in some cases.
> >>>>>
> >>>>> This would mean that hrtimers should always be used everywhere, but=
 they aren't.
> >>>>
> >>>> more or less rule of thumb is that regular timers are optimized for =
not firing case
> >>>> (e.g. timeouts that get deleted when the actual event happens) while=
 hrtimers
> >>>> are optimized for the case where the timer is expected to fire.
> >>>
> >>> I've heard that, which makes me wonder why msleep() is still there.
> >>>
> >>> One thing that's rarely mentioned is that programming a timer in HW
> >>> actually takes time, so if it is done too often, it hurts performance
> >>> through latency (even if this is the TSC deadline timer).
> >>
> >> yup and this is why you want to group events together "somewhat", and =
which is why
> >> we have slack, to allow that to happen
> >
> > So what do you think would be the minimum slack to use in this case?
> >
> > I thought about something on the order of 199 us, but now I'm thinking
> > that 50 us would work too.  Less than this - I'm not sure.
>
> 50 usec is likely more than enough in practice.

And would you use the same slack value regardless of the sleep
duration, or make it somehow depend on the sleep duration?

