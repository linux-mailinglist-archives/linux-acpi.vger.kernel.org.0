Return-Path: <linux-acpi+bounces-20065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B653D03684
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A8A3115956
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B43339FCE;
	Thu,  8 Jan 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6eE8CFu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543512EBBBC
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880836; cv=none; b=RSU2RvOlw5s4ZdZAjqW2AdSnVmJrDE9N0Rt6wt2Kn3T4ao04OsH/eCcZ62KDy0+hS6UOOJGKTtHH62LS9+ZlQnL2kKk+Bh/UvqZb70aP0OR+2SUT9jssJBgqCmeEivkryneBqsxw/+5oJO7PjWX05xBW5jeyw/mcnlTRxqJmIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880836; c=relaxed/simple;
	bh=hKfOSUfvuMQ5SepCQVYqi1D2A5CzKVBvwUGoWoBFvbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAHGjy9Lsi82oHTfYwKHNZYIuldc1gJ/M94QzDis57SzIR1j1yUDsUHYWIdW5Nr8xrj8KnTch+oWEtnw22Ve25OSh3o6zdEYTlwF7VpkUlZ6vn7VO6KO4DPZk4v2eqvoVKo1SU2D2UHpYsyVVkadFghPnGTD3Bhtr+V5SzChHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6eE8CFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1172C19423
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767880835;
	bh=hKfOSUfvuMQ5SepCQVYqi1D2A5CzKVBvwUGoWoBFvbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D6eE8CFuDWgzYLvzzZzZFvWc4uHTmOwT7/1sr5w5jLRYSTwtMDBWIomDvJQlSE4zQ
	 q9dPEYdraFvs9i9vojQBD7NxymfCe8PXiIq3cS29p8vT0SaaI25XwGpOa8OUGVP1mX
	 CxsKJhMd4mox2mT+nF1VZl42NegGCwLq5XRjJ7vjpAFWMkYJeHV4CiebXQemXKc3H6
	 IwOa6xipiqp7mi7gdngnBDgBD0L96ztuhoGJopEzMcF64huI7DWSmG5L+A01Yt/3rQ
	 xGDmz+w/lDU9/WW69TqLCdnwBGTXfI+4Mt9CS6+ZnIvdMw5k0PzpxPOq0S+S2ocovd
	 z1JMiD6YPkSIQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3ec4d494383so2393443fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 06:00:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWejpCibk18ndEVG73kDG6NupP/N59btgqANsyNCo4qhWrdYDHtfKRXtZHx9ENkGV8MNIcd7MMGeKPN@vger.kernel.org
X-Gm-Message-State: AOJu0YyvL+KWz3NBetXzh3x9NiBBc/7O7l30arx4ALMDPJn37IyEXY22
	gH3KKnaVhoL10K/stk0DAM7HEt7n2WmxhaspF5eru/RcrNbXo9bPZvydo0M8Tr4QlmPrQA31ZMt
	TupXJ+DcBY7JGSvMpkymV4dKoDikE71M=
X-Google-Smtp-Source: AGHT+IHuzwZG3RIztOFnuuSoi7na5S1md2vPW146MeXMTjxsZNNp6LzsuVGQ2sdodCQAUOnAPWd72ubFAH6Bdw8ntCo=
X-Received: by 2002:a05:6871:61c2:b0:3ae:f15:5dfa with SMTP id
 586e51a60fabf-3ffc0b69478mr2757787fac.28.1767880834939; Thu, 08 Jan 2026
 06:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201155210.22710-1-atharvd440@gmail.com>
In-Reply-To: <20251201155210.22710-1-atharvd440@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 15:00:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
X-Gm-Features: AQt7F2qXpUZysSL4zT5EKAuSZWtHQtiZRI4zJXetOPRTabYdOiR2W9ifaSip4aA
Message-ID: <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: acpi: replace manual zero-initialization with `pin_init::zeroed()`
To: Atharv Dubey <atharvd440@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:52=E2=80=AFPM Atharv Dubey <atharvd440@gmail.com> =
wrote:
>
> Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializin=
g
> `acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
> initialization with the pin-init conversion used across the Rust tree.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>

A Rust-side ACK or equivalent would be welcome.

> ---
>  rust/kernel/acpi.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> index 37e1161c1298..cc98b36b90a0 100644
> --- a/rust/kernel/acpi.rs
> +++ b/rust/kernel/acpi.rs
> @@ -40,8 +40,7 @@ pub const fn new(id: &'static CStr) -> Self {
>          let src =3D id.to_bytes_with_nul();
>          build_assert!(src.len() <=3D Self::ACPI_ID_LEN, "ID exceeds 16 b=
ytes");
>          // Replace with `bindings::acpi_device_id::default()` once stabi=
lized for `const`.
> -        // SAFETY: FFI type is valid to be zero-initialized.
> -        let mut acpi: bindings::acpi_device_id =3D unsafe { core::mem::z=
eroed() };
> +        let mut acpi: bindings::acpi_device_id =3D pin_init::zeroed();
>          let mut i =3D 0;
>          while i < src.len() {
>              acpi.id[i] =3D src[i];
> --
> 2.43.0
>

