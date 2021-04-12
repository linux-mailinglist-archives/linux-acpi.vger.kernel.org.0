Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36C35CF90
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhDLRii (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 13:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238649AbhDLRii (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Apr 2021 13:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618249099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HvxCWWDp+tM/I1EuiT9miErirEPrFUQybDt2tk/71To=;
        b=VQ+RC++a3t4BbK1kGi50FVAw6G6qXY9x81y1rFBdTNTofUx/rKlWvPm+osTI0eWYZkpmMd
        bO/HbHJGm4O75pMEFUvUAykz3rynaYvgZMgwd7ZdHhnRt8fyeunKHN49o9P/urvCha/+zb
        U23ybnU8MjBKbYHJKzuHVgbTlV4Bhw4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-bfL4nalOPjKRIVdxUa0dUQ-1; Mon, 12 Apr 2021 13:38:17 -0400
X-MC-Unique: bfL4nalOPjKRIVdxUa0dUQ-1
Received: by mail-ed1-f72.google.com with SMTP id l11so3627353edb.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Apr 2021 10:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HvxCWWDp+tM/I1EuiT9miErirEPrFUQybDt2tk/71To=;
        b=ae+a1jjvjSsVSXqHh+D7uR4UTRS0uL4KGJs7Mjt9tC7LFzovOfzwDufYSCymxGI9Ou
         7sraqRL5wgWt+NdiuApLzavVVYXzSd85oOXRaBYGN9yvvZdOakejTjNMwHdzxTg3ZqwY
         lrZTOlNw2nJS1iCpNf2fdGx6Zs4EAfA7Uy3pgjj9keKeBZtigDneJep/4FB13369lk5d
         UbQwJNOFYodcml9YtR1NQ2LT9UEkX4CT6xMjpEfEKnon7IWwhiQ5uNQ3sRA4Tdw30wQA
         VK0y8agJsZi1NAd8Lv7jEqsllhf0aenY0MxN8hTG1UKDDEUZmKUe4XtAeQ4fmjiJdeL7
         IuYA==
X-Gm-Message-State: AOAM532ow9VSrELNzoZInRwRV4DxOMnBh6eTcv76cGivc/rLTvMT69Es
        Z80FfmEb3XcCX3H9lCV3WT1n8GDMIh7feTJdde0T9IfIAUxiRaeCjj4PvH0pkDVDalKVCPEtfs5
        +/UNNZNSUCtqnwLK5UqGjCFsIZ/jiXJgbjZST+0jM2iYLlQE3PrPewn3Fpb00WhQ1jknnnxsWZw
        ==
X-Received: by 2002:a17:906:1e8e:: with SMTP id e14mr28758526ejj.399.1618249096147;
        Mon, 12 Apr 2021 10:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1p06avQLGBnMn5oOT51kvohbsCgHtHOnbdZ5D99aNcjxjMp6XbJj2hlFe2WJ5nR8V/FnT1A==
X-Received: by 2002:a17:906:1e8e:: with SMTP id e14mr28758512ejj.399.1618249095959;
        Mon, 12 Apr 2021 10:38:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x9sm7265206edv.22.2021.04.12.10.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 10:38:15 -0700 (PDT)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [5.12 regression] DSDT overriding from initrd no longer works
Message-ID: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com>
Date:   Mon, 12 Apr 2021 19:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

Sorry about the timing of reporting this regression.

I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
this is caused by:

commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")

This makes the initial acpi_locate_initial_tables() call happen earlier
then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
not moved up, so the tables in the initrd are now only parsed and saved
after the initial ACPI table scanning has already been done.

I guess fixing this might be as easy as moving the acpi_table_upgrade) call
higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.

I've several devices with ACPI tables which are so broken that they need
an override. I've reverted the commit from my personal tree for now which
avoids the regression.

Regards,

Hans

