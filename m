Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A04658447C
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jul 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiG1Q5E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jul 2022 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiG1Q5D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2022 12:57:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D75721B
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 09:56:59 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10e634ecfe6so3014290fac.8
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+neT7drnhUVN6IEwt5cqIrCpyz1zNkYGzrU5Sn+25po=;
        b=N/sgs+QuFpuUwFiUZBjJm6IQrlOlMhIiDya+kN2jqxag5eodzaya5QHHvG90yHGR6J
         ilM6y/ORThHfyVxS8edWpoQPrqBRXQiG9Wo7TpM26TPXMMvOZWJFi4ILQ1s/nARzg30c
         Jz9kIepJRc+HYrdrE5UP2EoKTLpt++h1/3cnDxUP7bFAR+uGKhL2Cb4OQdr2JkMAR1xf
         yaN/x3fcTzhubwXLDbPNia9IbwL/tUfDyMNVSoYLqEjY9NvkcrtSTP4CJbHyx1luCNbk
         5aW0yJzTpZ5Q1duc0tw4HOY+tlAl9w1M1fcmapGLnqz6FyOj+iSeG7NOC/mY1Y9kvowb
         izaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+neT7drnhUVN6IEwt5cqIrCpyz1zNkYGzrU5Sn+25po=;
        b=Hm2Wry+burvwjMxz7iEv2NuRt2BOy1T2gFiVe0Id/fJgYyoBbLjd6jciLaR7F3J358
         cpZpMU7cqJP3wu3jXe4AI3qMRNoZz37NfEdmrsNk4v+Nl+BihqAWJTiWyNfOykNhhnd1
         csFJ5VW28ngkGxy7vic8+CK4nnSbU4KX2G6dLJtACg5NOYh7BC+QHTnoeHJBWadydDvS
         GOlP0hCrd2ZDIwfvHp7uI+J8kmmUWdyEIdXEDsPcLap4zYpEWsBcqunO2WvkBpY6v4/L
         B3Y4hzKlHSqZCUy5Md9c3fbsuOAE0HH6V3lXNk8k/jwaSXwYT7zCX0RfVUd4OXgafs4K
         SYLQ==
X-Gm-Message-State: AJIora+IQtWavUmsXPeH6UkAjxGMNmckOx4p0bK8PyGDAKy1gK1BunA/
        tYZksRMt/M/PlussMB9tZ0nJOn3ZnvfpiTr297pY7w==
X-Google-Smtp-Source: AGRyM1s2wYwcYRLI1t8oGbHlSkYF7nki9R79iqP4GkO+sJM610lF9/jDXBRf6KuYUgt99I2pgHY/3R8xIXBCqcBgUmo=
X-Received: by 2002:a05:6870:4186:b0:101:17ef:d966 with SMTP id
 y6-20020a056870418600b0010117efd966mr173601oac.97.1659027418891; Thu, 28 Jul
 2022 09:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064321.2953971-1-mw@semihalf.com> <20220727064321.2953971-7-mw@semihalf.com>
 <20220727143147.u6yd6wqslilspyhw@skbuf> <CAPv3WKc88KQN=athEqBg=Z5Bd1SC3QSOPZpDH7dfuYGHhR+oVg@mail.gmail.com>
 <20220727163848.f4e2b263zz3vl2hc@skbuf> <CAPv3WKe+e6sFd6+7eoZbA2iRTPhBorD+mk6W+kJr-f9P8SFh+w@mail.gmail.com>
 <CAHp75VfGfKx1fggoE7wf4ndmUv4FEVfV=-EaO0ypescmNqDFkw@mail.gmail.com>
 <CAPv3WKeXtwJRPSaERzo+so+_ZAPSNk5RjxzE+N7u-uNUTMaeKA@mail.gmail.com> <20220728091643.m6c5d36pseenrw6l@skbuf>
In-Reply-To: <20220728091643.m6c5d36pseenrw6l@skbuf>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 28 Jul 2022 18:56:48 +0200
Message-ID: <CAPv3WKd0rbwN2AyGRSG1hUji3KzCdG2S=HfCxk7=Ut3VbmPXGA@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 6/8] net: core: switch to fwnode_find_net_device_by_node()
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

czw., 28 lip 2022 o 11:16 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(=
a):
>
> On Thu, Jul 28, 2022 at 08:52:04AM +0200, Marcin Wojtas wrote:
> > Yes, indeed. After recent update, I think we can assume the current
> > implementation of fwnode_find_parent_dev_match should work fine with
> > all existing cases.
>
> What you should really be fixing is the commit message of patch 4,
> that's what threw me off:
>
> | As a preparation to switch the DSA subsystem from using
> | of_find_net_device_by_node() to its more generic fwnode_
> | equivalent, the port's device structure should be updated
> | with its fwnode pointer, similarly to of_node - see analogous
> | commit c4053ef32208 ("net: mvpp2: initialize port of_node pointer").
> |
> | This patch is required to prevent a regression before updating
> | the DSA API on boards that connect the mvpp2 port to switch,
> | such as Clearfog GT-8K or CN913x CEx7 Evaluation Board.
>
> There's no regression to speak of. DSA didn't work with ACPI before, and
> fwnode_find_net_device_by_node() still works with the plain dev->of_node
> assignment.

There was a regression even for OF in v1, but after switching to
device_match_fwnode() it works indeed. Anyway patch v4 is imo useful,
I'll only reword the commit message.

Thanks,
Marcin
