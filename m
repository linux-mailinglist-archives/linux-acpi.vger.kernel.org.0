Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883E552D27
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jun 2022 10:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbiFUIh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Jun 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiFUIh1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2022 04:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 314A524F24
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 01:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655800645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3bclGG1Xinz1sqUkW5ID2LaEL91l9vsEJSfAbwVsFA=;
        b=HGNTKvtRnbd6FDxZpKKH3rJxZMJMH6eAx8/2Qp9FpXnP8ReKo0LdvuedKjuI0hI23zFr/X
        ORtAElPy0sAmxrCS3huELGe8nhhYKWJ4o94309Q1vHLasf0dyJaNDPrYu/DxUIugDguxdR
        0TkbVH5NhObvK95w5dsJBlGv9zp9I50=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-4A-fSQxqPVqKbUx3xnh53w-1; Tue, 21 Jun 2022 04:37:23 -0400
X-MC-Unique: 4A-fSQxqPVqKbUx3xnh53w-1
Received: by mail-ed1-f70.google.com with SMTP id s15-20020a056402520f00b004327f126170so10467230edd.7
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jun 2022 01:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z3bclGG1Xinz1sqUkW5ID2LaEL91l9vsEJSfAbwVsFA=;
        b=b6k6Q+9c6NbnVQhO1qpK6wT1eRgQcqU5Vy3TjEWrqtoTVQRSHsCy83FKa0eqou96b7
         hjffe/aVrsPs7nxtydlrx660/8Z9V+so++h0YEFN/cqGGvGrEBWvsCVtEO1MjrMqV8w/
         eJ9IHLiWRIvD7BvmLqJVDwtZzUL9QGjxIzhPNxbu5L6V9dTaoojwq0K0wc0Ojd8oW+zb
         b+VWgjy0k2svwYQTDkxurIbHy3Jthx4pH9ZZhA+mjEnWkIglEjeDeIDJaRQtyRcCiB8h
         FY4FmW/uFYSR4FFKq1jboAJL583VbTWxBOc9t+0NFsEVToi6uGBMhAraUbA3sxF/LrLC
         2Qmg==
X-Gm-Message-State: AJIora+VJOaHFtkmFp7ZF/b79jduvSY0NscmmcvtBbY5Yi/8ulicl4FX
        wMZS6IwEiOn5Vaa9WSPOWXVTyoWixZtrcYpMcLfNWgjCds2UxCn3udQMVsk5JxiXsYQrNtTZwub
        o1gwb8g6caZaafRVLp2nKyQ==
X-Received: by 2002:a17:907:9719:b0:722:e6cf:128 with SMTP id jg25-20020a170907971900b00722e6cf0128mr659521ejc.98.1655800642463;
        Tue, 21 Jun 2022 01:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiwA6r9scfdOipaRasUuUq6yUH4JY0eQxriJLTxoqFooJuLQR8l4NCdUEjxcB+QZVofyQZFg==
X-Received: by 2002:a17:907:9719:b0:722:e6cf:128 with SMTP id jg25-20020a170907971900b00722e6cf0128mr659508ejc.98.1655800642267;
        Tue, 21 Jun 2022 01:37:22 -0700 (PDT)
Received: from ?IPV6:2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a? (2001-1c01-2e0c-ab03-79ba-9443-520f-dd0a.cable.dynamic.v6.ziggo.nl. [2001:1c01:2e0c:ab03:79ba:9443:520f:dd0a])
        by smtp.gmail.com with ESMTPSA id qn25-20020a170907211900b00722e49c06e8sm696279ejb.216.2022.06.21.01.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:37:21 -0700 (PDT)
Message-ID: <08660caa-6c01-73e3-306d-6f85af0f5e04@redhat.com>
Date:   Tue, 21 Jun 2022 10:37:15 +0200
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
        devel@acpica.org, Lv Zheng <lv.zheng@intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Carlo Caione <carlo@caione.org>
References: <20220620092546.8298-1-hdegoede@redhat.com>
 <20220620092546.8298-3-hdegoede@redhat.com>
 <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com>
 <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com>
 <CAD8Lp464t0NOqR4keodsv2XXq1s_9soFDHEduHZGk1UoP5vFHA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAD8Lp464t0NOqR4keodsv2XXq1s_9soFDHEduHZGk1UoP5vFHA@mail.gmail.com>
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

On 6/21/22 04:37, Daniel Drake wrote:
> On Mon, Jun 20, 2022 at 10:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> It is a no-op now because after that commit the acpi_ec struct
>> which gets allocated when parsing the ECDT now gets re-used
>> when parsing the DSDT if the EC's cmd + data addresses match.
> 
> Got it. Seems rather clear indeed.
> 
> Can you point out how to check these addresses from dmesg output. We
> have several of them saved here from these models, including for some
> of the ones you weren't able to find logs for.

If you look for "ACPI: EC: " in the dmesg you shoud find 2 blocks
of log lines like this (note the output has changed somewhat
overtime):

[    0.642373] ACPI: EC: EC started
[    0.642375] ACPI: EC: interrupt blocked
[    0.651140] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.651142] ACPI: EC: Boot ECDT EC used to handle transactions

[    1.191469] ACPI: EC: interrupt unblocked
[    1.191471] ACPI: EC: event unblocked
[    1.191491] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.191493] ACPI: EC: GPE=0x16
[    1.191496] ACPI: \_SB_.PCI0.LPCB.EC__: Boot ECDT EC initialization complete
[    1.191501] ACPI: \_SB_.PCI0.LPCB.EC__: EC: Used to handle transactions and events

The first block is the ECDT probing, the second one is the DSDT probing
and the addresses are in the:

[    0.651140] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62

lines.

Regards,

Hans

