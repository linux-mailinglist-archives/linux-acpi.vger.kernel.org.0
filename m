Return-Path: <linux-acpi+bounces-20085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3631D062A1
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 21:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A02D303A382
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 20:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C132937A;
	Thu,  8 Jan 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/5z1Je3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23660218E91
	for <linux-acpi@vger.kernel.org>; Thu,  8 Jan 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905311; cv=none; b=jCXoN4QAaD2fpYSrAJRtph9RRipaDYCWYZeTlYrFUkeN7SPfE8Q2XIV9os8EoOohP6bc/IO4bQn9QUzU/FGsl1ez/XFNM+8XcPu+STzYwlTwMg58D44anlLqazW3KyrRV9TY5s70wjE//SCt+wfXrrwbxKljmuZgaTZXzY+h+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905311; c=relaxed/simple;
	bh=Ai+1VqmHWTtzDAf9XcManam8pxSl3gVLCwxDk5EXLsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9qru0pHN6k0lrgWSPtc/ACthneIwcDt0TfEBZ8uRXiRArnNtTHY09AA+C6qSHdGjPOpqlXndgeM0WCn7jr1ksH8iiBHAMKfc8dDwLUyRu/x2X8UuBBvdRIT61X7Au47gWkuBp4n93ZbwZrtco2+hFPVXBgp/WIiDHuh8ONGUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/5z1Je3; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ce0ef9d4eeso1559566a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767905309; x=1768510109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OBTSY1EEOdxfKcvbNf6L/Emq8mbP/mtnJeN4bCR0OXI=;
        b=i/5z1Je3IorTpPWb7049OP2pBkOZqYxMuIVjnyFxV7vIOKwVwWWruR/R7mCoeWQBFU
         Mjfmg6YdN0UwYyhZY4m4aOlAFIdQfwl+Bh/hE6dWk3sREyMP9pI3TSvhVg8M3n/VNEj0
         sBKgtHaEMpRz0tYd9WUg/iCKzU9+Nc/G0pvDbwYWv9QgWFnoCb5rVsky9r02dSwjg0B2
         Ag8B52k19nJHmKuwL+KObN5opL5wupiAlW4imdV/L+pYBpKxppEu2vyZ5w6M278gaCOM
         CY9aExB6Dblq+XlTD3ocvwjKJ66gbTYXkmQ/hK/1WU7/jf9ctQ5tLDZL2tCDOZsuXBfj
         +7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767905309; x=1768510109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBTSY1EEOdxfKcvbNf6L/Emq8mbP/mtnJeN4bCR0OXI=;
        b=MwAx8L8nr8DMnbPQJ4ZnGIpuatiSXqhigbknSR/eKT2XPQYVKchLVyFx4CrWijl+ap
         PZjzhPnlCpYPpWmoYgtZIrxm4JM7piFgP6YdiYy5Hj24KerDt5FFSgUb+8QI+T/sY7gE
         gTdnR2B/7CGZUGXEHistw49B1ZJjx4yhwyf0RxTaSjSv5ytTXYk4RTFUjuDuHTxqEg2z
         tZ/3/Jh54jKlbQnxILX/2J9YJ6YSN2gWPA79N8C01UeCkFZjf55mGGKETZeYwFwTYPps
         A1L6qdGjv41kSgqw4DI9CVBq/jYYQSeI/2NezIUqUgjzn+eDLkOgrGuJUbyrMCgBciju
         0fXA==
X-Forwarded-Encrypted: i=1; AJvYcCWWA4CkyhORDBCi7pd9Wxs2B3EHlt110QFzDczgXIBy+uiUq2tvC9dcVoahe2bWLNE6tB1/dHRwulA7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+Dyk7tpPqSuJkZ7iUCV4BM9WEnTU6wYBH2AszKpcYADKjpjr
	+9eeHNn35UjRM4eZKTnONxTNzw7YZr/AuLRXH/F8f2gn+Z6ySHLJJzEMind1BSQc
X-Gm-Gg: AY/fxX4JEgqb+Meks0pxEs+RpWhH9gvGnc/PdThLIrLrh6wDdUfO7h1DPGt1VOYkUHQ
	GdLPgd52HMf7iHCe1Ej6qHaNP5rsxv3/v6/hSYEjbKpBD7qxas/nmXtCi3yFIv+SNfCLXjuZiVh
	Q9b4eFVd9AeoSONoGa65Wftc5/jX7L6p2C66O099kOZFSH8fWOcVPgB6bdF/nUU5Mnn5vWnj97K
	V+h4z0OxlXrJplLSM8MPWYtNON614jtLOrdPp0/tY9qZbjwayr+QPKUuz0abbnFglQKmSHTlYm1
	VXC8HDl+hazV8X+U5fX8mq6jp7VH7aLmvE3oXF6VzCZJvcz0XhaHYn5WtfngszfPuYq5SqYgBcP
	2s9OGFPWfQEVUMt6xgTr15w6/TfzbmadQJx/4ENlWyDmy50q3OMRwuY7tvNVbE5H0hnSDNAdjSi
	TI9mvimU1/uUY4s5mAI6UBkSEmu7p1BDDUxDC8B24AqrhHwfLBV6cse+Gy
X-Google-Smtp-Source: AGHT+IEWTs2Z4OQXtKHEaAy/urTHnqTZB3YNIm7Gulb9Syh39cEll/vcicoWrjlaoLf4jH819ki+Nw==
X-Received: by 2002:a05:6830:730d:b0:7c7:26e:468f with SMTP id 46e09a7af769-7ce50bcb01bmr4198263a34.22.1767905303924;
        Thu, 08 Jan 2026 12:48:23 -0800 (PST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com. [209.85.160.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee883sm6250710a34.28.2026.01.08.12.48.23
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 12:48:23 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ffbfebae12so920026fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 08 Jan 2026 12:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIADZNHUv5+Lr9837QHONOcmWB5CMGeJbJtpKAGpF79isDjdGlAlrT2uZJ8JTLlKtbbvErz2aWkXKS@vger.kernel.org
X-Received: by 2002:a05:6870:6386:b0:3f9:b172:33e0 with SMTP id
 586e51a60fabf-3ffc098f288mr3727001fac.1.1767905303081; Thu, 08 Jan 2026
 12:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767818037.git.foxido@foxido.dev> <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
In-Reply-To: <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Thu, 8 Jan 2026 22:48:12 +0200
X-Gmail-Original-Message-ID: <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com>
X-Gm-Features: AQt7F2r4y4fMQm-Re3pQui1i037A4UVXW_kQP8DIPLiO0siB7OJeE8HUcxCwU2k
Message-ID: <CAKBF=psOiiakGigJj0Kee3Z5rym41eksSZTgzsO3H1gzUP6DjA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: add WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Jan 2026 at 22:56, Gladyshev Ilya <foxido@foxido.dev> wrote:
<snip>

> +impl DeviceId {
> +    /// Constructs new DeviceId from GUID string.
> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
> +
> +        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
> +
> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths.
> +        // Also we leave last byte zeroed, so guid_string is valid C string.
> +        unsafe {
> +            ::core::ptr::copy_nonoverlapping(
> +                guid.as_ptr(),
> +                &raw mut inner.guid_string[0],
> +                bindings::UUID_STRING_LEN as usize,
> +            );
> +        }

Just use while here so no unsafe is needed at all. Then probably patch
1/3 is not needed.

> +
> +        Self(inner)
> +    }
> +}

