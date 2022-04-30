Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3E515FA4
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Apr 2022 19:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiD3Rog (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Apr 2022 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiD3Rof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Apr 2022 13:44:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1551658B
        for <linux-acpi@vger.kernel.org>; Sat, 30 Apr 2022 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=YSY6giYgf7k3KN3oETsAe/eIirArACrWpE1hyeLsgbk=; b=Sr43s/FSrvN89vadH/YlA7fptU
        xfKmwX0auz75kQkftpCiH1q6unQp/rW1UlQtHMe9FmbbnNkEhHOwGokdQpnKVunSKum0kocYfApIG
        vMa8vM2tL/ufnDjvny5mTp34SP8yIwiKA/3RDtBhNDxC60JEvfqht3qtX+Sfa8h0VPNO0WLmiFMQW
        QwWziKCEDkBvVXSuskaaSdyYcKmLowO7Yx+1HYs3BYWqgTlVAkQJCS5CvrOJ9gq4MU6ODxAMgse+N
        BEYKQeY6h+bj13NfTGQPpr648D+9QVsZuLfuoN6i7QVYr8rqEVsAJHvyUtDn0pcXjpnynKmDWZPUb
        8pUehEUw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkr5i-00DUEG-PO; Sat, 30 Apr 2022 17:41:11 +0000
Message-ID: <0d399fdd-fbb5-47f8-dd5c-3a646829cb3e@infradead.org>
Date:   Sat, 30 Apr 2022 10:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: next: BUG: KASAN: slab-out-of-bounds in
 acpi_power_up_if_adr_present
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1e09b023-13d3-4474-f724-cb512d5244fb@infradead.org>
In-Reply-To: <1e09b023-13d3-4474-f724-cb512d5244fb@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/28/22 22:43, Randy Dunlap wrote:
> Hi,
> 
> I'm hitting $Subject bug on a Dell Inspiron laptop during boot.
> 
> faddr2line says that it's here:
> 
> 	adev = to_acpi_device(dev);
> 	if (!(adev->flags.power_manageable && adev->pnp.type.bus_address)) // <<<<< HERE
> 		return 0;
> 
> 
> [    1.710103] BUG: KASAN: slab-out-of-bounds in acpi_power_up_if_adr_present+0x17f/0x1d0
> [    1.710106] Read of size 1 at addr ffff888106016e0c by task swapper/0/1
> 
> [    1.710110] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc4-next-20220428 #1 // <<<<< VERSION
> [    1.710112] Hardware name: Dell Inc. Inspiron 15 5510/076F7Y, BIOS 2.6.1 12/15/2021
> 
> 
> Full boot log is attached.
> 

This problem goes away when I load the i915 firmware update during
early boot.

-- 
~Randy
