Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B023F298
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Aug 2020 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgHGSRY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Aug 2020 14:17:24 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37531 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGSRW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2020 14:17:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id e11so2307191otk.4;
        Fri, 07 Aug 2020 11:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFU9qSetmlHzp98q29/MxQ7l/3U0+Del5PqcymwLD98=;
        b=KlhK+MXJbzVi8NX0AH94C3TTHPdOG4pvEwxx0iX+K29hyuFTWmfrs2DBkl828sWetf
         ldPFcSGG6+bTYAn0wEPng0UywFO7P8Nv0BpI1FrUEvIt4029Chj52lYTdTz0flk9XeRD
         pIfpy6qpDNx+QQDVIWXJtDgI0pXBayxLOQ50NXyMrdyFEccpwTdIEZRsD+HqLRVjsmKL
         sD4pSOAOBdpH9YCrOSwAtQ4jrxOTHBXG8opj8c3PbHl6z+tDJ4AX7Gbrd43kEiQH+Yq6
         ZgTxfbE+ZpIgAADkcROuMhwOFZbrLOO4ey8INm0mBy7GldWMFrWLhPfslWKohFDOBtx0
         WKfg==
X-Gm-Message-State: AOAM532VcXuuHG2njW5pdzp/Qg+sPjKYPSoXibNBuEKfLwbLuGM5ZRPW
        lk0fzUCYOI9eN/68AQnTQDBmQ8eGHMrJuKgHmi0=
X-Google-Smtp-Source: ABdhPJxXOPvQ7Q9jlLfe9GWsFmyrbS1fgxV3RBJTgThMjB5uy4YXGTocdhpyzRH6f2m6zycLzsfJ9F9zicUysX9aYEk=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr12907809oth.262.1596824241773;
 Fri, 07 Aug 2020 11:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200731133604.12512-1-akshu.agrawal@amd.com>
In-Reply-To: <20200731133604.12512-1-akshu.agrawal@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Aug 2020 20:17:10 +0200
Message-ID: <CAJZ5v0iWuv-+ha+5Gem-hVaXCfgVJbNmCZ+6vaeKKtfjay=VoQ@mail.gmail.com>
Subject: Re: [0/4] Extend AMD SoC general purpose clk for all versions
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        rahul.tanwar@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 31, 2020 at 3:36 PM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> Hi,
>
> This series of patch does the following:
> 1. Changes the name of the AMD SoC general purpose clk
> from ST(a version of SoC) to FCH (name of the IP).
> 2. Then make the drivers support both older and newer versions of
> SoC.
>
> Thanks,
> Akshu
>
> Akshu Agrawal (4):
>   ACPI: APD: Change name from ST to FCH
>   clk: x86: Change name from ST to FCH
>   ACPI: APD: Add a fmw property is_raven
>   clk: x86: Support RV architecture
>
>  drivers/acpi/acpi_apd.c                       |  18 ++--
>  drivers/clk/x86/Makefile                      |   2 +-
>  drivers/clk/x86/clk-fch.c                     | 101 ++++++++++++++++++
>  drivers/clk/x86/clk-st.c                      |  78 --------------
>  .../platform_data/{clk-st.h => clk-fch.h}     |  11 +-
>  5 files changed, 119 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/clk/x86/clk-fch.c
>  delete mode 100644 drivers/clk/x86/clk-st.c
>  rename include/linux/platform_data/{clk-st.h => clk-fch.h} (51%)
>
> --

Whole series applied as 5.9-rc1 material, thanks!
