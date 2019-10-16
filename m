Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4BAD86CD
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 05:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJPDiN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Oct 2019 23:38:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40359 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfJPDiN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2019 23:38:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id e13so5201647pga.7
        for <linux-acpi@vger.kernel.org>; Tue, 15 Oct 2019 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDw1E+VxBs/5UND1mf/klt16slydi9JotBXF01e+CRk=;
        b=kyDL16WHaN2o9selPh6MHGPHfV+X7wEq0FllVlq4/AMM/N0LVOftGKRuCwqzhga1Hd
         cdN+t0MyQmeFRJ5bf/XbDXmItS0ZWVX7UiLiUci5QgPuJ0pmI/mAIAOhsVOExjXSLXDk
         WCFFMMunb9/gDv9fzRuwcEBPTAfrgn2BIMd7bsPFc9ZEvqcn3DgN99CzDKWE1tGebs5x
         6vF/R0l5IS2cpf/QJz71tCyEslIqkHo+nXy2rjOCY8UdaKI5fPfbIO9owHZ/WIva3dDB
         ++BCPIgmNCv0Mm2uFmWjsB7CWPUdt7AcPg514jBVxgt4Lt/OWXlHaApJAdDUsRfJPF9d
         J/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDw1E+VxBs/5UND1mf/klt16slydi9JotBXF01e+CRk=;
        b=lpD72yBujmgCT5IU80Y6GG3E0mRHTvpzh9lStwncJNr16Ce2OpDJ2AZ/9wKOgv4/TR
         V+g0B8J4oVMG8K6DYRNhjU9nVoPpNnoDOFNW+s5DYpwauiUwWVOdXlXX2yBCJcp60LKk
         p+LpU3k1jeKTwo5TMoFhnByHygSLHlVvkLsVlFYfaVGcO/YWjN+RSYQdbUm0yrQ9soRN
         ZakO1XXASqyFWKhErtfU0Umbdiezh/6xYbK6XqInGhzQM+8/S+zqLwRylVrPmq3kOrWs
         YSyTP0ZBk43+/QmzKYPSZgjgQTqedb7/c0FAuD7LeLcwUrcPsLK64hh+1Jsjgix5h2GB
         a+0Q==
X-Gm-Message-State: APjAAAUidGJ2gZVbk6gQNhFT8AqrfAgPRnvSlwnNx9cbfbhSXrh/NZpA
        1gXNiAvZRa1G4MM/JZzRiBAA4w==
X-Google-Smtp-Source: APXvYqxIMFWNe/yMHUCIaIMu64JgM3ECcEsbE/RT/QAxjCKzVVSrI8MfKrdZOI2NiD63SyqLmhqvNQ==
X-Received: by 2002:aa7:9ed2:: with SMTP id r18mr41382466pfq.1.1571197092543;
        Tue, 15 Oct 2019 20:38:12 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y17sm32299937pfo.171.2019.10.15.20.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 20:38:10 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:08:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI: processor: Avoid NULL pointer dereferences at init
 time
Message-ID: <20191016033808.uqgc4ss6xcg4ta5v@vireshk-i7>
References: <9765491.cFa8AugBjT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9765491.cFa8AugBjT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 15-10-19, 19:35, Rafael J. Wysocki wrote:
> rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If there are neither processor objects nor processor device objects
> in the ACPI tables, the per-CPU processors table will not be
> initialized and attempting to dereference pointers from there will
> cause the kernel to crash.  This happens in acpi_processor_ppc_init()
> and acpi_thermal_cpufreq_init() after commit d15ce412737a ("ACPI:
> cpufreq: Switch to QoS requests instead of cpufreq notifier")
> which didn't add the requisite NULL pointer checks in there.
> 
> Add the NULL pointer checks to acpi_processor_ppc_init() and
> acpi_thermal_cpufreq_init(), and to the corresponding "exit"
> routines.
> 
> While at it, drop redundant return instructions from
> acpi_processor_ppc_init() and acpi_thermal_cpufreq_init().
> 
> Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_perflib.c |   10 ++++++----
>  drivers/acpi/processor_thermal.c |   10 ++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
