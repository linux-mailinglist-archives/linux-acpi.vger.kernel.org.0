Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41D45AABD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbhKWSGl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:06:41 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44931 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWSGl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Nov 2021 13:06:41 -0500
Received: by mail-oi1-f180.google.com with SMTP id be32so46097132oib.11;
        Tue, 23 Nov 2021 10:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eTpqnVuWiy6J9/pK85SFmtlKrVau8JlSwHmWLQrrZc=;
        b=oTEIqUvSlG+yyHgkcnfzvSUpTDeGHF1xiMlGUyKcUfDpMtbrCTcyi5qHlCO4618ity
         F2ITTcostvmd1CbAIRuw06w4dgZN++pIkvhIeHv4IWgkwBOxFbVknTBCfGvhpGY/IKww
         4r68gnRvP14c4EgNWCnZkB1YTTb4Cd40tp9Vzh5rrQiCOF+pRK76I9V+a9KoutNopr8C
         Fk8GNuNcbt/zLj+ZX/MOZJsyzePpshOHDEQ0YJpQpNkEzz/dCVqrHFt0pldpDlugi8ot
         bm7E4Og8gMkKXtjvwcQ4yBI7Mtv2197v9pg+Ssa6cqB9ZPzmlj7xjBPkHWRF1pZaDbzN
         OWDQ==
X-Gm-Message-State: AOAM531z/06QXTbDWjuMhlsqxfZYWlJl5mCkmTv0B8KgjfZ2tUUOf7/f
        yiroesAnHtFZxuqakIlEuLq9DUx/rAwvOfIalWk=
X-Google-Smtp-Source: ABdhPJw3CPdiusK2j7KExKEEOfGfmKQp+tyKGKo2YlgWNtr7tduXngTF0kV4LWdRMiGXU6lIL7vAAyhpi+UipVAcmyY=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr4287594oil.166.1637690612921;
 Tue, 23 Nov 2021 10:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20211110111640.62807-1-andriy.shevchenko@linux.intel.com> <YZ0XXoH05cUQ+UMj@smile.fi.intel.com>
In-Reply-To: <YZ0XXoH05cUQ+UMj@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Nov 2021 19:03:21 +0100
Message-ID: <CAJZ5v0iz-rRV8dktYCe5L-u_zG3vp5S2ZuF=gjrsfgLgcQSnow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: Replace kernel.h with the necessary inclusions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 23, 2021 at 5:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 10, 2021 at 01:16:40PM +0200, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> >
> > Replace kernel.h inclusion with the list of what is really being used.
>
> Anybody any comments on this? I really want to shrink kernel.h usage in
> headers rather sooner than later...

Patch applied as 5.17 material, thanks!
