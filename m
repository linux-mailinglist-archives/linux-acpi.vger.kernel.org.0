Return-Path: <linux-acpi+bounces-8223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD4974237
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 20:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773BC1F262A5
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1C1A4AAF;
	Tue, 10 Sep 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUV+xCb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791413B5AE;
	Tue, 10 Sep 2024 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993067; cv=none; b=s86s9wYuOtDKSTG38YprBe6IcqQmUp9Tzv3QxSqSgKp7GOdRVE2ZyVyCL8RqVfWWxeZcIdY0p1Fi/DZES1fQZtGJNEkWm2Ktf3JvnJRJx88MvQqkexdgT9aTRFVfD4fguOgcJhx7bC4eeHuyuMvrtkNU+HQXrJuMvtgQ4Z737ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993067; c=relaxed/simple;
	bh=w2/Ur7uC7+aBCz0aONUWb8rN40NGu4OSi3QAeaN5Rbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlLX1OBgCBwR7DC4jQ8iRdoIjkaHTaN1Kx9RJBgE3+3FD57rcG10d1o1yh0QQBmXRHO4sJYmgDKxfVBhh+Cn4NB/GI8PwAUE8dO7X1YR77EDCD7xmsz+0AjTDRdg+9B2EFDMXMgNBIBBL0TWbRAiIH9HUXiuEkJkTFPaBCd42JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUV+xCb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD34C4CEC3;
	Tue, 10 Sep 2024 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725993066;
	bh=w2/Ur7uC7+aBCz0aONUWb8rN40NGu4OSi3QAeaN5Rbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aUV+xCb/RqEyY8lGL5iFnaXl4oi0kNvMMXAwQwYgwnZd6JLW0IAEoX7JqXp3cNxug
	 cuJ5PyC5X5LX+Bio9IYJn63t2nfNkSSYWrpwxZeWzqCSbSZY8FndiIzMMWnsTS/x3R
	 LkW7xwEd/vzQOaMblNYAWAhvFUojneBsI8XZLdEVvRgOSF0s3irGfGfHf3fzrXzo/L
	 +XrKiMdcCMJBjYD+gek90omf/Z+gIzm/p/AjcfTeGsKdE0SkuyGTbIDtvYwqHyFuhc
	 4GtYZYRE6m3EF8MgFYqGMosX617KW4fAgYXicPXQmrRXw6mPJ41sNKyOmSsvc2Av21
	 lKOKFC309Op5A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e1b35030aeso2886429eaf.3;
        Tue, 10 Sep 2024 11:31:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWjCT/rY7qDIIeVXLSVabM4+N2uK8Fs+uwXZE3FdgCwRhyiRv90c1gJMKBxJ68ZNK1smsd5vpkG6FQ@vger.kernel.org, AJvYcCWlMS/lkbbPoB+sYLpTXh8sECfRMwKB6ueA8n10Kf1o3aiaeXIR0gNITRHZvBkjcqMwMVmkdtF9da+rBT2a@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6pmmxigMKrld5ExykbHVda+kJGVItskjrLknnQE29MPZCMV2
	vm2RTpZ7gPBiOdEmwAv2otgxBilTzKvOamGvQMC1VjK3v+G8jVYrHiTOe+WHjxHOAcEiriQK+7q
	9JR8+r74za8WS7LA/w+h91Gd/mVw=
X-Google-Smtp-Source: AGHT+IG05vyBkVOeCELr57cYb+nUGt28dWWP3c9FcccL+auxRftxsTZrZ6nq5hSs0goGRLkmShGI2tkYwjUmYOJVCDc=
X-Received: by 2002:a05:6870:799b:b0:278:986:1e44 with SMTP id
 586e51a60fabf-27b82e12204mr15424505fac.18.1725993066191; Tue, 10 Sep 2024
 11:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910094008.1601230-1-wse@tuxedocomputers.com>
In-Reply-To: <20240910094008.1601230-1-wse@tuxedocomputers.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:30:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gL8ZapHmhBHxcuYT+A93X=zJHvAf3nkLLBh9E5og7JcA@mail.gmail.com>
Message-ID: <CAJZ5v0gL8ZapHmhBHxcuYT+A93X=zJHvAf3nkLLBh9E5og7JcA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: resource: Add another DMI match for the
 TongFang GMxXGxx
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:40=E2=80=AFAM Werner Sembach <wse@tuxedocomputer=
s.com> wrote:
>
> Internal documentation suggest that the TUXEDO Polaris 15 Gen5 AMD might
> have GMxXGxX as the board name instead of GMxXGxx.
>
> Adding both to be on the safe side.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/acpi/resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d0f29..b50fc5c16f749 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -545,6 +545,12 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
>                 },
>         },
> +       {
> +               /* TongFang GMxXGxX/TUXEDO Polaris 15 Gen5 AMD */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
> +               },
> +       },
>         {
>                 /* TongFang GMxXGxx sold as Eluktronics Inc. RP-15 */
>                 .matches =3D {
> --

Applied as 6.12 material, thanks!

