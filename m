Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115013766E8
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhEGONr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhEGONr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 May 2021 10:13:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82735C061574
        for <linux-acpi@vger.kernel.org>; Fri,  7 May 2021 07:12:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b17so10438046ede.0
        for <linux-acpi@vger.kernel.org>; Fri, 07 May 2021 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLniGNx4BxwN5Xd2zc0IGUwak+T5o8FFC1I3NPRJVXE=;
        b=uSs5tE4pdnmy1J5EesfN1eVWvpFDfJ1ly/S1gTE+RpFTbkyv0qiHb7E3qglgh8xHeS
         51bFyaQw0kQBalHPUo0unemVmMkSLKeHgnWjmLyZviH5ltlwQ5w8sEy88hLzBwu7ad/B
         zId42r9UHXvzucZJhnw6CY46qlzIOkoSgUuGrt9Qln+5C8FcQvhsJ2TJNZ8XMIPfRNpe
         hH2GQpcVWp/1TFmPymsPLa+DjiOZsOXrMSqn3NO5nSt30M5AUVcS1/z6Jfs5LgU9uaAq
         Z/Xli3WwfSlv2I4lCwDksdIsO3RJhiGl3/c9yr6lKw5xT5P2QsOrTRaen476Jl00SkKB
         KyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLniGNx4BxwN5Xd2zc0IGUwak+T5o8FFC1I3NPRJVXE=;
        b=bkSCBryFcJJoJqRag6n4lGAgcZgMD7P5C67UtqNvjmHitWOXuLc4vuNZgdmaodWFnq
         AdnOohHzMSRO+P/UBxRWbkS8fpoyiB9B6h8N1eiJIy1Nw+FCVACVYbXkNn4cxpp10jn4
         QodmykVrf2v2Je8ZA4MbVTFhA2Cg2qmDEOfJi1fAMD3DWVT587A5D7xVixH+gUa1N2SX
         nkEFEo5F96fzQ/weBUHSgWiVE7cwbeCtIqTnH5cwkS987Wz5P78qBwMmeez/yXcG+eV8
         Jx12d0A2gWo6y+z70OnmRfIKCwHUadNPg6bxJ0RljoL7UOVPLjmTQIVIxWm9Z9SKMtsV
         ZaZw==
X-Gm-Message-State: AOAM530J6XLB0/JrqsCRJtiipxBmzA/CJ7FLFt1nBX8QuzBXFBinzoPR
        f349x/pL2njUVMTt8Y2z6vN3O+fHMQ3YMFGGlhl7Qg==
X-Google-Smtp-Source: ABdhPJwWyScMuqXDcIBAuztYBHKcNDRNOaJtIKcFL4gBL8++2X0f1kwToRZXeC3Mdnv0qiilb3DxuPS08o181IP/mbQ=
X-Received: by 2002:a50:f0d6:: with SMTP id a22mr11880375edm.354.1620396766237;
 Fri, 07 May 2021 07:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 May 2021 07:12:51 -0700
Message-ID: <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Dan,
>
> On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > Address (SPA) Range Structure". The presence of that new field is
> > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > firmware implementations omit the flag and maintain the original size of
> > the structure.
> >
> > Update the implementation to check that flag to determine the size
> > rather than the ACPI 6.4 compliant definition of 'struct
> > acpi_nfit_system_address' from the Linux ACPICA definitions.
> >
> > Update the test infrastructure for the new expectations as well, i.e.
> > continue to emulate the ACPI 6.3 definition of that structure.
> >
> > Without this fix the kernel fails to validate 'SPA' structures and this
> > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > SPAs are valid if it finds valid SMBIOS tables.
> >
> >     BUG: unable to handle page fault for address: ffffffffffffffa8
> >     [..]
> >     Call Trace:
> >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> >      skx_register_mci+0x132/0x1c0 [skx_edac]
> >
> > Cc: Bob Moore <robert.moore@intel.com>
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
>
> Do you want me to apply this (as the commit being fixed went in
> through the ACPI tree)?

Yes, I would need to wait for a signed tag so if you're sending urgent
fixes in the next few days please take this one, otherwise I'll circle
back next week after -rc1.

>
> If you'd rather take care of it yourself:
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
