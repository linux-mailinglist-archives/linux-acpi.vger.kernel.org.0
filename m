Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030AE36DDF2
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Apr 2021 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhD1RNi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 13:13:38 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46913 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhD1RNi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Apr 2021 13:13:38 -0400
Received: by mail-ot1-f45.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso57124902otb.13;
        Wed, 28 Apr 2021 10:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwBsMZjQrdBeAvFqjLZ8N/H0W29YinbtR6he8HHKExo=;
        b=SxtikG5GkgB3NI0MKE28g6HnC9J2R4AxSAKbm9qJUu/uyQLyZMahoHDNCI+WMm9gDh
         mms5EM9cHmIJ7PpMJ6T3rsHIRPVRkO4rnWP3/rDPwn94QvWO+iKWg1lCgBBd1RNYCUwV
         m2FPm8roUuErHryZOzBvWdLWCtmOKJ++2NTfaWw+DytZf3OlcQOinWIqpTPogEjqL4fQ
         9tK46uQeJFmy55ulzdBA0TyBFAycWd+PTcUb9bgeC6RaXq51Ddsdv5vuWsFntMZEa31q
         8bHsMdNxzixoxFiTmdUtWef0OqiLHeDkBKEA3iL1lSz6WcvXZ5Tdm6nkgwJ4EGX4pj9w
         TVPg==
X-Gm-Message-State: AOAM532gSrWINiill8WjRDq4I855yqgg2Hbqhf/pF0owynmBsJCj9Qts
        RqL41xZaxuDnwGewW7+ltjnuJj/frrDlHYMhgaA=
X-Google-Smtp-Source: ABdhPJy0IkzcQIURbfJMwbrLJqU+1qmGGghbHLLtYLFgJRgdOP/zTnh50uNBLY+gYq3MfWfBnn+n7RvtAg3y6w5hDcQ=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr24636567otb.260.1619629972930;
 Wed, 28 Apr 2021 10:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210424143935.69487-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210424143935.69487-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Apr 2021 19:12:41 +0200
Message-ID: <CAJZ5v0jLZUn7V=7mHRR17=SuOwxP4LAH755gEhzSERNyNq3HNw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Documentation: firmware-guide: gpio-properties:
 Add note to SPI CS case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Apr 24, 2021 at 4:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Historically ACPI has no means of the GPIO polarity and thus
> the SPISerialBus() resource defines it on the per-chip basis.
> In order to avoid an ambiguity, the GPIO polarity is considered
> being always Active High.
>
> Add note about this to the respective documentation file.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/gpio-properties.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> index 4e264c16ddff..df4b711053ee 100644
> --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> @@ -99,6 +99,12 @@ native::
>        }
>    }
>
> +Note, that historically ACPI has no means of the GPIO polarity and thus
> +the SPISerialBus() resource defines it on the per-chip basis. In order
> +to avoid a chain of negations, the GPIO polarity is considered being
> +Active High. Even for the cases when _DSD() is involved (see the example
> +above) the GPIO CS polarity must be defined Active High to avoid ambiguity.
> +
>  Other supported properties
>  ==========================
>
> --

Applied as 5.13-rc material, thanks!
