Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FBB268479
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgINGKD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Sep 2020 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgINGJ7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2020 02:09:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D910C06174A;
        Sun, 13 Sep 2020 23:09:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j34so10672426pgi.7;
        Sun, 13 Sep 2020 23:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vc2Xuz/xnpKNW4iK8EMpd8c+mevxs6dRK7EymBsDeg=;
        b=ACRDT6zkaFoSMO+7GjohbJlTcQ1IxOfJSEHKxDHFONmN3FE6LMSJFYjh5xkCQ4EoE/
         QYddZZaTM3V8hDYv51qMRuVePoMUSsGK7Ec9ezrYT8iPALuuruAXhP02HHZt0O/erQgn
         J58vj5hGrCImYjI/uwGAM0E2eHoW7Cak06t16Wu5XHSnLzcolGC2BA8kZVb0+hs0QHTA
         A3MeuZ6EvU7BitGh1Nj7K2QVpbMYYENpRqvTeSS27jXgZnDzlfbP6eG5heRoDzoOHBiV
         EPH2EUMAg303iJqrEyxjNGtjWtJqj3nZ8aguutVOCKzs0bp7Vyd4e+prQ1jixT0T2YNt
         u6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vc2Xuz/xnpKNW4iK8EMpd8c+mevxs6dRK7EymBsDeg=;
        b=qeTcdard0A3AH6mqbgs3yULZsoHsxBBdBaduMR6njwZVHLRrZ1QH9ltJGaJe0JgyTU
         N1ZAP/Etzd8rolIFqvcderGBTGSL4McGLp65HlN/cxS/gymA3yZDcdeJ3c37sRTHnseE
         dBRCXDgmJjh6jllT2i92sVzq1p8UhvqXR2K11qG/DuCDqrR1OJbIb7jphIc25Lr8F3Jy
         9CMq91xqJABzTFSNhJeS5URwqy3SYe7kQGOm+Hci7JdF2GsyO5F5akhDgY/0RFXAK1Jz
         BOF5Nlp5Rbhkvlnm0Ww1oR4TGndeNyUJCyzmIX/Us6IDjgAFFhOC34VAD/5aYhRFtL1c
         3fzw==
X-Gm-Message-State: AOAM53146esXFY9F5oU7/6CtGK60XnWLTQhldzGl1lNMV5+GLUWyUwtf
        6ZPcN9O4Snle/ZZiXlCdlus=
X-Google-Smtp-Source: ABdhPJyrUB638HtfVTguOqRhU3+BefLJgUk2JM8FRPUZCu5TjMIA6jdeg8fkio5DCvdWxxnZXWAlMg==
X-Received: by 2002:a63:5420:: with SMTP id i32mr10044004pgb.149.1600063799017;
        Sun, 13 Sep 2020 23:09:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id e17sm8677219pff.6.2020.09.13.23.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 23:09:58 -0700 (PDT)
Date:   Sun, 13 Sep 2020 23:09:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Input: soc_button_array - Work around DSDTs which modify
 the irqflags
Message-ID: <20200914060956.GN1665100@dtor-ws>
References: <20200906122016.4628-1-hdegoede@redhat.com>
 <20200906122016.4628-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906122016.4628-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 06, 2020 at 02:20:16PM +0200, Hans de Goede wrote:
> Some 2-in-1s which use the soc_button_array driver have this ugly issue in
> their DSDT where the _LID method modifies the irq-type settings of the
> GPIOs used for the power and home buttons. The intend of this AML code is
> to disable these buttons when the lid is closed.
> 
> The AML does this by directly poking the GPIO controllers registers. This
> is problematic because when re-enabling the irq, which happens whenever
> _LID gets called with the lid open (e.g. on boot and on resume), it sets
> the irq-type to IRQ_TYPE_LEVEL_LOW. Where as the gpio-keys driver programs
> the type to, and expects it to be, IRQ_TYPE_EDGE_BOTH.
> 
> This commit adds a workaround for this which (on affected devices) does
> not set gpio_keys_button.gpio on these 2-in-1s, instead it gets the irq for
> the GPIO, configures it as IRQ_TYPE_LEVEL_LOW (to match how the _LID AML
> code configures it) and passes the irq in gpio_keys_button.irq.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

-- 
Dmitry
