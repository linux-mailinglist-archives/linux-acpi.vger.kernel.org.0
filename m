Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044875F27D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 07:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfGDFzc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 01:55:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36999 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfGDFzb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jul 2019 01:55:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so2374468pgi.4;
        Wed, 03 Jul 2019 22:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BX5JDaciana7ktLIahHDZ8Rm/ZU0HX0KyhCu3VI68A8=;
        b=ES/LWPfND6i8EUl8ALV5oWggRPVLI7ruCB9fs/GvPzxHMIPoN81XcE8xKezsMra/y6
         dSwtmhsVOcDEDLA3+63LTMxSlFWvNLIzPEdZZiYtQ3E0aqVn5T5Alw1PRyomomnXkJD6
         8TSPx95eZ4q2HFnM+Y18aqUHNumIeDhdJuw7YW81gRweXQIH3ei5iN4365L5rHuTezoO
         mbv+3O9cU982/pSlPyZrIJGuMZwxmgH2I//jRmEenMlfFtkEaW8stYKYUR7edjVF4Wln
         rsVaLY8yfmeSuPwncUDuN/KSvjXMeRrokfWjIUtYnBY04EyiTl/bZoKHY9T/rp7ef961
         F3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=BX5JDaciana7ktLIahHDZ8Rm/ZU0HX0KyhCu3VI68A8=;
        b=ciZYrl0euWR5Si7HQyo6rI5v/6Bol5RYJy1sxB2a+HxsMiAPmipm2U8xwOQ9Jc7er7
         VgHa3r3H5CSRlmmUNsgJj73T35YgFyFuraDk3XCkbem4WpC4NewOfehBrNKvAZI6kTmX
         zD67SgiDyUa+m7+8+uokdY/qSzIdBoqhFDOcXx//rs3Dxbz333vEPBknjR8cuffPTGeD
         SkAHrS8/+nuyl2KWKrskoc9pPpxLHwl7Sz1ULrZSFDbwyrbnhO8ZnNK7Ga/KGbhxd7Dl
         ekJCkHX64rbIL7ISv8yT50HG1vesZG5Yjyu3KvScpsNJqmBrWloYGdujvsAkr8puuikH
         D8Ww==
X-Gm-Message-State: APjAAAX160oIQ66L3ZBOSxrZJnRcPNbmFE7FyaBySe1Mzr7lVhykJtir
        AggYfdmOoMG5F/Zop+Oh15wOcLht
X-Google-Smtp-Source: APXvYqwDEIQv50OOSV4lqbB7mHxRneKKwMjQFsVni/kO8fTksoN52y09PuYbOrKCqczquTT9hKw8LQ==
X-Received: by 2002:a63:c508:: with SMTP id f8mr10813454pgd.48.1562219731123;
        Wed, 03 Jul 2019 22:55:31 -0700 (PDT)
Received: from [0.0.0.0] ([80.240.31.150])
        by smtp.gmail.com with ESMTPSA id j11sm5792476pfa.2.2019.07.03.22.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 22:55:30 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] Support CPU hotplug for ARM64
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, james.morse@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
 <2b22cf4d-9646-9f20-41ae-cceb83d9791b@gmail.com>
 <135ee490-a5a6-46c9-208e-81849b20d6b6@huawei.com>
From:   Jia He <hejianet@gmail.com>
Organization: ARM
Message-ID: <adfea83d-fb86-f388-3409-eea9564b938a@gmail.com>
Date:   Thu, 4 Jul 2019 13:55:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <135ee490-a5a6-46c9-208e-81849b20d6b6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Xiongfeng

On 2019/7/4 11:26, Xiongfeng Wang wrote:
> Hi Justin,
>
> On 2019/7/4 11:00, Jia He wrote:
>> Hi Xiongfeng
>>
>> It is a little bit awkful that I am also  investigating acpi based cpu hotplug issue silimar with
>>
>> your idea. My question is your purpose to implement the vcpu hotplug in arm64 qemu?
> Yes, my purpose is to implement the vcpu hotplug in arm64 qemu. So that I can add or remove vcpu
> without shutting down the Guest OS.

Thanks for the infor, I guess you used GED device in qemu ;-)?

---
Cheers,
Justin (Jia He)

