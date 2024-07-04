Return-Path: <linux-acpi+bounces-6766-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448BC9275DA
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BA91F23944
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622D1AC23E;
	Thu,  4 Jul 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Jf/G1w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B625779;
	Thu,  4 Jul 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095790; cv=none; b=ewWPmmKPL4IAtXCx1oNkhyFBNdd+BfCJdTXEeTHVnM6uPvSD73sfEyEHQ67A9WB1SXWdSfut4DunKAALNRPQxJpRGpTPhBiC6rTQvU5kveJTX8LTukWczkRKIhvzWywEraYXd5qEdiWrXN1RLqZEY88wUv6+hcypFTi4F5J21RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095790; c=relaxed/simple;
	bh=OBq3eQPG9TxPfc8abkT5qDvctPHPhVyt9XRVmZjHeys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcg5ojgGx95PtZF4G0z1H44zSqM70Fhgt2AoQbnfkx0sqYehgg2xmMJgKPT0o8UNVy67Fu9dYxcGE6giWMsY6xSTx+w70CDHCz/sKB06XGxbRsFB5jhvVtoX+RzMqoOoVQO71059t0shhNL4XzP54hHiokc5L2XXyMA9+F/PmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Jf/G1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F42EC3277B;
	Thu,  4 Jul 2024 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720095789;
	bh=OBq3eQPG9TxPfc8abkT5qDvctPHPhVyt9XRVmZjHeys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D7Jf/G1wodoKXYVvAEFAUFEH0CtnlNbXBhmsjuMz+GXUS0oRpMGot5WFf2aCSipaV
	 i0kMnSbztXhVkYJuBqLX837buvNqT5njOivYFUlTfCXAoz1D5tKTshYWQHPPT8pStP
	 n/5tpjAveCOEMeVPhKs/UZxCxx0ACd8SUZDk7Yk99UIkLSJ9XP5b5dm6RO3b9xdALu
	 48qmrKOL9OH8JCcE9pAdoaIQ5a625+bWN1QG6qoRll1xGpGbfZ77E6EVtyb3/MV6mj
	 OEmQm7wNahTQwAfGRrXSFiY+o3rI6VgGlKOlK3uppFIQfG5VnUMygKQ9gdFXwDbenT
	 Tm6k8o9SNvE5g==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d1b8bacf67so104874b6e.2;
        Thu, 04 Jul 2024 05:23:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGp4vAl/ChDSxYGxiniPcCss4nBh6c6+ZuQcDFk7tOKkZQUXhyc7jVX6vLT6Wbq9sxSWWeHcxWmookC57PL/ahx07wj0x3mPbOu9ZUiUCjJ55WtZ+VpunHKKWyKaO8KK6PK4T6UoX2Vg==
X-Gm-Message-State: AOJu0YwDyXRIaoYNrpoBzZO6Q5QWJ4KBY3uSp/Bs/pfBV1729NoEPlt1
	rxDB5f4Cp10R8NkLPVLyk1vKiUH+qPG94IXBOszbcllY2CXzVp7sIxHF2BydlNU/rCZsD+QCXVh
	Nl3pO7HMSXdJXUGG5MxwQIJMIrPE=
X-Google-Smtp-Source: AGHT+IGvsu7oRzVyox4mAN8dC55AZABk7sl5pDrzNy42RwZdz4te+sDZ9QcSbuMPbi0gg8Tx/rjqulFSpspWXJwKgC8=
X-Received: by 2002:a05:6820:2c07:b0:5c4:5cbf:a255 with SMTP id
 006d021491bc7-5c646a9379emr1295874eaf.0.1720095788913; Thu, 04 Jul 2024
 05:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703084124.11530-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240703084124.11530-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jul 2024 14:22:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyROLY9aR+5vqBWzwy3O0ncCapAYuAMp0X_HkWaj=ecQ@mail.gmail.com>
Message-ID: <CAJZ5v0hyROLY9aR+5vqBWzwy3O0ncCapAYuAMp0X_HkWaj=ecQ@mail.gmail.com>
Subject: Re: [PATCH v3] Updating a deprecated use of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:49=E2=80=AFAM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replacing strcpy with strscpy.
> strcpy is a deprecated function.
> It should be removed from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
>
> > Replacing strcpy with strscpy and memory bound the copy.
>
> > Why?  In this particular case, it is not fundamentally necessary.
>
> > strcpy is a deprecated function. It should be removed from the kernel s=
ource.
>
> > If the goal is to get rid of all strcpy() calls from the kernel
> > because using it is generally unsafe, just say so in the changelog and
> > it will be fine.
> changelog has been updated.
>
> > So is it necessary to use the size argument here and below?
> Size argument is not necessary as destination is an array of 40 bytes. Pa=
tch has been updated.
>
> > for that to work, shouldn't the size of the *destination* buffer be
> > passed, instead of the length of the string we want to copy?
> Yes, size of the destination should be passed.
>
> > Not tested, but the 3rd argument of strscpy () is optional.
> > (https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/string=
.h#L87),
> > so maybe just:
>
> >        strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> Thank you for sharing the reference, this suggestion will do the work and=
 accomodated in the patch.
>
> ---
>         v2 -> v3: Changelog has been updated. size argument has been remo=
ved.
>
>  drivers/acpi/acpi_video.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 1fda30388297..8274a17872ed 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acp=
i_device *device, void *arg)
>                 return -ENOMEM;
>         }
>
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
>
>         data->device_id =3D device_id;
>         data->video =3D video;
> @@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>         }
>
>         video->device =3D device;
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
>         device->driver_data =3D video;
>
>         acpi_video_bus_find_cap(video);
> --

Applied as 6.11 material with edited subject and changelog, thanks!

