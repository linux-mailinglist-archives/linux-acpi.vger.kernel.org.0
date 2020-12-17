Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7542DD1F1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 14:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgLQNKx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgLQNKw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 08:10:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE16C06138C
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 05:10:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 190so5523205wmz.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2020 05:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RSBE/3zCRI/fdlIa2O85+j7iTM1Xd4ZHnkVFYuERLqE=;
        b=akD+QnmT3IHGlQ5L7v4Y7apNAE2VpUxEloBUxoQyBkO/E4Uy8ICKJnCGeV1x5z/KqD
         EaoqzlKVQ82psG4l8kfAWtAr2fKX/+fCwvBUg86RRMiCaUnW2aYodi4ABa9/yTMVwyAG
         lKn0avA8C8JKRlGxIaLK1+hQHb5rD9BnDVJcaPI6KasxhABHKOF1KkyZmD5SP6vAE1gE
         R3Yq62k2OXtqm7N6YUO6NIF14lGz9pU0LNPDngrfpBwOfwRkuLSvzZkXe+RadYSfqJF8
         5UTzj+W9hXBgxKNYlkYZNV3e6ck2shDJFv10W0N44Klxz0rV1l5QKe/D/DHvcyDJrQbX
         gH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RSBE/3zCRI/fdlIa2O85+j7iTM1Xd4ZHnkVFYuERLqE=;
        b=BVV0Fg8BJTIg/6ExPlkhk83z9PHljFh1qvPX34hgtZGXg1XDXH9C/8pc5L/9VL+/jp
         iSSHwPs51BVtCEw8h9DVV4OU9D4RhKyRaNjl6MmdZiWBbO6gQ3xyAc2WOdpB7nFAQtew
         3q721Of9p94QIVq+mjIL26TQutU9aZdHZVE7YBS8+RsPWO7UC9YO6shLcM5LDTPKSQmD
         AK3H9fdIv4GESruu3q5Sw0dqdP3Ez75uC+YNc3Cc0cENqmuMd/aaeKwLEMuHPn9lWCBw
         fKtzWfr+Um8iguNSSlIwU/bDmoNsINe3JJngnmldmRyeOfctrmVMTU+/+48RDfCwCv4V
         jyjQ==
X-Gm-Message-State: AOAM532Xw6WwgBUezyhfeo+A+AH4Ej8uN4GPQSdj/NGnsQy9ytoPDlC2
        3hejIlG9DDjakk+fcJbUFBq1rpEQJKST6w==
X-Google-Smtp-Source: ABdhPJwANsRN7e8V4fLkplPexm3aweo7K9eQxQVy9vWxCfpQVDnEO0QeHwRf+NBUrOjxXo/B7RZ3lA==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr8182463wmi.19.1608210610707;
        Thu, 17 Dec 2020 05:10:10 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead? ([2a01:e34:ed2f:f020:ccb6:ce78:2bcd:4ead])
        by smtp.googlemail.com with ESMTPSA id d8sm7756941wmb.11.2020.12.17.05.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 05:10:10 -0800 (PST)
Subject: Re: [PATCH 3/5] thermal/drivers/acpi: Use hot and critical ops
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com
Cc:     kai.heng.feng@canonical.com, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
References: <20201210121514.25760-1-daniel.lezcano@linaro.org>
 <20201210121514.25760-3-daniel.lezcano@linaro.org>
 <c20d9077-66e8-f947-6422-c48e2f679cc5@linaro.org>
 <2b101b07aa18e06a32b26add651a3d2e009e6d18.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a91f984b-eb38-3fcf-f968-e3afb36d5f65@linaro.org>
Date:   Thu, 17 Dec 2020 14:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2b101b07aa18e06a32b26add651a3d2e009e6d18.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17/12/2020 12:38, Srinivas Pandruvada wrote:
> On Thu, 2020-12-17 at 07:28 +0100, Daniel Lezcano wrote:
>> On 10/12/2020 13:15, Daniel Lezcano wrote:
>>> The acpi driver wants to do a netlink notification in case of a hot
>>> or
>>> critical trip point. Implement the corresponding ops to be used for
>>> the thermal zone and use them instead of the notify ops.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Is there any comment on this patch ?
> 
> Looks good to me.

Thanks for reviewing


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
