Return-Path: <linux-acpi+bounces-8559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AEE990A6B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 19:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC3DB213C4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93A61DAC81;
	Fri,  4 Oct 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bly3jlG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4C1C8315;
	Fri,  4 Oct 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064299; cv=none; b=lRRAh7/2tW9aMUUXIwbqDDpbcZV5UBS692FYTrzixBVuIbX/awwig4NA80+ITx+vpLtzeKUo1xulvJAzayHIGnL9Dwm8NEGl4e59AaPEbnA0xmntA+bcElb9JsI3spwSbCe/Ytx7tN1zCel3ZGmfMxdRvaChu9xFSAyHRFrchu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064299; c=relaxed/simple;
	bh=QOT8DpvU292U8dzeD/6dY5RlYMFBHAzTSLeHX5BrL8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpknPx+azKh1cA+LHX3xK8QTqZ6iPwhhrZf0JDespSsfSffck1V3Gwo06FmGnnERG9gPkrUSTu2GXjSr1b9qF/b5WFFylG6+b0uatiYK/l30VAIdDz8nK/to0w8tuFbOU2hdk/XMfm/gawkA6V9c2yvwLYwqIhkVtYBGQ5IG4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bly3jlG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B7CC4CED0;
	Fri,  4 Oct 2024 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064299;
	bh=QOT8DpvU292U8dzeD/6dY5RlYMFBHAzTSLeHX5BrL8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bly3jlG2OKnbj0I71z8ZSQiSYMFctOetlyOTuAFuIdWdSV064SdLgIISmngTpN3XD
	 spoieb1Wue3VFdVYte/6wV1qIuovVfLiTX3p+CjGwy3foleN+101i/T2ZFc7zFV7Gb
	 vxl03jCljZBR4nbo0uvDqRNsajHmyRH0qLiq9Kn4Flrf5s/xdQXGLYGLWOdF7TPTZP
	 1iJnt5sJo2fZJKlFr0F4FLaV/fyXqIjQGZ2OSa/CDeYFgc7cMiLBIZE7FAmlEDn0lR
	 eq06wGyTdhw6d+Gk6fN+GU9LkFFlHvAf3BoA6FxISIv6d9S26G7j+MCeG/0gSH6L2W
	 Qe7m6EHCo0mXw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e3ba403b57so1545489b6e.2;
        Fri, 04 Oct 2024 10:51:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUafMk/bm+EFCjcqzDGCOXpDfBb7tNG6WcWM8XpPQUm1QGiGfJbsH0h5Rz6z4PnroUisdJFo7Kfoe1z@vger.kernel.org, AJvYcCV9JNMGpMZibVwpwh6xXfHQbr6yjmUv+fAkbSzCxs8XC5WTIhUCQ03HVWeiewSPwZeVzS+zr4J1mswoDQCQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhaj1a2xCfqcZ0v18zP3xzv06xGnS/oZR/cxCqKUYjZnGy8eO5
	oFyvz83EFup78sqqt43Eims567xzEboSHg0X6cT1GJryeEuj7x26ZzvoiCduPVfmAwIZ9kzIewf
	56prDUIQkuH8/3QYV5aU7HoLdKmI=
X-Google-Smtp-Source: AGHT+IGfudAVmgBiNbHDwOkHDWM/sQbEvS7Qqh0rXBFLg/YxtkrwDuczDOZnBgNIVPuw/rctv1151k2QDhonqr4Q8iM=
X-Received: by 2002:a05:6808:318e:b0:3e0:67be:a24d with SMTP id
 5614622812f47-3e3c131df45mr2628513b6e.9.1728064298588; Fri, 04 Oct 2024
 10:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914140026.29144-1-linux@treblig.org>
In-Reply-To: <20240914140026.29144-1-linux@treblig.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Oct 2024 19:51:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gbEJCHkgb_F5SjmzyaOhDqEF9Re8NMnSo4+3nkw6_7rw@mail.gmail.com>
Message-ID: <CAJZ5v0gbEJCHkgb_F5SjmzyaOhDqEF9Re8NMnSo4+3nkw6_7rw@mail.gmail.com>
Subject: Re: [PATCH] ACPCIA: Remove unused acpi_ns_one_complete_parse
To: linux@treblig.org
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 4:00=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of 'acpi_ns_one_complete_parse' was removed by commit
> aa342261bde5 ("ACPICA: Remove legacy module-level code support")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

In order to make changes in the ACPICA code, please submit them to the
upstream ACPICA project on GitHub from where they will be
automatically ported to the Linux kernel when the next upstream ACPICA
release is made.

If you want an ACPICA code change that has already been merged into
upstream ACPICA to be ported to Linux before the next ACPICA release,
please send a Linux patch corresponding to it with a Link tag pointing
to the original ACPICA commit or pull request through which it was
submitted.

Thanks!

