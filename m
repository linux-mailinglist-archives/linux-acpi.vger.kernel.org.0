Return-Path: <linux-acpi+bounces-13089-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314BA91A92
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A5019E56C7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9ED23C8B9;
	Thu, 17 Apr 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij0mZW02"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2923C8C2
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888804; cv=none; b=DmefxYgy6K7rzjdprqzk05RqGR8bukSFw6HNqLSEbe8xsYHENIy3VfkkmWNn3usIRpLNFqy4UaBATDWkBjmtOL15MHBDskae54okMOxVEi+fIGkwKwMVi6bEMJ2AyKq+lUnz8r9J+G3DNrZYuF21GyqebDnEdTBtv4xBJT8NOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888804; c=relaxed/simple;
	bh=Fo8Do25tF7TxXae3BIR2vMCgt8b7XujGrqelam73B9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3OEh1kKhPK9X1sF3fQPfR8VX8Vct49K5ZNnSaR/GnTurksNgRXftJoCpR+vgspEnuriDq0mXXh3impEFra2+7xLY3xpBDp1KCxcHRQO0VGcU2uZMe5f8c8FKbqA7HZIrCTVGkawrmZlXVdQsTu+XCyzHea7hNzYziKzOX9AyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij0mZW02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289C6C4CEEE
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888804;
	bh=Fo8Do25tF7TxXae3BIR2vMCgt8b7XujGrqelam73B9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ij0mZW02ekZcpWwDiyOfmneRvjJYPad5lbl/eCSGhBoKWPast/g/gVXA8mM8hY4qp
	 7VS5jCm5oN3qBdGI7/IPLpsF2GZqaixePsS+iRlbHFrJqX8FHwbfjv7UNUrdnEanNe
	 yzLMcY+ALxhEbmxYMSGYg9DI0ka/iSFTzWXmcTqkdISJkD1aCLtefNeM0nY59IrzhG
	 O8u1uAU0aO/RFOnsOh/67PEtMaX3k5EsQG7v5vaGHrB2JDQGPfQv/B6ifN6ZAPXHN1
	 jHFlbhvzFY9asRAg421DPWA0tnNUNkMtvr702WGLi5mtnk2cRgZJN9xA24H/Fmmcfl
	 9XRwrYCYqKDtw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2d0364e9231so150481fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 04:20:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb1Yn0VomELRqWi6yEdrPBwRd/UsOS8sqzEC3E9RJFvq3hGX1kLOdELYjke4URZYQ2vZn/maRjmTbj@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwV/qOuzAB6VgpPf2IOTCnzJ2lNPF82LRsuXKrD/RlIRYQxZa
	rqf+nUBGJzWKlGsDTuEOf+wlOyEfLZRIWJNQn7jVCZrMyd1iS3UdHcNsFu8fGPQm3YXZfCYbWoP
	T+l2ndb3pq9kIllLIoOojB47iGiU=
X-Google-Smtp-Source: AGHT+IH6P1tefLSzQ6ryUEC3zax80nWUUhlqbED1W9M/JQbtv7Yz74CZ+CVZey7RIMmBVFC7hPgDbavF0Fr1UAOazdA=
X-Received: by 2002:a05:6871:848b:b0:2c2:4e19:1cd4 with SMTP id
 586e51a60fabf-2d4d29b152emr3363119fac.1.1744888803367; Thu, 17 Apr 2025
 04:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417031040.514460-1-superm1@kernel.org>
In-Reply-To: <20250417031040.514460-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 13:19:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
X-Gm-Features: ATxdqUFjskxIqpd-AFR8hlSkP00eAbPSjRoQeirlWm1EKPzNvcC79H2sfq6KjAY
Message-ID: <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 5:10=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
> exit are emitted into the debug logs. This can be useful to understand
> call paths, however none of the arguments for the method calls are
> populated even when turning up other debug levels.
>
> This can be useful for BIOSes that contain debug strings to see those
> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the argumen=
ts
> for a given method call.
>
> This enables this type of debugging:
>
> ```
> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c4:\M4=
60] execution.
> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: %X  T=
IME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:\M460=
] execution.
> ```
>
> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4f208d=
f790a4e108c1c

