Return-Path: <linux-acpi+bounces-20109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D14D08D8B
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15F97300CB67
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4633C53A;
	Fri,  9 Jan 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVRSFU8t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECB2F83AC
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957339; cv=none; b=OQjoGSnqPGobbkoXzDi/reYa6/TaCFTb/gJYCvzuKRokwA921NEtb/ayCNjF5Tcsh6uBAZUbpWffj9QhjozBsVegUP1aA9RESH5PP3L6VeX+yzPutvqkUl3Q9/y9oAGfsxKHybmldD5j9n5+K494npu/d9HKuE3ajuD/zpR2k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957339; c=relaxed/simple;
	bh=LFYqHzPhV2sOQmqjxlHzpNPQb94+zx5F8UuTsZW33mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOsURr2DE0QcXaGDYa2zBCn0YvHUT85fO81zi0cdzMZJGz5/ilz6l7eqqPb+N6CRx6M+XvQFDhPRQdFjIZi44sdjmtrQ56T9W/MWs1Xv1M8nqZMy1jCYUvAvhfc6lA20QOjow7S+XwnNZJC6idRb5IUQmWfULSEnz46dOFLOhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVRSFU8t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so3284858a91.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 03:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767957338; x=1768562138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnuBzUiO4MDRfFQ4nmkFijV7grhObnxX1dTyGMCbkWU=;
        b=SVRSFU8tIN/tQrqlu2+DUNlnbWLHwmlVPFex8LgVGh7rq7am9fn9bt8Ma0Vi4T9egv
         gaFaO6QX5tqAUs8Iat19XtqUFRfr0bO5w4cKEd1DNiBtNTnBtB1/2UAJoEszgQJ06SEO
         J1Hy+iT+0NWIw4QNYG4nP86Fg2jj0wPu3bfEPSHmcRBOWCp2IFcPU1hjNQfXHbkrJBsL
         FoTrYvr5lNIo7i4Qv5N4iZHyp7u/iawXDJO65VRbpGMq16Rhos1gALb3kPzzGh0Y22tf
         NgTnJxX45vltkz4ERK4lDZF8PfoizfjF+A3ugalaN818F2aWik5Lfm4VvixT6tatFhud
         y3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957338; x=1768562138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnuBzUiO4MDRfFQ4nmkFijV7grhObnxX1dTyGMCbkWU=;
        b=lLo4Yy+uWBLNDel3yr4FVZk5W1MuPBMfBMd0WOXllpt0AwUrr8XY41QWJByWsBzEJH
         fuWO2fUMugzcIGUbFsjeZJc3aZ+/nkzdDbkd/7WCRiWYyR+sgspym5o9BSX7v/n3JaWR
         H2FsEU2MgVduxaMAbuwrVorUgSdZF9/FVyqt+l7UyhWssDEQnV6OgEgDTlUM4Ez9lzIC
         ug6RXBazb1+B4cKgcOE0KFm8l7bO+FSxM0zYhVk/BR9+yp3abF5FH+iN6m2gDs1SE/oD
         C2HyCLgtDgaFux2N8hMILOeJ2JX62uN/m+9nYPtpEfrf3+y69DWpgerlHUdxoOSYs+i7
         hOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUajUGl4Hpq/RukZXXm2Cj65BchIdNwo0TKh/cldKhzY6EBipow4TaKbh4ZBwjxOneSkYxmC9p1zkKS@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrIgbqU4WxIDRfKom1sRr5dshBP6eR3LVOko2Bp4NDTZVGAGz
	D9rmzPab4q45kTR8hs0jG2FHbCy/YMnO9rfdon+o/07NlmqbK5X6GsuGB9P1R8rqb7H7HQvqi0z
	Y6xKh+KlM9BMi5aSZ+BuK+I6pkeXT/zs=
X-Gm-Gg: AY/fxX6SV8QhIdz+AxQpz8Z8pKkUvRtOt9F6d6/9KK7YeLAd/kEdBVlmHccA/Z/t0bn
	vAtKiuziu3mQWJ8dRbP2yFK/h/9wEXBMPKJGfk5nhqNyhLqIYw2Yf4pwXcwYdtpDbnZb1Jg5Ba2
	didiwpvZRCkBE7l4fusGuXLduGb8VF6SJwrYBrV59hkOy7JqTg9hOJ/GOHDyVYi3dSsfTZpYp9S
	vUfWKUzqq1AslBn1pnNK6ynR62PfvfZjOAer8lLc0tW2pzPiQg1ZKTww+sIeKckevDHPwDJsAmn
	Yifo5XrmPJmaCHx+ghsW7zWalOw=
X-Google-Smtp-Source: AGHT+IH/xBA6vYrJVLL8il/zkc+YXxT1tVSY2UMZt2nSpI2HUjiCWySnfvMfDgm2+9HpZM/FVLniETx8REbloQcvMes=
X-Received: by 2002:a17:90b:4b85:b0:34c:fbf0:fa55 with SMTP id
 98e67ed59e1d1-34f68c4d727mr9471810a91.21.1767957337845; Fri, 09 Jan 2026
 03:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767818037.git.foxido@foxido.dev> <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
 <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com> <670cab36-3d32-4769-8a3c-a5d3e1bdd74a@foxido.dev>
In-Reply-To: <670cab36-3d32-4769-8a3c-a5d3e1bdd74a@foxido.dev>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Fri, 9 Jan 2026 13:15:22 +0200
X-Gm-Features: AQt7F2p-AFS6Q07HimFSYPCzE_vdBz3-9nvlSC-3b8ZMc8xPjyKQHdBQL8CrOto
Message-ID: <CAC=eVgRHu9UzPyTMcWZFGAwo0+6wO+v-iuqmoKmznj_kSPVL=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pe 9.1.2026 klo 13.01 Gladyshev Ilya (foxido@foxido.dev) kirjoitti:
>
> On 1/8/26 23:48, Kari Argillander wrote:
> > On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
> > <snip>
> >
> >> +impl DeviceId {
> >> +    /// Constructs new DeviceId from GUID string.
> >> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
> >> +        // SAFETY: FFI type is valid to be zero-initialized.
> >> +        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
> >> +
> >> +        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
> >> +
> >> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths.
> >> +        // Also we leave last byte zeroed, so guid_string is valid C string.
> >> +        unsafe {
> >> +            ::core::ptr::copy_nonoverlapping(
> >> +                guid.as_ptr(),
> >> +                &raw mut inner.guid_string[0],
> >> +                bindings::UUID_STRING_LEN as usize,
> >> +            );
> >> +        }
> >
> > Just use while here so no unsafe is needed at all. Then probably patch
> > 1/3 is not needed.
>
> Overall this operation is still unsafe because we are constructing C
> string in FFI object. So for me avoiding `unsafe` via less readable
> (imo) loop will just mask unsafe operation without any real benefits.

It is not unsafe if you also use pin_init::zeroed()

        let mut inner: bindings::wmi_device_id = pin_init::zeroed();

        let mut i = 0usize;
        while i < bindings::UUID_STRING_LEN as usize {
            inner.guid_string[i] = guid[i];
            i += 1;
        }

you can then also remove 'core::mem::MaybeUninit'

> Ideally this function should receive c string and just validate it's
> length, but IIRC I had troubles with build-time validation of C string
> length
>
> >> +
> >> +        Self(inner)
> >> +    }
> >> +}

