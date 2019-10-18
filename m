Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FAADC88F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410567AbfJRPcC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 11:32:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40279 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410487AbfJRPcB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 11:32:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so6658470ljw.7;
        Fri, 18 Oct 2019 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ei51YZAvEhA4r5N+YGs4qYhuh8+slSCkMfLH0jqZnD8=;
        b=GiAD4YwWVjSWvaK8Av5lcBHH0qomSRpUNph7poGrauD6glP+bDoN6fcrk3m03qOOai
         BpEJN6xOeocNXiR+hA8o3lvvVplAu+l/cN05qIFs38/3DttNJn7v/2iCRbvOmYZeJD4Y
         //Wwnbd99k1MgCsN6sMjwDh4XdsoGgQSHDYzT9dIgGRW0Kndhyhgm7PgRgGZOgL8aBDw
         SJrj2LewHiHI/23l1XERDDAQhm5Pipp8KaFxovjtCqxKxRPRmTAUDM49qyTeUadt0rrd
         ydeaXk+nlcwUchVz4XV40YcgIMkVgyHx2Ub3gu710baDSvs03w9D9cS1qD8B/HNFyfyE
         RYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ei51YZAvEhA4r5N+YGs4qYhuh8+slSCkMfLH0jqZnD8=;
        b=G7bUb/P2ATuBUGy8nyEaLugzKSN+zYnKQWi9oupRpEnkwzhI30aYYxd/SNHHv6wRPM
         QzOE6MK/FJ2zOZLxxZRnb/qT2umWfgbVxBdsTJBbiTmmav3uugBS2ULmWzfYpi5ZRvee
         4JwpBzoRvT/vJ8Mlec70YWBCxhB0qcYMY+h1eeFbL3FHHUN3xMH7o8jw/7k/01U76G0m
         zK06JWKY/qG2cuV9TunQZaROZp4vfEuOmhZpQwOYBaUPl1VOW++ci/E76DWDcjYLGzpi
         zlSLG0XTjcdgkH6YPHmQ1GHq6uTP+fiGOes65MPzug2FL7e5JlrSL7YzMe7CHO0C6ztD
         aqpg==
X-Gm-Message-State: APjAAAVRiwfTMncMGrP3oo2ES/6safKZJtNLL4ySCa3xuTrsLVreFeAM
        yqQXc+mmmyZ5iOrMSTNwnMNBPfqg
X-Google-Smtp-Source: APXvYqygSb9yccN0GFabj4MMsATDGDUIKCShWULu3efw0Wwdj02JGA47qkbMQUKzv7Put1QCPNQTBg==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr6297192ljg.246.1571412719588;
        Fri, 18 Oct 2019 08:31:59 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id s1sm2274235lfd.14.2019.10.18.08.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:31:58 -0700 (PDT)
Subject: Re: [RFT][PATCH 2/3] cpufreq: Use per-policy frequency QoS
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <2811202.iOFZ6YHztY@kreacher> <20154332.AJkCBzCetj@kreacher>
 <1707f018-fc6b-0122-17e0-635340daa4ef@gmail.com>
 <d88fc9b4-24af-6081-96e4-5a0b93c59d43@gmail.com>
 <20191018092933.2i7dpr35wkxemgby@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a4337199-5a69-1604-836b-f69436865b11@gmail.com>
Date:   Fri, 18 Oct 2019 18:31:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018092933.2i7dpr35wkxemgby@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

18.10.2019 12:29, Viresh Kumar пишет:
> On 18-10-19, 00:29, Dmitry Osipenko wrote:
>> Viresh, the warning is actually triggered by this line:
>>
>> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/opp/of.c#L664
>>
>> So it looks like the cpufreq-dt driver removal drops
>> opp_table->list_kref more times than it should be. I may try to take a
>> closer look at it later on, please let me know if you have any suggestions.
> 
> I was able to reproduce it and have sent a fix and cc'd you on it.
> Please give it a try.

Thanks!
