Return-Path: <linux-acpi+bounces-3981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E4869C7F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 17:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13031F24214
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Feb 2024 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8A4EB39;
	Tue, 27 Feb 2024 16:40:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193D22337
	for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052031; cv=none; b=I0AcZ8wGXk6MnWxu4zVpmop5ftB5XpRcsrbFAbnEI4VPgLS0/iS9DGQhd6jYq6LxBSRN6FgnWqzJRv7hU4QSu3rHxYlpsyi6yo7ubMqrnbmeR6t8KADENmsOiSEiOUVoFxnpsaOmwS2/SNXtJPV/SogqxahGAOsntYCiEZD104Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052031; c=relaxed/simple;
	bh=Sl5Brb97/GQ1VKcZVF9OsZqvjPbQZ0ClksFl19qa/ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMl4MqDMZhl/Ugi1kelEK2LtHbB8UrdWfSvsrBuhS/OafDh0Eds3v4bxqsfrO60ey81aYpYdMYvq+0HbrB6E1izcBHzG5gcAlGbt6v6OHEQdnsoLWmPtHnzKG+5yM4B1ieveaZMgp69g0EcOFgBoif7t8bgBx/eG4+B7vV1WcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e45f7c63f4so453727a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Feb 2024 08:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052028; x=1709656828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn3Jp5ZK1ROXp4S11XCbijpyOqJV2e0J/Iz4WkUARXQ=;
        b=c7V2goEVmy4mww0d3PWicYzgEQCx2SPVKukJJ2SmxJkg3ARHD/zoQYxb1Ay/zoveMi
         EvOAwehO+eyUXS9gTnDlOifygzuL8CChC7DeLkBMsl3rf2lDceErquVmRLWzVbLgGSlX
         R6KNxggZG4Cb6PXP2unZRYp+fzbKJ5HPcPWc1utx5l1/Eyj8u5h7wK/nmq/Nq4zPC5cv
         9FtAdhbGckjTh9+x5oHNjaMdIw7ueNdMwOne3LZ2V+lPptn4B4NLL+98b7RgCY6loEGL
         qgEk+aOqWRC5bF/xjLh4y2qCZG76x6DFUzLumYoQy/mj1VYphsQCt/MFFN1a+d9A9q4i
         w11g==
X-Forwarded-Encrypted: i=1; AJvYcCUl2epbOVhZdQXI6PJlFt70bkBtFDOE3HWkpUV/9D016ayeuCYs2e+4Msvd9V4YNItArE2IbniL+91O2p+7uICs5RCRRjVK/KdRUg==
X-Gm-Message-State: AOJu0YxNzQ3jlYsVXYpgZZ3y0O/s9bsVU9Dm+olRB7LrlevUqZD01Zba
	6T3Iqn+JykkAoPw9DfyLbBovMFDS36zYDB4NuXx7HbWXHxs+wBnrfHEkb31XRM/WCoJq5Rp+Sio
	y7F2nu+w8bIww5CcpwoRHiR6rz/w=
X-Google-Smtp-Source: AGHT+IHIi+10uf9gjj/tu2GGicfD8krq8Fx4onfXCKbudQ494xEFvV0Hq5X65IyL1SPiyq6e+veLxazNbR+ZRvqxdhA=
X-Received: by 2002:a4a:d037:0:b0:5a0:3d13:a45a with SMTP id
 w23-20020a4ad037000000b005a03d13a45amr9984103oor.0.1709052028595; Tue, 27 Feb
 2024 08:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 17:40:17 +0100
Message-ID: <CAJZ5v0i5qAHU5NpMwfyh7PDYjD0COyBTxS9ucEF0tmR869_pSw@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: Convert to platform remove callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel@pengutronix.de, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:52=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this series converts all drivers below drivers/acpi to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>
> All conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
>
> There are no interdependencies between these patches, so they could be
> picked up individually. But I'd hope that they get picked up all
> together by Rafael.
>
> There is another driver that needs adaption (as of today's next), but
> this is discussed separately, see
> https://lore.kernel.org/linux-acpi/CAJZ5v0jJX-6L9f_TLe-cv2MNnZVK7au=3Ddrb=
KCn-tEWEagY-9ZA@mail.gmail.com
> .
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (7):
>   ACPI: TAD: Convert to platform remove callback returning void
>   ACPI: AGDI: Convert to platform remove callback returning void
>   ACPI: DPTF: Convert to platform remove callback returning void
>   ACPI: GED: Convert to platform remove callback returning void
>   ACPI: fan: Convert to platform remove callback returning void
>   ACPI: pfr_telemetry: Convert to platform remove callback returning void
>   ACPI: pfr_update: Convert to platform remove callback returning void
>
>  drivers/acpi/acpi_tad.c           | 5 ++---
>  drivers/acpi/arm64/agdi.c         | 8 +++-----
>  drivers/acpi/dptf/dptf_pch_fivr.c | 6 ++----
>  drivers/acpi/dptf/dptf_power.c    | 6 ++----
>  drivers/acpi/evged.c              | 5 ++---
>  drivers/acpi/fan_core.c           | 6 ++----
>  drivers/acpi/pfr_telemetry.c      | 6 ++----
>  drivers/acpi/pfr_update.c         | 6 ++----
>  8 files changed, 17 insertions(+), 31 deletions(-)
>
> base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
> --

The whole series has been applied as 6.9 material, thanks!

