Return-Path: <linux-acpi+bounces-5989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36968CFE4F
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 12:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47B11C212E6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 10:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920313AA31;
	Mon, 27 May 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnFEd8Hp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BE3A8C0;
	Mon, 27 May 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806737; cv=none; b=ZNhEIb3Ks6T1KGmY2XTU/a6Jfc61EJgJaETmcI1HETI8RrQ/0ZXujdzEbKrTR/oirq8emXS8f7p7HRsIJ4YBUkpYIlbdBFt0Mf3fxmN0zQI+/WZpYdXaO+FKsFGb854GoOG51qKxk+gDuvxXmyS6Ih5WONZU2qMk7BmEBRKfIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806737; c=relaxed/simple;
	bh=NsRBdHHxQsCLxiD+yt98fp2Fw6YW/5eDs4/wXZCQ7iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffS1CEbNpzI0/rL8fcy20D/Tlvdf7wiIRGjt2wUwjGCHiH35l6P+32Kig7yS3xkw8b5XiyqBsNGQ3OrXeZ2MdAP2i5zNsY+dR9RHytkftD8nf4bA2wv83Ucr9P7NAtyD+4ugkjCBFL8dzZS4htm+obFp3hO6rWC771rPviwFJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnFEd8Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D362CC2BBFC;
	Mon, 27 May 2024 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716806736;
	bh=NsRBdHHxQsCLxiD+yt98fp2Fw6YW/5eDs4/wXZCQ7iM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YnFEd8Hp/1GeYYADul6Bnf5SYeLiFYxp1IWV0bC+S1oiyRbs0XNhCtH68vm5pO9Ee
	 Dim0IDbBCerwTh9U5kkl9xKKIUvHbaBM7gqq4zIbc2/dKgrBpaPOU+URbu3V8aC4jM
	 BTHiTVp+YehH8iQX9gXJXisdUHhysTwVnqGPSPhk5WO8FnBMzVv2XZHZRpXOALhWhD
	 glxFXCLbn+W97srNNcJTDKueP2cHCLfz08/zuwVpSlU3OZUnhubYIwCaR7MmvA/Bc/
	 HZU/NHnQiuHyAT9amRSHrDgqzaytiqGzArziWOzpAEmr65nZECpvW8INGUusa38+xs
	 RlggSLRm2dhBQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b97f09cde3so312092eaf.0;
        Mon, 27 May 2024 03:45:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZcwiF9Llo0jXhme9F2ywpkMHusLaxrucM61rG9dSN5jZjjjQNUqsB4lPDcOipk5bNnbww4zzhbyX2vy3KzUACw8FdAY9OPZpHAoXOzKvpw2vLnHYMXe3jicJNqmVXV5kL6oO0QE+K6Q==
X-Gm-Message-State: AOJu0YxT6BOzxZ9erIcDr1Ud8dzGN1Zxc+GD74ZGFRL2zpkwuESFuIzi
	6i150YvF2lKv4CRACoS++OarxKJoJd/EFEO1A3VmwVwhkq/tvJxT/AfdO9lVsFUyisYlyMGTD0D
	urgSlw2PQOoXwbm9cQ9W0k0jSYRo=
X-Google-Smtp-Source: AGHT+IGhDqzejDoNzSARoJax6rqzRJosWYBiW7MNYK9Ej1IlNbjaAkttHeqiiCY/n6EWxLUS0TKS2UR2S95ymTizp5k=
X-Received: by 2002:a4a:e6d8:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5b96195f885mr9471011eaf.1.1716806736217; Mon, 27 May 2024
 03:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522213649.2860-1-W_Armin@gmx.de> <20240522213649.2860-2-W_Armin@gmx.de>
In-Reply-To: <20240522213649.2860-2-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 May 2024 12:45:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVwZJ1Q9XFDMb5E0NmPsj=Z3sC9E9zNTjFH0oWKgpn-g@mail.gmail.com>
Message-ID: <CAJZ5v0jVwZJ1Q9XFDMb5E0NmPsj=Z3sC9E9zNTjFH0oWKgpn-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: EC: Avoid returning AE_OK upon unknown error
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:37=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> If an error code other than EINVAL, ENODEV or ETIME is returned
> by acpi_ec_read()/acpi_ec_write(), then AE_OK is wrongly returned.
>
> Fix this by only returning AE_OK if the return code is 0, and
> return AE_ERROR otherwise.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/ec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a68dce2147a4..68dd17f96f63 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1351,8 +1351,10 @@ acpi_ec_space_handler(u32 function, acpi_physical_=
address address,
>                 return AE_NOT_FOUND;
>         case -ETIME:
>                 return AE_TIME;
> -       default:
> +       case 0:
>                 return AE_OK;
> +       default:
> +               return AE_ERROR;
>         }
>  }
>
> --

Applied (with some edits in the subject and changelog) along with the
[1/2] as 6.10-rc material, thanks!

