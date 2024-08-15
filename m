Return-Path: <linux-acpi+bounces-7600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835DF952EBF
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 15:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D0281B44
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0419DF60;
	Thu, 15 Aug 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv7HjBoR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191619D89D;
	Thu, 15 Aug 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727083; cv=none; b=poUamoVqiOp0bCZbhXcKsCY1GO0wVcmu1xU45StTw2krgi2uwOCt2T5yKQrZMdqkQ1ahiKtk+fzrIKWG+weY9zZzNOQeU/RG2ViFtyZw5XxyyRJOHGqLZO1EUuDLcTasM+1Uafoq8fXUwLSj5g1Vhw50FK81Iqv2b5ii8X4PE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727083; c=relaxed/simple;
	bh=CDgGq5qU3Wr0Pir/YqVs7Al/PZ/iVw/ki/I4EssR9Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oxh2i9Rki4tB9HqnNUIzTnX64cC0i0ZJR8nNbthAoHD/bwDGO8PGE5xVn37iFspLi6CPDQ1y4zcFxGblVTHXE4RptgdZgKpWif1nnNcfrmWf+0NL1BQP+z2EOHTEBc/45vuJFBrHT9OPKlLHpn7HVTTposuG/qhDYEN4e7BxGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv7HjBoR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso642036a91.0;
        Thu, 15 Aug 2024 06:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727081; x=1724331881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia3t2Va5NtSu3BetvUd2KwI5mB/axZOmAEnZeyG3umQ=;
        b=Bv7HjBoRSkwYJp+afAgm6m9wEWXbr+lydKjFjFAa5HCHVOUCx3KwjAblF6ATDo5AP5
         uXdCWcwcEje2tCelFYELBx2tu9tljmjPvyu8UwUqtgy+eVKJaOr3CCQTjRrIN7ELPCbv
         2Ry2sBgojVaVT9p0tSBJvFSa8Htk27q693stQ4xMvxh6GWyAGxJJtENnRD84oafH59SY
         hRdqHXq8v5F6usr6mTG7uC4VL6LnEhMundc3qYuZkf1ZggiouBCH/g/ZiH3q9DelIa/3
         EhnCpGxXtvpxWKuiVdVnPmFrSGJ0iDvaxMtCbwizePEDPLfzlcXZ7YAU3zLucaHfyuRV
         mkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727081; x=1724331881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia3t2Va5NtSu3BetvUd2KwI5mB/axZOmAEnZeyG3umQ=;
        b=XnKKUyIxCiQn8o/8F5TvfqqXPG22iITBKEbSSkT9jQNXdpbpXAK2PwDJKCreGhqSlz
         I+3Z/jkuY2Zv5j/4fBWhf42DgOlbtEo9XEVlxucD8gvQz/LB+fiKFiUKCQVAmS9oz4W7
         NYqzxXs6B9RjUpSPNlUW06YCiptSlU4qLb2yRgz+zXA8MmfB/K8mgTE1fFO4Oa8MXupv
         GkQxwfKoBeQ4nQEll8ENGWiJr93/JbL2yoscFbJs9MYp7xNRsN6dw64bZEPDbvhkrqwg
         YjqRAs8lCeQZVvAacjIMjbyY6RFr34rBkQKIBULxgsY1t1kfD3kjx/6hVzTWhvBt/Q8p
         52ng==
X-Forwarded-Encrypted: i=1; AJvYcCVO3/J3XugBVcGsbYotU8ZkeeJmM2c9RYCMUaX5ok/0csKBl6wZwezFljuo0v/Np6244SW6BF+S3Ql6YjvCv6F2QTfHaZPlgc9ajOjUdnLzTPhLpJWSNhgV+CNOsc+tydCZsFZA7buLQFEveG+Pge7IKzLHqsDEBtPIrsTeNdhteM3k2CY=
X-Gm-Message-State: AOJu0YyCMo9iH6K0frof48ic4gF7tsxSbEUzSBclENggs20cj3wvd9Gl
	VVfFdVu+RhH5++XbC7RADng9z+6GtDaaUbJ8XHxQ7y7uD+JBOGDSN4UNYC/Nt2FebgGpV+iEZ26
	8d7k8y+MIyGWTrl8+dsf/IrCFZtPTpp2rBwk=
X-Google-Smtp-Source: AGHT+IGSrLrwuM5RhDoD7uxpi1mK7ij3LB5lI6V4fRyA+cAlhCiR6Vgro+l7Mk/y4jnJPGmGy0vvDkvDt+x+XsPj1nk=
X-Received: by 2002:a17:90b:4c51:b0:2d3:d0b7:da4 with SMTP id
 98e67ed59e1d1-2d3d0b70f31mr1146539a91.19.1723727080832; Thu, 15 Aug 2024
 06:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815082916.1210110-1-pierre.gondois@arm.com> <20240815082916.1210110-7-pierre.gondois@arm.com>
In-Reply-To: <20240815082916.1210110-7-pierre.gondois@arm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Aug 2024 15:04:27 +0200
Message-ID: <CANiq72mjvE7h_aH5tYnuuzdPHAzDUpioMi-h44HNCro8qFfDSw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of
 cppc_cpufreq driver
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Robert Moore <robert.moore@intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Thomas Bertschinger <tahbertschinger@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 10:31=E2=80=AFAM Pierre Gondois <pierre.gondois@arm=
.com> wrote:
>
> In an effort to add test/support the cpufreq framework in rust,
> add a rust implementation of the cppc_cpufreq driver named:
> `rcppc_cpufreq`.

Similar to what Greg said -- is this intended to be something like a
"Rust reference driver" [1] for the subsystem?

[1] https://rust-for-linux.com/rust-reference-drivers

> +       depends on ACPI_PROCESSOR
> +       depends on ARM || ARM64 || RISCV

`depends on RUST`?

Also, I imagine you skipped all safety comments etc. since it is an
RFC, but I thought I would mention it nevertheless.

Thanks for experimenting with Rust!

Cheers,
Miguel

