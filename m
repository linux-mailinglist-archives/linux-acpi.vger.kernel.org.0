Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE42DC5FF
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgLPSOk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 13:14:40 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44798 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgLPSOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2020 13:14:39 -0500
Received: by mail-ot1-f45.google.com with SMTP id f16so23874299otl.11;
        Wed, 16 Dec 2020 10:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NqLp0xMJUXp8l692c4bVNhRCbaY/x/DqAWSQcYHaN0=;
        b=KTGzlT4QUrbkJ5TudOAkMhCL6xqdhXhdf5Jsly2P0Lf0MTOGrwLlZJZXZn7O08pGT8
         YSTrmGPowT311oTVg9nA6OQ6LQRDaFnHBgVu7x9GAcI8yvH23PBJH4ZIoxa2wSZN9/l5
         DTWOANSEhCvleKSeAsOuQQrMPwe5UPwMCLLmTkbDMah89MFa6nX4ZbsoTmkileNfcHlf
         sMOelUUt9SKD43RhxVQVo9d+FW53rpLHRPg/Cr3kEqickmllAfqfWGk7VGN7hjSsKcPD
         U9alYMX92tpZ7EJJoqFCCUus4lqAcWr07k3vjByK8fFvvrmJ/uOzdXQg9gzfTic3Lng+
         weFg==
X-Gm-Message-State: AOAM531pNbBOCeQOTHDo9eqdShtKRFjMlH+KdrymNhfnwybwjQ69Ycdv
        8Oke31ycoPCcSjhkotkr1SBcA1KkSlGT6WcjmRg=
X-Google-Smtp-Source: ABdhPJyHykrQ8TnhAPmDsGcpolzw06DzSj/2yyrmUwYINiO9/ojdtg1aIBcVwV198dVMz/HubANxR21K3QmKjksh9+U=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr27686809otk.206.1608142438759;
 Wed, 16 Dec 2020 10:13:58 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
 <20201211020630.305905-2-markpearson@lenovo.com>
In-Reply-To: <20201211020630.305905-2-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Dec 2020 19:13:47 +0100
Message-ID: <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ACPI: platform-profile: Add platform profile support
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>, njosh1@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
>
> This is the initial implementation of the platform-profile feature.
> It provides the details discussed and outlined in the
> sysfs-platform_profile document.
>
> Many modern systems have the ability to modify the operating profile to
> control aspects like fan speed, temperature and power levels. This
> module provides a common sysfs interface that platform modules can register
> against to control their individual profile options.
>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>

[cut]

> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> new file mode 100644
> index 000000000000..9a1e2abd7602
> --- /dev/null
> +++ b/include/linux/platform_profile.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Platform profile sysfs interface
> + *
> + * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
> + * information.
> + */
> +
> +#ifndef _PLATFORM_PROFILE_H_
> +#define _PLATFORM_PROFILE_H_
> +
> +#include <linux/bitops.h>
> +
> +/*
> + * If more options are added please update profile_names
> + * array in platform-profile.c and sysfs-platform-profile.rst
> + * documentation.
> + */
> +
> +enum platform_profile_option {
> +       PLATFORM_PROFILE_LOW,
> +       PLATFORM_PROFILE_COOL,
> +       PLATFORM_PROFILE_QUIET,
> +       PLATFORM_PROFILE_BALANCED,
> +       PLATFORM_PROFILE_PERFORM,
> +       PLATFORM_PROFILE_LAST, /*must always be last */
> +};
> +
> +struct platform_profile_handler {
> +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       int (*profile_get)(enum platform_profile_option *profile);

I'm not sure why this callback is necessary and, provided that there
is a good enough reason, why it cannot return an enum
platform_profile_option value.

In principle, if ->profile_set() returns 0, the requested profile can
be saved in a static var and then returned by subsequent "read"
operations.

> +       int (*profile_set)(enum platform_profile_option profile);
> +};
> +
> +int platform_profile_register(const struct platform_profile_handler *pprof);
> +int platform_profile_remove(void);
> +void platform_profile_notify(void);
> +
> +#endif  /*_PLATFORM_PROFILE_H_*/
> --
