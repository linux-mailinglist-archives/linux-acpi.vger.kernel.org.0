Return-Path: <linux-acpi+bounces-12848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B8A80BAA
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8EC8A665F
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5476B26B944;
	Tue,  8 Apr 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/oZI4Ar"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271591AAA32;
	Tue,  8 Apr 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116782; cv=none; b=M3Gy4V7I7s7NBTC8U5YSFQG+qdi1XLrhynZPeTM0/stlIHNqOPptVSSRTMMnngCQhM9rft5NL6IiraCqUIXv7XvWaB3/c87B3CHEDn0CWCfEQ9DLc10fzJXE9JPNnCqLoIfl84Q8GCjc5guJiscxId64rs/5wc5/iNtz49k3EBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116782; c=relaxed/simple;
	bh=UavdLqKvpoear0J0LXCBHr0gEwqkzp+WBR8aWuxn3Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQaoAoqJ9TEp2H6/ydyAD3KGBQO/DKrB7ZigVQPeZxjnCVSaHmLbz6m9uep+tFg6KMPDbzsNchWPs7s9kQCw+fQQ6fjmsrkCfDUQfOY31tbAAIMz5fsVke2aXephR2O7tEJlCQQWdnhib2kBNjlnnlTCdrI0Hd/WF1V2pIV8BkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/oZI4Ar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77EC4CEE7;
	Tue,  8 Apr 2025 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116781;
	bh=UavdLqKvpoear0J0LXCBHr0gEwqkzp+WBR8aWuxn3Ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e/oZI4Ar5+PQaq/fZdyq1K++OBagt4m7GiaFtWJ+lpTw6GCxgOfGzPJ0BdAV/bgfN
	 IiDwhJhjVNYXQsbvpU8e9f/yhrkP2pV4eR6DDCrpVmLHGwyG+YzHSokQ+0/PsmXN/8
	 GNQxQO3y79wdf0LBhp7P2OzjO2G2xATIcmrQM7BhP5S5oO3gAbZoP2qnuuRSs/ZxHE
	 5a112yyf+UpMWIO4py7//ce/8qbIR5s3cs9vuUUpL4zz7/Ro8zKphAyMyIz9l04gYv
	 O2Og+fj0WYITs2ZTPv5+vZh8dC5M71u+pH3uZ15KviyD3wq2oQXmXMk3dD9Txmndlh
	 v/xrswwAF7PPg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so9096010a12.3;
        Tue, 08 Apr 2025 05:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgYkpEauA9gWdDsH9IzPuUDdgmr/BKtu5P2awO3iGxOYNJX920GHgaU4j8XY6s5DekEjBc/tuEbQrzXW5q@vger.kernel.org, AJvYcCX4ejHAoGmD8Vls0NpGEWCsC/pekWZL43k0BmGC2oEuTcJfiuuC4mgRoDqWvobfn1CWeN0PPcWI17av@vger.kernel.org, AJvYcCXa9Ou+1hftfMGnOriHLt+64N3JQrL3YGWD8ekS8cYyWZDLJTMUeM6RQBIFe6x+V6zMn4fuxDY9Iapv/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0qO5vLLakd1nsXIaUgreztelA7WDGvhB+ZV55ThTzxew/kP1
	FsQGw+76DNtPzxn0VUR2d3pMfNYEMjxd41B8E1MGxYeKiaFiA0VKvFWphe7FH17Y4ae3UFe0hOu
	XFXoVPN6o7jE8fJPKPT/W1uF4FQ==
X-Google-Smtp-Source: AGHT+IFyEhLibEFQDa5AqrYN9649IKr/lGXNdj3IrgOHpQRiAtAxhW2C4viR9kJ0Ufg14CwOEhDP6OhU57li8uTeH8s=
X-Received: by 2002:a05:6402:2350:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5f0b3b62b55mr12803313a12.4.1744116780465; Tue, 08 Apr 2025
 05:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-2-sean.anderson@linux.dev> <Z_TgP0epJ3cJzlUt@smile.fi.intel.com>
In-Reply-To: <Z_TgP0epJ3cJzlUt@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 07:52:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0tOahcAAqdT6n4q6b1OLwjmaDHfXgs=x4QGskQ2n+aw@mail.gmail.com>
X-Gm-Features: ATxdqUHqglKAyqHWr9OVcAUBpMs1BSQ9ylJ5iB8QpM8IB6CHEvX1BgjMfnz3WiE
Message-ID: <CAL_JsqL0tOahcAAqdT6n4q6b1OLwjmaDHfXgs=x4QGskQ2n+aw@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add optional nargs_prop for get_reference_args
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:37=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 07, 2025 at 06:37:13PM -0400, Sean Anderson wrote:
> > get_reference_args does not permit falling back to nargs when nargs_pro=
p
> > is missing. This makes it difficult to support older devicetrees where
> > nargs_prop may not be present. Add support for this by converting nargs
> > to a signed value. Where before nargs was ignored if nargs_prop was
> > passed, now nargs is only ignored if it is strictly negative. When it i=
s
> > positive, nargs represents the fallback cells to use if nargs_prop is
> > absent.
>
> And what is the case to support old DTs on most likely outdated hardware?

People still care when I break 1990s PowerMacs...

It's more that some bindings (like MSI) start out without #foo-cells,
and then we end up adding arg cells later. So we have to support no
#foo-cells means 0.

Rob

