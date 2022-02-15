Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC854B7605
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Feb 2022 21:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243371AbiBOTFZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Feb 2022 14:05:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbiBOTFZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Feb 2022 14:05:25 -0500
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA096F94F2
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 11:05:14 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id c6so59166266ybk.3
        for <linux-acpi@vger.kernel.org>; Tue, 15 Feb 2022 11:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5Gx5UNRmPnQ1up15AhhuwaryuHMTEA8mCwrwfpbeGo=;
        b=tqq5s15DYYNkdnB0pmmxtRUMKuA2F3/HciFo5fgUTrs2aCW3AUsT5P/1qjxuncnZfE
         XGQIGGHrOzfyoV/nJ78f6lodwllR65H0OOl1xkHF3m4Fm/CQdUhXAlDMJtp3ZtXe8ZYp
         CBdM98Qwv7ulUlWWwvVTkRC26BG2LReiOUmT+Lgb8U7fFwMnO4KXPdvX2r3mD+Jen7Le
         U2z9Rv58nyA8EfUuTXGMSaZdCVjLc1wgpqf2EaGCj1DX2KIbv5AM+4osJsE8p9NrgClt
         sIDGoDkXdpH1WlIHgAFC8GLO8V32242CZRd1OFtuUmRjSBMRhAbc4jvmp339DfOYnPb9
         N1Zw==
X-Gm-Message-State: AOAM531Te/iqhzXNpXyzm1E4RLlncLvx3np/88ge9zZkCwyVzlsfEr5j
        IBrCC/Dp1TgBZnGJromOHzNeTHtvqoI4npFJeVY=
X-Google-Smtp-Source: ABdhPJzQM4o9FN2kr1DysBeKgbz92gwL+HkS8626hXbn8+ljGl9yP1APzM6xAwNGd5zERV5Xkx5siKfqvwKXFQYHh7k=
X-Received: by 2002:a25:bd0b:: with SMTP id f11mr324938ybk.475.1644951913875;
 Tue, 15 Feb 2022 11:05:13 -0800 (PST)
MIME-Version: 1.0
References: <55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de> <164495126389.3958890.23245745243532605.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164495126389.3958890.23245745243532605.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Feb 2022 20:05:02 +0100
Message-ID: <CAJZ5v0iQnZx35Exo2vO0CC_k3sk3YDipopde+Cqo9XWWdhZ+Dg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Quiet ACPI table not found warning
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 15, 2022 at 7:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Paul reports that the ACPI core complains on every boot about a missing
> CEDT table. Unlike the standard NUMA tables (SRAT, MADT, and SLIT) that
> are critical to NUMA init, CEDT is only expected on CXL platforms. Given
> the notice is not actionable lower its severity to debug.
>
> Link: https://lore.kernel.org/r/55f5c077-061c-7e53-b02d-53dde1dd654f@molgen.mpg.de
> Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/acpi/tables.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 0741a4933f62..34600b5b9d8e 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -400,7 +400,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>
>         acpi_get_table(id, instance, &table_header);
>         if (!table_header) {
> -               pr_warn("%4.4s not present\n", id);
> +               pr_debug("%4.4s not present\n", id);
>                 return -ENODEV;
>         }
>

Applied as a fix for 5.17-rc5, thanks!
