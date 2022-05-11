Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502AC523BC8
	for <lists+linux-acpi@lfdr.de>; Wed, 11 May 2022 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiEKRmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 May 2022 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiEKRmm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2022 13:42:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234B223868
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:42:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v10so2387237pgl.11
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2022 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=z3CJ1gpLvuDM5QtBSTE3K23PvzQ84RjJX+Vd8J79gsA=;
        b=C9JrgIsGiuA7erbRAA4fegfiWDlBv15+IVASnO2k/aX6S4SF0PzQA/pD7j2AJ+bIR3
         RDwaPoQ4GECUUwdVk97liD4gg5Wqx9WGFGV9q0SrT2QipmtxrDjDMwE2rZmp9o8AKAG8
         w9Fc6Xb2QWdsAM7fUpskO958E6XPx0WnSowYaVxee23YXtQu2mR1UgMiEWzwbZ1YqJKO
         5nQkL7OMoPSqKaCVUEb2SWKNaECWuwJBPvFGKDxzejAhbzMfw2swbbMc2WPBNbADSOYs
         PIOiBLpXm+QiqZSWSwOvaUeUoAcIFXwVBVoEH0Hjf3HEk2Qkq4hG1thRvfswOHLMxz62
         2GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=z3CJ1gpLvuDM5QtBSTE3K23PvzQ84RjJX+Vd8J79gsA=;
        b=riNIxGZE4SSnt6Tye5lykMg++lQkibPULALKARWv8p6XdZc5cy5bzdW0I+HIcR3rNB
         aCj0DlQ/67V2N6sbWaabPlpGEXgagL4phoo9SwAPJ7f1xYKYSL2CnvEisyCZtKxlgqPI
         bTz+SjXSoSzQ8xfrm0IwBzKKjpXFw1559r3MYTdZyYxh+e/hFqcbvsYt3gXydXZvvxLv
         LOsTLRWjxGfwA7fy250K7hn2c0I84ocLDTunR94/HD2MLU+MZxOTM3QVfyzYMgXChm93
         F6/A/ULc1w/UZSPGFE2GNSCvv1SABUDIMlVJII3k2sLYtikRHEuHve2GhOGfMFwVaDdi
         jVAA==
X-Gm-Message-State: AOAM530IoErMubWTc0DvA/fKulBEIuVE8jql0dwmnL8z8yk1ngVsjHLN
        DbDRNcTLd7bG9zvuepo7ftA=
X-Google-Smtp-Source: ABdhPJwacQwjJet5fPIXYvKj/ENpbKgM5riQo9n4e9Np7VUz0WiaDE5elKJzlQL8zrsNHX8EEoAwSg==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr26179798pfu.6.1652290957458;
        Wed, 11 May 2022 10:42:37 -0700 (PDT)
Received: from [100.127.84.93] ([2620:10d:c090:400::4:d897])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a94c300b001cd4989fecdsm210964pjw.25.2022.05.11.10.42.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 10:42:36 -0700 (PDT)
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Len Brown <lenb@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] : Revert "ACPI: Remove side effect of partly creating a node in acpi_get_node()"
Date:   Wed, 11 May 2022 10:42:34 -0700
X-Mailer: MailMate (1.14r5852)
Message-ID: <7A00774E-13F2-4FB4-9979-D7827C92F5B8@gmail.com>
In-Reply-To: <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com>
References: <20220511171754.avfrrqg6eihku55s@bsd-mbp.dhcp.thefacebook.com>
 <CAJZ5v0jHDNBqCfmgyLUOs7yUZaEjQ96m5HVZKHP3x7_uamH5zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11 May 2022, at 10:33, Rafael J. Wysocki wrote:

> On Wed, May 11, 2022 at 7:24 PM Jonathan Lemon <jonathan.lemon@gmail.com> wrote:
>>
>> This reverts commit a62d07e0006a3a3ce77041ca07f3c488ec880790.
>>
>> The change calls pxm_to_node(), which ends up returning -1
>> (NUMA_NO_NODE) on some systems for the pci bus, as opposed
>> to the prior call to acpi_map_pxm_to_node(), which returns 0.
>>
>> The default numa node is then inherited by all pci devices, and is
>> visible in /sys/bus/pci/devices/*/numa_node
>>
>> The prior behavior shows:
>>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>>      122 0
>>
>> While the new behavior has:
>>  # cat /sys/bus/pci/devices/*/numa_node | sort | uniq -c
>>        1 0
>>      121 -1
>>
>> While arguably NUMA_NO_NODE is correct on single-socket systems which
>> have only one numa domain, this breaks scripts that attempt to read the
>> NIC numa_node and pass that to numactl in order to pin memory allocation
>> when running applications (like iperf).  E.g.:
>>
>>   # numactl -p -1 iperf3
>>   libnuma: Warning: node argument -1 is out of range
>>   <-1> is invalid
>>
>> Reverting this change restores the prior behavior.
>
> Well, that's not a recent commit and it fixed a real and serious issue.
>
> Isn't there a way to fix this other than reverting it?

The userspace behavior changed - is there another way to fix things
so that a valid numa_node is returned?
-- 
Jonathan
