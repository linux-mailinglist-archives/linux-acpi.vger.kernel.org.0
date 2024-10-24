Return-Path: <linux-acpi+bounces-8950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8649AEA89
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179561F22B84
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2024 15:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED71F585D;
	Thu, 24 Oct 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnxYmXPM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303B1EB9F1;
	Thu, 24 Oct 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783992; cv=none; b=fRFL2nAnoLpknzuKOqRz9N9xg8NN2Z14M5DAzzfmyV1V2PknONUzbXZlCSnHxITo7lxkw/DXbAaOGgl3BNi4u+mw/amxhZdcLmO2LFJh9DHaLD5otTlQCpvbGPAX06xCXWtDUfvu0bj0ZViM5Oav5NAIJNc2e1WtAANSsJYzMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783992; c=relaxed/simple;
	bh=AYpxmCYf4yOv//CjOmlSMozXI31Ms0jTW1lstb6nXqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHzJ8eik1uwPtVvP2vYLGa0DoJy2uytI02ZHDPzEWlhvtsVTvFqvud2JI5rFHZS39z9JDTiq19iHF3fPOVYYb9sqR15KTuiXmfNLNe6JbQ/SEWKiHkc5d4/FiU99b81rZ47SfiGiwqtRy6ZdykYr73n1MUVHeppnad6FDVuMIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnxYmXPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5523FC4AF09;
	Thu, 24 Oct 2024 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783992;
	bh=AYpxmCYf4yOv//CjOmlSMozXI31Ms0jTW1lstb6nXqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mnxYmXPMxovdMM5V8rY1VOmlQ5f1j4D+O5UIjdBV92UryftCoY5CLm8MgnCWAqYp+
	 ++Q+LZHq3sFHc0f2TebowjP/m2V28d/AIqPcsRwTygGIQ4LgiCGW18Q0rAAOO5VMZw
	 q4qd/iM6ZMSkPscTsyFBC3IuiQmQnFeEjGbsxUiJhX5SyqREzoGeqSzMn/3hX8SbCJ
	 5z0Nu1beCSWO1de1YjgpW2EcJaE5QreblxQFekcVhrNOP7Lbazs9RePwk2TMAEKuAo
	 Xta3oYjxxsjQYqYbsQ1ExHMcMtnl6GSKSqZ+vb/ZhI19g/PU7IcRZ/FkkyRZkGxRZp
	 weYp5pCnQRPOQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288b392b8daso590847fac.2;
        Thu, 24 Oct 2024 08:33:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYGllIiiN3gV6i1ZHD7WJ4F8lKCvTyelslBpe0BEK5e+V16oqfNCsZlDMo6B6q7AzStiSGiJTsid7qylXN@vger.kernel.org, AJvYcCVnA74DsS+pYtKwN+vASklPZsSJJ15DzxPGoWXiqY6EDV1+lsN9h1mrLzY2OSzORewehViZ9KCFzkz4dw==@vger.kernel.org, AJvYcCWm6JtpM5dl1n/h1wCznRtH3srwWkVeEUWyywUkEcRM8Gjx0GNQD6WzerNjS2dUKdJZgbltVRAi2kJdYuIrYuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuy8lQtpkOv1FEWXxNe1a/kWe7TmfPU1iCsnU+A4oz/nl5/J7U
	qyd7AUxUT5YwbrQzUs1ljS4wAse1dull5IJSBpdcQMwOOPcDdr92JviRozC6IKKtFPrC8qhJVWp
	aTc5RnH1ZduTRs3VyzXAk8AbM5M4=
X-Google-Smtp-Source: AGHT+IH313pouYkwWOQ0XbO6cOPorbYtAPn3/0vID9VvN/xAHi1DE1RQQZjoKFUKDNXDkjG64OB1oPtQ9hYDSVIEkwQ=
X-Received: by 2002:a05:6871:64e:b0:25e:940:e934 with SMTP id
 586e51a60fabf-28ccb9e51a2mr5302878fac.47.1729783991514; Thu, 24 Oct 2024
 08:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3777d71b-9e19-45f4-be4e-17bf4fa7a834@stanley.mountain> <CAMj1kXFRUhkCyN0PjLrtw1uSCuy4m=9g=pwNO9tkxckj-koijg@mail.gmail.com>
In-Reply-To: <CAMj1kXFRUhkCyN0PjLrtw1uSCuy4m=9g=pwNO9tkxckj-koijg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 17:33:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhp8u8xz=GYF+ePzLjCtZ4KrUzNhA0HTdSPoFcE4q8Ug@mail.gmail.com>
Message-ID: <CAJZ5v0jhp8u8xz=GYF+ePzLjCtZ4KrUzNhA0HTdSPoFcE4q8Ug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PRM: Clean Up guid type in struct prm_handler_info
To: Ard Biesheuvel <ardb@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Koba Ko <kobak@nvidia.com>, Len Brown <lenb@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Thu, 24 Oct 2024 at 10:07, Dan Carpenter <dan.carpenter@linaro.org> wr=
ote:
> >
> > Clang 19 prints a warning when we pass &th->guid to efi_pa_va_lookup():
> >
> > drivers/acpi/prmt.c:156:29: error: passing 1-byte aligned argument to
> > 4-byte aligned parameter 1 of 'efi_pa_va_lookup' may result in an
> > unaligned pointer access [-Werror,-Walign-mismatch]
> >   156 |                         (void *)efi_pa_va_lookup(&th->guid, han=
dler_info->handler_address);
> >       |                                                  ^
> >
> > The problem is that efi_pa_va_lookup() takes a efi_guid_t and &th->guid
> > is a regular guid_t.  The difference between the two types is the
> > alignment.  efi_guid_t is a typedef.
> >
> >         typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> >
> > It's possible that this a bug in Clang 19.  Even though the alignment o=
f
> > &th->guid is not explicitly specified, it will still end up being align=
ed
> > at 4 or 8 bytes.
> >
> > Anyway, as Ard points out, it's cleaner to change guid to efi_guid_t ty=
pe
> > and that also makes the warning go away.
> >
> > Fixes: 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM =
handler and context")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
>
> In case this wasn't implied already,
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Applied, thanks!

> > ---
> > Sorry for the unfair Fixes tags since you obviously aren't to blame.  B=
ut it's
> > more practical if we avoid breaking the build in backports or etc.  Fix=
es tags
> > are quite often unfair in this way...
> >
> >  drivers/acpi/prmt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index d59307a76ca3..747f83f7114d 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -52,7 +52,7 @@ struct prm_context_buffer {
> >  static LIST_HEAD(prm_module_list);
> >
> >  struct prm_handler_info {
> > -       guid_t guid;
> > +       efi_guid_t guid;
> >         efi_status_t (__efiapi *handler_addr)(u64, void *);
> >         u64 static_data_buffer_addr;
> >         u64 acpi_param_buffer_addr;
> > --

