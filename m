Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4993E443730
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 21:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhKBUXb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKBUXa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Nov 2021 16:23:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FDC061714;
        Tue,  2 Nov 2021 13:20:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r4so1672878edi.5;
        Tue, 02 Nov 2021 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UyetWvPuNDfyKp+4+2PGhwT/Geo73HADN4YLF27UPDU=;
        b=jPxPft0LAcrb9jf3ZVLf2T+Ts98E+25/MARM4tWWyPjZrtDTeZMQ8NovVytW1FiuCZ
         W4b5fHnVQzGp2ig/EPRU6jJZLxEie3YyBFzdlchKkK20gYHB5WpM2WSQMtC65b+Ixlad
         aS750LdXZFrA6VPEet8mbbrWSiMS8SCt/JH+o12os55SdpHQCYreVuV9k2g9ZG6qyRH3
         WghiilMZPEjIrmpDLwM4AUe8OQPGhP+vCtfUINudBGc7K1nz5DnT2ys5gi+Lak4c0iWL
         59pWcYXihX2xRsP7hsTCiCGJr/KEfcwo/lu8uxitooXbIgjzIVlfsDlDI/jYAEraY0Hd
         fXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UyetWvPuNDfyKp+4+2PGhwT/Geo73HADN4YLF27UPDU=;
        b=CVYKvTOzx20b/lY54VSYuvWEJJtcTvqxY+2GyGBV1P++WGTA0k6C4bL0j0DqkjI+GE
         gVtjlH+jS6Y6mOSIma2W90iUZwsb7BqPNjjjGkDoIwu+xMjb6pBvXTJyV5drzoPxGUmg
         1XE1cMUaTsAeoJxyg8AL2NSlk+4Db147fEHkZRkz3/Vk2PiVfQkbX+zWZPz7wVuP746W
         siOqS+GPBzWh4KvhtZ92ovbdSBti2Fm+O2sSEM7Ga04H/nAbweu5GR+nDdVLZ1Kq8JtG
         oTRkDZm1n2nlPJ075zmF0NGxc7tP/LORA/zer2UfXh0JnhQ3v2lNvIn4FguvvWQ16UPL
         EIdA==
X-Gm-Message-State: AOAM5321rl3lzj1w6GbZjdxEadkrTmbTQ8HnjA9URkir+0ZN5COWtbCL
        UI5LXextjxzxVG9kLzu/myLzTmR/9tJNBAPc7sc=
X-Google-Smtp-Source: ABdhPJzI/ebWOWGB2dP1VAOOAJLjsnxGsrinSpguycoI1uct4Q0O43HSBt1LwROMKas/ujZk3x9VRjfDjoIlhcErdZo=
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr46570525ejc.128.1635884453458;
 Tue, 02 Nov 2021 13:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com> <c5767824-f39c-772c-d376-77db24bb2f84@quicinc.com>
In-Reply-To: <c5767824-f39c-772c-d376-77db24bb2f84@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Nov 2021 22:20:04 +0200
Message-ID: <CAHp75VebqgAyOz5MYRjdujijhas2iTw3viS1vpXm8RNkBevaMg@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 9:44 PM Qian Cai <quic_qiancai@quicinc.com> wrote:
> On 11/1/21 7:51 PM, Andy Shevchenko wrote:
> > No, it=E2=80=99s not so easy. What you are doing is a papering over the=
 real issue
> > which is the limitation of the firmware nodes to two. What we need is t=
o
> > drop the link from struct fwnode_handle, move it to upper layer and mod=
ify
> > all fwnode ops to be used over the list of fwnode:s.
>
> Andy, this is my first time touching fwnode/swnode. After reading the
> source code for a few hours, I still don't understand the hint here.
> Specifically, what does the "the link" refer to?

https://elixir.bootlin.com/linux/latest/source/include/linux/fwnode.h#L36

(Property related) fwnode (as of today) is the single linked list with
only two possible entries. Comments against set_primary_fwnode()
followed by set_secondary_fwnode() may shed a bit of light here
https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4724

--=20
With Best Regards,
Andy Shevchenko
