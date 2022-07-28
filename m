Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958485847AA
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Jul 2022 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiG1VXo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Jul 2022 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiG1VXn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jul 2022 17:23:43 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD872EC1
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 14:23:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so2082912otk.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2022 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ij74Th/vMmEz+gNqy9uYn3se71AQn1yKD6gr4cPFKYw=;
        b=j7pelOj1pzxgg1efBlCqYELBpRD65FFTJ8tw9tnnP84FtDNTCds2dATWDgYxW32w38
         t8KyLhxB5JAS/1p7C82l2QwTRyznzPlz4aZlJHhzvyptLx29+F/pwQoMted7yZH54DZS
         txbUvMkJKVmf01otDG2x5kWNfWC3Rpx4tO50X3hDtaDhplalr0Q7MSADe9KUr83YUMe6
         x8uCmEwJ8rkgYBt+bIrQZcpE/+gHUNsEqf92ydSp+PR2T7aevca/+3/GU4A3VW6LX3A8
         11y78NVo8GuXrZNRcJ7/TREwqy/kc4Tw/5Y+Dz4i+vUPH09PYzgOf/25//tlJTxsdSxP
         DQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ij74Th/vMmEz+gNqy9uYn3se71AQn1yKD6gr4cPFKYw=;
        b=OjFwBnWPt/rrbPQ9sM4ew+n4irfa5+Ye0rfP/G0P6Hq+y7C71+ekvtTfoerN93Tws3
         1LTkTOE0C5zcVB7NQmaWOqtcBxullCGJ2wIzLUc8uMvCN39Lk0uYGOD5zzTaL8eqkAnK
         NO3HxoN5tkn5T5Vfd3gxZdBO6phg2pCuQXvXhV4xSBvvdnf6FrkJje4wOLGHdyaVIGOB
         DXS1MxFsP7nxkCG4YjRpndRI8MERje8W2jr50fXSzq1KtBnkibg1Ndvgy0sAfchIRplx
         NrfgodeqIwb0Axef2bYKiYa6qLQ+K1PDtkrZ+6wKvlEGGsNhuAbQ+1eQAjbD/9FggyWs
         8thQ==
X-Gm-Message-State: AJIora/Q/MC6DWMjI/WFq2+iX0OAKS9mvl0I9m+zOKZ/54MYMvzyfOed
        476y1mbThFLTWRX4TYMxtJWHVm1Jky5oIa/H8BdM/w==
X-Google-Smtp-Source: AGRyM1tKO2ZFY1R7hGdHQwefohosiDeoc/T9gnLvUi+K58diANIz+pSp0UhQGk3RXcfSH4c+MKCllBInmBrtjb82LFQ=
X-Received: by 2002:a9d:73d0:0:b0:61c:8d31:6981 with SMTP id
 m16-20020a9d73d0000000b0061c8d316981mr349015otk.99.1659043421462; Thu, 28 Jul
 2022 14:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220727064321.2953971-1-mw@semihalf.com> <20220727064321.2953971-7-mw@semihalf.com>
 <20220727143147.u6yd6wqslilspyhw@skbuf> <CAPv3WKc88KQN=athEqBg=Z5Bd1SC3QSOPZpDH7dfuYGHhR+oVg@mail.gmail.com>
 <20220727163848.f4e2b263zz3vl2hc@skbuf> <CAPv3WKe+e6sFd6+7eoZbA2iRTPhBorD+mk6W+kJr-f9P8SFh+w@mail.gmail.com>
 <20220727211112.kcpbxbql3tw5q5sx@skbuf> <CAPv3WKcc2i6HsraP3OSrFY0YiBOAHwBPxJUErg_0p7mpGjn3Ug@mail.gmail.com>
 <20220728195607.co75o3k2ggjlszlw@skbuf> <YuLvFQiZP6qmWcME@lunn.ch>
In-Reply-To: <YuLvFQiZP6qmWcME@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 28 Jul 2022 23:23:31 +0200
Message-ID: <CAPv3WKeD_ZXeH-Y_YP91Ba6nZagzBVPoWbmFE8WtRw-NYxdEaA@mail.gmail.com>
Subject: Re: [net-next: PATCH v3 6/8] net: core: switch to fwnode_find_net_device_by_node()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        upstream@semihalf.com
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

czw., 28 lip 2022 o 22:18 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > The 'label' thing is actually one of the things that I'm seriously
> > considering skipping parsing if this is an ACPI system, simply because
> > best practices are different today than they were when the OF bindings
> > were created.
>
> Agreed. We want the ACPI binding to learn from what has worked and not
> worked in DT. We should clean up some of the historical mess. And
> enforce things we don't in DT simply because there is too much
> history.
>
> So a straight one to one conversion is not going to happen.

I understand your standpoint - there is a long history, possible
clean-ups, backward compatibility considerations, etc. that should not
be zero-day baggage of ACPI. Otoh, we don't need to be worried about
the ACPI binding too much now - as agreed it was removed from this
series, beginning from v2. IMO it may be better to return to that once
the ACPI Spec is updated with the MDIOSerialBus and the patches are
resubmitted on whatever shape of the DSA subsystem is established
within the next weeks/months from now.

In v1 we discussed also the resubmission of the non-ACPI-related
patches, which would pave the way to dropping the explicit OF_
dependency in the DSA and moving to a generic hardware description
kernel API - without any functional change. Modifying DT bindings and
clean-ups could be done on top this patchset as well. Of course, it is
the subsystems' Maintainers call and I'll adjust accordingly - if you
wish me to wait and rebase after the 'validation patch' lands in
net-next, I'll do that.

A side note: I was of course aware that making it for the v5.20 would
be extremely hard, but I decided to give it a try anyway - I had to
wait for some time, as this series was gated by fate of the eventually
abandoned phylink-related changes.

Thanks,
Marcin
