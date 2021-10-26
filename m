Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3A43A99A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhJZBMD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbhJZBMC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2021 21:12:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E1C061767
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 18:09:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y7so12621323pfg.8
        for <linux-acpi@vger.kernel.org>; Mon, 25 Oct 2021 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCITFXxjqJeB6n9UK+yDG2f7cPRezhP5HHhiolMiCjM=;
        b=JBXGkcPdrfcD4ZLvACue6+5w79HWmZ5QfYlCap/SBqJF7MxgoRWbZiHXC3rMjgFOdm
         xcyPi/Xv2fX1ZOkShXNBB/JUsQb6jQKtJjBR3DOSiEwSiHiCm7nPlATmlkHmuFxRrbyP
         HsEtRw/S4+olKzmaMeMxOZGdSQLzBilB947JAnjba1ahavrOcmSSENqbCVjUZl4QnDFP
         p5sHQQBv6X50k9hkOa5A6dX4K6vSlJYcnOZ+t6JT8o5Zw83k+M+xhNSjrzCTy8EAGI2P
         t7yCVx67FuTLtAWpU7THQfwWPRudxaywAT6j1qShjxbeCd8pMz8hiowqsbkPYabOZQqv
         s3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCITFXxjqJeB6n9UK+yDG2f7cPRezhP5HHhiolMiCjM=;
        b=r4wtRyauMFjsZCUeqxgzKdZJY7YTZCbnEDdQRTi43X8b5k+kqS6FxVARIquROQuTXR
         f0fOXyT9E+4rpGhCH9BFcJUAewv/wfcTYMKbzX3rfl3mZMU0gfEcAux1DGclZWUnaDg7
         0ifMaQ8YwffCGHJpnIeMZsS9YhHxKDaZrJq0O6fryjN/lpk1/kdfSFTn8KCucXN39gs8
         67ZFvCwowIkvS3wU44Ev8YibddbSK8aD5lBJ0LE6p1emM6iQIRlUmubhaQMCczei4A1/
         0BKlqIaAkbiUUBe3TMmk4bhs6MzKYNaE4cKs54NagdxRIr9Hyk4SGoBPR5ij3Y5IZllN
         9zqA==
X-Gm-Message-State: AOAM531UctvQrv3LOo/whMamWnqLKbhFGGqa71jzjOy8Jx7nzT0Xcqg8
        90FXymYPA/gcUAe6UMsG7n0uNnCmy2fvfm44f9zYog==
X-Google-Smtp-Source: ABdhPJzvw8ppRYYrix8vcKQPtLZcUG4WuboObsoLWJSvOV9abVZFP6b3AzXVf1ZbdG5asXureWAlsVrxm5slsUtmYWA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr21917427pfu.61.1635210578889; Mon, 25
 Oct 2021 18:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com> <CAJZ5v0h3vwrNQrs8F5KQcFoNy+KyAfg6k99cwTO19g-ra7kzFQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h3vwrNQrs8F5KQcFoNy+KyAfg6k99cwTO19g-ra7kzFQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Oct 2021 18:09:28 -0700
Message-ID: <CAPcyv4jymqC5GG36YAZmoB-xm-cPdTsHkpnzGvM=mzJDYi7oHg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 20, 2021 at 8:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 19, 2021 at 7:01 AM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> >
> > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > Create a NUMA node for each CFMWS that is not already assigned to
> > a NUMA node. Add a memblk attaching its host physical address
> > range to the node.
> >
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> >
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>
> Dan, this seems to fall into your territory.

Rafael,

Sure, I'm happy to take this through the CXL tree with your ack.
