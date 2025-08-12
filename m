Return-Path: <linux-acpi+bounces-15610-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F1FB228EA
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491AF1AA142D
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40664283CA7;
	Tue, 12 Aug 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQKMWJWx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF8227E83;
	Tue, 12 Aug 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005555; cv=none; b=Q08drw8a7oz9Lo3HMlz+6n5PQpJwRJGIqbYsYF9Ni6X4Tj2cc3XNimjAgy9sIWxae1HvpVHPVgGkmnDJazr4Zkq29amY4BFa7hQ7YFhB4j9rqJv5RKY/L3Ir9FKuEpa5yfdsA4QnjFLFGoLAG1h3G1eCGsNBnnXfZKjeevVrtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005555; c=relaxed/simple;
	bh=vqbhFrPVJEtdPlxJ/bQd+A+YpNtID/igOKlPIpgPl1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4L8fAx7LdCXRxQN8bq8E68OMNN/WdtaSWpzmuncqjN54NsVtGmExXL0i4b1CG2q/KGJLRB3zOZBeSc1pAaiSHKkMR1pD4p2o1kf+Vw1Z7RE9ffPmg2dojsJ+GyfFIy44zGbn8MQvUYNw3ayfTSJkhBVqxR2P2UVoYfu8f6nfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQKMWJWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DA6C4CEF5;
	Tue, 12 Aug 2025 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755005554;
	bh=vqbhFrPVJEtdPlxJ/bQd+A+YpNtID/igOKlPIpgPl1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dQKMWJWxOyIbMrbj/h+WXWb8bXyAGPwwdyFUqD4z/wqxGAr+kga40q56dHSeWmr1l
	 pKVMAoTPkp8q94Gy/pjtY6gMiFrLN9Q7Q8k2iQLc4lqyZRdPiqONsFSdwVDBsc3gl8
	 bTTjefXQllN01Cu0gOmHBmDXO838p5vLbe2MMiB7rP86E1UgLUFXiEnJ435HTiveT/
	 w65pDOXkbBYIl2E2kzNGpgicldp/x9EwW5Dia9YdSvquSkSEfiv4aejhh8/u0dS+Kh
	 xut76QxcOpIcS28OMMFAdoaliLBCME/+/s0vw9zV4h1GSYj1MxL2wEKM3zLSvEfAn3
	 7N+eBTVs/zsUw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61998205433so2224226eaf.1;
        Tue, 12 Aug 2025 06:32:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzxN5WoVJLWv+Cl3htYLA+zqBLLVqHBiVVFW5KFXLOfJ1O8gW5P7EWPvgTX4g3oxXYkOYFhRtTrjHG@vger.kernel.org, AJvYcCXOdbpacfEUpllrDKDKW27Aj0eIu519sfGxmpVJVaeAfwkwXG4GS16UFfnfl6O9YphVEbv9wFhCsbnW6UOt@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXGTMi0ZV838Rc+uKoG8VaNEFsj5cFdVpslE2UY8NnmmyIFCy
	8iYl9Y6Ozr3wR+SV20tv2+x0Xj6P1a07cuzCG+qRVdIr3sKDH/KLDZ9OMDlcbsTyokGP12Yhzxc
	KNhGeOPJB07aUv2E4J3DWRu1lsJdd0wc=
X-Google-Smtp-Source: AGHT+IFW5tbsaOloJmufzLITdqlOhOamUzIFQVtlru4InzfEHD2iaysJpoTrn4GuAd1uwMqMhxnvPtr02zj2vhrLS8I=
X-Received: by 2002:a05:6820:1505:b0:61b:8d64:d07d with SMTP id
 006d021491bc7-61bb5d6c25emr1962963eaf.8.1755005553943; Tue, 12 Aug 2025
 06:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729062038.303734-1-W_Armin@gmx.de> <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
In-Reply-To: <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 15:32:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
X-Gm-Features: Ac12FXy6ben6rw9HI9xaSxUO_J6yD1lCoXwLcy_g1ycrz8Yh0ZnZwKjXCwr-d4U
Message-ID: <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Ilya K <me@0upti.me>
Cc: Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 9:01=E2=80=AFAM Ilya K <me@0upti.me> wrote:
>
> On 2025-07-29 09:20, Armin Wolf wrote:
> > It turns out that the ECDT table inside the ThinkBook 14 G7 IML
> > contains a valid EC description but an invalid ID string
> > ("_SB.PC00.LPCB.EC0"). Ignoring this ECDT based on the invalid
> > ID string prevents the kernel from detecting the built-in touchpad,
> > so relax the sanity check of the ID string and only reject ECDTs
> > with empty ID strings.
> >
> > Compile-tested only.
> >
> > Reported-by: Ilya K <me@0upti.me>
> > Fixes: 7a0d59f6a913 ("ACPI: EC: Ignore ECDT tables with an invalid ID s=
tring")
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> >  drivers/acpi/ec.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
>
> Thanks, this works!
>
> Tested-by: Ilya K <me@0upti.me>

Applied as 6.17-rc material and sorry for the delay (I was offline).

Thanks!

