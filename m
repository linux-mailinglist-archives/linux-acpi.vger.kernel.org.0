Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719451B929C
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Apr 2020 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDZR70 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Apr 2020 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDZR70 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Apr 2020 13:59:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065DDC061A0F;
        Sun, 26 Apr 2020 10:59:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so5740691pjb.5;
        Sun, 26 Apr 2020 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Agzoq47FRAesCK4Rm+PNfIIc52RShRiY7S7ixZtkBsE=;
        b=D+54ufDnGv47BkQQ1bzXZXAplN0jl0a3HMKhmlSujd7BkzQWTv5MMNZlpNKH5Hv4F+
         wG/kVHv9W+g1B6TvQzGrkIlhClxOByklmfjWQ0/J6mJT5wT50LEh2ZQ3hXFv+YTI6MVc
         f4oAaISJDUsSolgLd1j+RbMVDRNYJXkm50WZfSbv6UPXE8IUpt540cU7QbHrqLozQmU+
         86f2CZgDfqUkV89/nbYTWPbcV3upvhpsgISN0XVjhoqckLP54Fym7B1wQnM/7mIyY6sj
         XIbNDj77Y6+smfwlOQfesNAd/pX1COmmJ73moCuKB0o4d+zx00dCI5C6qPGQudHjhT+q
         4pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Agzoq47FRAesCK4Rm+PNfIIc52RShRiY7S7ixZtkBsE=;
        b=Z7208m2c0gwCMhZtz7/VrGrAfqgyMy3SOjBmTY7cKa4uisxFdVovPBrZg0BLx0Wvsv
         4LR4zbpK+Ls6xvvDayO86oeSSfAfFd6y73RkYK8bTwLAyrnJzAqmp/cg6UuA3Uc/LOQV
         ULweUBhya+Q82IDa72FB7tdY2eaiXcXWasBARY/cmU0QH32blksgwurRzAtjjHC7cK8L
         AsknCRA4Z4BPKMuzON9poEpQ9rYgiCW5NM4Lj76/GJ0Ds8LjTr2W2dn0U2GUS5XlYEZn
         xgBhn71CmuvaoTP3/DQos9pEROo4FjN3uPIu5vNgEkPck8a8bO82GPWZ6GJTKasmW+TA
         bb6A==
X-Gm-Message-State: AGi0PualRn+eiIPXjt5Hdy+LuhfIq8DbB4akvmfWbb/mNpjjpArRDZKw
        gXcgcIWfEavVty7HYRzNyt7Exd1KlYY+pq3rvAk=
X-Google-Smtp-Source: APiQypKr7+xGIaQ9h2OCGldijVYo+DjRbDucxSshbdQ6ouY4jUw/nEapxN+Daolzha+UYcKkTAyTQFf+OG03z6wcCHY=
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr19557530pje.1.1587923965301;
 Sun, 26 Apr 2020 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104713.216896-1-hdegoede@redhat.com> <20200426104713.216896-2-hdegoede@redhat.com>
In-Reply-To: <20200426104713.216896-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Apr 2020 20:59:14 +0300
Message-ID: <CAHp75VdOd6C36oR7HAnqrKiinVBr4YcqqJ=dv3NpR3=Xp0QQ-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: i2c-multi-instantiate: Add flag for
 passing fwnode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Apr 26, 2020 at 1:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> In some cases the driver for the i2c_client-s which i2c-multi-instantiate
> instantiates may need access some fields / methods from to the ACPI fwnode
> for which i2c_clients are being instantiated.
>
> An example of this are CPLM3218 ACPI device-s. These contain CPM0 and
> CPM1 packages with various information (e.g. register init values) which
> the driver needs.
>
> Passing the fwnode through the i2c_board_info struct also gives the
> i2c-core access to it, and if we do not pass an IRQ then the i2c-core
> will use the fwnode to get an IRQ, see i2c_acpi_get_irq().

I'm wondering, can we rather do it in the same way like we do for
GPIO/APIC case here.
Introduce IRQ_RESOURCE_SHARED (or so) and

case _SHARED:
 irq = i2c_acpi_get_irq();
...

?

>
> This is a problem when there is only an IRQ for 1 of the clients described
> in the ACPI device we are instantiating clients for. If we unconditionally
> pass the fwnode, then i2c_acpi_get_irq() will assign the same IRQ to all
> clients instantiated, leading to kernel-oopses like this (BSG1160 device):
>
> [   27.340557] genirq: Flags mismatch irq 76. 00002001 (bmc150_magn_event) vs. 00000001 (bmc150_accel_event)
> [   27.340567] Call Trace:
> ...
>
> So we cannot simply always pass the fwnode. This commit adds a PASS_FWNODE
> flag, which can be used to pass the fwnode in cases where we do not have
> the IRQ problem and the driver for the instantiated client(s) needs access
> to the fwnode.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/i2c-multi-instantiate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 6acc8457866e..dcafb1a29d17 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -20,6 +20,8 @@
>  #define IRQ_RESOURCE_GPIO      1
>  #define IRQ_RESOURCE_APIC      2
>
> +#define PASS_FWNODE            BIT(2)
> +
>  struct i2c_inst_data {
>         const char *type;
>         unsigned int flags;
> @@ -93,6 +95,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
>                 snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
>                          inst_data[i].type, i);
>                 board_info.dev_name = name;
> +
> +               if (inst_data[i].flags & PASS_FWNODE)
> +                       board_info.fwnode = dev->fwnode;
> +
>                 switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
>                 case IRQ_RESOURCE_GPIO:
>                         ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
