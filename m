Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830313132E1
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Feb 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBHNB4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 08:01:56 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42374 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBHNBz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 08:01:55 -0500
Received: by mail-oi1-f171.google.com with SMTP id u66so13549062oig.9;
        Mon, 08 Feb 2021 05:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvxc4VC9l/IR/i8ANGFEq/fIycfe1+oz586mHeCkXyY=;
        b=GhYCTtdPmhAoGTTOBo0Z2xZtdq5R8H5pJQBiymDyXiflnQRFS9vxLex/F4gW8ZxIg9
         zUUP9T09a027FqHwA1jW80EYbVSBpTrrjRUo8CLkgYQWQU4C8w7hAgYDLTgfjUfcVNs/
         uQel0f2ifre/shv1rm6TfYMxakanbjCjfw9CItz+4Bne4L8Y3/ovTaNhK5zt9cT3A7Or
         vmYSps1FAgXIKs0SFsW5OT8j31PoYezeMLQdgvGSDm3UrW48qe9XbufBe6/pawLzWVsg
         tfiY13QjvW+Zqy5/B5RlGXmxSlOiH1W/o1BmH+fjNjSOMKfJ8YmMoBAncWFDQDIEjqH4
         vCZw==
X-Gm-Message-State: AOAM533pXtSg5GP1yR5T3KG5NSMCAlKmDYAycB5EoWpyh96vVVN+2WMD
        Q3nXCfA6YXS7siMIIqz4e3qTB5emmcLC2HITLzMOIyKy
X-Google-Smtp-Source: ABdhPJwcBBneby+U8ATEJaNGJS/dzjUdsjmsd0GNONhJ+maNLDnptpwdadyvK1u/ZgGgN2gMddShxT5nyiPV0jERB0o=
X-Received: by 2002:a54:400b:: with SMTP id x11mr4489172oie.71.1612789274272;
 Mon, 08 Feb 2021 05:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20210206084937.20853-1-ardb@kernel.org> <20210206104854.GC27503@dragon>
In-Reply-To: <20210206104854.GC27503@dragon>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Feb 2021 14:00:58 +0100
Message-ID: <CAJZ5v0hMJnaHhUYib9d3yQ1CMHLE+Hu3UM4VoN=dOiyriTPmOw@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPICA: Interpreter: fix memory leak by using
 existing buffer"
To:     Shawn Guo <shawn.guo@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 6, 2021 at 11:49 AM Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Sat, Feb 06, 2021 at 09:49:37AM +0100, Ard Biesheuvel wrote:
> > This reverts commit 32cf1a12cad43358e47dac8014379c2f33dfbed4.
> >
> > The 'exisitng buffer' in this case is the firmware provided table, and
> > we should not modify that in place. This fixes a crash on arm64 with
> > initrd table overrides, in which case the DSDT is not mapped with
> > read/write permissions.
> >
> > Cc: Robert Moore <robert.moore@intel.com>
> > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Reported-by: Shawn Guo <shawn.guo@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks!

Erik, the upstream will need to sync up with this revert.
