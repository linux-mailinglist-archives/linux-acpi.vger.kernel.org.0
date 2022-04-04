Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601E4F1D15
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Apr 2022 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382458AbiDDVaC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Apr 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380578AbiDDUcN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2022 16:32:13 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B483387AD;
        Mon,  4 Apr 2022 13:30:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C96B78E084F;
        Mon,  4 Apr 2022 20:30:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0578D8E0723;
        Mon,  4 Apr 2022 20:30:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649104212; a=rsa-sha256;
        cv=none;
        b=ytDKJAWGnXLvlvlxFi9Kh3C1avNb2ST77BxkbQl+b+35IS5B4e/l+lSi4jvG/zU6ESH+mx
        JFeRkD/A1kDrzwD3SZb0N5ZpGijQ5DYgwDvmLQXfJD4CUpISqY5mugo9sTZwzVIx82K0Cm
        td3V5EmBygtIz6jv8BXb4kU+TQhJgAs4gpNv3NEAf6hahVLRYkNaYIEpZ0J/cG48wM6DsC
        D+dPU7T6/BqugyRJeBOzGKatAFBVIzHxk2OV5HqYVcS/GPG5B3hrYP36SZq+637MTpG+cH
        n9BTOouTLUeVzSBGKeoZQC5r3PowNhpOgmhZ3uBZ7eTSffVbHv0tXbTu0w2yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649104212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9LI+subktCWSE4eEv6xpkrrptry9AUobNq6AoXjS2qw=;
        b=ZRiyjdxgp2HT4uRJilHeTxGKmATvKHzFgKykC1yXS609+/FlIlaCeLoIh/SyceN74mxjLn
        Hit53m2sU34RPOLjqfdc/dB638E6peUOLazLsqDBI1rhFDS2oaiA4IyBR9AdxyTL/VVs2J
        U4KtiCeRQ2bf5+ID8WLoRmartDVxldcOZJqyOECQXkCfLx2pq/AuxUax50QiC0W+RnlqQK
        ydj58+cMk2BDtXoDks097vkzOC2s6tgPEOCHQ9Z4/w9J2d8klOAiFdKajCzI1o249gcByZ
        A/31U93OrcvejJOtFXEtjQYDu1DEtUvkeOqxW8AnAvMLICqEnM39f2EGXR7VHQ==
ARC-Authentication-Results: i=1;
        rspamd-f76767c84-4xpxg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.158.145 (trex/6.7.1);
        Mon, 04 Apr 2022 20:30:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Illustrious: 3400d08057b3e5fc_1649104212449_1787379020
X-MC-Loop-Signature: 1649104212449:3528900814
X-MC-Ingress-Time: 1649104212449
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4KXMpT5Zq4z1q;
        Mon,  4 Apr 2022 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649104211;
        bh=9LI+subktCWSE4eEv6xpkrrptry9AUobNq6AoXjS2qw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=DyR68C9mlfEtLToG2NNpsA+qPBA2ZNn6vsel9d7k5U41zrw8ay6tWpB8KAJQsdJK1
         GLYJmfsjR/v/TbJLbfivZ/RrIVb9nFKmhZtY9Vu0glUgeVv6NUWb/pL0xWlI7t4a4k
         7Ic6y+bpwsELJwZy17CyIN3vILrl7SZQ57P+FQICW87KPhnQ9M8yEeUGq7uWPEiYXE
         l3H99+hDRzanNYew+/O9T6s3gfIhTZEYu6DvwteLeHLRkuRNRLZE7GD8KwWm8kMg99
         u2zTPu+6g47sDDv0W0gKBOyAlSjza+05JwzddOSeavF73g1Sr9Qw6CrQI/NeNnVHWI
         4HqbyX1sM2QwA==
