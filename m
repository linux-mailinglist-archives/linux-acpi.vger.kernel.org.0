Return-Path: <linux-acpi+bounces-20072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E2D04642
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69B634A721A
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E8547ECC7;
	Thu,  8 Jan 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaFPbQxK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14D047DD51
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767882215; cv=none; b=bkJgqfzuQkAGj1Nfjo3EtZFq2JyVall1WQj34b1MIc1mG8IbspTLbbS8a2CPxi+8Bdp9WSkRkrhCJSQsPuDCA5gLWn/1fgxjC/vUplHjvDqBvz50H8tDttGtc5So6NVxSEqUDgt/YJ8oaxKLm3r1OTdfIQa4AvhuDB6bcUcApRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767882215; c=relaxed/simple;
	bh=zlRVwrdSOVY2CZZdXveBBVRP9u//BHqta1Ol/lsP+bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHwU3CkwmCR/iWsVhEoH8Rvse9OIDEriHa2O4mbklDTMN+Z0ar+pU2engdWrrXMzVVhTWs0wDVQcr1m4ZljuPG4vJrm7JARyq7MmbgfJ9tRfNp1bSHUkpiPOdloCeofUm6p6kZGYpdYd4K/qYRTSvDK8xFzElaT2xEulPTMswAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaFPbQxK; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11ddccf4afdso226325c88.3
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767882213; x=1768487013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlRVwrdSOVY2CZZdXveBBVRP9u//BHqta1Ol/lsP+bA=;
        b=eaFPbQxKPjfeQzoH2fyMm84zsJGsMlLadxbpA+GbZlK3yaF7YNJ0no8IAmm85EwCGU
         cVgahHgfuFg+onp1K4uJh6eoW+i6Jx0sZi9skB5/s+ceGSqZhHZ3O4/oEloXBWVBjZHX
         gUe7xR0uMOmAnnlzS6HFWhKDK7OiKWxs4lU2/GpaTOp4JiZDfCDm3tC39kMCCicBUJ1/
         J42EHotYW/1nGRnez0sxebqjlf7aegRCqgee4+6IU0C+BjXSn5mi7fo+oPrRFyhnougD
         5Tat0FPzZIQDIJbJVULVEdmyA/alW5Uewp9cJfFJ81avmAGuOUFvYAQNt2cWLiz4ip6c
         Ksug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767882213; x=1768487013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlRVwrdSOVY2CZZdXveBBVRP9u//BHqta1Ol/lsP+bA=;
        b=b2R0azkL1o1m72s42Nri9JWRqrWlLe5zSz3nRU0OrnUSsaQAq9IKeDLD3ee8eefirA
         mQJ6OCD1IZBR3VaNN9cFspmLabwzICbQhi66ozWDq4OT6LSOnUr96ZRGLMRLUOBtok6r
         K8b0PL+ZAHN8XUY0iZ3eSoXztXyNvGJ5VGcD+aVgAtBKiDRMMP8WQTrdlFoQk91a10Iw
         ZD5FVOrqAxDeXJxV7lpWpfeyMTJZ05Z5rCri3BPXpUhs/e9nvBkVAEvKsFHLMbkhMziT
         RM+yLlX9NNrT4r4DixVIoqdaqBENJwHmW3zbMpI9XLOeqFQuDQFjIUIFSs9NKn0GNmjF
         rvNA==
X-Forwarded-Encrypted: i=1; AJvYcCV5X4Sj1x0XpYBtkoNOvfkBPkWPpsQY1v4cIp1lsY7TT9A8+FTpd5mwUUjQr9xm2UlimaGzqBGBYMqB@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvCSiw3dhuIbl8jdVZwn2OEIinAIW5bPJGVd+w8sbgSRTKC9M
	ykEcHwG3QnfO7V616RgvJJlHZjx4YjePPukQhxL3lXhvUS9YC8qkKSirFV/BRi8EXAT1f5HgJcb
	/hPANZp995BdEWOhnWK/A39oqw9GdTMw=
X-Gm-Gg: AY/fxX5XILJNev0lTUytsdavYm2lo1qqziTqIwgamuHZ3dww8JCH2CXJsK5sypkvDG2
	E5C7nvOm7GFIMi1+RLUd/KDgFBcTs8FiwmfW16UwcytMyczci3EyWwtkixFjoxptUuNEyNXyHHK
	6QT7Jipy+X8Cqd7e+/25lNhN2thnQvPssSH8Amlg/pDyvLJKMeMwk46xCvVlEAmFjAiU6r7cSbU
	4FaZqs3DwV6SMgvtmFJyP3rJq2zJ8isX/hla4PsPsAhebZkv5T+ihYpVCgghOBilm9xqnl8wePs
	VsNWob6Pd96DDhS5MLBFkoZszxouRx87QHQKWmTysfJuIcec3uRW3/lrFoBMacwjnSFm35lNISv
	IxZWM1byO1B5T
X-Google-Smtp-Source: AGHT+IELvdw05oHTCoWO5f2S/QQ6TUxWIQWCWu4IsDvpm54xC29qHwlL5BYupV/nF2K5C4whI2juYLIRDu9iKoVWSJo=
X-Received: by 2002:a05:7301:190b:b0:2ab:ca55:89bd with SMTP id
 5a478bee46e88-2b17d2e3950mr1768661eec.4.1767882212773; Thu, 08 Jan 2026
 06:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201155210.22710-1-atharvd440@gmail.com> <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvD9T1y2uGq1MtFafQTRUJf2oeKEj11hAZ8gv5J5OM1w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Jan 2026 15:23:20 +0100
X-Gm-Features: AQt7F2ol0WqSmL0Fjmv5tDMpkcuK4WX0YIFIYb3YwUazpolDVukxJsOHTQb7jS4
Message-ID: <CANiq72=SEmPnP8Nz2_PjD_HuOV7UR5+WWJRBGoJTt66k42rqMg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: acpi: replace manual zero-initialization with `pin_init::zeroed()`
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Atharv Dubey <atharvd440@gmail.com>, Len Brown <lenb@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:00=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> A Rust-side ACK or equivalent would be welcome.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

