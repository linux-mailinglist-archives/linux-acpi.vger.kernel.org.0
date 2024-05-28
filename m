Return-Path: <linux-acpi+bounces-6047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64C8D17E9
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D7C1C246E8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBEF16C436;
	Tue, 28 May 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD8DxWqH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506B16B732;
	Tue, 28 May 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890331; cv=none; b=FG1DMyq1BqbKZIHs2u3eEITrTsScW8/Vc6sbLwnGZ/Ms0AKhLUbiRDuLAUHw/1/IjVWngjlYCTBlWkwcwHasXtU8n2/wRPWnZKynw9hXHd+g/MoJU4DCc8G708LRcupy8EaNF98hTn3xi9SbS4aWdCWTetle1W4P7FUZ6+Bq0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890331; c=relaxed/simple;
	bh=kpy/SWnwodDDc23zqO4dtMTL+noqtCELyjPO6KqVqjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlbGmtx/3FROxNEgQxlwHqlHus8fOy0aVlaBY1ODxsS3uctKc9otpXodKWLfxDBbFl9QRZO9Ox3tiUr7MrQ+SJx2L0wkjReylIHnLXMH9RmKfeSgya0sBOEVBmrZ75zdUjDokJAQn0n9r8RMSxA3TcY/C9jEU6gXTtTGfY1txug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD8DxWqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44946C4AF09;
	Tue, 28 May 2024 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890331;
	bh=kpy/SWnwodDDc23zqO4dtMTL+noqtCELyjPO6KqVqjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OD8DxWqHLypLnt4Z3iseoeFoDmf9Y8PIca+1SnsApjCcti+VXpWBll2p5HVyepbqA
	 qMHT0vvqR08PjyPsUT7RsE9U1u5zu+azb5wVufSbM8Ul16el/lEDhT42vY+m6CBvk7
	 VA53XosE0MT/X5/9TRg7kFtEvFWg5iZo40JxWQu17xpngS0bMxSaEmrB31jXsvoOi/
	 kE7WjifGzyoMIBu9+nvs4/sP6ZHFbWVt+97qliSopbGgWe4d5KnJwVlP3Jzj67VDW2
	 UHQJwJOp+rCb5fiG7i5P0d488N6ujnz7v+fIFQGi7wVVB3h+WJUbOADi0058TtrlUN
	 BpyFURvwNb34w==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b2e8d73bfcso78301eaf.1;
        Tue, 28 May 2024 02:58:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw3TFM22/+CtVssW6IiKBzt0wnynzkStWfvghC0TZhvtTDd0leqCaAlrly/YUV2cPyW1e69Ala2ELRTiaWH/1AgR+tzj/kSPlzeWxHjnFy9Sr5b0aqjeN3gs532/E2blpdDI/QZM6MrA==
X-Gm-Message-State: AOJu0Yx9WyiI4x/SilyLSAkrMRa9or4wK8JOD+YVneTClS6vtx3qed/j
	F+yU1Fs3MVJxOSRRQ4Jn9oeViw/TmbJBPdHupIwVqdvv8SBieM9Gmpiml/u37bHtm9JwabOZv3Y
	3MoaDwZ19wzwM8kM+sXOT8LqrJ3s=
X-Google-Smtp-Source: AGHT+IHF+56dLS6gXREGFzvGqwAVZQaHiMngD952WMn/XaX40vY9mh7dok9OOUgeknrGNlIt4REFMWiRAK/cTiMLv1M=
X-Received: by 2002:a4a:554f:0:b0:5b2:7e47:e914 with SMTP id
 006d021491bc7-5b95cfdd610mr12683799eaf.0.1716890330531; Tue, 28 May 2024
 02:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
 <CAJZ5v0i8N-SuKyzm1o601G-G9Jis4uciu3gxO-08GN-X-z0LUA@mail.gmail.com> <CAHp75VeOX3NqPxFWduRAXGhw8zDA1a4E1jk6L3DzvfjKX-KjVA@mail.gmail.com>
In-Reply-To: <CAHp75VeOX3NqPxFWduRAXGhw8zDA1a4E1jk6L3DzvfjKX-KjVA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 11:58:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQ4vaj88HVECyNon2Kyy=v6q0Bi+=+3TeA6LNE1Aq6-A@mail.gmail.com>
Message-ID: <CAJZ5v0hQ4vaj88HVECyNon2Kyy=v6q0Bi+=+3TeA6LNE1Aq6-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:53=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 28, 2024 at 12:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > On Mon, May 27, 2024 at 10:24=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > Since we have dev_is_pnp() macro that utilises the address of pnp_bus=
_type
> > > variable, the users, which can be compiled as modules, will be failed=
 to
> > > build. Export the variable to the modules to prevent build breakage.
>
> ...
>
> > > +EXPORT_SYMBOL(pnp_bus_type);
> >
> > Why not EXPORT_SYMBOL_GPL()?
>
> To be consistent with the rest, but in any case Christoph suggested
> something else, where _GPL is assumed to be.

Yes, that's even better.

