Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20A6475AB
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 19:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLHSfV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 13:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLHSfP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 13:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85926511ED
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670524436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCIG329yX9Oxb7r754RzmGzuN+6eq3Xm04xVUdanQoI=;
        b=byXopbxWtedv+Np0iGsAgvhOXfSv4Rk4NW2rKNObpL1V1xufm6u5GytAY6jXQewmxWX3PI
        v4cWkT23qg/NXar1p5yGhLBhp7KgJ3Z8mkkwk9Ryzt99FGJS1BVFR8J98TUpfq0HeHnzij
        YaC2eltfHVxBK8P5niu0PSM7VLhI7qc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-N34YOluBPICB0TBCuoDqQg-1; Thu, 08 Dec 2022 13:33:55 -0500
X-MC-Unique: N34YOluBPICB0TBCuoDqQg-1
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a056402274300b0046b14f99390so1398610edd.9
        for <linux-acpi@vger.kernel.org>; Thu, 08 Dec 2022 10:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCIG329yX9Oxb7r754RzmGzuN+6eq3Xm04xVUdanQoI=;
        b=nGh6PsTBCISbvCff0AYTcrbh7H2FYkKD+9pgG9zHOu50J0cIBxLeZw1IV87wTpLcvr
         nyhJr29IcM4WSpvOY7cG+cB03KNg1usf+OuzdHlSDmIvkqYMhdyHuQgMRH1+1Q6UR+pJ
         DNDLF4ZejYf2FoUY0dvCo/sdaQHAjQrKBQJH2NXd9tkVP2ZY3Khafo54+MTEap/KToms
         oQkWzyNlk47AcRc0bknoMywQ/ERk25s7SCKUW6A8VLvj+kv/vpbU9US2bm/67mf7GNtb
         ZpweVdCrxBdog75H1mTIPG5+EbW1S56Z1HohPBoIpyRZC+VqumFI3cshJHAwmAGrjWPq
         1yDw==
X-Gm-Message-State: ANoB5pmgsKi/3D4T3XYj5m/PBtoiR0zvGtCNA0RgMf5kKAuOZGTCubk1
        swkkBPZNwDOs+JFgd7Rz/wdnNwbtoXp0w8m/RX67/6RB/idcpnRlSFmKmKfb96xqHd9VMn4lViH
        NeSmMgCVOopbieh8b/Y2TDg==
X-Received: by 2002:a17:906:15cf:b0:78d:f454:378a with SMTP id l15-20020a17090615cf00b0078df454378amr2350004ejd.45.1670524433916;
        Thu, 08 Dec 2022 10:33:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vNK3UwsAZQshgrNOKPMir8vleG8jbdL+Iit2lT5FiNc8fux5nHprcNRVnuNziRaQ16qrUYg==
X-Received: by 2002:a17:906:15cf:b0:78d:f454:378a with SMTP id l15-20020a17090615cf00b0078df454378amr2349995ejd.45.1670524433764;
        Thu, 08 Dec 2022 10:33:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id op4-20020a170906bce400b0078df3b4464fsm10178189ejb.19.2022.12.08.10.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 10:33:53 -0800 (PST)
Message-ID: <c5acd35b-3bdb-c56e-f398-6d8bd33ba2ef@redhat.com>
Date:   Thu, 8 Dec 2022 19:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] ACPI[CA]: fix ECDT EC probe ordering issues
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?Q?Johannes_Pen=c3=9fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
References: <20221208142335.488382-1-hdegoede@redhat.com>
 <CAJZ5v0jA1cv5wuuouMkM1GsV3Chu+RSxBC7qH7YtDTVa4DGSOw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jA1cv5wuuouMkM1GsV3Chu+RSxBC7qH7YtDTVa4DGSOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/8/22 17:51, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Thu, Dec 8, 2022 at 3:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> As you requested in:
>> https://github.com/acpica/acpica/pull/786#issuecomment-1342632326
>>
>> Here is a non RFC version of my series fixing some ECDT EC probe
>> ordering issues which are causing issues om some laptops:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=214899
>>
>> including the ACPICA changes.
>>
>> This series is rebased on top of linux-pm/bleeding-edge,
>> otherwise it is unchanged from the previous [RFC v3] version.
>>
>> From the original cover-letter of the previous [RFC v3] version:
>>
>> The problem this fixed is best described by the commit message of patch 4:
>>
>> ACPI-2.0 says that the EC OpRegion handler must be available immediately
>> (like the standard default OpRegion handlers):
>>
>> Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
>> 2. OSPM must make Embedded Controller operation regions, accessed via
>> the Embedded Controllers described in ECDT, available before executing
>> any control method. These operation regions may become inaccessible
>> after OSPM runs _REG(EmbeddedControl, 0)."
>>
>> So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
>> acpi_install_address_space_handler() to install the EC's OpRegion
>> handler, early on.
>>
>> This not only installs the OpRegion handler, but also calls the EC's
>> _REG method. The _REG method call is a problem because it may rely on
>> initialization done by the _INI methods of one of the PCI / _SB root devs,
>> see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .
>>
>> Generally speaking _REG methods are executed when the ACPI-device they
>> are part of has a driver bound to it. Where as _INI methods must be
>> executed at table load time (according to the spec). The problem here
>> is that the early acpi_install_address_space_handler() call causes
>> the _REG handler to run too early.
>>
>> To allow fixing this the ACPICA code now allows to split the OpRegion
>> handler installation and the executing of _REG into 2 separate steps.
>>
>> This commit uses this ACPICA functionality to fix the EC probe ordering
>> by delaying the executing of _REG for ECDT described ECs till the matching
>> EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
>> This moves the calling of _REG for the EC on devices with an ECDT to
>> the same point in time where it is called on devices without an ECDT table.
>>
>> Changes in v3:
>> - Add a prep patch to fix an indentation issue in Linux' acpixf.h to fix
>>   the patch from ACPICA's script not applying
>> - Add 2 new functions to ACPICA for this instead of a flags argument
>>   1. acpi_install_address_space_handler_no_reg()
>>   2. acpi_execute_reg_methods()
>> - Add a patch to fix EC handler removal in the ECDT case
> 
> I've applied the series and queued it up for 6.2.
> 
> However, because I won't be able to do any kernel work before the next
> week (most likely), it will not go into linux-next before Monday and I
> would like it to spend at least a few days in it. This means that it
> will be pushed in the second half of the merge window.

Second half of the merge window is perfectly fine with me. Thank you
for picking this up.

Regards,

Hans


