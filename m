Return-Path: <linux-acpi+bounces-15042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A9FAFB38F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 14:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD90B17BAA1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719F29B761;
	Mon,  7 Jul 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdVtM+lV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4B28FFE6
	for <linux-acpi@vger.kernel.org>; Mon,  7 Jul 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892611; cv=none; b=usTFmsB+RtZf2zkDXjI0S29v1ImeuoPx0UwPkoHJt22NSZ61mY33LHNnW8kjEOQOgZG8AfCXYUjQIWA/f2UvEFsiAExSmy8rI0FrtlzB73IN/94WTXdWABhkL6+inhMsy2RStGIme8LQ00Odf0/0AskG7GVBVMeB9ZzIgFaCmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892611; c=relaxed/simple;
	bh=TlGVc2vlqFVb5SNdiOg16XM/hn4x/ChX9J75203gx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhValSBxHtjSvFmocSn4AIVkoq8wyFKW8OWwwJktoFG3gExMy+zl4QQ2UVH2hL+f4g5qqmTRQg44DmQ26z1YmDPEuE1zev4Rv09ntNwcw/5M83OlEW9sX75ST0FEWgNxGqXNbZHAz+NtQMQE8j8uzVDmVx3h7kLFBlvIveCtBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdVtM+lV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso25935795e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jul 2025 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751892607; x=1752497407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNdhzW/Y8MjvnDjqqg8r50YbwUFzxxNmO6sjtPUADNk=;
        b=wdVtM+lV2m66DDMtkJY2nu88alF5cVWGttMZ10OgbzsZ8h47ohfTKj5PABJwoK4tgG
         R65EXnjFiDOFCvOrozUhSSeOLXkz/xmjdfFfymxmBfSTyq8zlaE5LUOD/qY7LMv7tBQm
         eu+1+UWCLVupmDIf72CNX3fkkABjLj+6fQoIbM9JCM21IJMOkwX5pQaDjU6Xx3F6Dq0o
         KJp8kynEhEx534H/BuIavkPHVTrsuieSiajgPEREyrgjYkeyPbNVfVDUGqugBw8qOooT
         jr+oefHrq1AwuCjEQr1vhL4BipOAsck/AE4/9zW2+IKvl/0RVtz5dEe60IDC5sqnscNa
         fQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751892607; x=1752497407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNdhzW/Y8MjvnDjqqg8r50YbwUFzxxNmO6sjtPUADNk=;
        b=WXEQEYLk3CLB1q04iNCFpX9J8B0kn5aNAXqjvr9U3WC6AurcSh8IOEtDGjiPKj5dqM
         d8rZPIkeMNtJ8AS06H6j5LlNsaibS5PUeGBEAsOeiAVviLC50LzEH19i6l9TVRYPybei
         /RiyU60sFRBeNhV0PPFBaaUbMgGVcHoA3nw7vOsbya4Q7nduiY4nCahP+xpgbkAmVLyz
         N9dwAAai7emztyTcY2DDYfyulzj74mGypVZE1HEJ2dvUZJRxFY8m4vnxsEH7k1Em9Uda
         tlwMQXtkkkLKTB0E4Hmfi+ITOBf53CBJyjgDNnvrARD4Yx3tuGtdLrlcyOtKqR1RT5XA
         jdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQtCRF5wnbNLVjJMGquttU6THhF+84Y9SF4izwdEv5Div44uLPF43YUP2DRFutdISTQxPDZjDq7sD@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4rBXIvsmNBaR8OErpHCcAkDmtHsBDXfWY5A9jhYVolldj5iJ
	/2ywECmw9B/0gtBwIqAO7qi/YW6dCc3IL5lwyWBDovH4+6AEOZ5PPB/ZOlyuBvd/jjbbY1Y/s1M
	rGTWmKv63oeoM4TADwwxRhMn1rf0GJZxSRgqG+0fY
X-Gm-Gg: ASbGncsLh203ncpcl6BhjKb9W3GmRynrS6uuH3eGqsBacV1jqkEpmLWz6Q37yMEG7vh
	d41B9Igq/+ssw16UanNkXvVGWgDJkZuy480eDGcwzx8b4Nm/D5AnqxoL9CJYDyi23hfqwt8aN2x
	FyNqvJClmEQMX64k2LtJidli5PkOBBmrdxfUdLI1IOKAdTd5aee6p+A1oyTFV2dlHNTV6SAiw=
X-Google-Smtp-Source: AGHT+IHsMXBAD8GA+B5LxiAfDAfLtY6TvZ5FvEHyZmOChFA1YhgQJ0ZWJ5lgZJTqiFSe6ZNS/+jU9jf/Us1OmmZWM4c=
X-Received: by 2002:a05:600c:83c4:b0:450:d04e:22d6 with SMTP id
 5b1f17b1804b1-454b4e6bbdcmr104358265e9.7.1751892606844; Mon, 07 Jul 2025
 05:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701174656.62205-1-ojeda@kernel.org>
In-Reply-To: <20250701174656.62205-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Jul 2025 14:49:54 +0200
X-Gm-Features: Ac12FXzQ5ck03QQHYzFLsSFTLp2hRsyOexA643YmM2tCIERUaEuSJWfO_lmHndc
Message-ID: <CAH5fLghD5eU-YUkq0M4gFK1tXOGHz3Py4m_+xTnYzLxT_ru0xw@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: remove unneeded cast to clean future Clippy warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 7:48=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> A future Clippy warning, `clippy::as_underscore`, is getting enabled in
> parallel in the rust-next tree:
>
>     error: using `as _` conversion
>       --> rust/kernel/acpi.rs:25:9
>        |
>     25 |         self.0.driver_data as _
>        |         ^^^^^^^^^^^^^^^^^^^^^^-
>        |                               |
>        |                               help: consider giving the type exp=
licitly: `usize`
>
> The type is already `ulong`, which nowadays is always `usize`, so the
> cast is unneeded. Thus remove it, which in turn will avoid the warning
> in the future.
>
> Other abstractions of device tables do not use a cast here either.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

