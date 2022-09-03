Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06825AC0BD
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Sep 2022 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiICS0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Sep 2022 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiICS0z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Sep 2022 14:26:55 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8AE42AE8
        for <linux-acpi@vger.kernel.org>; Sat,  3 Sep 2022 11:26:53 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 202so2823449ybe.13
        for <linux-acpi@vger.kernel.org>; Sat, 03 Sep 2022 11:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c2u7bnsZ8XRnTuNhDkMsoT3UOTRQ1PU9dR0sFmS+Kt8=;
        b=bvsPM78tNmUigFLqZtjRTYQU7LLJ8+nKqxgQkp/mjFxlZZkDTvvU+ThAt9zu7BhTbr
         kfgJxWrA/6KpDeIlp5j4GRjlYaAqtewEQSP0QAkki8Z1q7GIZF6MgUy9538nwuAEN/Pr
         FcEsQWgJLSfkBMQCAwXFWhFbEofo21jnFzCGIhNhSnHTxQiFU2mhASltPgdpO7sb7yST
         Rvr3JVtXpICKF0C6aSvGBd1MlrI/L9sx8mDhs8FcEgQr+2V6wdiD88lLUqsCC8EC6Y5Z
         RQ/Wq+Vf22P8dMJPr9bl/oe3KnbsCmf0q7d611cRroaIp74eom9Aqi9NPW8qHjlFUQ+o
         c6dg==
X-Gm-Message-State: ACgBeo3HBWnU7UK3yffxOpbCkdzvfZzEjJhEGZjoPN0usz3bredkNYe1
        QhoLC83/hGSaSFaFqgqmG3fSzk4Vfld/hY4tnE8=
X-Google-Smtp-Source: AA6agR6CkoZQq7jsH17uE6LiG8nDoTmAfN/jlfZ8IhbtJ4ZyGBQxpmZuhCvq5PiPIQZ4JbPQ9ovH11s7FJb7SCdqEnI=
X-Received: by 2002:a25:2785:0:b0:69b:b1d2:fd05 with SMTP id
 n127-20020a252785000000b0069bb1d2fd05mr22994817ybn.81.1662229613011; Sat, 03
 Sep 2022 11:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <1661346073-730819-1-git-send-email-dmtrmonakhov@yandex-team.ru>
In-Reply-To: <1661346073-730819-1-git-send-email-dmtrmonakhov@yandex-team.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:26:42 +0200
Message-ID: <CAJZ5v0iZB1D0HGm9oX1n-ECj=eriKts8Ua3+YKr4b1DpdB4+sQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Add BERT error log footer
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Aug 24, 2022 at 3:02 PM Dmitry Monakhov
<dmtrmonakhov@yandex-team.ru> wrote:
>
> Print total number of records found during BERT log parsing.
> This also simplify dmesg parser implementation for BERT events.
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

Applied as 6.1 material with an ACK from Tony.

Thanks!
