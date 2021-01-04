Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C32E9F95
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jan 2021 22:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbhADVdl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jan 2021 16:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbhADVdl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2021 16:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609795934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U+Y4Pd1ueAFeOxFwMjWzVyK9EP+L8BxTKFSE68n3NXE=;
        b=GuGFNPbDWePvYATxL6GJb/a11Lc9FdZm1e5ZQZyhrrx6/8W3Pnqu0zLoWqHTwelS9x5CPe
        7NG3d6gIHjKqLbjVWIq7Wlk22FGtXIIeBGI2wdAfShXsLZryF+34j+QBgNDwNzu659ywnl
        cCTXCSKxQjBvXirslXcAZPiykJghQcM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-YxrjIFcXMCOygcPPUYvhqg-1; Mon, 04 Jan 2021 16:32:13 -0500
X-MC-Unique: YxrjIFcXMCOygcPPUYvhqg-1
Received: by mail-ej1-f69.google.com with SMTP id m11so7382355ejr.20
        for <linux-acpi@vger.kernel.org>; Mon, 04 Jan 2021 13:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=U+Y4Pd1ueAFeOxFwMjWzVyK9EP+L8BxTKFSE68n3NXE=;
        b=fydz4R2yd9CqxsyfRG910STc3i8hPqD17wSCRtwhdSr7SIDR+sRD3DGZR8Ta4YE1Vj
         fe0lYDQtK7YWOWcOkmBD96CiHSDH9fgVgQymou/volWmswDX7OQA75x96RevJbwllfJZ
         9rbQdKycwnR+njooM61WlFaO4zmBJMIcnFnU9dYfFIxz1E1MRC4fn1iTV58o2/j9P7Xl
         DlA86fQ5dzBwlGirjTWsIW9rZFVSuu47t9qSAXBU2y38CVH6Q8vWO2dCBmAFvzTdZm4e
         0TGU5BYWSpQ10C1usL5HqWKY7Zi2cWWMeBkbszlb97jNGcWhlPwctr4tKXQQL+vDZ1tb
         lJfw==
X-Gm-Message-State: AOAM533RmXu6wlKTFi/YIEmN0VWKgmQ6105sHK8gwVNzXXW+/Po/klmi
        VLFda2LIEYNVn22U7ZF+iN3LxGfLAGdw8eG04nHzWojYBdG34ZX04JqRDJX8tjpvpfdenrVb1qp
        Zk0k8wKg75S8+Ue5bRn2/+0t88tJ512cxj3+akfY96ZpsWxPK7Q3Ur+8vwztImukfS1fkrdBFPg
        ==
X-Received: by 2002:a05:6402:388:: with SMTP id o8mr72515563edv.359.1609795931656;
        Mon, 04 Jan 2021 13:32:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzC+vtO79VfytiVhjXcIpY3UBEI3R+JhbBnj8N/52YdwpMx9RrsqHMxVPGBeq/qyvfRhKzetA==
X-Received: by 2002:a05:6402:388:: with SMTP id o8mr72515541edv.359.1609795931397;
        Mon, 04 Jan 2021 13:32:11 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v24sm44494772edw.23.2021.01.04.13.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 13:32:10 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Possible problem with "ACPI: scan: Defer enumeration of devices with
 _DEP lists"
Message-ID: <7b32bd3a-4713-4283-df65-264ce035032e@redhat.com>
Date:   Mon, 4 Jan 2021 22:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

To help with testing the "ACPI: scan: Defer enumeration of devices with _DEP lists"
patch I've added it (the entire set) to my local 5.10 based tree about a month ago.
Approx. 2 weeks ago I noticed that sometimes the kernel build from my local tree
would not boot on a Lenovo Yoga Tablet 2 1051L machine. Reverting those changes
fixed the problem that the device was sometimes not booting.

When it did not boot, it would hang at:

         Starting udev Coldplug all Devices...

And FWIW there was an oops about an unhandled kernel pagefault pointing to a sysfs
directory entry reading function (I thought I saved the oops but it seems
that I did not).

I started debugging this but I did not really reach any conclusions before
going on vacation. Fast forward to today when I build a 5.11-rc1 kernel and
booted that 10 times on the Lenovo Yoga Tablet 2 1051L machine without issues...

So this is really just a FYI, I'm pretty sure that I did not botch cherry-picking
the patches on top of 5.10, do you know if there is a (somewhat) isolated patch which
is necessary for the splitting of the scanning of the ACPI root into 2 steps which
I might have missed ?

Anyways this seems to be resolved, but I did have some ideas on how to pinpoint
the culprit with the "backport" to 5.10, so if you get any bug-reports esp. ones
about hanging at "Starting udev Coldplug all Devices..." I will get back to
my 5.10 backport (I've a tag for it) and restart debugging on it. For now I'm
happy to report that it is resolved with 5.11-rc1.

Regards,

Hans

