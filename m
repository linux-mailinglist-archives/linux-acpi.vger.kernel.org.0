Return-Path: <linux-acpi+bounces-6928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDA933CA5
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 13:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A901C233DA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9A45009;
	Wed, 17 Jul 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajrDyLiK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983571CA9F
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721217353; cv=none; b=e4gvHfulsbt3Va+eM74qdEEJW1o5z06DhVrT9fdejuRAHJA+S/Zze48b9nzIMHnh5VME3j8KZurBLz7UObmGcX3XCAJI15cpoXwwaoT+o6FsqLZXsPK9sd1Sd7ZjW8vmsL/rypanxPLUS2BZNxA5u5XhsrmfrmRs9U0GE2XTa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721217353; c=relaxed/simple;
	bh=dGjbIHhjy0gIubxn7N7Zxd8O5SjCDoQuIKFOQccf5GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0Uiv1NPg2+gKi+ZjuUTGYNKyIp4V/nswUJtKoqHzjp8tW8edsbkdGkn1x96sRSBVBCuK/qlsiI7wCD6VN30P6RNZ6ZIoaf9fxHD20T6n2qHMbHtBBJ58RufsEA9c13T+9q+ALKFWX5jMbGv7J3+NGshIwjrF+J72r9G7toDIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajrDyLiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF2BC32782
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2024 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721217353;
	bh=dGjbIHhjy0gIubxn7N7Zxd8O5SjCDoQuIKFOQccf5GU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ajrDyLiKINrta+suZVIfBikVUFECBDNyrkqqVXQB7NNXJr+0KZ7NEPK7FW/gqGtop
	 TKL/NUzV0kbTvOOYrAIzSm2+cyg0MqvOwqPBkYev/2wwWWeSJjw13mJTgP8O9qkeFH
	 zeU/AOGJlBp53KaQRpAqrWl4F1BlFNY8cmuIocEsUtR1k/csvb1xGwNg8PSC+YpRKr
	 kRA3PTu1H7tMyvlub8dxiQnomub6kMeWdeodcbS/J2VUvaFPALgHTLiRKDYpVVjRsI
	 j4JGLr1Tj3MztCB1l5G+3LoONsHDb+FzJ/Fc9G6rwpRR/e8NvJUtbPXM5J+Ch0CLct
	 0zUoakYX+VUYg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6927d1969so16329eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 17 Jul 2024 04:55:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUV4Z1pZH6ebrBdiaD+mMc4dJI5c31GXAl1TND8+RVNtQ1vDb6
	qF0RCZLxh1CYP6LmMUJYenRm+fx9lReS/HSM+DFEMeV2iztDkSA7aBXmr1nt6bib/UJ/TgJ5JaX
	E4LdW9DLRtVMPGMscrDmVY5esKE4=
X-Google-Smtp-Source: AGHT+IG5mk+UG0Pu6wQJgpl/V2cvYyd1WmEKhH7/G0e0smCpCpXBVZ++oG77BpPsCtsyPA0jpFbaeGuxlH52PqoWMhY=
X-Received: by 2002:a4a:e40a:0:b0:5cd:8f2:5c8d with SMTP id
 006d021491bc7-5d41ae74ffdmr999365eaf.2.1721217352499; Wed, 17 Jul 2024
 04:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716143839.584288-1-prabhakar.pujeri@gmail.com>
In-Reply-To: <20240716143839.584288-1-prabhakar.pujeri@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Jul 2024 13:55:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2xVNO0JanHmK4XM+SyB7HTvKisRhDMoJycnx=gFgQaw@mail.gmail.com>
Message-ID: <CAJZ5v0i2xVNO0JanHmK4XM+SyB7HTvKisRhDMoJycnx=gFgQaw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: PM: Use max() for clearer D3 state selection in acpi_dev_pm_get_state
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:44=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@gmail.com> wrote:
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/acpi/device_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..81fc266ef18a 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -760,7 +760,7 @@ static int acpi_dev_pm_get_state(struct device *dev, =
struct acpi_device *adev,
>                         if (!adev->power.states[ret].flags.valid)
>                                 ret =3D ACPI_STATE_D3_COLD;
>
> -                       d_max =3D ret > d_min ? ret : d_min;
> +                       d_max =3D max_t(ret, d_min);

Does this compile?

>                 } else {
>                         return -ENODATA;
>                 }
> --
> 2.45.2
>
>

