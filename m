Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7121725D
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 17:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgGGPb7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Jul 2020 11:31:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728540AbgGGPbv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Jul 2020 11:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594135909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2GCSEyfeqXJcXbPVJoMrBPsm09EA1cEbL+k1DmirWM=;
        b=JvDAwOq+Uye98hjLovLwJ8s+ifsKPiZnsJCf4J1tVp1JuILg64oWhfxRDgHpZV++tRhr8z
        iaXNiuAUrSfuyU4PRC251OSP1Uft5fbhL8Qh9GeJ/ziflm6brKzI4xIHEyQ3T7d/EY1UJe
        WAvx81us6+tEEDI0vsAc5ulQNZgWmcQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-AA2SULFlMVSRWlgkhornDA-1; Tue, 07 Jul 2020 11:31:47 -0400
X-MC-Unique: AA2SULFlMVSRWlgkhornDA-1
Received: by mail-ed1-f72.google.com with SMTP id v8so47674994edj.4
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jul 2020 08:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H2GCSEyfeqXJcXbPVJoMrBPsm09EA1cEbL+k1DmirWM=;
        b=jauB3zdmQ2InGeDma4dGtWSmusTc1ulzWlueYZLH7qWqpbtybYNeEKo14IMqKrlk0t
         8uV0TUOsrByetA7TpgRmcGIWXLZK1WBl04urE48dOtFF7LGxhx/L7/XxCer/RsgiUuff
         O/FIvucn+PRQjLJ4FAGxfrbYAt9GQLN7B4iKwUF2BBRDhb84YROEmLxOOHNKgdAE7NnQ
         PeMXJOac4N6Mw9gs72yls086fDYb4DEL2wGkzeSMGYx1E25/PGmDB4YNNigVbiHTF68e
         wm+Fzrp+lL33KN8nl07AeD+0u+ekTvSNVyXbY3qrJo4QKvyshLOyNmwqwD1otd1lhxB5
         fMCQ==
X-Gm-Message-State: AOAM530oJKjWrwHjkV3C4aCfOgeEwut2MTanYgBQPfySCiRzYEWkZKV8
        8K6MW2GkKV0jHCN4EetWdaZlI2uydnpmSkwba/9Dj3CpkZUQGlFkuACoG2fiTlMMuVMiu/l2fC6
        G3CgVySvHc5XhD8gT+iTivg==
X-Received: by 2002:aa7:d754:: with SMTP id a20mr2986592eds.375.1594135904171;
        Tue, 07 Jul 2020 08:31:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdIgaA0g4YVUJ5d38uQJCdfus5E54mAxpYYKubLnc7t9FuWJgNZx0Kh+vFm4pOXxmDvHbF8w==
X-Received: by 2002:aa7:d754:: with SMTP id a20mr2986580eds.375.1594135904002;
        Tue, 07 Jul 2020 08:31:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id z25sm525119ejd.38.2020.07.07.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:31:43 -0700 (PDT)
Subject: Fwd: [Bug 1854502] New: Noticeably Increased CPU temperature
References: <bug-1854502-8448@https.bugzilla.redhat.com/>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
X-Forwarded-Message-Id: <bug-1854502-8448@https.bugzilla.redhat.com/>
Message-ID: <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
Date:   Tue, 7 Jul 2020 17:31:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bug-1854502-8448@https.bugzilla.redhat.com/>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

I got a copy of the below bugreport in my mailbox and I
was wondering if this rings any bells.

Are there any relevant power-management / scheduler
changes in 5.7 (vs 5.6) which might be related? And
is there any quick way for the reporter to test this
(by e.g. picking a different scheduler / cpufreq-governor).

Regards,

Hans


-------- Forwarded Message --------
Subject: [Bug 1854502] New: Noticeably Increased CPU temperature
Date: Tue, 07 Jul 2020 15:23:38 +0000
From: bugzilla@redhat.com
To: hdegoede@redhat.com

https://bugzilla.redhat.com/show_bug.cgi?id=1854502

             Bug ID: 1854502
            Summary: Noticeably Increased CPU temperature
            Product: Fedora
            Version: 32
           Hardware: x86_64
                 OS: Linux
             Status: NEW
          Component: kernel
           Severity: medium
           Assignee: kernel-maint@redhat.com
           Reporter: aria.aghazade@gmail.com
         QA Contact: extras-qa@fedoraproject.org
                 CC: acaringi@redhat.com, airlied@redhat.com,
                     bskeggs@redhat.com, hdegoede@redhat.com,
                     ichavero@redhat.com, itamar@ispbrasil.com.br,
                     jarodwilson@gmail.com, jeremy@jcline.org,
                     jglisse@redhat.com, john.j5live@gmail.com,
                     jonathan@jonmasters.org, josef@toxicpanda.com,
                     kernel-maint@redhat.com, lgoncalv@redhat.com,
                     linville@redhat.com, masami256@gmail.com,
                     mchehab@infradead.org, mjg59@srcf.ucam.org,
                     steved@redhat.com
   Target Milestone: ---
     Classification: Fedora



First things first, I'm running Fedora 32 with latest packages on intel 6700hq.
With latest kernel-5.7, cpu temperatures are noticeably higher.
Using kernel-5.6 my idle cpu temperature is around 35-40°C, but with kernel-5.7
its around 50-55. Htop and KDE System Monitor don't show anything using cpu and
idle cpu usage on both kernels is 0-2%.

I first noticed this issue on kernel-5.7.6-201.fc32.x86_64, and it is also
there with kernel-5.7.7-200.fc32.x86_64.

Booting with kernel-5.6.19-300.fc32.x86_64 fixes the issue.


Are you running any modules that not shipped with directly Fedora's kernel? No.


-- 
You are receiving this mail because:
You are on the CC list for the bug.

