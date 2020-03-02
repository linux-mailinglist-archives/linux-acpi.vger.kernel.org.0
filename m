Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8A175377
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 06:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCBFyq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 00:54:46 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38026 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBFyq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 00:54:46 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so144698uaq.5
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2020 21:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xaVFZKXkYwadGJPmxWSyTrfKN4QDA7x77UvzbDi6hYw=;
        b=CPr77l7kD5D+rAiwuZyWv8zJQjAQzrZ2SaX5O2HwQfDvb7nfHwgMHYMKB/gDZFMkU/
         hp4j50gGKIAeYlYuClcTqi6vwyt/nf3iceTzGL7aNCOe3LpLnTo9xxtuLd9s2u4emmki
         d1AiObF/E9n73EjuUtApBgiVqckrKAiE4IJ9mgutkBLgyp1BcRCAOnONvw3fteUiFVVA
         79dkuS2hylinTvRyOh14/8EHEGPAfdVK7ZHcHofybDXihzL9HSjGPKukITYYTxHjSHKM
         FpUcaY+ypDV92ZR62HEp5QvYKo4CTQEDvovh+34M5achweW6EW8YfmTOkPv+29Hd5ZeG
         YvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xaVFZKXkYwadGJPmxWSyTrfKN4QDA7x77UvzbDi6hYw=;
        b=nsc2qhzcbWMKeNQuVaTfQaom8vEy6xr94YKqAlxd3OEa/NKf8nSruMP56qMWvEXcOo
         WElgb8psjEofbMXC/+QIq7U1eln53tLoVN4FKNaELRCiFJ4I8WTrJrfatuMKgXMB5QNe
         X6Qehgdw7zsvnG2H4+Fhj18rBPr0+UgjMZIQPA72V1lRw6O0dsQpQGRTIYbiFMU735yA
         G5wW8P5ChXILytfwYDXcVjz0a+ROMMXmIytfKoMIzm5Zt2VX4fDcDBuoCx35yqAf0Abn
         C5bxthqSyEEyOuofD3OTMgYXr3cNVq6UjZtd6jXOZct3yq+NLC93twBsLCrH5taMnY7w
         QMBA==
X-Gm-Message-State: ANhLgQ1sY6SGAAhZNvZY0T7akJemhIKlG+KfPhRy8DyBn/4WPAQt/Uj8
        xAz/UxItzsYbS62borNazt2LB8cfIE+CbGOfv+sUew==
X-Google-Smtp-Source: ADFU+vtnQNxDfyhIydJNfyBpdE0lGq6GsJ6tyObK59DOF5xuyYZSJgq3fkaYxljupt7e3lTfBookfoG23Ynd14+Qjt0=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr6576762uap.94.1583128485802;
 Sun, 01 Mar 2020 21:54:45 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
In-Reply-To: <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 2 Mar 2020 13:53:56 +0800
Message-ID: <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Daniel Drake <drake@endlessm.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> > The purpose of this series of update of the ACPI EC driver is to make i=
ts
> > initialization more straightforward.
> >
> > They fix a couple of issues, clean up some things, remove redundant cod=
e etc.
> >
> > Please refer to the changelogs of individual patches for details.
> >
> > For easier access, the series is available in the git branch at
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-ec-work
> >
> > on top of 5.6-rc3.
>
> Jian-Hong, can you please test this on Asus UX434DA?
> Check if the screen brightness hotkeys are still working after these chan=
ges.

Hi Rafael,

Thanks for your patches, but we found an issue:
The laptops like ASUS UX434DA's screen brightness hotkeys work before
this patch series.  However, the hotkeys are failed with the patch
"ACPI: EC: Unify handling of event handler installation failures".

Jian-Hong Pan
