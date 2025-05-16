Return-Path: <linux-acpi+bounces-13752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42909AB9E68
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255F51BA1F7F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B678F5D;
	Fri, 16 May 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw1gTVs/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CA2B9A7;
	Fri, 16 May 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404956; cv=none; b=D5FbGsQGqUbt1FsQy4wY3tNdIiDfgYN3Xl9X6JIQY15RKa1v4lSWwE5T5hKUbTkniKsmYJBhftn3YHEALDMKA4VzRLhxaEHXWiuXAnCZ4F5rX0wUl4u01rept/GvJbREY6YbsV2M7srt5Xa/1gUR/ApHC9ltfrkRIo1kkHzOQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404956; c=relaxed/simple;
	bh=JPP6PZVPCyPpBi7NX7odUW7qXIUoGkCGhRHKl7+rxGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNWiACblEO8OV+EoVJsm2VTLYafGOb59ZqNtE6NueZacRLoUrzHMmURsg0lmlFd2EsKQ3M9EG6AkB4osyJqHuD78jYBG/NXNrPdIz/UR4N4FRR3Iy11qOQVxLoQZkacy+kPBG73Pf4DKF8pDsAf9MU+nImq6VndGOG9/sX4zNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw1gTVs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFE4C4CEED;
	Fri, 16 May 2025 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404955;
	bh=JPP6PZVPCyPpBi7NX7odUW7qXIUoGkCGhRHKl7+rxGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dw1gTVs/jf57SCOW6Wymkm1DyWIU7m/KHmweRe48yAnCuwGNkrr+xIx9LK8fX1j0V
	 7yFdIZnwEJ7TLBP8M+buGhUc+/6YNsrYA8yZnxcxY38ddJQSFb4ivK0M6ADp4Cs44W
	 3i013u1Qd7zcOk1Tiu2IZDmJSRXNoL4ElfJTsIWgkVjeK0P+hZBgADKD4VjulusLQd
	 a0nMqe5bBzYUcDa0j00Mkbk24yoVfzHVGNIM8msBTvyezmkC0zmvEzAHpBIr8PgJVI
	 UQC30myGs6a9R3Js4QfEEmHKNRPoUT6nH5Z1U5WfP30NFfoswM/FFvYtL/xWIlSd2s
	 B6d1r2+IW0Nag==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-404da7584adso484098b6e.3;
        Fri, 16 May 2025 07:15:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKjW302dGKehL6J9xWv/oSwmd09csOOOuO5pN860SYOF97phZNnyDr3FiYMuVqPJiSCYf3Qvo9a1yM@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBjWgcxYs3ZXHYJaqafmVHGqkNfB1495hitw8lq9Myjw99tkH
	mVxwKTnhxXD6hTMv7WPISCKzz67V8RT8Uqg8oWe8ahN9PNig2e6SjqeHL/29PUrH+MF2ZJ40JRp
	RErtd9hSSKJx1vGvUeFcS0uhrfdsLMs0=
X-Google-Smtp-Source: AGHT+IEifMgJi4I9KIB7g9la5wpxkudYHh/KMp5hArruRNgMVIpvFmFB7Kl/JfKlT61P+OJfapZDeIhIDy2BsGE64us=
X-Received: by 2002:a05:6808:6a89:b0:402:862:93ae with SMTP id
 5614622812f47-404d86e321bmr2322505b6e.16.1747404955135; Fri, 16 May 2025
 07:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com> <20250514055723.1328557-4-sunilvl@ventanamicro.com>
In-Reply-To: <20250514055723.1328557-4-sunilvl@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:15:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVvDZJFxcHG6x23G4_88DE_A9JLx0o7ejypNv=M2Qg6g@mail.gmail.com>
X-Gm-Features: AX0GCFtlXnPveldiowmA4mqsiA61H-XtjgSSx2COK0UFQUnxxpWloVNNJI4sskQ
Message-ID: <CAJZ5v0iVvDZJFxcHG6x23G4_88DE_A9JLx0o7ejypNv=M2Qg6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 7:57=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
> Add support for RISC-V as well.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

This is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please route it via RISC-V, but remember about the dependency on
the new ACPICA change.

> ---
>  drivers/acpi/scan.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..70f57d58fd61 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/acpi_rimt.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/iommu.h>
>  #include <linux/signal.h>
> @@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *=
dev, const u32 *id_in)
>         }
>
>         err =3D iort_iommu_configure_id(dev, id_in);
> -       if (err && err !=3D -EPROBE_DEFER)
> -               err =3D viot_iommu_configure(dev);
> +       if (err && err !=3D -EPROBE_DEFER) {
> +               err =3D rimt_iommu_configure_id(dev, id_in);
> +               if (err && err !=3D -EPROBE_DEFER)
> +                       err =3D viot_iommu_configure(dev);
> +       }
> +
>         mutex_unlock(&iommu_probe_device_lock);
>
>         return err;
> --
> 2.43.0
>

