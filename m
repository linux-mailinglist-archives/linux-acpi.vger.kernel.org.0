Return-Path: <linux-acpi+bounces-7824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A9195EDE6
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 12:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D5D1C21713
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2B148308;
	Mon, 26 Aug 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNz97goA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C4146D6F;
	Mon, 26 Aug 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666405; cv=none; b=pxax3MT+UAFhKa63VQSVmjgbRfmw92RBI0yBecz/rKA4q4PWpPCAT3vsMfdjZhYjAA/z6J4AQObvw/Arxj9L7dpgZTZS2xB+XDVbQoWOHUxuvisu96d3LgHLPQcD49zaFf7xWkpxTVBVcyLNLJwftSvbYpc1s+no0VaLy304I1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666405; c=relaxed/simple;
	bh=H1gNBBAhMfSVZg5l3P5whjBb1DwypNUyP7q+iCqtEic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePuFuEWs7M9zjV1N98veJF4e8oBQf+ISnXBFYFjN43mDQ0+Kg3icOwnxWsfnYXAm3y/EgjKkEPxbDtRHRwoF6mvSV57Ab1tgozkgeYD812eMCLkQOP8FqibDwpK4uswx2+XGuRV+fonm7BC3OZPAax4/WQAVLZ++rRE7AGRVP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNz97goA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9AEC51406;
	Mon, 26 Aug 2024 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724666405;
	bh=H1gNBBAhMfSVZg5l3P5whjBb1DwypNUyP7q+iCqtEic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DNz97goArRKajiUSlAKrRRaoClpMoTnOt8x/+hX8n82Zo6PjgfYEMxbcyBeFxGttI
	 CEwIWjIh/uktlZ96ssxyQdPAbqYzMx2pm7830eQQGW5y9fAvDh187Roy78l9f0tfsk
	 wxdujRN6IJajlLDH8sgaKYO26v4j63QLeBdheFlb6k9Dc4hEIVbbNjWmSLv+ylyckc
	 7xfcn20wqrrnGBVfNKX8TzmlVIXawkP+lxwiG/o1Ah5E6rSVi46pbc2lZcj7+a+Ugp
	 X6HJFLHNJkeBibmf3NHBbwtfrht3qOVZV8qJ7KdzRic0u7plQjNv/sAmaUKQhnogJR
	 1e2jBf3Jv6k4w==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c8c1006eso3065633eaf.3;
        Mon, 26 Aug 2024 03:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4JzbqtglOlRZckje9UO4ThmfDSmem7AOHdH9f27o8NJ2eYH5fyi3AjJQyWFGSzH2vLTIAvdQWLKEY@vger.kernel.org, AJvYcCVxLvu6ySicTJwsOWj2Il/DGYHaNo6orHsxsLQYZokEs4ELaEcFPHvWLDCpkIJca2xDsqUY7ayT8YStXKQp@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHjGpplhOFW3cZI8UVhhn/UFX9UfNHaakh3Qe4J5Gi1NUKkMe
	EDGKVOAqnWttp+lOvC5NTa9fWUXTkiOsa3SlKFuIt+Ja/AT3n9pzIsXtWvDL5QHo2nQdB6Wj2ww
	ivwmhUxNcjBBWCcKG/V+iLVgPEZQ=
X-Google-Smtp-Source: AGHT+IE/OB3jlh4F+GyGtLPrVPwvZucEs/pMxOW+5WBT9V6UxnSH23wxYVwVZbDNTz/44qsbbGiYgj4B49GU+4egfGQ=
X-Received: by 2002:a05:6871:29b:b0:270:4dbb:195a with SMTP id
 586e51a60fabf-273e6476a16mr11161053fac.15.1724666404545; Mon, 26 Aug 2024
 03:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
 <20240812054647.1194716-2-jiaqing.zhao@linux.intel.com> <CAJZ5v0hPtvVRM=Te2oPzCvE3tOy_rXYGJwaoQOfNc71z+pmkvA@mail.gmail.com>
 <f2fd62f7-3fe3-4bea-8c9e-6343d2cce8b7@linux.intel.com>
In-Reply-To: <f2fd62f7-3fe3-4bea-8c9e-6343d2cce8b7@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 11:59:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBk+vVKd1zXN7+4fX_-T-enmGMT=BD5R8CU_1C+xdQDw@mail.gmail.com>
Message-ID: <CAJZ5v0gBk+vVKd1zXN7+4fX_-T-enmGMT=BD5R8CU_1C+xdQDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPICA: Detect FACS in reduced hardware build
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:10=E2=80=AFAM Jiaqing Zhao
<jiaqing.zhao@linux.intel.com> wrote:
>
> On 2024-08-20 22:55, Rafael J. Wysocki wrote:
> > On Mon, Aug 12, 2024 at 7:47=E2=80=AFAM Jiaqing Zhao
> > <jiaqing.zhao@linux.intel.com> wrote:
> >>
> >> According to Section 5.2.10 of ACPI Specification, FACS is optional
> >> in reduced hardware model. Enable the detection for "Hardware-reduced
> >> ACPI support only" build (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=3Dy) also.
> >>
> >> Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542=
b68d605f8b2b1104
> >> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> >> ---
> >>  drivers/acpi/acpica/acglobal.h |  6 +-----
> >>  drivers/acpi/acpica/tbutils.c  |  5 +----
> >>  drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
> >>  include/acpi/acconfig.h        |  1 -
> >>  4 files changed, 14 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acgl=
obal.h
> >> index f4c90fc99be2..309ce8efb4f6 100644
> >> --- a/drivers/acpi/acpica/acglobal.h
> >> +++ b/drivers/acpi/acpica/acglobal.h
> >> @@ -29,11 +29,7 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INV=
ALID_TABLE_INDEX);
> >>  ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
> >>  ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX)=
;
> >>  ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
> >> -
> >> -#if (!ACPI_REDUCED_HARDWARE)
> >> -ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
> >> -
> >> -#endif                         /* !ACPI_REDUCED_HARDWARE */
> >> +ACPI_INIT_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS, NULL);
> >>
> >>  /* These addresses are calculated from the FADT Event Block addresses=
 */
> >>
> >> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbuti=
ls.c
> >> index 15fa68a5ea6e..356700349b45 100644
> >> --- a/drivers/acpi/acpica/tbutils.c
> >> +++ b/drivers/acpi/acpica/tbutils.c
> >> @@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
> >>  static acpi_physical_address
> >>  acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
> >>
> >> -#if (!ACPI_REDUCED_HARDWARE)
> >>  /********************************************************************=
***********
> >>   *
> >>   * FUNCTION:    acpi_tb_initialize_facs
> >> @@ -37,8 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
> >>         struct acpi_table_facs *facs;
> >>
> >>         if (acpi_gbl_FADT.Xfacs &&
> >> -                  (!acpi_gbl_FADT.facs
> >> -                   || !acpi_gbl_use32_bit_facs_addresses)) {
> >> +           (!acpi_gbl_FADT.facs || !acpi_gbl_use32_bit_facs_addresses=
)) {
> >>                 (void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
> >>                                               ACPI_CAST_INDIRECT_PTR(s=
truct
> >>                                                                      a=
cpi_table_header,
> >
> > I'm not sure how this change is related to the rest of the patch.
> >
> > It doesn't appear to be present in the original commit pointed to by
> > the Link tag.
>
> This change here is just indention fix, in original acpica, the indention=
 is just fine.
>
> Shall I remove this change?

Yes, please.

If you send a Linux counterpart of an ACPICA change, it should not
contain any changes in addition to what was there in the original
ACPICA commit.

Thanks!

