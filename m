Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8317A2AF436
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Nov 2020 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgKKO5F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Nov 2020 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKKO5E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2020 09:57:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C90EC0613D1;
        Wed, 11 Nov 2020 06:57:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so1093184plo.4;
        Wed, 11 Nov 2020 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyApQ3Qe0ikm4e96wlEFsdUKuOOWp3HZjy/jI5jhpdQ=;
        b=TC05TcfmI0zGf3u+l4x7bhmD2pAZ5ansAdrIpTH+gvMFEveSyZ/zWF4nAxcxhujaod
         6aSitX5yQNexfhAl/d+iJkL6MseppAI75My+pbUN75qKjq5iYArRb0fpHNRkEHWwybIz
         /VNZtCDsDGsXyb0Zd84xQ7IujxOWh3nHStw0HW89ARgw6qzO1BjtZVXwBwhpdMO3A1K5
         Q8N7zJwUEEAcULlHUsgMODJKBnDx4+jBnbhrV/toKPa0B8obDwMf3qSJCyA2PwdZMLBL
         kAQIQHyU1Eo/TGy0n0BV0iltvqCoO+C6vsK7ELKF4zQvrl0c8iDnGATssPGWzpVSIhVc
         MGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyApQ3Qe0ikm4e96wlEFsdUKuOOWp3HZjy/jI5jhpdQ=;
        b=bzBdSKfNOMWvaGYJrrqxRGCh6YYNnXJN28iFTpp2/bs3qXE0D9rBUuoqYtm6ATxtQ5
         egn3RnX5iZqwbu/882ZMHuJy7hEzLSRrw6fvV3jE/j1ev6ROMwMNPEpolUrgFWzeRMJq
         PKA7bPT2SHoKQ6ke2TfCajitL+D/3a08PV5OodtZbSL7jBQIdBO2BSmysKmkp527EQZ3
         sDtIVWWzWysKv3KsnLk5GtShTucUzvT3Eh7cW+6cuNRnQDrHE4Jm1fLCvYECxjGkRCK3
         s6qSfWP6qdudSI+I5sDktcQ4B4MTlOiR/NEy/WJishLtTjr/hRT7kTiZSV1AnuFM3AHC
         5XxA==
X-Gm-Message-State: AOAM532aPb/YXoSUJ/5iS0qG7cJ2bbickviyVK2PIOvqM3WL520IzjGR
        npPLXfTjF0QUIg6f37VMBFlaPzLpHCesMYqNiP5oms96zv4=
X-Google-Smtp-Source: ABdhPJxYzvEL9bujfSelart5xnHseI7z2+ubQqYjhGqDNU8DhEDl09EpsXM6Df/4Eum3wxbzysunMace65GxTLvCiiI=
X-Received: by 2002:a17:902:6bc8:b029:d6:d9d:f28c with SMTP id
 m8-20020a1709026bc8b02900d60d9df28cmr5734362plt.17.1605106624126; Wed, 11 Nov
 2020 06:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20201111130435.432982-1-f.suligoi@asem.it> <CAHp75VeccWtKRQkQE0XyyDZVvkD3QrBig2yU6=pz3KEG-bCKjA@mail.gmail.com>
 <93941f3b0142473399bfdd18608a4056@asem.it>
In-Reply-To: <93941f3b0142473399bfdd18608a4056@asem.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 Nov 2020 16:57:53 +0200
Message-ID: <CAHp75Vdhd2Swu5qiYszgBG4pfB8LG=jxgi=YMHNviogWQR_oJw@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: ACPI: explain how to use gpio-line-names
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 11, 2020 at 4:53 PM Flavio Suligoi <f.suligoi@asem.it> wrote:

...

> > Since it's rest, I would expect gpio-line-names in above paragraphs to
> > be a term, something like
> > ``gpio-line-names`` (double back quotes on each side). Yes, I know
> > that there are other places which need to be amended, but I believe
> > it's out of scope of this patch.
>
> Ok, I'll use the backquotes for code samples, right!
> If you want, when this patch will be concluded, I can check all the ACPI
> documentation to put all code samples into backquotes.

I'm not sure I understand what you meant under 'code samples'. The
code excerpts like below are fine, what I'm talking about is the
reference to properties in the text.

...

> > ``""`` but better to check the resulting (rendered) file. You may use
> > rst2pdf script for that.
>
> OK for the``""``.
> I check the rendered HTML using the usual "make htmldocs". Is it enough?

Ideally it's not enough. html, pdf and man all should be checked.

-- 
With Best Regards,
Andy Shevchenko
