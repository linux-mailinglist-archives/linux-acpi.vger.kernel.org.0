Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD0C1C6E39
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEFKTw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 06:19:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41640 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgEFKTv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2020 06:19:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id c3so898102otp.8;
        Wed, 06 May 2020 03:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Jd+W5BzC4qZWaXd8mMr44l3QHyMyxsGcV2SIRL+Ey0=;
        b=HS9sQ6QNtzhxPTOrFzimcPyjkde76rY2YfbyWAlGvMUi1HWS5oZvBrQb2VYI4h5PCj
         j6VssnVkjz+74it0D3U55CKKbURgqvTOqMs8Yoq4Y/l6aOUXaPNzUmVVfHcKTwyfZCi3
         P8lxVP7uCbEQ9ys60Q9EjzBdtffF7hhVDJnKq6YZLj6gp5Sj3njn48u7DC6gVjWV8bTw
         YEblCZRRz0CZLUgBF7vmmKQcIRFFxs1p85eMe2xtndbSuUSNLgNVsmdpPT4qm+WXTeIx
         GY81QoCFkUUYy9Di/pirenieV3FgoLZrGU6/Chycf+2Tw5LlhSt+HXmhGJCNZ3WtylXa
         97Cg==
X-Gm-Message-State: AGi0PuaxlAPxGqcMBLuXHydbUeLtLbshKZsqKBaxsf5Uf6nXcHngoVJM
        hYYkCX3+TG/aUReHqPq2HqDXx2aY4/md6tR43c3Apg==
X-Google-Smtp-Source: APiQypKOnnHoizZAjjH6JFCByCWVpWyQaiM0FY3kCcfXlB2TaOUlENM09pbUovXDWS0vH+3OFGg7USg9KBXKGjKs9nU=
X-Received: by 2002:a9d:112:: with SMTP id 18mr5482997otu.167.1588760390910;
 Wed, 06 May 2020 03:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <CAJZ5v0gZH61ui04Howzif-_Xc3-X9GyAx7FgZ=ZS2X=4KotEng@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZH61ui04Howzif-_Xc3-X9GyAx7FgZ=ZS2X=4KotEng@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 May 2020 12:19:39 +0200
Message-ID: <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
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

On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 4, 2020 at 7:09 PM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > Hi,
> >     I have an Intel X5-Z8350 laptop which used to work fine on s2idle
> > enter/exit with kernel 5.3. After upgrading to kernel 5.4 and later,
> > the system can still exit s2idle by power button. However, if I try to
> > wake it up from a keystroke, the system will freeze and then no longer
> > respond even to the power button. I can only shut it down and power on
> > again.
> >
> >     I tried to 'git bisect' to find out which commit causes the
> > difference, it shows me the commit "ACPI: PM: s2idle: Prevent spurious
> > SCIs from waking up the system". My laptop can work as usual to exit
> > s2idle by a keystroke with reverting it on kernel 5.4.
> >
> >     Then I tried to check whether I can reproduce it on the latest
> > mainline kernel, the same problem still there. But I can not fix it by
> > simply reverting. I found the acpi_s2idle_wake() has been refined on
> > the latest mainline kernel, and I have to make modifications as
> > follows to make my laptop work.
>
> Thanks for the report, the issue evidently is EC-related.
>
> > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> >                  * regarded as a spurious one.
> >                  */
> >                 if (!acpi_ec_dispatch_gpe())
> > -                       return false;
> > +                       return true;
>
> Have you tried commenting out simply removing the if () check and the
> following return statement?

Scratch that.

Instead, please try doing

acpi_ec_dispatch_gpe()

instead of the if () and the following return statement.
