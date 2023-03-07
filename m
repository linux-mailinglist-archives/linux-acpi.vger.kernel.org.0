Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D86AE03F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 14:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCGNUN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 7 Mar 2023 08:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCGNTu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 08:19:50 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6E4E5DE
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 05:19:06 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id ec29so21274444edb.6
        for <linux-acpi@vger.kernel.org>; Tue, 07 Mar 2023 05:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFkqgBIKONRKBd87rtkxImCMW+GSjICF8co1ANeAkVI=;
        b=h4I7g55l8PeeYOdlsZivIzrTuEbZSrF7YYChjaEGRu2djWvu1EZlEQpHzozL1iOKps
         NLRr7xIVIod7zeZBms3RBJsp8agdgTkLYE9uIkC09NeGirjXUpHzjjNcBuIBHQHHYJ9n
         nZ5oVKTf/fejCJnfrCAljN/4wCFpFJTq5CGOXbBZiY7JgRV/Muto9MO3lRdoITj6dbGQ
         SIxQFAEIaAq/muiYGI+b3lJA79Svc7PrHJsF70Tc33xDn4QCrcxBdFFhdYC+icFtZkt/
         k3q8neSQz0grQFUgmdd/n/yszrd8x2MBoSsJdSTJh1x9ajfp91nWIScHUQjiTblaMTSS
         fKAg==
X-Gm-Message-State: AO0yUKXD++QVVk0PZvBVDBXwCAfroy0h3ozD3Jg49fSAuH31rfRLVacb
        OZOJzSkDirns1G3xYdvZYLmHwzU/C5VCps1M8RhQBYzFJEg=
X-Google-Smtp-Source: AK7set98oMDmX78mdJ/9Ma+GMq6niXjOGwtnwujvS6iz/XhSpb/kIVnUVA7m/POtfnXJey6ZPAYbwZyMD+wlJbTtJoM=
X-Received: by 2002:a17:906:64d:b0:8d1:57cf:ef3c with SMTP id
 t13-20020a170906064d00b008d157cfef3cmr6832748ejb.2.1678195145134; Tue, 07 Mar
 2023 05:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20230301100436.132521-1-hdegoede@redhat.com>
In-Reply-To: <20230301100436.132521-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 14:18:54 +0100
Message-ID: <CAJZ5v0iddxVg=P59E4iFoo1ZG8+oBd6YBT2m5M_KJZHaGEj-yQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers()
 + 2 quirks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 1, 2023 at 11:04 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> Here is v2 (more of a resend really) of my patch series to allow
> the existing quirk mechanism in drivers/acpi/x86/utils.c to
> disable ACPI GPIO event handlers on systems where these are totally
> broken (typically systems which use Android as factory OS with a
> heavily patched linux kernel).
>
> New in this version of the series is the addition of a second new quirk
> using this.

Series applied (with the ACK from Andy) as 6.3-rc material, thanks!
