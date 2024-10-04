Return-Path: <linux-acpi+bounces-8563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDB9910D9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908981C22B65
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60957155C98;
	Fri,  4 Oct 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kszEJck6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAF231CAE;
	Fri,  4 Oct 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728074982; cv=none; b=gJor7U+kzHVteJ6FK/87EdEjSVqOEIlMD/g1qpoVmQwKlkxd1BWUkvjYqSrtfW0ON2H7Szp4yqLS5kYa9vz1V2jsT0cB3BuRbK1hKOs5kYOudxnLTdgKqq9VCGchtCKxR91arTqocGETdQOgFKVMwmWTAdsHmoHr/IfD7URqcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728074982; c=relaxed/simple;
	bh=RYdiU1exZrBcmefnIjVyBtDkebyERCkXiX/EIoabMYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPn0+iBcK0u0W5XxBmt86DSCbVQ3XnWNGiKBh8MciKwD7BS04uYrr1o4Q0UZKSEhe0BpcI/O5a6vb8s4UOtBufCkMzN0sd744qnpd22NSyc4Dl2P/EANWiNFFxrKw9kdq0YtEu97wCERFfX9fS45UppXv7mNG5t8Czj7RKvDkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kszEJck6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=wOok6V6JCrl5jJMFRFhd1GdooliC5J8onfuK7d6RQSU=; b=kszEJck6cw1yGFJD
	bW2OoI0y131IBGx9JgypZ0gg+G1m62yE4rQZZTxW2pLjeBBcJ382IiUpctO/7+Mg9eJ0LsdxGy19H
	XhczDgAjgnIIv1iuXcOQGppcXQK9LAHr47uB1Ys2MEOBaOO1xe3w+tFE4WAWLY4GOd6Slz+vOehIV
	34Wuq6YPHVDksnANl5Lj+qKzN6gDe39+DVZU7e2Rj/nUsX/4znOCCDgIGVTwzpcjFMAqpH9KEFIVa
	LmG7XHljyLwXZ/JbJSO43mcmGI/ip8xsxGiwbIGpXsDkenvhT7m9MoYdFpaMlWoEkZzPevMtHzvSW
	F2tML7DvzYTLHJXC0g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1swpEt-008zn2-2P;
	Fri, 04 Oct 2024 20:49:27 +0000
Date: Fri, 4 Oct 2024 20:49:27 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPCIA: Remove unused acpi_ns_one_complete_parse
Message-ID: <ZwBU18gXU79qCZJs@gallifrey>
References: <20240914140026.29144-1-linux@treblig.org>
 <CAJZ5v0gbEJCHkgb_F5SjmzyaOhDqEF9Re8NMnSo4+3nkw6_7rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gbEJCHkgb_F5SjmzyaOhDqEF9Re8NMnSo4+3nkw6_7rw@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:49:07 up 149 days,  8:03,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Rafael J. Wysocki (rafael@kernel.org) wrote:
> On Sat, Sep 14, 2024 at 4:00 PM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > The last use of 'acpi_ns_one_complete_parse' was removed by commit
> > aa342261bde5 ("ACPICA: Remove legacy module-level code support")
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> In order to make changes in the ACPICA code, please submit them to the
> upstream ACPICA project on GitHub from where they will be
> automatically ported to the Linux kernel when the next upstream ACPICA
> release is made.

OK, I'll go and have a dig in there for this and other related patches.

Dave

