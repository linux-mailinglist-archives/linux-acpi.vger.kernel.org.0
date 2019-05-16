Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA920AB1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPPIP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 11:08:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43198 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfEPPIP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 11:08:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id u27so2900789lfg.10
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2019 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGHxW899Amf7ZgHaxb24JsnGeNM4NZvWTEPA1jMV4y8=;
        b=AtS0tP7u7iyJ1QEm//4O5HaN3+5kkE2tr9Yqtj73YWBv2pnZkSMIsKWKaScHGyv6fO
         H8ljLoZWHA0lu28jqNo2CZO4sASGLxZBPHEQMwNQVDmIJ70k63fFucdxmDo8LHK54i46
         +sia9Wr5owuEX/MqfRs/YVPWurP/Jf7wXvQDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGHxW899Amf7ZgHaxb24JsnGeNM4NZvWTEPA1jMV4y8=;
        b=nkQPYr5iW73sAklDON2ZTatB7I1zjsPrbTAjxOo+HaQpLSJ/vDVM/FGinIPL6rwb1e
         LNjxTGO65aDs0T7HMy7hYUaBRlQbVukvnQXMDcVNEMRFDK9Tr21mL7zyk0427vKLxWaO
         FZoruDWhh28AJw3NMyQOkRkW0EjGWQWhNVjbS+Mngf7qIWztlhfPbPHtCNSCHcWcrBPi
         VJZQXnCQVLEttB2mX0Wpc5upVpwWrsRXSfslInqZrvHba6D4UINZ3PU07mmbodbkTh4Z
         +DnVQiqnqI+KEbpRjhZyhsqyMwRDBoC7HeyTtjeEcf3Jjd4zPrz8V8FtdzwWqvgMoUF3
         twTg==
X-Gm-Message-State: APjAAAUVGxfuu03Qrihwra5uKGlWNESjAQ95zyFIIECvL4uyc1k/D+Dj
        5PDYUHXxt341Vv8ITMHmRlDNhb2KJaE=
X-Google-Smtp-Source: APXvYqy6/IPvsYyJIvx5CVu3DH3I8YQ4tKEfMjLrM8lGqsGzkaQmxUQ6RtvoeLDxa3jU5zf36un+4Q==
X-Received: by 2002:a19:fc04:: with SMTP id a4mr9969324lfi.39.1558019292952;
        Thu, 16 May 2019 08:08:12 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k18sm923873ljk.70.2019.05.16.08.08.11
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 08:08:11 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y10so2954489lfl.3
        for <linux-acpi@vger.kernel.org>; Thu, 16 May 2019 08:08:11 -0700 (PDT)
X-Received: by 2002:ac2:510b:: with SMTP id q11mr22478766lfb.11.1558019290857;
 Thu, 16 May 2019 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516044313.GA17751@localhost.localdomain>
In-Reply-To: <20190516044313.GA17751@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 08:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Message-ID: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
To:     Eduardo Valentin <edubezval@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.

This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
support via external interrupt"), which added a timer to the pwm-fan
handling.

In particular, that timer now needed the same kind of cleanup changes,
and I'd like you guys (particularly Guenther, who was involved on both
sides) to double-check my merge.

The way I solved it was to just make the pwm_fan_pwm_disable()
callback do both the pwm_diable() _and_ the del_timer_sync() on the
new timer. That seemed to be the simplest solution that meshed with
the new devm cleanup model, but while I build-tested the result, I
obviously did no actual use testing. And maybe there's some reason why
that approach is flawed.

Guenther?

                    Linus
