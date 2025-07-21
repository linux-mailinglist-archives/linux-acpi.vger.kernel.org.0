Return-Path: <linux-acpi+bounces-15259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B769FB0C6DC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867846C1178
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEA28033C;
	Mon, 21 Jul 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/OS7QD4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09052DE6E7;
	Mon, 21 Jul 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109246; cv=none; b=mOT9tUSRAkFU1IK9Gw+o5VasNRNY7OcBUpESmPCDHTIup32y03kjKIRtZDBNuAV1Z1OWZNcKqD6L8JBVXRbAc0ilNphmlLjp3BchEILAt/dZD0Rb4qJ1Xgs57XiJ0KoXWeVl7k6C6oRDP5CphL9nCYWWJegMRo+7uC3sv4WgCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109246; c=relaxed/simple;
	bh=POu/6RcXAXPlWdUQ1qT/BoxmsEBrEVB56P9NerCYWXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og+kvtFU2G1sfeBCIDQW6CyfPduxq1b0iiRjmomk4CYkOhioUFP344ReWgGuOJkWH6G4u5iyib5K5qEUvUVCQX5ORH84HyrB2ASqF3jm6EisF8X/HpvdqKN52Xf0H2y8MjicfObjttTHNSaqHh68iIB8Szixll4aLA9SwSCfdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/OS7QD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E61C4CEF6;
	Mon, 21 Jul 2025 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753109245;
	bh=POu/6RcXAXPlWdUQ1qT/BoxmsEBrEVB56P9NerCYWXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m/OS7QD4PjEOHiqPVua/M/GbjGqpBGpwAzYznGumevTm5tzkrOHn5Cpc7DI3CLw2L
	 QUZcs58AVvMPFzkrK6SUPoiB1bTr6/00d/1D7hZUGyRuQPcYBzYbj/6Kvchopsqcco
	 g1y4vNzkAI/5FxhOhTCHCWQ/cjqsQPTFuowrYtvth96bMlKUp7NWSh/79XLQOSFO5E
	 D5+RBk9NAzjalB2x3NLX24fXs3/8hYGeqzE9dcw8R2f3A+cVN23rc9r+A9A7V7Yhwp
	 rlz385JAONbkQag6eMu3KpmWtYr1SsLIezsxHqvjnqWKgEyo4sFdOKYr4WmH8xwz09
	 CpbOx/IA3++5g==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61593d5f92bso2517019eaf.1;
        Mon, 21 Jul 2025 07:47:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVga2zwH5uH3TpUMFbzGLT2b/OgHs/ufcAhgbdxlvDFG84VcEYaXCu+ENKhRMvL3gHN7w4wZXuS3fyikw==@vger.kernel.org, AJvYcCWTuKlohwT+CxqGK87Q1zUmqvCCsUXMwqqC+ECg2EZAUsmD0q+PxnHQuBZX0LkqMI9bppR8u8p4ZvujAL6g@vger.kernel.org, AJvYcCX0b6L86YIRrkpYqb01aCdEpc/7b/yvp1eyF+R/52srgyFbksAkH68zfawfOelXwznQP4YeHDgmmwHD3OzOfGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/eN0UVfcxb4h7SU9fN4ZFCC0XnxSKCFvs3+d0iXap2gnhtfZU
	4TqMrDR7PuELyGo0CROIJE12Rk63K2+jIHpBdbenr5eZlsz2AuKGQVj/oNOGGsFB9PYelKMf/ty
	pESj9FGFW/QtG6Ef3/DKfZzDRHVDm7Is=
X-Google-Smtp-Source: AGHT+IEWdKVsxpzzKcxBaQkADZ6sERyQIlgfA82t1NIlBXHjio6fztFwfCBQrBDTOY4HMy0B7xBmmLv4qujQWpdVL8U=
X-Received: by 2002:a05:6820:6ac7:b0:615:9a1e:8d30 with SMTP id
 006d021491bc7-615acc73b58mr12078604eaf.2.1753109244758; Mon, 21 Jul 2025
 07:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721135016.2500117-1-colin.i.king@gmail.com>
In-Reply-To: <20250721135016.2500117-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 16:47:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7tGiYOWX138ODmX6QTxuF09gCADHX-aVXD_h3y5iFjQ@mail.gmail.com>
X-Gm-Features: Ac12FXxcjsguRVd_BYILBY4h1G6hudEeRQHcR3qRKDMhPSoFCr2obJ8c4H6N87k
Message-ID: <CAJZ5v0i7tGiYOWX138ODmX6QTxuF09gCADHX-aVXD_h3y5iFjQ@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: processor_throttling: Remove space before \n newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:50=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a extraneous space before a newline in a pr_warn message.
> Remove it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/processor_throttling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor=
_throttling.c
> index d1541a386fbc..f9c2bc1d4a3a 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -235,7 +235,7 @@ static int acpi_processor_throttling_notifier(unsigne=
d long event, void *data)
>                 if (pr->throttling_platform_limit > target_state)
>                         target_state =3D pr->throttling_platform_limit;
>                 if (target_state >=3D p_throttling->state_count) {
> -                       pr_warn("Exceed the limit of T-state \n");
> +                       pr_warn("Exceed the limit of T-state\n");
>                         target_state =3D p_throttling->state_count - 1;
>                 }
>                 p_tstate->target_state =3D target_state;
> --

Applied (as 6.17 material), thanks!

