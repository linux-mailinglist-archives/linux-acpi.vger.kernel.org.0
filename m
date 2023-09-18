Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501557A3FCC
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 05:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjIRDtw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Sep 2023 23:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbjIRDtn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Sep 2023 23:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AEB10F
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 20:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695008937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tf1afM7/bTwRaF6MhWk6NmsY4pxpFUisMFOko6iFoOg=;
        b=RmK6mqbqchmt5lYaE+aVLfYL3xLWUS5jHqRp7sAXOyajK4bn8yEjvdkSQRbq200WYSv/KO
        bBIFn/skeIo9ifvzbcFkn/E8WL6FZ/lZcgq+OJPKoXI3dZJorf2HNqQu8Eb/n2SOYe5v6a
        GPu+fXxhXzeYkPBXQ/qKMm5CWax3iPk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-JifenGOoMXmUTwSX3ECOcQ-1; Sun, 17 Sep 2023 23:48:55 -0400
X-MC-Unique: JifenGOoMXmUTwSX3ECOcQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5703b4e92b7so2898304a12.2
        for <linux-acpi@vger.kernel.org>; Sun, 17 Sep 2023 20:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008934; x=1695613734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf1afM7/bTwRaF6MhWk6NmsY4pxpFUisMFOko6iFoOg=;
        b=MxP7eI6hoF8RRRhVdep/auM/3zpZo/UxHzMx405S0gBEIaXioW6aYl6PZ4SE7hD1QH
         P2m+RLpS4HmRSQYIeKfwTB1nCv882sydbyMQ1hH8y0EbBRDJpq3OnihuCNxlWYGLX9LK
         koyz7oHuFkazarq01sCY/VMK6L3VYysZbO+1NMrIxrUqai3X+YW6yUThVxcA/NmltikM
         3ahoyRYSka+yIqMaGeixRz4WMiLlebwxakmxiM0Wxxll/dx3uuQnqQifcmpAaQTEEqOx
         bKRn0C0Y8AJ8YvpfpMjU8clWETww5wNnVVXU57xtnVHQPYnGMyU2oXzwmfJNmK9QzV+1
         W8fg==
X-Gm-Message-State: AOJu0YxAr+ig7F35gQ1TahbFhjpCIOBeiT9Mk/vW7gWJ0QYWvX2gGfQM
        Bzmo8dfnATKImpiQpxn4Cj1DUEW/K84g/3ltPfQkYFp9/NoQC/d+UU9wQIQjhTpPHXy6dETMhYA
        S+TKKnY0f5ug4snLplRdaJA==
X-Received: by 2002:a17:902:e551:b0:1c4:16f7:d95b with SMTP id n17-20020a170902e55100b001c416f7d95bmr8120390plf.63.1695008934603;
        Sun, 17 Sep 2023 20:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU+J6/1r/Ic+5ZZYMQ4fGS+99Vl+z2dkdnv17BDJt0rP24HSwlnxKPxSwy3c72dz81jLm2Bg==
X-Received: by 2002:a17:902:e551:b0:1c4:16f7:d95b with SMTP id n17-20020a170902e55100b001c416f7d95bmr8120381plf.63.1695008934370;
        Sun, 17 Sep 2023 20:48:54 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b001bbf7fd354csm7284723plc.213.2023.09.17.20.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 20:48:53 -0700 (PDT)
Message-ID: <4f368470-83c1-4140-9d0f-e64db3402865@redhat.com>
Date:   Mon, 18 Sep 2023 13:48:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 07/35] x86: intel_epb: Don't rely on link order
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-8-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 9/14/23 02:37, James Morse wrote:
> intel_epb_init() is called as a subsys_initcall() to register cpuhp
> callbacks. The callbacks make use of get_cpu_device() which will return
> NULL unless register_cpu() has been called. register_cpu() is called
> from topology_init(), which is also a subsys_initcall().
> 
> This is fragile. Moving the register_cpu() to a different
> subsys_initcall()  leads to a NULL derefernce during boot.
                                      ^^^^^^^^^^
                                      s/derefernce/dereference

Reported by ./scripts/checkpatch.pl --codespell

> 
> Make intel_epb_init() a late_initcall(), user-space can't provide a
> policy before this point anyway.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> subsys_initcall_sync() would be an option, but moving the register_cpu()
> calls into ACPI also means adding a safety net for CPUs that are online
> but not described properly by firmware. This lives in subsys_initcall_sync().
> ---
>   arch/x86/kernel/cpu/intel_epb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> index e4c3ba91321c..f18d35fe27a9 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -237,4 +237,4 @@ static __init int intel_epb_init(void)
>   	cpuhp_remove_state(CPUHP_AP_X86_INTEL_EPB_ONLINE);
>   	return ret;
>   }
> -subsys_initcall(intel_epb_init);
> +late_initcall(intel_epb_init);

Thanks,
Gavin

