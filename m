Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987D03B89F4
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhF3VF0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Jun 2021 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhF3VFZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jun 2021 17:05:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F361C061756
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jun 2021 14:02:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so6557286ejg.8
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jun 2021 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OO0nZiXrDUECIGR/D0Vafqkt409nF3+RGOok3dgFDPA=;
        b=bU3W84IPcwlV/op27K73mdsSZZctj7xZ9AUm/b4WHbmi1i+GCQzf9xz58wHWumvPEi
         rSauxGKZ7+qCkf5lx8bzAz3yMeZioIgM+zFlckEHmLZr1yLJCj0PDiFBLWdp84G/Tqsk
         bB15zV62T0tH7nWcyv0CY5TRWXpF3d0iwtFmqI0FZN8TK5B2SwyWEGBr3QDtJpXAxDW8
         G1g0tf29EXCtrbTFR8MoDmoeS1vmrkDDpWG7K2Ux1UH4zYYbZUUnRxad907ZGy+rIpDY
         ck5heX17m2yPpXHaqYYv8JV2RChkECgbaVHsJE71oczRzyEH10OdbdEiTV10FzIvX9RS
         W68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OO0nZiXrDUECIGR/D0Vafqkt409nF3+RGOok3dgFDPA=;
        b=cJ2xvtcF8EnjsRR993teUeftIZQ8RA3tn99ZJhmGSoMzyVS3kuS8S7/dP5Zx1WosK8
         pyz2lJfVljNuQabtR/NiyoKcaAIURluNzkWEsPmbb6XE7AsW+fX3gulubMtWbl137bLa
         45FnQDNYxfyaB1OrsBc9+nwLhHNrHA5w3CHq+fanBOGE6hcvU3UAAHMGWNbO86UmDK3f
         y4zSZEoPhqEQdQYtDiQ6sU6hnNNL4OI+9ahsq56HEChSVIgtUchdNaQq4N4lCwduxMhX
         lwhVd0dpdt1m2gbefcMW+PT32zpm6DZR4oEbn/vKSzccdd58qnAe88tiHOhWXPsr7V1R
         TWhw==
X-Gm-Message-State: AOAM531no6CukYY1PyQ6oRlzgMBMk3oQc1QeW33qUQw5dPozMClXMTep
        iQR+utUWCKuN7pCLWP9Ub6M=
X-Google-Smtp-Source: ABdhPJx84/d0LL/50uYB0KmFH9WKZsXtcn+DED7ulADTum4A5CmrARqxmyy94WUY+d4mvGqe1Ilbkw==
X-Received: by 2002:a17:906:fad5:: with SMTP id lu21mr37896836ejb.469.1625086973839;
        Wed, 30 Jun 2021 14:02:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::17aa? ([2a02:908:1984:a6c0::17aa])
        by smtp.gmail.com with ESMTPSA id d6sm432212edp.59.2021.06.30.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 14:02:53 -0700 (PDT)
Subject: Re: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>
References: <20210630194606.530-1-mario.limonciello@amd.com>
From:   Julian Sikorski <belegdol@gmail.com>
Message-ID: <38ff629e-c937-2afb-215c-83e6c24bd54c@gmail.com>
Date:   Wed, 30 Jun 2021 23:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630194606.530-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Am 30.06.21 um 21:46 schrieb Mario Limonciello:
> When using s2idle on a variety of AMD notebook systems, they are
> experiencing spurious events that the EC or SMU are in the wrong
> state leading to a hard time waking up or higher than expected
> power consumption.
> 
> These events only occur when the EC GPE is inadvertently set as a wakeup
> source. Originally the EC GPE was only set as a wakeup source when using
> the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM:
> Set up EC GPE for system wakeup from drivers that need it") but during
> testing a reporter discovered that this was not enough for their ASUS
> Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
> Marking the EC GPE for wakeup universally resolved this for that
> reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC GPE
> for system wakeup").
> 
> However this behavior has lead to a number of problems:
> 
> * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> sometimes the power button event doesn't work.
> * On HP 635 G7 detaching or attaching AC during suspend will cause
> the system not to wakeup
> * On Asus vivobook to prevent detaching AC causing resume problems
> * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> * On HP ENVY x360  to prevent detaching AC causing resume problems
> 
> As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-8550U
> that don't use intel-vbtn or intel-hid avoid these problems by only
> universally marking the EC GPE wakesource on non-AMD systems.
> 
I can suspend with lid and resume with lid, power and keyboard on an 
Asus Zenbook 14 UM425IA with 4500U so there are no regressions from 
using this patch at least. My laptop did not fail to resume all that 
frequently so I need to test for a bit longer to see if this patch 
improves my situation.

Best regards,
Julian
