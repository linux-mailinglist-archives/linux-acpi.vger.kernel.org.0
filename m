Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFAE47BF
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394413AbfJYJtM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:49:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46636 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394386AbfJYJtM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 05:49:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id c2so1159205oic.13;
        Fri, 25 Oct 2019 02:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnftwLozQ7rbTOcyHRhf8Njft/n9Yteu28kTUhPkPck=;
        b=sMK/DgJ16pGy1zZvZAwbe+USaBfd2gyWan9Tc9XKAATm2Xot//LCxSgx3389E8hz9I
         yA2rGK/XcuDT/u5XuOEaLFGwtB+FAP0QDUPweHC9T2k92HX72NMQU/74yGqIdgYnARZs
         zGvpf1qHxzJkhcgQsGTcSFRDJTJE1cT0P72e8EHRY3AkN2BYuGo8a44D/jGMT9iggl9V
         zM/I32u3eXCvNXej37S17DLAF2zz2/uVW+Sc1PHvE2+s5pf+JDFGY6fKC3ousB9Y95UM
         IPpIYZQhDus4sIMl8LVWgpmhSkNQ8dB4yHwMOJvBEwo39rW9m/Q6anBTfIP8N827TZVF
         7foQ==
X-Gm-Message-State: APjAAAUmypJRJ1P1NmGCVT+IFcpTMVggQHWb1r5vhAxxtPph2HxnCCu2
        62Ax17+n/8psxbwZo+Smm7KRtKkYzsm5GN/v3r4=
X-Google-Smtp-Source: APXvYqxSSvFmyDxcN0e+znakroRvM3i+swTFDtDyU0f82Zxu85rJEw56I5A/1ACOgXmpSLO2V/HdE/N9+nboQfyyS8Q=
X-Received: by 2002:aca:d706:: with SMTP id o6mr2288535oig.57.1571996951367;
 Fri, 25 Oct 2019 02:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191024213827.144974-1-hdegoede@redhat.com> <20191024213827.144974-3-hdegoede@redhat.com>
 <20191025074154.GX32742@smile.fi.intel.com> <49aa39b7-d457-1140-afdb-2a154278b29f@redhat.com>
 <20191025093325.GK32742@smile.fi.intel.com>
In-Reply-To: <20191025093325.GK32742@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Oct 2019 11:49:00 +0200
Message-ID: <CAJZ5v0iRpfNZqL9cfOn6ANjGxrSoe+pV8JapoH-GHOtKCnxaWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC
 OpRegion driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 11:33 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Oct 25, 2019 at 10:59:06AM +0200, Hans de Goede wrote:
> > On 25-10-2019 09:41, Andy Shevchenko wrote:
> > > On Thu, Oct 24, 2019 at 11:38:25PM +0200, Hans de Goede wrote:
>
> > > I would go with previously established pattern, i.e. intel_pmic_bytcc.c.
>
> > Well that would be consistent with the chtwc for the Whiskey Cove, but
> > Crystal Cove related files are shortened to crc in many places already:
> >
> > Filenames before this patch:
> > drivers/acpi/pmic/intel_pmic_crc.c
> > drivers/pwm/pwm-crc.c
> > drivers/mfd/intel_soc_pmic_crc.c
> >
> > And to me "cc" stands for the Type-C cc lines, or for Cc: from email,
> > so IMHO it is best to stick with crc here.
>
> Okay, let's do an exception here due to the fact the code and name already
> exists and spreads enough thru sources.
>
> It means you may use mine tags.

OK, applying the series as 5.5 material, thanks!
