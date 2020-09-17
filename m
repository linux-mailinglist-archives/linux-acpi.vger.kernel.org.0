Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C42826DF3E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIQPL6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 11:11:58 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:38894 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgIQPI5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2020 11:08:57 -0400
Received: by mail-oo1-f66.google.com with SMTP id r10so633437oor.5
        for <linux-acpi@vger.kernel.org>; Thu, 17 Sep 2020 08:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSsby7PK5iOChQOZVQAWZvV/HAyQi7aW/kE1FMkwCrU=;
        b=J54f8/+nZhs0cor6p+KechywCRQWTbuJec2odZuUcenPkwZT83KvE0WorA0WY8vgBo
         tZAchR1s9Ojn1cm+b3hmBi31crk0ZNQyEBcIyNY23dM702Lmhf20AbT+VbqmfRr56YGk
         3Qrp8MyUes7JL6gRO24w6XsFBvD9IU5QM4cK1Vxr5+v48S+tH6APRoHe01VBFunGphjD
         /iM2k1USNYyyxdwTjsASpXFDkMGi0tzCtPVyZthB0gDt+WrHdVN7p0F3A7HaJw4jE+HB
         78YymZr1vs1dX1dHxze9PILMCbfnvJYn9AR0VEiSia0XZ8Doj4RMeih8INm0JsTb4Vu0
         YA6Q==
X-Gm-Message-State: AOAM531wZW5En40Xxdl90/gZhbIYByoLHGTzw/9Mk38b3ZLck0vNjnDr
        q7zMU79jIfP4Tdeur/22VTn/2ICTMg2Fq11W3RTID85p
X-Google-Smtp-Source: ABdhPJyBbwEubdEokLO7Ki9FthRsxQdjgu4EWUT45KkBuWRLoeNiDhKghT/OKv1FTWWw+hh92Je5Bu2eSHS274jAvzQ=
X-Received: by 2002:a4a:dd0b:: with SMTP id m11mr21216467oou.75.1600355332175;
 Thu, 17 Sep 2020 08:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Sep 2020 17:08:41 +0200
Message-ID: <CAJZ5v0hukTBCyNO0Tj=FyOzh4uM=f8bLTToOT4zG3Tn_1KjO0g@mail.gmail.com>
Subject: Re: [PATCH 00/25] ACPI: First step to decouple ACPICA debug
 functionality from ACPI driver
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hanjun,

On Thu, Sep 17, 2020 at 10:34 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> For now, ACPI driver debug functionality is mixed of pr_* functions and
> ACPI_DEBUG_PRINT() which is provided ACPICA core directly, ACPICA debug
> functions are not friendly for users and also make ACPICA core deeply
> coupled with ACPI drivers.
>
> With the evolution of the ACPI driver code, lots of the ACPICA debug
> functions used in ACPI drivers were removed away, this makes the ACPICA
> debug in ACPI driver to be fragile, for example, some of the COMPONENT
> such as ACPI_CONTAINER_COMPONENT and ACPI_MEMORY_DEVICE_COMPONENT are not
> used anymore, they leaved as dead code.
>
> From another aspert, removing the ACPICA debug functions didn't raise
> concerns in the past, so I believe the ACPICA debug in ACPI driver can be
> removed and replace with equivalent pr_* debug functions, then decouple
> ACPICA debug functionality from ACPI driver.

This is a worthy goal, but the patch series appears to be a mixed bag
of changes some of which are not directly related to this goal.

> In order to decouple ACPICA debug functionality from ACPI driver, I do it
> in two steps:
>  - Remove the dead ACPICA functionality code, and remove the not used
>    COMPONENT;
>  - Remove all the ACPICA debug code from ACPI drivers.
>
> This patch set is the first step to decouple ACPICA debug functionality
> from ACPI driver, just remove the dead ACPICA functionality code and
> some cleanups for ACPI drivers, should no functional change if you don't
> apply the last two patches.
>
> Patch 1/25 ~ patch 23/25 are removing the dead code and cleanups;
> Patch 24/25 ~ patch 25/25 are the actual ABI change.
>
> If the ABI change is making sense, I will go further to remove the
> ACPICA debug functionality from ACPI driver, just keep it inside
> the ACPICA core.
>
> Hanjun Guo (25):
>   ACPI: cmos_rtc: Remove the ACPI_MODULE_NAME()

This, for example, should be a separate cleanup patch.

>   ACPI: configfs: Decouple with ACPICA
>   ACPI: configfs: Add the missing config_item_put()

This appears to be a fix that should go in separate from the rest of the series.

>   ACPI: debug: Remove the not used function

Another separate cleanup.

>   ACPI: LPSS: Remove the ACPI_MODULE_NAME()

Yet another one.

So can you please split up the patch set into several smaller and more
manageable ones?

Thanks!
