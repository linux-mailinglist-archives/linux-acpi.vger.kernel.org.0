Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4A5461183
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 10:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbhK2KBw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Nov 2021 05:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhK2J7u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Nov 2021 04:59:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA750C0619D6
        for <linux-acpi@vger.kernel.org>; Mon, 29 Nov 2021 01:37:52 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r11so69100046edd.9
        for <linux-acpi@vger.kernel.org>; Mon, 29 Nov 2021 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIbuiFCf4pgXIUFiVnfwxg6T7jIyJv5R4Wd/Ti2UWjY=;
        b=oquaP1Rprb+TsVLDkMWBmypatowFDPSGpzSLpa46Dh3YoTi7JZSwQP2O3MI/rGq/OS
         esYnDevEYM0hmNxmjfBbXlg+vfdtKfcMLlHadAnbrh2k9SwWhiISjpIR6yov3qBjBs9t
         HTn8OBSgSlzZYIvWDWozLid7ZnsFc2eP8IQR3NNWJy0CW5yF5sAuvPJc6mj7tXFl1Z6J
         Wr+tJ73uP5zRym2BBY33wDGkiCB5ALHQA0+n9t2woxHBzgIf4l2WWmnAmlf+Tq+6hfbP
         RSFjtXbetQxWajK8EmTnS0YJKSGWdhbRbVKR7TyguVEK95mbD+idqpVPaeb9HzFfB4AC
         5ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIbuiFCf4pgXIUFiVnfwxg6T7jIyJv5R4Wd/Ti2UWjY=;
        b=7ayVmSwmeycBx6Ku6HmpYGrOn/Yg69Vh/u40FqDqUInwmLprmnikjCpUC0Gdor5SYe
         81BIJs5ec1/MliHzvLSfTE6qR+zH6c7754UquM4ETaR2oGUqRJEnznSUql+mPT3YxgeR
         n+KaGP+zBSvj4ELT4DDk0IYZgh/HQxsPx3lJXOrO7TJJfsknfQCfyShshPcjdb3MkFPE
         XqF9UERvwUc7P+RI1vcgPXDjKlyyEOgJ8gzS1f5b2X3enuPpUKs8nBgXKnADlVb34B3x
         f9Kms2ymixP/HSTeRzfMEmAhHtPLhMKBaDB/7dmmmixX4bpUZ9Q4pZGjixlfUon1isnj
         z4bA==
X-Gm-Message-State: AOAM5308jks8p6Fa+j2o72U0qynu/jg/cyrkiYtNDDD0Jr65ChANAXv+
        E3aEyf3Vime7arcuPxxLxsYD5O29ZzBsDvYaKiQ=
X-Google-Smtp-Source: ABdhPJwJ8kmcN1ZtOCAfbULAA3kDmGU6eiMGaFQOGc92qSw+dJzf1KJQgexl+eLjs5T1maq8agLYPeF3qGI6FDqVAQY=
X-Received: by 2002:a05:6402:4394:: with SMTP id o20mr72010060edc.342.1638178671551;
 Mon, 29 Nov 2021 01:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20211126152109.230986-1-hdegoede@redhat.com> <20211126152109.230986-2-hdegoede@redhat.com>
 <YaEBcuFw+W8LNtMW@smile.fi.intel.com> <761aa221-690d-73fe-d58d-d769b83cff89@redhat.com>
In-Reply-To: <761aa221-690d-73fe-d58d-d769b83cff89@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Nov 2021 11:37:15 +0200
Message-ID: <CAHp75VcZaXuTCME+ronNjGUJVNfp45ZywNdgeJv5R-XBwF8G6w@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: PMIC: allow drivers to provide a custom
 lpat_raw_to_temp() function
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 27, 2021 at 11:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/26/21 16:46, Andy Shevchenko wrote:
> > On Fri, Nov 26, 2021 at 04:21:08PM +0100, Hans de Goede wrote:

...

> >> +    int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_table,
> >> +                            int raw);
> >
> > Can be on one line.
>
> I tried to stay within (or at least close too) 80 lines here as that is
> still the recommended limit. The new 100 is more of a checkpatch only
> change, not a change in the codingstyle docs.

Yes I know that and IIRC in ACPI we have a bit relaxed rules (WRT line
length) even before checkpatch has relaxed them. But as you pointed
out below it's not worth of resending since it can be amended when
applying.

> With that said I'm fine with changing this. Rafael, feel free to
> change this while merging. Or let me know if you want a v2.

-- 
With Best Regards,
Andy Shevchenko
