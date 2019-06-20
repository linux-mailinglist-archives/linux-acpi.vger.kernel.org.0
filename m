Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14BE4CBF9
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFTKd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 06:33:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41998 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731597AbfFTKdy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 06:33:54 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so64139ior.9
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lW99f343SGZPmLCebh5+lrrtY/mJe5T9CoLTr8Fktzw=;
        b=awCvmBgNg2/+XSfFuq4YFcRinuXzjZdxM2KK5wycgv0CG04Qfdr0ez6CQItfYsk/jd
         95wPU3PwozrjpCUZa4nz/y3fbmJXx8JuFgIe4TOZFlK67eR+AnPAk/tuZQEXedZiUTF5
         Ap9AJiFRI0a4vrsSdMZg58eySh48vf4dFYZkqILut+uvcXoQE+TQWocs0lQTxSqS65DE
         bCCGM8v5MBzgiKsBuEeRqY1LOGGwln3fETDsygVa+4A4px3JUGDkktQ4yqHhW09S9Si+
         8oVlqBU+B8jQlu8tZnIqR4KnepnsOZhm/K/mmIRZS2UWKPeF7TsAnsY3onyWTK6T6aNa
         KRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lW99f343SGZPmLCebh5+lrrtY/mJe5T9CoLTr8Fktzw=;
        b=gZAy/CaYnxIp9E3VAHJNY2N/r5OFXmtt7EtlFnEfFQvymiIJGf6/+lqbc0RTvlpeUc
         a0Q4peFnIorRBK/CRkqii+kbJoiYS91kJPCtM/mESPfO9ojbrIAs70JPNl9rfyMJmbBM
         leAHPodJCGZFvaMyPRzhVoZaMFDEpxy+XtVSqGgGyVtjlcKIc37aShOZcCxl5w08g5eK
         bjzqJHeNY6RfvlSBqLy2NqSB1sFrwv3j93aoUUpVdXV5/LBTs/FFw4Zt7MiNMo9/5cLj
         noeQfCPipNjeLAmXcRzofBnPp/LSSRUe8qqKKOj9gLW8ubAV/G/Cokm3v4RDFWbbtZUU
         FwKw==
X-Gm-Message-State: APjAAAXv9Ok29er6/HZyeGVMDYkrnzN0BLVaQk73P7SdELfKILXD0XVf
        dzgXi3dwdOTGHPcQh+SD2iUvodAOFhk+VLT2MVhnXQC8JTg=
X-Google-Smtp-Source: APXvYqyVVP9a6aurBYxq8PBvKFiNBU3ZfNoZJwjf4Lf2wNCmjX/jczz1frHaVzF/IyNGUjvN2UhVMebFwPFTzwQ08UQ=
X-Received: by 2002:a5d:9d97:: with SMTP id 23mr17931198ion.204.1561026833764;
 Thu, 20 Jun 2019 03:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com> <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com> <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com> <20190619144255.GG2640@lahna.fi.intel.com>
In-Reply-To: <20190619144255.GG2640@lahna.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Jun 2019 12:33:41 +0200
Message-ID: <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com>
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Jun 2019 at 16:43, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Jun 19, 2019 at 05:17:59PM +0300, Jarkko Nikula wrote:
> > Hi
> >
> > On 6/19/19 4:58 PM, Ard Biesheuvel wrote:
> > > So can you explain how exactly the I2C GPIO expander is failing? I
> > > struggle to understand how the SPI slave probing could be related to
> > > that.
> > >
> > They don't show up in /sys/kernel/debug/gpio, are not present in
> > /sys/bus/i2c/devices/ but SPI core instead tries add them with a bogus Chip
> > Select number:
> >
> > [    5.727699][    T1] pxa2xx-spi pxa2xx-spi.5: cs56 >= max 4
> > [    5.733545][    T1] spi_master spi5: failed to add SPI device INT3491:00
> > from ACPI
>
> Just a guess but looking at the 4c3c59544f33 acpi_register_spi_device()
> does not seem to zero fill the whole struct acpi_spi_lookup structure so
> when it is supposed to bail out when SPI slave was not found:
>
>         if (!lookup.max_speed_hz)
>                 return AE_OK
>
> it instead continues to register SPI slave because lookup.max_speed_hz
> may contain whatever garbage there is in the stack at that address.

Good point.

Jarkko, does this help?

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50d230b33c42..d072efdd65ba 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1914,6 +1914,7 @@ static acpi_status
acpi_register_spi_device(struct spi_controller *ctlr,
                return AE_OK;

        lookup.ctlr             = ctlr;
+       lookup.max_speed_hz     = 0;
        lookup.mode             = 0;
        lookup.bits_per_word    = 0;
        lookup.irq              = -1;
