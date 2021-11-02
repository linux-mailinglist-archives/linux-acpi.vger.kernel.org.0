Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17A44374A
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhKBUaF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 16:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhKBUaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 16:30:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11894C061714;
        Tue,  2 Nov 2021 13:27:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id j21so1624283edt.11;
        Tue, 02 Nov 2021 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QAaXhUzziYq9zGj4Dn+TSRAKewTMaW26NBtOKk5rNW0=;
        b=bgMThWbXBX8BJYCrH5bovFBKEVLKqcpIEs4af/BStQOpvBfKG1/neFup8YmukpBfJG
         ymGA3GTTcuH96/OqfzVR2//BXRBdm0Jj8xxO8+4L+ktsjKk+IcFiEDBm+Ur/7j5D/qPE
         rxnt493wXJ5+QdktZURiZhtO2aXNpKz2w2YgorA6CbrmDruVbGkEpv4Y2KO8oZ8ALEi1
         1MW5RM1u/EtE880HX92DzbHSEi6VenQ0r7qadMTm/+Z8cX3XZ8Cp2taWFTpQylW2U4bS
         m4UjDxNbRrj3kLGd+2LTPP288+/7CcmEMF0d3nF7mdReC7rs2OfHO1O4WnfiFEJwWu54
         07Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAaXhUzziYq9zGj4Dn+TSRAKewTMaW26NBtOKk5rNW0=;
        b=LfT5HbcOcJ7x8dDtg9fuqyib/pXN9sSP1nxvqhRwXX6+B5aDuOEKWijvb6xvp4cT/c
         vm5JGNnyZyCLAB0wSKkDwFhLL8hRgvAStbMDTK4IvrDYO4Hw9tcTTAZ0hjqLYnx53ALo
         mbbU8BSzaNqRga2dPl0xPI0NtblxQVp4kfuUH8JkEaf1vOPqHYFkf7eViN6PXCTGQt3x
         XPelVkQITH+fUsdIR95HiXbg14LjS150F0ytisELIPGV5jA30E9JGNrMGebvZb0tW5hZ
         pSW6eyQhF+oT/WB4rJaHYZsJ0d3DW4GvGHGQHrsXTqYHST2KZQLKabKPu0hCZsieQjm0
         tpMg==
X-Gm-Message-State: AOAM530HkCdxSQvCAyDZw5i9gDfY2lXazqF5ZqCv4P3qdGtcXYwusdOp
        PLwGWplVC8O7UeE7Z+V4tMlcC6l9QdsEXcjec0o=
X-Google-Smtp-Source: ABdhPJycZI0Dw0WaYwPwN+hEursxXTV7aXeKrv8My/ffFTCtVJCoYnTriOQyB5q1M8/qy6lu8Qsdekqd70HIlrTsS4g=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr48274365ejc.69.1635884848667;
 Tue, 02 Nov 2021 13:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
 <c5767824-f39c-772c-d376-77db24bb2f84@quicinc.com> <CAHp75VebqgAyOz5MYRjdujijhas2iTw3viS1vpXm8RNkBevaMg@mail.gmail.com>
In-Reply-To: <CAHp75VebqgAyOz5MYRjdujijhas2iTw3viS1vpXm8RNkBevaMg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Nov 2021 22:26:39 +0200
Message-ID: <CAHp75Vfo0Bp5SCeb1_oKa5BZBj=X9KdDicbVpUyR4HKY_MDsqg@mail.gmail.com>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 2, 2021 at 10:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Nov 2, 2021 at 9:44 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
> > On 11/1/21 7:51 PM, Andy Shevchenko wrote:
> > > No, it=E2=80=99s not so easy. What you are doing is a papering over t=
he real issue
> > > which is the limitation of the firmware nodes to two. What we need is=
 to
> > > drop the link from struct fwnode_handle, move it to upper layer and m=
odify
> > > all fwnode ops to be used over the list of fwnode:s.
> >
> > Andy, this is my first time touching fwnode/swnode. After reading the
> > source code for a few hours, I still don't understand the hint here.
> > Specifically, what does the "the link" refer to?
>
> https://elixir.bootlin.com/linux/latest/source/include/linux/fwnode.h#L36
>
> (Property related) fwnode (as of today) is the single linked list with
> only two possible entries. Comments against set_primary_fwnode()
> followed by set_secondary_fwnode() may shed a bit of light here
> https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4724

What you can start with, btw, is adding the trace events / points to
these two functions. (Currently only devres is enabled:
https://elixir.bootlin.com/linux/latest/source/drivers/base/trace.h)

When you do this, you may actually see what's going on and how the
swnode tries to recreate the same file.

--=20
With Best Regards,
Andy Shevchenko
