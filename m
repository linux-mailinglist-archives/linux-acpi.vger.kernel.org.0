Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633914F449F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Apr 2022 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiDEOqf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Apr 2022 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387855AbiDEOc4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Apr 2022 10:32:56 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E18EDF2B
        for <linux-acpi@vger.kernel.org>; Tue,  5 Apr 2022 06:14:40 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id x21so17058305ybd.6
        for <linux-acpi@vger.kernel.org>; Tue, 05 Apr 2022 06:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvOaH0ER71tusCcIPLqQC4dJdJu4fGW+h9h/KwcZ8Y8=;
        b=iNc1IzVsWCjf8tIfoD2ZSZ8tJqFZdg9Cg2hyCGYQL2SgszrLY13QfjxtpEg/H3rY9a
         iwqfQtDIdxyu+6MNKeV5kUIpz48aHsIZdNcDOuStDv2nKL0LV+gWn7/brhqVjd/9uCUC
         1jK0gjaSrkADzh22gTdTHwQm40CB/RUo3CszFTTOTcb+lN1vsO6FTsAx4ILlknlciS1I
         9b3doxGQH1h4EZgVDvgu5ESKdcBMQzCMd8hkn8oJWXp6tl3N7E778qpUyvhjLJpwCuVT
         s4MxuCmSufmjRWkwuAvjt26dQK2qb6x/kULqKKrj+7kCN8s42FUzKiPAAW+dVrP5YXI6
         tuvA==
X-Gm-Message-State: AOAM532qtVVUzXKAQQ7LtWJTWf3hZOIiHkilpoPTQiI1KlO4uRAQ65iH
        UswaNRGo7aLlR5F+XFyyPmAoLvu2aRjrYSkPloM=
X-Google-Smtp-Source: ABdhPJyQFt/MP1BpjrApObfcj1Gi1R/qyxjxsm0AbmN2lntNyuWJq9z9W/qYAInQcwlCtizabIjuuzArYHpSytEd7cM=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr2540036ybu.622.1649164478907; Tue, 05
 Apr 2022 06:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647525033.git.vit@kabele.me> <YjM/6rqxZN19en2I@czspare1-lap.sysgo.cz>
In-Reply-To: <YjM/6rqxZN19en2I@czspare1-lap.sysgo.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Apr 2022 15:14:27 +0200
Message-ID: <CAJZ5v0iSCrU3AeEaTxVkbma_0Wi9LPPRiP_NbmuAgDOeDS9c0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] acpica: Check that the EBDA pointer is in valid range
To:     platform-driver-x86@kernel.org, r.marek@assembler.cz,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert Moore <robert.moore@intel.com>, linux-kernel@kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     vit@kabele.me
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

On Thu, Mar 17, 2022 at 3:12 PM Vit Kabele <vit@kabele.me> wrote:
>
> If the memory at 0x40e is uninitialized, the retrieved physical_memory
> address of EBDA may be beyond the low memory (i.e. above 640K).
>
> If so, the kernel may unintentionally access the VGA memory, that
> might not be decoded or even present in case of virtualization.
>
> Signed-off-by: Vit Kabele <vit@kabele.me>
> Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
> ---
>  drivers/acpi/acpica/tbxfroot.c | 7 +++++--

Changes in the ACPICA code need to be submitted to the upstream ACPICA
project via https://github.com/acpica/acpica and they are pulled from
there into the kernel.

Of course, this applies to the next patch in the series too.

>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
> index 9fec3df6c3ba..67b7df1c0520 100644
> --- a/drivers/acpi/acpica/tbxfroot.c
> +++ b/drivers/acpi/acpica/tbxfroot.c
> @@ -138,8 +138,11 @@ acpi_find_root_pointer(acpi_physical_address *table_address)
>         acpi_os_unmap_memory(table_ptr, ACPI_EBDA_PTR_LENGTH);
>
>         /* EBDA present? */
> -
> -       if (physical_address > 0x400) {
> +       /* Check that the EBDA pointer from 0x40e is sane and does not point
> +        * above valid low memory
> +        */
> +       if (physical_address > 0x400 &&
> +           physical_address < 0xA0000) {
>                 /*
>                  * 1b) Search EBDA paragraphs (EBDA is required to be a
>                  *     minimum of 1K length)
> --
> 2.30.2
>
