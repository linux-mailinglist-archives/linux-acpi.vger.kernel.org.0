Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C331CD21B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 May 2020 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKGyl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 May 2020 02:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKGyl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 May 2020 02:54:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D8C061A0C
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 23:54:41 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so6705399otf.6
        for <linux-acpi@vger.kernel.org>; Sun, 10 May 2020 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6+amfEosJ/bxoBXLb6j1uSeLid6XebkwIxNU/VrJcPg=;
        b=a75yW7abW6pGtQ5fe3DEi2pjcgbX5xc8WztVZeVFufziZx+d4V/T7QWjUoYYjsQuwb
         GtNIfRw6PJb58i5XEzZbAaD5M8SFtzAl/aTandUu2B7fnwEgyUudv3FPKJ5ronfxP/FI
         NIm+Dsy0EOGR9NxCo47VECaQ9mHt4pySNhDk9umEDl2i7/k194FpMlsXW4eKXaEqsFud
         PHd3Z/NyuUmFRAQ/lXMhK/NhDv8eBPGdi/RcONTBtN1S9taAF5Fgi7zV141t5W4onNBL
         oJgzgyIvJlbeSgA/HdvDP9k+S5gA38olwYyc3vOKcDZWrZXRYbk2EYVzgQV5BI8sIOHd
         4fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+amfEosJ/bxoBXLb6j1uSeLid6XebkwIxNU/VrJcPg=;
        b=mQ7Muiki4ToHVG9+pn+FWA698JbELacFWV4t3WV7NKUJy3p88kvJcHlgfDPvRvSAYA
         c0NHmklmQram1/r+gHeGK+9dF0odQhYTE7BYiuw978aTgV303Lx1yJcn5eE8xE9JCrG+
         5D12BEPxAJE6llyuv25ahqIf9e8Tw5joxx/tRd4rW+VVrcpPm7IuYMrTivzLuiIv74Ns
         s/GBpzxFcIx5cejvbLNfNaX9+rl0X1TE2qSzwfinq0jWrBqZNHtri4BT8tcfZr5o2MAZ
         4ufewP9dbBe2xo0wrKusoaQWHtHCTSVFoTbaOmuk/DbRy+eY1vBzeASOLNK55VCfj1Hp
         pH4g==
X-Gm-Message-State: AGi0Puad1y32nbVgAMi/RaPu/szDp4FVEjQrF64kkuko8bs+cLSCZXgf
        +AxXRmolZhXDaAtISWOBQG1vjv5VyrI6xX6QwNqkhR8W/Y4=
X-Google-Smtp-Source: APiQypLkNnC4oo0clTiNZcwduav+zSJ51Ke8PRXADTGgd3N/ohCp/OedUzze728dcG1VvvKoKW2dxexVu0OnsACtau0=
X-Received: by 2002:a9d:7312:: with SMTP id e18mr8580141otk.33.1589180080183;
 Sun, 10 May 2020 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <5029155.caIQduTdCh@kreacher> <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
 <79452135.44xTU8OeJi@kreacher>
In-Reply-To: <79452135.44xTU8OeJi@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 11 May 2020 14:54:29 +0800
Message-ID: <CAB4CAwfSAjZUTf5DwqrJUV5BH5mx6EZMnnDjkCLHb_nA6jjvsA@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 9, 2020 at 12:50 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
>
> On Friday, May 8, 2020 10:22:09 AM CEST Chris Chiu wrote:
> > On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> >
> > =EF=BC=A8i Rafael,
> >     Thanks for your patch. I tried it on my laptop and it's also
> > working fine. Wake up by keystroke/power button/lid open all work as
> > expected. Thanks.
>
> Thanks for the confirmation!
>
> Please also verify the final version of the patch available from
>
> https://patchwork.kernel.org/patch/11537215/
>
> Of course, it will only make a difference if the ec_no_wakeup switch is s=
et
> on your system (either as a result of blacklisting or via the kernel comm=
and
> line).
>
> Thanks!
>
>
>

Thanks. Rafael. I've tested it on my laptop and it's still working well.

Chris
