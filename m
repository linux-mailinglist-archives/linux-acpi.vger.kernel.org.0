Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF9702C99
	for <lists+linux-acpi@lfdr.de>; Mon, 15 May 2023 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjEOMZI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 15 May 2023 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEOMZH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2023 08:25:07 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D41BC
        for <linux-acpi@vger.kernel.org>; Mon, 15 May 2023 05:25:04 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96a2b6d698cso167567866b.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 May 2023 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684153502; x=1686745502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU8TkkWi1PLQmP9Q/PJIeLJ+Q7Ze8owevQ+26p3y85U=;
        b=eVjsAWezRgL1wR8n1RO08/uBrmTfnRwo4O3qMApddKoQyL7T/WMiN6ZuljBA5Xn2qG
         oZbg27J3roCXIY6kC6oeS5QQKmXPbKy3/c+6qsXGJJDTcG/pyPW2CVhtDtbGp0sDHHdE
         BOLyclNZ/tqLYB1ZGEwVYoSjFnEwtTxx73SpSgNxGhxwetljNJ2n5QhCAnfuNT6DFNqz
         3bb+juB3zGXMhskLRYCFzZv/nOybJTSsvrxBL0HAlCF9MT9LgEZEbmNOJJKwrcIy7N0u
         mSLD02yZ9Wt6WyaNA9/+onvZ4Is+X7MjDQov2JiUqeiE0cAGqtCCgXU/7ZAW0vZlON7q
         uS0A==
X-Gm-Message-State: AC+VfDxZ+FbgSV7fGatwGRZADDzzhjxnaN7wQIdwRx95wwl0dQQN7FfW
        YCiRmlgFX6vY+93sVve7sX2LeiiPDL2/afl8xGv4BKgy
X-Google-Smtp-Source: ACHHUZ58cJfdj9XeVDR+FO+youSone9XQ44FLD6G4fg5sRDRKFZjRbsDKn5j88F6G1txMue9v3lI2dN2jNovoKz9tgQ=
X-Received: by 2002:a17:906:72cd:b0:965:9db5:3824 with SMTP id
 m13-20020a17090672cd00b009659db53824mr27274524ejl.6.1684153502387; Mon, 15
 May 2023 05:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <jzqzwdedY4SnVMhKdJpA2nv5eA7o6COWGesAYO0Th3IXK2Pu2UoYfKlhd0YJhospEusFM-qmJG5Mzo-vGhE9VzVWebfqbyYlDdk7ZeDUXCI=@proton.me>
In-Reply-To: <jzqzwdedY4SnVMhKdJpA2nv5eA7o6COWGesAYO0Th3IXK2Pu2UoYfKlhd0YJhospEusFM-qmJG5Mzo-vGhE9VzVWebfqbyYlDdk7ZeDUXCI=@proton.me>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 May 2023 14:24:50 +0200
Message-ID: <CAJZ5v0i7Sw6EDDdjiyzG-HHmxy-1NkGz+Tq9BoYG-0_nC=EvRQ@mail.gmail.com>
Subject: Re: [PATCH] Laptop internal keyboard not working on LG UltraPC 17U70P
To:     =?UTF-8?B?UnViw6luIEfDs21leg==?= <mrgommer@proton.me>
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 8, 2023 at 8:03 PM Rubén Gómez <mrgommer@proton.me> wrote:
>
> Hi,
>
> This patch, destined to the specific laptop model LG UltraPC 17U70P, solves an already known problem happening with some devices where the keyboard IRQ is handled with the ActiveLow attribute. The kernel currently ignores that, and as a consequence the internal keyboard stops responding as soon it loads up. This has been extensively discussed in bug 213031 [1]. From the work done there an ad hoc list was introduced in the kernel to handle those devices, as seems like other broader solutions would cause problems to other devices. This patch just adds this laptop model to that list. I filled a bug specifically for this laptop model with number 216983 [2]. Patch is already tested against commit 7163a2111f6c in the linux-pm branch.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213031
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=216983
>
> Signed-off-by: Rubén Gómez Agudo <mrgommer@proton.me>
> ---
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index e8492b3a393a..0800a9d77558 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -516,6 +516,17 @@ static const struct dmi_system_id maingear_laptop[] = {
>         { }
>  };
>
> +static const struct dmi_system_id lg_laptop[] = {
> +       {
> +               .ident = "LG Electronics 17U70P",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -532,6 +543,7 @@ static const struct irq_override_cmp override_table[] = {
>         { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>         { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +       { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,

Fixed up (new subject, new changelog, white space damage fixes) and
applied as 6.4-rc material.

Thanks!
