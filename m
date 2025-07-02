Return-Path: <linux-acpi+bounces-14950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1AAF6074
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF8B3B8303
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D38309A74;
	Wed,  2 Jul 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcoB3ls1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794430112C;
	Wed,  2 Jul 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478878; cv=none; b=MxRA4ih854ilziqpFqIuvhoPZXt9F8QVvW9MO0CNabUGx6oBiGxX4qGmsak5ZGxB0NZM9VKZSVB2eIshEsYYWYuNMmsBCW3VSCVJdOn1+BWXKON991zLGlKt2/lWK7+4NJWjxN0F4whbEDo/yLMcWSF9dzEW+AhOGWFdOlXvc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478878; c=relaxed/simple;
	bh=NH1fpTEBUSo89crtQmUHxeYFQ+mZA4F3eSHmxe1tucY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU7/BP59Kpd9fAC4L6yDZQJIedhjXne0huQXFm/+1tvEA4vb9UdivY0u4epLb0SJqiAn5pCJ9Y9zSPyQRCvTcuPnNPqeIv9K30DCf4K7yjBD+ANrAZneV7o/tWw5OH2a4N2jxIN7idWl4xBJUMF05edqejuCi0dDCiyByXa5zFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcoB3ls1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1E8C4CEEE;
	Wed,  2 Jul 2025 17:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478877;
	bh=NH1fpTEBUSo89crtQmUHxeYFQ+mZA4F3eSHmxe1tucY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcoB3ls1dZTu+us+xxpWU5eNFhzL5a6h6VXX+Pv5Xvs+j6zZlHnLf9d3PZH9/Igth
	 KOHktV0X3MRI/HTcL96gjwjCG4M0cnBTmcnBuEMlTg165kiOCoHLM74OL7avPBhq+m
	 vV53RA1sqQAK7FP4C5RpDcigGaie9yfnTCTxQwu3IOQYTEQyHnhasdlZe0vlw0AvoO
	 UfiSRoAjKNFgemrz2sutkDb0yW3Pfp+kHLl6nP2qrFP7N1FTyQxpyno6PuQ5UFGGUn
	 n5wxWoafUZq1UxeKN9BLMNdqRnmC3tgY0/OyhtV1iWGRK4gjGssZP/bbFFJBoUiVJM
	 TN96grKNd8LVQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73a44512c8aso1667918a34.0;
        Wed, 02 Jul 2025 10:54:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrtnzltGveJTzw7HjK1BI5GtKmZMxB2pVQ0/4tqBEcBV03/Fu1h1kj9iPiOPCDPo8mxBZUfaAzB/vs@vger.kernel.org, AJvYcCVy7ocw3clvgcl61jr7sMJkzk9bc1EK1HtPMAUQaLO6Su195JXD4oahoUfb5xnWjvipANZdbES/s2tyRlJV@vger.kernel.org, AJvYcCX993wevRprexX7WRpWJlQwpngBybldYWZ73D9JxbaESKBkuLFVxziTCv9R9+OnzEk9XkGhoFX7FlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKx7g3W8xBfyBWO+tT2xvfWuChGPbM0pJNcYpU496TjWvjliLl
	7Z0y2GcD+LxVJ6nPWE4PRz40K8tGpd/fiWVoRtAwg2xd5XKoDeoHhEp/Obs2l/BeUCxhI4sNdWo
	6LGM7pq5wPCg4JBeuY05zTNhXFs+iUQQ=
X-Google-Smtp-Source: AGHT+IF/MGixYNfZtVXvf5T1PXAkJhZSbfdC/0VxfGQeh+QDueUHALCwlSy6OtCSl1rAHL5ji1gvt0Tp3Kt1jyhRa5M=
X-Received: by 2002:a05:6820:1e88:b0:610:fc12:cbb4 with SMTP id
 006d021491bc7-6120115152emr2173767eaf.1.1751478876623; Wed, 02 Jul 2025
 10:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621051704.12050-1-sumeet4linux@gmail.com>
In-Reply-To: <20250621051704.12050-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 19:54:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqAO32zdLcwZ9UtWEhf=OfCqUN0PkB83v6=suXMP14UQ@mail.gmail.com>
X-Gm-Features: Ac12FXzU0B7EFlABWe5CBDD7DNDv124w6PCo07LTLmV2iYnH5tV7mT87iEdI3JQ
Message-ID: <CAJZ5v0hqAO32zdLcwZ9UtWEhf=OfCqUN0PkB83v6=suXMP14UQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: FAN: Update fps count debug print
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 7:17=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Update invalid value returned debug print with fps_count
> instead of control value for checking fan fps count condition.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/acpi/fan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 8ad12ad3aaaf..9f2696a1928c 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -102,7 +102,7 @@ static int fan_get_state_acpi4(struct acpi_device *de=
vice, unsigned long *state)
>                         break;
>         }
>         if (i =3D=3D fan->fps_count) {
> -               dev_dbg(&device->dev, "Invalid control value returned\n")=
;
> +               dev_dbg(&device->dev, "Invalid fps_count value returned\n=
");

I guess this should be "fps" instead of "fps_count" because the latter
is just the array size, isn't it?

But I don't see why it should not be "control" either.

>                 return -EINVAL;
>         }
>
> --

