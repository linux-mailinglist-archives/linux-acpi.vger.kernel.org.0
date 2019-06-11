Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223CC3D5B2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFKSoe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 14:44:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40808 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfFKSoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2019 14:44:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so7447148pgm.7;
        Tue, 11 Jun 2019 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjXOm39CWa6S4I71CKU5r+mT9fayfeuZ4n9Ko6h04/Q=;
        b=myaTjclOScSIDrJvBHbz7GqxDxIFK7e7DAfxQEM9oALn9rsTlpKt80fwIgm0KtX6V1
         rjsp2quD64X+j4e2krEEBu98c5MfZng1DbASdGyGwJG5NVw2h8ncvSeeiM2/is5mt8Tj
         Hl7PulNEfKL1iTcOm+BmiLv6YbI73mFN+CKOysg5B0Qajeo+mJ+3lkv/hTsDiLqP1K2X
         E0uc27fMFfCG5CTgpAOnmzWitO8GemDOyDhaTdzt2sylNoufOgyKKIZsO/0WcWMJBXRF
         bOI29cs4Pv20llVSyHkYaKW+KY4DlzmN8lJPePgHDnkkKHK19ZK8RN8IcjgGd4Bksfk0
         p/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjXOm39CWa6S4I71CKU5r+mT9fayfeuZ4n9Ko6h04/Q=;
        b=DGtfviaZwKHP/jH89Tru0Wsj4ev1KGVjO9XIsD4JvvwONe0/RFvN5kggNUnMZI3XNq
         4Y1WDVMZT4yVRug5cYkrBiSxNaGloG2KF9YUjH/oWXIQjuYOFyAx3voCbz66FP2l2ztU
         YK+pjqflDr55jhycvvnKkjK9wbC4j+MWVL9RfXSy0UoF7MU1EGZbt/D6YNtSx67pD86N
         LvtuEaYlnb2SDFjiZ0V7l3gxl5y5Iv49E9BxRyyycA0hBeFOJVF6fL+XYS1zfjmnw45V
         yK0uFYq4enVWefRdbPxpk0cO3tls1YhP4jvuJlxkxqwvTWqhEn3G7eKmuu/kmXZ0F7ch
         /R9A==
X-Gm-Message-State: APjAAAVGuf24ZkeAGJpgq4kGQcBC/vu7HLlnD/bwafbaofG2VEFI6nNO
        JD1IvZb32aLCEw/IjleITS/bZLlpTvb/yzjvrg8=
X-Google-Smtp-Source: APXvYqzkqeep3CqfOFDZoSRrKfSGRdBDWFEoMwtK6OFag6Wk/WDtXaVNa/EripQyuLMKoe63k5dbDPKFUOkVassx774=
X-Received: by 2002:a63:d84a:: with SMTP id k10mr6952505pgj.74.1560278673900;
 Tue, 11 Jun 2019 11:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <c15a9872-4ad4-1b7e-e34f-14549b5b55eb@metux.net>
In-Reply-To: <c15a9872-4ad4-1b7e-e34f-14549b5b55eb@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jun 2019 21:44:23 +0300
Message-ID: <CAHp75Vc_FnSaqq_Xu_Y3uXBYY=HbGsthVOAqyt4c-dH7sRGVVw@mail.gmail.com>
Subject: Re: How to inject fwnode/oftree/acpi data by platform driver ?
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: Heikki.
Heikki, can you help here with swnodes?

On Sat, Jun 1, 2019 at 5:17 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> Hi folks,
>
>
> I'm looking for a way to inject fwnode data from a platform driver,
> in order to initialize generic drivers w/ board specific configuration.
> The idea is getting rid of passing driver specific pdata structs
> (which, IIRC, seem to be deprecated).
>
> An example usecase is the APUv2/3 board, which have things like gpios
> wired to buttons and LEDs. The board can only be detected via DMI
> string, no way to probe the platform devices - have to be initialized
> explicitly (that's how I'm already doing it now).
>
> The nicest way, IMHO, would be if I could just write some piece of DTS
> and some fancy magic all the rest under the hood. Such thing doesn't
> seem to exist yet. Does it make sense to implement that ? How could
> we do it ?
>
> Which other options do we have ?
>
> Or should we just leave everything as it is and stick w/ pdata structs ?
>
>
> thx
> --mtx
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287



-- 
With Best Regards,
Andy Shevchenko
