Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED965747771
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jul 2023 19:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjGDRG2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 4 Jul 2023 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGDRG1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2023 13:06:27 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3C0E5B
        for <linux-acpi@vger.kernel.org>; Tue,  4 Jul 2023 10:06:26 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b5d0b3e288so18084091fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Jul 2023 10:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490385; x=1691082385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W3AtnLx85FDB9HvMr3WoROfLAWQKIuOUpaAW0LQxWc=;
        b=CVwv2J2LWPYJbb8ri8xV1UGuMSG/g433A89/AlF8EBD8KEA4DYdSscWSY/AQBBmmoD
         +C3yHWwa7iS5ESXibhYwYLLhJXAMzUyVqSCmRLmXOpVTe0elzNcuNOxZd1IyVGYHMX/p
         ditEXWIyuKZSgfMPThYlhC+/MRJmLqI6llnjdMeHd8tJtsKoMdjKzYqiXqIO5KwScN7L
         k5mlxGb3sR/gq5B3Rl/dNeKQy0f2b6928xRw71ze5LZjA/C3SFPndQfcQxAW7MPsZNWj
         gkjyFQ2azMw+pwmMqvV1brPBDSU5TSGSdXKqAFi9+uedw9bveIoZB8Wgxg4CTswRfzoh
         jBCg==
X-Gm-Message-State: ABy/qLbpGO+8FUVX6gUSXCIQH3QbfcpEHE0n4A3f2PicwMx4+ltW1YPW
        0c/MJO+I7hq8EVUmzUhbJ22jhXGFx/nsWgvQT2DU7iAt
X-Google-Smtp-Source: APBJJlElPr6Oj29vqyGno+TIumqk0U99I9L5EskAK35OKBkQAzllWotFla2OYhMvIY8hs/vrzPQAgMpNfI8hF9Asg0s=
X-Received: by 2002:a05:651c:1a0a:b0:2b5:ef16:d393 with SMTP id
 by10-20020a05651c1a0a00b002b5ef16d393mr10029672ljb.3.1688490384635; Tue, 04
 Jul 2023 10:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230703122450.951704-1-ben.dooks@codethink.co.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jul 2023 19:06:13 +0200
Message-ID: <CAJZ5v0jXBZNXKJGuMFp7Oh7K6ndnKqruWvAVdiRB4c0LYv48Sw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fix undeclared symbols from saprse
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     acpica-devel@lists.linuxfoundation.org, linux-acpi@vger.kernel.org,
        robert.moore@intel.com, lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 3, 2023 at 2:24 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> The building of drivers/acpi/acpica/utglobal.o is throwing
> a number of sparse warnins about undeclared symbols. This is
> due to defining DEFINE_ACPI_GLOBALS then making the macro
> ACPI_INIT_GLOBAL() define it but never declaring the fact this
> is an extern declared varible.
>
> This is some of the sparse warnings that are being fixed here:
>
> drivers/acpi/acpica/utglobal.c: note: in included file (through include/acpi/acpi.h):
> ./include/acpi/acpixf.h:104:1: warning: symbol 'acpi_gbl_enable_interpreter_slack' was not declared. Should it be static?
> ./include/acpi/acpixf.h:113:1: warning: symbol 'acpi_gbl_auto_serialize_methods' was not declared. Should it be static?
> ./include/acpi/acpixf.h:120:1: warning: symbol 'acpi_gbl_create_osi_method' was not declared. Should it be static?
> ./include/acpi/acpixf.h:126:1: warning: symbol 'acpi_gbl_use_default_register_widths' was not declared. Should it be static?
> ./include/acpi/acpixf.h:136:1: warning: symbol 'acpi_gbl_enable_table_validation' was not declared. Should it be static?
> ./include/acpi/acpixf.h:141:1: warning: symbol 'acpi_gbl_enable_aml_debug_object' was not declared. Should it be static?
> ./include/acpi/acpixf.h:149:1: warning: symbol 'acpi_gbl_copy_dsdt_locally' was not declared. Should it be static?
> ./include/acpi/acpixf.h:157:1: warning: symbol 'acpi_gbl_do_not_use_xsdt' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Note, if this isn't the correct place to fix, where should this be
> going?

This file belongs to ACPICA.  As a general rule, ACPICA changes should
be submitted as pull requests to the upstream ACPICA project on
GitHub, from where they are backported (semi-automatically) to Linux.

However, if an upstream ACPICA pull request has been submitted, a
corresponding Linux patch can be posted with a Link: tag pointing to
that pull request.

Thanks!

> ---
>  include/acpi/acpixf.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 9ffdc0425bc2..8d69d1e39cd9 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -37,6 +37,7 @@
>         type name
>
>  #define ACPI_INIT_GLOBAL(type,name,value) \
> +       extern type name; \
>         type name=value
>
>  #else
> --
> 2.40.1
>