Date:   Mon, 4 Apr 2022 13:30:05 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, a.manzanares@samsung.com
Subject: Re: [PATCH v4 3/3] PCI/ACPI: negotiate CXL _OSC
Message-ID: <20220404203005.wnee6i3aovvchpcr@offworld>
References: <20220331202022.1823174-1-vishal.l.verma@intel.com>
 <20220331202022.1823174-4-vishal.l.verma@intel.com>
 <20220401204014.khgozoeu6biirknu@offworld>
 <CAPcyv4iGtgO6tqLV_UjOsORmC0q-Kw0y5yvstXd=OO8vQ=9XoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4iGtgO6tqLV_UjOsORmC0q-Kw0y5yvstXd=OO8vQ=9XoQ@mail.gmail.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 01 Apr 2022, Dan Williams wrote:

>On Fri, Apr 1, 2022 at 1:40 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> On Thu, 31 Mar 2022, Vishal Verma wrote:
>>
>> >The CXL specification does not define any additional constraints on
>> >the hotplug flow beyond PCIe native hotplug, so a kernel that supports
>> >native PCIe hotplug, supports CXL hotplug.
>>
>> Hmm but from a Linux-pov does it make sense to allow hotplug
>> support if the MM cannot handle it?
>
>I would say yes, i.e. do not consider CONFIG_MEMORY_HOTPLUG for
>OSC_CXL_NATIVE_HP_SUPPORT, but see below and poke holes in my
>argument...
>
>>
>> @@ -531,7 +518,8 @@ static u32 calculate_cxl_support(void)
>>         support = OSC_CXL_2_0_PORT_DEV_REG_ACCESS_SUPPORT;
>>         if (pci_aer_available())
>>                 support |= OSC_CXL_PROTOCOL_ERR_REPORTING_SUPPORT;
>> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
>> +           IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>>                 support |= OSC_CXL_NATIVE_HP_SUPPORT;
>>
>>         return support;
>>
>> After all, per the CXL 2.0 Type 3 device Hot-Add flow:
>>
>> ""
>> 7. CXL aware software notifies OS memory manager about the new memory and its
>> attributes such as latency and bandwidth. Memory manager processes a request
>> and adds the new memory to its allocation pool.
>> ""
>
>If I look at ACPI hotplug it is true that CONFIG_ACPI_HOTPLUG_MEMORY
>depends on CONFIG_MEMORY_HOTPLUG. However, it is also true that there
>is no existing _OSC for memory hotplug support. The reason is that
>ACPI memory hotplug requires the OS to acknowledge / coordinate with
>memory plug events via a scan handler. On the CXL side the equivalent
>would be if Linux supported the Mechanical Retention Lock [1], or
>otherwise had some coordination for the driver of a PCI device
>undergoing hotplug to be consulted on whether the hotplug should
>proceed or not.
>
>The concern is that if Linux says no to supporting CXL hotplug then
>the BIOS may say no to giving the OS hotplug control of any other PCIe
>device. So the question here is not whether hotplug is enabled, it's
>whether it is handled natively by the at all OS, and if
>CONFIG_HOTPLUG_PCI_PCIE is enabled then the answer is "yes".
>
>Otherwise, the plan for CXL coordinated remove, since the kernel does
>not support blocking hotplug, is to require the memory device to be
>disabled before hotplug is attempted. When CONFIG_MEMORY_HOTPLUG is
>disabled that step will fail and the remove attempt cancelled. by the
>user. If that is not honored and the card is removed anyway then it
>does not matter if CONFIG_MEMORY_HOTPLUG is enabled or not, it will
>cause a crash and other badness.
>
>Long story short, just say yes, to CXL hotplug and require removal to
>be coordinated by userspace unless and until the kernel grows better
>mechanisms for doing "managed" removal of devices in consultation with
>the driver.

+Cc Adam.

Thank you for the overview of the landscape; I was assuming this last
part already existed. I would only suggest documenting the above in
calculate_cxl_support(), such that future readers don't also wonder
about this and why CXL doesn't follow what CONFIG_ACPI_HOTPLUG_MEMORY
does.

Thanks,
Davidlohr

>
>[1]: https://lore.kernel.org/all/20201122014203.4706-1-ashok.raj@intel.com/
