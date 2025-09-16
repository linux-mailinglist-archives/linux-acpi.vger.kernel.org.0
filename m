Return-Path: <linux-acpi+bounces-17010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ACAB59228
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF0C527006
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088212BDC02;
	Tue, 16 Sep 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9GWTVhI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651D29BDBF
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014753; cv=none; b=ejAyhicHvBPGGBBYcbLswKR1U24biPMaAo4E5Z/JHTeB0nS1vOE/mHyh+uQboEdlDPLozKwxuqPL9I3VC6ahiERW8zuCYPPEMMDhLt0lEzlyZ6pA6UCJgUmg5z73tIZvJfcON4RA5PDpa/4w8sGQGJ/aNr1+Lk7k4HtNDsQiXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014753; c=relaxed/simple;
	bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ES3nldB5g1YgxVQW6SECzFvmrqn2pqkAna88fsnOjIfyhiozQhbhdpXiZKYkTbkR4/0p2gbDOHVwKcc9Ahzk06yIfaRKhVgMM+m5vPTEK36lfClZiSI0JUoLAjnnydkh0QglMwaVyLg8hi9pJT/zj/n9N3dMyXzrGY+CM86P84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9GWTVhI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2630354dd1aso6258275ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014752; x=1758619552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
        b=Y9GWTVhIJtRrGpeL0bZclzvTItu83iRH38oBrb2EcNhXc3csSEaIHLjxntN6vPRekG
         U+fX+zMMyWvq4fU1tXc9j2glULsCsD3HDQtSdJDyCms7FAzij16kiCbq4ZFH4GfX1o2O
         60bm9gvWo1/H68oAAxP9Bh2C3rYz1lxFDBZZr5Llaxr51bh/syGn3RGUDU4Wubvi7ara
         /L0GnCtskb8YvQYVF0Cb8mRK/F3O+YZqvZLAJowHKwv2kqeo8uPRcyKtqEPj2z3PGkaP
         rt4IM+0Zu60Px0mIEQ9DMA72XYDEi5sZQhNM4KrzJelebhotOVNfMemzPC3+X9ehK8+e
         a/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014752; x=1758619552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
        b=ejocRNbBVCToSpqq6lwTak7JbSZdNCyVxTqJrrNB5cxFi7fURRZecYn7xWiQP35p+Z
         bvzHriqijlRW7tuHbQKfum110Cal1EkBcUAYH3d3n/+NpnpzPzOohLEzCF0YhLyTVei0
         fMC/2jfAF6W/11WtJzkxU4fXdjncOGrb00cThqCZBm2Y9Dar5lWeNZ/Oq2Cn9XUdP6zQ
         ZrOYiVlm/lxmMB647K/6BXLWGSMkBbUQciIsfb83LdEhxo6vtbjqBAJuu4Q8dcdJvAH7
         dQXd8R8/3ddG/n4P+CW9vVTaPW9lX6zJS5nc7U3aUrY3yWvG6qSuWrfRcMed3moBDaBB
         iuJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYY2NS75vbOISD7UFUiAnMxNr0b+NcAqKZrQlhoHPtrfnWt01ldnm646ye69KBmvFpVvoEp+A73Kjw@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNKPoTnFryna7Ds/Y+jKhdDUFyIwoci88tQDFR11wol4BI7Zu
	fGV4cI0BWhbTzzRiZXcEo4Obmv1drLQQ4jHtQ/ekUSXDEzJtQ6s7coKNJ6iSOjpQ5IcQGsFLp1a
	D0yXGEe0LR3+NdlmbhM+OmQR86ZwFF8dhvfZuCRA1zw==
X-Gm-Gg: ASbGncumOUF5LTEQsMONZycuNXzrVs7AFwB4Vd+gqkgLlnYt8gfjpYr7t5+r0T9CMqe
	d49nKCt2m6eGDwZe1If62CqUGz2Dfvl8uOujaYtjv10knpA3P13MH/jBwkpN0kEsmBhzA+K2Aib
	sLfWFqjYTaDxWZblqb4jyPnbPw9jDkGLRqlM8gEHnouMcC/1Rs4gOawnmkHBPqnEfvojMwL3/As
	Hjt92rnzo7JVrcb4yYCkYpVZYFQiT+QxgUA67gPdsOe1FXQMNmy/mbZSKEooMDziwn45VTHAAAq
	xhuraJvLnwm2hhv0bYuaASy4ug==
X-Google-Smtp-Source: AGHT+IFwc6Y1OseNifdIO5J0qDFbM+aOcV8Z7xSmon/0tVZxaKw/+AP4a1wI7bqiW8muI5j5MuELqcXm9FvbGpAicyA=
X-Received: by 2002:a17:902:e5c8:b0:264:9287:3fc3 with SMTP id
 d9443c01a7336-2649287431dmr60170295ad.2.1758014751666; Tue, 16 Sep 2025
 02:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 11:25:39 +0200
X-Gm-Features: AS18NWCYvwyg0oQ7WKMGNn77retnSNUsfiN0nCmq9Ts2BvgM8ip_kHMckevDcv8
Message-ID: <CANiq72kq4RWNO1pJtJuG8jBpARq5ft6pcn8dHuUWJx=nosweyQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] rust: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Len Brown <lenb@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:42=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is series 2b/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

If any maintainer has a problem with this, please shout.

Cheers,
Miguel

