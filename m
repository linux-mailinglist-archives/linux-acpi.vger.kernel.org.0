Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764971C5604
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgEEM4F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 08:56:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48998 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728497AbgEEM4F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 May 2020 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588683363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n0uNI1ChsYhL1tx1mTpF37lxsFeqNKsNpitUe2AQ5nU=;
        b=eL5AuGJu6nhWonWlDR3UT22lFOpBjbRhK7W86OquI8oZwwl7V4Yzt9suv4EjKMjQo07izK
        rU5d2V4fR8Um+S3x0gevFCqDXD/bN145E8CCgFsL7RZenRew9R8snoM/mnOStjXDo+2W8F
        g5Pen/Mre5ouAAxae/qS9RpOgL3Dhec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-3fzzvpx_MKKEnuyXM1eE3A-1; Tue, 05 May 2020 08:55:57 -0400
X-MC-Unique: 3fzzvpx_MKKEnuyXM1eE3A-1
Received: by mail-wr1-f69.google.com with SMTP id p8so1155712wrj.5
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2020 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=n0uNI1ChsYhL1tx1mTpF37lxsFeqNKsNpitUe2AQ5nU=;
        b=g0rvvVeCJm476Y6LVeiU7/qh4gjSZOiX0Or1Ao68vlqDifx2WU7uItTdm0wJs86s6a
         WaelYCF2Bda+BawFXnAOawJbzdgCijZUQPJTtk9Y01mLneFGRXDtd53sgB1BOgZXusiL
         rzAJQRqR6cEMFrNreLrB+L7ypLrM5NMzfszgL7NnTr6Zb64tvfUQz2lKoom8cp53CynZ
         O3rIlie7Obg7mwZmbbRV/unBcQg5Q0SM+AcPSvcYZAz8h0TRjKTbSJ8RMGa9r1zhJJvX
         ACdXdTm/gkuQJlVYQsQ9jE07CyFMHOzNnMddTVPh7JxaaFI2WX98REptR3Wm5fMDY4x9
         s63A==
X-Gm-Message-State: AGi0PubUorqvwm5x5tPlftu9n9HvsJHyXS9ETEjg4yfkezLDX3DVnZ1R
        knjR+O6v8/aR6a48b7lG4/H6QefFP4r0rw/SH4QOeBSVGyGO9MOnnESAfMyg0TKKEtbvwhKHXF5
        czkzrbLXwJMNXOHOZAVbW+w==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3045671wmo.23.1588683355971;
        Tue, 05 May 2020 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypLevp2iSB/Hf5230ONUKQcBTNXi9428r6hRALf0oRcefK8wCmyijQUbb4sUP4euchsBSlz10Q==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3045648wmo.23.1588683355676;
        Tue, 05 May 2020 05:55:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w10sm3458032wrg.52.2020.05.05.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:55:54 -0700 (PDT)
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Mattia Dongili <malattia@linux.it>,
        William Bader <williambader@hotmail.com>,
        Dominik Mierzejewski <dominik@greysector.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: 5.6 regression caused by "ACPICA: Dispatcher: always generate buffer
 objects for ASL create_field() operator"
Message-ID: <49f20a91-9362-6249-d413-1461258d56a9@redhat.com>
Date:   Tue, 5 May 2020 14:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Commit 6d232b29cfce ("ACPICA: Dispatcher: always generate buffer
objects for ASL create_field() operator") has dropped the
automatic conversion of small buffers into integers.

But some drivers relied on this automatic conversion, these
drivers have checks like this:

         if (object->type != ACPI_TYPE_INTEGER) {
                 pr_warn("Invalid acpi_object: expected 0x%x got 0x%x\n",
                                 ACPI_TYPE_INTEGER, object->type);
                 kfree(object);
                 return -EINVAL;
         }

This specific bit comes from the sony-laptop (platform/x86) code,
the ACPICA change has broken this code, causing systems using this
driver to hang on resume from suspend.

We have multiple bug-reports open for this already:

https://bugzilla.kernel.org/show_bug.cgi?id=207491
https://bugzilla.redhat.com/show_bug.cgi?id=1829096
https://bugzilla.redhat.com/show_bug.cgi?id=1830150

Mattia Dongili, the sony-laptop driver has already submitted
a fix for this upstream, adjusting the sony-laptop driver
to deal with the returned object type now being a BUFFER.

The goal of this email is to:

1. Make everyone involved aware of this breakage as we
may see similar breakage elsewhere.

2. Discuss if we should maybe revert the ACPICA change.

If you are reading this then 1. has been accomplished :)

Which leaves us with 2. I'm tending towards keeping the
change, since it seems the right thing to do and dealing
with the fallout. But since there is fallout we should
also at least consider reverting the ACPICA change.

So ACPI maintainers what is you take on this ?

Regards,

Hans

