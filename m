Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E733D54E004
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jun 2022 13:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiFPL2F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Jun 2022 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376301AbiFPL2E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2022 07:28:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5A42485
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 04:28:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so1725097edm.13
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jun 2022 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFhFRye+5B1ecjABNv2SUQC9YqXo8LQgZLjvUMJN4oQ=;
        b=LbM0QY6J/BZ9YYbZArpSAPXapNOQYzV/BzscPWPjtyp2FePAhSoGTMfGz54nAIrgm/
         O49wgCC5PoQl780T/sCeIHlZLh1cTt/oIpJlH5SGF1uKUiKSRYYYvdTT1oA+67Q+SvLb
         R/IhhUFcTDugXtobIfgHGhKXbaHMWC48nWrHOQUORnWNxW0Xa/H2oAAFb+R/fddYxKxm
         JAZCNNUXKsB4aESeuHx6HSNH6t0ZeJUnhSsPrZcvThzfj6DXWs9nOjK36CdH0cmiBXSL
         i1oJKK/vOUqAZcxjJFg5r1ziozl7qvYSID2xpMb6zL5qweloaBmctLHBu3axGa+TqbMs
         JaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFhFRye+5B1ecjABNv2SUQC9YqXo8LQgZLjvUMJN4oQ=;
        b=W1y1pQrYgFlbCExmicaG9lH4aoto4fnUkWwL3+YqDaVS5iO2FXLlN9eRnfoXWcoY2B
         Bl3mVoTMBE1ybUHevXGPsbq8BGEHIbHanbkv02h2o0ixPSZShgTkpw5uxVtYxim2vHHP
         Xc5Ebhen2Vsj5XznWh2Q4Eq/fQ9DlRUBvWQE/Ckelfxf4aV/pnm6Mew4oHjOf18rCXDc
         BgquBKVno/19kQjUiKAxP0aKMYEhBXIfbYWUf/xVc/CupYVv6oir+Uhj5cDzxM9o1eP5
         EdzADXnnTS9YKuEh1D07kMML2tYpVaua90hD3jW3VnmW9xhhENhUt/i3vXv55cAvxG9c
         bIpw==
X-Gm-Message-State: AJIora/ZZmS13qEY4dM5SR2bqzPUOWPt+EiyATilgSGo1/D/qHabOEQC
        JkOjJ45II1Df5eTiV7uSlbKxi49w2bm0oOBgUAw=
X-Google-Smtp-Source: AGRyM1t1nhtaAw4n7rhbGj5ULOwso59znXtxJabimDdAJxacqeZfjJdADYUqDZkUepacTbs/DYQJVYzbXUXtEtMYzgA=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr5890235edr.209.1655378882039; Thu, 16
 Jun 2022 04:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220615195643.12608-1-hdegoede@redhat.com> <20220615195643.12608-3-hdegoede@redhat.com>
 <CAHp75VcPEw93_3dZvKCadnAqrJCVvdVcKh+DodgBC68xkmJ7VQ@mail.gmail.com> <e1647dae-cde2-868d-458d-ffe969203566@redhat.com>
In-Reply-To: <e1647dae-cde2-868d-458d-ffe969203566@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Jun 2022 13:27:25 +0200
Message-ID: <CAHp75VeD5Ej3jvV=MtAB9fNxgyd8V8Wr+MZZnvbgzy2v3+eJmQ@mail.gmail.com>
Subject: Re: [RFC 2/4] ACPICA: Add \_SB.PC00, \SB.PCI0 to acpi_ns_early_initialize_devices()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 16, 2022 at 11:13 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 6/15/22 23:31, Andy Shevchenko wrote:
> > On Wed, Jun 15, 2022 at 9:57 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> >> -       char path[ACPI_PATH_SEGMENT_LENGTH + 2];
> >> +       char path[ACPI_PATH_SEGMENT_LENGTH * 2 + 2];
> >
> > Strictly speaking this should be, IIUC,
> >
> > 1 + ACPI_PATH_SEGMENT_LENGTH + ACPI_NAMESEG_SIZE + 1
> >
> > \\ + path segment length (with a separator) + name + \0
> >
> > That said, it seems the original code adds 1 unneeded byte.
>
> Right I already knew I needed the " * 2" when writing the
> original code, so I decided to do things this way for KISS
> reasons.

Yeah, but then you don't need + 2, it should be +1.
I believe the initial use of ACPI_PATH_SEGMENT_LENGTH vs.
ACPI_NAMESEG_SIZE is a bit misleading.

> > Perhaps a comment in the code?
>
> I've added a comment to my local version now.
>
> After this thread has had some more time to gather feedback
> I will turn the ACPICA patches into a acpica github pull-req
> with the comment added.
>
> (or if necessary rework the entire series)


-- 
With Best Regards,
Andy Shevchenko
