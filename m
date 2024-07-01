Return-Path: <linux-acpi+bounces-6713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3C91E672
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5E9284853
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFBC16E895;
	Mon,  1 Jul 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P79/qf96"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65C2B9DD
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854361; cv=none; b=AoOvaR7Zbj0BGaKZz+RTJB+xyHh0JRho1GH9NnpQ5g6kUQekVxoKFtHafapUaMkR2+tlRhXFLMGobFDDlXLKUcagRnQUfkj+o0MeFDNbt5pxGJGFj1FdtCchfvmk1jMZ+w/0SjwmEiYjZiS+hN3e9bHbR+66pEqO9vpYJqHStAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854361; c=relaxed/simple;
	bh=Kfv0+YoV7ifqmbjU8ljInpu/bEz4//M+sgoP3/oS8bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2KX0Y+PMOAKtvB/j+c2RVll0XLvcR5GAgfXeK6V32Afe6yu0G2jf0JpWS7MX4TdB/bhF2DO07oEZZkIv/hN4iYOqOwUY1AAC8whthE5BISahC+2rztYTANiEfD4E0KXWyfod5gCsIpOU9xqlv0IurNf9UzVccvC9T8QHASbFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P79/qf96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3508EC32781
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854361;
	bh=Kfv0+YoV7ifqmbjU8ljInpu/bEz4//M+sgoP3/oS8bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P79/qf96F6IthbD/KBYs/ozHPXbJD8hYaVFMXlE3ZH2s61NE4+jVXZQmmIPXq8OSy
	 1WrV0W7CiYn0vzSmqKLSoE6pryftL2Ya6muApAYElJOZdZxolsH2c+ICP7ym88Usk9
	 I7OL+Jr3xx06JIUIsxeJGmzxBaxr6WsIQemwiL0ROszVQr83fWVk6GWBmO+x8g+4zo
	 Xx7ED7i+twLsKzlIuiobNaWt176/6CwFNKpuD5hWSbQWUKicrQvAzfTvRVL6PvWlow
	 /SzKIKmQglOEt/W8QCEXtvu69872F8JJ/BuzrOWXESUa58Dh9ovcbKQ5SLMNbrqAY4
	 DWhRRfanj7f6g==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25cc44857a1so347321fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jul 2024 10:19:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyO0ZKRJcqwurvAOzhKOen/ABD1tf8nENBBoKl3UjUMDh9q7rnN
	bHLXH+MJ3HreJ/vuniuEubXXV6STpXbJfQ9N884SnGR8ULRCe4eYI+lGcDxrvVJKfy68tDUUEuU
	OxpbcJHpQPFl6SFbHrpSN+DxmD3Q=
X-Google-Smtp-Source: AGHT+IG0YywG8/C/hGKq+FCti6ffLeX5riYwUchom/ZIla+Sz32Zo0zRwnZopsvR/dcCC628jtlk68zSGXoSG0FM+qo=
X-Received: by 2002:a05:6870:b155:b0:254:d417:351f with SMTP id
 586e51a60fabf-25db338f8f9mr6780054fac.1.1719854360480; Mon, 01 Jul 2024
 10:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130941.1527127-1-prabhakar.pujeri@gmail.com> <20240626130941.1527127-3-prabhakar.pujeri@gmail.com>
In-Reply-To: <20240626130941.1527127-3-prabhakar.pujeri@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:19:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jC4QpSB553QY+jsob0i6dyMuECj9Lw965uCEHD8rMPYA@mail.gmail.com>
Message-ID: <CAJZ5v0jC4QpSB553QY+jsob0i6dyMuECj9Lw965uCEHD8rMPYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: PM: Use max() for clearer D3 state selection
 in acpi_dev_pm_get_state
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:14=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@gmail.com> wrote:
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/acpi/device_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..a90ae059fb60 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -760,7 +760,7 @@ static int acpi_dev_pm_get_state(struct device *dev, =
struct acpi_device *adev,
>                         if (!adev->power.states[ret].flags.valid)
>                                 ret =3D ACPI_STATE_D3_COLD;
>
> -                       d_max =3D ret > d_min ? ret : d_min;
> +                       d_max =3D max(ret, d_min);

You need to use max_t() here.

>                 } else {
>                         return -ENODATA;
>                 }
> --

