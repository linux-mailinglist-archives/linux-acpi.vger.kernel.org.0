Return-Path: <linux-acpi+bounces-15191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B49B075A7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0521C244FC
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C982F5080;
	Wed, 16 Jul 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n15LoGme"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093B2F2362;
	Wed, 16 Jul 2025 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668975; cv=none; b=GfjK5mOnqUoonQbfjOVGgA94lSPHwUnr5XyeeGKu07EM5bZj2RI89ytf9FzDiWbbn24zvJa96hR4Eq8+C9kxqd/EdrYMvd2jNXzKT/znRuWXfvnGhpnByDXPkmuRePD+l0EyHgXVaQ6mT65y7HK25pxPB8pOIcbei1Y3hgF0fmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668975; c=relaxed/simple;
	bh=YNtMCftI8pQY9RtM2Y+18wkXEagld4XNiwoXTnj+ydg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJYwyxyLB2dKh7uDU/rS2ij65CWtXbJgCPHFQYPL5xhyvWkcZKGy0B7KlsgtGrAkDAk/tYFnhKnYHO2ySIpZ9pJH8mBLxyD85gKCKAitbd73yDmCB9AZC/HIiYYe9UPiQvUKCjJ+aFPVkxfGbCpscx1DYP/hgxQ7ubO0T+Kp9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n15LoGme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE545C4CEF0;
	Wed, 16 Jul 2025 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668974;
	bh=YNtMCftI8pQY9RtM2Y+18wkXEagld4XNiwoXTnj+ydg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n15LoGmeGQA2zCIJ7KoIB/4saTAGEC4pA43xiDaaaddWH+jKoG7lCfaclGedp9siX
	 Y/zuho+NmMUicsXR+EzZDj/Yg598dT+oP8SrGps+eMofQof3uRFDufPhv/gLhMQJB4
	 6suX6POe9z0pXjvFGjriAMRCvlrjrPqgq1nEoVNaA2V0DRRbf7kHBBjXuNncSc/Rft
	 BRVBEPJSqWw0lhvN0a4eUzgtPA+rQ8DlIyAdHiao34U1lbg1KXT7MIEAefvAFsrVLO
	 bsHgj9KmldgkP3Wrv/fmARKpqG43RSwAqTguQiK5r1w4v6q96uPJjLS/k8OELGVjWo
	 rxnD1eW+yhDjA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-73e6320e767so581343a34.2;
        Wed, 16 Jul 2025 05:29:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBkpJ4zh/15Rzep1kKSmtfp7cvL5LH1Taivv3SdwJUjwAOMuugakhbWPYjlBC4rCmao1Bsd7XNUi75@vger.kernel.org, AJvYcCWXz2T3SbPdr/KuT1Smb5BnO7kf+XNqHbYYYcJC5IPgUmVvZ60h6hhNN8OBcaCOIRXdXYVmcY/iUoLloV5S@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqOyXunCKatx9HGadq48qww2Y5BoND4wu7ENrjjdLaCi57ash
	uG4YG8s5QGGj8WwY3iEna5TAkg7F33XXaDqEUetZddkfZQ4V5d6b38jah4u42BTp/R97Sp3qQ4b
	fwo8KDS/eiAEXiX/qBrqkTpHjr90Qnh8=
X-Google-Smtp-Source: AGHT+IHXRQPTnxjE5EegGyWvFrmCc/UYQg/fGbXAHH76xTqmYrlc9rXEooTqAMWD7p8gbTOuHrFCsTuEvkveFyO2j94=
X-Received: by 2002:a05:6808:4488:b0:408:e690:7e38 with SMTP id
 5614622812f47-41d038e1479mr1894621b6e.16.1752668973986; Wed, 16 Jul 2025
 05:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
In-Reply-To: <20250716100337.652657-1-mstrozek@opensource.cirrus.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 14:29:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i24A5N5bwJE-zqw_afcPk2a3OvnPNDCTCCd2tRTy7zBA@mail.gmail.com>
X-Gm-Features: Ac12FXwdSq0tZ4OCoh28r-_zxZq7h2o2SezU7K0CkYo6Mqx_9hsxygRkkSg9LFk
Message-ID: <CAJZ5v0i24A5N5bwJE-zqw_afcPk2a3OvnPNDCTCCd2tRTy7zBA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Add SoundWire File Table (SWFT) signature
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:04=E2=80=AFPM Maciej Strozek
<mstrozek@opensource.cirrus.com> wrote:
>
> The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
> which provides code/data which may be required by an SDCA device,
> utilizes SWFT to obtain that code/data. There is a single SWFT for the
> system, and SWFT can contain multiple files (information about the file
> as well as its binary contents). The SWFT has a standard ACPI Descriptor
> Table Header, followed by SoundWire File definitions as described in
> Discovery and Configuration (DisCo) Specification for SoundWire=C2=AE
>
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>

The canonical way to change ACPICA is to submit a PR to the upstream
ACPICA project on GitHub, wait until it is merged and then
(optionally) submit a Linux kernel patch based on it and pointing back
to the original upstream ACPICA commit.

Thanks!

> ---
> v2: Removed Change-Id line
> ---
>  drivers/acpi/tables.c |  2 +-
>  include/acpi/actbl2.h | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 9e1b01c35070..beaef9a8fc02 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -408,7 +408,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __i=
nitconst =3D {
>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>         ACPI_SIG_NHLT, ACPI_SIG_AEST, ACPI_SIG_CEDT, ACPI_SIG_AGDI,
> -       ACPI_SIG_NBFT };
> +       ACPI_SIG_NBFT, ACPI_SIG_SWFT};
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2e917a8f8bca..267ffabf3b7f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -54,6 +54,7 @@
>  #define ACPI_SIG_SDEI           "SDEI" /* Software Delegated Exception I=
nterface Table */
>  #define ACPI_SIG_SDEV           "SDEV" /* Secure Devices table */
>  #define ACPI_SIG_SVKL           "SVKL" /* Storage Volume Key Location Ta=
ble */
> +#define ACPI_SIG_SWFT           "SWFT" /* SoundWire File Table */
>  #define ACPI_SIG_TDEL           "TDEL" /* TD Event Log Table */
>
>  /*
> @@ -3163,6 +3164,26 @@ enum acpi_svkl_format {
>         ACPI_SVKL_FORMAT_RESERVED =3D 1   /* 1 and greater are reserved *=
/
>  };
>
> +/***********************************************************************=
********
> + * SWFT - SoundWire File Table
> + *
> + * Conforms to "Discovery and Configuration (DisCo) Specification for So=
undWire"
> + * Version 2.1, 2 October 2023
> + *
> + ***********************************************************************=
*******/
> +struct acpi_sw_file {
> +       u16 vendor_id;
> +       u32 file_id;
> +       u16 file_version;
> +       u32 file_length;
> +       u8 data[];
> +};
> +
> +struct acpi_table_swft {
> +       struct acpi_table_header header;
> +       struct acpi_sw_file files[];
> +};
> +
>  /***********************************************************************=
********
>   *
>   * TDEL - TD-Event Log
> --
> 2.39.5
>
>

