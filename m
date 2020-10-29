Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01729F3EE
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 19:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2SOv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2SOu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 14:14:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD9C0613CF;
        Thu, 29 Oct 2020 11:14:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so1684143pll.8;
        Thu, 29 Oct 2020 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANCKdgekhIPAJOL8kzjr3o6uzoOb1aXwKr4bEAlxk60=;
        b=BvzbnQPTHAsx1r6hFlBLJdnypyWfHQuZ0wy6IPljOefZg+JenOd1YwvV0h6gy7P6XN
         wb0jvJH77SIhf9hyteBYlsRVRy0Suo8hsEbRukvOJoq6AtlFYwn0NrI1euLdkKM8NL8C
         gsQo5Yqzy+hhQhlgNQcriEtHbwGtH0aFE2/JF4hCWwcYom3rs1EkVV8EbL739tqVapP+
         +zc7tDF6kRWbj9yvsbWRNGjLYAGqLqGVe8WMROOqEG+Nup8ItmfpduN8/TDm/7CQx3/z
         ZoS+Q3bZ6mC9z/pbQdr7D8P5sxUaLPnzr4axLvATM2ZuBzx4mbwqqwF1vZTuQ0e8mQnQ
         8cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANCKdgekhIPAJOL8kzjr3o6uzoOb1aXwKr4bEAlxk60=;
        b=kUdFaxjGhrxXr+kY4fJ6GjttitNPUHQnOL76lan9NXNe1RMK7Ls3N90kcZC183FL3D
         tZfin+y2AVRG0L44MJO7XCP2kstKk7+KJVid7Kf6ae7IfCXzMG8CcKIhucK6mwRt/8fT
         wFysDBLVBrCUVaIS3PNPdQktF96BE4OZeZ2/oT1PmbWhHziW/t038PmpTsJur7eqKYaz
         SwOIyYIRQ/X+i6ZrC39ojnXjdE7WdPW9lSVoUjiO8nhksGRDVJ1ADl1K3ttNmu0plf9z
         6OVrAouiyTF6cM6G8ZVQuyK0Hoc+2CbOm3JOAHxJn7kDXnZs2DmWEr5fIK50YffeFYYZ
         UJZA==
X-Gm-Message-State: AOAM531GdmRQxz/haeBTJeglhePlaX+0T/0nteq9jRTn6JgzmlBRMz43
        AP2xRDkkSOj7vVJiqW0bsEiL1/6+9zxZHts1anQ=
X-Google-Smtp-Source: ABdhPJwg0ga2rNMg8a+xHiMph4SxKef/CBp4rV7HNLt58LKTFO3nvO4iDv3KhJc3pYyYxhh8RuoMF2kY9/URgKzG5h4=
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id
 d10-20020a170902aa8ab02900d3c9dd77d1mr5253126plr.0.1603995290269; Thu, 29 Oct
 2020 11:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201028171757.765866-1-ribalda@chromium.org> <20201028182744.GZ4077@smile.fi.intel.com>
 <CANiDSCvy2dPyY8O5DVgTBwNNLmfA=kJ5HUKJqcFLnqQ8CWsJgA@mail.gmail.com>
 <CAHp75Vc6LhqKvuAeOkVtTAniHGRMGV=7Pa71CNT7por=PRk9eQ@mail.gmail.com> <CANiDSCsrtL1h+z_f7jQicgwz5nTc33wJGGCjZyeF9aGQJwED7A@mail.gmail.com>
In-Reply-To: <CANiDSCsrtL1h+z_f7jQicgwz5nTc33wJGGCjZyeF9aGQJwED7A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 20:14:33 +0200
Message-ID: <CAHp75Vd7D7gArrgAWJ-e=u-KeGiQ5Ouj94YGfRmLPb62JOF-2w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Support GpioInt with active_low polarity
To:     Ricardo Ribalda <ribalda@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 8:09 PM Ricardo Ribalda <ribalda@google.com> wrote:
> Adding Tomasz in CC in case he wants to share more info about the device.

OK, but let's discuss in another thread.

-- 
With Best Regards,
Andy Shevchenko
