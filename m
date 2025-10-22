Return-Path: <linux-acpi+bounces-18121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD9BFDF56
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 21:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D088C357827
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587872EE268;
	Wed, 22 Oct 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnk8iZ2I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346662222AF
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159715; cv=none; b=hJy4E3NuTM5UW7BjY1NH2xeVcTRJPVhOWXkUVUiPvypP2CRPsVChmYiGYpvkDIz722Egp94GOghpvkWUiDICPVaQliNmTXNRkRViZH1Be71z9Wgyh56IuxLxUJmlmkD62YYg+cK6jDGU7elEIxkzKHHwaGvPeDJwDi/1Ee56+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159715; c=relaxed/simple;
	bh=8QQS8kc7bdQGxyIQRwVYfhQc1BirQmFcHW9Ffirs0nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEW2tkAVezUTxD4QydVFgfa/oBWr3FIXFijm9uqJCQ7UOmQgCIspFGIEasqvA6CiKjbfMA/KP/s1NEOkoIlbSs5U/wEOUUyF5ZPLAqe+rFC76o6sPl0a9r+PmUFnAJgMlaF4pvXCcTCgth/gZXzRMEnFeauPCOG9ALvZ2Vz0tVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nnk8iZ2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152E6C16AAE
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 19:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761159715;
	bh=8QQS8kc7bdQGxyIQRwVYfhQc1BirQmFcHW9Ffirs0nk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nnk8iZ2I90zK9qB+2Trtl61Se3AY+7jwbl6TkQyDM76k5XpmE5uDY9wxS0I16vMvF
	 SjI0qKy1nDxsUNhyFxKDhJLaowCn2CZjV2QWNSY/Pce1ZE8+jwzcYazrwh+aeFE9rJ
	 jm8sjIt5NP4j+h6SjjPfGL+YvwWd5CY8C09mmAIADeJTSgMlOnmlK/cNharjw54YBe
	 x0O6s2HRi0AkRVnqfFzvj2bf5CmzGZMOWVQ6NIlnApgLToaotP8POrCyYfyx7U4y1h
	 hWAmdRioCfSzx08aNkn082rYr13Fe+7TO9h3n4y4njV2Owwwhu/EhJBpIya7rHBU4X
	 J0nEraEMk5WOg==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43fb60c5f75so1553760b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 12:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7OJuw5gmwF6cc90z0bMcz/22Wn+tUi4Hq4T35+dXZz+GLmBCvGjEPDzJpFpADTL7o69Q8TH+PhUx+@vger.kernel.org
X-Gm-Message-State: AOJu0YwMN5lKjoawS1lzHWLY9VHG4Bqso9EMMfQMYB79q9aDjHbaGQJt
	AlHjY76w+/PT/4d+l4nhEvFgZol7WYo2P3AnfQBXTQkYeRor9Mf1JIxedAX78D4js4/SvIhXSc9
	h7kO6vm+L+vPTnNalQk23dSY5hN24Y4E=
X-Google-Smtp-Source: AGHT+IEXOq+rbqWkZOsarn3B+OAXet6C8y0J0RnLRbiYccXp8jEfFHNnWoAaOR/i9138Oyqv7aW/kcaXgykyOjtveZ4=
X-Received: by 2002:a05:6808:2f13:b0:43f:3d56:4dad with SMTP id
 5614622812f47-443a2fb880dmr9100340b6e.38.1761159714404; Wed, 22 Oct 2025
 12:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006045320.970534-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251006045320.970534-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 21:01:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4WPTKuZ0G75jGWFnqtOvy6Q-L43ZuPGHG+KssfEknTQ@mail.gmail.com>
X-Gm-Features: AS18NWBYFq1R6UVO3FV9NSudb4sE4PDbwgTGaNn0bClUMSlHuTSmXcnnWcEL1rY
Message-ID: <CAJZ5v0g4WPTKuZ0G75jGWFnqtOvy6Q-L43ZuPGHG+KssfEknTQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer deallocation
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:55=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace kfree() with ACPI_FREE() in pch_fivr_read() for deallocating
> ACPI buffer objects. The buffer.pointer contains an ACPI object allocated
> through ACPI subsystem functions and should be freed using ACPI_FREE()
> to ensure proper cleanup and maintain consistency with ACPI memory
> management conventions.

This is just a conventional thing because ACPI_FREE() in Linux is
implemented as kfree().

There is no correctness issue here, just the convention is not
followed, so please update the changelog.

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_p=
ch_fivr.c
> index 952216c67d58..8d7e555929d3 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -41,7 +41,7 @@ static int pch_fivr_read(acpi_handle handle, char *meth=
od, struct pch_fivr_resp
>         ret =3D 0;
>
>  release_buffer:
> -       kfree(buffer.pointer);
> +       ACPI_FREE(buffer.pointer);
>         return ret;
>  }
>
> --
> 2.34.1
>

