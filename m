Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97383C85D
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2019 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405038AbfFKKPW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jun 2019 06:15:22 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:32850 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404572AbfFKKPV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jun 2019 06:15:21 -0400
Received: by mail-pg1-f171.google.com with SMTP id k187so6203286pga.0
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jun 2019 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/GhafBGXNChmbHBFBVgo86vnYJ9zTPpY7Pbx4Oe0Uw=;
        b=RD/wogDOJ5xjsvAegTRryAjNB4B4OpHpeQicOj+zqZ5bm8PyJfoaGzpyQ2rZkCNRa5
         WBz3Q8Xs5lT+MosEj08qvDK9whR94kSUv9YquW37uV0gwNSWFqKSyw7UnzHcn3Hf5yIY
         1yiaeDHDXJgEdXUU3ciTALWC4ynidLB2F2g/AycGAR2UQesDWIhdfd7rJKZpRMMEDqT3
         Fvv6KJtQKn6ZJjOaZpH2iZiJJyWjAEVYwuLFh9HzChAcAuAU3f3QQjt4AUcwuXG5G9Lw
         Uf7n7vXptP+OVO7JGCCxdXYMoIsQAJWNT+Yxqko3OCyZvmgGYSA5hfkJCNTcrr2jYVHu
         4+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/GhafBGXNChmbHBFBVgo86vnYJ9zTPpY7Pbx4Oe0Uw=;
        b=ri5DJutcA3Rqs/7PvdYpEKl2pSS7nlHiN/HCvA1l3nogxTZOxBihN7+hpLriMJwV3a
         1ia/vF8+0ZiMiu9JQbJIV/btfgxkk7x30xzgPucGLd1qc7hvLkt2na/BCbfc/oOc3UOE
         hDNfqJzbCygA8qU8JQDSn6Fltl+Pd5uEgPnSNIX/hMNzOrp44xqNjwZpqLVzTS7NGTkZ
         PvFEVlppl8pfGkh9TUBn8poybuj10bkVclg63mZklBQ1bQF01G2yYYNzQTTffeUUEKB+
         vEYu/LfIf4QXbS2c7U7HyNecEDI6cV9C7FYN095MuDw76JDwpHPpHptBQ8QCicOMt9dO
         xVdA==
X-Gm-Message-State: APjAAAXNQiAZxSPIcujAlJoXc0fognArUrZ4Hk9QWFBXzu/tivqNuWEL
        T8QwTaIQ380UyrqyMCFjaQNF0g==
X-Google-Smtp-Source: APXvYqwlcoxl7UcVZb3734sAW5vLeJRYA+E9ELIimvMTJNTcihpE5xxaq0vv1rE0oQ0DUhIqh7fw4A==
X-Received: by 2002:a63:e50c:: with SMTP id r12mr19633924pgh.284.1560248120768;
        Tue, 11 Jun 2019 03:15:20 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id k197sm6495503pgc.22.2019.06.11.03.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:15:19 -0700 (PDT)
Date:   Tue, 11 Jun 2019 15:45:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Zhang Rui <rui.zhang@intel.com>, daniel.lezcano@linaro.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Subject: Re: 5.2-rc2: low framerate in flightgear, cpu not running at full
 speed, thermal related?
Message-ID: <20190611101517.jen4bbiyqzdz4f2r@vireshk-i7>
References: <20190609111732.GA2885@amd>
 <20190609112340.GA9966@amd>
 <20190609121212.GA4520@amd>
 <1560089580.2363.10.camel@intel.com>
 <20190611101213.GA4256@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611101213.GA4256@amd>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11-06-19, 12:12, Pavel Machek wrote:
> v5.2:
> pavel@duo:~$ cat /sys/devices/system/cpu/*/cpufreq/scaling_governor
> powersave
> powersave
> powersave
> powersave
> 
> v4.6:
> 
> pavel@duo:~$ cat /sys/devices/system/cpu/*/cpufreq/scaling_governor
> ondemand
> ondemand
> ondemand
> ondemand

Hmm, the governors are different. But powersave should have picked the
lowest frequency always.

What about cpufreq driver ?

cat /sys/devices/system/cpu/*/cpufreq/scaling_driver

-- 
viresh
