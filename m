Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283D21C7129
	for <lists+linux-acpi@lfdr.de>; Wed,  6 May 2020 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEFM6q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 May 2020 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFM6q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 May 2020 08:58:46 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E67C061A0F
        for <linux-acpi@vger.kernel.org>; Wed,  6 May 2020 05:58:46 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x17so458279ooa.3
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2020 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ruwpJ2SIHBd8FaO8vvKDrjjlbrhdRWEAzgpAo7eh+cM=;
        b=qI80E4+I6eLsoH/893foD+osWZP0xywkogWWjp2Z4Upd27PSXbIRcGtzpa5UH8JnUi
         K/97GDXk95D1+cI7OdPOQxhEWdtTbEHYgmM3/6xV/REB5FmKAm/ANkYf0+vlTYOsHbhm
         bKgwYgGtQ9ELSIKUgMwUE/q847OlnZIdHbNmG9nc420AAghZpglhDgUG8J8tKPRSpngW
         AMD/+shoRnlAGTIgomQ1isGrCLzmBetrk63URKBDKmKu5QrKBdIXTYSHnByYbhQkLb/O
         H/4s7hZdGQOWYmvQAIww+APIPXDGR7rypnd4a7L3SP8dcMWoFBqZbRzmta2htDn/g5qn
         heuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ruwpJ2SIHBd8FaO8vvKDrjjlbrhdRWEAzgpAo7eh+cM=;
        b=jBOQY8yeuJQa4rZE/OHLuBdzNRxV4yvmmNRtvYmpEu1xU5qhgQ3vSLuq1rzkTWE1B7
         7w6ScIcHeAJq6jcZFeUrIp954BY1Z9ULW3eL4Og80UlJBs5tWJ5kYys2awjb/llu/CYx
         Gw1m70OiHCF7f5hF60gICXqMWHzPCuIqKlNnQcPCYjcXXo2QnHccQPEtwnuE6bRE+kjD
         chasLvaeW0HUtowInkvTbcNcYc+riRrsRtrpZ+dw8aXiGRb0traHHiInQZRzR4CShJb6
         3dk/yZecNMkR3zNsTRdbbVrDKEb5AwUGpWALSCEBGog+ZsbUy4KbYPGCBbpbV+73M3Wd
         e0Jw==
X-Gm-Message-State: AGi0PuZooi1VihohBzdHQYQsKYvlyErchZY1y2G9dmfd2Uk10Kxwx49v
        FquKGLEKvFDX4S5pIPn4xURoSlEQyDv7A8vBIqlg3pc3HyDfaw==
X-Google-Smtp-Source: APiQypJu8to6Wz5qLtkBZB1KslHZ5cfQthRn9rn7p5EXX5uQF9cEW2Xe3LBv6qinhLmLt9m4ae51jYYHc1qg5FRU2GQ=
X-Received: by 2002:a4a:e04b:: with SMTP id v11mr2911757oos.92.1588769925427;
 Wed, 06 May 2020 05:58:45 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 6 May 2020 20:58:33 +0800
Message-ID: <CANTwqXBYTyQukX4nA20iq+juGqGbb7-gwrMLhBmP4FGDgSdg-g@mail.gmail.com>
Subject: is there a memleak in function acpi_cppc_processor_probe
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,
I notice that most of the usage of kobject_init_and_add in drivers are
wrong, and now some drivers code has maken it right
please see commit dfb5394f804e (https://lkml.org/lkml/2020/4/11/282).
function acpi_cppc_processor_probe() in drivers/acpi/cppc_acpi.c may
have the similar issue and leak kobject.
if kobject_init_and_add() failed, the cpc_ptr->kobj may already
increased it's refcnt and allocated memory to store it's name,
so a kobject_put is need before return.

int acpi_cppc_processor_probe(struct acpi_processor *pr)
{

ret = kobject_init_and_add(&cpc_ptr->kobj, &cppc_ktype, &cpu_dev->kobj,
"acpi_cppc");
if (ret) {
per_cpu(cpc_desc_ptr, pr->id) = NULL;
goto out_free;
}

kfree(output.pointer);
return 0;

out_free:
/* Free all the mapped sys mem areas for this CPU */
for (i = 2; i < cpc_ptr->num_entries; i++) {
void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;

if (addr)
iounmap(addr);
}
kfree(cpc_ptr);

out_buf_free:
kfree(output.pointer);
return ret;
}


Best regards,
Lin Yi
