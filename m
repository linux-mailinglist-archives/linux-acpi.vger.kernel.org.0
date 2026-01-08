Return-Path: <linux-acpi+bounces-20082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22DED05B2D
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9A3D302AFDC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A32B32571F;
	Thu,  8 Jan 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4IuGTHh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1F296BBD
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898022; cv=pass; b=DxpdFnrWu4QuG7kQVcT7wC/alzlhaIaUtVDXq3FRnZFh5g7mvug6ePfVi/w9vyY6PdVqQ7/a5ayf7qxgnB2jPkxmwnpZJ23XZHAnjD9Nu51b3ZjgnKuf+V2IM4UQR8+/dcMsPJc/Y4pyZ6A02FXFXtsVvl7VoF9MmOoWkjNpY1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898022; c=relaxed/simple;
	bh=9dsp03vsh+jcxxLZ27Fffy/Yxt8RGmG/mTJwiKpUiiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhQ/nN0eM3uaYvfQPMsznB0Vco1fVmSQvel1012PPrDqWUlPWYviBlRmaAqkmEmeWmYDJEL3cL0WjjT+TvuO2ANKEwSlQcdQV+7bloah2n7C1P9iAwkzbQW9+qZ0gef8esJ+an1G/cGvpDmXzXysg/CECIkvAxshHqDOIn8Xk+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4IuGTHh; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae9f7fd413so65231eec.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 10:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767898018; cv=none;
        d=google.com; s=arc-20240605;
        b=VRSKvJTbVvcwgkkkVSZwFNhU/2C6YDxsMdZCuw9R3DuerfMQrgRxPx2MfNt8suXU/v
         tjhGbtVUhjBu7/oailELRPOT4MifEvzH9iWGDqFVQ8+kZax4a6QlaUFwY+jXxlHPr0W0
         5AEQd8DwK9VNRFlpGuacZbrFRWOTSvN5utvv5bGRw4oWctUoQNOLpg6zQg39bpKy6Z2d
         OShY2h3F+gE1kUzBSBIlTaCeNw9lprYPxC9YtcWqZlf3P2Wt2uJs8PLR5Kur/tmbU1VH
         jB0FA/UCZeXpIE1OVXmxBap5A5ITD43z358frizQ2f0w23ioV063SgDE4/1A2smQ4Nd/
         7GSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CovL4D9IWtlZK4zyQedETxH8Q9w0iNTyULXmwn7D6wQ=;
        fh=koOAQjv1wFHKNX97SvEdar7Pz0EtrFKJQMogJ8EIOOs=;
        b=LZRAC4EA1eVSUqZ2lK1rsy6tqdnmQVVafUpi5LkTROKFFRaUx6Ck+7eilGwgm8VKz0
         VhJwKRszS776U6N2xds+JbDHSGtR5TlTl5aIiVNrAoE0TxCXZYlulGtWz2qCgJ1HwL0k
         o9GvbJT9220bCH5VSoDK16c03ncdaRLO53PvFhmSsoOnQZTt3jKDbV3AqlSPCAjyVeOU
         ivjBkw7VpspfPMM4p2noqRZyOZUzItflwp7OiBAPrpRhIPppctqxNQVBHEfIl1IN5BtW
         lTtWQ2rCiRMESCH58mjb9vss6BXdDLe7zs2Tb+sFcBWpSoy+3VToDZwhI7Dagz4SjlYf
         w+VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767898018; x=1768502818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CovL4D9IWtlZK4zyQedETxH8Q9w0iNTyULXmwn7D6wQ=;
        b=P4IuGTHhbFZGxKiShnqfG1k4RbNk2Ncq3UTHJEXdI5H3mg2fFuwp0JNXkLdOVVg/k/
         Axx89kspInQzcJIinfqji2bWPWJ5HPboZ/BOH84e1MrjmkJPyKnl4IZXjfFkKK8vIUXK
         xB7wPFCQRNFLQVmX7sczzRY8+BM1RIVN57YWMG1DQuR0FDKq+bCwLCcUvYBernz3lOOQ
         mPgCz7NROIK8lu9znGHIFLJN0uxN001n4vqYA+Tc0dpw6A39OihQQuqaTu2znqFDNCvP
         iajpnhotOMXjEQxXnN/8OajuKY1zUzWo4FIWaHSPF3BkfxVBzbOCzvtdYm8hnGkEqkjK
         /GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898018; x=1768502818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CovL4D9IWtlZK4zyQedETxH8Q9w0iNTyULXmwn7D6wQ=;
        b=lyC1HM4a+4pmQ7WRqwGpZOutFoTjFDYVQQOKpySNdp8srE5DrxOoOLWGTuQj8RPOkP
         I8r0/IvbiCUd8heVtyRFevGyivnDFo+OUiwYmd4TCmfh4OH6QLxUClsMCnB4wDU2cR7P
         zN/ZndiNDB2JN/oLTZguFWj8+RfPfPDM1cGMe4E7CZlbkpr2aE6uxTt2QXrIrY4t86zF
         lg/DVYIMc7gsWHY08bKi3UxwsCFuRF19h3DO6d+KYHanXr3q08PS5fHYjqiprt3gGqWg
         ajI+D/CZuK+7zss2TrznI3NvZV2llwR9B8Jc/tLnD4+o+RVU01drEasveNTe6zG6BoDT
         +7ow==
