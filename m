Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47E3694DC
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhDWOif (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 10:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhDWOie (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 10:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619188677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UnF1xxkEQV57snnP6REro9CZbmE4pN1bYr4+yFPC0qY=;
        b=ba1CDgmFl3dKPA9+d0VeEFfc0gAJV13Q4cKMa4qfEh0uuN0TrY/GUCQnrWTNVLOzhPksaK
        CKflbfN6EmBxHqnX3jSsGzDUPchyJ+urr8JkkGZOAoei6uko7RrqZJj0edwwsHy7dQGila
        uEn3SnoLw1by1TmUP8DG2kFIAtmP87Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-8SBbz2KnPmCAyJ8CFZpxyw-1; Fri, 23 Apr 2021 10:37:56 -0400
X-MC-Unique: 8SBbz2KnPmCAyJ8CFZpxyw-1
Received: by mail-qt1-f200.google.com with SMTP id y17-20020ac870910000b02901a7f2d61003so17776482qto.20
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 07:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UnF1xxkEQV57snnP6REro9CZbmE4pN1bYr4+yFPC0qY=;
        b=Eh7ffOkmQMM2764JIT8qmLavRUMgkzkaCxVZ+WUH1usuciZhXhJwYPFijvKEMZacgq
         mE1gt3OvXwEMdz6JGFWnit7EznFNfy7JDJtDj3vBsnTANKAvCcuYIn3e1WkVBEW431rv
         BGzpcXaZubpoPWNAyd2rNS6kZvMuxcC5cNwtXqUV/Y9OaLAL/n+N7RMZR7B6iBgZ4WK9
         euIwM/XeeJB6C64HMpJIvt/sGj8pWUtdUE4ck+HVmtv+ZEcXVgSNL1SqnYeml3VomctR
         cZDSaKL9Vt72kAG6/tqmfy6ihMyRhArHoRXh8IwTKpTcNYEeIRU6288BSfbgJzuiblxn
         KCjw==
X-Gm-Message-State: AOAM533XfkOB/b4iK1BHu5rJYK07vFY4/Q0rFFR4jsfDaTcHJrL2ly/W
        JSsqJuJ+rJBzQb3bhaN4vxPfMFiwDSvY7gjUQwAXl1voK5uGqs07I44ot3ytYN/MhXTNYD7HSY5
        Dt++x4gIfedS/olTJ/ytudwPrbIPltHC6bmXDeR6Y6inLAapjg6AV2Ci5yo5HoHKD0bzkYlC/bA
        ==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr4287859qkg.145.1619188675371;
        Fri, 23 Apr 2021 07:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSJ+W+BYoZyXG9kceLsoRiJDZq+zZBNXu0yAjJlyx/4oDrnMyT9g472M14A2R877lccWLnNg==
X-Received: by 2002:ae9:ec1a:: with SMTP id h26mr4287839qkg.145.1619188675159;
        Fri, 23 Apr 2021 07:37:55 -0700 (PDT)
Received: from redhatnow.users.ipa.redhat.com ([2605:a601:ab5e:300:20c:bff:fe44:d76d])
        by smtp.gmail.com with ESMTPSA id b65sm4656940qkc.119.2021.04.23.07.37.54
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:37:54 -0700 (PDT)
To:     linux-acpi@vger.kernel.org
From:   Mark Langsdorf <mlangsdo@redhat.com>
Subject: Suspicious kfree at the end of cm_write
Message-ID: <59aad467-3526-b764-3310-456f8d14e651@redhat.com>
Date:   Fri, 23 Apr 2021 09:37:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit 03d1571d added an unconditional kfree() to the end of cm_write() 
in drivers/acpi/custom_method.c. I've been reviewing commits after the 
unm issue, and I think this code is wrong. If cm_write() is called with 
*ppos = 0 and count < table.length, the buf is kzalloc'd and immediately 
free'd. On subsequent calls to cm_write(), if cumulative count equals 
table.length, then the current contents of buf are passed to 
acpi_install_method. In the extremely unlikely case that buf has been 
reallocated and overwritten with a different but valid ACPI method, then 
some method other than the intended method could be installed. I'm not 
sure that this is a security issue but I don't think this code is correct.

It's a trivial patch to fix, but I'm not certain of my analysis. Could 
someone who is more familiar with cm_write review commit 03d1571d and 
tell me if I'm off base here?

--Mark Langsdorf

