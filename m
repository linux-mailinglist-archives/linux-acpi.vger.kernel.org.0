Return-Path: <linux-acpi+bounces-14245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61B6AD208C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB61887789
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293825B1CE;
	Mon,  9 Jun 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib7JYYMP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285011547D2;
	Mon,  9 Jun 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478030; cv=none; b=pCsSrU1lhLlkRt0oavDDby0OJwPoAbetxlz0rDA+iYsONp2jNA8Oivbkl+n1BVIClsYUQOBsX2Mp6Aj8rlHM8nKWDpYPMyKxCZDLlE+y6flYebi6vOY8vaQdmFHDDAUBPGwPXv+1CZNPOyPLdRKDeBgmycv96uL0LPtvOwHp/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478030; c=relaxed/simple;
	bh=hKR7+ajhuSlOyH7j2iFRCSEbWtE6DkgGdy/ZRTO5PvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EA3fsknUovE7Emt+CDkvtsVbDx3Zh3QTz7sMKVw1MyvkyY+r7n2OC4/J7P93aiyoMoTYnHKaXuelaCtloxHNBRNQX9Pjf808kNWjgfT8iJXybsKZ4MXoEUVxgc0Bux3EzUJclT5S0mDOGk4fIu8JVb+3Io0/84ohx2cyjVYxmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib7JYYMP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2e999729ccbso2861330fac.2;
        Mon, 09 Jun 2025 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749478028; x=1750082828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=afG0/kl8HRSNgTfY07WBqZftxaFWWI+8Ts2aM7Cdogo=;
        b=Ib7JYYMP7LP9DCiDoDAiyHBwqRieiCYVLr1IQgjGALsgiKl+nyRhGcsgT+wdaWXmJL
         0ZkJE0nIzquL759fjy75mWHBLHByu3rQlIbMAwjJvbCSJ/s4P9y0oCoqyosLCoz3nv4g
         e0enKEvELP7bOJTczb9g0eKlanU7c/JcvCPO0ZFT9KyfXk/FRpR2t2iSPoK1QGcox7OL
         NqR3CCBjqEQ8ClnW4BG9F5nJtyXU1s6RFo1nhGsEFzUxh19a4Be9sGLGtbviFSPtt6Iz
         doxQod2gtiK1YmGuOxCkXxRbm8Inll5JFkCGd7RO0lLH1Ojtu2j7WNK7P/iNiktGwlWk
         tKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749478028; x=1750082828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afG0/kl8HRSNgTfY07WBqZftxaFWWI+8Ts2aM7Cdogo=;
        b=CKNYmP0D/RuaZHeajohGofL7Uf3XRMAG4cMxfaHQvVKQNCRvfzHjz4qsE3XZaQYB6u
         3Q/FENSrrCTex5fzDQWa/UqtQ8Bdq+0TvxPM+UWSIf715pOSXQ9wXwkSAN5WIyow7jFG
         /GsOlqfVT1uIzX9hy1kV3DbmNVsJXoDkEGak9SfDNCEJdeP/cR73hr3i9IPo3481PtyQ
         1OijQCyrAzkuAClSU97/7LwVfdywfq9/yR1y447ojy8Px0R1QGaElJ4QzcthgKFe5CyQ
         K+Z5wc3NfOsgkx5yvQWgBnw62fmBlbX5VdQlPJA+emTJiZB9FXKVRC+SSNFCiirHFRRw
         vSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxgjWMvqMQ07EQpHCVGDzzL/Y1Vah+wsvoBRDKKcVu7QnefXXzrKO0o/MSHFuZAWtcv9LsWU+t8rlF@vger.kernel.org, AJvYcCVggiApVkXFMp6aD7yAw7RAKNMup56MZzKLyKe7RY3/cKJiMmEPKiB9+ozabxMWDO31zWfYERRveigsUBRnHTk=@vger.kernel.org, AJvYcCWpbm7UJvaGUg1mY2gUF/XRyiLc91i07BcQSVePgA5NRWGOfbvODz8z5gsk1R9nCgn58DM3IW+0BKhxCL9m@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmppyqqGUiYYwvwUE9U++2UR0CHbPrERa4G8eSdIIhMJ3C3pr
	VW9tXgivoYedlm6mt6dwsY4g0DfgP+RI0QPikDNdJfX0vtPHzx/kjmhhIvArWK7Ug1vu7UHU8vW
	qYxHIee9yF68za0ErYRiE+VoVOiBJCiQ=
