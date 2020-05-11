Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91C41CD386
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgEKIKb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 11 May 2020 04:10:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38117 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgEKIKb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2020 04:10:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id r66so14371898oie.5;
        Mon, 11 May 2020 01:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4G9OIpAZMoU+Rj2h+bioE7h+vc9JYbzJCpmFc3kICmI=;
        b=dbzc9l0N5cSXVn1MV0O2ZEYZ3r64Sk6YC6FDgcQn6dMzAp9Sm8FxthruHRuBYjfXID
         Pe0aad35ag4QCAZ0kMoCRyBykhSCXnThIfeECZquxh1DoPlbyenpfFnJfcOAy60ABhy2
         f3yPZIYzFyTbs2BtMaQgbEHDyJlZiFG6b22bh1hl4FxhhSfqaycruJMJi/GdXGnvT4kC
         stRX7Xcn5NopAI1QAxOvGGyJkwxythZDFFxoY5qct+KULTBzuPsfeOZcGnNFPp/M/4y4
         O0CSTs7JYcKFg9ttrjWsVDCpobmEMkgrGA5wBS230hZ43DdDYauI1ZMu3scLwgj/E597
         9RPQ==
X-Gm-Message-State: AGi0PuZqj3+2/Z89tK7pdNhfniASxy5PMvQ+Zi0Wi2g1HymGGzxZwZ7p
        R/VR8dvyhUqrvqlmVreeNt16yam+xYKnAyf8tVw=
X-Google-Smtp-Source: APiQypKcyiojqidAHlOj8oSMY7ShqOJrg8KWoMbdo1YAO1r/T/TsDKRHOwo7/z6H7ej1tOAPJXBdiVBBO2gOYF4KirQ=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr19456537oie.103.1589184630867;
 Mon, 11 May 2020 01:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <5029155.caIQduTdCh@kreacher> <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
 <79452135.44xTU8OeJi@kreacher> <CAB4CAwfSAjZUTf5DwqrJUV5BH5mx6EZMnnDjkCLHb_nA6jjvsA@mail.gmail.com>
In-Reply-To: <CAB4CAwfSAjZUTf5DwqrJUV5BH5mx6EZMnnDjkCLHb_nA6jjvsA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 May 2020 10:10:20 +0200
Message-ID: <CAJZ5v0jaYrtj2+TNsiByd8HJmyT8OpCtEUfG+LRAHuvy0NRB3w@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     Chris Chiu <chiu@endlessm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 11, 2020 at 8:54 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Sat, May 9, 2020 at 12:50 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Friday, May 8, 2020 10:22:09 AM CEST Chris Chiu wrote:
> > > On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Ｈi Rafael,
> > >     Thanks for your patch. I tried it on my laptop and it's also
> > > working fine. Wake up by keystroke/power button/lid open all work as
> > > expected. Thanks.
> >
> > Thanks for the confirmation!
> >
> > Please also verify the final version of the patch available from
> >
> > https://patchwork.kernel.org/patch/11537215/
> >
> > Of course, it will only make a difference if the ec_no_wakeup switch is set
> > on your system (either as a result of blacklisting or via the kernel command
> > line).
> >
> > Thanks!
> >
> >
> >
>
> Thanks. Rafael. I've tested it on my laptop and it's still working well.

Thanks!
