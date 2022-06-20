Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56674551FA8
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiFTPDW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbiFTPDM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 11:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C2F2B255
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655735601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZEKAY2GGhOuRw66r1V3hBnlbCKh6JZDPOisgvEphIw=;
        b=Vnhi2WyOibu2bKDoWsGusQfDYBbPPGEbweVQfGLe7QNvF5P4X5XZIxCa8z9lriHwjHOx6l
        dZwS61gO9EeZGD4eMDXg7p2hU5zqSfwjBoVR7OlHCyk8yWdjzNZx77byU0ahKD1GRLcjlY
        5wVTE5Lw4zKv3xhGr13OWXWPN5y2XJk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-Hif_LVdXM82pw1io1DZqdw-1; Mon, 20 Jun 2022 10:33:20 -0400
X-MC-Unique: Hif_LVdXM82pw1io1DZqdw-1
Received: by mail-ed1-f69.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso8818341eda.23
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 07:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NZEKAY2GGhOuRw66r1V3hBnlbCKh6JZDPOisgvEphIw=;
        b=ioveF4UxHNfcItLD+dNTgWkkDRJlTnB2au6AvNxOyQTm/NxkAtrWrzVl6IgzeAHXJn
         1f5BGnhr/tOGe+ijkB0XrxdPfJDMYDTGqE5mBFcbmHyPbvzrALp11D/tUPTZe+3jtpAt
         KYZEQIhbMEUVYF2v8vy40EfnUpHvOBCBtsZzMS2qK1E+kU4Ou6haEAL/E6+i4fpPWcOj
         vIH7BCIFsIb5wLnJ+Zn3QKiFptHKJpL73kZyk70C62jbYFqLYnKEMjFwQFe8wA9s8e4f
         w0poH3VWQ754KopA9F2m8xdzvVChAruTybA6sNrEdloTqDOLzTeP3FG90OHMQK1TAkCl
         1NgA==
X-Gm-Message-State: AJIora/N/CTG5f5QzIn81RfsaD8X1gqmyttljPDpPfwi75LITwRxBrZ8
        9p8kyja9SYbd8YsWHyzb7/wAV+tZXDoIC/L6mHvxScy003Gh1hBP1ffB8xNfp3IhklWEBXvsW2i
        ROtZ3i+2VWLfT5t4FQaynCQ==
X-Received: by 2002:a05:6402:51d3:b0:431:6c7b:c35 with SMTP id r19-20020a05640251d300b004316c7b0c35mr30413671edd.28.1655735598999;
        Mon, 20 Jun 2022 07:33:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcxT+KH7RtnHCZ9KdXiEfKheSE4uLLpoKMBbIDfv6DAHNER0Is80zeDp/VwUQYW3OW4TOl/A==
X-Received: by 2002:a05:6402:51d3:b0:431:6c7b:c35 with SMTP id r19-20020a05640251d300b004316c7b0c35mr30413645edd.28.1655735598768;
        Mon, 20 Jun 2022 07:33:18 -0700 (PDT)
Received: from [10.0.0.147] (D57D5A4B.static.ziggozakelijk.nl. [213.125.90.75])
        by smtp.gmail.com with ESMTPSA id a24-20020aa7cf18000000b004356c18b2b9sm6287475edy.44.2022.06.20.07.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 07:33:18 -0700 (PDT)
Message-ID: <b2ad4b62-89bc-48c5-ebc3-c9d8f86aa902@redhat.com>
Date:   Mon, 20 Jun 2022 16:33:17 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAD8Lp45ismm5yG2ajGH_h=BKLh6hs8yC7gy3jq1Kn1pst0AFKg@mail.gmail.com>
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

On 6/20/22 12:47, Daniel Drake wrote:
> Hi Hans,
> 
> Thanks for looking at this.
> 
> On Mon, Jun 20, 2022 at 5:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> Which leaves commit 6306f0431914 ("ACPI: EC: Make more Asus laptops
>> use ECDT _GPE"), which was committed way after the generic fix.
>> But this was just due to slow upstreaming of it. This commit stems
>> from Endless from 15 Aug 2017 (committed upstream 20 May 2021):
>> https://github.com/endlessm/linux/pull/288
>>
>> The current code should work fine without this:
> 
> Your explanation of the code flow seems clear and logical, but I have
> not checked the details. This is a bit of a tricky issue as you have
> probably seen from history, we went in a couple of wrong directions
> before we spotted the real cause.
> 
> The one thing I don't see clearly in your explanation (which I may
> have read too quickly) is how the generic fix 69b957c26b32 is
> responsible for making this a "no-op" code flow now.

It is a no-op now because after that commit the acpi_ec struct
which gets allocated when parsing the ECDT now gets re-used
when parsing the DSDT if the EC's cmd + data addresses match.

When we enter the if for re-using that boot_ec acpi_ec struct then
only boot_ec->handle is re-used; and we keep boot_ec->gpe to the
value set when parsing the ECDT.

The quirk does:

ec->gpe is boot_ec->gpe, but since we throw ec away now
(after taking ec->handle) and reuse boot_ec->gpe we will end
up using boot_ec->gpe just as the quirk caused us to do before
we started re-using the boot_ec acpi_ec struct.

Regards,

Hans