X-Gm-Gg: ASbGncumygkjABTfFgROWTy55ihO2VbxHyf44LjL1X7HkA7Zr59j0Iblc3wU0Q5h3qs
	W5aIbYTTLH+bJ1KYghNn7qw+TKboYqIEtv8kltJduKqlDhFhrnTEvMpKw/8jcNSrQOG6/BCUuv5
	h3nVfZZ26z1duGENupCf37CXU80NflmhTUKcpoasGF
X-Google-Smtp-Source: AGHT+IFMIV6U/igIlpB2ppK59kvRoIdscUJqew6GIJircIlEAiWY4uTovmhUmkBLtQPxTPuE4nyg2BFG5tS4OB9pPc8=
X-Received: by 2002:a05:6870:a7a2:b0:2e9:7e3:933f with SMTP id
 586e51a60fabf-2ea00684093mr7039729fac.3.1749478027948; Mon, 09 Jun 2025
 07:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
 <20250606170817.3881748-1-igor.korotin.linux@gmail.com> <DAGZNG518T0C.1PXOK55IXHZOF@kernel.org>
 <aEVqgUtflBCzZi1X@pollux> <DAH4KX3Y3M3P.3B82LSVWU172Q@kernel.org>
 <aEV43zxZmWvDgKES@pollux> <CAJxaTdNZEdK21mFPu2kTJPa7aQ+PpnkwFVdEP5MCt6w+bD0wXA@mail.gmail.com>
 <CANiq72=rerpj_Ut0x7dDb0O8dEh9SHaF1HVyyfMM83hz--QCJg@mail.gmail.com> <CAG7QV91u4rVgAqDjKAofupASSk9q0uRKNtsrHg7Q6KExRMkFog@mail.gmail.com>
In-Reply-To: <CAG7QV91u4rVgAqDjKAofupASSk9q0uRKNtsrHg7Q6KExRMkFog@mail.gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Mon, 9 Jun 2025 15:06:56 +0100
X-Gm-Features: AX0GCFvuwUvErfOYrgAzHxM0-sxRU7s6mm5moyKumxFcZp5T9Z7y7tnWeLeM7Kk
Message-ID: <CAJxaTdMFp0WAB3BBDPUztVvTtDGUt9=KyHTDpDOgAZ4ZEk2XUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] rust: driver: Add ACPI id table support to Adapter trait
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Alex Hung <alex.hung@amd.com>, Xiang Fei Ding <dingxiangfei2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> <igor.korotin.linux@gmail.com> wrote:
> >
> > Let me know if this pattern is acceptable. To my opinion it is not much
> > different from the original 2 functions conditioned by #[cfg] and
> > requires some nasty changes.
>
> In general, the more local a `cfg` can be made, the better, because we
> can share more, e.g. the docs and signature.
>
> But maybe in this case it doesn't work -- what would be the "nasty
> changes" required?

In particular on this example:
    fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
        #[cfg(not(CONFIG_OF))] {
            None
        }

        #[cfg(CONFIG_OF))] {
            // the rest of logic
        }
    }

The `dev` is marked as unused if `CONFIG_OF` is not set. So we have 3 options:
1. rename it to `_dev`. This is nasty to my opinion, because it is misleading.
2. add #[alloc(unused_variables)] on top of it. Also not good since it
will suppress
all other possible unused_variables as well.
3. The third option is `let _ = dev;` in `#[cfg(not(CONFIG_OF))]`
section. I came to
it while I was writing this reply. This looks like the best option of
three in my opinion.

Thanks
Igor

