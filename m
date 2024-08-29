Return-Path: <linux-acpi+bounces-7956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C696432E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FD72819F6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9527191F7C;
	Thu, 29 Aug 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW07G7AB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF3190663;
	Thu, 29 Aug 2024 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931383; cv=none; b=DV13sWnzcKPHQXDLmHEoIMbGbdNmkr0/VS63dl9fKOT1TDSo/lz3SjTc+m4tcJXMFZVC6UU7qYUVbvXPYj1a73RculAfc4mVEtRgSQ1O+5ZVhLbvnrV2RLY0WHpg+fYAEhAZlkF66kvicNrMXcXa5jtcx26Dq7gBH1gOP1yb0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931383; c=relaxed/simple;
	bh=UV/VEcSLsr0IvtBSy3fvTXeCYqvLcRLTSiq34M3N3rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAOFDFzCdBCckQpo21q8c8CS1KWv7Xgo7dzsOtncVcVksKvY+Kl1KDnmKspW2vbQ64f+t1E3qynG+egSf8skTfBy5aWWdHcK6yqXR4JY9ArxeOAS1CBQyOUlHXiKtKz79oQ6WFyglzcDZRv16TZc0nDz9yAhSFSsF2r168QO5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW07G7AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F000C4CEC1;
	Thu, 29 Aug 2024 11:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724931383;
	bh=UV/VEcSLsr0IvtBSy3fvTXeCYqvLcRLTSiq34M3N3rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dW07G7AB6Kx2OLWQ1+e0SuzrToISOL3pQfIw8NnGP6I2AOKoEAjXDyGzg8p0sBITB
	 IfDL76NLzdbjGdMLhgIxSoTxmnGcxb6FU63us++VqgfJB6twbjIIGUuGYyu0N8G95h
	 u/p5OtWM/rde3YF5darRI0tOw1gBteQQI6yQrKVdpRa1eFXmYgqhRsDoGk5M9lWbVk
	 wCs4FtHPXKLbl/Ly5mPLugRdDFXtByVYn4fSFsy8osC0jZ6xiLqdvxxE1d38vdQVUX
	 BjK+eAnLF4FpcdClaJEU11zpvuGvRnuLpIxXLG0Jtx6oZ/MkeJk16N8tF7zQL4dmMs
	 7hWDYCRhqjbpw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3df0519a3ceso306542b6e.2;
        Thu, 29 Aug 2024 04:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpVgsEhXfeBq2JWJjTNhEuZZ+YJWkW7Lxi4bqw676+bd4UiOcWo/jYdMSuM/dpEli/jGVI8xYA1Tvi@vger.kernel.org, AJvYcCXj6gRlC4lCT3SL0jGBojxHbQxHQQp2CbITHhNs4GafgYPBCRIVrJR3cNA3GR0jsHB8firAikKQua37Oaeo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13fpUQA3w9mbP9PxvnbWfbMTtUFHkl3B8PhhS7o7bEMZ11g9N
	3kSe+vszSawNF/0y2/5aTiX/k6xGxi3ge21RTYThcN2b51nUWrt/UCFSUfuPPpj97Tk9fonGpZv
	FTPzCSmI7STSZWpPFUTwPoPqS0yc=
X-Google-Smtp-Source: AGHT+IGRLMLDjKP7Mea2/P9G2bPD+iq2B4CkR78+Jl3o7ZHDib6Cg9ZOf5XNWtJFTZHgpNYZcaE4ghppbb8Rd2Zb5jM=
X-Received: by 2002:a05:6808:1799:b0:3da:adc3:4a83 with SMTP id
 5614622812f47-3df05f08b5cmr2536327b6e.51.1724931382475; Thu, 29 Aug 2024
 04:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826233437.19632-1-00107082@163.com>
In-Reply-To: <20240826233437.19632-1-00107082@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 13:36:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jjwFcs-w7c6tjzuZFdAdsOb7S_4yMvqVoJn_LmOiWJTA@mail.gmail.com>
Message-ID: <CAJZ5v0jjwFcs-w7c6tjzuZFdAdsOb7S_4yMvqVoJn_LmOiWJTA@mail.gmail.com>
Subject: Re: [PATCH] acpi/_DSM: Add rev/func to warning message when
 acpi_evaluate_dsm failed.
To: David Wang <00107082@163.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:35=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
> When acpi_evaluate_dsm failed, the warning message lacks the rev
> and func information which is available and helpful.
> For example, iwlwifi would make _DSM queries for lari config,
> and when it failed, all warning messages are all the same:
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (=
0x1001)
> With this patch, the warnings would be more informative:
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:1 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:6 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:7 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:8 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:3 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:9 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:10 (0x1001)
>   ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade r=
ev:0 func:12 (0x1001)
>
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  drivers/acpi/utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index ae9384282273..6de542d99518 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -801,7 +801,8 @@ acpi_evaluate_dsm(acpi_handle handle, const guid_t *g=
uid, u64 rev, u64 func,
>
>         if (ret !=3D AE_NOT_FOUND)
>                 acpi_handle_warn(handle,
> -                                "failed to evaluate _DSM %pUb (0x%x)\n",=
 guid, ret);
> +                                "failed to evaluate _DSM %pUb rev:%lld f=
unc:%lld (0x%x)\n",
> +                                guid, rev, func, ret);
>
>         return NULL;
>  }
> --

Applied as 6.12 material with some edits in the subject and changelog, than=
ks!