> If you want an ACPICA code change that has already been merged into
> upstream ACPICA to be ported to Linux before the next ACPICA release,
> please send a Linux patch corresponding to it with a Link tag pointing
> to the original ACPICA commit or pull request through which it was
> submitted.
> 
> Thanks!
> 
> > ---
> >  drivers/acpi/acpica/acnamesp.h |   5 --
> >  drivers/acpi/acpica/nsparse.c  | 102 ---------------------------------
> >  2 files changed, 107 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
> > index 9448bc026b9b..c3dd202e247f 100644
> > --- a/drivers/acpi/acpica/acnamesp.h
> > +++ b/drivers/acpi/acpica/acnamesp.h
> > @@ -104,11 +104,6 @@ acpi_ns_parse_table(u32 table_index, struct acpi_namespace_node *start_node);
> >  acpi_status
> >  acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node);
> >
> > -acpi_status
> > -acpi_ns_one_complete_parse(u32 pass_number,
> > -                          u32 table_index,
> > -                          struct acpi_namespace_node *start_node);
> > -
> >  /*
> >   * nsaccess - Top-level namespace access
> >   */
> > diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
> > index 31e551cf4ea6..549dc16aed3c 100644
> > --- a/drivers/acpi/acpica/nsparse.c
> > +++ b/drivers/acpi/acpica/nsparse.c
> > @@ -131,108 +131,6 @@ acpi_ns_execute_table(u32 table_index, struct acpi_namespace_node *start_node)
> >         return_ACPI_STATUS(status);
> >  }
> >
> > -/*******************************************************************************
> > - *
> > - * FUNCTION:    ns_one_complete_parse
> > - *
> > - * PARAMETERS:  pass_number             - 1 or 2
> > - *              table_desc              - The table to be parsed.
> > - *
> > - * RETURN:      Status
> > - *
> > - * DESCRIPTION: Perform one complete parse of an ACPI/AML table.
> > - *
> > - ******************************************************************************/
> > -
> > -acpi_status
> > -acpi_ns_one_complete_parse(u32 pass_number,
> > -                          u32 table_index,
> > -                          struct acpi_namespace_node *start_node)
> > -{
> > -       union acpi_parse_object *parse_root;
> > -       acpi_status status;
> > -       u32 aml_length;
> > -       u8 *aml_start;
> > -       struct acpi_walk_state *walk_state;
> > -       struct acpi_table_header *table;
> > -       acpi_owner_id owner_id;
> > -
> > -       ACPI_FUNCTION_TRACE(ns_one_complete_parse);
> > -
> > -       status = acpi_get_table_by_index(table_index, &table);
> > -       if (ACPI_FAILURE(status)) {
> > -               return_ACPI_STATUS(status);
> > -       }
> > -
> > -       /* Table must consist of at least a complete header */
> > -
> > -       if (table->length < sizeof(struct acpi_table_header)) {
> > -               return_ACPI_STATUS(AE_BAD_HEADER);
> > -       }
> > -
> > -       aml_start = (u8 *)table + sizeof(struct acpi_table_header);
> > -       aml_length = table->length - sizeof(struct acpi_table_header);
> > -
> > -       status = acpi_tb_get_owner_id(table_index, &owner_id);
> > -       if (ACPI_FAILURE(status)) {
> > -               return_ACPI_STATUS(status);
> > -       }
> > -
> > -       /* Create and init a Root Node */
> > -
> > -       parse_root = acpi_ps_create_scope_op(aml_start);
> > -       if (!parse_root) {
> > -               return_ACPI_STATUS(AE_NO_MEMORY);
> > -       }
> > -
> > -       /* Create and initialize a new walk state */
> > -
> > -       walk_state = acpi_ds_create_walk_state(owner_id, NULL, NULL, NULL);
> > -       if (!walk_state) {
> > -               acpi_ps_free_op(parse_root);
> > -               return_ACPI_STATUS(AE_NO_MEMORY);
> > -       }
> > -
> > -       status = acpi_ds_init_aml_walk(walk_state, parse_root, NULL,
> > -                                      aml_start, aml_length, NULL,
> > -                                      (u8)pass_number);
> > -       if (ACPI_FAILURE(status)) {
> > -               acpi_ds_delete_walk_state(walk_state);
> > -               goto cleanup;
> > -       }
> > -
> > -       /* Found OSDT table, enable the namespace override feature */
> > -
> > -       if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_OSDT) &&
> > -           pass_number == ACPI_IMODE_LOAD_PASS1) {
> > -               walk_state->namespace_override = TRUE;
> > -       }
> > -
> > -       /* start_node is the default location to load the table */
> > -
> > -       if (start_node && start_node != acpi_gbl_root_node) {
> > -               status =
> > -                   acpi_ds_scope_stack_push(start_node, ACPI_TYPE_METHOD,
> > -                                            walk_state);
> > -               if (ACPI_FAILURE(status)) {
> > -                       acpi_ds_delete_walk_state(walk_state);
> > -                       goto cleanup;
> > -               }
> > -       }
> > -
> > -       /* Parse the AML */
> > -
> > -       ACPI_DEBUG_PRINT((ACPI_DB_PARSE,
> > -                         "*PARSE* pass %u parse\n", pass_number));
> > -       acpi_ex_enter_interpreter();
> > -       status = acpi_ps_parse_aml(walk_state);
> > -       acpi_ex_exit_interpreter();
> > -
> > -cleanup:
> > -       acpi_ps_delete_parse_tree(parse_root);
> > -       return_ACPI_STATUS(status);
> > -}
> > -
> >  /*******************************************************************************
> >   *
> >   * FUNCTION:    acpi_ns_parse_table
> > --
> > 2.46.0
> >
> >
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

