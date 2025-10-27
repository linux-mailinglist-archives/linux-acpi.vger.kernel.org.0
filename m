Return-Path: <linux-acpi+bounces-18259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC81C11461
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 965454FE8AF
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10B2DC781;
	Mon, 27 Oct 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erki/gED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481812D660E
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594362; cv=none; b=b548mVoMmfgP/WNFfQHB3UpB91caVUZFcbg+v280t/2T0/Rq+hC9+/NEvdM8Cq4uXWKeTHZb153kNqjgqwB0SIbyuAxuz18OFG9IWoi0CHGNdPcQIYFWuQBxDRSqi/h9ehWZR1bZ1KH/oTJkCay3iVlG2mvIkZJJskbOQc8uGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594362; c=relaxed/simple;
	bh=nYf37d39Da9tD1c6nGhltl2lfPK+pJBRUuWPj00VhQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOcDGa8JDTuiiGVwF+tg8Z1k76kbmGHsjClcRLhg2oN6mpZNG/bj9xQwCVQEDIhCVREOjmKEmUBhD2wMBrrqeaX+0YNRbElTOd3STRmQHLJY5ZOVqsdQPRPZsy0A1WoV2FVMwczVDOn5ztau+wQJjQI+lAw+72hf3CQe8IxhdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erki/gED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF1CC4CEFD
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594362;
	bh=nYf37d39Da9tD1c6nGhltl2lfPK+pJBRUuWPj00VhQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Erki/gEDXPoAiSM2sZmiZQwbEg3fuwhiM5qEuepYn4JtBzt5ir9YIDzEeC4A0InbR
	 YHGHLhlO64DT1vzS/Ui/KONQd6aMmDDkKJhd4yyKtUAMpd8xRyNrmoOovtB144zUEI
	 jNPS5Mt1dpBpYZpX8C53UjE7LDVCWWuiAh/fUT4zZefoUDfp1IJeQR0DL2aRBuyO5w
	 FwnqNpy2j5tITOG26hYevyWdrBrcZQO7rooUHqp/rTykM33s9Y3spDIDdYU+dRymLJ
	 P6AQTeOZBNkphd7JYfAzIcalNF1qUUGARCPyIcrzPIRDi7nFOTsd3b9LnFAFXpxx5m
	 5FKdekjILG3Rw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-64a760e5281so1393228eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:46:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXExMjEBwyZR/P7ZWIxfvI+WVWv7H4+MfvERD/p9bke58dWA7OG7SinF93u7KRdKmiDKiX3KYdLBTPB@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaO+igzL6v3MuQP+tdC6un1Fg6rTed6K7/7wvOJVOdvovgb1N
	1sGkvG2TLjIJGm1YOcb/lh5XEe2htfAOpvQ2oTRzeuQvFUJ1CwE+wgGpEo6OMSwSg9NQBv6/jRG
	G+Gb2Z6IZhktILog55pw+1/c+j6UOC94=
X-Google-Smtp-Source: AGHT+IHX7zeTaM01SXUeWCj6P/wH9oQC6auwoVN7RODP41DySirMt4DRUR/bGSNbaW/i/xL5CLMgdumnOSw7pAJ1wvU=
X-Received: by 2002:a05:6820:2295:b0:654:f7cc:b181 with SMTP id
 006d021491bc7-6566f20a4eemr569428eaf.3.1761594361268; Mon, 27 Oct 2025
 12:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024123125.1081612-1-punit.agrawal@oss.qualcomm.com>
In-Reply-To: <20251024123125.1081612-1-punit.agrawal@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:45:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jB0ziP8RQBiLN_7s9seGqdoQAiP3t7dZg3e+Skd4JovA@mail.gmail.com>
X-Gm-Features: AWmQ_bnp2Lfd-Cm21FCeviqCT7l6FJRZID2RJ-YvfdlbQYb8GyFMojR-dL2wBtM
Message-ID: <CAJZ5v0jB0ziP8RQBiLN_7s9seGqdoQAiP3t7dZg3e+Skd4JovA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Check for table version when using precise baudrate
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
Cc: rafael@kernel.org, lenb@kernel.org, cp0613@linux.alibaba.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:31=E2=80=AFPM Punit Agrawal
<punit.agrawal@oss.qualcomm.com> wrote:
>
> Commit 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
> added support to use the precise baud rate available since SPCR
> 1.09 (revision 4) but failed to check the version of the table
> provided by the firmware. Accessing an older version of SPCR table
> causes accesses beyond the end of the table and can lead to garbage
> data to be used for the baud rate.
>
> Check the version of the firmware provided SPCR to ensure that the
> precise baudrate is vaild before using it.
>
> Fixes: 4d330fe54145 ("ACPI: SPCR: Support Precise Baud Rate field")
> Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
> ---
>  drivers/acpi/spcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index d4d52d5e9016..73cb933fdc89 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -155,7 +155,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool=
 enable_console)
>          * Baud Rate field. If this field is zero or not present, Configu=
red
>          * Baud Rate is used.
>          */
> -       if (table->precise_baudrate)
> +       if (table->header.revision >=3D 4 && table->precise_baudrate)
>                 baud_rate =3D table->precise_baudrate;
>         else switch (table->baud_rate) {
>         case 0:
> --

Applied as 6.18-rc material, thanks!

