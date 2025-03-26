Return-Path: <linux-acpi+bounces-12472-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A5A720C1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE9C3BCAAB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F63A25EFAE;
	Wed, 26 Mar 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbyAMKOl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4224EF7C;
	Wed, 26 Mar 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024361; cv=none; b=idEb0xzwLzkTuQame5qwDYNSayhC4CAcWuN7TG4BWLt48jMehxjD3ckeF9zox13boDUUEvOgg/PdJqSQOFnoBum/ZtGLKoo6rDlVEovj7F2tw6Z4bHIrXMh+xiuOhja0l8thIusLo6R2U0cbxqc78mfh+gckefHbxew2ZuQqY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024361; c=relaxed/simple;
	bh=5dd6mTNGubCGg1g4nFzCM8Oi/0JxeDqx+tX2b+VPkns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xz51dGJdoKgTsdKvt0h7PJ3H0saArr3P7n3hRYku4uSW60w0xACsfopfV5AVNPAxiQM9d2axJhr9OCZl67Pi4H2wBw+5IX9M8+HRSCWp1j/NDreOwLf0X0rUm2HzesjAepec9tJC5SEQXl3DUgCzsx/USSlG/3bhVFSrXGob9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbyAMKOl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so56225a91.2;
        Wed, 26 Mar 2025 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743024359; x=1743629159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dd6mTNGubCGg1g4nFzCM8Oi/0JxeDqx+tX2b+VPkns=;
        b=TbyAMKOlvkq+bGfxrrfGJ5ETNVACo+g/nBUoq1ULP89GameFvBBytVMP0QiqIEAUVm
         jY/ZF/R6ZwDUIkZHUn55PKAOBHjiyMNRm5hWhwBN0NHVaVyZ/vgG5N3q6xVrUDpLxxWF
         cWzQImTtkEqPU/g5XrGjArolyK2iUMpzClXgK69MfV3cPA6G3zCZblzmqTBkZtboC4c4
         ojac0FiYlbIsPhShX4H/eatefqZjk0okuxqyeBgEOIt9h4Yi4bKOGPSWP2693W7PFT+Q
         NPFXaizC6kvLlAWryYIbXRuLSbs8haRe6rn5VBUctapTwl2/ewCV8wJ+0XQ//DF3499s
         hglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743024359; x=1743629159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dd6mTNGubCGg1g4nFzCM8Oi/0JxeDqx+tX2b+VPkns=;
        b=BvZgpWoYwQBzMKofDM146lA6L/ZipZm59Hw7v4Xb4AMFU4ZMGeLt5uo3FG28ynKhdJ
         cqEszevy2XnCp9TTsKM8nXj/WajmjfLNYgNXqe7Mi+xBdef4vfIKsM1DJ70G8lmm7SBF
         wgGE/NzvL2EyOL4bTU9IUYLvY9qspRsUJ4gGj88GuysbRiLdQ2E47WfqXjJarRGzn3o+
         C6r+YLN7YWknrJ3SGByqYccURSE+UnZZ1wgKkCKvvew0ZP2SPNaNiy9jFvS7Sm4kKXCa
         SZizzGvGOddqbCl8SWa4dAy8iu6Gj7dLXJzKfcWkYCsqwBxZ5V48d3eWAEMrcotUdkTj
         8ybw==
X-Forwarded-Encrypted: i=1; AJvYcCUin4JPoylc2b4WJHYg82y790zfFrgSTDaQT2kE9QtCIF6lU6DDAFOgHxiTC54gy9iGtjbAkfrp/h2l1A==@vger.kernel.org, AJvYcCUsAHIWEM8HoQoc1nQMDvbeXKCp/XPeSHtBLHr+bZTqmWExj8jafY8G2hm8y5pySxOhoSxWwiMvfWADI+3BV1w=@vger.kernel.org, AJvYcCWpaIMFVMc/+qM4LljseC9DtV0QhN9ngF2cWzGzLPiatobiEBl2SVSOuMYQKdclxIfoHDk1DlOlEBvvh8Hv@vger.kernel.org, AJvYcCXEH14pwJLdTuLl1XCHO8VFqFDps+vFxzs5l8g4YZRYC3cE9X1Dgrq6zbJ8NGUK6F+K/375pMV8YUI7@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLj6UVzurinENqH+ogjXKJKZgcRErdFXbrziekTJ5jGeU4keZ
	BqHQmpQJR6GwT90AsMYa9WkCKtnyfyDimoi3g17C50kKP48g587ms+mhPLxidE/t+cQcGGyP895
	pT6LSxSVz5M2Lzr+qlCwS6L4QGiA=
X-Gm-Gg: ASbGncvf20ZPphsj3bTSU+rQxcCaqMEvY2eexCYjXXErN1W+M76Q0CBHa44L2GjlXW/
	ZQgIH2IcA7r6MwGOAS1lS2mfTa1RiIFI14zs1mie/yc47+YdOFuWmT+ltXKhjSQpOLE6r7i4yWZ
	ArPEzHCTSuxvlLee1PGbosQgCn
X-Google-Smtp-Source: AGHT+IEED3VZRyXSj1RWmXvdwtqZOUHywyrSkL0ECd59uK04S5vf0a3JXMoziVw+bs6ZQOSa5dnlhNjG/4as8bSJVCk=
X-Received: by 2002:a17:90b:4b0f:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-303a7d5b70cmr671784a91.1.1743024358841; Wed, 26 Mar 2025
 14:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326171411.590681-9-remo@buenzli.dev> <20250326210735.696416-1-andrewjballance@gmail.com>
In-Reply-To: <20250326210735.696416-1-andrewjballance@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 22:25:46 +0100
X-Gm-Features: AQ5f1Jp0Rp7E84Il1vwCrqKhN7FBkfP8izd3SLqtwQoJKmWnVsdDbD-_koYxdjo
Message-ID: <CANiq72nP3EEYH6cdZRj2S9XZUYyi=RyyQARypGCFj3ULEB=+fQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] rust: property: Add property_get_reference_args
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: remo@buenzli.dev, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	aliceryhl@google.com, andriy.shevchenko@linux.intel.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, devicetree@vger.kernel.org, dirk.behme@de.bosch.com, 
	djrscally@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojeda@kernel.org, rafael@kernel.org, 
	robh@kernel.org, rust-for-linux@vger.kernel.org, sakari.ailus@linux.intel.com, 
	saravanak@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:07=E2=80=AFPM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> This function is missing safety comments.

Yeah -- that should be spotted by Clippy.

Remo: did you build with `CLIPPY=3D1`?

Thanks!

Cheers,
Miguel

