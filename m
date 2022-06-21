Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5F552972
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243388AbiFUChl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbiFUChk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 22:37:40 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838421580C
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 19:37:39 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3177e60d980so95558627b3.12
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rapsIuDrfFsVuVecKKOgGJ7AOyoGsXdNTgfZIOKdyko=;
        b=TwlmVz9rzhd2YlyY1B03CnjZdACvG5uGoyT/xrcrFCZRkHG3ezoel6Uxf0cQekEtAh
         l264JeWXh+1YBy2NqNLBYb+08n1wMcjiqJqb3Fr6FVWqV++9w7vuOspSSg9yc5+rd2vq
         KtiebYJDJS8rvp/oAHIEuXsFDA7YyNn4nYxtrVMUL3nrUoy/7AHT9bKT37Ti/ygg6/7z
         l0ZWgHKVaIMlfl+sXsxqjmIw8DtHGqrJxvH1wWx5F9++7nZcvUdumZTLEuKf5CsA3yQ/
         1CdieYW4PVVnaeKs6tSGgRn2eEE+fpIwaSEgEFXhV1h7sJD/7sy3KIKQUIUecQS8mLci
         yosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rapsIuDrfFsVuVecKKOgGJ7AOyoGsXdNTgfZIOKdyko=;
        b=ZVrH9AXrrT1hGCbuQpbtcblN9XBZBIM+NI4zzN02oPJZJc9xdpCal4s4n3Ek9pTH9e
         fEb0WSvDnz16df+s7gnFGtwC9W2zDngRsoXKR6onqnNr6xyaONgfas2h+btM4PyAS9rk
         /OOqnL7+4GsN2983CEpxZrDWwjAbIfWwO5fo62XVwSFHLq9XdYHyBID7Y3Um5jeZ69uY
         mMbQGXqk6YjXOtqRu8jMNR+ePespWa3S4eFfPU7pccsFPuBZcjULxM/Y7Zn0alyjKRix
         JGJhcTRZJNWYNXbk3ET67sKfTF4IGUFSDM1clFYX56F16faCTfKJsNkDtMblvszgcVRH
         f3cg==
X-Gm-Message-State: AJIora/npUhPEhBITP5FBDO3Xx7WlNq6neJV+amyUc5fpstiL97wioRO
        tG5jqHAIkLv6VPKD/KwE3OaHPD1eM3P6oP/XP0DI4A==
X-Google-Smtp-Source: AGRyM1t2105/RZohN8kgMWpgeBaurKI4vv/4bcOTgcEZKnZijYDbK0YgAyT9ULeE7OSDouvWmAZ7iNiO/Tt1UQtI/sI=
X-Received: by 2002:a81:754:0:b0:314:59e0:ceb7 with SMTP id
 81-20020a810754000000b0031459e0ceb7mr31598433ywh.178.1655779058748; Mon, 20
 Jun 2022 19:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220620092546.8298-1-hdegoede@redhat.com> <20220620092546.8298-3-hdegoede@redhat.com>
 <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com> <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com>
In-Reply-To: <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com>
From:   Daniel Drake <drake@endlessos.org>
Date:   Tue, 21 Jun 2022 10:37:27 +0800
Message-ID: <CAD8Lp464t0NOqR4keodsv2XXq1s_9soFDHEduHZGk1UoP5vFHA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Lv Zheng <lv.zheng@intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 20, 2022 at 10:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
> It is a no-op now because after that commit the acpi_ec struct
> which gets allocated when parsing the ECDT now gets re-used
> when parsing the DSDT if the EC's cmd + data addresses match.

Got it. Seems rather clear indeed.

Can you point out how to check these addresses from dmesg output. We
have several of them saved here from these models, including for some
of the ones you weren't able to find logs for.

Daniel
