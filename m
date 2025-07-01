Return-Path: <linux-acpi+bounces-14885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB4AEFB37
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138CF7B249E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D92750FA;
	Tue,  1 Jul 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUKq4jIP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EA2749C9;
	Tue,  1 Jul 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378062; cv=none; b=r25W0TphJmXjU4ave5X4C33+pTjujXf/4LglDn7J0c5bQkzvT+f9mS49O/SQA3t1zaQYl6qNHiHhL1WPvRG+FxIqH8VwpX6ypBVuOtK5gNoCcFHO0ofcLc0JkCOf2FWkSTkHC7DembXuIxgj81va09/p3bRobFKc3DO2oydBOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378062; c=relaxed/simple;
	bh=Jng3wkmeznNgaZJCbfupk58RsqV3AADGX9KcfOwgqY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3Gzjtrwm6a8DKJw9Yn1x+eU8jfWlLivp4E4ANGQs9WTwOTs909z24ZcwgGhri2fIPI2wnNgQt3e4V2Fp64jFAUg9PjQZXees92k41BOqOgBkGHpt6w2R09+EHHa3Ll0YSPPVNBjCVWXVYwHnlEdgRzsQad6U7XPiTRdxiRC4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUKq4jIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA55C4CEF3;
	Tue,  1 Jul 2025 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751378061;
	bh=Jng3wkmeznNgaZJCbfupk58RsqV3AADGX9KcfOwgqY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uUKq4jIPUxYByK6SlEFyvyt/h0fGGotsrjQ6Q3Xe4WxxwEeNQTBhOVmVeHIXwomb4
	 Cf/wkVx1zZ6E2MbtfuDxJI9dZK2dzucNRIwix+R17zFavhXsQWYLprFY+/xy1ic/UA
	 ditp3Bqh2xRhYEJNmEfoZ9jdd7Z1ysUwnpw9RDYkuXkAYveQeJVw+hXO4T297IfE9m
	 7qlezuIDgzHIHF0zOy1bbu2nmQUzWLWltV+XT5ERreJPYYFObopx6XTZTsldEE+K00
	 37w0xaDyD0p99AVc8uCWl/+pJ7ia/8ggqYNJ3CcHHgmek+DCJ1723zrRyN7Bqrw8hi
	 vZn16wYO9hlMw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6116d9bb6ecso1852018eaf.3;
        Tue, 01 Jul 2025 06:54:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9rwdMQQo/8e5RYcuIj2Pu/qcS5W8vlt6at0bEpGDf5spu/NxXY8O07O7ohviem7hFZbO4eYskQJdb@vger.kernel.org, AJvYcCXzTQBfvbmbEkrVr3GhRUfKKxFnQMGFX51bT3o8tCQKeqQa24iEZ5CN0CfPVi6KfDk/JUCiptEj0TQB5Rmx@vger.kernel.org
X-Gm-Message-State: AOJu0YyQklBWdd/EVtTTQ+6waF4wlt/oQ4B/bkR6s6MG6GA7nO/Qa1uf
	MqT78TwO5hxu4anYUOfxQNWCEPWKSo2I7ez1nM/Pj27gRr6xqI8fooclLUxg8YbKXKXgRihN735
	WQzii0zZrvoGvHQcKtJDOw+oSJ/QObko=
X-Google-Smtp-Source: AGHT+IF8seE+Id7xG8WQlhFiBqridThxc49oWjknLWJxi/lTNTz9icUtsuqR9A2rhC3Lo+dq/lpP/fUkCq2qp3nRons=
X-Received: by 2002:a05:6820:994:b0:611:b561:258e with SMTP id
 006d021491bc7-611b90965aemr11674984eaf.3.1751378060915; Tue, 01 Jul 2025
 06:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620131309.126555-1-me@linux.beauty> <20250620131309.126555-2-me@linux.beauty>
 <aGPMM9Nw2-99sWRL@arm.com>
In-Reply-To: <aGPMM9Nw2-99sWRL@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Jul 2025 15:54:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h06-uQq57So7GzBMJ48dr42z3hY0EBFHSUmsjsVaUgjw@mail.gmail.com>
X-Gm-Features: Ac12FXz4Xi7TozQTSvDj_v42bWdO4aRE3ZuU9eQvEt5OUBffGU8gt-jQaTTOshI
Message-ID: <CAJZ5v0h06-uQq57So7GzBMJ48dr42z3hY0EBFHSUmsjsVaUgjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: Return -ENODEV from acpi_parse_spcr() when
 SPCR support is disabled
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Li Chen <me@linux.beauty>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>, 
	Liu Wei <liuwei09@cestc.cn>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:53=E2=80=AFPM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Fri, Jun 20, 2025 at 09:13:07PM +0800, Li Chen wrote:
> > From: Li Chen <chenl311@chinatelecom.cn>
> >
> > If CONFIG_ACPI_SPCR_TABLE is disabled, acpi_parse_spcr()
> > currently returns 0, which may incorrectly suggest that
> > SPCR parsing was successful. This patch changes the behavior
> > to return -ENODEV to clearly indicate that SPCR support
> > is not available.
> >
> > This prepares the codebase for future changes that depend
> > on acpi_parse_spcr() failure detection, such as suppressing
> > misleading console messages.
> >
> > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> > ---
> >  include/linux/acpi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index f102c0fe34318..71e692f952905 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1503,7 +1503,7 @@ int acpi_parse_spcr(bool enable_earlycon, bool en=
able_console);
> >  #else
> >  static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_co=
nsole)
> >  {
> > -     return 0;
> > +     return -ENODEV;
> >  }
> >  #endif
>
> Rafael, are you ok with this patch going via the arm64 tree?

Yes, I am, thanks!

