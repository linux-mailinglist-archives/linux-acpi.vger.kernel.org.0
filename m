Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA95EFDE8
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Sep 2022 21:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiI2T1g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Sep 2022 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiI2T1f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2022 15:27:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2315444B
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 12:27:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d11so2080724pll.8
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/2GwsSTauJmjYfkTPtC2/6DT6emkrfoGXZJnJAKA7Q4=;
        b=foDx98KEnUwOdRff85G0E13/0WM6bs/iCCF+h2oxTRfhB7Y8cg42aTZN6jyESeGP+M
         SMXoHJxaNBf/dU4aqoq9XMjty27bRq6o4egGu9mjF8HT6/tzgOCXTI19ixxEOtuJv4Hq
         BZNIv06QP3dxoJFec7uxD64LNaJdcxUwDvWos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2GwsSTauJmjYfkTPtC2/6DT6emkrfoGXZJnJAKA7Q4=;
        b=OTMhYHXEVDuXbxZAuBJphUrne9FjgA9W67bGflQ4x0/3yZ+5+bdRmuyJyIqCmXjnYi
         3jHFyxTW/RvpoE8ZKFqM66misBfwjNpGlMF+rOjV4WHC9+rSASCBivAZZoYbjWGx2ohz
         voVcAeA9mrwVZnEsvLhP3X/mmaKBd4HjH/qyaiEtojWQldd9H8Myl/3MrMgGN9F+nCbE
         NKFybUYCzlES3j0xhM1MjwpaeAQHHiWGQlnNaq5H0KhBPuIxQyIFUoiVH4FQ6GPMa9MD
         FuG/2oznBoG88lb6kk2dMMm088ARktx/P+4iCWhTTGoZlnZr8pFAFivAjGmsK4tgZIw3
         tShg==
X-Gm-Message-State: ACrzQf1Ruu20mxTZ7N0kmB3pPbzRc6tzQdMJkCfTom4/jK5tlvR3Or6X
        4sxQjX2+UO6F48ZuqGh4DfxNUtxWbMTHrg==
X-Google-Smtp-Source: AMsMyM5oCqR7YZZ9eIy8oWn5O2lzD8ziRb5u/lHRGkcEh1nrYXy91cUv4kdzA/l8W5GFiW34XmX+Ew==
X-Received: by 2002:a17:902:cf4c:b0:178:90fe:437d with SMTP id e12-20020a170902cf4c00b0017890fe437dmr4854308plg.40.1664479652508;
        Thu, 29 Sep 2022 12:27:32 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id w8-20020a63f508000000b0043b565cb57csm250486pgh.73.2022.09.29.12.27.31
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 12:27:31 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id f193so2336592pgc.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Sep 2022 12:27:31 -0700 (PDT)
X-Received: by 2002:a63:e16:0:b0:43b:d646:1bb7 with SMTP id
 d22-20020a630e16000000b0043bd6461bb7mr4327148pgl.53.1664479651010; Thu, 29
 Sep 2022 12:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220929161917.2348231-1-rrangel@chromium.org>
 <20220929093200.v6.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid> <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
In-Reply-To: <CAJZ5v0izHjb8vE0ALyYo9yMOExdpCzG8f7-d5SpQnftqJfTEig@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 29 Sep 2022 13:27:19 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
Message-ID: <CAHQZ30CJyhPK-OriZ5NZ=GjwNbofaCW6GZ_CvPsL0WiJGsxs-Q@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Terry Bowman <terry.bowman@amd.com>, Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2022 at 1:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 6:19 PM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > ACPI IRQ/Interrupt resources contain a bit that describes if the
> > interrupt should wake the system. This change exposes that bit via
> > a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
>
> I would call this IORESOURCE_IRQ_WAKE which is (a) simpler and easier
> to read and (b) it sort of matches the "wakeirq" naming convention.

It was Dmitry who originally suggested the name. I personally like the
CAPABLE in the name. It makes it clear that it's capable of acting as
a wake source, not to be confused with being enabled as a wake source.

>
> This is not a big deal if you insist on this name and for a good
> reason, but just something I would do differently.
>
> The patch LGTM otherwise.
>
