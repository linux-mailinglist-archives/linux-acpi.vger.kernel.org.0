Return-Path: <linux-acpi+bounces-15046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC2AFB8DB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5626A4A4398
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1E2248BE;
	Mon,  7 Jul 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aluFT9jJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346E3214;
	Mon,  7 Jul 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906628; cv=none; b=IETti6wgF8OlqlcOR/fp3I019wK7sdiDiRg00x+cLtXkI/Mckbv9PjKGiwEHv2odGa3JeIpn4ArX5Dfp1JVaOJUxVG5eVDh4ArYAMRPhvCexJsreip4orA7ISZmOEvYHctO6pEuixAJDkMuL9sCkU+SaDfATVQKfvFiRTKlm4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906628; c=relaxed/simple;
	bh=qo0v+QPLlpiFYrEAjLkcdvARHqyBsCjBOsJK6mdXbq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH6r20oWY9qZTuJ+x0SW30BUf3hvqC4vFIERLnEqwiqoOKtcgWBQX39q5htG95AqC/9XhBpR2+onIH8hl+gQn4AfaqDp5cbFsAsWHzOTiKpVCP4jKZcQhyGTag987XYbrlvUs/2wK+e2ae+mSFMBfhESbXewxSqO0zczbzRrubY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aluFT9jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D88C4CEF5;
	Mon,  7 Jul 2025 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906627;
	bh=qo0v+QPLlpiFYrEAjLkcdvARHqyBsCjBOsJK6mdXbq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aluFT9jJOhqWwZHBSIAzUt84iaQjIQSqK6Ifk9MFTdW6GcTowZvF/c6XT+9dl54PE
	 bOaTeaT8x6FpeMqK6BTokO7xjrXQE863F+lLT3rCi7IQua8/RcNzAmJuJhgwI86z8J
	 jC5TdboOy0Pt8xdtacIp4/l1h8ZdzMvy/baDHQabe2l7YI66bPX0j0PPB8fkJcUAKq
	 HlhNfF/cOboqfBTrNKKxG5zV0xq2j2AbBokg/E4I797itIauboRDBd8/CDnQ+t+lqK
	 YlXFrucikYqyPpScJZKQF5jSVvQudVr0KP4r0xFRR89iQUPYtQnOJK5ip0xyXn6oMh
	 GUjLCxh9lUC7A==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40d12821c1cso1537149b6e.2;
        Mon, 07 Jul 2025 09:43:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUx8dxxxxQwGv/oMadxXyF1+HtnbdFcYxej61FT5tP51l/2Wce6NZwBcn+7KyA35LZ/Z1G+03cuRmS7qLs4@vger.kernel.org, AJvYcCWE0+s69zKTS/Do/Z50uaI7WzPMOtKB0+Gc5UljixtjV11olWefn/zoipmQugG5aXgS+TE3ooTmNfbD@vger.kernel.org, AJvYcCWvCHQ8vzKRQeHcouJ5QLavP24JkrSt9VVz5fgKvoEIAIPMy2hvokv9DOZbf7tocVUnwqlfjvGeX1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZKQfPSu+QUE2VjsG4ckoReXnJURRvuRM/kvwMzt3aST/YLp5
	q7wj847thX8bF+RpQs9RGdouhP7ndUzn3fu7jasOIg3yejuwniuS7sMFEIWO2hVi883taqCUy/7
	4RVPgwoL9JJO0zlrr8GtnNQXL2jZWzPg=
X-Google-Smtp-Source: AGHT+IFDHeZTD7NQfecuChnzhujOybAaAYpaZaRxBlkUeTvBG5UHH4Tb0mjM99CwSaIJZ4hQuFK50vf9N/cCsM23b24=
X-Received: by 2002:a05:6808:67c9:b0:406:6a21:524f with SMTP id
 5614622812f47-40d043e7524mr11111111b6e.19.1751906626865; Mon, 07 Jul 2025
 09:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705110005.4343-1-sumeet4linux@gmail.com>
In-Reply-To: <20250705110005.4343-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:43:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ghk=s9r3BHW6A19_RwfCFhFconmR-aWKv7O9SCdgKSMQ@mail.gmail.com>
X-Gm-Features: Ac12FXwknHctRSFbyQILlEAe-z-BjIXdYKFXUwEq4gZdL5JRwp__LwaXRQUGcp0
Message-ID: <CAJZ5v0ghk=s9r3BHW6A19_RwfCFhFconmR-aWKv7O9SCdgKSMQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: FAN: Update fps count debug print
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 1:00=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> Update invalid control value returned debug print with
> appropriate message as no matching fps control value
> for checking fan fps count condition.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
> v1->v2: Addressed review comment received from Rafael Wysocki
>         to update the debug message appropriately.
> ---
>  drivers/acpi/fan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 8ad12ad3aaaf..095502086b41 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -102,7 +102,7 @@ static int fan_get_state_acpi4(struct acpi_device *de=
vice, unsigned long *state)
>                         break;
>         }
>         if (i =3D=3D fan->fps_count) {
> -               dev_dbg(&device->dev, "Invalid control value returned\n")=
;
> +               dev_dbg(&device->dev, "No matching fps control value\n");
>                 return -EINVAL;
>         }
>
> --

Applied as 6.17 material with edited subject, thanks!

