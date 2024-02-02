Return-Path: <linux-acpi+bounces-3187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3A847156
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Feb 2024 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F71C24614
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Feb 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359654778E;
	Fri,  2 Feb 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciLtjmQe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C446452
	for <linux-acpi@vger.kernel.org>; Fri,  2 Feb 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881507; cv=none; b=kFQdJObQnxyO1LMvnfOKc2ODdUR36b9sHKA5uXw3+7vZ0z2qVKOM9AkAeUcn1Hh1RFOtoTjrv+XVeSKUOJquo5OWyrxP7RJ6G5ZGmSrHfpMcUWh74pj7qeMNsxfTDsfDl0ZO6lg22wmWy9hVJjsvVUOcQ1pVy+bjjtKm530NlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881507; c=relaxed/simple;
	bh=PKzcI1q48e2Z9AZgmA1h8iLqG3H0FbHpPV+nCkPjFVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAgy3YWjCIq2CYnqCPPByJ8TUKSr3xAtiIlBOTrIjug3S9UvuLVOUqYRgydtnpa9qqCy5EnXv62JedFUZ9LEcV6mM91PB6pnvVJ46H3pEeJxmmRX/cgCMC2C3ydZw8HfeuOVXa3N+yiWB734PczKrO9d5vYohsADDfjbiAremC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciLtjmQe; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bda1df7e35so674946e0c.3
        for <linux-acpi@vger.kernel.org>; Fri, 02 Feb 2024 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706881504; x=1707486304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIzUaTAWY721VAmsfjicI7pRblrKzWu2/3eiQAJEETw=;
        b=ciLtjmQe/0vRcQ3JQLVTYPqCoOMXdITAKbYTfWsB+fpRqSM8y404m8HozoFm5QYZsL
         hFVfXSOloLdjHecWKFMM8jdutG0nvWpKrQtzxZo7VpdpsY5FH7fHh9BR6g0EGI8yTVqL
         X2XFDObPrxafA/1Sb4+6fkZuqIpPeMelkv2aWExfqoPn7KK9tQZeXG9t/AtPel9FGaH7
         3D6N/jyiXnluyTCTST9wICuZosRMjt6x7r2WaOnXojP+XdYv5tffqk+WBcrAJVqpgHB0
         mPBL6rpGZIAnxdCjkOS5UtTwYUk7va1agy48bAvxlJJIq+FtWNph+TEW7FIGMQjeVOYY
         27KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706881504; x=1707486304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIzUaTAWY721VAmsfjicI7pRblrKzWu2/3eiQAJEETw=;
        b=a5ZM8aOyz1LQUYuvN8QIO77PzUE39gztJeE4hPoXLywRQXSOoLXrYdXQNsBlB1ZOhU
         aaNBngA5/HDA3m3Ilt/ctR7ra3FyCGs5VrS2tsEd7qJqcTNuo0fyyp/ghffUgopQBCEn
         b1OiG5wn/P0VsyOBtrr+AlU6jW4s36O3kIMhDk00iJReC8IMpJPzdnD1pjbtgd38ooe/
         6STpFz5/j24b9oWtq97HFJ0f9rNxzKyDcYP1qJniyJzmatOl3zGH6DZ7bUmkexKpnmxY
         X4RZOFvNZ5LISlmHGwb0Kj/OLKBbMXxB+AJlC1Xm1rWf3mwF5p7xA9yuBHD21px4PPd3
         c3xA==
X-Gm-Message-State: AOJu0Yzso7GGvst4F2Mvp4fUkasEOjQMk6FL0iaLSYOAzQS3YBdMALVQ
	tw7d9OQTYjlfNKwXmhhQBLNheRVRQQFlfZkGZFulTSeSHVPfZoasndeKZdd4XQK6W35fXgNRTrC
	FheDWzGkKWdW2E/BPJQjes+vnMzHM+wjPxA9i
X-Google-Smtp-Source: AGHT+IHcugcAY0onJJ9YbOTRMsO8AuL33RLMvypF1xfaELG25ml3lxK0pklBkcHRLPdq/bsUZds6rXkq0SmKDaybI0c=
X-Received: by 2002:a1f:f4c9:0:b0:4b6:bdba:8460 with SMTP id
 s192-20020a1ff4c9000000b004b6bdba8460mr1847799vkh.9.1706881503872; Fri, 02
 Feb 2024 05:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202101311.it.893-kees@kernel.org> <20240202101642.156588-2-keescook@chromium.org>
 <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com> <202402020405.7E0B5B3784@keescook>
