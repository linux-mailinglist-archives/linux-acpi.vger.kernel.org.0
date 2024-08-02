Return-Path: <linux-acpi+bounces-7239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D934945F7F
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508501C21375
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C1210191;
	Fri,  2 Aug 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmggag30"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091613C914;
	Fri,  2 Aug 2024 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609441; cv=none; b=RVkM0vfRPCKTRaEy3bUIgkTk99UJXZgWzi47R8ocxT9UXsusnP7dL1y/U8YDTXCRZBjE47ABbBfFP9zx+T5YQ9fx1xMJTYLZHhMvxmy1J3bNnj7hSEZu8l02DE3PZR2G//FOicyb4sg2ZX/+1tKrAQSNYCbcqL5FDgqkZ7r9plo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609441; c=relaxed/simple;
	bh=84ATkB8B4asG5M+/R80ikVc1JWFsWZfU8RMxzyrfnOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmkK5jofJ04SbhbFVt5qz57AQUKudhNYgcSNPI4DfG3g8GVGL0QhQJDD5t7VXkRIM0rj7MCJ/c2Pf40k7f/v7rnf7IPR9ULenlaIcynNG2q7a12WOSt1sFSsr9ZjL79oF0aaBmoXc77wgA3ib8+gLJCAJs3+VKUT5+PtqHfbzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmggag30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D15CC32782;
	Fri,  2 Aug 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722609441;
	bh=84ATkB8B4asG5M+/R80ikVc1JWFsWZfU8RMxzyrfnOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kmggag30gsrlRr88nKmFQkK4M1V7p49eZWjoq/7CR7mjIXsuH4gmGBPjXPEGeeGOt
	 1bvvSG7bwZjPvmjPSlPFltQD0y5Dyn08mH5gRTAdNIZWqTKS7Tf43iRtQ2DogkV86S
	 6bVrzkAU1J6dDEFEamgFLBavCPoEG0FMS2D78fl9p/CVbz+3Tq1JslAIvxgcF4Qekb
	 ASbQJdrltwFfS2yppTkzPh9P7QwOowGZhlhxyvsN7GssleHPrzRSvuvE82G3Ds3DM2
	 oHK5ZSpYjxBaDN2Ni+FivxMgBHMWh4RDswaRvAevnHh+tGJ9q2nOXgsiYuidgia2Vt
	 7GL2ChB8+5zwA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-26123e59c8aso988362fac.1;
        Fri, 02 Aug 2024 07:37:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWm0tpZuuXPck8GyLOlKuLV0U6O4NLDPjOdyE4kXttcd2r+g0EM7+G4WGNPL2/+487BvOajYqZqXHH0@vger.kernel.org, AJvYcCXHoatYI3gE4NEx8r4Z3w9Es4BDE4gKwJbbB0rHUN+0hB/Pa6WpV677IwOQwwWqXJTFiuelNnPG6f/FipUX@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVX959NZTeXalOVqabXX/kNUkx5e7wPWxQ+7LK9jjf5ScJoWE
	BPhL5EFdMsqH0GcGKiRt/taOHGYXYjK+R0U+og9qzmYCVDyXUQkwu/ILLfSnaCIDge9f1P6A2ir
	YsiHfInKRkAHvQdADmnVKjXEty58=
X-Google-Smtp-Source: AGHT+IGslD5DoBw3k9PPMxNqR1gezjEN7LyvsIkTN4/ytQ5GDbMHGLz7buiM7LDYdhidiDdjpgH4yf0eZ1L9OlabtNA=
X-Received: by 2002:a05:6870:506:b0:260:eb27:1b83 with SMTP id
 586e51a60fabf-26891e95c16mr2801876fac.5.1722609440720; Fri, 02 Aug 2024
 07:37:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706074505.9885-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240706074505.9885-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 16:37:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hK7JgS5UemkjE2sipvdeHA=jTqcgbj2gZTKH2kYsO8jQ@mail.gmail.com>
Message-ID: <CAJZ5v0hK7JgS5UemkjE2sipvdeHA=jTqcgbj2gZTKH2kYsO8jQ@mail.gmail.com>
Subject: Re: [PATCH] Updating a deprecated use of strcpy in ac.c file.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 9:48=E2=80=AFAM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replacing strcpy with strscpy.
> strcpy is a deprecated function.
> It should be removed from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> ---
>  drivers/acpi/ac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 09a87fa222c7..ad1427a384e4 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -213,8 +213,8 @@ static int acpi_ac_probe(struct platform_device *pdev=
)
>                 return -ENOMEM;
>
>         ac->device =3D adev;
> -       strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> -       strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
> +       strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> +       strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
>
>         platform_set_drvdata(pdev, ac);
>
> --

Please see this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D142acc42a7443f377b1a452ce906dc3adec91f70

and format the subjects and changelogs of all of your ACPI patches
that replace strcpy() with strscpy() in analogy with it.

Thanks!

