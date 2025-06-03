Return-Path: <linux-acpi+bounces-14083-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A215ACC713
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDACD1732BE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42E22B8AA;
	Tue,  3 Jun 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLuJJq01"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173491E519;
	Tue,  3 Jun 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955373; cv=none; b=TR5TdymszmRAbW+Wq+g7gjbqRAWQLfvIouSQG6DZE46wu7SMAiIgJZsqJUbmrtRF7DodzHeNjvcge2cniOcc0DfvN+dcN1M9HsXWR04lFwQbbcGtJEDCXTx9Ao5aoMehhh64YI7LVjJlrBkNEFK7jvkBqhRWuyXaIVUuiYqwjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955373; c=relaxed/simple;
	bh=tnDWURJxBu29MAhAQ5kBlMknFDohQuT7/EPE7rM3kz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6uldmVdBZT1t3KULlxin3blqqkTE07fUmbX5rJ6v2CQDepJvaBfLvxOier93VkHI+HQWhj6Y8G54ngK+oDaH6o4cM2e+dM4ISq+cWkET535XJr+Tf4nDgC8Y/dmaIdDMv0ZKngOq9WkONcs9Jv1q+u+PI1WM3Rc6mVPDNT2Od8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLuJJq01; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87df8fa1c6aso2986439241.0;
        Tue, 03 Jun 2025 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748955369; x=1749560169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqCgqkVkHr1OUaJdWiHVR1CiDNceuGwFWHZhOjkI94s=;
        b=jLuJJq01tCnbXvPzNdTtchnf/yUnWTvMElLKJ7QwHUWNeTywJGSUQXitj00tpRuvAW
         /T2/a6NPrnu98d0kYWuqFUzy5IJFOFrx5MTsrL26slhFaMvX8KwBsQv+MU/o7V21qvHF
         6dhg7OykhqotmFjWv+R0HelzGAnxYJ8ezLkB/ZyDhydaRhLnk8Xf6mXK/6qAiScAJIR5
         iHXq/8UQmsnu4z+BSQm502laQOXAzeS9x6JpPy42becZO2WXR/IpxZ5LqbjGnXGgFU3E
         yF0VGE88H7U+BykGnAb6FjHr0gkicYUkjP4mQGlhcIbUmUaimIm7Lm3gwWEXZp1H40up
         kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748955369; x=1749560169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqCgqkVkHr1OUaJdWiHVR1CiDNceuGwFWHZhOjkI94s=;
        b=YJlrtSTgXfJY9pZd3AD2FU/edRu+MYyHB2hp7N9EmNUf6GU+ee0Mb9NvpNNHsWm2bW
         Mm5mfeOCrfZZqtdXIaij4P7H4R/QV97/4IyMyzX8W7BE2PQ+TvN+kRNHHrtrJQEuO178
         RmG/M7NDjcTNpfJ++9abLvcBYIULSK/J0DJOVfcmb9TeICAkTN2hoCS4YfNFPC5YpJXB
         vSwUVCfm+xnQJsACYN9SmA+54pZerk/W0jIu5CZoVzsebOkDK1FrskF1/Rxkk5j2l8of
         +5DkW6VWntRtZiJniQjJ3LwzCj3YFjYzvC3763VawgXTjrFcIDdepLt8ruO9ZNPryo0N
         Hvlw==
X-Forwarded-Encrypted: i=1; AJvYcCULN78s8J5ircFOrvYwc+/iAO2toRTuRI3yLBMQFgbrvPObT3RBbsoAN0dbR4NBP25DXLvcGI0V0hfg@vger.kernel.org, AJvYcCWO72MYBG4ST+et2VfK6hpzDRN+qhS2iyRCL7YwfK/E5FFip96kSEy5bwyLyrw/yvX0ClWRpkQS0t2rMOU4l5g=@vger.kernel.org, AJvYcCWt278FSDHUpM/IJkknSqdJkvMZ0o/tM1Nc+bYy6Rg3QhuP927dF2vCuSIfLhR8AsGgfm+L7LsfoI5cLnSI@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaAxKmJ2719cx5NiZK//iC9ed1yWDlzJA8QCJiuqBPAq28+CP
	DFTINJCufKo+Bwxvzr6iNn13fCpSf4zAuVhKZ1OANuXzJFCD1CA8W7gPZBAaZNId/1V3fZIiQfP
	/4PvlgDccIL4nkqX/HLVPhR3Lb4OquQPjDFVg
X-Gm-Gg: ASbGnctkHO8fih+EkAdPrAqIKSucFm19MHLbmdSYyarGtf0tVrmqMgUuyB+qE7Qzplb
	fOExo/1NX6oWtS8co9TjNGbwaAawg9Z1Z3EK+p7qArc3SsvfE1hOkTN1rp4lLd7ujjwZSVkCEUC
	i+AC4nPKDKRwIPJUuHohMXEbYX+sJE3w==
X-Google-Smtp-Source: AGHT+IGkCU9q/jGCgYkKnk5w4ox9fP/ZSVFfzHsSXPjA58eEG+hcpGo7g7McYHy9QFNonYwedeyh/W20kx3txlIrvG8=
X-Received: by 2002:a05:6122:1d11:b0:529:1a6a:cc2f with SMTP id
 71dfb90a1353d-530810d7929mr15272934e0c.7.1748955358373; Tue, 03 Jun 2025
 05:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
 <aDnD_Bb3l6GiI_8K@cassiopeiae> <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>
 <2025053111-anteater-balsamic-8d01@gregkh> <aDrWCBAxPnu7VY0P@pollux>
In-Reply-To: <aDrWCBAxPnu7VY0P@pollux>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Tue, 3 Jun 2025 13:55:47 +0100
X-Gm-Features: AX0GCFvn3f5JBPkgAzmRxRxHC9D0futeilp6i6Q-qO5HuZk4eVci7qT64RWQ48s
Message-ID: <CAG7QV936MPp7RLH_D6+K8mRcgPdpNsGFWF_D10b1C8op7YRtqA@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Alternatively, if you want to upstream this dependency already you can send the
> following patches:
>
>   - this acpi::DeviceId abstraction
>   - the glue code for the generic adapter trait in rust/kernel/driver.rs
>   - use this glue code in the platform abstraction
>   - add acpi support to the platform sample driver
>
> This way we can already validate that the code works correctly. All this is
> required anyways if the I2C device you write a driver for is on the platform
> bus.

A few questions if I may:
1. I committed to 4 different files: `acpi.rs`, `driver.rs`,
`platform.rs`, platform rust sample driver.
Should I commit all of this as one commit or split each part to a
separate commit and send it as a patch sequence?
2. From author's point of view, as Danilo noticed, `acpi table`
abstraction code is in general just copy-paste from `of table`
abstraction code. How should I explicitly mark that fact?

Thanks
Igor

