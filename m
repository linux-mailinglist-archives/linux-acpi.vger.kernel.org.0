Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8A3572D8
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354667AbhDGRML (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 13:12:11 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33296 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhDGRMK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Apr 2021 13:12:10 -0400
Received: by mail-oi1-f174.google.com with SMTP id w70so19545857oie.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Apr 2021 10:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoRSxI+sWKsXSLYqhnx0GoEZg3FdxK88yTnDJBoR40c=;
        b=Kpy8Th/bZpOGdx4ijJ/PYouXgJ6tMTjNJXriXNzTqRKmgFzGDGZw/AGVyHYLHN1Qxc
         V0rmV32KqVSdKqFB5vyLqMoGrUQpQAJlHCwrtuq7kQz0qdauwg9GMvgxER+xXHqaN2eN
         dC9fbVq83TePD7swNmHoRABdUcn7jroqBbG0ElaBJ8jbCJCtzHuYvH0bdLNnHJUklX0u
         i5a6RBYA2DNa7nNIQLjTqCe5iXLFQqyryThQvVj6h36SefySi6Ck05xdyevcD+eFxLZv
         jCWlH/w3FnkYqDwCVygRuKBcjpWu6qTOft5uPoIy4dpMYPaV0zw/yXCHCD4BoOTnRERK
         w0yw==
X-Gm-Message-State: AOAM533S9kBP5+HSoosfUsiohy682TJMEtRshwqc448qkcCrNNmCq5vw
        WnpZ1kHyswXwDsEEvgsxIc/sFKpSjF8xzm6MwTv7MWrG
X-Google-Smtp-Source: ABdhPJw/nD9+D2gfyQbA83gG1X3CgaZHoJgtorOuVP+o86k7K2XPLGTl2Kf7gai66l2nUcObNhhroog+zAKsmSHFxEk=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr2992031oif.71.1617815520412;
 Wed, 07 Apr 2021 10:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210406213028.718796-1-erik.kaneda@intel.com>
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Apr 2021 19:11:49 +0200
Message-ID: <CAJZ5v0janTWJ1Q4CeAyuxM5QOn3nuqkQey2n9yWyabpR-LX42A@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] ACPICA release 20210331 (ACPI 6.4 support)
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 7, 2021 at 12:05 AM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> This series contains the Linux-ized patches of ACPICA version 20210331.
> This release implements changes to implement the ACPI 6.4 specification
> as well as several new tables defined outside of the ACPI specification.
>
> v2: fix build issue stemming modified NFIT structure
>
> This patch set is also available here:
>
> https://github.com/SchmErik/linux/tree/20210331
>
>
> Alexander Monakov (1):
>   ACPICA: Add parsing for IVRS IVHD 40h and device entry F0h
>
> Ben Widawsky (1):
>   ACPICA: CXL 2.0: CEDT: Add new CEDT table
>
> Bob Moore (8):
>   ACPICA: ACPI 6.4: NFIT: add Location Cookie field
>   ACPICA: ACPI 6.4: HMAT: add new fields/flags
>   ACPICA: ACPI 6.4: Add new flags in SRAT
>   ACPICA: ACPI 6.4: PMTT: add new fields/structures
>   ACPICA: ACPI 6.4: add CSI2Bus resource template
>   ACPICA: iASL: Add support for CEDT table
>   ACPICA: iASL: Decode subtable type field for VIOT
>   ACPICA: Update version to 20210331
>
> Colin Ian King (1):
>   ACPICA: Tree-wide: fix various typos and spelling mistakes
>
> Erik Kaneda (8):
>   ACPICA: ACPI 6.4: Add new predefined objects _BPC, _BPS, and _BPT
>   ACPICA: ACPI 6.4: add USB4 capabilities UUID
>   ACPICA: ACPI 6.4: add CXL ACPI device ID and _CBR object
>   ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
>   ACPICA: ACPI 6.4: PCCT: add support for subtable type 5
>   ACPICA: ACPI 6.4: PPTT: add new version of subtable type 1
>   ACPICA: ACPI 6.4: add SDEV secure access components
>   ACPICA: ACPI 6.4: add support for PHAT table
>
> Jean-Philippe Brucker (2):
>   ACPICA: iASL: Add definitions for the VIOT table
>   ACPICA: acpisrc: Add missing conversion for VIOT support
>
> Shameer Kolothum (1):
>   ACPICA: IORT: Updates for revision E.b

All applied as 5.13 material, thank you!
