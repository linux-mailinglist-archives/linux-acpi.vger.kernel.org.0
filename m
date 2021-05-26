Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E118E391271
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhEZIhC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 04:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhEZIhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 04:37:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF8C061574;
        Wed, 26 May 2021 01:35:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m124so323570pgm.13;
        Wed, 26 May 2021 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ovUdr/UfZiAvf5V9cZ5izxdltN0dsbmxECPugreCcc=;
        b=PlV4lm9zksTMWU2VF5e2dObRzVzujrnJeTPmvV2yo/TmK8mhjalW4d8kThw2M+DgbL
         dLpujD7+2LpXhQP3oN1fDf+j7dakOa3jEMenKqxZNxTACz4B98oOR++aCmUwm8yHwhn1
         6NJTqXGLglJ3z9dyhRGnvLQORBldoNwN9U9eIOLCGmbstObrgLIrODe9DOPazCt6Cc08
         4IWru3TxFkQt3aVbqfV3uX6zVCLycJ4UpdKBAvTD1VhJnq1B6pudwW3lwM4NN+RJUS90
         iZeXv9N0B5rdJhARItnBiVcaukutRa8w2KqT6zPsDTgbrp7iiAim0MMMOpUWgfrVNGxO
         kV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ovUdr/UfZiAvf5V9cZ5izxdltN0dsbmxECPugreCcc=;
        b=hsi4VSa0/eQBQfOgy3mLgSkCx+JdjuC98b7QzYYUPGdabQW2nbbR/RWaoMnMc6TLc/
         7h/CVS2Vj9rwNhoULKTsEPScAWY1xBcatg7UvZxcaUBwAv8PC+0GU5yEJ0Nlx0FASgVa
         4lq82E+m/U5P0TwkTIbhwn4jQfc8qxalW+NPsgf9yvNmq0xsWYBAQvQE8VkcVWqkHP0R
         dmCftAajB/ftzVO10rSrAPdy4qoTT30GO/Kj0AfnL6fi9J2duEYSN0Ti03i+bp2dAcGU
         AG65xh2TLIlotZHS2c/MLOED/9slmnRT+atgIYUegsztFH6i6pLRASdem9dwbL69xbX8
         sDMA==
X-Gm-Message-State: AOAM530HsDBfWfDW6NMyNeLxMAZq1wSWB047No2wFU8vp6k4ohxWgq3A
        +qi0PbvV+ZFdhlU0BAX40VxmjiqQCD04HzR/KxM=
X-Google-Smtp-Source: ABdhPJykHhYQRw2KLnTaZd2rOvYqPSCPl/TfNeQJ6g8tjppPtu4A7EllMGHNwfM2YQFThKaa1GniRjEN2zy5ZGeU7sk=
X-Received: by 2002:a63:b507:: with SMTP id y7mr16323273pge.74.1622018129671;
 Wed, 26 May 2021 01:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210519210253.3578025-1-andy.shevchenko@gmail.com>
 <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
 <CAJZ5v0hsDpGtLHPQvcnof3c1LBnhoZSwWyHJdj1mOov9gV_W8A@mail.gmail.com> <50903d09-96f8-0dc9-a1f7-21bf1543b15a@gmail.com>
In-Reply-To: <50903d09-96f8-0dc9-a1f7-21bf1543b15a@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 May 2021 11:35:13 +0300
Message-ID: <CAHp75VeON6netzJAw0YR=wQBBabvQNpqSpY8MwDSxsTabpMZow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in for_each_acpi_dev_match()
To:     Daniel Scally <djrscally@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 26, 2021 at 1:29 AM Daniel Scally <djrscally@gmail.com> wrote:
> On 20/05/2021 20:40, Rafael J. Wysocki wrote:
> > On Thu, May 20, 2021 at 9:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:
> >>> Currently it's possible to iterate over the dangling pointer in case the device
> >>> suddenly disappears. This may happen becase callers put it at the end of a loop.
> >>>
> >>> Instead, let's move that call inside acpi_dev_get_next_match_dev().
> >> Not really.
> > OK, I see what you want to achieve and the macro is actually buggy,
> > because it leaves unbalanced references behind.
>
>
> Yeah; I guess the originally intended use (which was "get all these
> devices") doesn't really tally with the naming or with the operation of
> similar functions in the kernel like the fwnode_handle ops; sorry about
> that. Anyway; I think Andy's fix is the right way to do it, so the
> calling code's responsible for holding onto a reference if it wants to
> keep it.

I think we need to postpone the fix till v5.14-rc1 is out. It appears
that some code has been changed in EFI and media subsystems so that
patch will be in conflict with.


-- 
With Best Regards,
Andy Shevchenko
