Return-Path: <linux-acpi+bounces-20337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B727D204FF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB64B3008D43
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206FD3A4F29;
	Wed, 14 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC0i16fR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A52441A6
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409299; cv=none; b=jJrYLw27yUhPQCbr7ouGLJt35akjpYk0nvG54Sjvj0RtuzYCSC7ni7yJmetEgeVUyxxTJ3FY6e3D1KVjJnqO7OYqVVtLHgNOKDZO5LpqQJunXdkoqGyj08CPCktS0KeiMGjFEC4GRxkB7qIvapv8KkEtfw02mtLn4mAielbAguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409299; c=relaxed/simple;
	bh=MiLcr3TKt//wLpnljySYy8yHfqsFTihF42uOu5rhE1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQmLLUQvlL6/jliPEmD67OXF9HCIyQq6xUAlqCJ66tM1eWKSolB0Rrfi/1r/XViedvyIj4RD6IumPbMAqkSlIAXTw1rPu5eLsx5W5WRQWTni2F6/JggWk4a37BRT54TvgjaYlEtrQdanyoKQFPD+dW2f4T6oITLOCbjX6psJC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC0i16fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAAC2BC86
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768409298;
	bh=MiLcr3TKt//wLpnljySYy8yHfqsFTihF42uOu5rhE1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PC0i16fRiLYddoETv81zHWd7AEvZuUKuuMDYYwaKpbC15l/oGlxXF5fYOLHVcf7Cx
	 J6M1qXKVQc9le44eSzd54E8lH3Vj2A1fcdo0wXfoLBCDCYxUzOKxjED1F6BQwzLjKd
	 J8W4A2Ip6VfBDjCAogvvGvNCPsXmyxUZp4C8dJ0XS4sCHofv0daLdydhYfX8llKN9a
	 FG7M1lwXNWW25tkuwLE1ZprlOl4m5NEGNjbouSnZ3nE7vsM+hfnzzpbysWjq9AcuVs
	 6FCjDVLc+2R37j4ds0rUpwleu9UJ5KNmt+QhUB1d3XvbOtAZRSH+QqCchiYa6W8IiH
	 Jl0Mcouc6uk8g==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-455ddb90934so2809266b6e.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 08:48:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+xj/oR+X1skqrChKH7uLVsV96vUnGaF89LmcbMFFxtiIHb+67kdkF1+5K6M40GNbsc8670ssnuRjW@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQU81oE/a5J2dOCBr5ZbmVatEKwLqB0pPWm+4HgUmWMMQAOmj
	OUh/EH0ewKgpSohxRiS/HcezX+CsW5fmrCiSLPLKLwjgJ7LFOREhu5RLsSeXBsNls5BIPeOArqe
	V2JFAnlXlZh8FtzGaGPRGLoCJGTwFnm0=
X-Received: by 2002:a05:6808:c16c:b0:44f:6e2a:ace with SMTP id
 5614622812f47-45c73e33e0amr1746056b6e.52.1768409297839; Wed, 14 Jan 2026
 08:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125064702.3666149-1-lihuisong@huawei.com> <20251208163459.00000842@huawei.com>
In-Reply-To: <20251208163459.00000842@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 17:48:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hh79=BgBDAvYE1L3ncX58Mn=U53N_rYhA1a8ObAn_OiQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgrn-1P1YxlHb2BkNw0DTyu_EIpzAhmnFakWpKrYyi8hUQ5_bwVW-TPy-s
Message-ID: <CAJZ5v0hh79=BgBDAvYE1L3ncX58Mn=U53N_rYhA1a8ObAn_OiQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Add debug log for the state whose
 entry method is illegal
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Huisong Li <lihuisong@huawei.com>
Cc: linuxarm@huawei.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, zhanjie9@hisilicon.com, 
	zhenglifeng1@huawei.com, yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 5:35=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Tue, 25 Nov 2025 14:47:02 +0800
> Huisong Li <lihuisong@huawei.com> wrote:
>
> > According to ACPI spec, entry method in LPI sub-package must be buffer
> > or integer. Driver will disable the state whose the entry method is
> > illegal by zero flags in struct acpi_lpi_state. The entry method is
> > very key in cpuidle. A debug log is very useful developers.
> >
> > Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Seems reasonable to me and debug is probably appropriate error for broken
> firmware.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Applied as 6.20 material, thanks!

> > ---
> >  drivers/acpi/processor_idle.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idl=
e.c
> > index 22909fccf0b1..5f86297c8b23 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -946,6 +946,8 @@ static int acpi_processor_evaluate_lpi(acpi_handle =
handle,
> >                       lpi_state->entry_method =3D ACPI_CSTATE_INTEGER;
> >                       lpi_state->address =3D obj->integer.value;
> >               } else {
> > +                     pr_debug("Entry method of state-%d is illegal, di=
sable it.\n",
> > +                              state_idx);
> >                       continue;
> >               }
> >
>

