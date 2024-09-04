Return-Path: <linux-acpi+bounces-8146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75F96BCB4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 14:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1281C225F8
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47A1D9335;
	Wed,  4 Sep 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+lsso+K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98611D58B0;
	Wed,  4 Sep 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453886; cv=none; b=LMW/aZPAZmILQNSaFctVPVzPUM79ZweVR6G1c/YmbuB8TPfeJeH3L1GoJZ/rb6UyrDH0pBC40gur9zaI2Ir5FFBlfnKN21XG9L2GrZJWpRFTHpd2Y1p7om8m6yGecRogBy+rj0Ja3J8g0g7jePmVMWApLJ9HNv9aXk6DGFDOw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453886; c=relaxed/simple;
	bh=gWBcDXpnwV66JzP9agnNz1yjQNRH/lnU5CCm2VgO5ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1VMLe8kQOFFq7+wAsM/O6uq0u+yYfSEmbOMA0tdfDNaGSs69kreQUxGCFMFr0bNPlb+YaQT2IasDiUytzxSQwIE+H1x3isYJeXOyEH1ODVpwAQgMkHWyZ4rJAFTuUkSW1UT1Nko4E+VInE6V4LIF26y5laDJCciFuw0QHrqu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+lsso+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FE9C4CEC6;
	Wed,  4 Sep 2024 12:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453885;
	bh=gWBcDXpnwV66JzP9agnNz1yjQNRH/lnU5CCm2VgO5ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+lsso+KGn5IEHcldCoBJPqtLQMGdt8IjSTnQkiE4v6bhrPkZPpNvY1idL1JR8eMn
	 AVFwFvKHetRQ5Ksdl/ZsW0IREm7jqNeGgXPHVEdeKMbyqtSKE36KOkhzuFi3q5y14c
	 A0hlDPOPTmxna/4P6ZqUCYjf/nMUJDWdMNJB/aGzZw8TZi4I9Lxk9ZWHkvxkZ8SJlc
	 CuqusVLI4XJGQhOaym6obkFaFYRccsxdb+WgLacf5bFVaiBH9nQv2uAXG4qW/nifsC
	 BIsi+guLIUmNoWDNUO3kU85vOoycKyEm8g5QawDk46F6j17P1UdNfLPmdsCRylObAZ
	 9d5hTwEWW4TOQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5df9343b5b8so4188069eaf.0;
        Wed, 04 Sep 2024 05:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2jgdEvLHGnjzKE1Vl5Xp4VTK6s+vRUALM/hrFp5BoCTpICVH4KbQLq1N7g3Nb29UWUTJPx/LSPmBTlfO2@vger.kernel.org, AJvYcCXPD5lfNcqh9IpCi5YzW01SkGHH3XBZN9gURUPlyAlQ3OMrAv+0aG2k3yOwm90BkslwgIarGQZAgSZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGB7ZIaGyKL7hGLpE3K2g8pfkDx2NH4HAkj2MeMcH9u51KjvS
	P9KGzXPaQioTMd0ahgbmSK9URTERpVt18w6bmfVwSQou6fr3stFH9NJifSTaCpLSmUQNiQpnfqI
	jpj2SSpUa1+FNF15rZy2Cjvcbed4=
X-Google-Smtp-Source: AGHT+IEp499+TpEPUrVKQyS4saF7KGklaNfDvGSGHqxz1J8u892Paq6EOcylAGzZQjNDOFGKD6Li9hTms7relqG+Btg=
X-Received: by 2002:a05:6820:545:b0:5d5:a343:d135 with SMTP id
 006d021491bc7-5dfacddf0a9mr18406823eaf.1.1725453884784; Wed, 04 Sep 2024
 05:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
In-Reply-To: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 14:44:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com>
Message-ID: <CAJZ5v0gAaMLrSyva_cZBxJpzAFM3Lb_SiuTxESjAmHJLxnThGA@mail.gmail.com>
Subject: Re: [PATCH 0/5] ACPI: battery: various cleanups
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 9:13=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Thomas Wei=C3=9Fschuh (5):
>       ACPI: battery: check result of register_pm_notifier()
>       ACPI: battery: allocate driver data through devm_ APIs
>       ACPI: battery: initialize mutexes through devm_ APIs
>       ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
>       ACPI: battery: install notify handler through ACPI core
>
>  drivers/acpi/battery.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
> ---

Since it is a bit late in the cycle and this material does not appear
to be urgent, I'd prefer to defer it until 6.12-rc1 is out.

