Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AF624A71
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKJTRU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 14:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJTRS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 14:17:18 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4582CE10
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:17:17 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id v8so1732363qkg.12
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 11:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hkp748D/4pu2AMsTFyvTUkK0GV/pf+x3WHzs2WM18PQ=;
        b=iu7HxuiqYSDGDU7nr8M/GTOijHs6pBUELAsbf4D9lgqsVfmHF432LlHI0vsph6wFnc
         Pu2GFtBveLKZ6GbKifI7GcGA4TopwOk/bk4vSpa7p5jBYu0Jyo1bAg50jwrSy8gwithv
         wZAvoFWFlLUP6rhH0VDCOeVS850XD+TaLkKZmIj4HWbv3dK5o5Xlznz9FI9pVNQxegEb
         j30WA0LOQdE+yp7tMds0Q5DHghTYqcFYQgZzXQkRLnhe/XkTtRy1TerR2i49wIVBxrvn
         CEhrAfZZyVudz/gWdedplcGN4cUlzFl2++fG30SEkwFhrsTRZNtKlMUW9TXVav6C2fzA
         cdFw==
X-Gm-Message-State: ACrzQf2Ec6tODpebLs1DJQo8E2bx/ck28ngy9vOCBweBpAoY/CG2yp9J
        nLZ8Yr9016wdVIqS74Xea31Rho4fQ6hnpSyyitQ=
X-Google-Smtp-Source: AMsMyM6gcurKR1hGr4IfMU+WKmBdvapYR9fu8d6zVhTk+kIdd3szRWl9/99U66+3nrX7qzAzMEFbqbF+trBhEpEWT3E=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr36257333qkl.23.1668107836818; Thu, 10
 Nov 2022 11:17:16 -0800 (PST)
MIME-Version: 1.0
References: <1667552078-48344-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1667552078-48344-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:17:05 +0100
Message-ID: <CAJZ5v0hwLWUw2HqJ8z-P-tnkEnYA+SF9OwHbVOd5LbU2eLBCQw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tables: Fix the stale comments for acpi_locate_initial_tables()
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 4, 2022 at 10:09 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> sdt_entry[] is long gone by commit ceb6c4683902 ("ACPICA: Remove
> duplicate table manager"), update the comments to avoid confusion.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/tables.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 47ec11d..afb365a 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -838,12 +838,11 @@ acpi_status acpi_os_table_override(struct acpi_table_header *existing_table,
>  /*
>   * acpi_locate_initial_tables()
>   *
> - * find RSDP, find and checksum SDT/XSDT.
> - * checksum all tables, print SDT/XSDT
> + * Get the RSDP, then find and checksum all the ACPI tables.
>   *
> - * result: sdt_entry[] is initialized
> + * result: initial_tables[] is initialized, and points to
> + * a list of ACPI tables.
>   */
> -
>  int __init acpi_locate_initial_tables(void)
>  {
>         acpi_status status;
> --

Applied as 6.2 material, thanks!
