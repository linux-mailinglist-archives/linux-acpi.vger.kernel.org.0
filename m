Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504A446939
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Nov 2021 20:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhKETnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Nov 2021 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhKETnM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Nov 2021 15:43:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54315C061714;
        Fri,  5 Nov 2021 12:40:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v11so34075490edc.9;
        Fri, 05 Nov 2021 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zoYOTM2NV5RyZ0l0zhLuwSNQOW5Ix3TRM9XY/V4SUj4=;
        b=bY+ywjEgO7ch/e24ID03hDOSNQcWe8kEGiV7m55DaN24oq+UaltV/wSVODoWOPdxmz
         xwrGwYH99UcDiBBnynEZjQrSWPXIxh6azpA42N3VO+4VyCiWgWinLBFCKzdwUEQjx9ZZ
         PQGkx+kMLCCaiQrU0EGpXBSDEVhJYiIJBwa6MkYfbu03xJoCAElFyGgs7I6VheZ07Y3Z
         4plOdeOZNu9hOl1DneQcVmw7MoC5yW4wZPOcdj+xyzix/cg4mQ5SzosQpDXDDLhtNVbQ
         tMeRU01MP3E+3JZaJeKNu2mC8VlOdPoOyW/Cb3hBeBuJGeqZs0xmn968deoTJBrJVhIK
         z4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zoYOTM2NV5RyZ0l0zhLuwSNQOW5Ix3TRM9XY/V4SUj4=;
        b=f4p0squdOB1sZG8Qld5XByY0SqaiQAFWwpwzMHQn0YoPqoO1MKk/9+E2d0jY5EmMCE
         tIP2KwDgYVo3066LJ9gGsTSj7B740FS24ZyjHUdBv5Zc6BOpcgtkvB8VWc7xd0qbQbpH
         k8+ajYaUpJFW1Ew+U7qkxz5YyPjw7rG6PluL0zAVlGHuEw4KyQ3V5ht4+1HGcjf9/U++
         By3LSTaDLYkCkR2n+MBZZE4H6jV6mxVREEJvD//2sqokATDSml6KyoaAXchgynY/hHuM
         8FJ7IOQWJuOFSjNCapsz/pL6AmbToXTZrLlOBfxAi1hwXBkr2T63SwLHMMYgQXV1eSaL
         4a5g==
X-Gm-Message-State: AOAM533YbyN8Ta99zZhiH/344mC6dk5ldsuprFU3lKZzWV2XTw3US/hx
        94579ta9oppsxKQPMYatm+Zs2CGjr8IxC+I6iqM=
X-Google-Smtp-Source: ABdhPJxe4Y5bMJlChwfIjX2wzz2fesdu1sjIm+KIR7U8H0MRf/YBfjRzRbx4z5Jg+rlHErmQWPz0HySz8DeYbU85JzM=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr16245889ejb.377.1636141229878;
 Fri, 05 Nov 2021 12:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com> <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
In-Reply-To: <52df4a97-1132-d594-0180-132d0ca714d5@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Nov 2021 21:39:42 +0200
Message-ID: <CAHp75VebOnrce-XZjOnZiivQPz-Cdgq6mor5oiLxK8Y49GiNNg@mail.gmail.com>
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

On Fri, Nov 5, 2021 at 8:47 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
> On 11/1/21 7:51 PM, Andy Shevchenko wrote:
> > No, it=E2=80=99s not so easy. What you are doing is a papering over the=
 real issue
> > which is the limitation of the firmware nodes to two. What we need is t=
o
> > drop the link from struct fwnode_handle, move it to upper layer and mod=
ify
> > all fwnode ops to be used over the list of fwnode:s.
> >
> > XHCI driver and DWC3 are sharing the primary fwnode, but at the same ti=
me
> > they wanted to have _different_ secondary ones when role is switched. T=
his
> > can=E2=80=99t be done in the current design. And here is the symptom wh=
at you got.
>
> Andy, thanks for the pointers so far. I was able to trace
> set_primary_fwnode() and set_secondary_fwnode().

Can you share the trace you have got?

> Anyway, what's the "upper layer"? Is that "struct device" or "struct
> swnode"? I suppose you meant:

struct device here.

> - Remove "secondary" field from "struct fwnode_handle".
> - Replace "fwnode" from "upper layer" with
>   "struct list_head fwnode_head;".
> - Modify all functions in "software_node_ops" to use "fwnode_head".
>
> Is that correct?

Yes.

It might be a bit complicated taking into account how much fwnode is
spreaded in the kernel... Basically, you need to fix all direct
accesses to the dev->fwnode first.
Besides that you need to check that fwnode, which is used out of the
device scope, like in IRQ domains, doesn't use secondary pointer(s).

This nevertheless adds a lot of flexibility and we may add whatever
type of fwnodes and mix them together.

--=20
With Best Regards,
Andy Shevchenko
