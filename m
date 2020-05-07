Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA31C808E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 05:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgEGDiZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGDiY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2020 23:38:24 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B28C061A0F
        for <linux-acpi@vger.kernel.org>; Wed,  6 May 2020 20:38:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c124so3706474oib.13
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2020 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0cQq4xYVzYPxzyVLbBLMpWehBwGYgPxNzAF85GiSfE=;
        b=XeHQ3OiHkwJ8xT3Ya6XM1SJOsqPv23Pjveh468DQabZ5fp+bykhAi+ZmC9PoKgG9CR
         Yl+3Xi4b7WQmgDPI9noIy777DxVwgGgP0oSxGHoi0woUcd8iXj2H5VI81C6dabWmD0P/
         h+RagNwXqFR8VAmWPzqHmvaxrlpfClz72fKiuqpA0dtAiodikqRvbvzpKL94i/ZK9Hwu
         nqvWexmvmy1bw8u7K7urw4H1igbO1rcqoPDZIBRJywqRqsj1ClwMPhjHcAUnNrhkTYTv
         QCiwQQOzslL7v0wqJpLIihMWVNlKRrjyZMG6ASI8Cpd9AxqdHIQloHNHkXww8JL0OUeL
         uBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0cQq4xYVzYPxzyVLbBLMpWehBwGYgPxNzAF85GiSfE=;
        b=A11uyRaduNRIo1sNRviF3P0XKaBEHW9T6s5BR5pmkdxslzQdaFMo5a9n/lMI1EAerl
         BVY0ziFoKUg/7mvvN7iWN6d9xvsV7eV9X+vqMayKXijGijCxX/wnOZ6MDsz/5HKtn1eN
         w3QTwMHYJL+tgGW5FtbG/o3KjYgFJKiw2gilUfAd1oNNIF0kNEDgC6nZEjJFZxPc04L3
         n0UtDmcD9qFWO0Qlycb8vcbBOSXYKHwUWnU+8mtUelOu8mxxIWe3iTYz1hHQ8m0J/4kI
         dUQrCg/GiTixAHTp7C3LEZrTWTBY2cM+qcpOjOLxPotzJUnDi3zLiMAg2zaHhCxkhloN
         lgMw==
X-Gm-Message-State: AGi0PuaQivrA9VnCNeD/F7iHbVHFnHa20k5+8B7EYZfpQxSp9KTjoRV+
        Td8O0b1EcThSL8tO6awt/sIcozHHgtikvM2WQHQ4H9/kdHXZJGY8
X-Google-Smtp-Source: APiQypKeoTq4Fn0g+OFMHCi+moiq/xR/F6cwta6TxxrGshqaggMLYBBmp/8fE4jGyVDn1L0+Qub8g2v2+ELApD1EDO0=
X-Received: by 2002:aca:447:: with SMTP id 68mr4938547oie.94.1588822702710;
 Wed, 06 May 2020 20:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <CAJZ5v0gZH61ui04Howzif-_Xc3-X9GyAx7FgZ=ZS2X=4KotEng@mail.gmail.com> <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 7 May 2020 11:38:11 +0800
Message-ID: <CAB4CAweZcN0SPe-a7jbthV=-ip9cCzJOM=NfP9YvtXw97ugKgQ@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 6, 2020 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >
> > Thanks for the report, the issue evidently is EC-related.
> >
> > > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > >                  * regarded as a spurious one.
> > >                  */
> > >                 if (!acpi_ec_dispatch_gpe())
> > > -                       return false;
> > > +                       return true;
> >
> > Have you tried commenting out simply removing the if () check and the
> > following return statement?
>
> Scratch that.
>
> Instead, please try doing
>
> acpi_ec_dispatch_gpe()
>
> instead of the if () and the following return statement.

Yes. I verified with the modification you suggested on my laptop. It's
working OK.
I can wake from a keystroke w/o problem.

@ -1024,8 +1024,7 @@ static bool acpi_s2idle_wake(void)
                 * If the EC GPE status bit has not been set, the wakeup is
                 * regarded as a spurious one.
                 */
-               if (!acpi_ec_dispatch_gpe())
-                       return false;
+               acpi_ec_dispatch_gpe();

                /*
                 * Cancel the wakeup and process all pending events in case
