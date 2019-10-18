Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF89DC0EB
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 11:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409732AbfJRJ3h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 05:29:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41035 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733157AbfJRJ3g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 05:29:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so3506373pfh.8
        for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2019 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0wJcF0+MU8onT4dQlcS5SYf3gjezQhPtNmK0I7nY6I=;
        b=AC2Lkt+54mTJ8oA7oUAFoCNuCudKUP69OuYq8gUduwPZydK3rvBO//TtYfOpIs7xw9
         rWyccryi7QP4SA2CgY8TDSk1BJx2ZDZKA1bx4OeOhUxBFo+ur3JbMEMrMHIw4o7PA28X
         vNtSql73UXPGvwZeNeYcyDBKU++Hduf0kh6uajhB0cgItaFqHMwHBP7fiEMxkcEpYPyM
         D4OgKxg7+leENuo/IGr+b85l2vhbRPT0HESQSADQbHmG53Rr1pkIjypouOU/ItHz+eAi
         UeP/TVHfsLAwAfgj/psAMseWVV5z4y0kxrQfA4LOipxDtAGpfAh0jckWOaaRYRhLM7px
         eVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0wJcF0+MU8onT4dQlcS5SYf3gjezQhPtNmK0I7nY6I=;
        b=rS7YEWq8ebvWulXKlpfJQ146dUpzJSpdqFTP81r6ZBZset/wNnYl+sA6hENrS7C8G/
         Tk//lan1mOPBmVB+Hwt+gm6LHl4wK1pbJtzXhxTP/GJ+ACfE0hM2GojJ2RC+GYE85cKO
         TdY8xulTLAjLXESuFyLcy3AFULi8NLjdbb1L1O8tSUl5lWOLvvwQbj0wufNckLC7TEJv
         XlooCuPp4eEEo/YFFDPlqhs0F0u8bp+kAiyndhZ6kdT2DSGBgOkr1cgcgDOCyk+7nhl9
         k/LMt6rzKVjo6DhjOqZ1/1olIiQPgNW5OigN84Pru2gH5DeIo2CdNp8v9gqDZ1CaTexN
         bSGw==
X-Gm-Message-State: APjAAAXZ8g2ng8gwQ6vyyiTVihly11elyu6YC9svJtUWvPLg7vyy0Ei6
        LkoDwqYH0AMK7bgjA6qpvoydZL16Sfc=
X-Google-Smtp-Source: APXvYqzdCKqUCleUtrRntSSQeapM3vme2IX5RXZxIKneWH/lOi7AQ4zNoe3fUN+iPFYS2lkzBOzWYQ==
X-Received: by 2002:a63:5a59:: with SMTP id k25mr9044265pgm.171.1571390975933;
        Fri, 18 Oct 2019 02:29:35 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id r185sm5809366pfr.68.2019.10.18.02.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:29:35 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:59:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFT][PATCH 2/3] cpufreq: Use per-policy frequency QoS
Message-ID: <20191018092933.2i7dpr35wkxemgby@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
 <20154332.AJkCBzCetj@kreacher>
 <1707f018-fc6b-0122-17e0-635340daa4ef@gmail.com>
 <d88fc9b4-24af-6081-96e4-5a0b93c59d43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d88fc9b4-24af-6081-96e4-5a0b93c59d43@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18-10-19, 00:29, Dmitry Osipenko wrote:
> Viresh, the warning is actually triggered by this line:
> 
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/opp/of.c#L664
> 
> So it looks like the cpufreq-dt driver removal drops
> opp_table->list_kref more times than it should be. I may try to take a
> closer look at it later on, please let me know if you have any suggestions.

I was able to reproduce it and have sent a fix and cc'd you on it.
Please give it a try.

-- 
viresh
