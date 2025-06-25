Return-Path: <linux-acpi+bounces-14584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27AAE7C8B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D316BDDD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708172882C7;
	Wed, 25 Jun 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIFaz6HA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A027FB28;
	Wed, 25 Jun 2025 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843067; cv=none; b=rqHToYY2/qKbI0ZnJnQ+fNlW5M5KVUhWJrEmEmfTR4QyXc9Ptuu7mH/xk4Q26nWrzdxKcIh2A5lVeDI02oW0fly5AvWpPq75i5IAisL6WMQ+QEFDxHxwRsXPxUdRTT58crHk5QntVxQEo+edPqAfyp9mzqqJ133j+Up34Ykxacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843067; c=relaxed/simple;
	bh=lzpnOdON6DVOT5w6AYitAh53ABW/+efYEjeRFM+K+0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxlgh2lSiaOotCO8Oq6N7ILbsX9Jof1d39D76oQwKl4WuVBZeb3ZFrKz++h4XtAwnbuzCmfgNe6JsdGLTFUS444h7YQRgLgETsR0CAlL4uX/UNr/3puwJsiCuQ84+SJf1ZP7ez0NzAcKAjwK4XKws2dOcTKCpDHTX6bQUU5IwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIFaz6HA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E5EC4CEFC;
	Wed, 25 Jun 2025 09:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750843066;
	bh=lzpnOdON6DVOT5w6AYitAh53ABW/+efYEjeRFM+K+0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XIFaz6HAp30XC5+3kqWdbXtioch/sN2GYVla67EpZbZur7OMiWAmaWk+mVMmQjq7h
	 xWUkKD+6vJNDyOBeSsHwjpwIqsWGm/tBIvAVKheCu/e9tpTOjHd+75Jq4gmLFMw2os
	 /sY/85yf0wnByP76jCTiSiw9WgxezQacG7tUYcIkAj9GG3REgJR8nsBem1NNxfc2/D
	 xbD1foSYRScGYKvWqMymjo5Ff89TmWU28FLjE2oOoiOn04Y9UT23ASghVz4gPcfbYQ
	 YkAWMyhdPj/jkyF0Bkajv9n31IeX60kr0CslyJVzFdHSp+YnTbPE0n2UuNvp4JtF7o
	 +8G0CsvspQGMQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60ef07eb7f4so3340198eaf.3;
        Wed, 25 Jun 2025 02:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWiEhFJM8CTNvkSpjjQGcYY1FQn2yDiZBdmMpDsyo1K3CXStMcllxuiVWa4GfwYbZyT/V3drg3B9Bb1zP3V@vger.kernel.org, AJvYcCXV/xggpJvnQe2r1FNbuHYnk5C8XPqNMrUnUa8sAJeI4Vy+lzYzT2ncCKtHUTae+XnXDuPqbzqr4hzMNf82Vv8=@vger.kernel.org, AJvYcCXb/b9X5Go/HbxN9hmY12Msyy1UH8yexaimP1zv1OVt0uTjf3ihIptKWNKAEFUD8Qitfnvf6ViQ0O7K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4P6CEtEh6BLEmFOL9EMxFZU3qiENWsFEVg6B7X72lY0VhjKZo
	lyeqbZgjQw8rUlP4jtcXxnVbS0IPd2F7furhzgK0ko0WDdLMvc6sWZ2scZloufuDyuBtM96hNuE
	hqEi7vOtAHLJoNGQPYpSLX8gk1cdKrMc=
X-Google-Smtp-Source: AGHT+IGwmHiP0k0AYczEQyTJX9RAeJkddhKZ8nYsuI6oroN+azy2At44HmYTpTB4O/qsehu29og+iFkdUwWY8+oAXOs=
X-Received: by 2002:a05:6820:4c0d:b0:611:75a8:f6ca with SMTP id
 006d021491bc7-6119d87e6c2mr1465775eaf.6.1750843065563; Wed, 25 Jun 2025
 02:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
 <20250613135407.1233005-1-igor.korotin.linux@gmail.com> <aFB2FZEFcXUsW8lN@pollux>
 <f29b4eba-bd79-4f74-940c-8cff65495ae0@gmail.com> <aFGisAm-n6Mt70Hd@pollux>
In-Reply-To: <aFGisAm-n6Mt70Hd@pollux>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Jun 2025 11:17:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBG-ccWdhiKtcasAVOph+===AZoOroznf2k5OG0BOnkg@mail.gmail.com>
X-Gm-Features: Ac12FXzgbtqeoG_UDw0GugtkAlia8IsWynCbV-x9VcnNKKiUERwayNEWl_bRE4s
Message-ID: <CAJZ5v0hBG-ccWdhiKtcasAVOph+===AZoOroznf2k5OG0BOnkg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] samples: rust: add ACPI match table example to
 platform driver
To: Danilo Krummrich <dakr@kernel.org>, Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com, 
	viresh.kumar@linaro.org, alex.hung@amd.com, dingxiangfei2009@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 7:15=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue, Jun 17, 2025 at 05:39:07PM +0100, Igor Korotin wrote:
> > I could suggest on of the following:
> > DRV0001
> > DRVR0001
> > PDRV0001
>
> This one looks reasonable to me.
>
> > TEST0001
> > TST0001

Can we please avoid using made up device IDs in the code, even if it
is just sample code?

It is way better to use a real one that's been reserved already as
"never use in real ACPI tables" for some reason.  I think I can find a
few of these for you if need be.

Thanks!

