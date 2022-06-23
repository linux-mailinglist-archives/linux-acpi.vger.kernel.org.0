Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6DE557769
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jun 2022 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiFWKHM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jun 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiFWKGt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 06:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD59449FAD
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655978802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MioxYM3pNfOVLGO8cTNLJgT0cBlvjug91OSVJzVKM8E=;
        b=TFC9S9TP7H8obJw7894PfsbP0CSFn6HXzU4Q3eHcjaIINbMPW4KNtZHkBqbiw3WQ9Ou646
        TU9hqoI51UWgp132LpjnyiE1JIQYqDnFdneZCPWnNkFV6+tHbg7PFzAS/Pgyg38K1O6nA4
        6fn/FdAKylXqC5FYXTJDlF4xa+aGFTU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-Ujh0ljr8N4-1v6_V1wOCIA-1; Thu, 23 Jun 2022 06:06:42 -0400
X-MC-Unique: Ujh0ljr8N4-1v6_V1wOCIA-1
Received: by mail-ej1-f72.google.com with SMTP id qw12-20020a1709066a0c00b00722e6059673so3499813ejc.10
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 03:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=MioxYM3pNfOVLGO8cTNLJgT0cBlvjug91OSVJzVKM8E=;
        b=KYNt54oWmGpvKoxVBpuL38sLTwtrsaGu1em/yalDEqIirM6SCKU3yJHiFYyyOpVdD9
         9UJwYkCP9DfMS2jcianPBaLQNXBcwNv0QYk0K0+ZwwH/DdU2WnaqrVkAiiXigadZVUjq
         XPTYU7VoGBj/Lf6RvQ26Fvxv5IjqHqEN5vcUB7wygdghvau7w1BOUujr1VCwbJkQpPZh
         CKWtniUm3AmYOYbgOVJZV0s4qvvFAf58+RisTbzix7r7/VS67EUWwFEKdYr+1IkIcZaq
         NjUfmYJdNyT7fsqXLDdYM7BemGSxMcCUezGTnkAGdghsGAKXZiO/Xeg2C+vIb2l9xY6l
         Ho4A==
X-Gm-Message-State: AJIora9iCYfUHOKuBk+U1i00upjbsv7g6drFVoam7xL+XhAKU+z0sdEy
        p5IiocTm1YvAvWXx97pA+BsaDNyuufu+jaXeI+n/E8O8J7GPm1k033ozbJQrqw6GsXbeg/qvemr
        XRxjOnMEJMDFPyk0QKG+JkA==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr9274090edu.39.1655978800588;
        Thu, 23 Jun 2022 03:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v37TQT00xpGm9EZ6fLVsyBKDjYgnUbsIr3TY/LWilvcid/aWwNH4myyTsGzwkbjJ9htNpshg==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr9274071edu.39.1655978800405;
        Thu, 23 Jun 2022 03:06:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709060f0f00b006ff19354f9fsm10468108eji.215.2022.06.23.03.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:06:39 -0700 (PDT)
Message-ID: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
Date:   Thu, 23 Jun 2022 12:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
Subject: "Revert "ACPI: Pass the same capabilities to the _OSC regardless of
 the query flag"" is causing regressions
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Mario,

Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the
_OSC regardless of the query flag"") is causing the issues fixed
by the reverted commit to show up again, see:

https://bugzilla.kernel.org/show_bug.cgi?id=213023
https://bugzilla.redhat.com/show_bug.cgi?id=1963717

both of which have comments from the reporters that
the error message is back again; and presumably also
that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
again.

Can you please take a look and see if we can come up with
something which fixes both the re-surfaced issue, as well
as the issue which the revert tries to address ?

Regards,

Hans