In-Reply-To: <202402020405.7E0B5B3784@keescook>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 14:44:25 +0100
Message-ID: <CANpmjNO-4A4LMK8kbWiiODB-vOZqc5gZndWtnYDc5RCGDBcoSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow sanitizers
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Hao Luo <haoluo@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Fangrui Song <maskray@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Bill Wendling <morbo@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 13:17, Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Feb 02, 2024 at 12:01:55PM +0100, Marco Elver wrote:
> > On Fri, 2 Feb 2024 at 11:16, Kees Cook <keescook@chromium.org> wrote:
> > > [...]
> > > +config UBSAN_UNSIGNED_WRAP
> > > +       bool "Perform checking for unsigned arithmetic wrap-around"
> > > +       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> > > +       depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> > > +       depends on !COMPILE_TEST
> > > +       help
> > > +         This option enables -fsanitize=unsigned-integer-overflow which checks
> > > +         for wrap-around of any arithmetic operations with unsigned integers. This
> > > +         currently causes x86 to fail to boot.
> >
> > My hypothesis is that these options will quickly be enabled by various
> > test and fuzzing setups, to the detriment of kernel developers. While
> > the commit message states that these are for experimentation, I do not
> > think it is at all clear from the Kconfig options.
>
> I can certainly rephrase it more strongly. I would hope that anyone
> enabling the unsigned sanitizer would quickly realize how extremely
> noisy it is.
>
> > Unsigned integer wrap-around is relatively common (it is _not_ UB
> > after all). While I can appreciate that in some cases wrap around is a
> > genuine semantic bug, and that's what we want to find with these
> > changes, ultimately marking all semantically valid wrap arounds to
> > catch the unmarked ones. Given these patterns are so common, and C
> > programmers are used to them, it will take a lot of effort to mark all
> > the intentional cases. But I fear that even if we get to that place,
> > _unmarked_  but semantically valid unsigned wrap around will keep
> > popping up again and again.
>
> I agree -- it's going to be quite a challenge. My short-term goal is to
> see how far the sanitizer itself can get with identifying intentional
> uses. For example, I found two more extremely common code patterns that
> trip it now:
>
>         unsigned int i = ...;
>         ...
>         while (i--) { ... }
>
> This trips the sanitizer at loop exit. :P It seems like churn to
> refactor all of these into "for (; i; i--)". The compiler should be able
> to identify this by looking for later uses of "i", etc.
>
> The other is negative constants: -1UL, -3ULL, etc. These are all over
> the place and very very obviously intentional and should be ignored by
> the compiler.

Yeah, banning technically valid code like this is going to be a very hard sell.

> > What is the long-term vision to minimize the additional churn this may
> > introduce?
>
> My hope is that we can evolve the coverage over time. Solving it all at
> once won't be possible, but I think we can get pretty far with the
> signed overflow sanitizer, which runs relatively cleanly already.
>
> If we can't make meaningful progress in unsigned annotations, I think
> we'll have to work on gaining type-based operator overloading so we can
> grow type-aware arithmetic. That will serve as a much cleaner
> annotation. E.g. introduce jiffie_t, which wraps.
>
> > I think the problem reminds me a little of the data race problem,
> > although I suspect unsigned integer wraparound is much more common
> > than data races (which unlike unsigned wrap around is actually UB) -
> > so chasing all intentional unsigned integer wrap arounds and marking
> > will take even more effort than marking all intentional data races
> > (which we're still slowly, but steadily, making progress towards).
> >
> > At the very least, these options should 'depends on EXPERT' or even
> > 'depends on BROKEN' while the story is still being worked out.
>
> Perhaps I should hold off on bringing the unsigned sanitizer back? I was
> hoping to work in parallel with the signed sanitizer, but maybe this
> isn't the right approach?

I leave that to you - to me any of these options would be ok:

1. Remove completely for now.

2. Make it 'depends on BROKEN' (because I think even 'depends on
EXPERT' won't help avoid the inevitable spam from test robots).

3. Make it a purely opt-in sanitizer: rather than having subsystems
opt out with UBSAN_WRAP_UNSIGNED:=n, do the opposite and say that for
subsystems that want to opt in, they have to specify
UBSAN_WRAP_UNSIGNED:=y to explicitly opt in.

I can see there being value in explicitly marking semantically
intended unsigned integer wrap, and catch unintended cases, so option
#3 seems appealing. At least that way, if a maintainer chooses to opt
in, they are committed to sorting out their code. Hypothetically, if I
was the maintainer of some smaller subsystem and have had wrap around
bugs in the past, I would certainly consider opting in. It feels a lot
nicer than having it forced upon me.

Thanks,
-- Marco

