Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45C61C555C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEEM1W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEEM1W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 08:27:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FCCC061A0F;
        Tue,  5 May 2020 05:27:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q24so277208pjd.1;
        Tue, 05 May 2020 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhsumHv3M7JlyLmYk4HXYpW3mzApZUYeYN5b+cm9jrs=;
        b=pwOUsrY8gz0ywfHf6VXimW+wl6/f5kfbIggBi3iaOwy69TaD/6g0D4WqjCdpGtM3JI
         5wbFxX7oYXaQj3KvhEsOZr3VJRj2/+qaL/ZFnB6O0bVHSgEO31QLQfZZNlXuH97ZLbed
         097d1KasOHWPyDUAgANEn2neSWJ/oNBJ3y1OCesTC95riQ90QMdK1iXR92nWsqVWI0Z7
         A8ecvSHBwEAkZQNv7J5QnEz8Namsfvwuww4L/Vb7e5F2ZRIXwxI+3ge94FJhzi1Guy0F
         oFf/v2CwgrJ5Eiys/yUueGVlAFd/PZdjhmrAaN+1GDqGmljIDQCR0yudyQS8/bfCE5lv
         87+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhsumHv3M7JlyLmYk4HXYpW3mzApZUYeYN5b+cm9jrs=;
        b=p4EBm71/Iat1hJHhFJNPAmX79JJsfAFskPvVpG2h71Iw8QGOau8TaXuFYHR/QiAWe2
         aWbfktyZzRqQlRod+OZ7yV2+DneWuFzlNlz5MAqavBQm8XqYVTjkWLEt15t3q8T3C4Lx
         9FRLfOb+3FSudCPlKDXHzjZmXkefoJLcvZMlhKczTfu7fWrA8cJ7x699xU7aAlHSSVR6
         1TKzkvID36dZSVq946WB/y+iitPebUnF/03eGFiiycaYd8hzr13GzHEcj6rAx/FWJePs
         ML/RonwC9XWtYH5Sfv7rrtGs0VkzgYOPtUnRAesVqyz/ud4i5jjYPgg198AUUzY58wgc
         tqUg==
X-Gm-Message-State: AGi0PuZB3q+W99g0r8033+X8GGbJwMoOizs21+dk61km29u8J0IiCDex
        5vu0xXQ1m/kga7M7ViVmUzqXKapb4LABbjnG/1o=
X-Google-Smtp-Source: APiQypKgSD6aM5OF9+bSd/EeD+2ArzvXBfNLbBzitRMtEfAqCQnufK6Z5xzei9jbOQmDD1xLFqDqB/+ca6UDmzj6rJo=
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr2865043pjb.22.1588681641529;
 Tue, 05 May 2020 05:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505111810.65586-1-malattia@linux.it> <20200505111810.65586-2-malattia@linux.it>
In-Reply-To: <20200505111810.65586-2-malattia@linux.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 15:27:15 +0300
Message-ID: <CAHp75Ve--kecWYufUiXUxUZM=tL3NgKtDNf6Ny4ds8GJVz_0pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] [sony-laptop] SNC calls should handle BUFFER types
To:     Mattia Dongili <malattia@linux.it>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.co>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dominik Mierzejewski <dominik@greysector.net>,
        William Bader <williambader@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc ACPI(CA) people

On Tue, May 5, 2020 at 1:16 PM <malattia@linux.it> wrote:
> After commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
> objects for ASL create_field() operator") ACPICA creates buffers even
> when new fields are small enough to fit into an integer.

> Many SNC calls counted on the old behaviour.

Rafael, Erik, is it correct behaviour from ACPICA p.o.v. nowadays or
should be fixed rather there?

-- 
With Best Regards,
Andy Shevchenko
