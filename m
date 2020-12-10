Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6A2D6533
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 19:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390842AbgLJSgf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 13:36:35 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:42039 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbgLJOdB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 09:33:01 -0500
Received: by mail-oo1-f65.google.com with SMTP id x203so1315217ooa.9;
        Thu, 10 Dec 2020 06:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k62Ve7mlBGGKYnLuZVHB8mMB87DGHB1By9AKQqAliVw=;
        b=TS2XoujjUkgV1LYJ4nbdQV0XfPv+mJcZ/uGt7DU4uM4ozF1FnhyKGsQvN0nCG15JgF
         lCoNNHzXKzZ/ia6ZBk1z+P2PziGAANbx5RBw5F+FZsazJuuSIsyDem7ps4I5Z3dTJW4l
         02PMjKj6903sUetAlQfDReaAHU50+jcYNNg2sYXW8xALP9kWghymnkiEFL3+lOLGdcb4
         50DXf2W4jMf+qvHlBJdalOGnCjezPzRkUS8bQO28xWIWjmW2oc2lCV8dnxfH6G349UWO
         JJhso9kEZoV0raQPLZFOIRITbSS8/yRK+G2+gsoJApERC8VzDv5ZI5VA3fgC/hEKLDNW
         eu/A==
X-Gm-Message-State: AOAM5310CcSl5riaffpNtK0yw5WBIUOalwllsrLf+HJfyZ4Vx722CDzC
        7yEslr8pPfNBUqLV1x3m7A67BGAXjokGi/q/RIY=
X-Google-Smtp-Source: ABdhPJxsInWkuQMARndOZonBEuc0OjkBD+vUgPSyChtLKlr7QodvM1uxGMaD4o5So/hwQumvATutmKPpcaCfcxSFQK4=
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr6089606oon.2.1607610740318;
 Thu, 10 Dec 2020 06:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20201210142139.20490-1-yousaf.kaukab@suse.com>
In-Reply-To: <20201210142139.20490-1-yousaf.kaukab@suse.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Dec 2020 15:32:09 +0100
Message-ID: <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
To:     Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Petr Cervinka <pcervinka@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
<yousaf.kaukab@suse.com> wrote:
>
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
>
> Since commit 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with
> lists"), cppc-cpufreq driver doesn't check availability of PSD data before
> registering with cpufreq core. As a result on a ThunderX2 platform when
> CPPC is disabled from BIOS, kernel log is spammed with following messages:
>
> [  180.974166] CPPC Cpufreq: Error in acquiring _CPC/_PSD data for CPUxx
>
> acpi_cppc_processor_probe() never succeed in this case because
> acpi_evaluate_object_typed("_CPC") always returns AE_NOT_FOUND. When
> cpufreq core calls cppc_cpufreq_cpu_init(), driver fails to obtain PSD data
> and print error messages.
>
> Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.

Honestly, I prefer to drop 28f06f770454 (along with its follower)
instead of making this change.

> Fixes: 28f06f770454 ("cppc_cpufreq: replace per-cpu structures with lists")

Thanks!
