Return-Path: <linux-acpi+bounces-14022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47B8AC9320
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5271E16B339
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EF2356DE;
	Fri, 30 May 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8wNNzGq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DE21FF31;
	Fri, 30 May 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621513; cv=none; b=BToHCY8WGwAXl6vs9aDvQG4EpzCvwU7pSUE74BD3wpXg3Px7UxRqHPPuo1zl/YFK+FYahTH+hmE8BVNisft7joosly/kCQu+Cdv1nOTwNNTkJedan5YpWaIj9dpYuLXKKd5iwqlXLOtj622yUuBSSpZVVUlndqJ3aGL/ajmjzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621513; c=relaxed/simple;
	bh=JxtV0D6AubRniQkjtIgt5S1C6ts+wMFzj/fqdznVwRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR3ktKNbGtnCnyUZfMzgNLgQx2TcxJ6n+Tw/NtHoCsJ4fILYXM1yEPMB/Khfs7uKBfN0BBqluhuGcLDdw+puNfEDTgw0Gj4040hdRLJG9GTRtrZPq7dozyWgbCV0NMQ3js/2cXrwJShXLoXIEHnax6Md5d59nkq7yIsIyrx7DMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8wNNzGq; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-605f7d3215cso1101941eaf.0;
        Fri, 30 May 2025 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748621511; x=1749226311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxtV0D6AubRniQkjtIgt5S1C6ts+wMFzj/fqdznVwRE=;
        b=l8wNNzGqzGPCvHwNFcZAZVxhCtHOb0fGrl2nClhWtu43jjF/1cH0JWObeq5o5ykbhP
         uUHgsl3HFFVfcwp6YdsnONmS2ZvGKsL7baZkQ+mZ89h4Z6148MNNDMB+DomUif8rvkep
         yar8gS1IxkmK9e0djk5/Ud2gD3Gjm9EfxzM9ld1K+4k4bHEZfSFa6o3P8wyc12cuWi+N
         JI4tesFFLZqaPerPV5jgndqwxg4JNE9ICC7EnytaLYTdkYAO37r9nark79GQQaTPGfu8
         Ix/hNambz367Fz0IAM8mbbrcfCPCuKAnuiQixHVzoQ5BNyj9BPx6PWrvLNA4GJmCClFw
         KzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748621511; x=1749226311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxtV0D6AubRniQkjtIgt5S1C6ts+wMFzj/fqdznVwRE=;
        b=NZ/t78CmhXYZZXXUnTWd3PuPOIPiGxiH3xWh2ImYaBqFrXjpUjx1Y7vvfyOmH3tWOX
         lbz6dFfTj/cLpB1QC+oGgrdxaZHUufV6IltbV2fDaDU57a669abAbhhHnUOyqlMz6ox5
         mZabSkPv8jZtQ5Ic13MESGfatWJ/9WVyx5kzERPrS8N6CoU92Vgf7prKbr7vJSCqVxFd
         5Fc+hSvDoMZf0rJ+/VzzkfcXMUxB3PLBH3Cp/BLIcjEQYzNrYTvGNUvM6MsNQnc0t2Y9
         mIE2lyuIaBaykJZPXLXlozEbrdEserceJzX7cEnae+/9I09GPTksA5l/QJ1ERp8RXOVL
         1JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1j/w2ENfD65+7N8JkF5KadmJg++inhkayTpAqmMXULY+8VVhjROr929giyY65MvY9vw5JLGrTf9Xc@vger.kernel.org, AJvYcCUNA4DaFk8m13uTsfOHuIYKf/cEMVTx3xqikJMFMGMMyV/idLkV40NcY7QbnB4dKTB+lUDLbD+JU376Te1iyik=@vger.kernel.org, AJvYcCXFKeVNUQogoPTKsMl4zInOtGl8iYNPpZ9COlzM1CDjcYf4JFjEJX9yZtx57EOji9LoQNwL0I4vMwffQiNv@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAkzGSzR1LhjJTAazH8Bz0ggm7Pc6BN3Ul34Y9lvMP3KouW7k
	lHbX6ok4HQ5mGIpQQ3Qd4uaA6+vPNemqCHJoInopIKwVMgnqC57cZ3UbYo5mlIeWSeOHU+6/vmd
	yN8+mXKFLRNAfohlc0HEKe0GDknX31D7Dpg==
X-Gm-Gg: ASbGncuJBrGo0QYc5/QF0dGkMmcDghf26uq9x9sTVGMqD6duUI3PR+XbpFMiQKwqdUC
	MgfuNnUgFduKTGV+L05Uc/6fBtKhX02jGtjbDlm1M37xCNTuVN1IjgrkvmK7BR15W25zEskJgwr
	owH73ZYkuXZoQqOl7Gp7PqGWlmBodzwQ==
X-Google-Smtp-Source: AGHT+IF/aay3NumOFpYxCTYvXjGPw2aJjTjotLJwNMW8KxAvRIws3RyvOkPxadtZbDnzO4KRruHMoJNWabrLeMwZQ2A=
X-Received: by 2002:a05:620a:2611:b0:7c8:39ea:5166 with SMTP id
 af79cd13be357-7d0a2039baemr649090385a.55.1748621500677; Fri, 30 May 2025
 09:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com> <aDnD_Bb3l6GiI_8K@cassiopeiae>
In-Reply-To: <aDnD_Bb3l6GiI_8K@cassiopeiae>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Fri, 30 May 2025 17:11:29 +0100
X-Gm-Features: AX0GCFvLICHmBiqMxdqqp48Vv-IC_I1t26FXsHgkRDW34PvFxl3Wr_UaVsW7sYg
Message-ID: <CAG7QV92rtk7NUKzUoApkopv1LF2WVjqyNA9hPt=yCuEvdJjoCA@mail.gmail.com>
Subject: Re: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 3:43=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri, May 30, 2025 at 01:38:06PM +0100, Igor Korotin wrote:
> > `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> >
> > This is used by subsequent patches, in particular the i2c driver
> > abstractions, to create ACPI device ID tables.
> >
> > Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
>
> As Greg mentioned it would be nice to see the subsequent patches.

Ok. There's a little misunderstanding from my side. I'm in the
progress of implementation
of I2C driver abstractions. I2C drivers can use either "of" or "acpi".
The idea was to push this
change first, because:
 - It's quite standalone one.
 - I'm not sure how much time it will take me to finalize I2C drivers
abstractions.

If it is not appropriate way of commits, I'll then keep it until all is don=
e.

Noted all the remarks. Will sort them in the next drop.

Thanks for the review.

Thanks
Igor

