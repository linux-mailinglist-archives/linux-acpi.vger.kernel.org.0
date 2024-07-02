Return-Path: <linux-acpi+bounces-6746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A227924848
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 21:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDED1C24B7D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449F1CFD42;
	Tue,  2 Jul 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0MQy4zz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D451CFD40;
	Tue,  2 Jul 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948502; cv=none; b=LaW8JNqIPKZFSW0O3Yi0qu6fbVfSCJJ0IW/mJ1XFyNdJpvH/lH7TTiJFx6F9xpiitmEXFRo0uJvNZhT2LYyq6F96IGbEH5f/JexcW1c95vd1vMXHOD1p8IXOwaezgN92/4sh7gVmzwtp1tHU9RPz+NwiESaRDg8Gkjx2IDbZgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948502; c=relaxed/simple;
	bh=d53Mhpa3K0NHA0txmiM9wG0bXC8iq/XIoY210mn1Tzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsSF/4bLqLLN8o/c3J34mUtMTeHisqrzBt7AAMM8AZmkO2DdmWzv+/9q+GLfmnfVZ+xnetY3aqA42nTqqOoSQPe/gmCQIqKMouANc1Lyoyq7xD/lO78Ot9Oap/DjuOTORuOvrCnCR9Br8zaObeqsqZ/yk71lSQgb0q7K9kTvowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0MQy4zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FBAC116B1;
	Tue,  2 Jul 2024 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719948502;
	bh=d53Mhpa3K0NHA0txmiM9wG0bXC8iq/XIoY210mn1Tzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0MQy4zzkvUMn7/yh2JMaaiWSgCflKaCuzeCY6BpnbwOEhVptWir6q3V2rR9RTH8t
	 cOSdvlQ1q1lnTIJO0CKNtvgd0143Gc78Id8oGPLimiLfmmTEPS2FQ60/2qXtl1U+iM
	 v36FKWuMKzi6eTsV55aSa8TiSjH+cqpAs99TuxGh9Ao4EWn1UQMDokDJJsdArmDWoO
	 i2XoGAj0jBvGXUkDJ/k5C6OzsyhKl3lFyZBapaRfIE9s9o6FzwymlJ7Xs58kGgsW4+
	 JNC1204oE21CLY0EB/iiGv/QC5nscUojMbrOtXIuBe2AIGwJIPIDh6C5qnxOMmeIqD
	 Spl9G0aIivz1g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25cd49906aeso590309fac.2;
        Tue, 02 Jul 2024 12:28:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWF9VL+MWGHsOs+aL4DcxvfSLjj5VyUDbV6gGRZrR0ZNWEblfW8fyUgNOjZn4nXyozl3jE9VSWNQareW2ZGOKgFBqp0frgMJWArzeq7rT/1fXrh2ijIRuaB8Etd2osatGDAgW4n64hDQ==
X-Gm-Message-State: AOJu0YxeUIt/yYe4NP4u0LWvLxekt4LpFetw9O2+CRNlPgAc9iKwEA6c
	LCo/QgtjbXw/3i1bl1PXX0xTHSca4cLSdOUUqiVSXlRIoLv0eezRmHmkCboz3Tn7Czw6fmVpAGW
	XgRl7+/KMqfbaIQYLOXgmRBslx9g=
X-Google-Smtp-Source: AGHT+IHv14pqGHYCsUwo4I6/73RApsIYCL242vkVHrSHAiljgO8mfJlUMTP9AZ0Ok1GXd+Y/mre3u2VlJ6FHTLhFN8A=
X-Received: by 2002:a05:6870:2892:b0:255:1fea:340d with SMTP id
 586e51a60fabf-25db3049d93mr9852571fac.0.1719948501560; Tue, 02 Jul 2024
 12:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702185523.17716-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240702185523.17716-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 21:28:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOKf1kv9Zj+wo5BE24ApftNrpgxuYPbZ2e_PtiqxpDJg@mail.gmail.com>
Message-ID: <CAJZ5v0gOKf1kv9Zj+wo5BE24ApftNrpgxuYPbZ2e_PtiqxpDJg@mail.gmail.com>
Subject: Re: [PATCH v2] Updating a vulnerable use of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:04=E2=80=AFPM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replacing strcpy with strscpy and memory bound the copy.

Why?  In this particular case, it is not fundamentally necessary.

> strcpy is a deprecated function. It should be removed from the kernel sou=
rce.

If the goal is to get rid of all strcpy() calls from the kernel
because using it is generally unsafe, just say so in the changelog and
it will be fine.

> Reference: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
>
> > In what way exactly is it vulnerable?
> strcpy is a deprecated interface (reference: https://github.com/KSPP/linu=
x/issues/88). It should be removed from kernel source.
> It is reported as vulnerable in Enabling Linux in Safety Critical Applica=
tions (ELISA) builder.
>
> > Why is a runtime check needed here if all of the sizes in question are =
known at compile time?
> Runtime check has been replaced with compile time check.
>
> ---
> v1 -> v2: Commit message has been updated and runtime check is replace wi=
th compile time check.
>
>  drivers/acpi/acpi_video.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 1fda30388297..be8346a66374 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acp=
i_device *device, void *arg)
>                 return -ENOMEM;
>         }
>
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME, sizeof(=
ACPI_VIDEO_DEVICE_NAME));
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_=
VIDEO_CLASS));

The strscpy() kerneldoc comment says this:

 * The size argument @... is only required when @dst is not an array, or
 * when the copy needs to be smaller than sizeof(@dst).

So is it necessary to use the size argument here and below?

>         data->device_id =3D device_id;
>         data->video =3D video;
> @@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>         }
>
>         video->device =3D device;
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME, sizeof(ACP=
I_VIDEO_BUS_NAME));
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, sizeof(ACPI_=
VIDEO_CLASS));
>         device->driver_data =3D video;
>
>         acpi_video_bus_find_cap(video);
> --

