Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979BF121BCC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 22:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLPVfr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 16:35:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46351 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfLPVfq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 16:35:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id a124so4491632oii.13;
        Mon, 16 Dec 2019 13:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJ2usFWIeCmkzmTC7qcf2zGiRqXsS5ix2vXMB0EkNbI=;
        b=KyxZePEZ3YNKJXcVKlyZlVzzbTLYeNjCNtwazWD9XU6GxZwyS6zEXU9qDAidHsUClO
         fZoXkOrdKzRm5B7vnHgC08d3RsMbT//W1k32OP4m6uLoJ4dRNbjeRr5h9ErcKpe7jMRZ
         yYtklx9Vc8T51qnsL8Mt3FU7I2bzOGlHiR89i3S9PFzjTyWnZJRh2RSufSvJBVOI8wHQ
         XxKKg8KoeLkMcvtJ/b/IfBa5yMOiJ0HUTry9lu2P8XX8hE973JkgcRX5cc3YIBRjdhe9
         SZ72QCmoOE0wbu0QB+yqeevDB9ybeihVkErjsN0zQ1WTtHpjaEKiYV87ZAa3sGpAkeDW
         JP/w==
X-Gm-Message-State: APjAAAV/sXZU2MaveHIs/Z3n2DjWrWpUHExSXX/aZ1Kc1zrECMrOlgTh
        s7TBaiE82djpNoqFFWcstBl1G0zJuM2kqx3GYCE=
X-Google-Smtp-Source: APXvYqzeC3z/0g7tRLvdvvwAJCteCRLAbygW1va+REys9e3fUJcMxQkdZnEB0iQtUlOzmkKHEvgmtrZmAiwIi1djeJc=
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr729850oij.110.1576532145696;
 Mon, 16 Dec 2019 13:35:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576520244.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1576520244.git.gayatri.kammela@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Dec 2019 22:35:34 +0100
Message-ID: <CAJZ5v0g2UHJcnczekgegX6_7kzHrmXNS_e3KRCC2d4LQ1+RceA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] drivers: Add Tiger Lake hardware IDs to support ACPI,
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 16, 2019 at 7:33 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Hi,
>
> Tiger Lake supports devices whose hardware IDs are changed for various
> drivers. Hence, add the new hardware IDs.
>
> Patch 1: Add Tiger Lake support to DPTF driver
> Patch 2: Add Tiger Lake support to fan driver
> Patch 3: Add Tiger Lake support to device_pm
> Patch 4: Add Tiger Lake support to Intel's HID driver
> Patch 5: Add Tiger Lake support to thermal driver

I'm going to apply the whole series (for 5.6) if nobody has any issues
with that.

Thanks!
