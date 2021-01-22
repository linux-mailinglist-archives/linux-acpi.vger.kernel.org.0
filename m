Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC430075C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbhAVPbV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:31:21 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:40847 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbhAVPaz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:30:55 -0500
Received: by mail-oo1-f43.google.com with SMTP id v19so1480747ooj.7;
        Fri, 22 Jan 2021 07:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03dJtu15+0cRiddI8u8vo7xYDnw351QffqYb99/wZ+I=;
        b=MycVuxDtCgXQni6sazaoTwsobd6RepJ/4z5Fm8NMsHh1D74LkAXgjPS0W1WBhbxYiz
         S+hQhcJabftb6Qgs1N9Cud9KgdrwQiqKo4EPWlh3VdvCglzZrLpZVNUflPIBba8gWAKl
         ReQt+AZa5HoQ/MoXdX/zDt1fW4CnJD/juagomYmbIPULst5EuMBQttTvIUVuA+ORKdLl
         uwyaW0RwXW2AnxHEGR2CAlRX8t2rFGEMtm0U+Lf4Qf/nA9qKuaXlvMXLvKYNkewuaQG6
         NxUsZ7sLExG7s5tAi38e1CBOR2ovSv9iPf9PVcdpkR86Pjep6sCMLEMJBWRfRDcnSOuw
         Uuwg==
X-Gm-Message-State: AOAM532njUsCcctN+7HZdFHZlcyfQH/a6MCZ4usvarVkEAIjPW1UynVZ
        ZX+Mv1VSbvyKOCQDgDfilpRGigua2Xq5FEBK4hI=
X-Google-Smtp-Source: ABdhPJypDIpwXOwWEvsQiUYJPHvf2c/qZonMf17BPHO0tP9zDLNfTU65dOnzyY56B+x72PFYn//9l693HkxjGk1osS4=
X-Received: by 2002:a4a:c191:: with SMTP id w17mr4167031oop.1.1611329414498;
 Fri, 22 Jan 2021 07:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20210107111717.5571-1-ionela.voinescu@arm.com>
In-Reply-To: <20210107111717.5571-1-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:30:03 +0100
Message-ID: <CAJZ5v0h61E3zK=1Z5a=Dz7oRGNg-mrmxR68_r6izHVi1UNm+yA@mail.gmail.com>
Subject: Re: [PATCH 0/3] acpi: cppc_acpi: fix sparse warnings
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 7, 2021 at 12:19 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi guys,
>
> These patches just fix some trivial sparse warnings.
>
> Hope they help,
> Ionela.
>
> Ionela Voinescu (3):
>   acpi: cppc_acpi: remove __iomem annotation for cpc_reg's address
>   acpi: cppc_acpi: add __iomem annotation to generic_comm_base pointer
>   acpi: cppc_acpi: initialise vaddr pointers to NULL
>
>  drivers/acpi/cppc_acpi.c | 8 ++++----
>  include/acpi/cppc_acpi.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
>
> base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
> --

All patches in the series applied as 5.12 material with some minor
edits in the subjects, thanks!