The link doesn't work.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> This is a backport from upstream ACPICA.  I'm not sure if there is a scri=
pt
> that converts code style, so I just manually adjusted to kernel code styl=
e.
> It is really useful for me for debugging; so I would ideally like to see =
it
> go for 6.16 if possible.
>
> v2:
>  * handle non-CONFIG_ACPI_DEBUG W=3D1 build
> ---
>  drivers/acpi/acpica/acinterp.h |  3 ++
>  drivers/acpi/acpica/dsmthdat.c |  1 +
>  drivers/acpi/acpica/extrace.c  | 51 ++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>
> diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinter=
p.h
> index 955114c926bd0..d02779ee92103 100644
> --- a/drivers/acpi/acpica/acinterp.h
> +++ b/drivers/acpi/acpica/acinterp.h
> @@ -120,6 +120,9 @@ void
>  acpi_ex_trace_point(acpi_trace_event_type type,
>                     u8 begin, u8 *aml, char *pathname);
>
> +void
> +acpi_ex_trace_args(union acpi_operand_object **params, u32 count);
> +
>  /*
>   * exfield - ACPI AML (p-code) execution - field manipulation
>   */
> diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthda=
t.c
> index eca50517ad824..5393de4dbc4ca 100644
> --- a/drivers/acpi/acpica/dsmthdat.c
> +++ b/drivers/acpi/acpica/dsmthdat.c
> @@ -188,6 +188,7 @@ acpi_ds_method_data_init_args(union acpi_operand_obje=
ct **params,
>
>                 index++;
>         }
> +       acpi_ex_trace_args(params, index);
>
>         ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "%u args passed to method\n", ind=
ex));
>         return_ACPI_STATUS(AE_OK);
> diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.=
c
> index b5e4bb4ae3ce6..e4721504c390d 100644
> --- a/drivers/acpi/acpica/extrace.c
> +++ b/drivers/acpi/acpica/extrace.c
> @@ -147,6 +147,57 @@ acpi_ex_trace_point(acpi_trace_event_type type,
>         }
>  }
>
> +/***********************************************************************=
********
> + *
> + * FUNCTION:    acpi_ex_trace_args
> + *
> + * PARAMETERS:  params            - AML method arguments
> + *              count             - numer of method arguments
> + *
> + * RETURN:      None
> + *
> + * DESCRIPTION: Trace any arguments
> + *
> + ***********************************************************************=
*******/
> +
> +void
> +acpi_ex_trace_args(union acpi_operand_object **params, u32 count)
> +{
> +       u32 i;
> +
> +       ACPI_FUNCTION_NAME(ex_trace_args);
> +
> +       for (i =3D 0; i < count; i++) {
> +               union acpi_operand_object *obj_desc =3D params[i];
> +
> +               if (!i) {
> +                       ACPI_DEBUG_PRINT((ACPI_DB_TRACE_POINT, " "));
> +               }
> +
> +               switch (obj_desc->common.type) {
> +               case ACPI_TYPE_INTEGER:
> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "%llx"=
, obj_desc->integer.value));
> +                       break;
> +               case ACPI_TYPE_STRING:
> +                       if (!obj_desc->string.length) {
> +                               ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT=
, "NULL"));
> +                               continue;
> +                       }
> +                       if (ACPI_IS_DEBUG_ENABLED(ACPI_LV_TRACE_POINT, _C=
OMPONENT))
> +                               acpi_ut_print_string(obj_desc->string.poi=
nter, ACPI_UINT8_MAX);
> +                       break;
> +               default:
> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "Unkno=
wn"));
> +                       break;
> +               }
> +               if (i+1 =3D=3D count) {
> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, "\n"))=
;
> +               } else {
> +                       ACPI_DEBUG_PRINT_RAW((ACPI_DB_TRACE_POINT, ", "))=
;
> +               }
> +       }
> +}
> +
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_ex_start_trace_method
> --
> 2.43.0
>
>

