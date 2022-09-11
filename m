Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A345B51B7
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Sep 2022 00:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIKW6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 11 Sep 2022 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiIKW6W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Sep 2022 18:58:22 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066321E14
        for <linux-acpi@vger.kernel.org>; Sun, 11 Sep 2022 15:58:20 -0700 (PDT)
Date:   Sun, 11 Sep 2022 22:58:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1662937096; x=1663196296;
        bh=GxW/Dm6QATFPOvatiT3Z7C68ZBjpnugyoRHAYt6E2B8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=TnfOzs7mKEtD8SEQdFpVu37Bro+iSSANfUPWcl+XqXxvuZEJDmrGaBP9oPWLLPX2+
         6PoBGozA6f5zT5d44Pt5StlOCHwDDIX3xj11+Czv+6azJFBGQb8S9eDcLibNt7Vmkz
         WdYGCMEnwskvzW700/Qk6W2QG+2Vgid9zQWFD+W6JVIbNOHDA828idb3w9gmD/g9cN
         gcW4ydwrYFVm/D4Rx3YlR/X8RfsB9xDowvusch0HeJP8bvgOfhZrouWh7bLA0ozw9+
         JWY7IfhIIVYXPZNo0Le6/TAMcGHTC9XoePoTolN5F8cJvjeQM2cJRsETqh15No5cuc
         7vvmCl/vUKbwg==
To:     Arvid Norlander <lkml@vorpal.se>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-input@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH RFC 0/2] Quickstart buttons driver and Toshiba Z830
Message-ID: <n4eOueQW9oL86xdHuyF_thrcz7rwRvVavkwXIM1_BfIZcDwQjWDSoPTDMppNhfHxhISs_hVTTbBOolGV2plbmfkWv6V61Uv_hR7l1dzwzYA=@protonmail.com>
In-Reply-To: <20220911194934.558019-1-lkml@vorpal.se>
References: <20220911194934.558019-1-lkml@vorpal.se>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


2022. szeptember 11., vas=C3=A1rnap 21:49 keltez=C3=A9ssel, Arvid Norlander=
 =C3=ADrta:

> [...]
>
> 1. Summary of standard
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Here is a brief high level summary of the standard for PNP0C32. See
> https://archive.org/details/microsoft-acpi-dirapplaunch for the full
> standard.
>
> PNP0C32 devices are "Direct Application Launch" buttons. The idea is that
> they should work while the laptop is in various sleep modes (or even off)=
.
> The Z830 does not support waking from any sleep mode using these buttons,
> it only supports them while it is awake.
>

Hi

I might be way off here, but could it not be that one has to enable/allow
the device to be able to wake the system up? Or did you test it on windows
as well and it did not work there either?


Regards,
Barnab=C3=A1s P=C5=91cze

> Each PNP0C32 device represents a single button. Their meaning is complete=
ly
> vendor defined. On Windows you can either:
> * Make them launch an application when pressed (defined in the registry)
> * Or an application can subscribe to specific Window messages to get
> notified when they are pressed (this is how they are used by the Toshiba
> software).
> [...]
