Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF91E1242AE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2019 10:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfLRJRh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 18 Dec 2019 04:17:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35660 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfLRJRg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Dec 2019 04:17:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id f71so1672489otf.2
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2019 01:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CsuSqE9cEj4PrC6l1fWx6siNdgbM+X/8dFY9GnHz8L0=;
        b=KgZoAzTYhywNZGR0NoKH+Zac+gQRLoqqSQqgTae7TUHjaNo4FOG2QDzMGnRlzGJ24z
         /2uYZ9P2V4XnG2pCCLfndrySTcuxIOtoZLqUF9dcp+FE+vAFJ3U3U46lZ+c0u1TVrCHO
         WZInuJWccWvygCvySWeYzcY3kriAwxJkmGfRMzR2xVTE/vSHmT8E1RjnzGos1KgCKz4+
         Rv2tHK2vD0UsT5CmiiAcPDiyrtmeBUY9zU8hGXy0/3WKoLi+4UUfHcWfiBl1aruzp/gQ
         p2HCJ+E7tgfvw4xyAT7GdltAJqMX3+GuWzichxWbEDeBi845z2uc4p5iTMlWIc0cdH9Q
         wmSw==
X-Gm-Message-State: APjAAAXkI8Mi2DMSJpYmOkQUhu8h7u2PsjsbmpABy4vI7BOXbdA3zKZ7
        I91PcVfHXRw0YlKB54OX6FrbIORbqvRX6V74mR0=
X-Google-Smtp-Source: APXvYqwx6IeScjaH6vaUzcr5O42K+NkV1Lb/kjd6MpNj3NSWKVoypHVj47Dlt7C3D4ojNj6c0RGMnBA5jUIa8sJK5pI=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr1494365otr.167.1576660655905;
 Wed, 18 Dec 2019 01:17:35 -0800 (PST)
MIME-Version: 1.0
References: <1860961.FledB3ecnK@kreacher> <20191218002709.GA8314@dtor-ws>
In-Reply-To: <20191218002709.GA8314@dtor-ws>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Dec 2019 10:17:23 +0100
Message-ID: <CAJZ5v0hUu8xb-w4yM9Auynhgeb6L3yQovUvk5JexA7YoyFFieg@mail.gmail.com>
Subject: Re: Fwd: [pm:bleeding-edge] BUILD REGRESSION 208501f6808a1dc0205904ed84cac99da01bbf70
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2019 at 1:27 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Fri, Dec 13, 2019 at 11:14:16AM +0100, Rafael J. Wysocki wrote:
> > Hi Dmitry,
> >
> > Unfortunately, this report was sent directly to me without any CCs to
> > mailing lists.
> >
> > This is a tree with the v9 of the last patch from the software nodes series
> > merged.
>
> I tried fetching your linux-pm tree, but it does not contain the commit
> Kbuild referenced. But you must be testing with an old version of tests
> because I see the largest frame at 600 bytes, not the 2.5-3K as in your
> logs:
>
> dtor@dtor-ws:~/kernel/linux-next (swnode-refs-v9)$ make CFLAGS_KERNEL=-Wframe-larger-than=512
> drivers/base/test/property-entry-test.o
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      drivers/base/test/property-entry-test.o
> drivers/base/test/property-entry-test.c: In function ‘pe_test_uint_arrays’:
> drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 600 bytes is larger than 512 bytes [-Wframe-larger-than=]
>  }
>
> Could you please try the 0-day on your tree again?

I will.

Cheers,
Rafael
