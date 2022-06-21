Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B0553519
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352119AbiFUPAj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351048AbiFUPAi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 11:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47C4F26558
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655823634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhHMbi/XcvZ90UX8m2jais0+UU6lCzz5EPMlpTHts5A=;
        b=Gp0WadSFBk8kUa2znX5DYWdQQsgmdLgKmff9IuO6Td0SBOPvJk6NfiB6NVfI9tvckrAP6D
        FuIBlvjlg7crX8Ogfc60vmxhAQEkX9dC4+JDyrJB+lHjdkrwACM8zgQn09OAsBE/1fB+Uq
        J40D/Tc8DSV4ubcuFZsW4fwklcDXqmw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-u7bRorQIPXOqoeKhGsSz2w-1; Tue, 21 Jun 2022 11:00:32 -0400
X-MC-Unique: u7bRorQIPXOqoeKhGsSz2w-1
Received: by mail-ej1-f72.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso4981011ejs.12
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 08:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhHMbi/XcvZ90UX8m2jais0+UU6lCzz5EPMlpTHts5A=;
        b=okrd4j7BSBZRNX0fDfa7AR6jSq8LD5ISBbMpO7Xe9lXi7bIKxsXaY6mXsK1I+HUyxM
         0ZVwOY0Z3jEEsNNSD8apuFx/zE0Ft+f+Bn0GalP9xtrjmF/jthBmMSCroa+qlozElVoQ
         kFOgL0R3MBw48FgzbKJNM2wMPrLvKMnR3icx9LNHYbtSElWJNyMTm2WqlQa8J4EBpe0V
         gvdyDzIyIuLP7vRZ5kt/tr1ni4vPKM7K6OOMz+FBGS2dIjawONRr2E+p+GYRQpFFknJp
         YedqInoiLQeYy/qEN9UzGLecbrpPxRai8lPGfbMTRjiX5aN8b8KTVygRTMwce6iw2LzO
         y8Nw==
X-Gm-Message-State: AJIora9oT7zwqLpDbqeAawMv+1jtqm6/4ujhSos/PpzSjfZ2DrTQjNxb
        UgaFHyf6Z5MDQlBXIeW8NAxTtOlrqPDKEcHr4e0H64VnghbAqCY8ApXFl7EWtuPZ3tyHy5vbexs
        S6IMdcSB3tKWH5Is/OCSHnQ==
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id n11-20020a05640205cb00b00434eb48754fmr36691804edx.421.1655823630361;
        Tue, 21 Jun 2022 08:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sBEX5e1/WZsIXET93HkNsa/meiCx0uO8+IVan9B2tlc8Z4Irh7Z+NW/wz9tGt6a/L+VZKs8Q==
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id n11-20020a05640205cb00b00434eb48754fmr36691781edx.421.1655823630204;
        Tue, 21 Jun 2022 08:00:30 -0700 (PDT)
Received: from ?IPV6:2a02:a211:21c2:7e80:eb7f:8817:a74a:9765? ([2a02:a211:21c2:7e80:eb7f:8817:a74a:9765])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0070abf371274sm7758878ejg.136.2022.06.21.08.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 08:00:29 -0700 (PDT)
Message-ID: <12e20755-1084-9893-0813-d20e3586795b@redhat.com>
Date:   Tue, 21 Jun 2022 17:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] ACPI: EC: Drop the EC_FLAGS_IGNORE_DSDT_GPE quirk
Content-Language: en-US
To:     Daniel Drake <drake@endlessos.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Carlo Caione <carlo@caione.org>
References: <20220620092546.8298-1-hdegoede@redhat.com>
 <20220620092546.8298-3-hdegoede@redhat.com>
 <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com>
 <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com>
 <CAD8Lp464t0NOqR4keodsv2XXq1s_9soFDHEduHZGk1UoP5vFHA@mail.gmail.com>
 <08660caa-6c01-73e3-306d-6f85af0f5e04@redhat.com>
 <CAD8Lp466DCY3k0piSJLLxvHXi9Jbd=mdROrnMwVDQtwZDdNMng@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAD8Lp466DCY3k0piSJLLxvHXi9Jbd=mdROrnMwVDQtwZDdNMng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/21/22 14:38, Daniel Drake wrote:
> On Tue, Jun 21, 2022 at 4:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> If you look for "ACPI: EC: " in the dmesg you shoud find 2 blocks
>> of log lines like this (note the output has changed somewhat
>> overtime):
> 
> Got it.
> 
> I was able to verify matching addresses for GL702VMK, X505BA, X505BP,
> X580VD, X542BP.
> 
> I also have logs for FX502VD, FX502VE and X550VX but they only log one
> set of addresses, some kernel version along the way did not log both.
> 
> Don't have logs for X542BA.
> 
> I think this plus the code tracing is overly convincing,
> 
> Reviewed-by: Daniel Drake <drake@endlessos.org>

Thank you.

Regards,

Hans

