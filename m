Return-Path: <linux-acpi+bounces-14195-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1BAAD03F9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48621746F7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120D70823;
	Fri,  6 Jun 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/YrrZDb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A72B9A5;
	Fri,  6 Jun 2025 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219987; cv=none; b=OY/xVxivZpJZax4jSOP93uXiEwxqQamuIdh2cp6wxEfWULPJucBBbIzBP8UBK6Y2Q3vfG9XJt8zmz1K+n/Dr8bmq1nAoK/pdwKEOUG1DItPGlAqZQwp4rquGomMIChTq0t4XqsC+yw4JHEuFmNNbNZNgO9iz/RTX/LT8AvoeX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219987; c=relaxed/simple;
	bh=XfnyRTF9cyYzPGBVpgr2ODnE1deAYbYcyIcYxtMRycc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WD7ZZjuI2DbmFk3Bt3FocNVBDNNtvh3snpsLfRLcY5dOXt4dNHzYucLoTiDkX5kHNrjqbIYCEUMSwU58gzL4y/LSkApds5Xzu/lT1iY5Xlea2Ob0G1clZG1lIaeOEcjq1tzDtwkGxvfc+iS9SbDtTnXObahL0F+oPVQllcsBqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/YrrZDb; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e59af1f0e7so619611137.0;
        Fri, 06 Jun 2025 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749219985; x=1749824785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfnyRTF9cyYzPGBVpgr2ODnE1deAYbYcyIcYxtMRycc=;
        b=g/YrrZDbhdoEhU5yDdf8I9o5F/JxgFrDNT48SYbGo7t8mUs2AEAlFlrwapPiPi7o1n
         WpAaKx9cC3Cz5/zXNrgXMl7HY8xIY28Ol5A1CZ1ZxYLqg3+r52z+SEhwoy+plVRFmstX
         /XYEz3moccqwsCQfMwZ3GtY16AUysXW/qehDEOlraDl7k6Vr97V1rgAMVF4iepmhoV0F
         2i+gZwfk5Nj4bNJey4q9w/pGV3TBC0Wve8K4gvBJlog42a/XKtNuR4pPokXSK1PCAuvo
         o1E4YzdX4zUDypPDnC2IV5nM52IEC6VcKXj4wLAZXN0taRTxEMO6iHQlzV++k8lvXuTa
         jjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219985; x=1749824785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfnyRTF9cyYzPGBVpgr2ODnE1deAYbYcyIcYxtMRycc=;
        b=ln0ZIzDyHTwPJxtLt1D14BVwoutn8QJBQKfPnzY9ysz/dLYk6pakDSnENWCrOZJUBw
         aWsDgUbGKkLxO6C/Q5fhX9JIHzi0yrOEGd6lslN2x+EVU0iUeRMMPZbiQ+FiS3lDU41R
         2+EVHDNjc3YXogojh+Sno6iDZ/ZNe7Xc+XDv6/TRF/BEme6BfnjM/24EWSzfGSQXBHyv
         e8Vx/s92JLX7RGrojxgSxDzlX9U2ZlJ8SJkKmYVUzGEkRJb5bk+4wBHphA72J+qWEqHJ
         nAzswUWgPTHm1aKyHfyi70iTc6dqfJtSwpK75qHFYctOKp0/ZMyUUmXFB0AmWMYgKEuV
         nd1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3ufsZnUPhlK1fwdI0Ya53N7ldX3AZ39u93CglBk5X+rxsT8eQ6YBdTvVpjzzwzm8la7ZArCLnusoXgu7/@vger.kernel.org, AJvYcCV49fTg5fEzQs/zwJLV3JSbkse9ja/OcttPKi0SgRV5Do0q7HioD0eD6pScwa+N4F5nmiuBejTL1vbcskEAjkA=@vger.kernel.org, AJvYcCXAlmIfUr6VaTqhKGyhoDzI0Z1BDx/IrMoaee9L9xYXtIStIQ14GGaMqiKOtfH0RKfsSD0nM1vWH6iZ@vger.kernel.org, AJvYcCXnUNgl1HbDGsIeANovFiQgNzpXbpvHxzxxy3V+fg8Iy7k2XORsEQAtl3EQYYjTB4XlnrN4gnhOC7tQNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd02TrfNahnt9Fc3vQGOwR6TdJGvbH6OpZAdwXmvggpVqMcnEV
	UkQ8uRT2Qe8suE+x0VpR0pWH20eBbX1lWS7tCqUDEcLa2WnKj5DjgdLXEgvdY4kMM64Zizauyjq
	gmyE31CS1hCd3TvTJ5gU1lnkKwDa/UOI=
X-Gm-Gg: ASbGncuqvagTs7Cl5XpKSVXirIRq1qNgQPPiQOBAFJYa/KU+H/O4AeNtX6OyWykpXZc
	QqpONhIUYeJA+Z80LuRhzK8GRia9kJKviOGi9fyPhOdTkbW4k6S9bm3/N0Ebai8BfJpcCo1zTo+
	jdFxBe82jEGGKTq1c1MC/6YStAS/wMuvoQ68SDY2BX
X-Google-Smtp-Source: AGHT+IHtfcCyCFZ6TdHUHESBhIqNCBUddX3O7P9LGH4zDo9p4z3LAVOg5NAYcVejVe51KzO/kmt6J7IoLoJyDzPVH/g=
X-Received: by 2002:a05:6122:2a45:b0:52f:2a3:4bd6 with SMTP id
 71dfb90a1353d-530e47d7084mr3572334e0c.3.1749219984860; Fri, 06 Jun 2025
 07:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com> <aELyEqg0GrkC8oZY@pollux>
In-Reply-To: <aELyEqg0GrkC8oZY@pollux>
From: Igor Korotin <igor.korotin.linux@gmail.com>
Date: Fri, 6 Jun 2025 15:26:13 +0100
X-Gm-Features: AX0GCFtw9v0O2vZnp5UZfhE6lx1eLBBwkxj8gJtRKsSFion-e94P9ebf93MfPIQ
Message-ID: <CAG7QV91AWpOk7VUcE-B1MLkEQPDB0Y=zsBOBf6MhHVYh1aEGQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to Adapter trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin@yahoo.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	devicetree@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 2:50=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
> However, I don't understand why we need this and the subsequent
> is_acpi_device_node() and is_of_node() checks.

The idea is to avoid unnecessary table lookups when both OF and ACPI
match tables are present. If we already know the fwnode type, these
simple pointer comparisons (is_acpi_device_node() / is_of_node()) let
us skip the irrelevant match function.

Those checks are cheap (just pointer comparisons), while
acpi_match_device() and of_match_device() iterate over tables.

So yeah, it=E2=80=99s a bit ugly, but it can save some CPU cycles during en=
umeration.

Thanks,
Igor

