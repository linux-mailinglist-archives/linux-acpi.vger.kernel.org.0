Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C262D1C6CFA
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 11:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEFJcV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 05:32:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45669 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgEFJcV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2020 05:32:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id k133so942340oih.12;
        Wed, 06 May 2020 02:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0cp8+eLp6spEAhT31IJ6eCca6B3J7assOLUD7HR8XU=;
        b=ASaBVk67DvMTi2+DmnWBpZupZskxPEGDCsHZYCYYmD+Ug5FqK18H9TzP9m+pGJRA7d
         MHEr8L1ozcFxT51jDNFVdZE6tovC8GjlgTBPB2sEg5Eo8lNewp90uJcE+7qHjd0BCi31
         as/AtJ9i/oJWTZzaYqGapDGOmy/V/qNQaG0ugi2Oymm9hs+/hq2GXpaS0dAbHUXq2GJ9
         j/pMGZggpgt4EhjoiAF5Lz5MOr/VbNXECkGrOxZG/b1mGv1hpAP8bNBqvuYlv/vuXVyl
         fTcKwbiPEEPrlfq3JZL6La8o9QRhnve7QEWoTxxsmonqX/jWU7Risw4TxO3JNW20k6Li
         WsUA==
X-Gm-Message-State: AGi0PuZgEqEJ/Bie5m196SSfVKa51m8TSiM4xie/LM0/yPyjra0APyFg
        derZSwJbnc8lgUi0utPkoFgZf0OV81BU2eLeyRo=
X-Google-Smtp-Source: APiQypIvjg0Am7EUmhUrz0AaZ4tmVQl5/G+7G+iuFYkVzyTGE/IxGboIafUsn2RcIUL5am2aQRDYAEyt18kcX1ivlhU=
X-Received: by 2002:aca:c441:: with SMTP id u62mr2161265oif.110.1588757539104;
 Wed, 06 May 2020 02:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
In-Reply-To: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 May 2020 11:32:07 +0200
Message-ID: <CAJZ5v0gZH61ui04Howzif-_Xc3-X9GyAx7FgZ=ZS2X=4KotEng@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     Chris Chiu <chiu@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        seth.forshee@canonical.com, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 4, 2020 at 7:09 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> Hi,
>     I have an Intel X5-Z8350 laptop which used to work fine on s2idle
> enter/exit with kernel 5.3. After upgrading to kernel 5.4 and later,
> the system can still exit s2idle by power button. However, if I try to
> wake it up from a keystroke, the system will freeze and then no longer
> respond even to the power button. I can only shut it down and power on
> again.
>
>     I tried to 'git bisect' to find out which commit causes the
> difference, it shows me the commit "ACPI: PM: s2idle: Prevent spurious
> SCIs from waking up the system". My laptop can work as usual to exit
> s2idle by a keystroke with reverting it on kernel 5.4.
>
>     Then I tried to check whether I can reproduce it on the latest
> mainline kernel, the same problem still there. But I can not fix it by
> simply reverting. I found the acpi_s2idle_wake() has been refined on
> the latest mainline kernel, and I have to make modifications as
> follows to make my laptop work.

Thanks for the report, the issue evidently is EC-related.

> @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
>                  * regarded as a spurious one.
>                  */
>                 if (!acpi_ec_dispatch_gpe())
> -                       return false;
> +                       return true;

Have you tried commenting out simply removing the if () check and the
following return statement?

If not, can you please try this and see what happens?

>
>                 /*
>                  * Cancel the wakeup and process all pending events in case
>
