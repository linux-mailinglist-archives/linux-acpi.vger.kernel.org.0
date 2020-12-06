Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA002CFFDC
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Dec 2020 01:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgLFABf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Dec 2020 19:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLFABf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Dec 2020 19:01:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E0CC0613CF
        for <linux-acpi@vger.kernel.org>; Sat,  5 Dec 2020 16:00:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k14so9002390wrn.1
        for <linux-acpi@vger.kernel.org>; Sat, 05 Dec 2020 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LX0q8W/7CYmsB/s640o/f2MYu/a+KH6opSBdlTFtvsg=;
        b=mE3RwKrbhXM4WH9wuWWjrGvUTOkpdDLmcE0UH9Iu0SDON4KnFFXWmXB4f5590eXl/a
         qNXRMQLEiN904t/KeefJsiRKVmXanUcbUPEoHJcpiZCGABEniUN58ZJ5xymZsLllhasb
         iprhkSXJ5egP4wVaSxOJJLbSK8ksaM0bm+n39+y6ymXpEiA/QLuYajKcPhMDtkQ5F6tb
         cce/50a64rzORFuVakFncReCfY22BG8zKbV7spdBaDlVF6zEimG7yArNN/ZDBNi52KBL
         eMW6zPhWLcqBll7a+sM8F7chAP8PuW5/R2ASoJWEPLyintGR897HCsKyd+P8LqKMBCaK
         xqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LX0q8W/7CYmsB/s640o/f2MYu/a+KH6opSBdlTFtvsg=;
        b=DnW041KfR/ib24Xlc3TWOen7OrK/Te6jSv55NkDh7hT9TeiXNkFoQBNd/WMnnO4p8I
         YQUFGqbKwcQBZU7SMtxMJLHbusBs7bhAN7eotJjboBpIUYI6s8mLNI3KnEp6k7YY4cxt
         fK4qBBg9vuvTOigaRDPvgufusOxxhdmeYuANvKf4juqDhd6HMnAKYXtjkFVbAiwBePbx
         +VN3M/O/j+0oED3wb4YrVzmF8K04bWFqG8Rk93DTx1K0kid90V0U14EI1S8o2OjnSg8H
         ff+d2GaQA/OoeiN7reZg9lX6Kjc6sAqppv65jina4zB5XqKQJDdvbQAWmJ+dZsxHF1m+
         ipeg==
X-Gm-Message-State: AOAM530vZh3e1Tvm/aQ+JaH3QI0dkdqkrPLW3DoDoYtYp1mn033XTQkI
        erhEqKsOdLuQ8EyZz4xerMQ=
X-Google-Smtp-Source: ABdhPJwBI74OMRkTmvbd0KPVnQxx80GVTwczMABa7TygGC0y6VLaTU1JSvLkUIW/90DKohZbYj8twA==
X-Received: by 2002:adf:f1d2:: with SMTP id z18mr12894043wro.244.1607212853852;
        Sat, 05 Dec 2020 16:00:53 -0800 (PST)
Received: from [192.168.1.211] ([2.31.225.57])
        by smtp.gmail.com with ESMTPSA id q25sm10141969wmq.37.2020.12.05.16.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 16:00:53 -0800 (PST)
X-Mozilla-News-Host: news://nntp.lore.kernel.org:119
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org
From:   Daniel Scally <djrscally@gmail.com>
Cc:     linux-acpi@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: acpi_device_notify() binding devices that don't seem like they should
 be bound
Message-ID: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
Date:   Sun, 6 Dec 2020 00:00:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Len, Rafael

I'm having some trouble with how the kernel is treating some ACPI
devices, and I'm hoping for some help.

For reference, the DSDT tables for everything I'm talking about below
can be found here. The device in question is a Lenovo Miix 510:

https://gist.githubusercontent.com/djrscally/e64d112180517352fa3392878b0f4a7d/raw/88b90b3ea4204fd7845257b6666fdade47cc2981/dsdt.dsl

So the problem goes like this; we have a bunch of devices with _HID
"INT3472" in those tables. Most of them have _STA=0, but 2 have _STA=15.
I expect both of these devices (INT3472:08 and INT3472:09) to be created
as platform_devices as well as acpi_devices by the kernel, however it
turns out that only INT3472:09 gets a platform_device, :08 doesn't.

The reason :08 gets no platform_device is that by the time
acpi_create_platform_device() is ran for it, it's already gotten a
physical_node. This comes from acpi_bind_one() binding the INT3472:08
acpi_device to a pci device named 0000:00:00.0 during
acpi_device_notify(). The flow goes like this:

acpi_device_notify(0000:00:00.0)
 -> acpi_pci_find_companion(0000:00:00.0)
     -> acpi_find_child_device(PNP0A08:00, 0, false)
	 -> return INT3472:08

The jump to PNP0A08:00 there is acpi_find_companion() fetching the
ACPI_COMPANION() for 0000:00:00.0's _parent_ device, named pci0000:00.
This isn't behaviour that strikes me as particularly desirable.
INT3472:08 is not an acpi device that seems to be a good candidate for
binding to 0000:00:00.0; it just happens to be the first child of
PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.

The comment within acpi_find_child_device() does imply that there should
only ever be a single child device with the same _ADR as the parent, so
I suppose this is possibly a case of poor ACPI tables confusing the code
a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
set to zero (as indeed do the machine's cameras), but I'm not
knowledgeable enough on ACPI to know whether that's to spec (or at least
accounted for). The INT3472 devices themselves do not actually seem to
represent a physical device (atleast, not in this case...sometimes they
do...), rather they're a dummy being used to simply group some GPIO
lines under a common _CRS. The sensors are called out as dependent on
these "devices" in their _DEP method, which is already a horrible way of
doing things so more broken ACPI being to blame wouldn't surprise me.

The other problem that that raises is that there seems to be _no_ good
candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
entries and the machine's cameras.

Any advice on how to go about rectifying this would be very much
appreciated.

Thanks
Dan
