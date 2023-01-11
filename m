Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510F96657F3
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jan 2023 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjAKJrL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Jan 2023 04:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbjAKJqf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2023 04:46:35 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8C317E0C
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 01:44:28 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id u9so35458310ejo.0
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2023 01:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDJk/IY9RuEK56wCfr65vYLHErs9j10EgsadVOzTykE=;
        b=pAIFXXxIbrdYElLzHF2FCmFufcBfxyahHMZxv4Uw4qGv+aoLcx378ZoyeK5k0zqDGa
         b7PVHB1ZPmV1i+kI/Q5oTsMGJwg9S6kIy9EXhkPqIMvKFe5ShzLIutL4MIuT+1N7LeUG
         ps5+DrOLVFIcjEhrLdS6WdRsf4puXf9E3eZ2JloS8EeJThbBPRNWo/8tus86QJma6K4Q
         PGGN//CY4EuDXhoXWhDU75PGmM8FnC/9+pHYDMxxjU4AD8krSypk3c6fBo2v9IzkrVp2
         /HkrFxPRoi3RGcJHKZg666ndBA7m0BmuND5Xc5DEgLLmYK0wJLR4WRwtiAwNzcdy5diM
         AOiQ==
X-Gm-Message-State: AFqh2kp4ZMdIMYl5uO2xVAHhev9Jli69qfAVok9Kue7BTFhZt/0+eOpu
        G5yGeDFJI51zTYKSlIwOdu2UA9Lu6gi8u2M24XM=
X-Google-Smtp-Source: AMrXdXu5Mpi1mZKsBH5auyDPLvx5zVBmNgxh9MHhkLGSAMZVxCjQlpOnU+QJX/Gb0g4EcI4upyQu+tDxOCy1MmEvYfM=
X-Received: by 2002:a17:907:8d0e:b0:7b2:7b45:2cd2 with SMTP id
 tc14-20020a1709078d0e00b007b27b452cd2mr6281582ejc.615.1673430266546; Wed, 11
 Jan 2023 01:44:26 -0800 (PST)
MIME-Version: 1.0
References: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
In-Reply-To: <ef8c7138-8ed1-d849-0ed5-e629ddcafd63@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 10:44:14 +0100
Message-ID: <CAJZ5v0hsgLpWecW=imR09jUNnrs0i9kxnVnchh5GQeRQLEx2tg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/ACPI: Ignore CPUs that are not online capable for
 x2apic, entries as well
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 22, 2022 at 7:26 PM James Puthukattukaran
<james.puthukattukaran@oracle.com> wrote:
>
> Extending commit aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not
> online capable") to include acpi_parse_x2apic as well. There is a check
> for invalid apicid; however, there are BIOS FW with madt version >= 5

It would be good to give at least one example of a platform where this happens.

> support that do not bother setting apic id to an invalid value since they
> assume the OS will check the enabled and online capable flags.
>
> Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
> Reported-by: Benjamin Fuller<ben.fuller@oracle.com>
>
> v2 : use 'enabled' local variable. Also fix checkpatch.pl catches
> v3 : updates as per Rafael's comments
> ---
>  arch/x86/kernel/acpi/boot.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..cf2509f9de31 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -208,7 +208,15 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
>         apic_id = processor->local_apic_id;
>         enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
>
> -       /* Ignore invalid ID */
> +       /* don't register processors that can not be onlined */
> +       if (!enabled && acpi_support_online_capable &&
> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))

I would add a MADT version check to this, because
ACPI_MADT_ONLINE_CAPABLE may be set by mistake in an older BIOS too.

> +               return 0;
> +
> +       /*
> +        * for systems older than madt version 5 (does not have

Also please spell MADT in capitals.

> +        * ACPI_MADT_ONLINE_CAPABLE defined); ignore invalid ID
> +        */
>         if (apic_id == 0xffffffff)
>                 return 0;
>
> --
