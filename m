Return-Path: <linux-acpi+bounces-20154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11CD0F8A4
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE967302FBFF
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0734D38F;
	Sun, 11 Jan 2026 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxuE3rHf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267E34CFB6
	for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154260; cv=none; b=RSOd/yS1A2rntCX9J0tx/khbKz2Yc9ihUDvil7kNzpt7ofE6e6k8jCrFTk9UQBqtxJz/jQmlmOUW65bDPYiMmGI1GFHDMaJOAxii/ZEMp0A/43x77jYhUJUQ6SlrLe0gHTIZXlCpN/XovC/GIEU2oECV4zJ1yr7FDG3nDfJubMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154260; c=relaxed/simple;
	bh=fbJK7xOI/xq6Tar8qezI6hVv8dspBtPq2Jhl4huh3nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcbtxslvo3zoLZGEoVeBcp/TNd+TTts1MULo4jxJVwbXEdBiWoZ18ip3shPBHgocOUMcpbd87fDsCPxDWYzBocRpQAEZeDv3biwqWdjRN09C5tnqZzkM7S9Zy5Fx3a28h9ENsA96yuemmttzyIw6DsFM2Mk4ZbvUzZMRaxLNjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxuE3rHf; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b1769fda0eso141117eec.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 09:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768154258; x=1768759058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbJK7xOI/xq6Tar8qezI6hVv8dspBtPq2Jhl4huh3nY=;
        b=mxuE3rHf/Gdpqbss+uKujK4jg/ftTr7Aw1KdFKgW5ryvOT9GdvcAR5rqHFoIt43CtJ
         QZe23wYie35xSFIXf/ds91Fn0KUyOiIwMALy+Ifpgu1k7QTz3yGgpYbf+vqZJzlpk1TJ
         e/lp1LWqtmnxMfGH0VHJLea6Ou230ZRKqlZwM7si+ltca/1TwgPJpZvoupYycrkDm3XH
         XmpIqD4rRe7AFTm7khy48+Sl9PHaUQF4/Sxzj8JJX+qhQNozDttPbJ+r2c+I3FG/YWuM
         jQKaPM/iXzh0ZbQt6kA/czIwi/y0OREq91O2rbjloGOg+o0arJo5F2Y03u2gP6yac6uv
         5y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768154258; x=1768759058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbJK7xOI/xq6Tar8qezI6hVv8dspBtPq2Jhl4huh3nY=;
        b=Z+Wh552XSSm4fiO8vSYs/8OCOlXYD/SKWFA6/89gluafcpkZDG+mzE7ArjRZ/w7SM+
         voYQp01zuRkFjDlaIztzMCepjo0jT8sxiG+Ur3T1JIblFYx8eqDR9gNjL8gU77WqVfgo
         oSQdTcGBvjQUPFXVT8enZK8vLbSYHZnBljsaU5n3GJ/gCNBr8XVyqN2LslxOYa7HaGp9
         grF6rd27p+Fs51BwWHFJ+fvfL102QfYoHuWfR4VgTLtkE+uddQDeC6L95cnagEc3lOXP
         39pcT9xIx1AoibwGpn8Si+5Qyos40ofjW7Y1lewj/KsKOsOchIvopA93L47tZ/aaEqtk
         mvJw==
X-Forwarded-Encrypted: i=1; AJvYcCWxv/MvA4Ypg4Ye+3KAHLZ4S8H8tHHsBI9jnDtvcjyNfVzCrE3AUvQ9nCuLvh9QFZQoKuj2wfkE7wRm@vger.kernel.org
X-Gm-Message-State: AOJu0YyKWgQe9jp9FqmtszByHj6HtyCKPIYSJQhZoVPscySN7RqqQOFy
	kovNv5/IcTzWXRalWVxmUPehrxv4Ddudvv4WXZ2B7jcAzpY3mjfZ8EFBLP9bnfNEo6sRAZuXn3X
	VZG+HsbrDphuIEFR58lP/7OHTUp4MvU8=
