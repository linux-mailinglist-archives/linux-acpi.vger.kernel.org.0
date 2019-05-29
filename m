Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3042D684
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfE2Hi4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 03:38:56 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:33615 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfE2Hi4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 May 2019 03:38:56 -0400
Received: by mail-it1-f195.google.com with SMTP id j17so4769708itk.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 May 2019 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYdxpoQyKFeDaQbdKIUrN5/Ag9haNiYupFVN0i2N9tI=;
        b=uHyaDhs+yuzAFqEYJAVKpxTifDtlQH1n+iiledygxDhAWUxN21+5LPjKLrF81HPxVo
         D2QplBvvzVVRjujCa1RP5wHv/+uAKXtTZ5OmkmzBcQtszNJdcxWqQmE5/dYAcRwOdGLa
         hk5uHYPHHFLmOcp2LQswEdJjF8bX4JE9p9d1fUtTXKT8+Mg+pzbxoBErHaDy4o3HvSHh
         lSwfGtAYobCEWGbtdyBYRaVaDyvFvGBw0MTy6b5KGP2Ztaho5GjxZmaAPHE2kv6hev4I
         SKVF9ybnj72MgdsN95OdzbVAdNC+hLmQ09GmAQy6XfGi+0fo5Scs3hLEws+LDqMcDULk
         IQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYdxpoQyKFeDaQbdKIUrN5/Ag9haNiYupFVN0i2N9tI=;
        b=iDMA7uCvlxWgqH2i2jVmdeny2EIh897zMe6UxRyKOMe7GVmwVHlnVWK2dB+8uqFac0
         eUQi4hGuVJ2YJd5oiG7T/czgGU55Fp3XMLKZUh/RJutjzgodRjlGIEq4Sq3Dl9Xx2Qgw
         6MI0zujQb76qz83RdQUQborLV0lfyC9A3KvIs7ox521p8vG/Nhgre7PiT/RTxckkGLTi
         epxCU6Y2/YJP003XCB/WQsGq1cXjr8QYp+KNGZ1EL8ewJmt8hnhuXvmmQ5xqz2pXYodJ
         OXFZMUgaNLW1do3MWXx/V+mdQ4IIYfYuQdbk+yYiRr/4pEOsk5r8AT/NRY1f5ArPgtpD
         l+eQ==
X-Gm-Message-State: APjAAAUbt6lWVggo0pI1dPNqIA2yAQ+a9RY58U93qwlx4ohSNPxEBFMN
        ZaoFPb4H8+tZ6ef0R7iqApGTkYWb5CYpygTgAe4kEX9HMKI=
X-Google-Smtp-Source: APXvYqwJaWt8FOT5iYYwEp1+i82EfIFqj3p//Hr4qZtGOCamTO84O9sAgIaSczF1o/Ft+u1WfFjVLNDcfZybQ0ZTrP0=
X-Received: by 2002:a24:910b:: with SMTP id i11mr6751918ite.76.1559115535209;
 Wed, 29 May 2019 00:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190528133647.3362-1-ard.biesheuvel@linaro.org>
 <20190528133647.3362-5-ard.biesheuvel@linaro.org> <20190529073129.GP2781@lahna.fi.intel.com>
In-Reply-To: <20190529073129.GP2781@lahna.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 29 May 2019 09:38:42 +0200
Message-ID: <CAKv+Gu_BJO9AYDicyd4hC7uSWP47ac12wPzi4kgCETwjGZQZOA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] gpio: mb86s7x: enable ACPI support
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 29 May 2019 at 09:31, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, May 28, 2019 at 03:36:47PM +0200, Ard Biesheuvel wrote:
> > Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
> > support for ACPI GPIO interrupts routed via platform interrupts, by
> > wiring the two together via the to_irq() gpiochip callback.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Hmm, I thought I reviewed this already? Well anyway,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Yes, you did. Apologies.

Marc, can you still incorporate this? Or is it too late?
