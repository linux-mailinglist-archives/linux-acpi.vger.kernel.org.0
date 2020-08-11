Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF460241C74
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Aug 2020 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgHKOeX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Aug 2020 10:34:23 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:35743 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgHKOeX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Aug 2020 10:34:23 -0400
Received: by mail-oo1-f67.google.com with SMTP id j19so2669566oor.2;
        Tue, 11 Aug 2020 07:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIC4cfW+RcaIaHxzET6Mv7HV0tRxX9+Hs/NGmdFDqgQ=;
        b=lV041ly4fydpqfzso7qJIM66jjIFILbyLnAFM82OxHw1RPjEyWWhrZPEI5qTFBH350
         RVwimoFDQGPBVICZdM0aN3qrQ5LCNztQcaYTBAoIJ9sQwfh0dhlgTRd9zjkuVpjEXMAc
         K6bIzP+0c2HmORZq1We6vb9jMpCs47iooTJsdnV4SjbQYE9CKqzY/qaiJdX6m4SdS5b3
         OedR95VQnwobXqiqI2kj33s0d0AbxMB/jj+C944Gh4EwMgvjLM8zpUqWv+47FEYswhGO
         6cV1fQr8+GZFv5Uw1ydwvfDye4VYKkY/DE/G+UZPPGfx+/gLUMi53gX0hwN6e69uvt1C
         238g==
X-Gm-Message-State: AOAM532yWo/tk/IwTxPqQrfWtMS768FL+cY+sYGoQKMrxk9X0u1T2FEF
        aEHCfdUcg9M7eOfySrPILtk8XonHzfKE7QmRlV0=
X-Google-Smtp-Source: ABdhPJzlzVsSL+6xjj+8UpyK2xzCh7cJEzoW8doRs3Y9Ve3BiPOquBNUZU2eVdJdyNiRRO9V88pV93P7wpUziQEvOHo=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr5401194ooj.1.1597156462415;
 Tue, 11 Aug 2020 07:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <871rmesqkk.fsf@gmx.net> <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net> <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de> <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de> <87blkbx1gt.fsf@gmx.net>
 <87imdp5r80.fsf@rub.de> <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
In-Reply-To: <20200811132955.wbt55ns7bu5mxouq@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Aug 2020 16:34:09 +0200
Message-ID: <CAJZ5v0h+n9VCz5=VixVbe_b=ZbTU3D=46stGhE9z7Y7yaUMJzw@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Stephen Berman <stephen.berman@gmx.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 11, 2020 at 3:29 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-08-11 13:58:39 [+0200], Stephen Berman wrote:
> > him about your workaround of adding 'thermal.tzp=300' to the kernel
> > commandline, and he replied that this works for him too.  And it turns
> > out we have similar motherboards: I have a Gigabyte Z390 M Gaming
> > Rev. 1001 board and he has Gigabyte Z390 Designare rev 1.0.
>
> Yes. Based on latest dmesg, the ACPI tables contain code which schedules
> the worker and takes so long. It is possible / likely that his board
> contains the same tables which leads to the same effect. After all those
> two boards are very similar from the naming part :)
> Would you mind to dump the ACPI tables and send them? There might be
> some hints.

Do we have a BZ for this?  It would be useful to open one if not.

> It might be possible that a BIOS update fixes the problem but I would
> prefer very much to fix this in kernel to ensure that such a BIOS does
> not lead to this problem again.

I agree.

It looks like one way to address this issue might be to add a rate
limit for thermal notifications on a given zone.
