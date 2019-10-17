Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7957CDA904
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408649AbfJQJqR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 05:46:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34957 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393123AbfJQJqQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 05:46:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so1305008pfw.2
        for <linux-acpi@vger.kernel.org>; Thu, 17 Oct 2019 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HA1gROLlU5nGU3rZp9KPpPiUhlmPzfUUJa/DdhRHaus=;
        b=DsFChQGcXp/0iKktNloQYHrCgctEcJmlGRFe5cJtd064ngexVy5CRyAxFJHY8aZPmh
         H+WTGsg3MCA18mom70GTV4yMoRU+0splvu0vWL0Fj/tD1slcmF0KzCGKn4qPyI8CdrIY
         3QU+pVnjgLTFZjL3l5PH/IuLilMbvi7tE96zXxd6eeqYJjRcMczwBJ088Y3+JHTxngB1
         yNCe164G7MqXquzb1QZWaPfaaA4tBpAITRRTX9lK6PO3JTh7sIQCs9SzOsXQo8YnlZr2
         uMP2fdizjwe0KKZ5Qpz7x1xURymp2OPpbqsEHwiVpRhq79xd5Nk0rmSyqO6kMHHaALl/
         M6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HA1gROLlU5nGU3rZp9KPpPiUhlmPzfUUJa/DdhRHaus=;
        b=o8g9/IJMzL6+E10QlxzAIhOiIoO6nrU4cYfrV9Oy01uwK+rx0VwhVCZMsE422QErjK
         atIrKcbHEDPIuwrxR2uJfNV51guhjXI7zEGBerEjoVzCxHWUPXOiLkEnZOcbNOnh1PLy
         lR4Fl7tr9WS/6LOh0T3I4JSLlx62p3v910IcLEh+ceUdqNdY0auELfgUhnA0EQcVx0wI
         NPkiV13Y+o6aCHJVqJlme435zrdpYZh6vuYOSxRV1kgjDc6no1cfDz59XgBwaas7/+dj
         VFVfEtJ/yqBa1ClP1QajMkW1yuSsP9f486nWVaaBq/O0IVowCQriRorDAplSKIHhz8pU
         xaPw==
X-Gm-Message-State: APjAAAUujTzb3cZxh/Qfp380n5PlbxbrMvRG2N9q+TTdtHn1CaSmhWcv
        aHBlaNYVTqsx7p3qfu86NMemdw==
X-Google-Smtp-Source: APXvYqxRRGkNYrj4IvnEwznK2d7owuc1bIYg4jbYp+1Gxo/TJcJlDlIYX89z/3q85T0fIfNrQtQqSg==
X-Received: by 2002:a65:6701:: with SMTP id u1mr3132918pgf.368.1571305575072;
        Thu, 17 Oct 2019 02:46:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id s202sm2510839pfs.24.2019.10.17.02.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:46:14 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:16:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191017094612.6tbkwoq4harsjcqv@vireshk-i7>
References: <2811202.iOFZ6YHztY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2811202.iOFZ6YHztY@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16-10-19, 12:37, Rafael J. Wysocki wrote:
> Hi All,
> 
> The motivation for this series is to address the problem discussed here:
> 
> https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f
> 
> and also reported here:
> 
> https://lore.kernel.org/linux-pm/20191015155735.GA29105@bogus/
> 
> Plus, generally speaking, using the policy CPU as a proxy for the policy
> with respect to PM QoS does not feel particularly straightforward to me
> and adds extra complexity.
> 
> Anyway, the first patch adds frequency QoS that is based on "raw" PM QoS (kind
> of in analogy with device PM QoS) and is just about min and max frequency
> requests (no direct relationship to devices).
> 
> The second patch switches over cpufreq and its users to the new frequency QoS.
> [The Fixes: tag has been tentatively added to it.]
> 
> The third one removes frequency request types from device PM QoS.
> 
> Unfortunately, the patches are rather big, but also they are quite
> straightforward.
> 
> I didn't have the time to test this series, so giving it a go would be much
> appreciated.

Apart from the minor comment on one of the patches, these look okay to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
