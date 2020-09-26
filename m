Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6DA279BE6
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Sep 2020 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgIZSgm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Sep 2020 14:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIZSgl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Sep 2020 14:36:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9DCC0613CE;
        Sat, 26 Sep 2020 11:36:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so2978975ejb.4;
        Sat, 26 Sep 2020 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WDnJbrBWNQ1GugmB49qXnIh1j39vlYsXsMRH5FVMOGE=;
        b=Nr6wRrYK0wJDsSfwIWT0TReTx26DLYS54KgwFYTb1tH9u7tGLnWMkcOJtKwjvCakuS
         OrpDEMFI1FZvXMim2+7MjVOw8usGy1FgJFdkK9cqijh2lDpzMDYViWa4NHCL9MNgKG0R
         Q6472YAOryArav1e9kgYojxT7e2xSlFQieY0fO/MAYoN6TgVBf8FIKMZCHh+Wb3YXRg6
         yYrDXfv0T+h5/rgMdFjKrlB7zdapovqnGdpAgqNJb0GbUF2Vmgc1ucLcYBQcPyFA/Im7
         IdmYV66DIMpIJlAY3FX6c4zD7Tgaa9k15ddhAd2IdaNfnafwUwriGOpETn8Baz2xzpNf
         SGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDnJbrBWNQ1GugmB49qXnIh1j39vlYsXsMRH5FVMOGE=;
        b=FWWDT8jbOq8A1Qz4Qt6cG7sy8WNjHFIpLy92b/6nsTkLXuu6bPst3LrvE7Evyan3Cu
         xe+pxPPX1V+K9WsvyX841H9Gsj7wh29GiSP+e/U/4OoyJs6wAZ9Yxpm2d6jJWR7aT4Z7
         WvGCWkBIG42Wv5cNkCO0hLjFgMJFDqdCct+2P6qo6N0dvXeUFLiGorUkvElmRwF9gvNU
         kx7Z6nQw+/hbz4+Jc7MQNjIvOjl6kqsKbQSF3wuaK8WM4L928yHqrHratC0+Pme+h7BM
         sLBJNWKLHiUsG4gEYDIFBDFwlkqQhe/e7fpOlMpAmT6EAaSCGwude4SbRVgCb/ukyQTv
         OIhQ==
X-Gm-Message-State: AOAM533BsqRjDFZpumk/6FbOupWttkcnLhcQ1UUplNx94IvVfoJjLkK4
        cfMCDyVzkicV84X/jBhzr0kpabQOLm4=
X-Google-Smtp-Source: ABdhPJzSmmzYNq6dts1SW8TCoIL/fLVgTMgK2xrx8XOKuwhp3uBJX5NwzNpcjW+sS6z44oPJLqInWQ==
X-Received: by 2002:a17:906:ce30:: with SMTP id sd16mr8410852ejb.53.1601145398448;
        Sat, 26 Sep 2020 11:36:38 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id f21sm4915752edw.83.2020.09.26.11.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 11:36:37 -0700 (PDT)
Subject: Re: [PATCH v3] platform/x86: Add Driver to set up lid GPEs on MS
 Surface devices
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200917155559.1686146-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <095203ce-37ef-2a5f-4397-63632139c925@gmail.com>
Date:   Sat, 26 Sep 2020 20:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917155559.1686146-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I suggest delaying this patch until

   [PATCH] platform/surface: Create a platform subdirectory for Microsoft Surface devices

has been resolved. If accepted, I would then submit a v4 directly
against the new platform/surface subdirectory.

Regards,
Max
