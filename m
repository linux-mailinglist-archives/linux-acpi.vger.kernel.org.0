Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1D278C62
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgIYPUE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 11:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYPUE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 11:20:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A5C0613CE;
        Fri, 25 Sep 2020 08:20:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so3099630oif.13;
        Fri, 25 Sep 2020 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OAz96dzZAfm+2IsbvC6/JC7wz7Vim1MaFIU86o+xxBc=;
        b=bkype4lDtQu8pRj6WfmiXQPUW+sj2sSQKx24pH0BxTPiqKHNS4T2ysAtgj+b95adKv
         f0L49bmor4OFG/JEmdpiZoQRV2z/NK6jrngYQaHjcUXP2UcNxfbeinh6US+vEw2towrz
         KId04bKS0LtZQ7nIEeSlSuzKskFQhQKpav35kZmiRQ17cdS7Ih5vE8XjQc/YuYFmpQSs
         rfJbRuNGZ1ZSLYwRC+HyMQQYRNejMaTFg47BzoM5MuWtIcQXHh9mB1C5XQaz57lVnzxG
         M2XJdtUBa3/4op50EiwxaBJf5tHBlPFl1dbXT3hISOPJ7HG77WS0gt3Cb4tDEvjSdptY
         8fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OAz96dzZAfm+2IsbvC6/JC7wz7Vim1MaFIU86o+xxBc=;
        b=YLNDy5kEisgKXDbXGI5VSUmZ2QWEV2Rb+ltHxjuRI5WIgUH8iwXhxebIuWE2uI4/Hd
         MRkPrlHWXAQrDBi3xab+3aTfZVkhjlsEv2hQ2VprvmEQXDZo7ypchTR51wDYGoM5fTGU
         NDTUJhQh8wcdNC6YiQ4sZwfezwLtR2M+vM/R5p307Gt2UDPB8N3y+P8duyLPehfaVHxo
         1+iCH1+/L051hppUCalBbFLMWpaxNV6Ac0CvqQ/9Fcqn3gbhbYtsZvNP0iVviSoQTUqk
         GBEQDp9QKrjfUZpru+UsJtFaLjne5oMzj424pXfhIbTE0l7WcnSune1c18q1kJL2lt+y
         D5Dg==
X-Gm-Message-State: AOAM531y2yGLiDEFQrx7VUn/CoO830ReLgRtYRaW6dT3kd/qlf4JWL5d
        v3nZv5sCwwnQIQgAuqhkrPY=
X-Google-Smtp-Source: ABdhPJxr625Iuk10y+rqyxSf4pr0wUa75eDXBc27X9CAnPokzupWPQnmgPcYyJ2e+9oCEnyjzADR1A==
X-Received: by 2002:a05:6808:a05:: with SMTP id n5mr566305oij.154.1601047203447;
        Fri, 25 Sep 2020 08:20:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g22sm709668ots.35.2020.09.25.08.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Sep 2020 08:20:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Sep 2020 08:20:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, bp@alien8.de, x86@kernel.org,
        tony.luck@intel.com, lenb@kernel.org, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        paulmck@kernel.org, tglx@linutronix.de, naresh.kamboju@linaro.org
Subject: Re: [RFC][PATCH 4/4] acpi: Take over RCU-idle for C3-BM idle
Message-ID: <20200925152000.GA171076@roeck-us.net>
References: <20200915103157.345404192@infradead.org>
 <20200915103806.479637218@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915103806.479637218@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 12:32:01PM +0200, Peter Zijlstra wrote:
> The C3 BusMaster idle code takes lock in a number of places, some deep
> inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> the driver take over RCU-idle duty and avoid flipping RCU state back
> and forth a lot.
> 
> ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
>   that combination, otherwise we'll loose RCU-idle, this requires
>   shuffling some code around )
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

ia64:defconfig:

ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!

I realize that this has already been reported more than a week ago, with
no visible reaction. Another problem introduced in the same file, resulting
in

drivers/acpi/processor_idle.c: In function 'lapic_timer_needs_broadcast':
drivers/acpi/processor_idle.c:179:1: warning:
	no return statement in function returning non-void

may cause ia64 boot problems since a non-zero return value will trigger
a function call. AFAICS that is not supposed to happen on ia64.

This makes me wonder - if no one cares about buiding (much less running)
ia64 images with the upstream kernel, is it possibly time to remove it ?

Guenter
