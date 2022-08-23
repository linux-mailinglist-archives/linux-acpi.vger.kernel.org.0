Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68D59EAC4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Aug 2022 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiHWSRW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Aug 2022 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiHWSPY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Aug 2022 14:15:24 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F81165
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 09:29:47 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3378303138bso353476207b3.9
        for <linux-acpi@vger.kernel.org>; Tue, 23 Aug 2022 09:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EbN2+B9FOsFQerAauxUt5kHcJeVWvPCLOc8XK2LUD1k=;
        b=ncKnbuWqABw9fVFiRZmv1043SNvJdDONYKtdR/xx12RIR1usCCci8cLFP5NxwdJm3M
         JscOOmR+cxcJTSWFWqxogkUmgDu3RWKoIaIj05dijXedI+sVH7uoSFZdsa/qKaDZu2MK
         jBYnZNnaenqqYk3X+mw5PV1/mOJoDU+kIIt1ExiEJIuwgLX7NV2Z0XTN0FAi0307oSd2
         XYast8uI4zj4oP/ssRJgHNeMuLMyxtxzHmeFkZi/0vzv4q6uiUW9U1oY/qyqL8fu+fdr
         sONWWvbnEaOVs5liNIxWwo2/SrYUDo28iLWarGsVlj/mHp0f4uILyGtIbvuvRZjQRXjr
         yd7Q==
X-Gm-Message-State: ACgBeo02vcYSdI9RcVDB6hYrUzBARnj+mClugLfBOeCpcwvRG/ufAAgN
        z3E+XcEmwvoovt73s33bQmOkbx58jB0TAD6Ss1xiYrpn
X-Google-Smtp-Source: AA6agR7i/FzKDUyWyPQmXKQ5/RgEKS5YuKZlYqREDbCxJj6l9JNq7pju/MTerR07ms6utBhuTAKpz9T3juWNtKRtmqs=
X-Received: by 2002:a0d:f647:0:b0:328:317c:9069 with SMTP id
 g68-20020a0df647000000b00328317c9069mr25970442ywf.301.1661272186158; Tue, 23
 Aug 2022 09:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1660554889-174857-1-git-send-email-dmtrmonakhov@yandex-team.ru>
In-Reply-To: <1660554889-174857-1-git-send-email-dmtrmonakhov@yandex-team.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 18:29:35 +0200
Message-ID: <CAJZ5v0hi8jRukb26Th6QX60a9pd9CAZ6wuKYV8zGqtYt4iFKzg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Add bert error log footer
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
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

On Mon, Aug 15, 2022 at 11:22 AM Dmitry Monakhov
<dmtrmonakhov@yandex-team.ru> wrote:
>
> Print total number of records found during bert log parsing.

Please spell BERT in capitals everywhere, including the subject.

> This also simplify dmesg parser implementation for bert events.
>
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
>
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index 45973aa6e06d..c23eb75866d0 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -90,6 +90,9 @@ static void __init bert_print_all(struct acpi_bert_region *region,
>
>         if (skipped)
>                 pr_info(HW_ERR "Skipped %d error records\n", skipped);
> +
> +       if (printed + skipped)
> +               pr_info("Total records found: %d\n", printed + skipped);
>  }
>
>  static int __init setup_bert_disable(char *str)
> --
> 2.7.4
>