> ---
>  drivers/acpi/acpica/acnamesp.h |   5 --
>  drivers/acpi/acpica/nsparse.c  | 102 ---------------------------------
>  2 files changed, 107 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnames=
p.h
> index 9448bc026b9b..c3dd202e247f 100644
> --- a/drivers/acpi/acpica/acnamesp.h
> +++ b/drivers/acpi/acpica/acnamesp.h
> @@ -104,11 +104,6 @@ acpi_ns_parse_table(u32 table_index, struct acpi_nam=
espace_node *start_node);
>  acpi_status
>  acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start=
_node);
>
> -acpi_status
> -acpi_ns_one_complete_parse(u32 pass_number,
> -                          u32 table_index,
> -                          struct acpi_namespace_node *start_node);
> -
>  /*
>   * nsaccess - Top-level namespace access
>   */
> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.=
c
> index 31e551cf4ea6..549dc16aed3c 100644
> --- a/drivers/acpi/acpica/nsparse.c
> +++ b/drivers/acpi/acpica/nsparse.c
> @@ -131,108 +131,6 @@ acpi_ns_execute_table(u32 table_index, struct acpi_=
namespace_node *start_node)
>         return_ACPI_STATUS(status);
>  }
>
> -/***********************************************************************=
********
> - *
> - * FUNCTION:    ns_one_complete_parse
> - *
> - * PARAMETERS:  pass_number             - 1 or 2
> - *              table_desc              - The table to be parsed.
> - *
> - * RETURN:      Status
> - *
> - * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
> - *
> - ***********************************************************************=
*******/
> -
> -acpi_status
> -acpi_ns_one_complete_parse(u32 pass_number,
> -                          u32 table_index,
> -                          struct acpi_namespace_node *start_node)
> -{
> -       union acpi_parse_object *parse_root;
> -       acpi_status status;
> -       u32 aml_length;
> -       u8 *aml_start;
> -       struct acpi_walk_state *walk_state;
> -       struct acpi_table_header *table;
> -       acpi_owner_id owner_id;
> -
> -       ACPI_FUNCTION_TRACE(ns_one_complete_parse);
> -
> -       status =3D acpi_get_table_by_index(table_index, &table);
> -       if (ACPI_FAILURE(status)) {
> -               return_ACPI_STATUS(status);
> -       }
> -
> -       /* Table must consist of at least a complete header */
> -
> -       if (table->length < sizeof(struct acpi_table_header)) {
> -               return_ACPI_STATUS(AE_BAD_HEADER);
> -       }
> -
> -       aml_start =3D (u8 *)table + sizeof(struct acpi_table_header);
> -       aml_length =3D table->length - sizeof(struct acpi_table_header);
> -
> -       status =3D acpi_tb_get_owner_id(table_index, &owner_id);
> -       if (ACPI_FAILURE(status)) {
> -               return_ACPI_STATUS(status);
> -       }
> -
> -       /* Create and init a Root Node */
> -
> -       parse_root =3D acpi_ps_create_scope_op(aml_start);
> -       if (!parse_root) {
> -               return_ACPI_STATUS(AE_NO_MEMORY);
> -       }
> -
> -       /* Create and initialize a new walk state */
> -
> -       walk_state =3D acpi_ds_create_walk_state(owner_id, NULL, NULL, NU=
LL);
> -       if (!walk_state) {
> -               acpi_ps_free_op(parse_root);
> -               return_ACPI_STATUS(AE_NO_MEMORY);
> -       }
> -
> -       status =3D acpi_ds_init_aml_walk(walk_state, parse_root, NULL,
> -                                      aml_start, aml_length, NULL,
> -                                      (u8)pass_number);
> -       if (ACPI_FAILURE(status)) {
> -               acpi_ds_delete_walk_state(walk_state);
> -               goto cleanup;
> -       }
> -
> -       /* Found OSDT table, enable the namespace override feature */
> -
> -       if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_OSDT) &&
> -           pass_number =3D=3D ACPI_IMODE_LOAD_PASS1) {
> -               walk_state->namespace_override =3D TRUE;
> -       }
> -
> -       /* start_node is the default location to load the table */
> -
> -       if (start_node && start_node !=3D acpi_gbl_root_node) {
> -               status =3D
> -                   acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD=
,
> -                                            walk_state);
> -               if (ACPI_FAILURE(status)) {
> -                       acpi_ds_delete_walk_state(walk_state);
> -                       goto cleanup;
> -               }
> -       }
> -
> -       /* Parse the AML */
> -
> -       ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
> -                         "*PARSE* pass %u parse\n", pass_number));
> -       acpi_ex_enter_interpreter();
> -       status =3D acpi_ps_parse_aml(walk_state);
> -       acpi_ex_exit_interpreter();
> -
> -cleanup:
> -       acpi_ps_delete_parse_tree(parse_root);
> -       return_ACPI_STATUS(status);
> -}
> -
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_ns_parse_table
> --
> 2.46.0
>
>

