Return-Path: <linux-acpi+bounces-20070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A7BD03D27
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AF43063B23
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC636E48C;
	Thu,  8 Jan 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+oHFgWJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3F212542
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881247; cv=none; b=MkmJVgmtS83bZWlDPJvIxYXyGmex32X49yLLB8Af7q+uOsfvtSULZm+xJwZRFcRXPsyIGZox+XqrqAi1OXU6gKtR59nDVexNGo0Hz/rO+T7GrlMKCZ4dOSqfYoXQY5dnPiMpeat2+vZ3IyElgjvmckvuh35Wl1MaknMJocEyBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881247; c=relaxed/simple;
	bh=jY7usSNT4rTyKQgdFHMP8USgm6QByHELxYUKyGll5EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9K+fR4ZMM85IAgsbq00J7kB+o445YwO+oQ6a0bIzGP0muphvSVL13wSItiiS7v3gI1YhovBnxORYh/UXJ1NTX0SGfjPteWjmEJ8ug1FqPFIAz8LY3prJzZsKRnIKjQmmgKiY6UHHCVVAHtrVDHIwGRjAI0yjk5VYZb37qab2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+oHFgWJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47a8195e515so23659885e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 06:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767881243; x=1768486043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY7usSNT4rTyKQgdFHMP8USgm6QByHELxYUKyGll5EQ=;
        b=y+oHFgWJSFAk+Rl8Fk3DhgMKxaZxafAKrnIhyD29e0Tl+kcrDfNL2gFLrNPWt/imXN
         EY6db6meTD6uqMNq9WFZ6fRA/KxUwEYIYUXFbp3UOYBr64oYkMCc4mcYbvqh5Zvgl86M
         J0RQIUTlpYvxx1xLu+agHDSXSbWEugb4pBN3gNZYuhsHT7TtWvBAw6sbaqBrtQ4Fjp2t
         gwb4RG8U7vnVGDgT7fN42NBxaV+9Kyr2IQ1lGfMJNImL5iuxk3Ub0T9cUPtp9R0xWeDt
         zc6Dqi7sG0L2l1XFyNSsw01CyxM4ub3rbsA0mgIzO6SQqTKgF+4WfetSGmew/b6wdmHs
         kRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881243; x=1768486043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jY7usSNT4rTyKQgdFHMP8USgm6QByHELxYUKyGll5EQ=;
        b=RWWVUw13y++ZYeFeKEJaLa+H6DiXWmKdfykVD5Yj3P5mmUtnztHP5KSRcNV2gwsgLF
         cYnz7DcNpFaCya2arcTfukL8X2yBOBSPJGhzjH+oJbfA6dlrmoG1Dop/4/Iy9zMfWmWB
         r5m/nnOsLLEmXcKsE+98MK40OBczVw8GY4wQgn8MKgFtsNS/lZUSMF0GEhpIQhDn2mUU
         MB+cBL5oH4lWn8JjG5U4UAhwf6Nv+T3O6xusyvjeJpyFRTF751KcnOA4LQiJHBGfrBJL
         xe5+sSeFGCfPNV0vTF8qZBmsscnnJ4v69RUjTQ/MxiEUOuHPsAVLTOccpG+npLtRMzwr
         kwMw==
X-Forwarded-Encrypted: i=1; AJvYcCVRhjecw2Px1Ue2xuTiVr0HNlaDc2HE7pYSAF5KnClZ1ednXKXpCKXwLpMbdPffb1Bivm/HSg7BFrvB@vger.kernel.org
X-Gm-Message-State: AOJu0YyJGhPE37hk7eZ1628Ue2J4ulUMlkkbXHnB9Yjer+uupd0cYMjc
	M9drAbRKxVIDlTK2ca9QNLdeFl9u6oc7bBjkgWnNFiqpB4Myp+POw6uHm8xZBt3LGLMxHM+6p/y
	ERflMw2q3wXWXZH0aNJ+ysU8jG8yEcAp+X0/pXDeQ
X-Gm-Gg: AY/fxX6jjph0a5I45gl22L6Dw9yajCftiihFbA1Zu5nsp47tYSjQzDjP8oQLqwCe48N
	W89KJAAmLboOoKcHgBhoaqt2xC4pjQUqLrXy63pcMOQCvoqU/uVROSjDYmJzSKUXOqwniuNWBrD
	g9Ggqly8NJyij8Wi7ECJ69q4WIOl6pqx7kf0vcH1PIK8PsOf+trLM0fBxu/4SbGdfukVYQMIQfh
	W9AmYP1HaPUyI2yAKynR96nCWDWt4H5AQoi1HAXyk1n9BhMb3IEbe5mk4J/AVdrbhJqKZuE7X9K
	dxEIOqp4M2knQRZHAFgjboKiTCXWejFlF/mn+21QzwBTQ8ApvlWpQTiV9A==
X-Google-Smtp-Source: AGHT+IF1237WYc38p9/B3qh2Aqyfcy/bNYXZ3uChDeYed9WMB0aAYkPIHqxXqRrs+vItXWmGNjDcidgrfb9Q9nJNXg4=
X-Received: by 2002:a05:600c:3114:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-47d84b32f3fmr78790375e9.21.1767881243403; Thu, 08 Jan 2026
 06:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201155210.22710-1-atharvd440@gmail.com> <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Jan 2026 15:07:11 +0100
X-Gm-Features: AQt7F2qJ2qTAy-Nl-YM9N51CbNtXzqrY-DauEClktNVvNl_fSY8CekNAAtqqceQ
Message-ID: <CAH5fLgg1zP50iTZpOHkObq5HLQt9y+OU_=3+aaxCK4XX5HqbCA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: acpi: replace manual zero-initialization with `pin_init::zeroed()`
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Atharv Dubey <atharvd440@gmail.com>, Len Brown <lenb@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Dec 1, 2025 at 4:52=E2=80=AFPM Atharv Dubey <atharvd440@gmail.com=
> wrote:
> >
> > Use `pin_init::zeroed()` instead of `core::mem::zeroed()` for initializ=
ing
> > `acpi_device_id`. This removes an explicit unsafe block and aligns ACPI
> > initialization with the pin-init conversion used across the Rust tree.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/1189
> > Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
>
> A Rust-side ACK or equivalent would be welcome.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

