Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA86A342548
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 19:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCSSvT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 14:51:19 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46713 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSSvM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 14:51:12 -0400
Received: by mail-ot1-f47.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso9468789ott.13;
        Fri, 19 Mar 2021 11:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29ZEanNYNzIk58a8Y3Rva+TVwajoUYncNK5jliynVQM=;
        b=XY+pCl9ta03hk0d+mx8f1e7SOpSJdXVvb6l6+zAvQ9SXH3efZvBovxNebSx68Bg4fM
         ASynPrxRckQsGLaM89csWor+tYVaEXmdXiVTuZtp6frCv3K0rlyslaw0jBOMz8T+rjUb
         kWKQXPh0lwijUDDX8axFj9ffWoxRv2yrUqf+hrUEtTZJBtuU9qPjMcw5BPJtcjRvsne7
         c2BfooQOgGbwwPsgxqQx4RqdIXsfL62MMnFvE8I8OYXYyEkm0YFUBWr6oD+mE6lC4Ccy
         qTKTSwso0eyAqwyD/OY5bET8zrCGg/9wmEcEJ6oRhzwnJepizfYehiZ17IrGFoC1TWk1
         iI6w==
X-Gm-Message-State: AOAM532xMQxLXd9ILGCP6x4nctQyw6xN3LqXkyvwryd5syBDH77Le8bV
        n12umDAkEh7r48WAF8Hou21sbY/Ob7Oj9R7ovcQ=
X-Google-Smtp-Source: ABdhPJz6cZGHWn7lejUkF5f78hrcjvURmosbcxZ2eeIEDki84Urf4wI1sn5ogAhmO1vtEP+hgkvT0td5PAS/r8lgrIw=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr2244474otr.321.1616179872125;
 Fri, 19 Mar 2021 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210319183234.23629-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210319183234.23629-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 19:51:00 +0100
Message-ID: <CAJZ5v0jihmos4gza_+0MzGsUfxJJ-5LGBOURVebdGsE_RuPhFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: scan: Use unique number for instance_no
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 19, 2021 at 7:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Current mechanism of incrementing and decrementing plain integer
> to get a next free instance_no when creating an ACPI device is buggy.
>
> The simple integer and operations line increment and decrement
> on top of it can't cover the possible gaps during run time. The
> arbitrary instantiation and elimination of the devices is racy

But it isn't racy AFAICS.  It always happens under acpi_device_lock().

> and after a couple of iterations with unequal amount of devices
> being added and removed we may reproduce a bug:
