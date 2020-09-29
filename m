Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1FB27D309
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgI2PsA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2PsA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2020 11:48:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6715C0613D2
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 08:47:59 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z25so5278518iol.10
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2020 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fRDsNgN2uFtN5BY9cG8Ru5uS2pUVkVtSMvZ/oFCZ9E=;
        b=x9Z/6sT5LSTuCUR7kzaaUJSzg1TkTbzFbyQjcLWsMkHkRvIWkdk9OBzY5wawZ4ObZK
         5GE+8/seStWi3GQ2XoIQUfLMGLL8Wb/RbRMbRK4xTROmLxOvecQyniFoGhAJYzvwIqS2
         YRUMVpr4p1k8mNLTNTjDhtOogQyGwk2nWCAZ5yZNokL61fZFQsqyGWMo9shE9JUWxTD/
         iZ1eLUkOgxOJ58kOii/fzArF7XwHyinUGcXwQW1/6Vwis9eah0+PoJPKzFU+jZHHg+El
         amYzX370qWMdZDMn+jMjH7gQsksOUGVTGdebAuAv2+gzvHh3MgN0bnYH2v2lEwJp6ezi
         uTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fRDsNgN2uFtN5BY9cG8Ru5uS2pUVkVtSMvZ/oFCZ9E=;
        b=Ogmz3TuG3fzkMyQkQ1MpEt7cLlBEbW9DVGla60lV8RDqGY7O0QmILVTh9SW+Qh7EL/
         66ek8FTJHLLVXOLc/TqqFLCCWLSKeDMHIrnPgJJPu17bjnfJbFGKh5DxDGBwaTvH5Rmm
         MTtVnmHRBEsW1B8UUp3tzZVnuBS6yGzUju9M4rqfpYnncLzbRaVTgzyarcPs5a3Jf9/s
         BvG9lSYfY1tA1t/PyFBFIPIzi9Pu3U77YG0C9nkHMJWmdO3RUkY3mdpX5st1Tt8iouXM
         iv7z6173ELVYhKJQO6O5QtPro+tFZ+3wE1s2dls3EOhvriIWrmd4Tvrn4+Ke+PHembvm
         G4Vw==
X-Gm-Message-State: AOAM532166YZua8Vq2uFeZ3+bfo5d2ETeo5t+VCeHGpGc+CNo7sFPUDK
        c2V6R8dlaOcdBoEz0pj8+WaNvkoU/jJmqp4dIwsQ9w==
X-Google-Smtp-Source: ABdhPJyQsuGvOKqXQmMRSBpnMXmXFrQ8GQAMhq92OErRmFnbHAaXulpCnWr7QcOrhhAKug9yo0lalEsORfrv1aGwo+Y=
X-Received: by 2002:a5d:8e14:: with SMTP id e20mr2924164iod.119.1601394479066;
 Tue, 29 Sep 2020 08:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
In-Reply-To: <9152bb8be33e4192a7766eb53c6ca9af@asem.it>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Sep 2020 17:47:48 +0200
Message-ID: <CAMRc=McnsSkg-7UMp7pKaGX2wSqsZC2jQZV2zRepxm9UxGg=YA@mail.gmail.com>
Subject: Re: How to use an ACPI declared GPIO in a userspace ...
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 29, 2020 at 5:43 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> Hi all,
>
> I need to expose to the userspace a GPIO, physically connected to a board
> push-button. This GPIO must expose a pre-defined name, such as
> "user-push-button", so that the userspace applications can use it without
> know any physical GPIO details.
>
> I can customize the board BIOS and so my goal is to add an ACPI table with
> a content like this:
>
> ...
> Scope (\_SB.GPO1)
>         {
>                 Device (BTNS)
>                 {
>                         Name (_HID, "PRP0001")
>                         Name (_DDN, "GPIO buttons device")
>
>                         Name (_CRS, ResourceTemplate ()
>                         {
>                                 GpioIo (
>                                 Exclusive,               // Not shared
>                                 PullNone,                // No need for pulls
>                                 0,                       // Debounce timeout
>                                 0,                       // Drive strength
>                                 IoRestrictionInputOnly,  // Only used as input
>                                 "\\_SB.GPO1",            // GPIO controller
>                                 0, ResourceConsumer, , ) // Must be 0
>                                 {
>                                         25,              // GPIO number
>                                 }
> ...
>
> I know that this GPIO can be used from other drivers.
> For example I successfully tested it using the "gpio-keys" device driver,
> giving to my GPIO a key-code and emulating in this way a keyboard key.
> This could be a possible solution.
>
> But I prefer to expose my GPIO as a classic GPIO, not as a keyboard key.
>
> I was wondering if there is a generic GPIO driver that I can use to expose
> this GPIO with its pre-defined name (caming from the ACPI table declaration),
> to the userspace...
>
> Best regards,
>
> Flavio

Adding Andy who knows ACPI GPIO well.

In general, the "gpio-line-names" property is used for that and it's
supported both for device tree as well as ACPI, although I have only
ever used the former.

Bartosz
