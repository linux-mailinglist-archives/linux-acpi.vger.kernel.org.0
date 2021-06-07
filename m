Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70B139DC24
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFGMZL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 7 Jun 2021 08:25:11 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34502 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMZK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 08:25:10 -0400
Received: by mail-oi1-f179.google.com with SMTP id u11so17832902oiv.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 05:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCw6LqVcomzEqqujdFHiNyHGkT82MjMLx4Phtx56qGI=;
        b=UBdT364KT0CB8BX5EtVijgCG7WwteeIStQIyPyiCf//HfMftiVT1a79Pe/kEiVUxKt
         ZknTt6eXVLrIgnE0AbSYjMqBLmfq2lmV0nZg1sZmgLdQgO7kJBa0WTqYD3iv7PxiRejo
         6YWL/QgQhUDtOg4VF4LlXtghy6EMHPjG/IZmJZu7S1pCYS5MberwXCx529LGFm1MX5CS
         svrRJqb+vZ4tL2wm00eSnWNeYe9LZmDHbr1YWjvAU3a+PJamg52wimJim1U6agsR0L4d
         NxAEjoCs3dt89IEm4Pm/5kYLxUQE+jAfxjqYl8mtdK5n8OX2yj/IhnAh9N/jj0+Ognv9
         HIHw==
X-Gm-Message-State: AOAM531bDwxy1KUSRZ40eGx7+xl9sxztRMrg2MjEAHc3f5jFeiToMhDr
        BztkPN9VKdYADlK5D52H64SevO/q/2WXoHchcijdnhRn
X-Google-Smtp-Source: ABdhPJxo8eq8JPJ0aeJUiac43GpdBhblif6QMQufDMgFBTybbdctDzge5xjkUpQbynvTxPgCrtm2Ul/umUGxDH6+Z9Q=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10545300oii.69.1623068584483;
 Mon, 07 Jun 2021 05:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:22:53 +0200
Message-ID: <CAJZ5v0h8fG1LJo0a+EWC3T2nOaLC3zXR5uSU2gHrrOgK=j7PrQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] ACPICA version 20210604
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 5, 2021 at 12:00 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This series contains the linux-ized patch set of ACPICA version
> 20210604. The patch mostly contains additional structures for ACPI
> tables. In addition, this patch set contains ACPICA support for
> a new OperationRegion subtype called PlatformRtMechanism (for PRM).
> As far as ACPICA is concerned, this subtype will hand off a buffer to a
> handler registered by the OS.
>
> Other than that, I will be leaving Intel and this will be my last
> ACPICA release. With that said, Rafael will take over this role for
> the timebeing. If you have any ACPICA related questions, I will be
> around for a few more days so please feel free to reach out.

Many thanks for the great work you've done on the ACPICA front Erik,
and good luck with your future endeavours!

> Alison Schofield (2):
>   ACPICA: Add defines for the CXL Host Bridge Structure (CHBS)
>   ACPICA: Add the CFMWS structure definition to the CEDT table
>
> Bob Moore (5):
>   ACPICA: iASL: Finish support for the IVRS ACPI table
>   ACPICA: iASL: Add support for the SVKL table
>   ACPICA: iASL Table Compiler: Add full support for RGRT ACPI table
>   ACPICA: iASL: Add support for the BDAT ACPI table
>   ACPICA: Update version to 20210604 Version 20210604.
>
> Erik Kaneda (3):
>   ACPICA: Fix memory leak caused by _CID repair function
>   ACPICA: iASL: add disassembler support for PRMT
>   ACPICA: Add support for PlatformRtMechanism OperationRegion handler
>
> Fabian Wüthrich (1):
>   ACPICA: Add _PLD panel positions
>
> Kuppuswamy Sathyanarayanan (2):
>   ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
>   ACPICA: Add SVKL table headers
>
> Wei Ming Chen (1):
>   ACPICA: Use ACPI_FALLTHROUGH

The entire series has been applied as 5.14 material, thanks!
