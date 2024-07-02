Return-Path: <linux-acpi+bounces-6744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F69247CF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6991528512A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764881EB25;
	Tue,  2 Jul 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bduuv/Cm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D154657
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jul 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947080; cv=none; b=leCUA+Fgjx+dN2yi4Uko9RMTiZhAzc2fFnCuqQyBTzUqzJ2t+dq89nmHF1GwJyyP6wBM/vTMQKdhbbkkIrh5GbRTVcc29YKxvxTeVut3kwP+tI9O0qM/CdwH8vIQ21EXvtctBBsvoHQ2QO7PaQtxFS2Lp4tPiS5kZ+09wY7FwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947080; c=relaxed/simple;
	bh=ZEvtfS4+2z6g/g4WdpVReC0F+yql4hL/t3vA8E7VvI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPWgMi7d2KwxvlrC+Q1ghNxusfyVtB7+5tOpbPLr7QQDFGktD2hvkaqCPzLqkEDSiQhF5NasURG6D1FUHrv23HSYDovgQhKW1SA4aVEuEcV0v6FKBgdH4imarJHt4Wtz3tVUt5rADCi63iVcsQa1LeBb/J4xMGLSOT+XoA4hu/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bduuv/Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2089C116B1
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jul 2024 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719947079;
	bh=ZEvtfS4+2z6g/g4WdpVReC0F+yql4hL/t3vA8E7VvI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bduuv/CmSw+npSMyAbZy0M3nKtX4wHVYGVgqmTDssyexdmdYSdDshf0cBuWFwhWMM
	 AvrPA7x6YVVVu7O8ztOMCiOLRNhBSp8/zAEf7CdCngZtOjkzOxVxl5OfmTP2i+FdgH
	 dabunvmZm0t6g98msucPLwdoKA/QpeHmNl//Q6DOOqYiXbFmuPKTENkfLjbzPB8UqF
	 YUQ6omb1B976t4kcaKgHx7wh8V7HuVt9QTIVOONsss4h5uaH8Imm/h4Mdp7Y8tnU5R
	 sRFIGX+/gPKt+l6nR0QqnDpfH5u+bbYMqE0tJKtpp4MNejncLm2sxdU7Wo+S3z/kz9
	 rxR6a3/NH6hYw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-254925e6472so652337fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jul 2024 12:04:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjmlOpc0f8fVZ6EB6mHEUp92LgDpNmrAZmjNKd183EdjlHlXND
	sOjCMqpwM7i7Jv0LkEeekmn9NgLwbTrAPSy1mg4ZUo06usvOrXIskuV0lWSAiIS4BXXDbPn5W3x
	x98NydduqW97zaEMu8zN/5tTKa+c=
X-Google-Smtp-Source: AGHT+IGSRaMI8Y0JaS2RPQTV/Oqlp0SuEy5XxXG2Kkc8v6EyzUpAB7brUY7kmUSLn6GQ9eV72jd2dvHWI/DiBS96VqA=
X-Received: by 2002:a05:6870:eca2:b0:258:476d:a781 with SMTP id
 586e51a60fabf-25db361456amr10337335fac.3.1719947079168; Tue, 02 Jul 2024
 12:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626111446.1445111-1-prabhakar.pujeri@gmail.com> <20240626111446.1445111-2-prabhakar.pujeri@gmail.com>
In-Reply-To: <20240626111446.1445111-2-prabhakar.pujeri@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 21:04:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gufxJ=6Js66tw+v+OA3Qzc2P1TMrEBm20_Ge_v-DGp6A@mail.gmail.com>
Message-ID: <CAJZ5v0gufxJ=6Js66tw+v+OA3Qzc2P1TMrEBm20_Ge_v-DGp6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: CPPC: Replace ternary operator with max() in cppc_find_dmi_mhz
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:15=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@gmail.com> wrote:
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1d857978f5f4..a2591e1677f5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1837,7 +1837,7 @@ static void cppc_find_dmi_mhz(const struct dmi_head=
er *dm, void *private)
>             dm->length >=3D DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
>                 u16 val =3D (u16)get_unaligned((const u16 *)
>                                 (dmi_data + DMI_PROCESSOR_MAX_SPEED));
> -               *mhz =3D val > *mhz ? val : *mhz;
> +               *mhz =3D max(val, *mhz);
>         }
>  }
>
> --

Applied as 6.11 material with some edits in the subject and changelog, than=
ks!