X-Gm-Gg: AY/fxX44Dfc0V6LNah9iyEE3LtO8LyMYMlH5KCODsRW2CbgXnADOS0huWTEm4eomv8y
	Al1yzeBaQumFT5EBdqk5MrcRKmaGAjWLvMZ7AomVdov9VWSQNJw6sYHfwdhyTlkZk5SMw9Pa44J
	lGWa2qdGA8xU0E32HvRR6Dim2XXDxmAfO4Mtgg57aBYqoAWqS4Uxv0znwWG8M2TRvfIdx5V/1It
	M/I2hGaChqAozw3L0dDLWr6LXrP7DC8FFXGU8pMktbi9V4XzmzzjlMww9A+SCwAO0yyshdbfStW
	FYeO5DaZH4LYSVaXCMAhBJGfmAw2MQkiabDcRb4g4MhVyPrefUYSM6Qxeaqk0JbY5xr98MzFlUc
	2kXTn2wSK9UJP
X-Google-Smtp-Source: AGHT+IHsUNDTkZWXPnDKsokQQfGSgLB5pLSBd31BRF2afyEHDMLGxpLMw7U1an74C6nf4v5M3uxlrayIC4FhizbbcvI=
X-Received: by 2002:a05:7301:fa0f:b0:2a4:3592:cf8b with SMTP id
 5a478bee46e88-2b17d23fd01mr8560661eec.2.1768154257822; Sun, 11 Jan 2026
 09:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767818037.git.foxido@foxido.dev> <05261e88ac8503e2af59d703389d94cc15f4450d.1767818037.git.foxido@foxido.dev>
 <20260108132141.6cce4827.gary@garyguo.net> <7b8130de-8096-4fcb-be84-c13209638b25@foxido.dev>
 <CANiq72=TAXwjjxFiKiiwh9m_rRK_yUVS4b+2st=QJWErz5qTpQ@mail.gmail.com> <b8e2c3ed-7db1-48ca-8dc8-64dfa437c595@foxido.dev>
In-Reply-To: <b8e2c3ed-7db1-48ca-8dc8-64dfa437c595@foxido.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Jan 2026 18:57:24 +0100
X-Gm-Features: AZwV_QjkEeEeUhKFkM_68O4DnxLwqPiN_AxlqeD2e8VEqMZVrLimsVfRWFtZI4Q
Message-ID: <CANiq72n27gF0e3r_pZ_6ZD7EBhwCLghFkQtLwfApEGCQo6gcnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: implement wrapper for acpi_object
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Gary Guo <gary@garyguo.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 11:57=E2=80=AFAM Gladyshev Ilya <foxido@foxido.dev> =
wrote:
>
> If I understand correctly, acpi_object is something untrusted in general
> and broken hardware can provide arbitrary _type value. So ergonomics of
> enum solution would be kinda strange:
>
> ```
> type_id() -> Result<Enum> // Result because it can be invalid
>
> // ...
>
> // '?' here makes it look like non-trivial operation
> if x.type_id()? =3D=3D Enum::Buffer
> ```

Yeah, I was mentioning the `bindgen` bit because returning
`Result<Enum>` is essentially what we asked for the generated code,
i.e. we generate a panicking `From` impl, a fallible `TryFrom` impl
and an unsafe conversion method too.

Whether that may add overhead or not, it depends, of course. Sometimes
the result (i.e. the enum) may need to be used later on in several
places, and knowing statically that the value is in-bounds means there
is no need to recheck anymore for that reason.

That can actually mean reducing overhead (e.g. if checks exist in
several APIs, possibly defensively) or at least reduce the mistakes
that may be made tracking whether the value is valid or not.

But, of course, if the value is not used for anything on the Rust
side, and is just passed along, and the consumer of the value in the C
side do not have UB if it is out of range, and you generally don't
expect that to change, then checking validity upfront may indeed not
add much value like you say. From what you say (I don't know), it
seems that is the case and thus a newtype may be simpler and best.

But if those conditions change, e.g. you later start to want to
manipulate the value on the Rust side for any reason, then it will
likely be a different story. In such a case, then we shouldn't be
scared of the ergonomics of conversions, i.e. it is fine and expected
to have to do that, which is why we want to generate all that
boilerplate in `bindgen` eventually.

Or perhaps you may need both options, i.e. the newtype, and the other
one, depending on what you are doing with the value.

Regarding `ACPI_TYPE_INVALID`, yeah, it would depend on what is used
for. If nobody should be calling a given API with such a value, then
that API should return `Err`. But if it gets used as a useful marker
value somewhere, then it may need to be a valid value and thus return
`Ok`. If both cases are true, then perhaps again two ways may be
needed to model those.

Cheers,
Miguel

