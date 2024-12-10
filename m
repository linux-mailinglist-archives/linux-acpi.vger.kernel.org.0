Return-Path: <linux-acpi+bounces-10030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F99EB8C7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69511889389
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF81FD791;
	Tue, 10 Dec 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIL7aRBI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDA1AA786
	for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853204; cv=none; b=rWuB/ZGbPWk2ncnYF1fPLP6CTUzrib/7VrADsemLiPp+PqMMN/OTX4FUmy+aeGnhvC3p8x2UXFbuNc9eymABM4UfGdBhSTrDjOFBN/jKFfoVuKPEhVahIJ/QMpgwGccnJWGrTKv/wEI6VK9J8Ze+nayhkfK5welkyTwGaRull3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853204; c=relaxed/simple;
	bh=1NngA0t9PkSPSJH5kkJCNaJZC81rt33joXJ7GOZ3aVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxYwyjYvSsdacSQ4JWQz6g5okmENO+z/n8AVMhvNJrUfkqAsNyeH79ym0rk3S7MVaKHGjSx4nLbCr2JINAyiYfuV1x7mCaWhPyA0Vq+DnFpElyRxNbFyOqGHzB4xVV1elAY69afMMTULvbEmwUREMm26fKWxMeMeW8Re038SjjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIL7aRBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E13C4CED6;
	Tue, 10 Dec 2024 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733853204;
	bh=1NngA0t9PkSPSJH5kkJCNaJZC81rt33joXJ7GOZ3aVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PIL7aRBIAhgHi93lXNukIINv1droNE/gAKHcW8sILu7u0eApP+Yk3+f0j0OhJTvwk
	 w1/INmAp2x34YbcuCQiOw4Dk3UW1n/FEm24QFaoBmetxVyTdK6yr7HLXdwhvf9sQFR
	 wCGjmDAmwDnKe8h49FYbaSosr9mmlSot8J5/9fjxBLjst7M//RuoeDmEqxG55YAPpH
	 PUU+BcBNyOfbf6dYe0WCUzQsYeZ/ahzRlvlS3VvLYe05cepzJWKed/ay2zW/7It8BO
	 e50K3aSortr0K3zdur3PmNqkWGTKEG5lFTrabOk2sLI2JaXXw5f7BxXlMaQhS4i/hv
	 tXtfgLlsEIiRg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f2c86d59ccso710912eaf.1;
        Tue, 10 Dec 2024 09:53:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9R9uDcYrrGquL6krL7/qerP80rwxFVEcKKmzXTvoQrkKC6XRNiWLW8t4EvpprC5gIXFw5z5qyaQif@vger.kernel.org, AJvYcCVrSlGrd+26VShcP5systr4R4qWKTGYsJhb1n2NtIqNL4I6V6MNPcB0LvnBxjLgRJzxZI3N/7F4pxHNsHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+dcUWI/b91TdG4fYh3uqHicGodoAFMIZ28+0audTIda7vqvm
	NepqFt1yalk6uLCqmeirvf5xqD8v90NVOsciZO/nyMikRyzfOLOJ2Upco7th7XbG/B4LoG/I5MX
	l2S/zEOLRzjeoaXw7cscDBxS5mNk=
X-Google-Smtp-Source: AGHT+IE1S69XC7Qmo8+rAJWDxFEVBmqtbVeFDxHQD0PYtbWwzXf755DkaZ0BQbDssfI9yKsigXCc593XkXiK+Bos7VQ=
X-Received: by 2002:a05:6820:4c0e:b0:5e5:c073:9ea5 with SMTP id
 006d021491bc7-5f287111588mr10706735eaf.6.1733853203441; Tue, 10 Dec 2024
 09:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115025351.85283-1-xiongyining1480@phytium.com.cn>
In-Reply-To: <20241115025351.85283-1-xiongyining1480@phytium.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 18:53:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gooYrx7er_gpNG_vickyh05HRt7beN_-RqnV6=h-RdVA@mail.gmail.com>
Message-ID: <CAJZ5v0gooYrx7er_gpNG_vickyh05HRt7beN_-RqnV6=h-RdVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi_driver: add CONFIG_ACPI_KERN_DEBUG config to
 enable KERN_DEBUG
To: Xiong Yining <xiongyining1480@phytium.com.cn>
Cc: rafael@kernel.org, len@kernel.org, linux-acpi@vger.kernel.org, 
	linx-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 3:54=E2=80=AFAM Xiong Yining
<xiongyining1480@phytium.com.cn> wrote:
>
> In the API module, there is no unified configuration switch to control de=
bug

You mean ACPI I suppose?

> output, and the current approach is to enable debugging by adding "define=
 DEBUG"
> in the file, which is both cumbersome and difficult to manage. a global d=
ebug config
> to control the debug output of the ACPI module will be more easily and cl=
early.

So there is only one KERN_DEBUG printk() statement in the entire
drivers/acpi/ directory, the rest is pr_debug() or dev_dbg() that
shouldn't need this change.

> Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
>
> ---
>  drivers/acpi/Kconfig  | 6 ++++++
>  drivers/acpi/Makefile | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index cee82b473dc5..ea198ead57d7 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -479,6 +479,12 @@ config ACPI_REDUCED_HARDWARE_ONLY
>
>           If you are unsure what to do, do not enable this option.
>
> +config ACPI_KERN_DEBUG
> +       bool "Acpi kernel debugging"

Please always spell ACPI in capitals.

> +       help
> +         This is an option for use by developers, most people should
> +         say N here. This enables ACPI driver KERN_DEBUG.
> +
>  source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index eaa09bf52f17..d0a417e73071 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -4,6 +4,7 @@
>  #
>
>  ccflags-$(CONFIG_ACPI_DEBUG)   +=3D -DACPI_DEBUG_OUTPUT
> +ccflags-$(CONFIG_ACPI_KERN_DEBUG)      :=3D -DDEBUG

Isn't this kind of confusing?

>
>  #
>  # ACPI Boot-Time Table Parsing
> --

