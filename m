Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DE2ED4B5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbhAGQqt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 11:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbhAGQqt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 11:46:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC3C0612F6
        for <linux-acpi@vger.kernel.org>; Thu,  7 Jan 2021 08:46:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c124so5704948wma.5
        for <linux-acpi@vger.kernel.org>; Thu, 07 Jan 2021 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtKZ9TQkml6Lz7+hOPcIIWjt0mc1TgS4RME7awVcoUI=;
        b=pAKb7F2epYX+2fWfSSnlCutGRT89eo+e7/vLUaho+Na3wwaVB2uqRVbt/wSVvFZGaT
         mJiNuTHm6yQ7bhKv57MZa0IdM7dVO7CwI/RVV7iZDPHiy5tMcglm4z+Z+pNp6UdoO6Sm
         H6wq2uKqD7Xol9PgYz//vNers9MsFE+JOKOqOFomK2ZQLMNFQ4zfLGavmT9etDoMJF8f
         vsjy6M13/eYDPZUTNoDvha+KExikH+K5WKMfrfFKF//wmFGa+gnIwbGKz6FrCg+hpva1
         TDtrm+aMA7BpF5dkKyu5BSJbOxBoz4nQ2yt8kPyYuxrdA0wDUGDc47qRYwulqFXoma09
         2Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtKZ9TQkml6Lz7+hOPcIIWjt0mc1TgS4RME7awVcoUI=;
        b=Z5Ga3cfWhbT+1VFboxUzlHG9QRT9d10NwIGp/9+WHTST0fAOcaDi1IAiPawqdOrQhh
         s1EGFwjjGx+dQ0tvxUspSxETttSasnlbXsR9/93wY4KY/SYr6IZ+o3mgeJejX5HnaTnH
         TCEr5yFIG2NIY1UbXFupK11x8lWefsgyrGkMKgqW4WJX0bww+1IyAhlI6Sp3ClEGCiOa
         o7ARyys1iP0dtZkzBG5IYStTEgsuP4A5zj805xIu1BQoA0Ks2F8eGsav5pYWQVz6vpg4
         jECQCx2+WFmPhpyp4KWnDRlT8Uhra6ezRyjKcsbMq4eLRXXRY6Vuiduaq9A3ZU7OxQVl
         kA5A==
X-Gm-Message-State: AOAM530FXB74C2aOIg0EmftihEM3j7Jftzrm89lBFJzc6jQwpIn6qvo7
        afWdLAp3cnog6rzmDb6L4FY7Q3h3otM03Q==
X-Google-Smtp-Source: ABdhPJzrd2xngVKWYGStgfLM787mlgYrvi1phj2XWmYfICSkBsmlVyljWKhO8ZM3wAurS9c00hiBUw==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr8604081wmg.145.1610037967332;
        Thu, 07 Jan 2021 08:46:07 -0800 (PST)
Received: from [192.168.0.41] (lns-bzn-59-82-252-152-224.adsl.proxad.net. [82.252.152.224])
        by smtp.googlemail.com with ESMTPSA id m8sm8870434wmc.27.2021.01.07.08.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 08:46:06 -0800 (PST)
Subject: Re: [PATCH 4/6] acpi/drivers/thermal: Remove TRIPS_NONE cooling
 device binding
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "mjg59@codon.org.uk" <mjg59@codon.org.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
 <20201214233811.485669-4-daniel.lezcano@linaro.org>
 <1de4868e-6229-ed33-f45a-7cd82d3ee48a@linaro.org>
 <cb755a9f2b314dcda0392fd5c08f7fb9@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <493103a1-df95-515d-9d4d-1508685aac0e@linaro.org>
Date:   Thu, 7 Jan 2021 17:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb755a9f2b314dcda0392fd5c08f7fb9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 07/01/2021 06:10, Zhang, Rui wrote:
> ACPI thermal driver binds the devices listed in _TZD method with THERMAL_TRIPS_NONE.
> Now given that
> 1. THERMAL_TRIPS_NONE is removed from thermal framework
> 2. _TZP is rarely supported. I searched ~500 acpidumps from different platforms reported by end users in kernel Bugzilla, there is only one platform with _TZP implemented, and it was almost 10 years ago.
> 
> So, I think it is safe to remove this piece of code.

Thanks Rui for digging into



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
