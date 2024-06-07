Return-Path: <linux-acpi+bounces-6271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE0900C0C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93640B22E7E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 18:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C10C13E40C;
	Fri,  7 Jun 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ/KCLvp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24243AB9;
	Fri,  7 Jun 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786289; cv=none; b=VYt9JxMxw3C6gi01SNLNaQ0IdNXa57aCU02WnkyqWNCWz6Vdm1EGc0k0lQlwhkvNUvu8YBxC9X9eGxqRuZikNSGYN60ssWNadRYcPAqscuz4glwIH62beL7JA1Ap5SHEp5lrMqdCihU1HMKMfVxYk8a1AARIZw0/2lMDxISyFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786289; c=relaxed/simple;
	bh=cFzkODmuFdatFvol7eP8ZUj927zMJW9NOIP9knaSwqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBRdZVfIM3Qz/0lEAyEwiPbkuivZYEwI7SAgUAJHoPLH0g553U46DcV5QDyzEHaBh2RARbJ18TIYoSxJ7RhW4CHx8OgvqcrPboZUMzpGWUu3XeweR7HVWs6dj5C6Yy+miSOKjzYlpZtoI0yHl8b4aSq2LOrYjtzAtUKYHUUALP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ/KCLvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F56C4AF08;
	Fri,  7 Jun 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717786288;
	bh=cFzkODmuFdatFvol7eP8ZUj927zMJW9NOIP9knaSwqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tJ/KCLvpAQp9P+xzeq/6CkTDwAkNJUy20ikt9Y8mBnm4ySHuZfdPh5W+x/dBgqPNl
	 n53kEHEa1Mz9+CrEJYiOqvk4gpERRCGPpmiT1HuCMlK2Lzbn+SwgXuvqrLtCt0/LKY
	 jH2HYUdu7NsL2XMNo96hapMJTcxo1ZLaVyjRiwC69ItjpDANAuvxDKIjoqFknV4fw7
	 GofetUKQZsi6VdG2P9AmYokVhM/OMDpH4pT42jptURKeDio1zB0vRLtLQrzgOmdn9w
	 YJPmflr6C77QiIdBQhjz7rmpDIZc9xmhRDv2yZM9VYSBIzViMY2iRefrmSXXrTuUSP
	 cD88MlB6pC+Ng==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b3364995b4so388383eaf.0;
        Fri, 07 Jun 2024 11:51:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRkJUzxKiG48QCieMaPQ0+9YRntAa8He6i5DX7XKEIXmfhk1OwCezKiQQZyQRL5Eo2itk1Z/romPS6nbBC8HFeld3mvHcPg79w5jCPd9T6hEzSIhHP3v7MdTe2k+hrnwE3ExtonNG3fQ==
X-Gm-Message-State: AOJu0YzfulB5/nCMJZFsg1icpxMTPRKit7xDp7OpmT/+XUu4BMdC0g+J
	yVNTO/iS6vAkRj1ahOpOI6q4GrKQHlwDeKlDjQAXy66zI0xgm1L+vW/1ZNf67JJPlXuZcsmRR+2
	RwXMpSjZaJ1AGetDqh7FtxQMNygo=
X-Google-Smtp-Source: AGHT+IFsrjyMELPV1llaPxZb1cvGhLLxJKvmwyTp0MUABHmTP4LU0rIk0K5xv2Xq9o9QbrFspFa7s+sGnpxz0dgKb9k=
X-Received: by 2002:a4a:ac08:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5baae73b688mr3253417eaf.1.1717786287770; Fri, 07 Jun 2024
 11:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com> <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240528192936.16180-2-pierre-louis.bossart@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 20:51:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com>
Message-ID: <CAJZ5v0g8aW5FBbceYJDvDrMHRxT6i71O_LTWKALb=qr+m1BJ7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: utils: introduce acpi_get_local_u64_address()
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de, 
	broonie@kernel.org, rafael@kernel.org, vkoul@kernel.org, 
	andriy.shevchenko@linux.intel.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:29=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> The ACPI _ADR is a 64-bit value. We changed the definitions in commit
> ca6f998cf9a2 ("ACPI: bus: change _ADR representation to 64 bits") but
> some helpers still assume the value is a 32-bit value.
>
> This patch adds a new helper to extract the full 64-bits. The existing
> 32-bit helper is kept for backwards-compatibility and cases where the
> _ADR is known to fit in a 32-bit value.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>
> Reviewed-by: P=C3=A9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Do you want me to apply this or do you want me to route it along with
the rest of the series?

In the latter case feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

Thanks!

> ---
>  drivers/acpi/utils.c | 22 ++++++++++++++++------
>  include/linux/acpi.h |  1 +
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 202234ba54bd..ae9384282273 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -277,15 +277,25 @@ acpi_evaluate_integer(acpi_handle handle,
>
>  EXPORT_SYMBOL(acpi_evaluate_integer);
>
> +int acpi_get_local_u64_address(acpi_handle handle, u64 *addr)
> +{
> +       acpi_status status;
> +
> +       status =3D acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, =
addr);
> +       if (ACPI_FAILURE(status))
> +               return -ENODATA;
> +       return 0;
> +}
> +EXPORT_SYMBOL(acpi_get_local_u64_address);

I'd prefer EXPORT_SYMBOL_GPL() here unless you absolutely cannot live with =
it.

> +
>  int acpi_get_local_address(acpi_handle handle, u32 *addr)
>  {
> -       unsigned long long adr;
> -       acpi_status status;
> -
> -       status =3D acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, =
&adr);
> -       if (ACPI_FAILURE(status))
> -               return -ENODATA;
> +       u64 adr;
> +       int ret;
>
> +       ret =3D acpi_get_local_u64_address(handle, &adr);
> +       if (ret < 0)
> +               return ret;
>         *addr =3D (u32)adr;
>         return 0;
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 28c3fb2bef0d..65e7177bcb02 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -761,6 +761,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
>  }
>  #endif
>
> +int acpi_get_local_u64_address(acpi_handle handle, u64 *addr);
>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
>  const char *acpi_get_subsystem_id(acpi_handle handle);
>
> --

