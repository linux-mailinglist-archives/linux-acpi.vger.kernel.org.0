Return-Path: <linux-acpi+bounces-7971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB10964BD5
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC891C2277C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B411B4C45;
	Thu, 29 Aug 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXp2Etva"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70C1AB505
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724949748; cv=none; b=Lj1I1Qs15Y92QBt6STB5L2Mom5Z8Yiw3gtDIQFwy+m1Hmgp9aaawvZk6l6k6n5sqNouNamroLUaB1E6k/hzkfUgDfDmCRS78gpCDIxj/8QCoF37kHYj3+uJLKFFVSrx/b8hjRu4ZlBkCTAog6NFLe5XAg87rgpTZCFjPFdCtg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724949748; c=relaxed/simple;
	bh=a4x5/qXvOBBBKn2ObnT2bX/iUIeVGlbiRtA4tS8VYmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjDoLQSRfsmEqtMMCobYqqxJ+JjSHgma8nHl7Omd2bX3M9y5TiSwhxMi56uEUkXq4EXqX8hlaOxwCSNS05lBmwmPdranpN1S3iSc9T9Bb4kEX2KXAyBWqxHxHncH1FeOcAZJ8bRnP4sxq9F4x0R0I2jjWpb5fdpWYE3ET358I80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXp2Etva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18CCC4CECE
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724949747;
	bh=a4x5/qXvOBBBKn2ObnT2bX/iUIeVGlbiRtA4tS8VYmU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MXp2EtvaJRB8VSdFT5j71XTHeEEM3d/bUyNVbet25CT0UjeG7hGtnvtgCk0RVHAJq
	 8rp+haYg60WMjobcItkEQ8188iya3b3TmPj4efNFS1bZrICeJn4+bCAoVz1M94DHS9
	 /lxB6pg8VtMscnDYJZCB5BQ7xt2PyA1M/FRVeELglXu566oDQTZAAbF4AC/ZKJ0VQW
	 SsC/UF2NZu5Ldd/ZHVhSwUjqiFnYijpCMCzuwc1eU51TexBLTIGdZswj63Q9c59MGE
	 Yqk6nPpURwihcjx2hBPF0FYVBpjyO6x1WTBYzuh2rpfHjjiP/K3+0K0xMcKxz3flRP
	 igMSlC+fs4NiQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70f65cad4b8so72034a34.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 09:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5Dr0juW/IgrIXfUufZYg5PYZiXNSG7nfCheSaDZ+0S5Z3eOl6vrwyhxB1EvteTt58QK8AXKYnvk44@vger.kernel.org
X-Gm-Message-State: AOJu0YytDR/LpOVluVHjAkddzQLpf9cYzpOVXuiKMb5uDi6ZoghSkSDl
	na/rzLAEZS9G3JtIk94t+wSfKsqnnIhP6QxPcmaiuwtRY04gl4oFCQGp5KYjTAQYhh6ZRCHG60E
	j5t2CGAW2qkPl33Rp1AagbEn3gc0=
X-Google-Smtp-Source: AGHT+IHZB/5440kh05O9HbWM6H011fcLN0JXrpLwkhOBHoLbmADmc7ckzlWZZXjULxINOdtIit7VcBCYhOgdPhfBRaA=
X-Received: by 2002:a05:6808:23c9:b0:3dd:ca:a3f6 with SMTP id
 5614622812f47-3df0682c6camr1041010b6e.18.1724949747170; Thu, 29 Aug 2024
 09:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
 <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com> <4EC8AF0D-321F-437B-93C6-E597E4D4BB34@gmail.com>
 <ZtCbLIfCklb5kQN1@bogus>
In-Reply-To: <ZtCbLIfCklb5kQN1@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 18:42:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hXW+oH6KkJiXP7mtg2rgvgy85D_x6snckaA=cw9iFy6Q@mail.gmail.com>
Message-ID: <CAJZ5v0hXW+oH6KkJiXP7mtg2rgvgy85D_x6snckaA=cw9iFy6Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: introduce acpi_arch_init
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Miao Wang <shankerwangmiao@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:00=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Aug 28, 2024 at 04:40:29AM +0800, Miao Wang wrote:
> >
> >
> > > 2024=E5=B9=B48=E6=9C=888=E6=97=A5 17:43=EF=BC=8CHanjun Guo <guohanjun=
@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On 2024/8/8 17:00, Miao Wang via B4 Relay wrote:
> > >> From: Miao Wang <shankerwangmiao@gmail.com>
> > >> To avoid arch-specific code in general ACPI initialization flow,
> > >> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
> > >> utillize this to insert its specific flow. In the future,
> > >> other architectures can also have chance to define their own
> > >> arch-specific acpi initialization process if necessary.
> > >> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> > >> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > >> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > >> ---
> > >> Changes from v1
> > >> - Change acpi_arch_init from a static inline stub to a weak function
> > >>   according to Haijun Guo's advice
> > >> ---
> > >> Changes from v2:
> > >> - Add __init attribute to the weak acpi_arch_init stub
> > >> - Link to v2: https://lore.kernel.org/r/20240807-intro-acpi-arch-ini=
t-v2-1-9231e23a7721@gmail.com
> > >
> > > Thanks for the quick update,
> > >
> > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> >
> > Hi, all. I wonder whether this patch is good to be applied or
> > any improvement is needed.
> >
>
> LGTM. Rafael, do you want to take this via your tree or arm64(need your a=
ck)
> once you are happy with the change ?

Actually, I'd prefer the RISCV ACPI changes to land first:

https://lore.kernel.org/linux-acpi/20240812005929.113499-1-sunilvl@ventanam=
icro.com/

and then it can be consolidated to use acpi_arch_init() in both places.

I'm going to move the RISCV material to linux-next on Monday, but I'd
prefer to defer the consolidation to the 6.13 cycle (after 6.12-rc1 is
out).

Thanks!

