Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7563715D4
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhECNSP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 09:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234194AbhECNSN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2021 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620047839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ3P44Yfnu49NpfXUggovdI/GLNt/AAmmjz1I1EQb1c=;
        b=PMm0e2x4Jt9ePswSUwIGzQPnVd6DOXaDJ32hKT+36kBeRpGxEHcfPj2/g/L/7dR0RKNWMs
        LdkmgZFUPeYTHQ0/p1FUyj6AfE5dY3wdMPfjjKgpwhWiCxDwz2xZqYGHoqUp/tWBOFO2z2
        gHAwsZsWXu+iYz/XFv36b7vzn53yKKo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-qdKoZZVFOWGmsYN1IW8jQg-1; Mon, 03 May 2021 09:17:18 -0400
X-MC-Unique: qdKoZZVFOWGmsYN1IW8jQg-1
Received: by mail-qt1-f199.google.com with SMTP id b8-20020a05622a0208b02901b5b18f4f91so1369438qtx.18
        for <linux-acpi@vger.kernel.org>; Mon, 03 May 2021 06:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lZ3P44Yfnu49NpfXUggovdI/GLNt/AAmmjz1I1EQb1c=;
        b=njPvygxQd9ym8SEUQvQNp4SEQPux3XgygA0gnlIc21fHDjhjhsW+SvRN6LSGHSdM5+
         DX+MlT4vJzO9H/h9aqKhak3iKM5bZ1H7TkYYkb6A+HkMnEe/n4+XADJGp6lUaeBfg+8S
         /ePMP6hv5XVmQWjfGKmsiRnXngJlCL7rhXF5cSAGf5wGPwRfw4dUR55zPKtOMcpKrWlc
         /J3ogTqh3HRL8Yk7iMIGp8Z4uTvFUwJqTI+LxFNLw4ROgZp64oC1Tj0RYkp5/3oInpCM
         P1ZRLP6ovKc9KE+klw4SSThHn3Q/Bweef5saJxS9EcXKHbUotg1nc9iQJB8HBEQvefOO
         HC4w==
X-Gm-Message-State: AOAM532zuByuqEzS1vOJKDdbMQxmn7CqvbqQOKnFdF2Y6C7ZHCThqx2S
        QzQiyzn6xFq6vw90DrZJ+CCb5eQGwaR35VrkmkDxKEsRDUI/sWuOHYJN19FDYjuiijtGZCL/vyb
        vUbEVAz4m0Dkptq7YLLdD3GeMLS4j2DOtmtBJeRIGyDH/EKieMkJP+/LfU/tSeEUoLz+9Zrv+wg
        ==
X-Received: by 2002:a37:9a16:: with SMTP id c22mr16145777qke.0.1620047837137;
        Mon, 03 May 2021 06:17:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQxOHgnDvzivrvWF+f41wjCfS0nWr2QjOGWOHxpLgLWxPJr4p5uQ3N9F4ixkJD2cJUfJ+RTQ==
X-Received: by 2002:a37:9a16:: with SMTP id c22mr16145743qke.0.1620047836859;
        Mon, 03 May 2021 06:17:16 -0700 (PDT)
Received: from redhatnow.users.ipa.redhat.com ([2605:a601:ab5e:300:20c:bff:fe44:d76d])
        by smtp.gmail.com with ESMTPSA id g1sm8460932qth.69.2021.05.03.06.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:17:15 -0700 (PDT)
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210502172326.2060025-1-keescook@chromium.org>
From:   Mark Langsdorf <mlangsdo@redhat.com>
Message-ID: <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com>
Date:   Mon, 3 May 2021 08:17:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210502172326.2060025-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In 5/2/21 12:23 PM, Kees Cook wrote:
> This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
>
> While /sys/kernel/debug/acpi/custom_method is already a privileged-only
> API providing proxied arbitrary write access to kernel memory[1][2],
> with existing race conditions[3] in buffer allocation and use that could
> lead to memory leaks and use-after-free conditions, the above commit
> appears to accidentally make the use-after-free conditions even easier
> to accomplish. ("buf" is a global variable and prior kfree()s would set
> buf back to NULL.)
>
> This entire interface needs to be reworked (if not entirely removed).
>
> [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
> [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
> [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
>
> Cc: Wenwen Wang <wenwen@cs.uga.edu>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

I have two patches submitted to linux-acpi to fix the most obvious bugs 
in the current driver.  I don't think that just reverting this patch in 
its entirety is a good solution: it still leaves the buf allocated in 
-EINVAL, as well as the weird case where a not fully consumed buffer can 
be reallocated without being freed on a subsequent call.

https://lore.kernel.org/linux-acpi/20210427185434.34885-1-mlangsdo@redhat.com/

https://lore.kernel.org/linux-acpi/20210423152818.97077-1-mlangsdo@redhat.com/

I support rewriting this driver in its entirety, but reverting one bad 
patch to leave it in a different buggy state is less than ideal.

--Mark Langsdorf

