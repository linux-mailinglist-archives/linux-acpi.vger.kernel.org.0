Return-Path: <linux-acpi+bounces-15605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A202BB22840
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783721BC52F5
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97084279346;
	Tue, 12 Aug 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4I6pp98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23926B2C8;
	Tue, 12 Aug 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004276; cv=none; b=nVzRN0cEpf4t2Qt8s+ek37q6ZxIlkhE7tCdTMO8w1mSOule1Pfkcrew1LrG3G1oAQ2y9tP7s2+EEK3KsyLutS9IFsLZAvv+sorrzLm/bwSt7BmuKzVWRdoCICXhMkr8KNNL+n/b2hEyUZSQTYbRt/TPgI11kS7Fedgu3QJgVd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004276; c=relaxed/simple;
	bh=5qa0J3Om+9en/e7dJz1OITwTbWAQZ5Tl2ZwIUN3aK/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hciT7KnJHV7xeB8iLBBKbTiJ+AT5LlWP66p7VQBfqdJopsgcwmiTk+tCoh2ropCFK09jApR+1HEOQFqe17NUDAbLG9Vc4TGkoy709EFYATRLM6yAtVKdyPCdGYUUoME2h0BOlc+jK2BoSSCqJ6J+Zt7EpAg0QkMHqfESDjvwjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4I6pp98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A1C4CEF0;
	Tue, 12 Aug 2025 13:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004276;
	bh=5qa0J3Om+9en/e7dJz1OITwTbWAQZ5Tl2ZwIUN3aK/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h4I6pp98jJh5XfKuLy3Wu+798tWeoHgRp6BrZDZEW4PybajvCmYZyWEaRFU1lYRpH
	 L7mqIVEbX/cZEWQtioViUqbm2Q6BvEnvPDsXeiGB0KRyuJWmrDJwGl/QyO1yfYa4gT
	 A4M3xrqXhPHQvdfRfdO5G5fg+fjKmss0TbJbaDNG0WalZg0OY+3DRT0/NOWKr++MC8
	 jndMjwKdBSFSDddzK2DsMwPEaFd7WsYLJKbJ/QXA6qqt1Ht1huDf6Vh70maFgDdlcB
	 R3v34BD/l+ZR78LtXrZc3eu7voUEek3vDJePouXlhmmxn5+Yw6FH5xM6L/SdyoEWBu
	 eg5JlWSw4G2yw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-619a915c65fso2941567eaf.3;
        Tue, 12 Aug 2025 06:11:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpd38VNuyRo37xIvDhvMOQ5rFJtIOWSVAgq7dgKszfOg6oh+uCT6pCby7RFw8zQZV42tVQKbIWO7VEbOJK@vger.kernel.org, AJvYcCXqCJ6FfVSlkDuagvebjKyDyl/znN1hZPbyTEX1ifIH3JopHACDGGAeAt6SC17uFNRyUBleqPOZHNdL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qp5zdggtUpn35I6Vnh7muSBsgz++wM3Uk0tiKtKLz2PbvUq7
	zQtrzGdozyKoEhQTWJbdTCC+OcFw1CxYk/TRaflUnbJ+vTU3Tz2znMAE7MDK5hLvRX1dniqfFFf
	KnUVre0xGbGyB+Lt/imwASXjb7FFkWp0=
X-Google-Smtp-Source: AGHT+IFuLV6yjXEEI8oqpZer834q6yQFOQbYYGTR045ln1zplUNOmcMKLeZ6ClO2lw3H99+ilRz7NBjIjuyQ7BRESgA=
X-Received: by 2002:a05:6820:60b:b0:61b:924a:b7a3 with SMTP id
 006d021491bc7-61b924ac435mr5554342eaf.1.1755004275349; Tue, 12 Aug 2025
 06:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811122240.541469-1-zhao.xichao@vivo.com>
In-Reply-To: <20250811122240.541469-1-zhao.xichao@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 15:11:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gz6AepoYjyWjefUp6xRQiX9KZ3AyGyPo73RW-2SdaoTA@mail.gmail.com>
X-Gm-Features: Ac12FXwEP_i-_uF9x-OmXuYAgXyY_hbzpuFkeTBslkUo2PoS8PlGUNT1BJNBl3Q
Message-ID: <CAJZ5v0gz6AepoYjyWjefUp6xRQiX9KZ3AyGyPo73RW-2SdaoTA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:22=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> Use the string choice helper function str_plural() to simplify the code.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/acpi/acpica/utpredef.c | 2 +-

ACPICA changes need to be submitted as pull requests to the upstream
ACPICA project on GitHub.  Corresponding Linux patches can only be
applied after those changes have been accepted upstream (and those
patches need to point to the corresponding upstream ACPICA commits via
Link: tags).

Thanks!

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpica/utpredef.c b/drivers/acpi/acpica/utprede=
f.c
> index d9bd80e2d32a..658aeb397111 100644
> --- a/drivers/acpi/acpica/utpredef.c
> +++ b/drivers/acpi/acpica/utpredef.c
> @@ -248,7 +248,7 @@ acpi_ut_display_predefined_method(char *buffer,
>         printf("%4.4s    Requires %s%u argument%s",
>                this_name->info.name,
>                (this_name->info.argument_list & ARG_COUNT_IS_MINIMUM) ?
> -              "(at least) " : "", arg_count, arg_count !=3D 1 ? "s" : ""=
);
> +              "(at least) " : "", arg_count, str_plural(arg_count));
>
>         /* Display the types for any arguments */
>
> --
> 2.34.1
>
>