X-Forwarded-Encrypted: i=1; AJvYcCX8jqjtUI/NnW9z3t74behgcL50QAjX9cXDaK4D1h8kACkaB013aO+KHPo7y5W9e0reXSKtViEsnZ3F@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPzoqMYChL3VWVfOM+M8qftYASQiPaJ4OlckVGrMVAnuyG7WN
	G3aPKsSoY7w1ZQdKq9KHesniSX0Qd4CDq3DEGjiz+lfKJVudewJuHEli/VoFOnPqWQr1/J+8QBj
	a6+HteGuW+ORbkGhnl6U3NGaanyLARc8=
X-Gm-Gg: AY/fxX5Llku5Xz0StVHWKoO4fRfNbW3phT980HVn4ZIU29ECfYd24KAhn36l7Sa+/f4
	T+1OMY8l+1Y+3z3PSq2V8cuF6lx18JkytigqlZJKQOumdReTWHRlXjYWaprvtj2KE+OwH/3ruCT
	FKv0jOWwZ9Y7oZPCDtcNpCgf+xn8+gMB5WhsAwpQUENyISCni0kMgpfjcvsRbM3Cvogsx2/hQ8T
	97twSxv9t6u/qlBsMdERx2IMA43Ea1VzfC98/vA6Y6rGBTwhyTs8HRUxgxinpGvhgU+dEX+pG/q
	25NdRV2EJM2txROrAvOXU1OIrUheneY/5+p8jnzK+o60q3lyjzQzmW2kEzudJ1BfbFqk/r4GEjY
	lLE8wJaap5g==
X-Google-Smtp-Source: AGHT+IGu9T2XibzVKy8btuxcDZZhMyLH36+M8tNqwT0uSTo7qZFAQAMpI7ByxDxoDczkqic0/esmI4Vvqc2uRrIB7lA=
X-Received: by 2002:a05:7300:1483:b0:2ae:5245:d50e with SMTP id
 5a478bee46e88-2b17d2fd32bmr3273953eec.8.1767898018039; Thu, 08 Jan 2026
 10:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767818037.git.foxido@foxido.dev> <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net> <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
In-Reply-To: <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Jan 2026 19:46:45 +0100
X-Gm-Features: AQt7F2o5ZZFBECo7tHTbw4EaUh07Wub13m9AN2oeE3UmPHevRhqMf_DCW1K3HAo
Message-ID: <CANiq72=TAXwjjxFiKiiwh9m_rRK_yUVS4b+2st=QJWErz5qTpQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Gary Guo <gary@garyguo.net>, 
	"foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:11=E2=80=AFPM Gladyshev Ilya <foxido@foxido.dev> w=
rote:
>
> Hm, I looked through ACPI_FREE() call sites and acpi_evaluate_object()
> implementation, and it seems to me that the acpi_object's lifetime is
> the same as its internal buffer. Overall, it is indeed managed
> externally, but acpi_object and acpi_object::buffer->pointer live
> together. I=E2=80=99m not an ACPI expert, though, so maybe I=E2=80=99m mi=
ssing something.
>
> Anyway, the current Rust setup seems fine for now:
> 0. AcpiObject validity is guaranteed by whoever constructed/passed it (C
> side for WMI abstractions, for example)
> 1. You can only convert &AcpiObject to &AcpiSubType (reference to
> reference), so AcpiSubType can't outlive AcpiObject
> 2. You can't steal the data pointer from &AcpiSubType either, because
> the Deref impl is "logically safe" and only gives you a reference to the
> inner data, which can't outlive AcpiSubType's reference -> can't outlive
> AcpiObject.
>
> So for now until AcpiObject lives _less_ than it's inner data,
> everything is OK.

Assuming this is correct, this sort of analysis is typically nice to
keep documented as as an implementation comment (`//`) somewhere
(instead of just in the mailing list or the commit message) -- would
that make sense?

> Using an enum would require keeping Rust's enum synced with the C side,
> as well as implementing some simple but non-trivial checks that the
> `type_` field is a valid enum value (and the valid range isn't
> continuous). I think that keeping it as an integer is simpler and better
> matches C side.

If this refers to the `ACPI_TYPE_*` constants, there seems to be a
comment in the C docs that requires it to be kept in sync already with
elsewhere, so perhaps it could be reasonable to add one more place to
sync? (Though I don't see the mentioned arrays from a quick grep?)

     * NOTE: Types must be kept in sync with the global acpi_ns_properties
     * and acpi_ns_type_names arrays.

Ideally, these would be actual `enum`s on the C side and then
eventually we should be able to have `bindgen` generate the new kind
of `enum` that keeps this in sync and generates those checks for us,
see my suggestion at:

    Support a new "enum variant" kind, similar to `rustified_enum`, that
    provides a safe method to transform a C `enum` to Rust.
    https://github.com/Rust-for-Linux/linux/issues/353

(But we can't do it just know, and even if it lands in `bindgen` we
will probably need to wait to bump the minimum etc.)

Cheers,
Miguel

