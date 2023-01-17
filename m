Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D0066E7D1
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jan 2023 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjAQUjU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Jan 2023 15:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjAQUfh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2023 15:35:37 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E82252B3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 11:20:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h184so5939729iof.9
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2023 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQQhGaa8ME/qD8GrOmb/LR8k+tyYKhHj8WpJOgJmL40=;
        b=N7yg3KxlCKSsu1VLFwTpGLiGTU9blVjz991dhmvqJBNqTfCy4BzvkPgeUjMrUYfSy7
         /FxMBE0zLvyO99Y2aDlH1urHHynquVL1ldUueDFvMzJymo9wh22fKm27wHn1OzcAvL2T
         yYe+MedHIUiQkwelizE9HuJVyQAPyC7xpw4b03TB4gKah2lNdziKu2cPMS/vPNsx85zl
         dM1VbsPr0pQDaJLu/4imj/uLvr2B1Se8zh2vsO17KX0Ev6i94T7OwXZ8UphY4LQePhVc
         HxR2F3B+CsvOQAhA5VwqE7riipIdmRRGiSzUoS3JcMcwJdBOGWUZJlbWW8myUH+mk0Vh
         ksGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQQhGaa8ME/qD8GrOmb/LR8k+tyYKhHj8WpJOgJmL40=;
        b=bo0wdvVvV10DVou8dBfwmCWgkwd0u+UEl7fS3crLzKDEm2OZJkiCD9aB1tS2lPuiaV
         qm/WauAQWFxGAXsdeL63QNI3LvF4/ksuBbt6UtdFgIIz4aIkyoTx0PDaU8YIDl94jgI5
         pBlzkEx85DhwkH+4hqkJPOiJm0gYtONumRQUHp7OxVNXi6g319cTPUvMmnCRCQxq8B2b
         B65hKk+IzXVvCp85ZdiEZ5HfUWfd1UdADeGeZW6neGl5ShNDY0u/K1On+nbMnh16f1Yh
         HgNn/mn9bKdJFgsJFmdOSRhS+77v7vaJQ+/hl/67WRUrU4gc3rGS12esmFaLK64ErmsG
         bOnw==
X-Gm-Message-State: AFqh2kpFc8Rw4UEiF/J4libOPalwoFGkjBxp1rIXx6U1zCbplBuUiQxF
        sUk0KLq99EWrZlfIHAPz90GazQ==
X-Google-Smtp-Source: AMrXdXsRiQGWp5HyS8FdEGoGTMhjd2qK1yDflbDU2KXk0dOG/CUpT3PLJ7xrBuniiCZq5cJTQXdJqQ==
X-Received: by 2002:a5e:df08:0:b0:704:6e8d:4891 with SMTP id f8-20020a5edf08000000b007046e8d4891mr3332526ioq.3.1673983246899;
        Tue, 17 Jan 2023 11:20:46 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id o13-20020a0566022e0d00b006bb5af55ddfsm10651735iow.19.2023.01.17.11.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:20:46 -0800 (PST)
Message-ID: <b9686ab1-8f18-4175-2581-df84ba58e3ce@linaro.org>
Date:   Tue, 17 Jan 2023 13:20:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 00/28] Drivers for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <83b6dbc2-01da-04b6-64ec-9a69fd5c4c89@linaro.org>
 <d945e654-9679-72d7-bb79-d09c45f6d5aa@quicinc.com>
Content-Language: en-US
In-Reply-To: <d945e654-9679-72d7-bb79-d09c45f6d5aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 1/10/23 3:47 PM, Elliot Berman wrote:
>>
>> I haven't looked at the earlier reviews; perhaps the RFC stuff
>> was requested.  I'm sure it's useful to see that but it doesn't
>> seem directly helpful if your goal is to get this code upstream.
>>
> 
> Right, the RFC patches were requested. Do you have a recommendation for 
> sharing those later patches? I understand it's best practice not to post 
> too many patches. The logical split was to have 1-20 go in first, and 
> the remaining patches submitted later.

If they're RFC they should be tagged "RFC".

I do think it's easier for reviewers if you can divide up the
code into a few smaller series, so reviewing each (sub-)series
isn't such an overwhelming thing to consider.  I've started
looking (IN GREAT DETAIL) the RPC core code, and haven't gone
much past that, so I don't have any guidance about how things
could be structured.  (I do appreciate that the early patches
were small, and built things up gradually.)

I personally try to keep my series to closer to 5-10 patches,
though the maintainer(s) involved need to agree to accept the
smaller series before the full functionality gets enabled when
it's all accepted.

You'll get (lots) more feedback from me on the remaining patches,
eventually.  If you decide to re-spin things soon I'd like to know
your plan so I can review the latest when it's available.

					-Alex
